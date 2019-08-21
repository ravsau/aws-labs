## Lab 10: Setting Up WordPress on Amazon EC2 and using small EC2 features


- From the Amazon EC2 dashboard, choose Launch Instance.

- On the Choose an Amazon Machine Image (AMI) page, choose the AWS Marketplace category on the left.  Using the search functionality, search for 'WordPress Certified by Bitnami and Automattic' Choose Select to choose your product.

- On the dialog box that shows the pricing , click continue
- Select t2 micro as instance type 
- Select all the default setting
- Launch Instance
- You will be directed to a page titled Launch Status
- Click on View Usage Instructions
- You can  access your instance via SSH using the username 'bitnami' and your Amazon private key. 


>Once the instance is running, enter the public DNS provided by Amazon into your browser. You will then see the WordPress application. You can go to '/wp-admin/' from your browser to access the application administration panel. The default server administrator is 'user'. Please check our documentation at https://docs.bitnami.com/aws/faq/#how-to-find-application-credentials to learn how to get your password.

- Write a sample blog


---
- Enable Termination Protection
- Snapshot of your volume 


