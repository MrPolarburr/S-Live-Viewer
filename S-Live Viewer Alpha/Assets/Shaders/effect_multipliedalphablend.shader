Shader "MCRS/Effect/MultipliedAlphaBlend" {
	Properties {
		_MainTex ("MainTex", 2D) = "white" {}
		_MainMaskTex ("MainMaskTex", 2D) = "white" {}
		_TintColor ("Base Color", Vector) = (1,1,1,1)
		[MaterialToggle] _TexColorOnOff ("TexColor On/Off", Float) = 0
		_GlowColor ("Glow Color", Vector) = (1,1,1,0)
		[MaterialToggle] _GlowColorOnOff ("GlowColor On/Off", Float) = 0
		_Emission ("Emission", Range(0.5, 5)) = 1
		[HideInInspector] _Cutoff ("Alpha cutoff", Range(0, 1)) = 0.5
	}
SubShader
	{
		Tags { "Queue"="Transparent" "RenderType"="Transparent" "LightMode" = "Vertex"}
		Blend One OneMinusSrcAlpha
		ZWrite Off
		Pass
		{
			CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

			struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
				float4 color : COLOR;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
				float4 color : COLOR;
            };

			sampler2D _MainTex;
			float _Power;
			float4 _Color;
			float4 _MainTex_ST;

			v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.color = v.color
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv) * i.color *_Power;

                col.rgba *= _Color.rgba;

                UNITY_APPLY_FOG(i.fogCoord, col);
                return col;
            }
			ENDCG
		}
	}
}