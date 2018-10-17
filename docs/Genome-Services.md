Genome Services
==========================
To speed up staging input data from CyVerse Data Store to TACC clusters, we staged pre-built genome indexes for following genomes:
* Arabidopsis (TAIR10)
* Sorghum bicolor (Sorbi3)
* Zea mays (AGPv4)
* Homo sapiens (GRCh38)
* Mus musculus (GRCm38)


Using Genome Services for building Agave apps
-----------------------
1. Add a parameter (e.g. genomeIndex) to your app JSON and update the app:
```json
        {
            "id": "genomeIndex",
            "value": {
                "visible": true,
                "required": false,
                "type": "enumeration",
                "order": 0,
                "enquote": false,
                "default": "None",
                "enum_values": [
                    {
                        "None": ""
                    },
                    {
                        "Arabidopsis_TAIR10" : "Arabidopsis (TAIR10)"
                    },
                    {
                        "Sorghum_bicolor_Sorbi3" : "Sorghum bicolor (Sorbi3)"
                    },
                    {
                        "Zea_mays_AGPv4" : "Zea mays (AGPv4)"
                    },
                    {
                        "Human_GRCh38" : "Homo sapiens (GRCh38)"
                    },
                    {
                        "Mouse_GRCm38" : "Mus musculus (GRCm38)"
                    }
                ]
            },
            "details": {
                "label": "Select the prebuilt genome index",
                "description": "Prebuilt index files hosted by SciApps",
                "argument": null,
                "showArgument": false,
                "repeatArgument": false
            },
            "semantics": {
                "minCardinality": 1,
                "maxCardinality": 1,
                "ontology": [
                    "xs:string"
                ]
            }
        }
  ```
  
  2. Then handle the new parameter in your app wrapper script:
  ```sh
        ref=/work/01308/lwang/genomes/${genomeIndex}
        ref_fasta=${ref}/genome.fa
  ```
