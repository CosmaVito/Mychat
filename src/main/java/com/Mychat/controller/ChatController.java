package com.Mychat.controller;

import java.util.Date;

import org.slf4j.*;
import org.springframework.messaging.handler.annotation.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import com.Mychat.dto.*;

@Controller
@RequestMapping("/")
public class ChatController {

  private Logger logger = LoggerFactory.getLogger(getClass());

  @RequestMapping(method = RequestMethod.GET)
  public String viewApplication() {
    return "index";
  }
  
  /*
   * The @MessageMapping annotation ensures that if a message is sent to destination "/chat", 
   * then the sendMessage() method is called.
   * The payload of the message is bound to a Message object which is passed into sendMessage().
   */
  @MessageMapping("/chat")
  @SendTo("/topic/message")
  public OutputMessage sendMessage(Message message) {
    logger.info("Message sent");
    return new OutputMessage(message, new Date());
  }
}
