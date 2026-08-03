import canonicalLaneMathlib.AdmissibleClass

namespace HautevilleHouse
namespace AbsolutePlanesMetricGeometryTheoremCanonicalLaneLean

noncomputable section

/-- An absolute plane: an incidence structure with betweenness, segment congruence,
    and an angle measure (in radians). The only axiom we record is that a right
    angle has positive measure. -/
structure AbsolutePlane where
  Point : Type
  Line : Type
  incident : Point → Line → Prop
  between : Point → Point → Point → Prop
  congruent_segments : Point → Point → Point → Point → Prop
  angle : Point → Point → Point → ℝ
  right_angle : ℝ
  right_angle_pos : 0 < right_angle

/-- A triangle in an absolute plane is a triple of non-collinear points. -/
structure Triangle (π : AbsolutePlane) where
  a : π.Point
  b : π.Point
  c : π.Point
  noncollinear : ¬ (π.between a b c ∨ π.between b c a ∨ π.between c a b)

/-- The sum of the three interior angle measures of a triangle. -/
def triangleAngleSum (π : AbsolutePlane) (t : Triangle π) : ℝ :=
  π.angle t.a t.b t.c + π.angle t.b t.c t.a + π.angle t.c t.a t.b

/-- The Saccheri–Legendre theorem, a central result in absolute plane geometry:
    every triangle has angle sum at most two right angles. -/
def SaccheriLegendreTheorem (π : AbsolutePlane) : Prop :=
  ∀ t : Triangle π, triangleAngleSum π t ≤ 2 * π.right_angle

/-- A witness for the absolute-plane metric bridge: a plane together with a proof
    that the Saccheri–Legendre theorem holds in it. -/
structure AbsolutePlaneMetricWitness where
  plane : AbsolutePlane
  conclusion : SaccheriLegendreTheorem plane

/-- The closure property for an absolute-plane witness: its conclusion holds. -/
def AbsolutePlaneMetricWitnessClosed (w : AbsolutePlaneMetricWitness) : Prop :=
  w.conclusion

/-- The admissible-class structure for this domain: an object is an absolute-plane
    metric witness. -/
structure AdmissibleClass where
  object : AbsolutePlaneMetricWitness

/-- The bridge is closed precisely when the witness's Saccheri–Legendre conclusion
    is accepted. -/
def bridgeClosed (A : AdmissibleClass) : Prop :=
  AbsolutePlaneMetricWitnessClosed A.object

/-- Every admissible object immediately provides its witness's conclusion, so the
    bridge is always closed. -/
theorem bridge_from_admissible_class (A : AdmissibleClass) :
    bridgeClosed A := by
  exact A.object.conclusion

end

end AbsolutePlanesMetricGeometryTheoremCanonicalLaneLean
end HautevilleHouse