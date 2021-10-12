# NickelPlugin - Create plugins for NickelMenu

NickelPlugin is an **EXPERIMENTAL** plugin interface for NickelMenu. It currently only works with an unofficial, experimental version of NickelMenu. There is no guarantee this will be accepted in upstream NickelMenu.

This project allows you to launch GUI plugins directly from NickelMenu.

## Usage

NickelPlugin currently requires using [This experimental branch](https://github.com/shermp/NickelMenu/tree/shermp/plugins) of NickelMenu.

You can run the `gen-plugin.sh` script to generate a skeleton project in a directory of your choosing. Usage is as follows:
```
./generate.sh -n "Awesome Plugin name" -d "This is a cool description" -c AwesomePluginClassName -o /path/to/output/dir
```

To compile your plugin, you will need to use [NickelTC](https://github.com/pgaskin/NickelTC), which is a docker image. 

From your generated project directory, do the following:
```
docker run --volume="$PWD:$PWD" --user="$(id --user):$(id --group)" --workdir="$PWD" --rm -it ghcr.io/pgaskin/nickeltc:1.0
mkdir build
cd build
qmake ..
make
```
Assuming your plugin compiles successfully, it will be called `libclassname.so`.

The NickelMenu plugin loading is in a highly experimental state. You can currently load a plugin by saving the plugin somewhere on your Kobo, and creating the following NickelMenu config line:
```
menu_item : main : Load my plugin : nm_gui_plugin : /path/to/libclassname.so
```

It's highly likely that in the future, plugins will be loaded from a specific directory, and will not allow arbitrary paths.
