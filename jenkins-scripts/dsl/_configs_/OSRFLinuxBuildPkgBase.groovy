package _configs_

import javaposse.jobdsl.dsl.Job

/*
  Implements:
    - cleanup pkgs directory
    - keep only 200 build logs and 25 build artifacts
    - publish artifacts
*/
class OSRFLinuxBuildPkgBase
{
   static void create(Job job)
   {
     OSRFLinuxBase.create(job)

     job.with
     {
       logRotator {
         artifactNumToKeep(25)
         numToKeep(200)
       }

       wrappers {
         preBuildCleanup {
           includePattern('pkgs/*')
           // the sudo does not seems to be able to remove root owned packaged
           deleteCommand('sudo rm -rf %s')
         }
      }

      publishers
      {
        postBuildScripts {
          steps {
            shell("""\
              #!/bin/bash -xe

              [[ -d \${WORKSPACE}/pkgs ]] && sudo chown -R jenkins \${WORKSPACE}/pkgs
              """.stripIndent())
          }

          onlyIfBuildSucceeds(false)
          onlyIfBuildFails(false)
        }

        archiveArtifacts('pkgs/*')
      }
    }
  }
}
