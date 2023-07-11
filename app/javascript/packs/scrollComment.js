function scrollToEnd() {
  const messageDetails = document.getElementById('scrollInner');
  if (messageDetails) {
    messageDetails.scrollTop = messageDetails.scrollHeight;
  }
}
window.commentsScrollToEnd = scrollToEnd;