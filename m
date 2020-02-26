Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9F916FB8B
	for <lists+dmaengine@lfdr.de>; Wed, 26 Feb 2020 11:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgBZKB3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 26 Feb 2020 05:01:29 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:48458 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgBZKB3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 26 Feb 2020 05:01:29 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01Q9s0Sc088844;
        Wed, 26 Feb 2020 10:01:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=ZD1D7OK36Baxe2flMIUpBNb6dJD27LTf4KKg278bZ8E=;
 b=ACBfps/7o83K1BXZtBKJBTejc9ckPoNmFaH4aOJHfPWMwp+ijPDkrcCJcJ4P2JbmalQh
 7Bbyx5ny6j0ulfY4MyAjwzXBc33iyGyrnnNN1/47BSpJFn8bahczWQLRr8NJPdrGeN8h
 54B3AaL8A5krrHDatu9xJT2z64ag5VmhUuMbTTg9NluJuwFOCMC7fVNHPj/xcxwe6Six
 vXmsxcCDSbF2WIW0AL3J+yzD2eAvcQmcGtQLLLPmFPGmCRRc6to1jUJZZvirTk1mRN3r
 ERixcYgeyGlZ/m1ASrccfyYP5Ge5YTJEDIHCWMSQlrh/HiEoHNOcNB33jnNzAkA/hSJQ Dg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2ydcsrje9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Feb 2020 10:01:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01Q9q4Ke184421;
        Wed, 26 Feb 2020 10:01:24 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2ydj4h3yuf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Feb 2020 10:01:24 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01QA1MtD015851;
        Wed, 26 Feb 2020 10:01:23 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Feb 2020 02:01:22 -0800
Date:   Wed, 26 Feb 2020 13:01:12 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     dan.j.williams@intel.com, vkoul@kernel.org, dave.jiang@intel.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] dmaengine: Simplify error handling path in
 '__dma_async_device_channel_register()'
Message-ID: <20200226100112.GD3286@kadam>
References: <20200226090707.12285-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226090707.12285-1-christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9542 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=2
 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002260074
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9542 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 suspectscore=2
 bulkscore=0 malwarescore=0 spamscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002260074
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Feb 26, 2020 at 10:07:07AM +0100, Christophe JAILLET wrote:
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index c3b1283b6d31..6bb6e88c6019 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -978,11 +978,8 @@ static int __dma_async_device_channel_register(struct dma_device *device,
>  	if (!chan->local)
>  		goto err_out;
>  	chan->dev = kzalloc(sizeof(*chan->dev), GFP_KERNEL);
> -	if (!chan->dev) {
> -		free_percpu(chan->local);
> -		chan->local = NULL;
> +	if (!chan->dev)
>  		goto err_out;
> -	}
>  
>  	/*
>  	 * When the chan_id is a negative value, we are dynamically adding
> @@ -1008,6 +1005,7 @@ static int __dma_async_device_channel_register(struct dma_device *device,
>  
>   err_out:

Rule of thumb:  If the error label is "err" or "out" it's probably
going to be buggy.  This code is free everything style error handling.
We hit an error so something were allocated and some were not.  It's
always complicated to undo things which we didn't do.

>  	free_percpu(chan->local);
> +	chan->local = NULL;
>  	kfree(chan->dev);
>  	if (atomic_dec_return(idr_ref) == 0)
>  		kfree(idr_ref);

The ref counting on "idr_ref" is also wrong.

   967  
   968          if (tchan->dev) {
   969                  idr_ref = tchan->dev->idr_ref;
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This is 1+ references.  We don't increment it.

   970          } else {
   971                  idr_ref = kmalloc(sizeof(*idr_ref), GFP_KERNEL);
   972                  if (!idr_ref)
   973                          return -ENOMEM;
   974                  atomic_set(idr_ref, 0);
                        ^^^^^^^^^^^^^^^^^^^^^^
This is 0 references (Wrong.  Everything starts with 1 reference).

   975          }
   976  
   977          chan->local = alloc_percpu(typeof(*chan->local));
   978          if (!chan->local)
   979                  goto err_out;
   980          chan->dev = kzalloc(sizeof(*chan->dev), GFP_KERNEL);
   981          if (!chan->dev) {
   982                  free_percpu(chan->local);
   983                  chan->local = NULL;
   984                  goto err_out;
   985          }
   986  
   987          /*
   988           * When the chan_id is a negative value, we are dynamically adding
   989           * the channel. Otherwise we are static enumerating.
   990           */
   991          chan->chan_id = chan_id < 0 ? chancnt : chan_id;
   992          chan->dev->device.class = &dma_devclass;
   993          chan->dev->device.parent = device->dev;
   994          chan->dev->chan = chan;
   995          chan->dev->idr_ref = idr_ref;
   996          chan->dev->dev_id = device->dev_id;
   997          atomic_inc(idr_ref);
                ^^^^^^^^^^^^^^^^^^^
Probably if device_register() fails we don't want to free idr_ref, it
should instead be handled by device_put().

   998          dev_set_name(&chan->dev->device, "dma%dchan%d",
   999                       device->dev_id, chan->chan_id);
  1000  
  1001          rc = device_register(&chan->dev->device);
  1002          if (rc)
  1003                  goto err_out;
  1004          chan->client_count = 0;
  1005          device->chancnt = chan->chan_id + 1;
  1006  
  1007          return 0;
  1008  
  1009   err_out:
  1010          free_percpu(chan->local);
  1011          kfree(chan->dev);
  1012          if (atomic_dec_return(idr_ref) == 0)
  1013                  kfree(idr_ref);

If alloc_percpu() fails this is decrementing something which was never
incremented.  That's the classic error of trying to undo things which we
didnt do.

Presumably here we only want to free if we allocated the "idr_ref"
ourselves.  atomic_dec_return() returns the new reference count after
the decrement so on most paths it's going to be -1 which is a leak and
on the other paths there is a chance that it's going to lead to a use
after free.  There is no situation where this will do the correct thing.

Probably the cleanest fix it to just move the idr_ref allocation after
the other allocations so that we always rely on device_register() to
handle the clean ups.

  1014          return rc;
  1015  }

regards,
dan carpenter

