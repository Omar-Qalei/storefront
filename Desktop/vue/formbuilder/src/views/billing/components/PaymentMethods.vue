<template >
    <div class="paymentMethods" :loading="loading" v-if="loading === false" >
        <v-row class="my-4">
            <v-col cols="4" v-for="paymentMethod in paymentMethods" :key="paymentMethod.id">
             <v-card class="mx-auto" max-width="350" outlined  elevation="5" >
                <v-list-item three-line>
                    <v-list-item-content>
                         <v-list-item-title class="headline mb-1"><v-img width="100" :lazy-src="paymentMethod.image" :src="paymentMethod.image"></v-img></v-list-item-title>
                       <v-list-item-subtitle> {{ paymentMethod.number }} | Expires {{ paymentMethod.expire }}</v-list-item-subtitle>
                       <v-list-item-subtitle> {{ paymentMethod.is_default }}</v-list-item-subtitle>
                    </v-list-item-content>
                    <v-list-item-avatar tile size="80"></v-list-item-avatar>
                </v-list-item> 
                <v-card-actions >
                    <v-btn  @click="removeDialog(paymentMethod)"   text>Remove</v-btn> 
                    <v-btn  v-if="paymentMethods.length > 1" @click="setAsDefault(paymentMethod)"   text>Set Default</v-btn> 
                </v-card-actions>
            </v-card>
            </v-col>
            <v-col cols="4"  @click="addDialogForm"><a>
             <v-card class="mx-auto" min-height="165" outlined  elevation="5" align="center" justify="center">
                <v-list-item three-line >
                    <v-list-item-content>
                      <v-list-item-title class="headline mb-1"><v-icon color="light-blue" class="my-5"  x-large>mdi-plus-circle</v-icon></v-list-item-title>
                       <v-list-item-subtitle> Add a Payment Method</v-list-item-subtitle>
                    </v-list-item-content>
                </v-list-item> 
            </v-card></a>
            </v-col>
        </v-row>
        <!-- delete payment method -->
        <v-dialog v-model="dialog" max-width="350"  >
            <v-card>
                <v-card-title class="text-h5">
                   Delete Payment Method
                </v-card-title>
                <v-card-text>
                    Are you Sure you want to delete ?
                </v-card-text>
                <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn color="gray darken-1" text>
                        Cancel
                    </v-btn>
                    <v-btn color="red darken-1" text  @click="removePaymentMethod()">
                        Delete
                    </v-btn>
                </v-card-actions>
            </v-card>
        </v-dialog>
        <!-- delete payment method  -->
        <!-- Add Payment Method -->
    <v-dialog v-model="addDialog" width="600">
        <v-card>
            <v-card-title class="text-h5 grey lighten-2">
                Add Payment Method
            </v-card-title>
                <v-card-text class="pa-5 border-bottom">
                <h2 class="title blue-grey--text text--darken-2 font-weight-regular">Card Details</h2>
                </v-card-text>
                <hr/>
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

            <v-divider></v-divider>

            <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn color="red" text @click="addDialog = false">
                    Cancel
                </v-btn>
                <v-btn color="primary" text @click="addPaymentMethodCard()">
                    Add
                </v-btn>
            </v-card-actions>
        </v-card>
    </v-dialog>
    <!-- Add Payment Method -->
    </div>
</template>

<script>
    import {
        loadStripe
    } from '@stripe/stripe-js';
    import {
        SubscriptionService
    } from "../../../services/billing/subscription.js"

    export default {
        name: "paymentMethods",
        data() {
            return {
                firstName:null,
                lastName:null,
                token:null,
                stripe: {},
                loading: true,
                dialog:false,
                addDialog:false,
                paymentMethods: [],
                selectedPayment:null,
                cardElement: {},
            };
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
            downloadInvoice: function (item) {
                window.open(item.url, '_blank');
            },
            async addDialogForm(){
                this.addDialog = true;
                this.stripe = await loadStripe("pk_test_51JG1ZOHSO2EOvWbReJEckSbfJb0TwrBVHCY8uqEvFRcxBDrGfzUvzkPeTAZxDtc4PsiysQLg9cxDQVswhb8304KV00mv7yh2J9");
                const elements = this.stripe.elements();
                this.cardElement = elements.create('card',{
                    style: {
                        base: {
                        iconColor: '#455a64',
                        color: '#455a64',
                        fontWeight: '500',
                        fontSize: '23px',
                        fontSmoothing: 'antialiased',
                        ':-webkit-autofill': {
                            color: '#455a64',
                        },
                        '::placeholder': {
                            color: '#455a64',
                        },
                        },
                        invalid: {
                        iconColor: '#455a64',
                        color: '#455a64x',
                        },
                    },
                    });
                this.cardElement.mount('#card-element');
            },
            removeDialog(paymentMethod){
                this.dialog = true;
                this.selectedPayment = paymentMethod;
            },
            setAsDefault(paymentMethod){
                SubscriptionService.setDefaultPaymentMethod(paymentMethod)
                    .then((result) => {
                        if(result.data.status == true){
                            this.paymentMethods = [];
                            this.getCustomerPaymentMethods();
                        }
                    })
                    .catch((error) => console.log(error));
            },
            removePaymentMethod: function () {
                if(this.selectedPayment){
                SubscriptionService.deletePaymentMethod(this.selectedPayment)
                    .then((result) => {
                        if(result.data.status == true){
                            this.paymentMethods = [];
                            this.getCustomerPaymentMethods();
                        }
                    })
                    .catch((error) => console.log(error));
                }
                this.dialog = false;
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
                         this.addDialog = false;
                         this.getCustomerPaymentMethods();
                     })
                     .catch((error) => console.log(error));
             },
        },
        created() {
            this.loading = true;
            this.getCustomerPaymentMethods();
        },
    };
</script>

<style></style>