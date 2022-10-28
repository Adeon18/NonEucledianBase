#include "render.glsl"
#include "common.glsl"

#iChannel0 "file://data_channel.glsl"

/*
 * Create the player object(Piramid) and handle input transformation and rotation
*/
float createPlayer(vec3 point, vec3 originPos, vec3 offset) {

    /// Get Rotation radians and matrix
    float rotationRad = texelFetch(iChannel0, ivec2(P_ROTATION_COL, PLAYER_LAYER), 0).x;
    mat2 rotationMat = Rotate(rotationRad);

    /// Player body
    Piramid body = Piramid(vec3(0., 0., 0.) + originPos, 1.5);

    /// Handle body rotation and body movement
    vec3 bodyPos = point - body.pos;
    bodyPos -= offset;
    bodyPos.xy *= rotationMat;

    /// Flatten the piramid
    bodyPos *= vec3(1., 1., 2.);

    return sdPyramid(bodyPos, body.height / 2., body.height / 10., body.height / 1.5) / 2.;
}
