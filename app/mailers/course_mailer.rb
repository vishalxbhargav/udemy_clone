class CourseMailer < ApplicationMailer
    default from: 'MS_PqOWyh@trial-vywj2lprk0m47oqz.mlsender.net' # this domain must be verified on your MailerSend dashboard
    def welcome_email
        mail(to: ["vishalxbhargav@gmail.com"], subject: 'Hello from MailerSend!')
    end
end
