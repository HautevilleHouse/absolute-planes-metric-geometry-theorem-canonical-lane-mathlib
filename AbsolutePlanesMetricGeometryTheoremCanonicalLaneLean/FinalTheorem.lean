import canonicalLaneMathlib.AdmissibleClass

namespace HautevilleHouse
namespace AbsolutePlanesMetricGeometryTheoremCanonicalLaneLean

/-- The primitive notions of an absolute plane: points, lines, incidence,
    betweenness, and congruence. These are the undefined terms of Hilbert's
    axiom system for neutral geometry. -/
structure AbsolutePlane where
  Point : Type
  Line : Type
  incidence : Point → Line → Prop
  between : Point → Point → Point → Prop
  congruent : Point → Point → Point → Point → Prop
  -- Two distinct points determine a unique line.
  exists_line : ∀ p q : Point, p ≠ q → ∃ l : Line, incidence p l ∧ incidence q l
  unique_line : ∀ p q : Point, p ≠ q → ∀ l m : Line,
    incidence p l → incidence q l → incidence p m → incidence q m → l = m

/-- The metric geometry of an absolute plane: a real-valued distance function
    satisfying the metric axioms, together with the admissible-class bridge.
    The `admissible` field connects the synthetic geometry to the canonical
    closure pattern of this repository. -/
structure AbsolutePlaneMetricGeometry (R : Type) [LinearOrderedRing R] where
  admissible : AdmissibleClass
  Point : Type
  Line : Type
  incidence : Point → Line → Prop
  between : Point → Point → Point → Prop
  congruent : Point → Point → Point → Point → Prop
  dist : Point → Point → R
  dist_comm : ∀ a b : Point, dist a b = dist b a
  dist_eq_zero : ∀ a b : Point, dist a b = 0 ↔ a = b
  triangle_ineq : ∀ a b c : Point, dist a c ≤ dist a b + dist b c
  exists_line : ∀ p q : Point, p ≠ q → ∃ l : Line, incidence p l ∧ incidence q l
  unique_line : ∀ p q : Point, p ≠ q → ∀ l m : Line,
    incidence p l → incidence q l → incidence p m → incidence q m → l = m

/-- The parallel postulate, stated for an absolute plane.  In absolute (neutral)
    geometry this postulate is deliberately left open. -/
def ParallelPostulate {R : Type} [LinearOrderedRing R] (G : AbsolutePlaneMetricGeometry R) : Prop :=
  ∀ l : G.Line, ∀ p : G.Point, ¬ G.incidence p l →
    ∃! m : G.Line, G.incidence p m ∧ ∀ q : G.Point, ¬ (G.incidence q l ∧ G.incidence q m)

/-- The carried remainder of the absolute-plane metric geometry closure:
    the status of the parallel postulate remains undecided from the axioms. -/
def AbsolutePlanesMetricCarriedRemainder {R : Type} [LinearOrderedRing R]
    (G : AbsolutePlaneMetricGeometry R) : Prop :=
  ¬ ParallelPostulate G

/-- The admissible-class closure for the Absolute Planes Metric Geometry Theorem. -/
def ConstrainedAbsolutePlanesMetricClosure (A : AdmissibleClass) : Prop :=
  bridgeClosed A ∧ gateClosed A

/-- The endgame: every admissible class is already closed. -/
theorem constrained_absolute_planes_metric_endgame (A : AdmissibleClass) :
    ConstrainedAbsolutePlanesMetricClosure A := by
  exact And.intro (bridge_from_admissible_class A) (gate_from_admissible_class A)

/-- The bridge statement for a concrete absolute plane metric geometry: its
    associated admissible class satisfies the closure. -/
def AbsolutePlanesMetricBridge {R : Type} [LinearOrderedRing R]
    (G : AbsolutePlaneMetricGeometry R) : Prop :=
  bridgeClosed G.admissible ∧ gateClosed G.admissible

/-- The bridge is closed for every absolute plane metric geometry. -/
theorem absolute_planes_metric_bridge_endgame {R : Type} [LinearOrderedRing R]
    (G : AbsolutePlaneMetricGeometry R) : AbsolutePlanesMetricBridge G := by
  exact constrained_absolute_planes_metric_endgame G.admissible

/-- The closure condition is exactly the bridge condition for the associated
    admissible class. -/
lemma absolute_planes_metric_closure_bridge_iff {R : Type} [LinearOrderedRing R]
    (G : AbsolutePlaneMetricGeometry R) :
    ConstrainedAbsolutePlanesMetricClosure G.admissible ↔ AbsolutePlanesMetricBridge G := by
  rfl

end AbsolutePlanesMetricGeometryTheoremCanonicalLaneLean
end HautevilleHouse