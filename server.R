# Server ####
shinyServer(function(input, output, session) {
  # Dunnett検定(Dunnett) ####
  csvFile_Dunnett <- callModule(csvFile, "inputFile_Dunnett")

  # サンプル、コントロール、値、選択 ####
  output$select_control_col_Dunnett <- renderUI({
    selectInput("control_col_Dunnett", "サンプルの行を選択", choices =  colnames(csvFile_Dunnett())
    )
  })
  output$select_control_name_Dunnett <- renderUI({
    selectInput("control_Name_Dunnett", "コントロール名を選択", choices =  distinct_(csvFile_Dunnett(), input$control_col_Dunnett))
  })
  output$select_value_Dunnett <- renderUI({
    selectInput("control_value_Dunnett", "値の行を選択", choices =  colnames(csvFile_Dunnett())
    )
  })

  # データ処理(実行ボタン押されたときの処理)####
  # 選択された行から新しくデータフレーム作成
  df_Dunnett <- eventReactive(input$do_Dunnett,{
    x_Dunnett <- pull(csvFile_Dunnett(), !!input$control_col_Dunnett)
    y_Dunnett <- pull(csvFile_Dunnett(), !!input$control_value_Dunnett)
    z_Dunnett <- tibble(x_Dunnett, y_Dunnett)%>% 
      mutate(x_Dunnett = fct_relevel(x_Dunnett, input$control_Name_Dunnett))
    return(z_Dunnett)
  })
  
  # 要約 
  summary_Dunnett <- reactive({
    df_Dunnett() %>% 
      group_by(x_Dunnett) %>% 
      summarise(mean = mean(y_Dunnett), SD = sd(y_Dunnett), SE = SD/sqrt(n())) %>% 
      set_colnames(c(input$control_col_Dunnett, "mean", "SD", "SE"))
  })
  
  # Dunnett検定 
  result_out_reactive_Dunnett <- reactive({
    fx_Dunnett <- df_Dunnett()$x_Dunnett
    vx_Dunnett <- df_Dunnett()$y_Dunnett

    result_Dunnett <-summary(glht(aov(vx_Dunnett~fx_Dunnett),linfct=mcp(fx_Dunnett="Dunnett")))
    tidy_result_Dunnett <- tidy(result_Dunnett)
    return(tidy_result_Dunnett)
  })
  
  # Output####
  output$rawcsv_out_Dunnett <- DT::renderDataTable(csvFile_Dunnett(),
                                                   extensions = c('Buttons'),
                                                   options = DT_options)
  output$summary_out_Dunnett <- DT::renderDataTable(summary_Dunnett(),
                                                   extensions = c('Buttons'),
                                                   options = DT_options)
  output$plot_summary_out_Dunnett <- renderPlot(ggplot(df_Dunnett(), aes(x_Dunnett, y_Dunnett, fill = x_Dunnett)) +
                                                  geom_col() +
                                                  scale_fill_viridis_d() +
                                                  xlab(input$control_col_Dunnett) +
                                                  ylab(input$control_value_Dunnett))
  output$result_out_Dunnett <- DT::renderDataTable(result_out_reactive_Dunnett(),
                                                   extensions = c('Buttons'),
                                                   options = DT_options)
  
  
  # PlateReader ####
  # Plater 実行
  csvFile_Plate <- callModule(PlateFile, "inputFile_Plate")
  
  # データ処理(実行ボタン押されたときの処理)####
  df_Plate <- eventReactive(input$do_Plate,{
    csvFile_Plate() %>% 
      select(Name, Value)
  })
  
  df_spread_Plate <- reactive({
    df_Plate() %>% 
      group_by(Name) %>% 
      mutate(n = row_number()) %>% 
      spread(n, Value)
  })
  
  df_summary_Plate <- reactive({
    df_Plate() %>% 
      group_by(Name) %>% 
      summarise(mean = mean(Value), SD = sd(Value), n = n())
  })
# Output####
  output$rawcsv_out_Plate <- DT::renderDataTable(csvFile_Plate(),
                                                   extensions = c('Buttons'),
                                                   options = DT_options)
  output$spreadcsv_out_Plate <- DT::renderDataTable(df_spread_Plate(),
                                                 extensions = c('Buttons'),
                                                 options = DT_options)
  output$summary_out_Plate <- DT::renderDataTable(df_summary_Plate(),
                                                    extensions = c('Buttons'),
                                                    options = DT_options)
  
  
})