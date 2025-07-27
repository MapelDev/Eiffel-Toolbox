class
    QUATERNION

create
    make_identity, make_from_axis_angle, make_from_components

feature -- Access

    x: REAL
    y: REAL
    z: REAL
    w: REAL

    magnitude: REAL
            -- Length of the quaternion
        do
            Result := (x*x + y*y + z*z + w*w).sqrt
        ensure
            non_negative: Result >= 0.0
        end

    normalized: QUATERNION
            -- Return a normalized (unit) quaternion.
        do
            create Result.make_from_components (x, y, z, w)
            Result.normalize
        ensure
            result_attached: Result /= Void
            result_unit: (Result.magnitude - 1.0).abs <= 1e-5
        end

feature -- Creation

    make_identity
            -- Create identity quaternion (no rotation).
        do
            x := 0.0
            y := 0.0
            z := 0.0
            w := 1.0
        ensure
            identity_created: x = 0.0 and y = 0.0 and z = 0.0 and w = 1.0
        end

    make_from_components (a_x, a_y, a_z, a_w: REAL)
            -- Create from components.
        do
            x := a_x
            y := a_y
            z := a_z
            w := a_w
        ensure
            components_set: x = a_x and y = a_y and z = a_z and w = a_w
        end

    make_from_axis_angle (axis: VECTOR_3I; angle_radians: REAL)
            -- Create a quaternion from axis (must be normalized) and angle in radians.
        require
            axis_attached: axis /= Void
        local
            half_angle, sin_half: REAL
            axis_magnitude: REAL
        do
            axis_magnitude := (axis.x * axis.x + axis.y * axis.y + axis.z * axis.z).sqrt
            if axis_magnitude > 1e-6 then
                half_angle := angle_radians / 2.0
                sin_half := half_angle.sin
                x := axis.x.to_real / axis_magnitude * sin_half
                y := axis.y.to_real / axis_magnitude * sin_half
                z := axis.z.to_real / axis_magnitude * sin_half
                w := half_angle.cos
            else
                make_identity
            end
        ensure
            result_created: True
        end

feature -- Basic Operations

    normalize
            -- Normalize this quaternion to unit length.
        local
            mag: REAL
        do
            mag := magnitude
            if mag > 1e-6 then
                x := x / mag
                y := y / mag
                z := z / mag
                w := w / mag
            else
                make_identity
            end
        ensure
            is_normalized: (magnitude - 1.0).abs <= 1e-5
        end

    conjugate: QUATERNION
            -- Conjugate (negate vector part).
        do
            create Result.make_from_components (-x, -y, -z, w)
        ensure
            result_attached: Result /= Void
        end

    inverse: QUATERNION
            -- Inverse of the quaternion.
        local
            dot: REAL
        do
            dot := x*x + y*y + z*z + w*w
            if dot > 1e-6 then
                create Result.make_from_components (-x / dot, -y / dot, -z / dot, w / dot)
            else
                create Result.make_identity
            end
        ensure
            result_attached: Result /= Void
        end

feature -- Rotations

    rotate_vector (v: VECTOR_3I): VECTOR_3I
            -- Rotate a 3D vector by this quaternion.
        require
            v_attached: v /= Void
        local
            qvec: QUATERNION
            result_q: QUATERNION
            inv_self: QUATERNION
        do
            create qvec.make_from_components (v.x.to_real, v.y.to_real, v.z.to_real, 0.0)
            inv_self := inverse
            result_q := (Current * qvec) * inv_self
            create Result.make (
                result_q.x.rounded,
                result_q.y.rounded,
                result_q.z.rounded
            )
        ensure
            result_attached: Result /= Void
        end

feature -- Interpolation

    frozen lerp (to_quat: QUATERNION; t: REAL): QUATERNION
            -- Linear interpolation.
        require
            to_quat_attached: to_quat /= Void
            t_valid: t >= 0.0 and t <= 1.0
        do
            create Result.make_from_components (
                x + (to_quat.x - x) * t,
                y + (to_quat.y - y) * t,
                z + (to_quat.z - z) * t,
                w + (to_quat.w - w) * t
            )
            Result.normalize
        ensure
            result_attached: Result /= Void
        end

    frozen slerp (to_quat: QUATERNION; t: REAL): QUATERNION
            -- Spherical linear interpolation.
        require
            to_quat_attached: to_quat /= Void
            t_valid: t >= 0.0 and t <= 1.0
        local
            cos_half_theta, sin_half_theta, half_theta, ratio_a, ratio_b: REAL
            q2: QUATERNION
        do
            cos_half_theta := x * to_quat.x + y * to_quat.y + z * to_quat.z + w * to_quat.w

            create q2.make_from_components (to_quat.x, to_quat.y, to_quat.z, to_quat.w)

            if cos_half_theta < 0.0 then
                q2.set_components (-q2.x, -q2.y, -q2.z, -q2.w)
                cos_half_theta := -cos_half_theta
            end

            if cos_half_theta > 0.9995 then
                -- Almost linear
                Result := lerp (q2, t)
            else
                half_theta := cos_half_theta.acos
                sin_half_theta := (1.0 - cos_half_theta*cos_half_theta).sqrt

                if sin_half_theta.abs < 1e-6 then
                    create Result.make_from_components (
                        (x * 0.5 + q2.x * 0.5),
                        (y * 0.5 + q2.y * 0.5),
                        (z * 0.5 + q2.z * 0.5),
                        (w * 0.5 + q2.w * 0.5)
                    )
                else
                    ratio_a := (half_theta * (1.0 - t)).sin / sin_half_theta
                    ratio_b := (half_theta * t).sin / sin_half_theta

                    create Result.make_from_components (
                        (x * ratio_a + q2.x * ratio_b),
                        (y * ratio_a + q2.y * ratio_b),
                        (z * ratio_a + q2.z * ratio_b),
                        (w * ratio_a + q2.w * ratio_b)
                    )
                end
            end
            Result.normalize
        ensure
            result_attached: Result /= Void
        end

feature -- Operators

    infix "*" (other: QUATERNION): QUATERNION
            -- Multiply two quaternions.
        require
            other_attached: other /= Void
        do
            create Result.make_from_components (
                w * other.x + x * other.w + y * other.z - z * other.y,
                w * other.y - x * other.z + y * other.w + z * other.x,
                w * other.z + x * other.y - y * other.x + z * other.w,
                w * other.w - x * other.x - y * other.y - z * other.z
            )
        ensure
            result_attached: Result /= Void
        end

feature -- Output

    to_string: STRING
            -- Text representation
        do
            create Result.make_from_string ("(" + x.out + ", " + y.out + ", " + z.out + ", " + w.out + ")")
        ensure
            result_attached: Result /= Void
        end

feature -- Internal Utilities

    set_components (a_x, a_y, a_z, a_w: REAL)
            -- Directly set all components.
        do
            x := a_x
            y := a_y
            z := a_z
            w := a_w
        end

invariant
    -- No constraint on quaternion components

end
