---
description: Most Common Dummy Images for Docker
---

# k8s-developments

To follow the all instructions use my [gitbook](https://santillanrodriguezcristian.gitbook.io/k8s-development/)

#### **Common Dummy Images**

While you're learning Kubernetes, tutorials conventionally use a few 'dummy' or 'vanilla' docker images. In practice, your images will be real, production Docker images custom to your application. In these as a placeholder for your real application.

Here are a few of the most common 'dummy' images you'll see throughout this help guide and tutorials online.

* **alpine** – a Linux operating system that is very lightweight but still has access to a package repository so that you can install more packages. Often used as a lightweight base for other utilities and applications. 
* **nginx** – a powerful, highly performant web server used in many production deployments. It's widely used as a reverse proxy, load balancer, cache, and web server. It's often used when tutorials need a standard web server.
* **busybox** – a very space-efficient image that contains common Unix utilities. It's often used in embedded systems or environments that need to be very lightweight but still useful.
* **node** – an image of the Node.js JavaScript runtime, commonly used for web applications. You'll also see variants of node based on different base operating systems via different tags.

 For example, node:8.11.3-alpine and node:8.11.3-jessie are two variants of node:8.11.3 that use the alpine and jessie Linux distros respectively • Similarly, there are Docker images for php, ruby, python, and so on. These have variants that you can use via different tags, similar to the node image.



