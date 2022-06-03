# godot-outline3d
viewport based 3d object outline example

The Viewport in the scene contains a camera with a specific cull mask set, meaning it will only render objects assigned to that layer. The resulting texture is fed into a screen covering quad mesh with a shader that samples it to produce a single pixel outline. 

To make an object appear with an outline assign it to the same cull mask layer. This is performed in the Outline3D script at the top-level which will randomly assign objects to the outline layer when spacebar is pressed. 

Information about the nodes and specific setup requirements has been added as node comments in the scene. Hovering over the nodes in the scene tree will display these comments in tooltip form.

