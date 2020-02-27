Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8C14172A21
	for <lists+dmaengine@lfdr.de>; Thu, 27 Feb 2020 22:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729975AbgB0V3m (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 27 Feb 2020 16:29:42 -0500
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:30029 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgB0V3l (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 27 Feb 2020 16:29:41 -0500
Received: from [192.168.1.41] ([92.140.213.100])
        by mwinf5d87 with ME
        id 7xVW220022AY1JL03xVdgM; Thu, 27 Feb 2020 22:29:38 +0100
X-ME-Helo: [192.168.1.41]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 27 Feb 2020 22:29:38 +0100
X-ME-IP: 92.140.213.100
Subject: Re: [PATCH] dmaengine: Simplify error handling path in
 '__dma_async_device_channel_register()'
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     dan.j.williams@intel.com, vkoul@kernel.org, dave.jiang@intel.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20200226090707.12285-1-christophe.jaillet@wanadoo.fr>
 <20200226100112.GD3286@kadam>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <3483bb10-a7f7-2bc0-b1e8-e79e84db54ab@wanadoo.fr>
Date:   Thu, 27 Feb 2020 22:29:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200226100112.GD3286@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

Thanks Dan for the additional comments.
However, their are to much things that I won't be able to test my self.

So unfortunately, I won't feel comfortable enough for a V2 with all your 
suggestions.
Please, you, or anybody else, go ahead and propose the corresponding fixes.

CJ


Le 26/02/2020 à 11:01, Dan Carpenter a écrit :
> On Wed, Feb 26, 2020 at 10:07:07AM +0100, Christophe JAILLET wrote:
>> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
>> index c3b1283b6d31..6bb6e88c6019 100644
>> --- a/drivers/dma/dmaengine.c
>> +++ b/drivers/dma/dmaengine.c
>> @@ -978,11 +978,8 @@ static int __dma_async_device_channel_register(struct dma_device *device,
>>   	if (!chan->local)
>>   		goto err_out;
>>   	chan->dev = kzalloc(sizeof(*chan->dev), GFP_KERNEL);
>> -	if (!chan->dev) {
>> -		free_percpu(chan->local);
>> -		chan->local = NULL;
>> +	if (!chan->dev)
>>   		goto err_out;
>> -	}
>>   
>>   	/*
>>   	 * When the chan_id is a negative value, we are dynamically adding
>> @@ -1008,6 +1005,7 @@ static int __dma_async_device_channel_register(struct dma_device *device,
>>   
>>    err_out:
> Rule of thumb:  If the error label is "err" or "out" it's probably
> going to be buggy.  This code is free everything style error handling.
> We hit an error so something were allocated and some were not.  It's
> always complicated to undo things which we didn't do.
>
>>   	free_percpu(chan->local);
>> +	chan->local = NULL;
>>   	kfree(chan->dev);
>>   	if (atomic_dec_return(idr_ref) == 0)
>>   		kfree(idr_ref);
> The ref counting on "idr_ref" is also wrong.
>
>     967
>     968          if (tchan->dev) {
>     969                  idr_ref = tchan->dev->idr_ref;
>                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> This is 1+ references.  We don't increment it.
>
>     970          } else {
>     971                  idr_ref = kmalloc(sizeof(*idr_ref), GFP_KERNEL);
>     972                  if (!idr_ref)
>     973                          return -ENOMEM;
>     974                  atomic_set(idr_ref, 0);
>                          ^^^^^^^^^^^^^^^^^^^^^^
> This is 0 references (Wrong.  Everything starts with 1 reference).
>
>     975          }
>     976
>     977          chan->local = alloc_percpu(typeof(*chan->local));
>     978          if (!chan->local)
>     979                  goto err_out;
>     980          chan->dev = kzalloc(sizeof(*chan->dev), GFP_KERNEL);
>     981          if (!chan->dev) {
>     982                  free_percpu(chan->local);
>     983                  chan->local = NULL;
>     984                  goto err_out;
>     985          }
>     986
>     987          /*
>     988           * When the chan_id is a negative value, we are dynamically adding
>     989           * the channel. Otherwise we are static enumerating.
>     990           */
>     991          chan->chan_id = chan_id < 0 ? chancnt : chan_id;
>     992          chan->dev->device.class = &dma_devclass;
>     993          chan->dev->device.parent = device->dev;
>     994          chan->dev->chan = chan;
>     995          chan->dev->idr_ref = idr_ref;
>     996          chan->dev->dev_id = device->dev_id;
>     997          atomic_inc(idr_ref);
>                  ^^^^^^^^^^^^^^^^^^^
> Probably if device_register() fails we don't want to free idr_ref, it
> should instead be handled by device_put().
>
>     998          dev_set_name(&chan->dev->device, "dma%dchan%d",
>     999                       device->dev_id, chan->chan_id);
>    1000
>    1001          rc = device_register(&chan->dev->device);
>    1002          if (rc)
>    1003                  goto err_out;
>    1004          chan->client_count = 0;
>    1005          device->chancnt = chan->chan_id + 1;
>    1006
>    1007          return 0;
>    1008
>    1009   err_out:
>    1010          free_percpu(chan->local);
>    1011          kfree(chan->dev);
>    1012          if (atomic_dec_return(idr_ref) == 0)
>    1013                  kfree(idr_ref);
>
> If alloc_percpu() fails this is decrementing something which was never
> incremented.  That's the classic error of trying to undo things which we
> didnt do.
>
> Presumably here we only want to free if we allocated the "idr_ref"
> ourselves.  atomic_dec_return() returns the new reference count after
> the decrement so on most paths it's going to be -1 which is a leak and
> on the other paths there is a chance that it's going to lead to a use
> after free.  There is no situation where this will do the correct thing.
>
> Probably the cleanest fix it to just move the idr_ref allocation after
> the other allocations so that we always rely on device_register() to
> handle the clean ups.
>
>    1014          return rc;
>    1015  }
>
> regards,
> dan carpenter
>
>

