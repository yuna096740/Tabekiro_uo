function scrollToEnd() {
  let execute = true
  const messageDetails = document.querySelector('.scrollInner');
  if (messageDetails) {
    messageDetails.scrollTop = messageDetails.scrollHeight;
  }
  let position = 0;
  if (messageDetails) {
    document.querySelector('.scrollInner').addEventListener("scroll", event=>{
      if ( position < messageDetails.scrollTop && execute ){
        //下方向のスクロール
        if ( messageDetails.scrollTop != messageDetails.scrollHeight){
          messageDetails.scrollTop = messageDetails.scrollHeight;
        }
      }
      else{
        //スクロールの停止
        if ( position == messageDetails.scrollTop ){
          execute = false;
        }
      }
      position = messageDetails.scrollTop;
    });
  }
}
window.commentsScrollToEnd = scrollToEnd;
