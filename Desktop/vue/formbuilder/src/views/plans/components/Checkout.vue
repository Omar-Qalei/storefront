<template>
    <div class="checkout">
            <v-radio-group v-model="cardSource">
            <v-row>
                <v-col class="col-7">
                    <v-card max-width="700"> 
                    <v-card-title class="h3 title">Payment Methods<v-spacer></v-spacer>
                    </v-card-title>
                    <v-divider class="my-4"></v-divider>
                        <v-row class="my-4">  
                        <v-col cols="12"> 
                            <v-card-title class="subtitle-2">
                                <v-radio :value="true"></v-radio>Saved Payment Methods<v-spacer></v-spacer></v-card-title>
                            <v-list>
                                <v-list-item-group v-model="model" v-if="cardSource" :loading="loading" >
                                    <v-list-item   v-for="paymentMethod in paymentMethods" :key="paymentMethod.id" @click="chooseCard(paymentMethod)" >
                                    <v-list-item-icon>
                                        <v-img width="100" :lazy-src="paymentMethod.image" :src="paymentMethod.image"></v-img>
                                    </v-list-item-icon>
                                    <v-list-item-content>
                                        <v-list-item-title> {{ paymentMethod.number }} | Expires {{ paymentMethod.expire }}</v-list-item-title>
                                    </v-list-item-content>
                                    </v-list-item>
                                </v-list-item-group>
                            </v-list> 
                              <v-divider class="my-2"></v-divider>
                        </v-col>
                        <v-col cols="12"> 
                            <v-card-title class="subtitle-2"> <v-radio :value="false" @click="prepareCardAdd"></v-radio>Use Another Card<v-spacer></v-spacer></v-card-title>
                                <v-row v-if="!cardSource">
                                <v-col>
                                    <v-card-text>
                                    <v-row class="mt-4">
                                        <v-col cols="12" sm="12">
                                            <div outlined id="card-element"></div>
                                        </v-col>
                                    </v-row>
                                    <v-row class="mt-4">
                                        <v-col cols="12" sm="6">
                                            <v-text-field label="First Name" v-model="firstName"></v-text-field>
                                        </v-col>
                                        <v-col cols="12" sm="6">
                                            <v-text-field label="Last Name" v-model="lastName"></v-text-field>
                                        </v-col>
                                    </v-row>
                                </v-card-text>
                                <v-card-actions justify="center">
                                    <v-spacer></v-spacer>
                                    <v-btn color="primary" @click="addPaymentMethodCard()">
                                        Save Card
                                    </v-btn>
                                </v-card-actions>
                                </v-col>
                             </v-row>
                        </v-col>
                    </v-row>
                </v-card>
            </v-col>
            <v-col class="col-5">
                <v-card  :key="this.plan.id">
                    <v-card-title class="h3 title">Summary<v-spacer></v-spacer>
                    </v-card-title>
                    <v-divider class="my-5"></v-divider>
                    <v-row>
                        <v-col>
                            <v-card-text>
                                <v-card-title>Plan Details</v-card-title>
                                <v-card-text> {{ this.plan.name }} <br>
                                    {{ this.plan.number_of_sites }} Sites <br>
                                    <div v-if="this.plan.type == 0">
                                        Monthly
                                    </div>
                                    <div v-else-if="this.plan.type == 1">
                                        Yearly
                                    </div>
                                </v-card-text>
                            </v-card-text>
                        </v-col>
                    </v-row>
                    <v-divider class="my-5"></v-divider>
                    <v-row>
                        <v-col>
                            <v-card-text>
                                <v-card-text class="headline" v-if="this.plan.type == 0">Total :
                                    {{ this.plan.price_monthly  + ' ' + this.plan.currency }}</v-card-text>
                                <v-card-title class="headline" v-if="this.plan.type == 1">Total :
                                    {{ this.plan.price_yearly  + ' ' + this.plan.currency }}</v-card-title>
                            </v-card-text>
                        </v-col>
                    </v-row>
                    <v-divider class="my-5"></v-divider>
                    <v-form>
                        <v-container>
                            <v-row>
                                <v-col cols="12" md="12" align="center">
                                    <v-alert type="success" v-if="success">
                                        Payment is processed successfully, check your subscription details
                                    </v-alert>
                                    <v-alert type="error" v-if="error">
                                        Something went wrong.
                                    </v-alert>
                                    <v-btn  class="blue darken-1 white--text font-weight-black"
                                        color="indigo" @click="processPayment" :disabled="purchase"
                                        :loading="paymentProcessing"
                                        v-text="paymentProcessing ? 'Processing' : 'Submit Purchase'"></v-btn>
                                        <v-card-text>Safe & Secure Payment</v-card-text>
                                </v-col>
                            </v-row>
                        </v-container>
                    </v-form>
                </v-card>
            </v-col>
        </v-row>
    </v-radio-group>
    </div>
</template>
<script>
    import {
        loadStripe
    } from '@stripe/stripe-js';
    import {
        SubscriptionService
    } from "../../../services/billing/subscription";
    export default {
        props: ['plan'],
        data() {
            return {
                paymentMethods: [],
                selectedPayment:null,
                stripe: {},
                paymentCard: {},
                cardElement: {},
                cardSource:true,
                customer: {
                    token: '',
                    package_id: '',
                    type: null,
                },
                paymentProcessing: false,
                success: false,
                error: false,
                loading:false,
                purchase :true,
                firstName:null,
                lastName:null,
                token:null,
            }
        },
        async mounted() {
             this.stripe = await loadStripe(
                "pk_test_51JG1ZOHSO2EOvWbReJEckSbfJb0TwrBVHCY8uqEvFRcxBDrGfzUvzkPeTAZxDtc4PsiysQLg9cxDQVswhb8304KV00mv7yh2J9"
            );
        },
        methods: {
            getCustomerPaymentMethods: function () {
                SubscriptionService.getPaymentMethods()
                    .then((result) => {
                        const data = result.data.data || [];
                        if (data.length > 0) this.paymentMethods = data;
                    })
                    .catch((error) => console.log(error))
                    .finally(() => {
                        this.loading = false;
                    });
            },
           async prepareCardAdd(){
                this.purchase =true;
                const elements = await this.stripe.elements();
                this.cardElement = elements.create('card', {});
                this.cardElement.mount('#card-element');
            },
            async processPayment() {
                this.paymentProcessing = true;
                this.customer.card = this.paymentCard;
                this.customer.package_id = this.plan.id;
                this.customer.type = this.plan.type;
                SubscriptionService.createSubscription(this.customer)
                    .then((result) => {
                        this.paymentProcessing = false;
                        console.log(result);
                    })
                    .catch((error) => {
                        this.paymentProcessing = false;
                        this.error = true;
                        console.log(error);
                    });
            },
            async addPaymentMethodCard() {
                 let result = await this.stripe.createToken(this.cardElement);
                 this.token = result.token;
                 const data = {
                     first_name: this.firstName,
                     last_name: this.lastName,
                     token: this.token,
                 };
                 SubscriptionService.addPaymentMethod(data)
                     .then((result) => {
                         console.log(result);
                         this.cardSource = true;
                         this.getCustomerPaymentMethods();
                     })
                     .catch((error) => console.log(error));
             },
             async chooseCard(card) {
                 this.paymentCard = card;
                 this.purchase = false;
             }
        },
        created() {
            this.loading = true;
            this.getCustomerPaymentMethods();
        },
    }
</script>