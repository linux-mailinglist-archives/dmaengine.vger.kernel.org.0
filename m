Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E97FB16ABBD
	for <lists+dmaengine@lfdr.de>; Mon, 24 Feb 2020 17:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbgBXQhN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 24 Feb 2020 11:37:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:41986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727160AbgBXQhN (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 24 Feb 2020 11:37:13 -0500
Received: from localhost (unknown [122.182.199.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 009AA20637;
        Mon, 24 Feb 2020 16:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582562232;
        bh=EaF2MyjS2zZaaolBzvb8Q1sCIgrqXN34CG6/GRVu+iw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tPm95vGIpi/ZtZoLMfrUCE5SZ1PDT8Cqi/ELFlvHsA0J9xzr54BhKa5RXGOBckvjD
         OEqlGIjTd8HOAwSrcTqxPCRsYsGZiQY0h4/c84ANrlzg9t/pFgFAtnM4nv/xrdDYV2
         lhOTZmDtPZ50QYXLS/9CWV4vnFKRBxEVBXYuBZSk=
Date:   Mon, 24 Feb 2020 22:07:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.j.williams@intel.com, geert@linux-m68k.org
Subject: Re: [PATCH v3] dmaengine: Add basic debugfs support
Message-ID: <20200224163707.GA2618@vkoul-mobl>
References: <20200205111557.24125-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205111557.24125-1-peter.ujfalusi@ti.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 05-02-20, 13:15, Peter Ujfalusi wrote:
> Via the /sys/kernel/debug/dmaengine users can get information about the
> DMA devices and the used channels.
> 
> Example output on am654-evm with audio using two channels and after running
> dmatest on 6 channels:
> 
> # cat /sys/kernel/debug/dmaengine
> dma0 (285c0000.dma-controller): number of channels: 96
> 
> dma1 (31150000.dma-controller): number of channels: 267
>  dma1chan0    | 2b00000.mcasp:tx
>  dma1chan1    | 2b00000.mcasp:rx
>  dma1chan2    | in-use
>  dma1chan3    | in-use
>  dma1chan4    | in-use
>  dma1chan5    | in-use
>  dma1chan6    | in-use
>  dma1chan7    | in-use
> 
> For slave channels we can show the device and the channel name a given
> channel is requested.
> For non slave devices the only information we know is that the channel is
> in use.
> 
> DMA drivers can implement the optional dbg_show callback to provide
> controller specific information instead of the generic one.
> 
> It is easy to extend the generic dmaengine_dbg_show() to print additional
> information about the used channels.
> 
> I have taken the idea from gpiolib.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
> Hi,
> 
> Changes since v2:
> - Use dma_chan_name() for printing the channel's name
> 
> Changes since v1:
> - Use much more simplified fops for the debugfs file (via DEFINE_SHOW_ATTRIBUTE)
> - do not allow modification to dma_device_list while the debugfs file is read
> - rename the slave_name to dbg_client_name (it is only for debugging)
> - print information about dma_router if it is used by the channel
> - Formating of the output slightly changed
> 
> Regards,
> Peter
> 
>  drivers/dma/dmaengine.c   | 65 +++++++++++++++++++++++++++++++++++++++
>  include/linux/dmaengine.h | 12 +++++++-
>  2 files changed, 76 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index c3b1283b6d31..37c3a4cd5b1a 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -32,6 +32,7 @@
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
>  #include <linux/platform_device.h>
> +#include <linux/debugfs.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/init.h>
>  #include <linux/module.h>
> @@ -760,6 +761,11 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
>  		return chan ? chan : ERR_PTR(-EPROBE_DEFER);
>  
>  found:
> +#ifdef CONFIG_DEBUG_FS
> +	chan->dbg_client_name = kasprintf(GFP_KERNEL, "%s:%s", dev_name(dev),
> +					  name);
> +#endif
> +
>  	chan->name = kasprintf(GFP_KERNEL, "dma:%s", name);
>  	if (!chan->name)
>  		return chan;
> @@ -837,6 +843,11 @@ void dma_release_channel(struct dma_chan *chan)
>  		chan->name = NULL;
>  		chan->slave = NULL;
>  	}
> +
> +#ifdef CONFIG_DEBUG_FS
> +	kfree(chan->dbg_client_name);
> +	chan->dbg_client_name = NULL;
> +#endif
>  	mutex_unlock(&dma_list_mutex);
>  }
>  EXPORT_SYMBOL_GPL(dma_release_channel);
> @@ -1562,3 +1573,57 @@ static int __init dma_bus_init(void)
>  	return class_register(&dma_devclass);
>  }
>  arch_initcall(dma_bus_init);
> +
> +#ifdef CONFIG_DEBUG_FS
> +static void dmaengine_dbg_show(struct seq_file *s, struct dma_device *dma_dev)
> +{
> +	struct dma_chan *chan;
> +
> +	list_for_each_entry(chan, &dma_dev->channels, device_node) {
> +		if (chan->client_count) {
> +			seq_printf(s, " %-13s| %s", dma_chan_name(chan),
> +				   chan->dbg_client_name ?: "in-use");
> +
> +			if (chan->router)
> +				seq_printf(s, " (via router: %s)\n",
> +					dev_name(chan->router->dev));
> +			else
> +				seq_puts(s, "\n");
> +		}
> +	}
> +}
> +
> +static int dmaengine_debugfs_show(struct seq_file *s, void *data)
> +{
> +	struct dma_device *dma_dev = NULL;
> +
> +	mutex_lock(&dma_list_mutex);
> +	list_for_each_entry(dma_dev, &dma_device_list, global_node) {
> +		seq_printf(s, "dma%d (%s): number of channels: %u\n",
> +			   dma_dev->dev_id, dev_name(dma_dev->dev),
> +			   dma_dev->chancnt);
> +
> +		if (dma_dev->dbg_show)
> +			dma_dev->dbg_show(s, dma_dev);
 do we really want a custom dbg_show()..? Drivers can add their own
files...

> +		else
> +			dmaengine_dbg_show(s, dma_dev);
> +
> +		if (!list_is_last(&dma_dev->global_node, &dma_device_list))
> +			seq_puts(s, "\n");
> +	}
> +	mutex_unlock(&dma_list_mutex);
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(dmaengine_debugfs);
> +
> +static int __init dmaengine_debugfs_init(void)
> +{
> +	/* /sys/kernel/debug/dmaengine */
> +	debugfs_create_file("dmaengine", 0444, NULL, NULL,
> +			    &dmaengine_debugfs_fops);

Should we add a directory? That way we can keep adding stuff into that
one
-- 
~Vinod
