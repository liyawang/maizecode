Optimizing modular Agave apps for SciApps
-------
* Follow the [CyVerse Agave app development guide](https://github.com/cyverse/cyverse-sdk)
* Register the app on sciapps.org system
  * Use the 'debug' queue of the system for testing and building workflow
  * Use 'exampleData' for testing and building workflow
  * Contact support@SciApps.org if you don't have access or you need to add example data to 'public'
  * The system and public data is set up to avoid unnecessary data transfer among TACC, CSHL and UA
* Define an output explicitly if you want to use it in building automated SciApps workflows
  * For an example, check the examplar [variant calling workflow](../wrappers/platypus_workflow/README.md)
    * The basic idea is to build one-to-one relationship between output_file and default_ouput ('default' value of an output in app JSON)
      * Such relationship can be built in the wrapper script by creating a default_output folder and placing the output_file in there
        * The wrapper script of 'next app' will extract the name of output_file if the input is a folder with a single item inside it
        * Such modifications are necessary for retaining sample_name in output_file name
          * Supporting merging of replicates at run time (not collapse on filename)
      * Alternatively, the relationship can be built by renaming output_file as default_output
        * The wrapper script of 'next app' will just use the input directly
        * Works if sample name is not necessary to be retained
      * In both cases, make sure to define default_output in app JSON
  * Defined default_outputs (in app JSON) are the only ones that will be displayed on SciApps right panel for building workflow
* Use [installed Singularity images](Singularity-SciApps.md) if you can, and put wrapper scripts in your CyVerse Data Store
  * Remove existing code that handles installation of any packages
  * This will ensure that the same workflow can be easily pointed to XSEDE/Stampede2 or other cloud for execution
  * When running on a different cloud, we will add the image to the bin folder, gzip it, and pass it with the wrapper script
  * Contact support@SciApps.org if you need new images installed
* Modify wrapper script to optimize data transfer
  * Try to compress all inputs, intermediate outputs, and results if possible
  * Try to delete inputs, temporary files, wrapper scripts, libraries, etc at the end of the wrapper script (especially when job crashes)
  * For running through SciApps @CSHL and leveraging CSHL storage, this is mainly for saving disk space 
  * For running on other clouds or when leveraging CyVerse Data Store, this greatly reduces the data transfer bottleneck
