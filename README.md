---
description: Most Common Dummy Images for Docker
=======
description: Based on Golden Guide to k8s application development
---
# k8s-developments

## k8s-developments

## To follow the all instructions use my [gitbook](https://santillanrodriguezcristian.gitbook.io/k8s-development/)

### **Containers**

#### Docker and containers

Containerization is packaging an application, it's dependencies, and it's configuration into a single unit. This unit is called an image. The image is then used as a template to construct live, running instances of this image. These running instances are called containers. A container consists of the image, a read-write filesystem, network ports, resource limits, and other runtime configuration. Docker is the most popular way to build images and run containers, and is what we use in this book.

![](.gitbook/assets/screen-shot-2019-10-26-at-6.50.36-pm.png)

Consider a simple Node.js application that has not been containerized. If you were deploying this on a fresh virtual machine, you'd need to: • install the operating system • install the Node.js runtime • copy your application's source code into place • run your code using Node Of that list, you really only take responsibility for your source code. When you deploy a new version of your application, you just swap out the old source code for the newer version. The operating system and Node.js stays in place. When you package your application into a container, you take responsibility for everything you need to run your application—the OS, the runtime, the source code, and how to run it all. It all gets included into the image, and the image becomes your deployment unit. If you change your source code, you build a new image. When you redeploy your code, you instantiate a new container from the image. Conceptually, this is great. Encapsulate everything your application needs into a single object, and then just deploy that object. This makes deployment predictable and reproducible—exactly what you want for something that’s typically outside an application developer’s expertise. But alarm bells might be ringing: why aren't these images huge and expensive to run? The image includes the whole operating system and the Node.js runtime! Docker uses layers—read-only intermediate images—that are shared between final images. Each command used to generate the Docker image generates a new intermediate image via a delta—essentially capturing only what changed from the previous intermediate step. If you have several applications that call for the Ubuntu operating system in their Dockerfile, Docker will share the underlying operating system layer between them. There are two analogies that might help depending on your familiarity with other technologies. React—the JavaScript framework—re-renders all your UI whenever your application's state changes. Like including an operating system in your application deployment, this seems like it should be really expensive. But React gets smart at the other end—it determines the difference in DOM output and then only changes what is necessary. The other analogy is the git version control system, which captures the difference between one commit and the previous commit so that you can effectively get a snapshot of your entire project at any point in time. Docker, React, and git take what should be an expensive operation and make it practical by capturing the difference between states. Let's create a Docker image to see how this works in practice. Start a new directory, and save the following in a file called **Dockerfile.**

```text
# Get the Node.js base Docker image - shared!
FROM node:carbon
# Set the directory to run our Docker commands in
WORKDIR /app
# Copy your application source to this directory
COPY . .
# Start your application
CMD [ "node", "index.js" ]
```

Then, let's write a simple Node.js web server. Create the following in a file called **index.js**.

=======

```text
# index.js
var http = require('http');
var server = http.createServer(function(request, response) {
 response.statusCode = 200;
 response.setHeader('Content-Type', 'text/plain');
 response.end('Welcome to the Golden Guide to Kubernetes
Application Development!');
});
server.listen(3000, function() {
 console.log('Server running on port 3000');
});
```

In the directory, open a new shell and build the Docker image.

```text
$ docker build . -t node-welcome-app
Sending build context to Docker daemon 4.096kB
Step 1/4 : FROM node:carbon
carbon: Pulling from library/node
1c7fe136a31e: Pull complete
ece825d3308b: Pull complete
06854774e2f3: Pull complete
f0db43b9b8da: Pull complete
aa50047aad93: Pull complete
42b3631d8d2e: Pull complete
93c1a8d9f4d4: Pull complete
5fe5b35e5c3f: Pull complete
Digest:
sha256:420104c1267ab7a035558b8a2bc13539741831ac4369954031e0142b565fb7b5
Status: Downloaded newer image for node:carbon
 ---> ba6ed54a3479
Step 2/4 : WORKDIR /app
Removing intermediate container eade7b6760bd
 ---> a8aabdb24119
Step 3/4 : COPY . .
 ---> 5568107f98fc
Step 4/4 : CMD [ "node", "index.js" ]
 ---> Running in 9cdac4a2a005
Removing intermediate container 9cdac4a2a005
 ---> a3af77202920
Successfully built a3af77202920
Successfully tagged node-welcome-app:latest
```

Now that we've built and tagged the Docker image, we can run a container instantiated from the image using our local Docker engine.

```text
$ docker run -d -p 3000 node-welcome-app
a7afe78a7213d78d98dba732d53388f67ed0c3d2317e5a1fd2e1f680120b3d15
$ docker ps
CONTAINER ID IMAGE COMMAND PORTS
a7afe78a7213 node-welcome-app "node index.js" 0.0.0.0:32772->3000
```

The output of **`docker ps`** tells us that a container with ID **a7afe78a7213** is running the **node-welcome-app** image we just built. We can access this container using port 32772 on localhost, which Docker will forward to the container's port 3000, where our application server is listening.

```text
$ curl 'http://localhost:32772'
Welcome to the Golden Guide to Kubernetes Application Development!
```

#### **Common Dummy Images**

While you're learning Kubernetes, tutorials conventionally use a few 'dummy' or 'vanilla' docker images. In practice, your images will be real, production Docker images custom to your application. In these as a placeholder for your real application.

Here are a few of the most common 'dummy' images you'll see throughout this help guide and tutorials online.

* **alpine** – a Linux operating system that is very lightweight but still has access to a package repository so that you can install more packages. Often used as a lightweight base for other utilities and applications. 
* **nginx** – a powerful, highly performant web server used in many production deployments. It's widely used as a reverse proxy, load balancer, cache, and web server. It's often used when tutorials need a standard web server.
* **busybox** – a very space-efficient image that contains common Unix utilities. It's often used in embedded systems or environments that need to be very lightweight but still useful.
* **node** – an image of the Node.js JavaScript runtime, commonly used for web applications. You'll also see variants of node based on different base operating systems via different tags.

 For example, node:8.11.3-alpine and node:8.11.3-jessie are two variants of node:8.11.3 that use the alpine and jessie Linux distros respectively • Similarly, there are Docker images for php, ruby, python, and so on. These have variants that you can use via different tags, similar to the node image.



