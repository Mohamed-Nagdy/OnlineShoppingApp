const contactUsRouter = require("express").Router();
const nodemailer = require("nodemailer");

contactUsRouter.post("/api/v1/contactUs", async (req, res) => {

  try {
    const send = require('gmail-send')({
        user: 'bloodbank10895@gmail.com',
        pass: 'bloodBank@10895',
        to:   'mohamednagdy257@gmail.com',
        subject: 'Blood Bank Contact',
        text: req.body.userName + '\n' + req.body.userEmail + '\n' + req.body.message,
      });
    send()
    res.json({success: "OK"})
  } catch (e) {
    console.log(e);
    res.json({error: e.toString()})
  }
});

module.exports = contactUsRouter;
