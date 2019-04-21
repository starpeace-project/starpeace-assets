
# Development

Local development can be accomplished in a few commands. The following build-time dependencies must be installed:

* [Node.js](https://nodejs.org/en/) javascript runtime and [npm](https://www.npmjs.com/get-npm) package manager
* [Grunt](https://gruntjs.com/) task manager

Retrieve copy of repository and navigate to root:

```
$ git clone https://github.com/starpeace-project/starpeace-assets.git
$ cd starpeace-assets
```

Install starpeace-assets dependencies:

```
$ npm install
```

Different grunt targets execute each script, explained further below:


```
$ grunt audit
```

```
$ grunt export --type=[b][i]
```

```
$ grunt import --type=[b][i]
```
