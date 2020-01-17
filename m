Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4BF140EEE
	for <lists+dmaengine@lfdr.de>; Fri, 17 Jan 2020 17:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgAQQ0o (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Jan 2020 11:26:44 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42764 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgAQQ0o (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Jan 2020 11:26:44 -0500
Received: by mail-lj1-f196.google.com with SMTP id y4so27059050ljj.9
        for <dmaengine@vger.kernel.org>; Fri, 17 Jan 2020 08:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=inxR1wA+jz9jvQ8VP84ip6LN880c6JYvrjnRZfT90Sw=;
        b=qFZT+WPtAQjHf/dXz2se/v1C0FZuDeCi9+Dc4H+qsnlWfQN8R+IeODlwQTntgOwS1g
         KlOOuJ2Ue4nJU/pReIND5RcvCPSftbqzItRAyJHhlGIuE8yq95olk/MI/w6Zao0iiD00
         lDis8Hjzf6cLVKUkIOudsOd0NppclqpG/I7Nz+9ZETnNxyrbmIBZ94mdtVOlH7XFDoPy
         b073Ump4J29YOS43WvXMk7qTpxHkJZ3KnbNkPPdwQAtJO/q5wyt51Tv9kX3kKro3gTIa
         WwZAxCjeswrEvXJtzLm3brro9HDyJyHVVBlBuF7fPoJm3koSX+S5ri5AEPwNwKRTp4H/
         DzDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=inxR1wA+jz9jvQ8VP84ip6LN880c6JYvrjnRZfT90Sw=;
        b=QEM9SUee4R7RUVMDSYHjllPzYlmYg9iKk0Qa+iY5qswHtyzMZB2SuyIAOVzYVVEx4R
         +ubzxjUC/aX0FcYppZoyIHQEcA7FDO0xtLVjGBez0Np+f5hl3Iz6nEi7PCBkeSaLelsS
         rbBB5EQZw/PGTMI2SzA3oSJ5CUd7DkeYsOKw4A/VMtQjyXIBb0OTBbFlLrgDFlfrlbmo
         72/Nu907w/isMK8QietkTeNT5E3ItPeV/yXt0fWnSSXxKvJ1cdvqiapbHPCTXGderEM/
         pQzYhTY7N1QP7beHWb5632E1+e/8fo+Q3wWhD/KbN0aAI9q5AUgEiFRKxHsDJTy6t7ms
         +p9Q==
X-Gm-Message-State: APjAAAXYBU58tj3fOCWgJ2o3Ownux+K5MAds0YePNUyoCa+qMMK0F/9X
        pjYoVgHILSEdoS6EcTPDc2hDDOXHrj4=
X-Google-Smtp-Source: APXvYqxNa+cnmPu1ROl9cASz4Uh2mKsEeyud8twaL/Ha3Ul2JvDVodaWUQjkrJTodxG9+12Qgkw0oA==
X-Received: by 2002:a2e:884f:: with SMTP id z15mr6181709ljj.46.1579278401982;
        Fri, 17 Jan 2020 08:26:41 -0800 (PST)
Received: from localhost (h-93-159.A463.priv.bahnhof.se. [46.59.93.159])
        by smtp.gmail.com with ESMTPSA id i17sm12664361ljd.34.2020.01.17.08.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 08:26:41 -0800 (PST)
Date:   Fri, 17 Jan 2020 17:26:40 +0100
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: Create symlinks between DMA channels and
 slaves
Message-ID: <20200117162640.GD1074550@oden.dyn.berto.se>
References: <20200117153056.31363-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200117153056.31363-1-geert+renesas@glider.be>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Geert,

Thanks for your patch.

On 2020-01-17 16:30:56 +0100, Geert Uytterhoeven wrote:
> Currently it is not easy to find out which DMA channels are in use, and
> which slave devices are using which channels.
> 
> Fix this by creating two symlinks between the DMA channel and the actual
> slave device when a channel is requested:
>   1. A "slave" symlink from DMA channel to slave device,
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

I like this change,

Tested-by: Niklas Söderlund <niklas.soderlund@ragnatech.se>

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
> -- 
> 2.17.1
> 

-- 
Regards,
Niklas Söderlund
