Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32383216629
	for <lists+dmaengine@lfdr.de>; Tue,  7 Jul 2020 08:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgGGGF2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Jul 2020 02:05:28 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36620 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgGGGF2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Jul 2020 02:05:28 -0400
Received: by mail-ed1-f68.google.com with SMTP id dg28so37360844edb.3;
        Mon, 06 Jul 2020 23:05:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Z1+PuVigojbXMwk+wz+wz2DIPJDnuhHnRRpGmoxoap8=;
        b=tF5q6mhU3hh5q02qVc8QUk0y07iZ/IuvcD0rw+9lCLGoMY5+WWFlW/hvTjjRAddXjK
         5DraJ7cOx8Aq2+aMq6gqd2BTq8+OvnEMUln+/PGdW7VbMusa0+j68LKllEXkUGEvwZAM
         Ja9mO41GC/gQAORYFP74CaMq7UoMzrdOWZmbKW3ivqs8q8N99hl8xJU/enzNc+bRlX6l
         52k4VMpgoHc8CiOoCmihwiSPy2jmYiuZMGXDWN2+Mjize7KAZ4NztR5IjXcScaCTNHEM
         2eiFOi3jd6buWIPA9eFGSO4P036X7wLbCAIMPGHb2TVUj4YjGtC/KLizWQMkXvEksu2o
         JCbA==
X-Gm-Message-State: AOAM532Fu5NaqOo1HXlaSgtrDbxvQSHnOU2Va4iWIdxaclqppbdbGztx
        JsaZ8E8ksoIooWMGoOz5YFUDX9Do
X-Google-Smtp-Source: ABdhPJz6BYto8F6w1V28U5u6BUGNgmmTURwFrCZgqLxgT8vqheyaqLdFxfTbftwtFpGhwl6F/6xrQg==
X-Received: by 2002:a50:da83:: with SMTP id q3mr61791883edj.325.1594101923788;
        Mon, 06 Jul 2020 23:05:23 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id yj16sm14542951ejb.122.2020.07.06.23.05.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2020 23:05:23 -0700 (PDT)
Subject: Re: [PATCH v2] dmaengine: check device and channel list for empty
To:     Dave Jiang <dave.jiang@intel.com>, vkoul@kernel.org
Cc:     Swathi Kovvuri <swathi.kovvuri@intel.com>,
        dmaengine@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <159319496403.69045.16298280729899651363.stgit@djiang5-desk3.ch.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <ea3ef860-0b7a-e8da-8cf9-5930a8f3b7ed@kernel.org>
Date:   Tue, 7 Jul 2020 08:05:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <159319496403.69045.16298280729899651363.stgit@djiang5-desk3.ch.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 26. 06. 20, 20:09, Dave Jiang wrote:
> Check dma device list and channel list for empty before iterate as the
> iteration function assume the list to be not empty. With devices and
> channels now being hot pluggable this is a condition that needs to be
> checked. Otherwise it can cause the iterator to spin forever.

Could you be a little bit more specific how this can spin forever? I.e.
can you attach a stacktrace of such a behaviour?

As in the empty case, "&pos->member" is "head" (look into
list_for_each_entry) and the for loop should loop exactly zero times.

> Fixes: e81274cd6b52 ("dmaengine: add support to dynamic register/unregister of channels")
> Reported-by: Swathi Kovvuri <swathi.kovvuri@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Tested-by: Swathi Kovvuri <swathi.kovvuri@intel.com>
> ---
> 
> Rebased to dmaengine next tree
> 
>  drivers/dma/dmaengine.c |  119 +++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 94 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index 2b06a7a8629d..0d6529eff66f 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -85,6 +85,9 @@ static void dmaengine_dbg_summary_show(struct seq_file *s,
>  {
>  	struct dma_chan *chan;
>  
> +	if (list_empty(&dma_dev->channels))
> +		return;
> +
>  	list_for_each_entry(chan, &dma_dev->channels, device_node) {
>  		if (chan->client_count) {
>  			seq_printf(s, " %-13s| %s", dma_chan_name(chan),
> @@ -104,6 +107,11 @@ static int dmaengine_summary_show(struct seq_file *s, void *data)
>  	struct dma_device *dma_dev = NULL;
>  
>  	mutex_lock(&dma_list_mutex);
> +	if (list_empty(&dma_device_list)) {
> +		mutex_unlock(&dma_list_mutex);
> +		return 0;
> +	}
> +
>  	list_for_each_entry(dma_dev, &dma_device_list, global_node) {
>  		seq_printf(s, "dma%d (%s): number of channels: %u\n",
>  			   dma_dev->dev_id, dev_name(dma_dev->dev),
> @@ -324,10 +332,15 @@ static struct dma_chan *min_chan(enum dma_transaction_type cap, int cpu)
>  	struct dma_chan *min = NULL;
>  	struct dma_chan *localmin = NULL;
>  
> +	if (list_empty(&dma_device_list))
> +		return NULL;
> +
>  	list_for_each_entry(device, &dma_device_list, global_node) {
>  		if (!dma_has_cap(cap, device->cap_mask) ||
>  		    dma_has_cap(DMA_PRIVATE, device->cap_mask))
>  			continue;
> +		if (list_empty(&device->channels))
> +			continue;
>  		list_for_each_entry(chan, &device->channels, device_node) {
>  			if (!chan->client_count)
>  				continue;
> @@ -365,6 +378,9 @@ static void dma_channel_rebalance(void)
>  	int cpu;
>  	int cap;
>  
> +	if (list_empty(&dma_device_list))
> +		return;
> +
>  	/* undo the last distribution */
>  	for_each_dma_cap_mask(cap, dma_cap_mask_all)
>  		for_each_possible_cpu(cpu)
> @@ -373,6 +389,8 @@ static void dma_channel_rebalance(void)
>  	list_for_each_entry(device, &dma_device_list, global_node) {
>  		if (dma_has_cap(DMA_PRIVATE, device->cap_mask))
>  			continue;
> +		if (list_empty(&device->channels))
> +			continue;
>  		list_for_each_entry(chan, &device->channels, device_node)
>  			chan->table_count = 0;
>  	}
> @@ -556,6 +574,10 @@ void dma_issue_pending_all(void)
>  	struct dma_chan *chan;
>  
>  	rcu_read_lock();
> +	if (list_empty(&dma_device_list)) {
> +		rcu_read_unlock();
> +		return;
> +	}
>  	list_for_each_entry_rcu(device, &dma_device_list, global_node) {
>  		if (dma_has_cap(DMA_PRIVATE, device->cap_mask))
>  			continue;
> @@ -613,6 +635,10 @@ static struct dma_chan *private_candidate(const dma_cap_mask_t *mask,
>  		dev_dbg(dev->dev, "%s: wrong capabilities\n", __func__);
>  		return NULL;
>  	}
> +
> +	if (list_empty(&dev->channels))
> +		return NULL;
> +
>  	/* devices with multiple channels need special handling as we need to
>  	 * ensure that all channels are either private or public.
>  	 */
> @@ -749,6 +775,11 @@ struct dma_chan *__dma_request_channel(const dma_cap_mask_t *mask,
>  
>  	/* Find a channel */
>  	mutex_lock(&dma_list_mutex);
> +	if (list_empty(&dma_device_list)) {
> +		mutex_unlock(&dma_list_mutex);
> +		return NULL;
> +	}
> +
>  	list_for_each_entry_safe(device, _d, &dma_device_list, global_node) {
>  		/* Finds a DMA controller with matching device node */
>  		if (np && device->dev->of_node && np != device->dev->of_node)
> @@ -819,6 +850,11 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
>  
>  	/* Try to find the channel via the DMA filter map(s) */
>  	mutex_lock(&dma_list_mutex);
> +	if (list_empty(&dma_device_list)) {
> +		mutex_unlock(&dma_list_mutex);
> +		return NULL;
> +	}
> +
>  	list_for_each_entry_safe(d, _d, &dma_device_list, global_node) {
>  		dma_cap_mask_t mask;
>  		const struct dma_slave_map *map = dma_filter_match(d, name, dev);
> @@ -942,10 +978,17 @@ void dmaengine_get(void)
>  	mutex_lock(&dma_list_mutex);
>  	dmaengine_ref_count++;
>  
> +	if (list_empty(&dma_device_list)) {
> +		mutex_unlock(&dma_list_mutex);
> +		return;
> +	}
> +
>  	/* try to grab channels */
>  	list_for_each_entry_safe(device, _d, &dma_device_list, global_node) {
>  		if (dma_has_cap(DMA_PRIVATE, device->cap_mask))
>  			continue;
> +		if (list_empty(&device->channels))
> +			continue;
>  		list_for_each_entry(chan, &device->channels, device_node) {
>  			err = dma_chan_get(chan);
>  			if (err == -ENODEV) {
> @@ -980,10 +1023,17 @@ void dmaengine_put(void)
>  	mutex_lock(&dma_list_mutex);
>  	dmaengine_ref_count--;
>  	BUG_ON(dmaengine_ref_count < 0);
> +	if (list_empty(&dma_device_list)) {
> +		mutex_unlock(&dma_list_mutex);
> +		return;
> +	}
> +
>  	/* drop channel references */
>  	list_for_each_entry_safe(device, _d, &dma_device_list, global_node) {
>  		if (dma_has_cap(DMA_PRIVATE, device->cap_mask))
>  			continue;
> +		if (list_empty(&device->channels))
> +			continue;
>  		list_for_each_entry(chan, &device->channels, device_node)
>  			dma_chan_put(chan);
>  	}
> @@ -1132,6 +1182,39 @@ void dma_async_device_channel_unregister(struct dma_device *device,
>  }
>  EXPORT_SYMBOL_GPL(dma_async_device_channel_unregister);
>  
> +static int dma_channel_enumeration(struct dma_device *device)
> +{
> +	struct dma_chan *chan;
> +	int rc;
> +
> +	if (list_empty(&device->channels))
> +		return 0;
> +
> +	/* represent channels in sysfs. Probably want devs too */
> +	list_for_each_entry(chan, &device->channels, device_node) {
> +		rc = __dma_async_device_channel_register(device, chan);
> +		if (rc < 0)
> +			return rc;
> +	}
> +
> +	/* take references on public channels */
> +	if (dmaengine_ref_count && !dma_has_cap(DMA_PRIVATE, device->cap_mask))
> +		list_for_each_entry(chan, &device->channels, device_node) {
> +			/* if clients are already waiting for channels we need
> +			 * to take references on their behalf
> +			 */
> +			if (dma_chan_get(chan) == -ENODEV) {
> +				/* note we can only get here for the first
> +				 * channel as the remaining channels are
> +				 * guaranteed to get a reference
> +				 */
> +				return -ENODEV;
> +			}
> +		}
> +
> +	return 0;
> +}
> +
>  /**
>   * dma_async_device_register - registers DMA devices found
>   * @device:	pointer to &struct dma_device
> @@ -1247,33 +1330,15 @@ int dma_async_device_register(struct dma_device *device)
>  	if (rc != 0)
>  		return rc;
>  
> +	mutex_lock(&dma_list_mutex);
>  	mutex_init(&device->chan_mutex);
>  	ida_init(&device->chan_ida);
> -
> -	/* represent channels in sysfs. Probably want devs too */
> -	list_for_each_entry(chan, &device->channels, device_node) {
> -		rc = __dma_async_device_channel_register(device, chan);
> -		if (rc < 0)
> -			goto err_out;
> +	rc = dma_channel_enumeration(device);
> +	if (rc < 0) {
> +		mutex_unlock(&dma_list_mutex);
> +		goto err_out;
>  	}
>  
> -	mutex_lock(&dma_list_mutex);
> -	/* take references on public channels */
> -	if (dmaengine_ref_count && !dma_has_cap(DMA_PRIVATE, device->cap_mask))
> -		list_for_each_entry(chan, &device->channels, device_node) {
> -			/* if clients are already waiting for channels we need
> -			 * to take references on their behalf
> -			 */
> -			if (dma_chan_get(chan) == -ENODEV) {
> -				/* note we can only get here for the first
> -				 * channel as the remaining channels are
> -				 * guaranteed to get a reference
> -				 */
> -				rc = -ENODEV;
> -				mutex_unlock(&dma_list_mutex);
> -				goto err_out;
> -			}
> -		}
>  	list_add_tail_rcu(&device->global_node, &dma_device_list);
>  	if (dma_has_cap(DMA_PRIVATE, device->cap_mask))
>  		device->privatecnt++;	/* Always private */
> @@ -1291,6 +1356,9 @@ int dma_async_device_register(struct dma_device *device)
>  		return rc;
>  	}
>  
> +	if (list_empty(&device->channels))
> +		return rc;
> +
>  	list_for_each_entry(chan, &device->channels, device_node) {
>  		if (chan->local == NULL)
>  			continue;
> @@ -1317,8 +1385,9 @@ void dma_async_device_unregister(struct dma_device *device)
>  
>  	dmaengine_debug_unregister(device);
>  
> -	list_for_each_entry_safe(chan, n, &device->channels, device_node)
> -		__dma_async_device_channel_unregister(device, chan);
> +	if (!list_empty(&device->channels))
> +		list_for_each_entry_safe(chan, n, &device->channels, device_node)
> +			__dma_async_device_channel_unregister(device, chan);
>  
>  	mutex_lock(&dma_list_mutex);
>  	/*



-- 
js
suse labs
