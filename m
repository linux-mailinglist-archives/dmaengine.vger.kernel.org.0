Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC0DD215EFC
	for <lists+dmaengine@lfdr.de>; Mon,  6 Jul 2020 20:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729695AbgGFSsC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Jul 2020 14:48:02 -0400
Received: from mga04.intel.com ([192.55.52.120]:49907 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729569AbgGFSsC (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 6 Jul 2020 14:48:02 -0400
IronPort-SDR: s+we0hs7npyXQsbX5Qk6/t4HpI049QBYH6Y1XGai/fe1HisXHbncf3kA0nMpEt8phmRA82JwrQ
 DNO6+oniMwIQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="144980520"
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; 
   d="scan'208";a="144980520"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 11:47:58 -0700
IronPort-SDR: 68nKHoO+/jn5zpi8BLo6t1b1CThbr+Sma4IkCNsEaXB2m/248YD+VcFgwwO578IhnQF9z1nY5G
 1rq4wiLkd49Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; 
   d="scan'208";a="314042249"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.168.148]) ([10.212.168.148])
  by orsmga008.jf.intel.com with ESMTP; 06 Jul 2020 11:47:54 -0700
Subject: Re: next/master bisection: baseline.login on qemu_arm64-virt-gicv3
To:     "kernelci.org bot" <bot@kernelci.org>,
        Swathi Kovvuri <swathi.kovvuri@intel.com>,
        Vinod Koul <vkoul@kernel.org>, kernelci-results@groups.io,
        gtucker@collabora.com
Cc:     linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org
References: <5f036d83.1c69fb81.10199.06d0@mx.google.com>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <64f1ab9a-2390-5b42-4e57-2a4f78db94c4@intel.com>
Date:   Mon, 6 Jul 2020 11:47:52 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5f036d83.1c69fb81.10199.06d0@mx.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 7/6/2020 11:29 AM, kernelci.org bot wrote:
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> * This automated bisection report was sent to you on the basis  *
> * that you may be involved with the breaking commit it has      *
> * found.  No manual investigation has been done to verify it,   *
> * and the root cause of the problem may be somewhere else.      *
> *                                                               *
> * If you do send a fix, please include this trailer:            *
> *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
> *                                                               *
> * Hope this helps!                                              *
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> 
> next/master bisection: baseline.login on qemu_arm64-virt-gicv3
> 
> Summary:
>    Start:      5680d14d59bd Add linux-next specific files for 20200706
>    Plain log:  https://storage.kernelci.org/next/master/next-20200706/arm64/defconfig+CONFIG_RANDOMIZE_BASE=y/gcc-8/lab-collabora/baseline-qemu_arm64-virt-gicv3.txt
>    HTML log:   https://storage.kernelci.org/next/master/next-20200706/arm64/defconfig+CONFIG_RANDOMIZE_BASE=y/gcc-8/lab-collabora/baseline-qemu_arm64-virt-gicv3.html
>    Result:     deb9541f5052 dmaengine: check device and channel list for empty
> 
> Checks:
>    revert:     PASS
>    verify:     PASS
> 
> Parameters:
>    Tree:       next
>    URL:        https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>    Branch:     master
>    Target:     qemu_arm64-virt-gicv3
>    CPU arch:   arm64
>    Lab:        lab-collabora
>    Compiler:   gcc-8
>    Config:     defconfig+CONFIG_RANDOMIZE_BASE=y
>    Test case:  baseline.login


This should be already fixed. Same issue that Naresh reported and Arnd bisected.
https://www.spinics.net/lists/dmaengine/msg22787.html

> 
> Breaking commit found:
> 
> -------------------------------------------------------------------------------
> commit deb9541f5052b2f93bd51cb263d9035bfd89fa96
> Author: Dave Jiang <dave.jiang@intel.com>
> Date:   Fri Jun 26 11:09:41 2020 -0700
> 
>      dmaengine: check device and channel list for empty
>      
>      Check dma device list and channel list for empty before iterate as the
>      iteration function assume the list to be not empty. With devices and
>      channels now being hot pluggable this is a condition that needs to be
>      checked. Otherwise it can cause the iterator to spin forever.
>      
>      Fixes: e81274cd6b52 ("dmaengine: add support to dynamic register/unregister of channels")
>      Reported-by: Swathi Kovvuri <swathi.kovvuri@intel.com>
>      Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>      Tested-by: Swathi Kovvuri <swathi.kovvuri@intel.com>
>      Link: https://lore.kernel.org/r/159319496403.69045.16298280729899651363.stgit@djiang5-desk3.ch.intel.com
>      Signed-off-by: Vinod Koul <vkoul@kernel.org>
> 
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index 2b06a7a8629d..0d6529eff66f 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -85,6 +85,9 @@ static void dmaengine_dbg_summary_show(struct seq_file *s,
>   {
>   	struct dma_chan *chan;
>   
> +	if (list_empty(&dma_dev->channels))
> +		return;
> +
>   	list_for_each_entry(chan, &dma_dev->channels, device_node) {
>   		if (chan->client_count) {
>   			seq_printf(s, " %-13s| %s", dma_chan_name(chan),
> @@ -104,6 +107,11 @@ static int dmaengine_summary_show(struct seq_file *s, void *data)
>   	struct dma_device *dma_dev = NULL;
>   
>   	mutex_lock(&dma_list_mutex);
> +	if (list_empty(&dma_device_list)) {
> +		mutex_unlock(&dma_list_mutex);
> +		return 0;
> +	}
> +
>   	list_for_each_entry(dma_dev, &dma_device_list, global_node) {
>   		seq_printf(s, "dma%d (%s): number of channels: %u\n",
>   			   dma_dev->dev_id, dev_name(dma_dev->dev),
> @@ -324,10 +332,15 @@ static struct dma_chan *min_chan(enum dma_transaction_type cap, int cpu)
>   	struct dma_chan *min = NULL;
>   	struct dma_chan *localmin = NULL;
>   
> +	if (list_empty(&dma_device_list))
> +		return NULL;
> +
>   	list_for_each_entry(device, &dma_device_list, global_node) {
>   		if (!dma_has_cap(cap, device->cap_mask) ||
>   		    dma_has_cap(DMA_PRIVATE, device->cap_mask))
>   			continue;
> +		if (list_empty(&device->channels))
> +			continue;
>   		list_for_each_entry(chan, &device->channels, device_node) {
>   			if (!chan->client_count)
>   				continue;
> @@ -365,6 +378,9 @@ static void dma_channel_rebalance(void)
>   	int cpu;
>   	int cap;
>   
> +	if (list_empty(&dma_device_list))
> +		return;
> +
>   	/* undo the last distribution */
>   	for_each_dma_cap_mask(cap, dma_cap_mask_all)
>   		for_each_possible_cpu(cpu)
> @@ -373,6 +389,8 @@ static void dma_channel_rebalance(void)
>   	list_for_each_entry(device, &dma_device_list, global_node) {
>   		if (dma_has_cap(DMA_PRIVATE, device->cap_mask))
>   			continue;
> +		if (list_empty(&device->channels))
> +			continue;
>   		list_for_each_entry(chan, &device->channels, device_node)
>   			chan->table_count = 0;
>   	}
> @@ -556,6 +574,10 @@ void dma_issue_pending_all(void)
>   	struct dma_chan *chan;
>   
>   	rcu_read_lock();
> +	if (list_empty(&dma_device_list)) {
> +		rcu_read_unlock();
> +		return;
> +	}
>   	list_for_each_entry_rcu(device, &dma_device_list, global_node) {
>   		if (dma_has_cap(DMA_PRIVATE, device->cap_mask))
>   			continue;
> @@ -613,6 +635,10 @@ static struct dma_chan *private_candidate(const dma_cap_mask_t *mask,
>   		dev_dbg(dev->dev, "%s: wrong capabilities\n", __func__);
>   		return NULL;
>   	}
> +
> +	if (list_empty(&dev->channels))
> +		return NULL;
> +
>   	/* devices with multiple channels need special handling as we need to
>   	 * ensure that all channels are either private or public.
>   	 */
> @@ -749,6 +775,11 @@ struct dma_chan *__dma_request_channel(const dma_cap_mask_t *mask,
>   
>   	/* Find a channel */
>   	mutex_lock(&dma_list_mutex);
> +	if (list_empty(&dma_device_list)) {
> +		mutex_unlock(&dma_list_mutex);
> +		return NULL;
> +	}
> +
>   	list_for_each_entry_safe(device, _d, &dma_device_list, global_node) {
>   		/* Finds a DMA controller with matching device node */
>   		if (np && device->dev->of_node && np != device->dev->of_node)
> @@ -819,6 +850,11 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
>   
>   	/* Try to find the channel via the DMA filter map(s) */
>   	mutex_lock(&dma_list_mutex);
> +	if (list_empty(&dma_device_list)) {
> +		mutex_unlock(&dma_list_mutex);
> +		return NULL;
> +	}
> +
>   	list_for_each_entry_safe(d, _d, &dma_device_list, global_node) {
>   		dma_cap_mask_t mask;
>   		const struct dma_slave_map *map = dma_filter_match(d, name, dev);
> @@ -942,10 +978,17 @@ void dmaengine_get(void)
>   	mutex_lock(&dma_list_mutex);
>   	dmaengine_ref_count++;
>   
> +	if (list_empty(&dma_device_list)) {
> +		mutex_unlock(&dma_list_mutex);
> +		return;
> +	}
> +
>   	/* try to grab channels */
>   	list_for_each_entry_safe(device, _d, &dma_device_list, global_node) {
>   		if (dma_has_cap(DMA_PRIVATE, device->cap_mask))
>   			continue;
> +		if (list_empty(&device->channels))
> +			continue;
>   		list_for_each_entry(chan, &device->channels, device_node) {
>   			err = dma_chan_get(chan);
>   			if (err == -ENODEV) {
> @@ -980,10 +1023,17 @@ void dmaengine_put(void)
>   	mutex_lock(&dma_list_mutex);
>   	dmaengine_ref_count--;
>   	BUG_ON(dmaengine_ref_count < 0);
> +	if (list_empty(&dma_device_list)) {
> +		mutex_unlock(&dma_list_mutex);
> +		return;
> +	}
> +
>   	/* drop channel references */
>   	list_for_each_entry_safe(device, _d, &dma_device_list, global_node) {
>   		if (dma_has_cap(DMA_PRIVATE, device->cap_mask))
>   			continue;
> +		if (list_empty(&device->channels))
> +			continue;
>   		list_for_each_entry(chan, &device->channels, device_node)
>   			dma_chan_put(chan);
>   	}
> @@ -1132,6 +1182,39 @@ void dma_async_device_channel_unregister(struct dma_device *device,
>   }
>   EXPORT_SYMBOL_GPL(dma_async_device_channel_unregister);
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
>   /**
>    * dma_async_device_register - registers DMA devices found
>    * @device:	pointer to &struct dma_device
> @@ -1247,33 +1330,15 @@ int dma_async_device_register(struct dma_device *device)
>   	if (rc != 0)
>   		return rc;
>   
> +	mutex_lock(&dma_list_mutex);
>   	mutex_init(&device->chan_mutex);
>   	ida_init(&device->chan_ida);
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
>   	}
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
>   	list_add_tail_rcu(&device->global_node, &dma_device_list);
>   	if (dma_has_cap(DMA_PRIVATE, device->cap_mask))
>   		device->privatecnt++;	/* Always private */
> @@ -1291,6 +1356,9 @@ int dma_async_device_register(struct dma_device *device)
>   		return rc;
>   	}
>   
> +	if (list_empty(&device->channels))
> +		return rc;
> +
>   	list_for_each_entry(chan, &device->channels, device_node) {
>   		if (chan->local == NULL)
>   			continue;
> @@ -1317,8 +1385,9 @@ void dma_async_device_unregister(struct dma_device *device)
>   
>   	dmaengine_debug_unregister(device);
>   
> -	list_for_each_entry_safe(chan, n, &device->channels, device_node)
> -		__dma_async_device_channel_unregister(device, chan);
> +	if (!list_empty(&device->channels))
> +		list_for_each_entry_safe(chan, n, &device->channels, device_node)
> +			__dma_async_device_channel_unregister(device, chan);
>   
>   	mutex_lock(&dma_list_mutex);
>   	/*
> -------------------------------------------------------------------------------
> 
> 
> Git bisection log:
> 
> -------------------------------------------------------------------------------
> git bisect start
> # good: [bb5a93aaf25261321db0c499cde7da6ee9d8b164] x86/ldt: use "pr_info_once()" instead of open-coding it badly
> git bisect good bb5a93aaf25261321db0c499cde7da6ee9d8b164
> # bad: [5680d14d59bddc8bcbc5badf00dbbd4374858497] Add linux-next specific files for 20200706
> git bisect bad 5680d14d59bddc8bcbc5badf00dbbd4374858497
> # good: [2549a884c8373a109a93521bf806cc523c92340b] Merge remote-tracking branch 'crypto/master'
> git bisect good 2549a884c8373a109a93521bf806cc523c92340b
> # good: [f94ee8e6645aadfc1e80c2a5fe5fb07841526610] Merge remote-tracking branch 'selinux/next'
> git bisect good f94ee8e6645aadfc1e80c2a5fe5fb07841526610
> # good: [16d4f454c697a796cfac0af2b5ab39bedf71f4fe] Merge remote-tracking branch 'thunderbolt/next'
> git bisect good 16d4f454c697a796cfac0af2b5ab39bedf71f4fe
> # bad: [2c43abadd30bab02d2a94b5aa72a7eb6edbe6b96] Merge remote-tracking branch 'nvdimm/libnvdimm-for-next'
> git bisect bad 2c43abadd30bab02d2a94b5aa72a7eb6edbe6b96
> # bad: [d5a942e3894462eb44f6bb51dde5b5b481ba355a] Merge remote-tracking branch 'scsi/for-next'
> git bisect bad d5a942e3894462eb44f6bb51dde5b5b481ba355a
> # good: [bd7a168a024dcfbc4db7fb79a51c8b574f55b527] staging: rtl8712: use common ieee80211 constants
> git bisect good bd7a168a024dcfbc4db7fb79a51c8b574f55b527
> # good: [28ed7374401b20915bf980fdf2d3ac80f8c2945d] scsi: lpfc: Fix language in 0373 message to reflect non-error message
> git bisect good 28ed7374401b20915bf980fdf2d3ac80f8c2945d
> # good: [198d6cb9263bb25156132d87babfe6e6506a4c88] Merge remote-tracking branch 'icc/icc-next'
> git bisect good 198d6cb9263bb25156132d87babfe6e6506a4c88
> # good: [7244068998c8266300c48f1a3af7b237446de885] Merge branch 'misc' into for-next
> git bisect good 7244068998c8266300c48f1a3af7b237446de885
> # good: [999a32efed09d724c426568731c5691233d3a680] dmaengine: hisilicon: Use struct_size() in devm_kzalloc()
> git bisect good 999a32efed09d724c426568731c5691233d3a680
> # good: [d12ea5591eddf625b7707c018b72e46e8674c3c2] dmaengine: pl330: Make sure the debug is idle before doing DMAGO
> git bisect good d12ea5591eddf625b7707c018b72e46e8674c3c2
> # bad: [f50b150e315ed133b74a75e3c71864fb2cd4cece] dmaengine: idxd: add work queue drain support
> git bisect bad f50b150e315ed133b74a75e3c71864fb2cd4cece
> # bad: [deb9541f5052b2f93bd51cb263d9035bfd89fa96] dmaengine: check device and channel list for empty
> git bisect bad deb9541f5052b2f93bd51cb263d9035bfd89fa96
> # first bad commit: [deb9541f5052b2f93bd51cb263d9035bfd89fa96] dmaengine: check device and channel list for empty
> -------------------------------------------------------------------------------
> 
