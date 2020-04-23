Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD20C1B5D73
	for <lists+dmaengine@lfdr.de>; Thu, 23 Apr 2020 16:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgDWORy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Apr 2020 10:17:54 -0400
Received: from mga09.intel.com ([134.134.136.24]:41075 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727037AbgDWORx (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 23 Apr 2020 10:17:53 -0400
IronPort-SDR: 8GGpDQ/YIF6AXY/+uSOhO/s0RMRzK6aUoDThrnWe6bPPYcaMTXvNmCinle7U4aRwWFvsB2KV7f
 Mi3un0xxMnpg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2020 07:17:53 -0700
IronPort-SDR: NOQYTzDwYIQSGVNll33ldBdM0LenKMnyypmLhML6gqlF8MAz8pKXN5TVcb2hM9Rv3HLcPOJwZJ
 6riap+CChoXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,307,1583222400"; 
   d="scan'208";a="456923832"
Received: from jamancin-mobl.amr.corp.intel.com (HELO [10.209.98.49]) ([10.209.98.49])
  by fmsmga005.fm.intel.com with ESMTP; 23 Apr 2020 07:17:52 -0700
Subject: Re: [PATCH] dmaengine: fix channel index enumeration
From:   Dave Jiang <dave.jiang@intel.com>
To:     "vkoul@kernel.org" <vkoul@kernel.org>
Cc:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
References: <158679961260.7674.8485924270472851852.stgit@djiang5-desk3.ch.intel.com>
Message-ID: <58fbb46c-5a54-c4b8-e4b7-3921c4d7fe9e@intel.com>
Date:   Thu, 23 Apr 2020 07:17:51 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <158679961260.7674.8485924270472851852.stgit@djiang5-desk3.ch.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 4/13/2020 10:40 AM, Jiang, Dave wrote:
> When the channel register code was changed to allow hotplug operations,
> dynamic indexing wasn't taken into account. When channels are randomly
> plugged and unplugged out of order, the serial indexing breaks. Convert
> channel indexing to using IDA tracking in order to allow dynamic
> assignment. The previous code does not cause any regression bug for
> existing channel allocation besides idxd driver since the hotplug usage
> case is only used by idxd at this point.
> 
> With this change, the chan->idr_ref is also not needed any longer. We can
> have a device with no channels registered due to hot plug. The channel
> device release code no longer should attempt to free the dma device id on
> the last channel release.

Hi Vinod, just checking to see if you had time to look at this patch 
yet. Thanks.

> 
> Fixes: e81274cd6b52 ("dmaengine: add support to dynamic register/unregister of channels")
> 
> Reported-by: Yixin Zhang <yixin.zhang@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Tested-by: Yixin Zhang <yixin.zhang@intel.com>
> ---
>   drivers/dma/dmaengine.c   |   60 ++++++++++++++++++++-------------------------
>   include/linux/dmaengine.h |    4 ++-
>   2 files changed, 28 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index 72c584f1dd26..e341f8d7ae62 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -151,10 +151,6 @@ static void chan_dev_release(struct device *dev)
>   	struct dma_chan_dev *chan_dev;
>   
>   	chan_dev = container_of(dev, typeof(*chan_dev), device);
> -	if (atomic_dec_and_test(chan_dev->idr_ref)) {
> -		ida_free(&dma_ida, chan_dev->dev_id);
> -		kfree(chan_dev->idr_ref);
> -	}
>   	kfree(chan_dev);
>   }
>   
> @@ -952,27 +948,9 @@ static int get_dma_id(struct dma_device *device)
>   }
>   
>   static int __dma_async_device_channel_register(struct dma_device *device,
> -					       struct dma_chan *chan,
> -					       int chan_id)
> +					       struct dma_chan *chan)
>   {
>   	int rc = 0;
> -	int chancnt = device->chancnt;
> -	atomic_t *idr_ref;
> -	struct dma_chan *tchan;
> -
> -	tchan = list_first_entry_or_null(&device->channels,
> -					 struct dma_chan, device_node);
> -	if (!tchan)
> -		return -ENODEV;
> -
> -	if (tchan->dev) {
> -		idr_ref = tchan->dev->idr_ref;
> -	} else {
> -		idr_ref = kmalloc(sizeof(*idr_ref), GFP_KERNEL);
> -		if (!idr_ref)
> -			return -ENOMEM;
> -		atomic_set(idr_ref, 0);
> -	}
>   
>   	chan->local = alloc_percpu(typeof(*chan->local));
>   	if (!chan->local)
> @@ -988,29 +966,36 @@ static int __dma_async_device_channel_register(struct dma_device *device,
>   	 * When the chan_id is a negative value, we are dynamically adding
>   	 * the channel. Otherwise we are static enumerating.
>   	 */
> -	chan->chan_id = chan_id < 0 ? chancnt : chan_id;
> +	mutex_lock(&device->chan_mutex);
> +	chan->chan_id = ida_alloc(&device->chan_ida, GFP_KERNEL);
> +	mutex_unlock(&device->chan_mutex);
> +	if (chan->chan_id < 0) {
> +		pr_err("%s: unable to alloc ida for chan: %d\n",
> +		       __func__, chan->chan_id);
> +		goto err_out;
> +	}
> +
>   	chan->dev->device.class = &dma_devclass;
>   	chan->dev->device.parent = device->dev;
>   	chan->dev->chan = chan;
> -	chan->dev->idr_ref = idr_ref;
>   	chan->dev->dev_id = device->dev_id;
> -	atomic_inc(idr_ref);
>   	dev_set_name(&chan->dev->device, "dma%dchan%d",
>   		     device->dev_id, chan->chan_id);
> -
>   	rc = device_register(&chan->dev->device);
>   	if (rc)
> -		goto err_out;
> +		goto err_out_ida;
>   	chan->client_count = 0;
> -	device->chancnt = chan->chan_id + 1;
> +	device->chancnt++;
>   
>   	return 0;
>   
> + err_out_ida:
> +	mutex_lock(&device->chan_mutex);
> +	ida_free(&device->chan_ida, chan->chan_id);
> +	mutex_unlock(&device->chan_mutex);
>    err_out:
>   	free_percpu(chan->local);
>   	kfree(chan->dev);
> -	if (atomic_dec_return(idr_ref) == 0)
> -		kfree(idr_ref);
>   	return rc;
>   }
>   
> @@ -1019,7 +1004,7 @@ int dma_async_device_channel_register(struct dma_device *device,
>   {
>   	int rc;
>   
> -	rc = __dma_async_device_channel_register(device, chan, -1);
> +	rc = __dma_async_device_channel_register(device, chan);
>   	if (rc < 0)
>   		return rc;
>   
> @@ -1039,6 +1024,9 @@ static void __dma_async_device_channel_unregister(struct dma_device *device,
>   	device->chancnt--;
>   	chan->dev->chan = NULL;
>   	mutex_unlock(&dma_list_mutex);
> +	mutex_lock(&device->chan_mutex);
> +	ida_free(&device->chan_ida, chan->chan_id);
> +	mutex_unlock(&device->chan_mutex);
>   	device_unregister(&chan->dev->device);
>   	free_percpu(chan->local);
>   }
> @@ -1061,7 +1049,7 @@ EXPORT_SYMBOL_GPL(dma_async_device_channel_unregister);
>    */
>   int dma_async_device_register(struct dma_device *device)
>   {
> -	int rc, i = 0;
> +	int rc;
>   	struct dma_chan* chan;
>   
>   	if (!device)
> @@ -1168,9 +1156,12 @@ int dma_async_device_register(struct dma_device *device)
>   	if (rc != 0)
>   		return rc;
>   
> +	mutex_init(&device->chan_mutex);
> +	ida_init(&device->chan_ida);
> +
>   	/* represent channels in sysfs. Probably want devs too */
>   	list_for_each_entry(chan, &device->channels, device_node) {
> -		rc = __dma_async_device_channel_register(device, chan, i++);
> +		rc = __dma_async_device_channel_register(device, chan);
>   		if (rc < 0)
>   			goto err_out;
>   	}
> @@ -1241,6 +1232,7 @@ void dma_async_device_unregister(struct dma_device *device)
>   	 */
>   	dma_cap_set(DMA_PRIVATE, device->cap_mask);
>   	dma_channel_rebalance();
> +	ida_free(&dma_ida, device->dev_id);
>   	dma_device_put(device);
>   	mutex_unlock(&dma_list_mutex);
>   }
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 3a43dbd5f615..e7419038d60f 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -337,13 +337,11 @@ struct dma_chan {
>    * @chan: driver channel device
>    * @device: sysfs device
>    * @dev_id: parent dma_device dev_id
> - * @idr_ref: reference count to gate release of dma_device dev_id
>    */
>   struct dma_chan_dev {
>   	struct dma_chan *chan;
>   	struct device device;
>   	int dev_id;
> -	atomic_t *idr_ref;
>   };
>   
>   /**
> @@ -846,6 +844,8 @@ struct dma_device {
>   	int dev_id;
>   	struct device *dev;
>   	struct module *owner;
> +	struct ida chan_ida;
> +	struct mutex chan_mutex;	/* to protect chan_ida */
>   
>   	u32 src_addr_widths;
>   	u32 dst_addr_widths;
> 
