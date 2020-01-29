Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C72A414D35C
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2020 00:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgA2XNx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Jan 2020 18:13:53 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35390 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgA2XNw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Jan 2020 18:13:52 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id 69FCE265C5A
Subject: Re: mainline/master bisection: baseline.login on odroid-xu3
To:     Vinod Koul <vkoul@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@ragnatech.se>
References: <5e320e71.1c69fb81.e97dd.2bf5@mx.google.com>
Cc:     dmaengine@vger.kernel.org, mgalka@collabora.com,
        enric.balletbo@collabora.com, broonie@kernel.org,
        khilman@baylibre.com, tomeu.vizoso@collabora.com,
        linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <71ae1017-2077-87c9-d140-cac181017fb7@collabora.com>
Date:   Wed, 29 Jan 2020 23:13:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <5e320e71.1c69fb81.e97dd.2bf5@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Please see the bisection report below about a boot failure.

Reports aren't automatically sent to the public while we're
trialing new bisection features on kernelci.org but this one
looks valid.

Guillaume

On 29/01/2020 23:00, kernelci.org bot wrote:
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
> mainline/master bisection: baseline.login on odroid-xu3
> 
> Summary:
>   Start:      b3a608222336 Merge branch 'for-v5.6' of git://git.kernel.org:/pub/scm/linux/kernel/git/jmorris/linux-security
>   Plain log:  https://storage.kernelci.org//mainline/master/v5.5-3996-gb3a608222336/arm/multi_v7_defconfig+CONFIG_SMP=n/gcc-8/lab-collabora/baseline-exynos5422-odroidxu3.txt
>   HTML log:   https://storage.kernelci.org//mainline/master/v5.5-3996-gb3a608222336/arm/multi_v7_defconfig+CONFIG_SMP=n/gcc-8/lab-collabora/baseline-exynos5422-odroidxu3.html
>   Result:     71723a96b8b1 dmaengine: Create symlinks between DMA channels and slaves
> 
> Checks:
>   revert:     PASS
>   verify:     PASS
> 
> Parameters:
>   Tree:       mainline
>   URL:        git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>   Branch:     master
>   Target:     odroid-xu3
>   CPU arch:   arm
>   Lab:        lab-collabora
>   Compiler:   gcc-8
>   Config:     multi_v7_defconfig+CONFIG_SMP=n
>   Test case:  baseline.login
> 
> Breaking commit found:
> 
> -------------------------------------------------------------------------------
> commit 71723a96b8b1367fefc18f60025dae792477d602
> Author: Geert Uytterhoeven <geert+renesas@glider.be>
> Date:   Fri Jan 17 16:30:56 2020 +0100
> 
>     dmaengine: Create symlinks between DMA channels and slaves
>     
>     Currently it is not easy to find out which DMA channels are in use, and
>     which slave devices are using which channels.
>     
>     Fix this by creating two symlinks between the DMA channel and the actual
>     slave device when a channel is requested:
>       1. A "slave" symlink from DMA channel to slave device,
>       2. A "dma:<name>" symlink slave device to DMA channel.
>     When the channel is released, the symlinks are removed again.
>     The latter requires keeping track of the slave device and the channel
>     name in the dma_chan structure.
>     
>     Note that this is limited to channel request functions for requesting an
>     exclusive slave channel that take a device pointer (dma_request_chan()
>     and dma_request_slave_channel*()).
>     
>     Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>     Tested-by: Niklas Söderlund <niklas.soderlund@ragnatech.se>
>     Link: https://lore.kernel.org/r/20200117153056.31363-1-geert+renesas@glider.be
>     Signed-off-by: Vinod Koul <vkoul@kernel.org>
> 
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index 51a2f2b1b2de..f3ef4edd4de1 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -60,6 +60,8 @@ static long dmaengine_ref_count;
>  
>  /* --- sysfs implementation --- */
>  
> +#define DMA_SLAVE_NAME	"slave"
> +
>  /**
>   * dev_to_dma_chan - convert a device pointer to its sysfs container object
>   * @dev - device node
> @@ -730,11 +732,11 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
>  	if (has_acpi_companion(dev) && !chan)
>  		chan = acpi_dma_request_slave_chan_by_name(dev, name);
>  
> -	if (chan) {
> -		/* Valid channel found or requester needs to be deferred */
> -		if (!IS_ERR(chan) || PTR_ERR(chan) == -EPROBE_DEFER)
> -			return chan;
> -	}
> +	if (PTR_ERR(chan) == -EPROBE_DEFER)
> +		return chan;
> +
> +	if (!IS_ERR_OR_NULL(chan))
> +		goto found;
>  
>  	/* Try to find the channel via the DMA filter map(s) */
>  	mutex_lock(&dma_list_mutex);
> @@ -754,7 +756,23 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
>  	}
>  	mutex_unlock(&dma_list_mutex);
>  
> -	return chan ? chan : ERR_PTR(-EPROBE_DEFER);
> +	if (!IS_ERR_OR_NULL(chan))
> +		goto found;
> +
> +	return ERR_PTR(-EPROBE_DEFER);
> +
> +found:
> +	chan->slave = dev;
> +	chan->name = kasprintf(GFP_KERNEL, "dma:%s", name);
> +	if (!chan->name)
> +		return ERR_PTR(-ENOMEM);
> +
> +	if (sysfs_create_link(&chan->dev->device.kobj, &dev->kobj,
> +			      DMA_SLAVE_NAME))
> +		dev_err(dev, "Cannot create DMA %s symlink\n", DMA_SLAVE_NAME);
> +	if (sysfs_create_link(&dev->kobj, &chan->dev->device.kobj, chan->name))
> +		dev_err(dev, "Cannot create DMA %s symlink\n", chan->name);
> +	return chan;
>  }
>  EXPORT_SYMBOL_GPL(dma_request_chan);
>  
> @@ -812,6 +830,13 @@ void dma_release_channel(struct dma_chan *chan)
>  	/* drop PRIVATE cap enabled by __dma_request_channel() */
>  	if (--chan->device->privatecnt == 0)
>  		dma_cap_clear(DMA_PRIVATE, chan->device->cap_mask);
> +	if (chan->slave) {
> +		sysfs_remove_link(&chan->slave->kobj, chan->name);
> +		kfree(chan->name);
> +		chan->name = NULL;
> +		chan->slave = NULL;
> +	}
> +	sysfs_remove_link(&chan->dev->device.kobj, DMA_SLAVE_NAME);
>  	mutex_unlock(&dma_list_mutex);
>  }
>  EXPORT_SYMBOL_GPL(dma_release_channel);
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index f52f274773ed..fef69a9c5824 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -294,10 +294,12 @@ struct dma_router {
>  /**
>   * struct dma_chan - devices supply DMA channels, clients use them
>   * @device: ptr to the dma device who supplies this channel, always !%NULL
> + * @slave: ptr to the device using this channel
>   * @cookie: last cookie value returned to client
>   * @completed_cookie: last completed cookie for this channel
>   * @chan_id: channel ID for sysfs
>   * @dev: class device for sysfs
> + * @name: backlink name for sysfs
>   * @device_node: used to add this to the device chan list
>   * @local: per-cpu pointer to a struct dma_chan_percpu
>   * @client_count: how many clients are using this channel
> @@ -308,12 +310,14 @@ struct dma_router {
>   */
>  struct dma_chan {
>  	struct dma_device *device;
> +	struct device *slave;
>  	dma_cookie_t cookie;
>  	dma_cookie_t completed_cookie;
>  
>  	/* sysfs */
>  	int chan_id;
>  	struct dma_chan_dev *dev;
> +	const char *name;
>  
>  	struct list_head device_node;
>  	struct dma_chan_percpu __percpu *local;
> -------------------------------------------------------------------------------
> 
> 
> Git bisection log:
> 
> -------------------------------------------------------------------------------
> git bisect start
> # good: [4703d9119972bf586d2cca76ec6438f819ffa30e] Merge tag 'xarray-5.5' of git://git.infradead.org/users/willy/linux-dax
> git bisect good 4703d9119972bf586d2cca76ec6438f819ffa30e
> # bad: [b3a6082223369203d7e7db7e81253ac761377644] Merge branch 'for-v5.6' of git://git.kernel.org:/pub/scm/linux/kernel/git/jmorris/linux-security
> git bisect bad b3a6082223369203d7e7db7e81253ac761377644
> # bad: [a78208e2436963d0b2c7d186277d6e1a9755029a] Merge branch 'linus' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6
> git bisect bad a78208e2436963d0b2c7d186277d6e1a9755029a
> # bad: [b1dba2473114588be3df916bf629a61bdcc83737] Merge tag 'selinux-pr-20200127' of git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux
> git bisect bad b1dba2473114588be3df916bf629a61bdcc83737
> # good: [9e1af7567b266dc6c3c8fd434ea807b3206bfdc1] Merge tag 'mmc-v5.6' of git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc
> git bisect good 9e1af7567b266dc6c3c8fd434ea807b3206bfdc1
> # bad: [aae1464f46a2403565f75717438118691d31ccf1] Merge tag 'regulator-v5.6' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator
> git bisect bad aae1464f46a2403565f75717438118691d31ccf1
> # bad: [a5b871c91d470326eed3ae0ebd2fc07f3aee9050] Merge tag 'dmaengine-5.6-rc1' of git://git.infradead.org/users/vkoul/slave-dma
> git bisect bad a5b871c91d470326eed3ae0ebd2fc07f3aee9050
> # good: [12fb2b993e1508a0d9032a2314dfdda2a3a5535e] Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid
> git bisect good 12fb2b993e1508a0d9032a2314dfdda2a3a5535e
> # good: [7d083ae983573de16e3ab0bfd47486996d211417] dmaengine: doc: Add sections for per descriptor metadata support
> git bisect good 7d083ae983573de16e3ab0bfd47486996d211417
> # good: [e606c8b9d751e593b71bdcb636ac3392c62c1c50] dmaengine: s3c24xx-dma: fix spelling mistake "to" -> "too"
> git bisect good e606c8b9d751e593b71bdcb636ac3392c62c1c50
> # good: [8f47d1a5e545f903cd049c42da31a3be36178447] dmaengine: idxd: connect idxd to dmaengine subsystem
> git bisect good 8f47d1a5e545f903cd049c42da31a3be36178447
> # good: [f46e49a9cc3814f3564477f0fffc00e0a2bc9e80] livepatch: Handle allocation failure in the sample of shadow variable API
> git bisect good f46e49a9cc3814f3564477f0fffc00e0a2bc9e80
> # good: [e9f08b65250d73ab70e79e194813f52b8d306784] dmaengine: hisilicon: Add Kunpeng DMA engine support
> git bisect good e9f08b65250d73ab70e79e194813f52b8d306784
> # bad: [71723a96b8b1367fefc18f60025dae792477d602] dmaengine: Create symlinks between DMA channels and slaves
> git bisect bad 71723a96b8b1367fefc18f60025dae792477d602
> # first bad commit: [71723a96b8b1367fefc18f60025dae792477d602] dmaengine: Create symlinks between DMA channels and slaves
> -------------------------------------------------------------------------------
> 

