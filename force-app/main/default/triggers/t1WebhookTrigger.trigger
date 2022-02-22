trigger t1WebhookTrigger on X1__c (after insert) {

    String url = 'https://sm2test-developer-edition.ap5.force.com/faxconnect';

    String content = Webhook.jsonContent(Trigger.new, Trigger.old);

    Webhook.callout(url, content);

}