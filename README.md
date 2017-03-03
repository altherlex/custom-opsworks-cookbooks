# Cookbooks

Provisioning Espn applications on AWS, using [Chef](https://www.chef.io/) to cook.

[Berkshelf](https://api.berkshelf.com) - cookbook dependency manager (now into ChefDK)

[Getting started with Chef](http://gettingstartedwithchef.com/first-steps-with-chef.html)

[Opsworks Cookbooks sources](https://github.com/aws/opsworks-cookbooks)

[Opsworks Cookbook Guide](https://docs.aws.amazon.com/opsworks/latest/userguide/workingcookbook.html)

### Path custom chef on OpsWorks

`cd /opt/aws/opsworks/current/site-cookbooks`

### current_path
`/srv/www/espn_api/current`


### Comands 

```bash
opsworks-agent-cli run_command execute_recipes ruby_application::shoryuken
```
