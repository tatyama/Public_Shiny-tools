# 実行部分 ####
do_action_button <- function(id){
  actionButton(id, "実行")
}

# DT設定 ####
# DT::renderDataTableの設定
# 初期の行は50行
# ダウンロードボタン設置

DT_options <- list(
  dom = 'Blfrtip',
  pageLength = 50,
  buttons = c('csv', 'excel', 'copy')
  )