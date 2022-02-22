trigger t2WebhookTrigger on X1__c (after insert) {

    String url = 'https://sm2test-dev-ed--c.ap5.visual.force.com/apex/faxconnect';

    String content = Webhook.jsonContent(Trigger.new, Trigger.old);

    Webhook.callout(url, content);

}