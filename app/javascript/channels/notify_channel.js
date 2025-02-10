import consumer from "channels/consumer";

const notifyChannel = consumer.subscriptions.create("NotifyChannel", {
  connected() {
    console.log("Connected to NotifyChannel");
  },

  disconnected() {
    console.log("Disconnected from NotifyChannel");
  },
  received(data) {
    document.getElementById('notification').innerText=data
    console.log("Notification Received:", data);
  }
});
export default notifyChannel;