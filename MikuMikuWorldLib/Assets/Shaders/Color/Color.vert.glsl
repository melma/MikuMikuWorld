﻿#version 450

uniform mat4 MVP;

layout (std430, binding = 1) readonly buffer Trans {
  mat4 data[];
} gTrans;

layout (location = 0) in vec3 position;
layout (location = 9) in vec4 boneIndex;
layout (location = 10) in vec4 boneWeight;

void main()
{
    vec4 p = vec4(0);
	for (int i = 0; i < 4; i++)
	{
		mat4 m = gTrans.data[int(boneIndex[i])];
		p += (m * vec4(position, 1.0)) * boneWeight[i];
	}
	p /= p.w;
	gl_Position = MVP * p;
}