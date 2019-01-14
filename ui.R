# UI ####

shinyUI(
  navbarPage("Tools",
             theme = "/css/bootstrap.min.css",
             # Home画面(Home) ####
             tabPanel("Home",
                      h1("Rによる解析ツール"),
                      h2("1. はじめに"),
                      p("実験データの統計解析や可視化、プレートリーダーなどの実験機器の出力データを見やすく整形するツールです。"),
                      helpText("プログラムの作成には細心の注意を払っていますが、結果の正確性について保証するものではありません。"),
                      h2("2. ツール"),
                      p("使用可能なツールは下記のとおりです。詳しい説明は個別ページを見て下さい。"),
                      tags$div(
                        class = "well",
                        tags$dl(
                          tags$dt("1. Dunnett検定"),
                          tags$dd("多重比較のための検定。コントロールと他のサンプルを比較する。")
                        )
                      )
             ),
             # Dunnett検定(Dunnett) ####
             tabPanel("Dunnett検定",
                      sidebarLayout(
                        sidebarPanel(
                          csvFileInput("inputFile_Dunnett"),
                          uiOutput("select_control_col_Dunnett"),
                          uiOutput("select_control_name_Dunnett"),
                          uiOutput("select_value_Dunnett"),
                          actionButton("do_Dunnett", "実行")
                        ),
                        mainPanel(
                          tabsetPanel(type = "tabs",
                                      tabPanel("Input",
                                               DT::dataTableOutput("rawcsv_out_Dunnett")
                                      ),
                                      tabPanel("Summary",
                                               h2("表"),
                                               DT::dataTableOutput("summary_out_Dunnett"),
                                               h2("グラフ"),
                                               plotOutput("plot_summary_out_Dunnett")
                                      ),
                                      tabPanel("Result",
                                               DT::dataTableOutput("result_out_Dunnett"))
                          )
                        )
                      )
             ),
             # Platereader読み込み####
             tabPanel("PlateReader",
                      sidebarLayout(
                        sidebarPanel(
                          PlateFileInput("inputFile_Plate"),
                          actionButton("do_Plate", "実行")
                        ),
                        mainPanel(
                          tabsetPanel(type = "tabs",
                                       tabPanel("Table",
                                                DT::dataTableOutput("rawcsv_out_Plate")
                                       ),
                                       tabPanel("Summary",
                                                h2("生データ"),
                                                DT::dataTableOutput("spreadcsv_out_Plate"),
                                                h2("基本統計量"),
                                                DT::dataTableOutput("summary_out_Plate")
                                       )
                          )
                        )
                      )
                      
             )
  )
)