import consumer from "channels/consumer";

const notifyChannel = consumer.subscriptions.create("NotifyChannel", {
  connected() {
    console.log("Connected to NotifyChannel");
  },

  disconnected() {
    console.log("Disconnected from NotifyChannel");
  },

  received(data) {
    console.log("Received data:", data); 
  },
});

export default notifyChannel;
