  # Delete ALL files from target source folder level only (no traversal or subfolders affected)
  # Filename: Deletes_ALL_Files_OlderThanXDay.ps1
  
  # Step 1. Test Path to Test First

  if ($args.count -eq 0 )
  { 
      clear
      Write-Host "USAGE SYNTAX:"-ForegroundColor green
      Write-Host "             .\Deletes_ALL_Files_OlderThanXDay.ps1 (PARAM1) -(PARAM2) (PARAM3)"
      Write-Host "" 
      Write-Host "        WHERE: (PARAM1)=is a valid FOLDER PATH of the files"
      Write-Host "               (PARAM2)=is a negative integer for back-dated day. " 
      Write-Host "                      For example: 0 (today) or -1 (yesterday) or -2 ( 2days ago) and so on.."  
      Write-Host "                      Non-numeric value and value > 0 are not allowed."  
      Write-Host "               (PARAM3)=is y|Y to confirm deletion to avoid accidental deletion." 
      Write-Host "                     Leaving this option blank is to just display or show the files to be delete."       
      Write-Host ""
      Write-Host ""  
      Write-Host "SAMPLE COMMAND:"-ForegroundColor cyan  
      Write-Host "              .\Deletes_ALL_Files_OlderThanXDay.ps1 ""c:\temp"" -1 Y" 
      Write-Host "" 
      Write-Host "** !WARNING!:                                                                             **"-ForegroundColor red -BackgroundColor yellow
      Write-Host "             (DELETES ALL FILE REGARDLESS of its Format or extention)                       "-ForegroundColor red 
      Write-Host "             This PS script Deletes all file(s) on the basis of when it was created.        "
      Write-Host "             No traversal or sub-folder deletion for this feature.                          " 
      Write-Host "**                                                                                        **"-ForegroundColor red -BackgroundColor yellow
      Break
  }
  else  { 
    clear

    $param1FolderPath = $args[0] 
    $Daysback = $args[1] 
    $AreYouSure= [string]$args[2] 

    if(![System.IO.Directory]::Exists($param1FolderPath))
    {     
      Write-Host "(PARAM1) Your folder path provided " $param1FolderPath " DOES NOT EXISTS!" 
      Break
    }
     

    if($Daysback.Length -eq 0)
    {
       Write-Host "(PARAM2) Your back-dated day ""$Daysback"" has an INVALID value!" 
       Break
    }
    if([int]$Daysback -gt 0)
    {
       Write-Host "(PARAM2) Your back-dated day ""$Daysback"" must be 0 or negative values only!" 
       Break
    }
     
     
    if([int]$Daysback -lt 0 -Or [int]$Daysback -eq 0 ) 
    {  
         
         if([int]$Daysback -eq 0)
         {
            Write-Host "Below are the list of file(s) to be removed by Today... "
         }
         else
         { 
            if([int]$Daysback -eq -1)
            {
              Write-Host "Below are the list of file(s) to be removed Yesterday's day "
            }
            else
            { 
             Write-Host "Below are the list of file(s) to be removed "$Daysback" days ago... "
            } 
         } 
         Write-Host ""  
    
         $CurrentDate = Get-Date
         $DateToDelete = $CurrentDate.AddDays($Daysback)
         Get-ChildItem $param1FolderPath  | Where-Object { $_.LastWriteTime -lt $DateToDelete}  


         if($AreYouSure -eq "Y" -Or $AreYouSure -eq "y" ) 
         {
          Write-Host "" 
          Get-ChildItem $param1FolderPath  | Where-Object { $_.LastWriteTime -lt $DateToDelete} | Remove-Item
          Write-Host ""
          Write-Host "Deletion of file(s) done!"
         }
      
     }
    #else{
    # Write-Host "(PARAM2) back-dated day has an invalid value!"
    #
    #}

  
  }
  