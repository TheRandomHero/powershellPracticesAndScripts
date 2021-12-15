$language = $SitecoreContextItem.Language
#$item = Get-Item -path "./" -language $language

Function Get-SmartCroppedImage {
    param(
        [Item]$imageMediaItem,
        [int]$imageWidth,
        [int]$imageHeight,
        [string]$uploadPath = "/sitecore/media library/New Corporate Folder/Sandbox")
    $filePath = $imageMediaItem.ItemPath
    if ((-not $imageMediaItem) -or (-not $imageWidth ) -or (-not $imageHeight)) {
        return
    }

    $liveurl = "https://dlwpro-cv.cognitiveservices.azure.com/vision/v2.0/generateThumbnail?width=$imageWidth&height=$imageHeight&smartCropping=true"

    Try {
        Add-Type -AssemblyName 'System.Net.Http'
        
        $fileStream = [system.io.stream]$body = $imageMediaItem.Fields["blob"].GetBlobStream()

        $client = New-Object System.Net.Http.HttpClient
        $content = New-Object System.Net.Http.MultipartFormDataContent

        $fileName = [System.IO.Path]::GetFileName($filePath)
		$resultFileName = $filename.Substring(0, [System.Math]::Min(50, $filename.Length)) + " crop " + $imageWidth + "x" + $imageHeight + "." + $resultType
		$resultFileNameWE =  $filename.Substring(0, [System.Math]::Min(50, $filename.Length)) + " crop " + $imageWidth + "x" + $imageHeight
		$destination = "$uploadPath/$resultFileNameWE"
        Write-Host $resultFileNameWE
		
		if (-not (Test-Path $destination)) {
			$fileContent = New-Object System.Net.Http.StreamContent($fileStream)
			$client.DefaultRequestHeaders.Add("Ocp-Apim-Subscription-Key", "2e4c470d4a1d406ca9668796f714b510")
			$content.Add($fileContent, "image", $fileName)
			#$content.Add($contentData)

			$result = $client.PostAsync($liveurl, $content).GetAwaiter().GetResult()
			Write-Host $result.EnsureSuccessStatusCode()
		
			$stream = $result.Content.ReadAsStreamAsync().Result;
			
			$resultType = ($result.Content.Headers.ContentType.MediaType).SubString(($result.Content.Headers.ContentType.MediaType).LastIndexOf('/')+1)
			#$resultType
			


			$mco = New-Object Sitecore.Resources.Media.MediaCreatorOptions
			$mco.Database = [Sitecore.Configuration.Factory]::GetDatabase("master");
			$mco.Language = [Sitecore.Globalization.Language]::Parse("en");
			$mco.Versioned = [Sitecore.Configuration.Settings+Media]::UploadAsVersionableByDefault;
			$mco.Destination = $destination;
			#$mco
			
			$mc = New-Object Sitecore.Resources.Media.MediaCreator
			$cropMediaItem = $mc.CreateFromStream($stream, $resultFileName, $mco);

			
			#[Sitecore.Data.Items.MediaItem]$item = gi "/sitecore/media library/Images/test/test"
			#[Sitecore.Resources.Media.Media] $media = [Sitecore.Resources.Media.MediaManager]::GetMedia($item);

			$stream.Close();
		}

    }
    Catch {
        Write-Error $_
        exit 1
    }
    Finally {
        if ($client -ne $null) { $client.Dispose() }
        if ($content -ne $null) { $content.Dispose() }
        if ($fileStream -ne $null) { $fileStream.Dispose() }
        if ($fileContent -ne $null) { $fileContent.Dispose() }
    }
    return $cropMediaItem
}

#Publish-Item -Item $cropMediaItem -PublishMode Smart