.pragma library

function make(stiffness, dampingRatio, epsilon) {
    const w0 = Math.sqrt(stiffness)
    const z = Math.min(dampingRatio, 1)
    const seconds = -Math.log(epsilon) / (z * w0)
    return { w0: w0, z: z, duration: Math.round(seconds * 1000) }
}

function at(s, ms) {
    const t = Math.max(0, ms) / 1000
    if (s.z < 1) {
        const wd = s.w0 * Math.sqrt(1 - s.z * s.z)
        return 1 - Math.exp(-s.z * s.w0 * t) * (Math.cos(wd * t) + (s.z * s.w0 / wd) * Math.sin(wd * t))
    }
    return 1 - Math.exp(-s.w0 * t) * (1 + s.w0 * t)
}
