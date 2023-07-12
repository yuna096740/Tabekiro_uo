function scrollToEnd() {
  const messageDetails = document.querySelector('.scrollInner');
  if (messageDetails) {
    messageDetails.scrollTop = messageDetails.scrollHeight;
  }
}
window.commentsScrollToEnd = scrollToEnd;