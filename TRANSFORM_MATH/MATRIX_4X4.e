class
    MATRIX_4X4

create
    make_identity, make_zero, make_from_elements

feature -- Access

    elements: ARRAY2 [REAL]
            -- 4x4 matrix elements (row-major)

feature -- Creation

    make_identity
            -- Create identity matrix.
        do
            create elements.make_filled (0.0, 1, 4, 1, 4)
            elements.put (1.0, 1, 1)
            elements.put (1.0, 2, 2)
            elements.put (1.0, 3, 3)
            elements.put (1.0, 4, 4)
        ensure
            identity_matrix: elements.item (1,1) = 1.0 and elements.item (2,2) = 1.0 and elements.item (3,3) = 1.0 and elements.item (4,4) = 1.0
        end

    make_zero
            -- Create zero matrix.
        do
            create elements.make_filled (0.0, 1, 4, 1, 4)
        ensure
            zero_matrix: across elements as e all e.item = 0.0 end
        end

    make_from_elements (values: ARRAY [REAL])
            -- Create matrix from array of 16 elements.
        require
            values_attached: values /= Void
            values_correct_size: values.count = 16
        local
            i, row, col: INTEGER
        do
            create elements.make_filled (0.0, 1, 4, 1, 4)
            from
                i := 1
            until
                i > 16
            loop
                row := ((i-1) // 4) + 1
                col := ((i-1) \\ 4) + 1
                elements.put (values[i], row, col)
                i := i + 1
            end
        ensure
            filled: elements.count = 4 and elements.lower = 1
        end

feature -- Basic Operations

    infix "*" (other: MATRIX_4X4): MATRIX_4X4
            -- Matrix multiplication.
        require
            other_attached: other /= Void
        local
            r, c, k: INTEGER
            sum: REAL
        do
            create Result.make_zero
            from
                r := 1
            until
                r > 4
            loop
                from
                    c := 1
                until
                    c > 4
                loop
                    sum := 0.0
                    from
                        k := 1
                    until
                        k > 4
                    loop
                        sum := sum + elements.item (r,k) * other.elements.item (k,c)
                        k := k + 1
                    end
                    Result.elements.put (sum, r, c)
                    c := c + 1
                end
                r := r + 1
            end
        ensure
            result_attached: Result /= Void
        end

    transpose: MATRIX_4X4
            -- Return the transposed matrix.
        local
            r, c: INTEGER
        do
            create Result.make_zero
            from
                r := 1
            until
                r > 4
            loop
                from
                    c := 1
                until
                    c > 4
                loop
                    Result.elements.put (elements.item (c,r), r,c)
                    c := c + 1
                end
                r := r + 1
            end
        ensure
            result_attached: Result /= Void
        end

feature -- Transformations (Construction)

    frozen translation (v: VECTOR_3I): MATRIX_4X4
            -- Create a translation matrix from vector v.
        require
            v_attached: v /= Void
        do
            create Result.make_identity
            Result.elements.put (v.x.to_real, 1, 4)
            Result.elements.put (v.y.to_real, 2, 4)
            Result.elements.put (v.z.to_real, 3, 4)
        ensure
            result_attached: Result /= Void
        end

    frozen scaling (scale: VECTOR_3I): MATRIX_4X4
            -- Create a scaling matrix from scale vector.
        require
            scale_attached: scale /= Void
        do
            create Result.make_identity
            Result.elements.put (scale.x.to_real, 1,1)
            Result.elements.put (scale.y.to_real, 2,2)
            Result.elements.put (scale.z.to_real, 3,3)
        ensure
            result_attached: Result /= Void
        end

    frozen rotation_from_quaternion (q: QUATERNION): MATRIX_4X4
            -- Create rotation matrix from quaternion.
        require
            q_attached: q /= Void
        local
            xx, yy, zz, xy, xz, yz, wx, wy, wz: REAL
        do
            create Result.make_identity
            xx := q.x * q.x
            yy := q.y * q.y
            zz := q.z * q.z
            xy := q.x * q.y
            xz := q.x * q.z
            yz := q.y * q.z
            wx := q.w * q.x
            wy := q.w * q.y
            wz := q.w * q.z

            Result.elements.put (1.0 - 2.0*(yy + zz), 1,1)
            Result.elements.put (2.0*(xy - wz), 1,2)
            Result.elements.put (2.0*(xz + wy), 1,3)

            Result.elements.put (2.0*(xy + wz), 2,1)
            Result.elements.put (1.0 - 2.0*(xx + zz), 2,2)
            Result.elements.put (2.0*(yz - wx), 2,3)

            Result.elements.put (2.0*(xz - wy), 3,1)
            Result.elements.put (2.0*(yz + wx), 3,2)
            Result.elements.put (1.0 - 2.0*(xx + yy), 3,3)
        ensure
            result_attached: Result /= Void
        end

feature -- Output

    to_string: STRING
            -- Text output of matrix
        local
            r, c: INTEGER
        do
            create Result.make_empty
            from
                r := 1
            until
                r > 4
            loop
                from
                    c := 1
                until
                    c > 4
                loop
                    Result.append (elements.item(r,c).out + " ")
                    c := c + 1
                end
                Result.append ("%N")
                r := r + 1
            end
        ensure
            result_attached: Result /= Void
        end

invariant
    elements_attached: elements /= Void
    correct_size: elements.count = 4

note
	copyright: "Copyright (c) 2025, KontinuumGames"
	license:   "MIT, redistributable, keep author references"
	source: "[
			Eiffel Toolbox,
			Github: https://github.com/MapelSiroup/Eiffel-Toolbox
		]"
end -- MATRIX 4X4