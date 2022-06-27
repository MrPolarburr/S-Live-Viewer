using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Threading.Tasks;
using UnityEngine;

namespace UtaCore
{
    public class AssetBundleManager{
        public static void LoadBundleToMemory(string path){
            var aBundle = AssetBundle.LoadFromFile(Path.Combine(Application.streamingAssetsPath, path));
            if (aBundle == null)
            {
                Debug.Log("Failed to load AssetBundle!");
                return;
            }
        }

        public static async Task<List<GameObject>> LoadPrefabsFromBundle(string path){
            var aBundle = AssetBundle.LoadFromFile(Path.Combine(Application.streamingAssetsPath, path));
            if (aBundle == null)
            {
                Debug.Log("Failed to load AssetBundle!");
                return new List<GameObject>();
            }

            var gos = aBundle.LoadAllAssets<GameObject>();
            List<GameObject> prefabs = new List<GameObject>();

            aBundle.Unload(false);

            foreach (var go in gos)
            {
              if(go.name.ToLower().Contains("prefab")){
                prefabs.Add(go);
              }
            }          
            return prefabs;
        }

        public static async Task<List<AnimationClip>> LoadClipsFromBundle(string path){
            var aBundle = AssetBundle.LoadFromFile(Path.Combine(Application.streamingAssetsPath, path));
            if (aBundle == null)
            {
                Debug.Log("Failed to load AssetBundle!");
                return new List<AnimationClip>();
            }

            var gos = aBundle.LoadAllAssets<AnimationClip>();
            List<AnimationClip> animations = new List<AnimationClip>();

            aBundle.Unload(false);

            foreach (var go in gos)
            {
                animations.Add(go);
            }          
            return animations;
        }
    }
}

