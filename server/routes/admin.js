const espress = require('express');
const adminRoute=espress.Router();
const admin =require('../midddlewares/admi');
const {Product} = require('../models/product');
const User = require('../models/user');
const Order=require('../models/order');
const e = require('express');
const { PromiseProvider } = require('mongoose');

adminRoute.post("/admin/add-product",admin,async (req,res)=>{
  
  try{
    const {name,description, images, quantity, price, category}=req.body;

    let product =new Product({
        name,
        description,
        images,
        quantity,
        price,
        category,
    });

    product =await product.save();
    res.json(product);


  }catch (e){
    res.status(500).json({error: e.message});
  }

});

adminRoute.get('/admin/get-product',admin,async(req,res)=>{
 
  try{
 product=await Product.find({});
 res.json(product);

  } catch (e){
      res.status(500).json({error: e.message});
     
  }
});

adminRoute.post('/admin/delete-product',admin, async (req,res)=>{

  try{
   const {id}=req.body;
   let product= await Product.findByIdAndDelete(id);
   res.send('All went weell');
   
  }catch (e){
    res.status(500).json({error: e.message});
  }
});
adminRoute.get('/admin/get-order',admin,async(req,res)=>{
 
  try{
 let orders=await Order.find({});
 res.json(orders);

  } catch (e){
      res.status(500).json({error: e.message});
     
  }
});

adminRoute.post('/admin/change_orde-status',admin, async (req,res)=>{

  try{
   const {id, status}=req.body;
   let order= await Order.findById(id);
   order.status=status;
   order= await order.save();
   res.json(order);
   
  }catch (e){
    res.status(500).json({error: e.message});
  }
});

adminRoute.get('/admin/analytics',admin,async(req,res)=>{
  try{ 

    let orders=await Order.find({});
    let totalEraning=0;
  
    for(let i=0;i<orders.length;i++){
      for(let j=0;j<orders[i].products.length;j++){
        totalEraning+=orders[i].products[j].quantity * orders[i].products[j].product.price;
      }
    } 
    let modilesEarning = await fetchCategoryWiseProduct('Mobiles'); 
    let essentialsEarning = await fetchCategoryWiseProduct('Essentials'); 
    let booksarning = await fetchCategoryWiseProduct('Books');
    let fashionEarning = await fetchCategoryWiseProduct('Fashion');

    let earnings={
      totalEraning,
      modilesEarning,
      essentialsEarning,
      booksarning,
      fashionEarning,
    }

    res.json(earnings);

  }catch (e){
    res.status(500).json({error: e.message});
  }
});

async function fetchCategoryWiseProduct(category){
  let earnings=0;
  let categoryOrdes=await Order.find({'products.product.category':category});
  for(let i=0;i<categoryOrdes.length;i++){
    for(let j=0;j<categoryOrdes[i].products.length;j++){
      earnings+=categoryOrdes[i].products[j].quantity * categoryOrdes[i].products[j].product.price;
    }
  }  
return earnings;
}

module.exports=adminRoute;