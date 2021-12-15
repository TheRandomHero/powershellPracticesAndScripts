Get-Item master: -Query "fast://sitecore/content/Sites/Corporate/DBE/Home/Digital//*[@@templateid='{A96D86CE-D096-460B-B568-81ACB456C419}']" | foreach-object {
    $newVersion = Add-ItemVersion -Item $_ -Language 'en' -TargetLanguage 'en'
    
    $newVersion."Text block" = $_."Text block" -replace '<p style="text-align: left; margin-bottom: 1em;">', '' -replace '</p>', '' -replace '<span style="font-size: [0-9]*px; font-weight: 400;">(.*)<\/span><br>', '<h1 style="font-weight: 400; text-align: left;"><span class="visible-desktop" style="font-size: 75px;">$1</span><span class="hide-desktop" style="font-size: 10vw;">$1</span></h1>' -replace  '<span style=\"color: #c1c1c1; font-size: 22px;\">(.*)<\/span>', '<div class="visible-desktop"><p style="color: #c1c1c1; font-size: 22px; text-align: left;">$1</p></div>'
    $newVersion
}
<#
Name                             Children Language Version Id                                     TemplateName
----                             -------- -------- ------- --                                     ------------
Video                            False    en       4       {9F4BC172-5CA4-49C5-A259-09BE89205B49} Video
Video                            False    en       3       {3C898388-C1B9-4CB9-9220-0EDF45403FDD} Video
Video                            False    en       3       {F850CDE1-FE67-46AD-9BFE-1A61E1EE9353} Video
Video                            False    en       3       {14DF4ACF-831A-496A-9BD9-2957CF0B3BAD} Video
Video                            False    en       3       {C69F0D70-CA5A-4873-8540-2F9A3A21F5CC} Video
Video                            False    en       3       {2E8B07DE-0B22-451C-94CC-42ADE5337508} Video
Video                            False    en       3       {7E3CD144-15CB-4CF1-9D99-52B9A746FC24} Video
Video                            False    en       3       {92A904AF-288C-4A1D-85A5-59BD833BD32D} Video
Video                            False    en       3       {7310A8FB-2010-49CA-B148-6D03FFCAE3BE} Video
Video                            False    en       3       {58689ACD-3CA5-4F40-9352-6EB9757ACFCF} Video
Video                            False    en       3       {8D0654AA-46E0-45E7-9995-6ECC9F082332} Video
Video                            False    en       3       {013F898E-622C-45A1-BA29-740DC80C85F3} Video
Video                            False    en       3       {27E0B873-0FE0-4DD6-A2AE-850F240DDB7D} Video
Video                            False    en       3       {7D7F6B44-C6D5-4D97-BDDF-8510C30812FA} Video
Video                            False    en       3       {78FE645F-05AB-4F47-B0F1-8739213765A6} Video
Video                            False    en       3       {75CB3172-BA89-48FC-BA07-8AC64D805B08} Video
Video                            False    en       3       {504CE233-46C0-4744-9CBD-8ECAE7A99F76} Video
Video                            False    en       3       {9C79E58C-0C4C-4CB6-8F51-964FB7BD28FC} Video
Video                            False    en       3       {FD42688D-23F7-4BA2-9F06-9BC19F18F538} Video
Video                            False    en       3       {186BBD42-C293-4BCC-9C4A-9E13EAE92C77} Video
Video                            False    en       3       {639A90A2-F6DE-402F-BBF8-A1DDC7278330} Video
Video                            False    en       3       {2BA91E2D-B3D9-437D-8BDC-A3048D5FFD0D} Video
Video                            False    en       3       {673BCD39-7FFA-4DBB-A452-A39AE5E5B64C} Video
Video                            False    en       3       {F7201FFC-4117-4C82-A374-A5B5B3DDD13B} Video
Video                            False    en       3       {7D75396D-39EA-4123-8E30-AACBD21B8696} Video
Video                            False    en       3       {980980ED-E771-4045-8E28-AAEB1667344A} Video
Video                            False    en       3       {36AA3BEA-1F59-45F4-BAD0-B9B4510230C1} Video
Video                            False    en       3       {90AD7486-F583-4A45-9A13-BB1A0FCD667C} Video
Video                            False    en       3       {B81D9D78-DDC0-463D-9DAC-C4240E38684A} Video
Video                            False    en       3       {E4A253C7-E4E8-4C14-8E9B-D3CE98FFB85B} Video
Video                            True     en       3       {E7C51D74-76E8-4ED6-9CE3-D6664C6074E6} Video
Video                            False    en       3       {3027B86C-9F0B-483C-A71F-D9C84931578C} Video
Video                            False    en       3       {1A18147A-C72A-4EAD-9A0B-E3EB30807E69} Video
Video                            False    en       3       {9753C884-9260-434C-88E1-E4B2B301ABD2} Video
Video                            False    en       3       {A6A8DAAE-076D-424C-95CD-E798A4173D21} Video
Video                            False    en       3       {CAB95ACD-EE2C-49E1-B68A-ED38C27A815C} Video
Video                            False    en       3       {64B0B478-4D3A-4BE4-9450-F194181C6637} Video
Video                            False    en       3       {47A6F462-1C64-4003-A575-F54E849D227F} Video
#>
