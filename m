Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8113F14121D
	for <lists+dmaengine@lfdr.de>; Fri, 17 Jan 2020 21:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbgAQUIx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Jan 2020 15:08:53 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53086 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbgAQUIw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Jan 2020 15:08:52 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00HK8jAF113059;
        Fri, 17 Jan 2020 14:08:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1579291725;
        bh=mbY87qveryPPYQ1EQ2+4SCwD3anHdznVGfKwmBfB3qU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=MiUR3HmUa3MijBs1Fep5EiIV+Us20ffc6Q27yybmrdBJvSwAAhhNz0ZY4neX4aUOW
         jVYy+eBfNXLxFh1+g9WD64HsxQNyC7owP5QuVnwTIbHHpOEJ0pUIshEfxnieCsiUu5
         fT8poCuKpCNlzPY4L4DTPYO2pvfd6ufjuvk7HYSk=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00HK8jxc093876
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Jan 2020 14:08:45 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 17
 Jan 2020 14:08:44 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 17 Jan 2020 14:08:44 -0600
Received: from [192.168.2.10] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00HK8giI051925;
        Fri, 17 Jan 2020 14:08:43 -0600
Subject: Re: [PATCH v2] dmaengine: Create symlinks between DMA channels and
 slaves
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <dmaengine@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200117153056.31363-1-geert+renesas@glider.be>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <d2b669e7-a5d4-20ec-5b54-103b71df7407@ti.com>
Date:   Fri, 17 Jan 2020 22:10:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200117153056.31363-1-geert+renesas@glider.be>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Geert,

On 1/17/20 5:30 PM, Geert Uytterhoeven wrote:
> Currently it is not easy to find out which DMA channels are in use, and
> which slave devices are using which channels.
> 
> Fix this by creating two symlinks between the DMA channel and the actual
> slave device when a channel is requested:
>   1. A "slave" symlink from DMA channel to slave device,

Have you considered similar link name as on the slave device:
slave:<name>

That way it would be easier to grasp which channel is used for what
purpose by only looking under /sys/class/dma/ and no need to check the
slave device.

>   2. A "dma:<name>" symlink slave device to DMA channel.
> When the channel is released, the symlinks are removed again.
> The latter requires keeping track of the slave device and the channel
> name in the dma_chan structure.
> 
> Note that this is limited to channel request functions for requesting an
> exclusive slave channel that take a device pointer (dma_request_chan()
> and dma_request_slave_channel*()).
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - Add DMA_SLAVE_NAME macro,
>   - Also handle channels from FIXME,
>   - Add backlinks from slave device to DMA channel,
> 
> On r8a7791/koelsch, the following new symlinks are created:
> 
>     /sys/devices/platform/soc/
>     ├── e6700000.dma-controller/dma/dma0chan0/slave -> ../../../e6e20000.spi
>     ├── e6700000.dma-controller/dma/dma0chan1/slave -> ../../../e6e20000.spi
>     ├── e6700000.dma-controller/dma/dma0chan2/slave -> ../../../ee100000.sd
>     ├── e6700000.dma-controller/dma/dma0chan3/slave -> ../../../ee100000.sd
>     ├── e6700000.dma-controller/dma/dma0chan4/slave -> ../../../ee160000.sd
>     ├── e6700000.dma-controller/dma/dma0chan5/slave -> ../../../ee160000.sd
>     ├── e6700000.dma-controller/dma/dma0chan6/slave -> ../../../e6e68000.serial
>     ├── e6700000.dma-controller/dma/dma0chan7/slave -> ../../../e6e68000.serial
>     ├── e6720000.dma-controller/dma/dma1chan0/slave -> ../../../e6b10000.spi
>     ├── e6720000.dma-controller/dma/dma1chan1/slave -> ../../../e6b10000.spi
>     ├── e6720000.dma-controller/dma/dma1chan2/slave -> ../../../ee140000.sd
>     ├── e6720000.dma-controller/dma/dma1chan3/slave -> ../../../ee140000.sd
>     ├── e6b10000.spi/dma:rx -> ../e6720000.dma-controller/dma/dma1chan1
>     ├── e6b10000.spi/dma:tx -> ../e6720000.dma-controller/dma/dma1chan0
>     ├── e6e20000.spi/dma:rx -> ../e6700000.dma-controller/dma/dma0chan1
>     ├── e6e20000.spi/dma:tx -> ../e6700000.dma-controller/dma/dma0chan0
>     ├── e6e68000.serial/dma:rx -> ../e6700000.dma-controller/dma/dma0chan7
>     ├── e6e68000.serial/dma:tx -> ../e6700000.dma-controller/dma/dma0chan6
>     ├── ee100000.sd/dma:rx -> ../e6700000.dma-controller/dma/dma0chan3
>     ├── ee100000.sd/dma:tx -> ../e6700000.dma-controller/dma/dma0chan2
>     ├── ee140000.sd/dma:rx -> ../e6720000.dma-controller/dma/dma1chan3
>     ├── ee140000.sd/dma:tx -> ../e6720000.dma-controller/dma/dma1chan2
>     ├── ee160000.sd/dma:rx -> ../e6700000.dma-controller/dma/dma0chan5
>     └── ee160000.sd/dma:tx -> ../e6700000.dma-controller/dma/dma0chan4
> 
> On r8a77951/salvator-xs:
> 
>     /sys/devices/platform/soc/
>     ├── e6460000.dma-controller/dma/dma4chan0/slave -> ../../../e659c000.usb
>     ├── e6460000.dma-controller/dma/dma4chan1/slave -> ../../../e659c000.usb
>     ├── e6470000.dma-controller/dma/dma5chan0/slave -> ../../../e659c000.usb
>     ├── e6470000.dma-controller/dma/dma5chan1/slave -> ../../../e659c000.usb
>     ├── e6510000.i2c/dma:tx -> ../e7300000.dma-controller/dma/dma7chan0
>     ├── e6550000.serial/dma:rx -> ../e7310000.dma-controller/dma/dma8chan1
>     ├── e6550000.serial/dma:tx -> ../e7310000.dma-controller/dma/dma8chan0
>     ├── e6590000.usb/dma:ch0 -> ../e65a0000.dma-controller/dma/dma2chan0
>     ├── e6590000.usb/dma:ch1 -> ../e65a0000.dma-controller/dma/dma2chan1
>     ├── e6590000.usb/dma:ch2 -> ../e65b0000.dma-controller/dma/dma3chan0
>     ├── e6590000.usb/dma:ch3 -> ../e65b0000.dma-controller/dma/dma3chan1
>     ├── e659c000.usb/dma:ch0 -> ../e6460000.dma-controller/dma/dma4chan0
>     ├── e659c000.usb/dma:ch1 -> ../e6460000.dma-controller/dma/dma4chan1
>     ├── e659c000.usb/dma:ch2 -> ../e6470000.dma-controller/dma/dma5chan0
>     ├── e659c000.usb/dma:ch3 -> ../e6470000.dma-controller/dma/dma5chan1
>     ├── e65a0000.dma-controller/dma/dma2chan0/slave -> ../../../e6590000.usb
>     ├── e65a0000.dma-controller/dma/dma2chan1/slave -> ../../../e6590000.usb
>     ├── e65b0000.dma-controller/dma/dma3chan0/slave -> ../../../e6590000.usb
>     ├── e65b0000.dma-controller/dma/dma3chan1/slave -> ../../../e6590000.usb
>     ├── e7300000.dma-controller/dma/dma7chan0/slave -> ../../../e6510000.i2c
>     ├── e7310000.dma-controller/dma/dma8chan0/slave -> ../../../e6550000.serial
>     └── e7310000.dma-controller/dma/dma8chan1/slave -> ../../../e6550000.serial
> ---
>  drivers/dma/dmaengine.c   | 37 +++++++++++++++++++++++++++++++------
>  include/linux/dmaengine.h |  4 ++++
>  2 files changed, 35 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index 56a8420c388679d3..617c84cf6800962b 100644
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
> index 2cd1d6d7ef0fcce5..2804da93e27e114b 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -238,10 +238,12 @@ struct dma_router {
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
> @@ -252,12 +254,14 @@ struct dma_router {
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
> 

- Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
