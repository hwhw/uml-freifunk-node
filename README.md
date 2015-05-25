# uml-freifunk-node
User mode linux based system with support for batman-adv (v14, v15), fastd etc.

In its current configuration, it needs VDE2 installed for networking.

To build, first initialize and update all the submodules and download kernel:
```
 ./prepare.sh
```

Then build:
```
 ./build.sh
```

Use the wrapper scripts (run-....sh) to start instances.

More documentation and examples are yet to come.
