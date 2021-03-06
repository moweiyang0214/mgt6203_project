library(lars)
library(glmnet)
library(plm)

data = read.csv("~/gatech/mgt6203/project/mgt6203_project/consumer_analysis.csv",header=TRUE,sep=",",stringsAsFactors=FALSE, row.names=NULL)

data$proportion_purchased_store_coup = data$total_units_purchased_on_store_coup / data$total_units_purchased
data$brand = as.factor(data$brand)
data$rim_market = as.factor(data$rim_market)
data$household_income = as.factor(data$household_income)

data$t_proportion_purchased_store_coup = log(data$proportion_purchased_store_coup*100)
data$t_proportion_purchased_store_coup = data$proportion_purchased_store_coup*100

model <- lm(formula = t_proportion_purchased_store_coup ~ Q2 + Q3 + Q4 + rim_market +  
                      num_small_appliances + num_members_in_household + household_income + 
                      primary_head_avg_work_hours, data=data)
summary(model)


data$proportion_purchased_mfr_coup = data$total_units_purchased_on_mfr_coup / data$total_units_purchased
data$t_proportion_purchased_mfr_coup = data$proportion_purchased_mfr_coup*100

model <- lm(formula = proportion_purchased_mfr_coup ~ Q2 + Q3 + Q4 + rim_market + num_large_appliances + 
              num_small_appliances + num_members_in_household + household_income + 
              primary_head_avg_work_hours, data=data)
summary(model)

# https://stats.stackexchange.com/questions/66973/difference-between-fixed-effects-models-in-r-plm-and-stata-xtreg

cluster_data = read.csv("~/gatech/mgt6203/project/mgt6203_project/consumer_analysis_quarterly_cluster_results.csv",header=TRUE,sep=",",stringsAsFactors=FALSE, row.names=NULL)


cluster_data$proportion_purchased_store_coup = cluster_data$total_units_purchased_on_store_coup / cluster_data$total_units_purchased
cluster_data$proportion_purchased_mfr_coup = cluster_data$total_units_purchased_on_mfr_coup / data$total_units_purchased
#cluster_data$brand = as.factor(cluster_data$brand)
cluster_data$rim_market = as.factor(cluster_data$rim_market)
cluster_data$household_income = as.factor(cluster_data$household_income)
cluster_data$k3 = as.factor(cluster_data$k3)
cluster_data$k5 = as.factor(cluster_data$k5)
cluster_data$k8 = as.factor(cluster_data$k8)

# k = 3
model <- lm(formula = proportion_purchased_store_coup ~ Q2 + Q3 + Q4 + rim_market + num_small_appliances + 
              num_pets + num_members_in_household + household_income + total_head_avg_work_hours + weekday_purchase_percentage + 
              residence_status + k3, data=cluster_data)
summary(model)



# k = 5
model <- lm(formula = proportion_purchased_store_coup ~ Q2 + Q3 + Q4 + rim_market + weekday_shopper + num_large_appliances + 
              num_small_appliances + num_members_in_household + household_income + 
              primary_head_avg_work_hours + k5, data=cluster_data)
summary(model)

# k = 8
model <- lm(formula = proportion_purchased_store_coup ~ Q2 + Q3 + Q4 + rim_market + weekday_shopper + num_large_appliances +  
              num_small_appliances + num_members_in_household + household_income + 
              primary_head_avg_work_hours + k8, data=cluster_data)
summary(model)

# model per cluster
cluster_0 = cluster_data[cluster_data$k3 == 0, ]
cluster_1 = cluster_data[cluster_data$k3 == 1, ]
cluster_2 = cluster_data[cluster_data$k3 == 2, ]


# cluster 0 only had one value for rim_market so I removed it
model <- lm(formula = proportion_purchased_store_coup ~ Q2 + Q3 + Q4 + weekday_shopper + num_large_appliances +  #rim_market +  
              num_small_appliances + num_members_in_household + household_income + 
              primary_head_avg_work_hours, data=cluster_0)
summary(model)

model <- lm(formula = proportion_purchased_store_coup ~ Q2 + Q3 + Q4 + weekday_shopper + num_large_appliances +  #rim_market +  
              num_small_appliances + num_members_in_household + household_income + 
              primary_head_avg_work_hours, data=cluster_1)
summary(model)

model <- lm(formula = proportion_purchased_store_coup ~ Q2 + Q3 + Q4 + weekday_shopper + num_large_appliances +  #rim_market +  
              num_small_appliances + num_members_in_household + household_income + 
              primary_head_avg_work_hours, data=cluster_2)
summary(model)

model <- lm(formula = proportion_purchased_store_coup ~ Q2 + Q3 + Q4 + weekday_shopper + num_large_appliances +  #rim_market +  
              num_small_appliances + num_members_in_household + household_income + 
              primary_head_avg_work_hours, data=cluster_3)
summary(model)

model <- lm(formula = proportion_purchased_store_coup ~ Q2 + Q3 + Q4 + weekday_shopper + num_large_appliances +  #rim_market +  
              num_small_appliances + num_members_in_household + household_income + 
              primary_head_avg_work_hours, data=cluster_4)
summary(model)

model <- lm(formula = proportion_purchased_store_coup ~ Q2 + Q3 + Q4 + weekday_shopper + num_large_appliances +  #rim_market +  
              num_small_appliances + num_members_in_household + household_income + 
              primary_head_avg_work_hours, data=cluster_5)
summary(model)

model <- lm(formula = proportion_purchased_store_coup ~ Q2 + Q3 + Q4 + weekday_shopper + num_large_appliances +  #rim_market +  
              num_small_appliances + num_members_in_household + household_income + 
              primary_head_avg_work_hours, data=cluster_6)
summary(model)

model <- lm(formula = proportion_purchased_store_coup ~ Q2 + Q3 + Q4 + weekday_shopper + num_large_appliances +  #rim_market +  
              num_small_appliances + num_members_in_household + household_income + 
              primary_head_avg_work_hours, data=cluster_7)
summary(model)

library(ggplot2)

p_model <- glm(t_proportion_purchased_store_coup ~ Q2 + Q3 + Q4 + rim_market +  
                 num_small_appliances + num_members_in_household + household_income + 
                 primary_head_avg_work_hours, family="poisson", data=data)
summary(p_model)

qplot(data$t2_proportion_purchased_store_coup, geom="histogram") 
qplot(data$t_proportion_purchased_mfr_coup, geom="histogram")

qplot(log(data$proportion_purchased_store_coup), geom="histogram") 
qplot(log(data$proportion_purchased_mfr_coup), geom="histogram")

ggplot(data=data, aes(factor(rim_market), proportion_purchased_store_coup)) +
  geom_boxplot() + 
  xlab("ERIM Market") + 
  ylab("Units purchased w coupon/units purchased")

ggplot(data=data, aes(factor(household_income), response)) +
  geom_boxplot() + 
  xlab("Household Income") + 
  ylab("Units purchased w coupon/units purchased")

ggplot(data=data, aes(factor(num_members_in_household), response)) +
  geom_boxplot() + 
  xlab("Number of members in household") + 
  ylab("Units purchased w coupon/units purchased")


ggplot(data=data, aes(factor(male_head_race), response)) +
  geom_boxplot() + 
  xlab("Male head race") + 
  ylab("Units purchased w coupon/units purchased")


ggplot(data=data, aes(factor(female_head_race), response)) +
  geom_boxplot() + 
  xlab("Female head race") + 
  ylab("Units purchased w coupon/units purchased")


