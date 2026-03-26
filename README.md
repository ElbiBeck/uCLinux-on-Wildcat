# uCLinux-on-Wildcat
Project work for bachelor in computer engineering. Port of NOMMU Linux to Wildcat (https://github.com/schoeberl/wildcat)

## Note to nikolaj
The **entrypoint.sh** specifies _export BR2_JLEVEL=4_ which sets the parallel processing core to 4. This could be higher but has been reduced since the C++ compiler sometimes runs out of memory when compiling, and this becomes lower when less cores are used. The memory docker is allowed can also be increased in the settings.
