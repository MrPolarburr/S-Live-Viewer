using UnityEngine;
using System.Collections.Generic;

namespace XeApp.Game.Common
{
	public class StageColorChanger : MonoBehaviour
	{
		public List<Material> fakelitMaterials;
		public Material lightMaterialA;
		public Material lightMaterialB;
		public Material lightMaterialC;
		public Material psylliumMaterial;

		private void Start() {
			Vector4 color = new Vector4();
			switch(LoadScene.Instance.divaID){
				case 1:
					color = new Vector4(0.941f, 0.078f, 0.078f, 1);
					break;
				case 2:
					color = new Vector4(0.607f, 0.078f, 0.941f, 1);
					break;
				case 3:
					color = new Vector4(0.984f, 0.584f, 0.074f, 1);
					break;
				case 4:
					color = new Vector4(0.984f, 0.074f, 0.803f, 1);
					break;
				case 5:
					color = new Vector4(0.478f, 0.984f, 0.074f, 1);
					break;
				case 6:
					color = new Vector4(0.141f, 0.639f, 0.239f, 1);
					break;
				case 7:
					color = new Vector4(0.917f, 0.949f, 0.533f, 1);
					break;
				case 8:
					color = new Vector4(0.949f, 0.533f, 0.847f, 1);
					break;
				case 9:
					color = new Vector4(0.870f, 0.215f, 0.090f, 1);
					break;
				case 10:
					color = new Vector4(0.090f, 0.137f, 0.870f, 1);
					break;
				default:
					color = new Vector4(1f, 1f, 1f, 1);
					break;
			}
			foreach(var thing in FindObjectsOfType<Renderer>()){
				if(thing.material.shader.name == psylliumMaterial.shader.name){
					thing.material.SetVector("_Color1", color);
				}
			}
		}
	}
}
