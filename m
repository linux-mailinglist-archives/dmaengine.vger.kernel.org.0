Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1E52172A9
	for <lists+dmaengine@lfdr.de>; Tue,  7 Jul 2020 17:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbgGGPml (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Jul 2020 11:42:41 -0400
Received: from mga18.intel.com ([134.134.136.126]:25465 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbgGGPmk (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 7 Jul 2020 11:42:40 -0400
IronPort-SDR: tTzXGni9iTx0L+pr8uGfjrKDi/PSKQ6qkBMvP5eLDtmwHGjw999CTextBdZzDAqv0QMnYgw11j
 y0VguzYc6weQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="135093045"
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; 
   d="scan'208";a="135093045"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 08:42:38 -0700
IronPort-SDR: z8LPy+f+2p84GKIy4hdq61IbZZaaL/DOqWEPwYw2fILArWZIlrfgofrhKAegpvau/uIac8DS8J
 XmaF4nDq8zXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; 
   d="scan'208";a="322693231"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.176.45]) ([10.212.176.45])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Jul 2020 08:42:37 -0700
Subject: Re: [PATCH v2] dmaengine: check device and channel list for empty
To:     Jiri Slaby <jirislaby@kernel.org>, vkoul@kernel.org
Cc:     Swathi Kovvuri <swathi.kovvuri@intel.com>,
        dmaengine@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <159319496403.69045.16298280729899651363.stgit@djiang5-desk3.ch.intel.com>
 <ea3ef860-0b7a-e8da-8cf9-5930a8f3b7ed@kernel.org>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <b9e8f171-6961-b483-c698-18a89e58f361@intel.com>
Date:   Tue, 7 Jul 2020 08:42:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ea3ef860-0b7a-e8da-8cf9-5930a8f3b7ed@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 7/6/2020 11:05 PM, Jiri Slaby wrote:
> On 26. 06. 20, 20:09, Dave Jiang wrote:
>> Check dma device list and channel list for empty before iterate as the
>> iteration function assume the list to be not empty. With devices and
>> channels now being hot pluggable this is a condition that needs to be
>> checked. Otherwise it can cause the iterator to spin forever.
> 
> Could you be a little bit more specific how this can spin forever? I.e.
> can you attach a stacktrace of such a behaviour?

I can't seem to find the original splat that lead me to the conclusion of it's 
spinning forever. As I recall, the issue seems to produce different splats and 
not always consistent in being reproduced. Here's a partial splat that was 
tracked by the internal bug database. Since with the dma device and channel list 
being are hot added and removed, the device and channel lists can be empty. The 
list_entry() and friends expect the list to not be empty (according to header 
comment), I added the check to ensure that isn't the case before using them in 
dmaengine. With the fix, we can no longer produce any of the splats. So maybe 
the above was a bad description of the issue.

[ 4216.048375]  ? dma_channel_rebalance+0x7b/0x250
[ 4216.056360]  dma_async_device_register+0x349/0x3a0
[ 4216.064604]  idxd_register_dma_device+0x90/0xc0 [idxd]
[ 4216.073175]  idxd_config_bus_probe.cold+0x7d/0x1fc [idxd]
[ 4216.081988]  really_probe+0x159/0x3e0
[ 4216.088791]  driver_probe_device+0xbc/0x100
[ 4216.096138]  device_driver_attach+0x5d/0x70
[ 4216.103463]  bind_store+0xd3/0x110
[ 4216.109913]  drv_attr_store+0x24/0x30
[ 4216.116666]  sysfs_kf_write+0x3e/0x50
[ 4216.123390]  kernfs_fop_write+0xda/0x1b0
[ 4216.130354]  __vfs_write+0x1b/0x40
[ 4216.136661]  vfs_write+0xb9/0x1a0
[ 4216.142802]  ksys_write+0x67/0xe0
[ 4216.148844]  __x64_sys_write+0x1a/0x20
[ 4216.155289]  do_syscall_64+0x57/0x1d0
[ 4216.161642]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 4216.169603] RIP: 0033:0x7f4640339b1a
[ 4216.175918] Code: 48 c7 c0 ff ff ff ff eb be


> 
> As in the empty case, "&pos->member" is "head" (look into
> list_for_each_entry) and the for loop should loop exactly zero times.
> 
>> Fixes: e81274cd6b52 ("dmaengine: add support to dynamic register/unregister of channels")
>> Reported-by: Swathi Kovvuri <swathi.kovvuri@intel.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> Tested-by: Swathi Kovvuri <swathi.kovvuri@intel.com>
>> ---
>>
>> Rebased to dmaengine next tree
>>
>>   drivers/dma/dmaengine.c |  119 +++++++++++++++++++++++++++++++++++++----------
>>   1 file changed, 94 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
>> index 2b06a7a8629d..0d6529eff66f 100644
>> --- a/drivers/dma/dmaengine.c
>> +++ b/drivers/dma/dmaengine.c
>> @@ -85,6 +85,9 @@ static void dmaengine_dbg_summary_show(struct seq_file *s,
>>   {
>>   	struct dma_chan *chan;
>>   
>> +	if (list_empty(&dma_dev->channels))
>> +		return;
>> +
>>   	list_for_each_entry(chan, &dma_dev->channels, device_node) {
>>   		if (chan->client_count) {
>>   			seq_printf(s, " %-13s| %s", dma_chan_name(chan),
>> @@ -104,6 +107,11 @@ static int dmaengine_summary_show(struct seq_file *s, void *data)
>>   	struct dma_device *dma_dev = NULL;
>>   
>>   	mutex_lock(&dma_list_mutex);
>> +	if (list_empty(&dma_device_list)) {
>> +		mutex_unlock(&dma_list_mutex);
>> +		return 0;
>> +	}
>> +
>>   	list_for_each_entry(dma_dev, &dma_device_list, global_node) {
>>   		seq_printf(s, "dma%d (%s): number of channels: %u\n",
>>   			   dma_dev->dev_id, dev_name(dma_dev->dev),
>> @@ -324,10 +332,15 @@ static struct dma_chan *min_chan(enum dma_transaction_type cap, int cpu)
>>   	struct dma_chan *min = NULL;
>>   	struct dma_chan *localmin = NULL;
>>   
>> +	if (list_empty(&dma_device_list))
>> +		return NULL;
>> +
>>   	list_for_each_entry(device, &dma_device_list, global_node) {
>>   		if (!dma_has_cap(cap, device->cap_mask) ||
>>   		    dma_has_cap(DMA_PRIVATE, device->cap_mask))
>>   			continue;
>> +		if (list_empty(&device->channels))
>> +			continue;
>>   		list_for_each_entry(chan, &device->channels, device_node) {
>>   			if (!chan->client_count)
>>   				continue;
>> @@ -365,6 +378,9 @@ static void dma_channel_rebalance(void)
>>   	int cpu;
>>   	int cap;
>>   
>> +	if (list_empty(&dma_device_list))
>> +		return;
>> +
>>   	/* undo the last distribution */
>>   	for_each_dma_cap_mask(cap, dma_cap_mask_all)
>>   		for_each_possible_cpu(cpu)
>> @@ -373,6 +389,8 @@ static void dma_channel_rebalance(void)
>>   	list_for_each_entry(device, &dma_device_list, global_node) {
>>   		if (dma_has_cap(DMA_PRIVATE, device->cap_mask))
>>   			continue;
>> +		if (list_empty(&device->channels))
>> +			continue;
>>   		list_for_each_entry(chan, &device->channels, device_node)
>>   			chan->table_count = 0;
>>   	}
>> @@ -556,6 +574,10 @@ void dma_issue_pending_all(void)
>>   	struct dma_chan *chan;
>>   
>>   	rcu_read_lock();
>> +	if (list_empty(&dma_device_list)) {
>> +		rcu_read_unlock();
>> +		return;
>> +	}
>>   	list_for_each_entry_rcu(device, &dma_device_list, global_node) {
>>   		if (dma_has_cap(DMA_PRIVATE, device->cap_mask))
>>   			continue;
>> @@ -613,6 +635,10 @@ static struct dma_chan *private_candidate(const dma_cap_mask_t *mask,
>>   		dev_dbg(dev->dev, "%s: wrong capabilities\n", __func__);
>>   		return NULL;
>>   	}
>> +
>> +	if (list_empty(&dev->channels))
>> +		return NULL;
>> +
>>   	/* devices with multiple channels need special handling as we need to
>>   	 * ensure that all channels are either private or public.
>>   	 */
>> @@ -749,6 +775,11 @@ struct dma_chan *__dma_request_channel(const dma_cap_mask_t *mask,
>>   
>>   	/* Find a channel */
>>   	mutex_lock(&dma_list_mutex);
>> +	if (list_empty(&dma_device_list)) {
>> +		mutex_unlock(&dma_list_mutex);
>> +		return NULL;
>> +	}
>> +
>>   	list_for_each_entry_safe(device, _d, &dma_device_list, global_node) {
>>   		/* Finds a DMA controller with matching device node */
>>   		if (np && device->dev->of_node && np != device->dev->of_node)
>> @@ -819,6 +850,11 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
>>   
>>   	/* Try to find the channel via the DMA filter map(s) */
>>   	mutex_lock(&dma_list_mutex);
>> +	if (list_empty(&dma_device_list)) {
>> +		mutex_unlock(&dma_list_mutex);
>> +		return NULL;
>> +	}
>> +
>>   	list_for_each_entry_safe(d, _d, &dma_device_list, global_node) {
>>   		dma_cap_mask_t mask;
>>   		const struct dma_slave_map *map = dma_filter_match(d, name, dev);
>> @@ -942,10 +978,17 @@ void dmaengine_get(void)
>>   	mutex_lock(&dma_list_mutex);
>>   	dmaengine_ref_count++;
>>   
>> +	if (list_empty(&dma_device_list)) {
>> +		mutex_unlock(&dma_list_mutex);
>> +		return;
>> +	}
>> +
>>   	/* try to grab channels */
>>   	list_for_each_entry_safe(device, _d, &dma_device_list, global_node) {
>>   		if (dma_has_cap(DMA_PRIVATE, device->cap_mask))
>>   			continue;
>> +		if (list_empty(&device->channels))
>> +			continue;
>>   		list_for_each_entry(chan, &device->channels, device_node) {
>>   			err = dma_chan_get(chan);
>>   			if (err == -ENODEV) {
>> @@ -980,10 +1023,17 @@ void dmaengine_put(void)
>>   	mutex_lock(&dma_list_mutex);
>>   	dmaengine_ref_count--;
>>   	BUG_ON(dmaengine_ref_count < 0);
>> +	if (list_empty(&dma_device_list)) {
>> +		mutex_unlock(&dma_list_mutex);
>> +		return;
>> +	}
>> +
>>   	/* drop channel references */
>>   	list_for_each_entry_safe(device, _d, &dma_device_list, global_node) {
>>   		if (dma_has_cap(DMA_PRIVATE, device->cap_mask))
>>   			continue;
>> +		if (list_empty(&device->channels))
>> +			continue;
>>   		list_for_each_entry(chan, &device->channels, device_node)
>>   			dma_chan_put(chan);
>>   	}
>> @@ -1132,6 +1182,39 @@ void dma_async_device_channel_unregister(struct dma_device *device,
>>   }
>>   EXPORT_SYMBOL_GPL(dma_async_device_channel_unregister);
>>   
>> +static int dma_channel_enumeration(struct dma_device *device)
>> +{
>> +	struct dma_chan *chan;
>> +	int rc;
>> +
>> +	if (list_empty(&device->channels))
>> +		return 0;
>> +
>> +	/* represent channels in sysfs. Probably want devs too */
>> +	list_for_each_entry(chan, &device->channels, device_node) {
>> +		rc = __dma_async_device_channel_register(device, chan);
>> +		if (rc < 0)
>> +			return rc;
>> +	}
>> +
>> +	/* take references on public channels */
>> +	if (dmaengine_ref_count && !dma_has_cap(DMA_PRIVATE, device->cap_mask))
>> +		list_for_each_entry(chan, &device->channels, device_node) {
>> +			/* if clients are already waiting for channels we need
>> +			 * to take references on their behalf
>> +			 */
>> +			if (dma_chan_get(chan) == -ENODEV) {
>> +				/* note we can only get here for the first
>> +				 * channel as the remaining channels are
>> +				 * guaranteed to get a reference
>> +				 */
>> +				return -ENODEV;
>> +			}
>> +		}
>> +
>> +	return 0;
>> +}
>> +
>>   /**
>>    * dma_async_device_register - registers DMA devices found
>>    * @device:	pointer to &struct dma_device
>> @@ -1247,33 +1330,15 @@ int dma_async_device_register(struct dma_device *device)
>>   	if (rc != 0)
>>   		return rc;
>>   
>> +	mutex_lock(&dma_list_mutex);
>>   	mutex_init(&device->chan_mutex);
>>   	ida_init(&device->chan_ida);
>> -
>> -	/* represent channels in sysfs. Probably want devs too */
>> -	list_for_each_entry(chan, &device->channels, device_node) {
>> -		rc = __dma_async_device_channel_register(device, chan);
>> -		if (rc < 0)
>> -			goto err_out;
>> +	rc = dma_channel_enumeration(device);
>> +	if (rc < 0) {
>> +		mutex_unlock(&dma_list_mutex);
>> +		goto err_out;
>>   	}
>>   
>> -	mutex_lock(&dma_list_mutex);
>> -	/* take references on public channels */
>> -	if (dmaengine_ref_count && !dma_has_cap(DMA_PRIVATE, device->cap_mask))
>> -		list_for_each_entry(chan, &device->channels, device_node) {
>> -			/* if clients are already waiting for channels we need
>> -			 * to take references on their behalf
>> -			 */
>> -			if (dma_chan_get(chan) == -ENODEV) {
>> -				/* note we can only get here for the first
>> -				 * channel as the remaining channels are
>> -				 * guaranteed to get a reference
>> -				 */
>> -				rc = -ENODEV;
>> -				mutex_unlock(&dma_list_mutex);
>> -				goto err_out;
>> -			}
>> -		}
>>   	list_add_tail_rcu(&device->global_node, &dma_device_list);
>>   	if (dma_has_cap(DMA_PRIVATE, device->cap_mask))
>>   		device->privatecnt++;	/* Always private */
>> @@ -1291,6 +1356,9 @@ int dma_async_device_register(struct dma_device *device)
>>   		return rc;
>>   	}
>>   
>> +	if (list_empty(&device->channels))
>> +		return rc;
>> +
>>   	list_for_each_entry(chan, &device->channels, device_node) {
>>   		if (chan->local == NULL)
>>   			continue;
>> @@ -1317,8 +1385,9 @@ void dma_async_device_unregister(struct dma_device *device)
>>   
>>   	dmaengine_debug_unregister(device);
>>   
>> -	list_for_each_entry_safe(chan, n, &device->channels, device_node)
>> -		__dma_async_device_channel_unregister(device, chan);
>> +	if (!list_empty(&device->channels))
>> +		list_for_each_entry_safe(chan, n, &device->channels, device_node)
>> +			__dma_async_device_channel_unregister(device, chan);
>>   
>>   	mutex_lock(&dma_list_mutex);
>>   	/*
> 
> 
> 
