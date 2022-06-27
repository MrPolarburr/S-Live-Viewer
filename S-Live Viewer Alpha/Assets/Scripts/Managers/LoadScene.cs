using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Threading.Tasks;
using UnityEngine;
using UtaCore;
public class LoadScene : MonoBehaviour
{
    public static LoadScene Instance;

    [Header("Diva to load")]
    public int divaID = 0;
    [Header("Costume to load")]
    public int costumeID = 0;
    [Header("Check if Costume has multiple colors")]
    public bool colorVariants = false;
    [Header("If using color variants, specify the color (usually only 0 or 1)")]
    public int colorID = 0;
    [Header("Animation to load")]
    public int animationID = 0;
    [Header("Stage to Load")]
    public int stageID = 0;
    [Header("Effects to load")]
    public int[] dvEffectIDs, stEffectIDs;
    [Header("---------------------DO NOT TOUCH PAST THIS---------------------")]
    public GameObject cam;
    public GameObject facialHelper;
    public RuntimeAnimatorController[] animController;
    public float[] offsets;
    private AudioSource mainAudio;
    private List<Animator> animControllers = new List<Animator>();
    private List<GameObject> loadedObjects = new List<GameObject>();
    private GameObject diva, mike, stage;

    private void Awake() {
        Instance = this;
        mainAudio = GetComponent<AudioSource>();
        AssetBundleManager.LoadBundleToMemory("handmade/shader.decrypted");
    }

    private void Start() {
        SetUp();
    }

    //add some sort of await later
    private async void SetUp(){
       await loadDiva();
       await loadStage();
        foreach(var effect in dvEffectIDs){
           await loadDVEffects(effect);
        }
        foreach(var effect in stEffectIDs){
          await loadSTEffects(effect);
        }
        await loadAnimations();
        foreach(var obj in loadedObjects){
            await cleanShaders(obj);
            await grabAnimators(obj);
        }
        playScene();
    }

    private async Task loadDiva(){
        List<GameObject> prefabs = new List<GameObject>();

        float offset = offsets[divaID-1];

        if(colorVariants){
            Debug.Log("Loading color variant: " + colorID);
            AssetBundleManager.LoadBundleToMemory($"cs/{divaID.ToString("000")}_{costumeID.ToString("000")}_{colorID.ToString("00")}.decrypted");
            prefabs = await AssetBundleManager.LoadPrefabsFromBundle($"cs/{divaID.ToString("000")}_{costumeID.ToString("000")}.decrypted");
        }else{
            prefabs = await AssetBundleManager.LoadPrefabsFromBundle($"cs/{divaID.ToString("000")}_{costumeID.ToString("000")}.decrypted");
        }

        foreach(var go in prefabs){
            if(go.name.Contains("mike")){
                mike = Instantiate(go);
                mike.SetActive(false);
                loadedObjects.Add(mike);
            }else{
                diva = Instantiate(go, new Vector3(0, offset, 0), Quaternion.identity);
                diva.AddComponent<AnimationEvents>().mic = mike;
                diva.GetComponentInChildren<Animator>().runtimeAnimatorController = animController[divaID-1];
                if(divaID == 2)
                    diva.transform.Find("mesh_root")?.Find("menu_hair")?.transform.gameObject.SetActive(false);
                loadedObjects.Add(diva);
            }
        }
    }

    private async Task loadStage(){
        List<GameObject> prefabs = new List<GameObject>();

        prefabs = await AssetBundleManager.LoadPrefabsFromBundle($"st/{stageID.ToString("0000")}.decrypted");

        foreach(var go in prefabs){
            stage = Instantiate(go);
            loadedObjects.Add(stage);
        }
    }

    private async Task loadDVEffects(int effectID){
        List<GameObject> prefabs = new List<GameObject>();

        prefabs = await AssetBundleManager.LoadPrefabsFromBundle($"mc/{animationID.ToString("0000")}/dr/dv/{effectID.ToString("000")}.decrypted");

        foreach(var go in prefabs){
            loadedObjects.Add(Instantiate(go));       
        }
    }

    private async Task loadSTEffects(int effectID){
        List<GameObject> prefabs = new List<GameObject>();

        prefabs = await AssetBundleManager.LoadPrefabsFromBundle($"mc/{animationID.ToString("0000")}/dr/st/{effectID.ToString("000")}.decrypted");

        foreach(var go in prefabs){
            loadedObjects.Add(Instantiate(go));
        }
    }

    private async Task loadAnimations(){
        List<AnimationClip> clips = new List<AnimationClip>();

        float offset = offsets[divaID-1];

        if(divaID == 9){
            clips = await AssetBundleManager.LoadClipsFromBundle($"mc/{animationID.ToString("0000")}/bt002.decrypted");
        }else{
            clips = await AssetBundleManager.LoadClipsFromBundle($"mc/{animationID.ToString("0000")}/bt001.decrypted");
        }
        
        facialHelper = Instantiate(facialHelper, Vector3.zero, Quaternion.identity);
        loadedObjects.Add(facialHelper);
        cam = Instantiate(cam, new Vector3(0,offset,0), Quaternion.identity);
        loadedObjects.Add(cam);

        foreach(var anim in clips){
            if(anim.name.ToLower().Contains("body")){
                var animController = diva.GetComponent<Animator>().runtimeAnimatorController;
                var aoc = new AnimatorOverrideController(animController);
                aoc["Dance"] = anim;
                diva.GetComponent<Animator>().runtimeAnimatorController = aoc;
            }
            if(anim.name.ToLower().Contains("cam")){
                var animController = cam.GetComponentInChildren<Animator>().runtimeAnimatorController;
                var aoc = new AnimatorOverrideController(animController);
                aoc["Camera"] = anim;
                cam.GetComponentInChildren<Animator>().runtimeAnimatorController = aoc;
            }
            if(anim.name.ToLower().Contains("face")){
                var animController = facialHelper.transform.GetChild(0).gameObject.GetComponent<Animator>().runtimeAnimatorController;
                var aoc = new AnimatorOverrideController(animController);
                aoc["Face"] = anim;
                facialHelper.transform.GetChild(0).gameObject.GetComponent<Animator>().runtimeAnimatorController = aoc;
            }
            if(anim.name.ToLower().Contains("mouth")){
                var animController = facialHelper.transform.GetChild(1).gameObject.GetComponent<Animator>().runtimeAnimatorController;
                var aoc = new AnimatorOverrideController(animController);
                aoc["Mouth"] = anim;
                facialHelper.transform.GetChild(1).gameObject.GetComponent<Animator>().runtimeAnimatorController = aoc;
            }

            facialHelper.GetComponent<FacialAnimsConverter>().mainAnimator = diva.GetComponent<Animator>();
        }
    }

    private async Task cleanShaders(GameObject obj){
        if (null == obj)
            return;

        foreach (Transform child in obj.transform){
            if (null == child)
                continue;
            //child.gameobject contains the current child you can do whatever you want like add it to an array
            foreach(var ren in obj.GetComponentsInChildren<Renderer>()){
                    foreach(var mat in ren.materials){
                        mat.shader = Shader.Find(mat.shader.name);
                }
            }
            cleanShaders(child.gameObject);
        }
    }

    private async Task grabAnimators(GameObject obj){
        if (null == obj)
            return;

        foreach (Transform child in obj.transform){
            if (null == child)
                continue;
            //child.gameobject contains the current child you can do whatever you want like add it to an array
            if(obj.GetComponent<Animator>() != null){
                animControllers.Add(obj.GetComponent<Animator>());
            }
            grabAnimators(child.gameObject);
        }
    }

    private void playScene(){
        mainAudio.Play();
        foreach(var anim in animControllers){
            if(anim.runtimeAnimatorController != null){
                 anim.Play(0, -1);
            }    
        }
    }
}
