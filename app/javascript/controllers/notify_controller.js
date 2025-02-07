import { Controller } from "@hotwired/stimulus";
import notifyChannel from "channels/notify_channel";

export default class extends Controller {
  connect() {
    console.log("Stimulus controller connected!");

    notifyChannel.received = (data) => {
      console.log(" Stimulus received data:", data); // Check if this logs
    };
  }
}
