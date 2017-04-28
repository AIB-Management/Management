package com.gdaib.pojo;

import java.util.ArrayList;
import java.util.List;

public class V_DnExample {
    protected String orderByClause;

    protected boolean distinct;

    protected List<Criteria> oredCriteria;

    public V_DnExample() {
        oredCriteria = new ArrayList<Criteria>();
    }

    public void setOrderByClause(String orderByClause) {
        this.orderByClause = orderByClause;
    }

    public String getOrderByClause() {
        return orderByClause;
    }

    public void setDistinct(boolean distinct) {
        this.distinct = distinct;
    }

    public boolean isDistinct() {
        return distinct;
    }

    public List<Criteria> getOredCriteria() {
        return oredCriteria;
    }

    public void or(Criteria criteria) {
        oredCriteria.add(criteria);
    }

    public Criteria or() {
        Criteria criteria = createCriteriaInternal();
        oredCriteria.add(criteria);
        return criteria;
    }

    public Criteria createCriteria() {
        Criteria criteria = createCriteriaInternal();
        if (oredCriteria.size() == 0) {
            oredCriteria.add(criteria);
        }
        return criteria;
    }

    protected Criteria createCriteriaInternal() {
        Criteria criteria = new Criteria();
        return criteria;
    }

    public void clear() {
        oredCriteria.clear();
        orderByClause = null;
        distinct = false;
    }

    protected abstract static class GeneratedCriteria {
        protected List<Criterion> criteria;

        protected GeneratedCriteria() {
            super();
            criteria = new ArrayList<Criterion>();
        }

        public boolean isValid() {
            return criteria.size() > 0;
        }

        public List<Criterion> getAllCriteria() {
            return criteria;
        }

        public List<Criterion> getCriteria() {
            return criteria;
        }

        protected void addCriterion(String condition) {
            if (condition == null) {
                throw new RuntimeException("Value for condition cannot be null");
            }
            criteria.add(new Criterion(condition));
        }

        protected void addCriterion(String condition, Object value, String property) {
            if (value == null) {
                throw new RuntimeException("Value for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value));
        }

        protected void addCriterion(String condition, Object value1, Object value2, String property) {
            if (value1 == null || value2 == null) {
                throw new RuntimeException("Between values for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value1, value2));
        }

        public Criteria andDnIdIsNull() {
            addCriterion("dn_id is null");
            return (Criteria) this;
        }

        public Criteria andDnIdIsNotNull() {
            addCriterion("dn_id is not null");
            return (Criteria) this;
        }

        public Criteria andDnIdEqualTo(Integer value) {
            addCriterion("dn_id =", value, "dnId");
            return (Criteria) this;
        }

        public Criteria andDnIdNotEqualTo(Integer value) {
            addCriterion("dn_id <>", value, "dnId");
            return (Criteria) this;
        }

        public Criteria andDnIdGreaterThan(Integer value) {
            addCriterion("dn_id >", value, "dnId");
            return (Criteria) this;
        }

        public Criteria andDnIdGreaterThanOrEqualTo(Integer value) {
            addCriterion("dn_id >=", value, "dnId");
            return (Criteria) this;
        }

        public Criteria andDnIdLessThan(Integer value) {
            addCriterion("dn_id <", value, "dnId");
            return (Criteria) this;
        }

        public Criteria andDnIdLessThanOrEqualTo(Integer value) {
            addCriterion("dn_id <=", value, "dnId");
            return (Criteria) this;
        }

        public Criteria andDnIdIn(List<Integer> values) {
            addCriterion("dn_id in", values, "dnId");
            return (Criteria) this;
        }

        public Criteria andDnIdNotIn(List<Integer> values) {
            addCriterion("dn_id not in", values, "dnId");
            return (Criteria) this;
        }

        public Criteria andDnIdBetween(Integer value1, Integer value2) {
            addCriterion("dn_id between", value1, value2, "dnId");
            return (Criteria) this;
        }

        public Criteria andDnIdNotBetween(Integer value1, Integer value2) {
            addCriterion("dn_id not between", value1, value2, "dnId");
            return (Criteria) this;
        }

        public Criteria andDeIdIsNull() {
            addCriterion("de_id is null");
            return (Criteria) this;
        }

        public Criteria andDeIdIsNotNull() {
            addCriterion("de_id is not null");
            return (Criteria) this;
        }

        public Criteria andDeIdEqualTo(Integer value) {
            addCriterion("de_id =", value, "deId");
            return (Criteria) this;
        }

        public Criteria andDeIdNotEqualTo(Integer value) {
            addCriterion("de_id <>", value, "deId");
            return (Criteria) this;
        }

        public Criteria andDeIdGreaterThan(Integer value) {
            addCriterion("de_id >", value, "deId");
            return (Criteria) this;
        }

        public Criteria andDeIdGreaterThanOrEqualTo(Integer value) {
            addCriterion("de_id >=", value, "deId");
            return (Criteria) this;
        }

        public Criteria andDeIdLessThan(Integer value) {
            addCriterion("de_id <", value, "deId");
            return (Criteria) this;
        }

        public Criteria andDeIdLessThanOrEqualTo(Integer value) {
            addCriterion("de_id <=", value, "deId");
            return (Criteria) this;
        }

        public Criteria andDeIdIn(List<Integer> values) {
            addCriterion("de_id in", values, "deId");
            return (Criteria) this;
        }

        public Criteria andDeIdNotIn(List<Integer> values) {
            addCriterion("de_id not in", values, "deId");
            return (Criteria) this;
        }

        public Criteria andDeIdBetween(Integer value1, Integer value2) {
            addCriterion("de_id between", value1, value2, "deId");
            return (Criteria) this;
        }

        public Criteria andDeIdNotBetween(Integer value1, Integer value2) {
            addCriterion("de_id not between", value1, value2, "deId");
            return (Criteria) this;
        }

        public Criteria andDepartmentIsNull() {
            addCriterion("department is null");
            return (Criteria) this;
        }

        public Criteria andDepartmentIsNotNull() {
            addCriterion("department is not null");
            return (Criteria) this;
        }

        public Criteria andDepartmentEqualTo(String value) {
            addCriterion("department =", value, "department");
            return (Criteria) this;
        }

        public Criteria andDepartmentNotEqualTo(String value) {
            addCriterion("department <>", value, "department");
            return (Criteria) this;
        }

        public Criteria andDepartmentGreaterThan(String value) {
            addCriterion("department >", value, "department");
            return (Criteria) this;
        }

        public Criteria andDepartmentGreaterThanOrEqualTo(String value) {
            addCriterion("department >=", value, "department");
            return (Criteria) this;
        }

        public Criteria andDepartmentLessThan(String value) {
            addCriterion("department <", value, "department");
            return (Criteria) this;
        }

        public Criteria andDepartmentLessThanOrEqualTo(String value) {
            addCriterion("department <=", value, "department");
            return (Criteria) this;
        }

        public Criteria andDepartmentLike(String value) {
            addCriterion("department like", value, "department");
            return (Criteria) this;
        }

        public Criteria andDepartmentNotLike(String value) {
            addCriterion("department not like", value, "department");
            return (Criteria) this;
        }

        public Criteria andDepartmentIn(List<String> values) {
            addCriterion("department in", values, "department");
            return (Criteria) this;
        }

        public Criteria andDepartmentNotIn(List<String> values) {
            addCriterion("department not in", values, "department");
            return (Criteria) this;
        }

        public Criteria andDepartmentBetween(String value1, String value2) {
            addCriterion("department between", value1, value2, "department");
            return (Criteria) this;
        }

        public Criteria andDepartmentNotBetween(String value1, String value2) {
            addCriterion("department not between", value1, value2, "department");
            return (Criteria) this;
        }

        public Criteria andNFirIdIsNull() {
            addCriterion("n_fir_id is null");
            return (Criteria) this;
        }

        public Criteria andNFirIdIsNotNull() {
            addCriterion("n_fir_id is not null");
            return (Criteria) this;
        }

        public Criteria andNFirIdEqualTo(Integer value) {
            addCriterion("n_fir_id =", value, "nFirId");
            return (Criteria) this;
        }

        public Criteria andNFirIdNotEqualTo(Integer value) {
            addCriterion("n_fir_id <>", value, "nFirId");
            return (Criteria) this;
        }

        public Criteria andNFirIdGreaterThan(Integer value) {
            addCriterion("n_fir_id >", value, "nFirId");
            return (Criteria) this;
        }

        public Criteria andNFirIdGreaterThanOrEqualTo(Integer value) {
            addCriterion("n_fir_id >=", value, "nFirId");
            return (Criteria) this;
        }

        public Criteria andNFirIdLessThan(Integer value) {
            addCriterion("n_fir_id <", value, "nFirId");
            return (Criteria) this;
        }

        public Criteria andNFirIdLessThanOrEqualTo(Integer value) {
            addCriterion("n_fir_id <=", value, "nFirId");
            return (Criteria) this;
        }

        public Criteria andNFirIdIn(List<Integer> values) {
            addCriterion("n_fir_id in", values, "nFirId");
            return (Criteria) this;
        }

        public Criteria andNFirIdNotIn(List<Integer> values) {
            addCriterion("n_fir_id not in", values, "nFirId");
            return (Criteria) this;
        }

        public Criteria andNFirIdBetween(Integer value1, Integer value2) {
            addCriterion("n_fir_id between", value1, value2, "nFirId");
            return (Criteria) this;
        }

        public Criteria andNFirIdNotBetween(Integer value1, Integer value2) {
            addCriterion("n_fir_id not between", value1, value2, "nFirId");
            return (Criteria) this;
        }

        public Criteria andNFirstIsNull() {
            addCriterion("n_first is null");
            return (Criteria) this;
        }

        public Criteria andNFirstIsNotNull() {
            addCriterion("n_first is not null");
            return (Criteria) this;
        }

        public Criteria andNFirstEqualTo(String value) {
            addCriterion("n_first =", value, "nFirst");
            return (Criteria) this;
        }

        public Criteria andNFirstNotEqualTo(String value) {
            addCriterion("n_first <>", value, "nFirst");
            return (Criteria) this;
        }

        public Criteria andNFirstGreaterThan(String value) {
            addCriterion("n_first >", value, "nFirst");
            return (Criteria) this;
        }

        public Criteria andNFirstGreaterThanOrEqualTo(String value) {
            addCriterion("n_first >=", value, "nFirst");
            return (Criteria) this;
        }

        public Criteria andNFirstLessThan(String value) {
            addCriterion("n_first <", value, "nFirst");
            return (Criteria) this;
        }

        public Criteria andNFirstLessThanOrEqualTo(String value) {
            addCriterion("n_first <=", value, "nFirst");
            return (Criteria) this;
        }

        public Criteria andNFirstLike(String value) {
            addCriterion("n_first like", value, "nFirst");
            return (Criteria) this;
        }

        public Criteria andNFirstNotLike(String value) {
            addCriterion("n_first not like", value, "nFirst");
            return (Criteria) this;
        }

        public Criteria andNFirstIn(List<String> values) {
            addCriterion("n_first in", values, "nFirst");
            return (Criteria) this;
        }

        public Criteria andNFirstNotIn(List<String> values) {
            addCriterion("n_first not in", values, "nFirst");
            return (Criteria) this;
        }

        public Criteria andNFirstBetween(String value1, String value2) {
            addCriterion("n_first between", value1, value2, "nFirst");
            return (Criteria) this;
        }

        public Criteria andNFirstNotBetween(String value1, String value2) {
            addCriterion("n_first not between", value1, value2, "nFirst");
            return (Criteria) this;
        }

        public Criteria andNSecIsNull() {
            addCriterion("n_sec is null");
            return (Criteria) this;
        }

        public Criteria andNSecIsNotNull() {
            addCriterion("n_sec is not null");
            return (Criteria) this;
        }

        public Criteria andNSecEqualTo(String value) {
            addCriterion("n_sec =", value, "nSec");
            return (Criteria) this;
        }

        public Criteria andNSecNotEqualTo(String value) {
            addCriterion("n_sec <>", value, "nSec");
            return (Criteria) this;
        }

        public Criteria andNSecGreaterThan(String value) {
            addCriterion("n_sec >", value, "nSec");
            return (Criteria) this;
        }

        public Criteria andNSecGreaterThanOrEqualTo(String value) {
            addCriterion("n_sec >=", value, "nSec");
            return (Criteria) this;
        }

        public Criteria andNSecLessThan(String value) {
            addCriterion("n_sec <", value, "nSec");
            return (Criteria) this;
        }

        public Criteria andNSecLessThanOrEqualTo(String value) {
            addCriterion("n_sec <=", value, "nSec");
            return (Criteria) this;
        }

        public Criteria andNSecLike(String value) {
            addCriterion("n_sec like", value, "nSec");
            return (Criteria) this;
        }

        public Criteria andNSecNotLike(String value) {
            addCriterion("n_sec not like", value, "nSec");
            return (Criteria) this;
        }

        public Criteria andNSecIn(List<String> values) {
            addCriterion("n_sec in", values, "nSec");
            return (Criteria) this;
        }

        public Criteria andNSecNotIn(List<String> values) {
            addCriterion("n_sec not in", values, "nSec");
            return (Criteria) this;
        }

        public Criteria andNSecBetween(String value1, String value2) {
            addCriterion("n_sec between", value1, value2, "nSec");
            return (Criteria) this;
        }

        public Criteria andNSecNotBetween(String value1, String value2) {
            addCriterion("n_sec not between", value1, value2, "nSec");
            return (Criteria) this;
        }
    }

    public static class Criteria extends GeneratedCriteria {

        protected Criteria() {
            super();
        }
    }

    public static class Criterion {
        private String condition;

        private Object value;

        private Object secondValue;

        private boolean noValue;

        private boolean singleValue;

        private boolean betweenValue;

        private boolean listValue;

        private String typeHandler;

        public String getCondition() {
            return condition;
        }

        public Object getValue() {
            return value;
        }

        public Object getSecondValue() {
            return secondValue;
        }

        public boolean isNoValue() {
            return noValue;
        }

        public boolean isSingleValue() {
            return singleValue;
        }

        public boolean isBetweenValue() {
            return betweenValue;
        }

        public boolean isListValue() {
            return listValue;
        }

        public String getTypeHandler() {
            return typeHandler;
        }

        protected Criterion(String condition) {
            super();
            this.condition = condition;
            this.typeHandler = null;
            this.noValue = true;
        }

        protected Criterion(String condition, Object value, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.typeHandler = typeHandler;
            if (value instanceof List<?>) {
                this.listValue = true;
            } else {
                this.singleValue = true;
            }
        }

        protected Criterion(String condition, Object value) {
            this(condition, value, null);
        }

        protected Criterion(String condition, Object value, Object secondValue, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.secondValue = secondValue;
            this.typeHandler = typeHandler;
            this.betweenValue = true;
        }

        protected Criterion(String condition, Object value, Object secondValue) {
            this(condition, value, secondValue, null);
        }
    }
}