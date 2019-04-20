## EC2 with instance store

To choose an instance store-backed AMI using the console

- Open the Amazon EC2 console.

- Click Launch Instance
- Choose **Community AMIs** from the left Navigation box. 
- From the filter lists under the Root device type option , select Instance store.
![image](https://user-images.githubusercontent.com/22568316/51089787-1c806380-1741-11e9-85ee-786b0d0e8c3e.png)

- Select the Top AMI( or any Amazon Linux AMI)

- You cannot select any kind of instance type as not all instance types ( eg t2.micro) support Instance store as root device type. Let's select m1.small as our instance type. 
- After this, launch the instance as usual.




