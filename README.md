# S-Live Viewer
 A WIP S-Live viewer for Uta Macross
 
 REQUIRES UNITY 2020.3.30f1

I will not be providing files you must provide those yourself

To load files:

MAKE SURE ALL FILES INPUTED END IN .decrypted (will most likely change later idk yet)
You also need to remove the original file and the md5 file that was generated from xele script.

1. Open up powershell in the folder you want to pull files from and run:

``Get-ChildItem -recurse -include *.decrypted* | foreach-object { $name = $_.fullname; $newname = $name -replace '!.*\.','.'; rename-item $name $newname }``

This should wipe the file names and leave them to something like: 001.decrypted

2.Under Assets/StreamingAssets

![image](https://user-images.githubusercontent.com/41769662/175868687-73f04ec6-b382-4f9f-8275-c02ca6ee2b98.png)

Place Costumes under cs

place Shader.decrypted in handmade

place animation folders like this:

![image](https://user-images.githubusercontent.com/41769662/175869088-7f87bc2e-c4a0-49ca-8a89-0235353750be.png)

Under mc

and place stages in st.




To play an animation:

Under the scenes folder in assets open up TestScene.

Click on the SceneSetup Gameobject

![image](https://user-images.githubusercontent.com/41769662/175869304-fbfadc77-e797-4c43-9ad8-9b07e62a8b9f.png)

You should now see information on the right

![image](https://user-images.githubusercontent.com/41769662/175869349-69ccb37b-5300-4b71-ad64-e3624fc08082.png)

DivaID is the diva 
1 - Freyja
2 - Mikumo
3 - Kaname
4 - Makina
5 - Reina
6 - Ranka
7 - Sheryl
8 - Mylene
9 - Basara
10 - Lynn

CostumeID is the id the costume has you can find it at the trailing end of a cs file

![image](https://user-images.githubusercontent.com/41769662/175869574-740e4b86-352a-4015-bb41-527bd59e6332.png)

In the image above that is basically Mikumo Costume 1

No need to add the leading 0s

Some Outfits have multiple color variants if you choose one of those make sure to check the colorvariant and select the right ID usually its either 0 or 1

AnimationID is the folder number so if the folder is 0020 you would put 20

StageID is the stage number as above if its 0013 you would put 13

DvEffects are the effects under the dr/dv directory of the animation folder. These change depending on either costume/diva feel free to experiment. You can load multiple at once by adding more to the list

StEffects are the same as above. they can be found under the dr/st direction of the animation folder. 

DVEffects and STEffects tend to not have any corrispondance so you have to sorta guess work on which is for what situation.

then thats it! hit play and everything should load.

