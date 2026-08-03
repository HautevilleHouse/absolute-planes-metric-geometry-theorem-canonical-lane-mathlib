import canonicalLaneMathlib.AdmissibleClass
import Mathlib.Data.Real.Basic

namespace HautevilleHouse
namespace AbsolutePlanesMetricGeometryTheoremCanonicalLaneLean

/-! Absolute planes metric geometry: admissible-class bridge. -/

structure AbsolutePlane where
  Point : Type
  Line : Type
  incidence : Point → Line → Prop
  between : Point → Point → Point → Prop
  congruent : Point → Point → Point → Point → Prop
  distance : Point → Point → ℝ
  distance_nonneg : ∀ x y, 0 ≤ distance x y
  distance_eq_zero : ∀ x y, distance x y = 0 ↔ x = y
  distance_comm : ∀ x y, distance x y = distance y x
  between_distance : ∀ {a b c : Point}, between a b c →
    distance a c = distance a b + distance b c
  congruent_iff_distance : ∀ {a b c d : Point},
    congruent a b c d ↔ distance a b = distance c d
  line_through_two : ∀ {a b : Point}, a ≠ b →
    ∃ l : Line, incidence a l ∧ incidence b l
  line_unique : ∀ {a b : Point} {l m : Line}, a ≠ b →
    incidence a l → incidence b l → incidence a m → incidence b m → l = m

structure AdmittedObject where
  plane : AbsolutePlane
  citation : String

def bridgeClosed (P : AbsolutePlane) : Prop :=
  ∀ {a b : P.Point}, a ≠ b →
    ∃ l : P.Line, P.incidence a l ∧ P.incidence b l ∧
      ∀ m : P.Line, P.incidence a m → P.incidence b m → m = l

def gateClosed (P : AbsolutePlane) : Prop :=
  ∀ {a b c : P.Point}, P.between a b c →
    P.distance a c = P.distance a b + P.distance b c

structure AdmissibleClass where
  object : AdmittedObject
  endpointSatisfied : Prop
  remainderRecorded : Prop
  gateWitness : endpointSatisfied ∨ remainderRecorded

def carriedRemainder (A : AdmissibleClass) : Prop :=
  A.remainderRecorded

def ConstrainedAbsolutePlanesMetricGeometryClosure (A : AdmissibleClass) : Prop :=
  bridgeClosed A.object.plane ∧ gateClosed A.object.plane

theorem bridge_from_structure (P : AbsolutePlane) : bridgeClosed P := by
  intro a b hne
  rcases P.line_through_two hne with ⟨l, hl⟩
  refine ⟨l, hl.1, hl.2, ?_⟩
  intro m hma hmb
  exact P.line_unique hne hl.1 hl.2 hma hmb

theorem gate_from_structure (P : AbsolutePlane) : gateClosed P := by
  intro a b c hb
  exact P.between_distance hb

theorem constrained_absolute_planes_metric_geometry_endgame (A : AdmissibleClass) :
    ConstrainedAbsolutePlanesMetricGeometryClosure A := by
  exact And.intro (bridge_from_structure A.object.plane) (gate_from_structure A.object.plane)

end AbsolutePlanesMetricGeometryTheoremCanonicalLaneLean
end HautevilleHouse