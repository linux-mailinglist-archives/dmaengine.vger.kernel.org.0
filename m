Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37086175449
	for <lists+dmaengine@lfdr.de>; Mon,  2 Mar 2020 08:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgCBHLx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 Mar 2020 02:11:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:38224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgCBHLx (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 2 Mar 2020 02:11:53 -0500
Received: from localhost (unknown [171.76.77.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C25B24697;
        Mon,  2 Mar 2020 07:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583133112;
        bh=GNyguOEdwGJ7BtTeR33CFq0k6jMsDdlT5RZFCn7IQY4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LNTq8dE/Yp+ua2NM6Nv3J+WiqilOPgl7XCo0IuVbmqlgl1+2Cs7Q8EfxctH+UvtKX
         WI8SM8tmwMA1afkCD1Edx5YGoNu7oFCv9WOXAP8UKbe7L4UnzSCrqOLEcDXb/GTZRf
         B9dzU/r70ybfqYVu3WD8PMzk9veQTtB/Pcsmi2ZI=
Date:   Mon, 2 Mar 2020 12:41:46 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.j.williams@intel.com, geert@linux-m68k.org
Subject: Re: [PATCH v4 1/2] dmaengine: Add basic debugfs support
Message-ID: <20200302071146.GE4148@vkoul-mobl>
References: <20200228130747.22905-1-peter.ujfalusi@ti.com>
 <20200228130747.22905-2-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228130747.22905-2-peter.ujfalusi@ti.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 28-02-20, 15:07, Peter Ujfalusi wrote:
> Via the /sys/kernel/debug/dmaengine/summary users can get information
> about the DMA devices and the used channels.
> 
> Example output on am654-evm with audio using two channels and after running
> dmatest on 4 channels:
> 
> dma0 (285c0000.dma-controller): number of channels: 96
> 
> dma1 (31150000.dma-controller): number of channels: 267
>  dma1chan0    | 2b00000.mcasp:tx
>  dma1chan1    | 2b00000.mcasp:rx
>  dma1chan2    | in-use
>  dma1chan3    | in-use
>  dma1chan4    | in-use
>  dma1chan5    | in-use
> 
> For slave channels we can show the device and the channel name a given
> channel is requested.
> For non slave devices the only information we know is that the channel is
> in use.
> 
> DMA drivers can implement the optional dbg_summary_show callback to
> provide controller specific information instead of the generic one.
> 
> It is easy to extend the generic dmaengine_summary_show() to print
> additional information about the used channels.
> 
> In case DMA drivers want to create additional files under the dmaengine
> directory to provide additional debug points, they can use the
> dmaengine_get_debugfs_root() to get the dentry of the rootdir.
> 
> I have taken the idea from gpiolib and clk subsystems.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/dma/dmaengine.c   | 77 +++++++++++++++++++++++++++++++++++++++
>  drivers/dma/dmaengine.h   |  6 +++
>  include/linux/dmaengine.h | 12 +++++-
>  3 files changed, 94 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index c3b1283b6d31..b5e8b737785c 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -760,6 +760,11 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
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
> @@ -837,6 +842,11 @@ void dma_release_channel(struct dma_chan *chan)
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
> @@ -1562,3 +1572,70 @@ static int __init dma_bus_init(void)
>  	return class_register(&dma_devclass);
>  }
>  arch_initcall(dma_bus_init);
> +
> +#ifdef CONFIG_DEBUG_FS
> +#include <linux/debugfs.h>
> +
> +static struct dentry *rootdir;
> +
> +struct dentry *dmaengine_get_debugfs_root(void)
> +{
> +	return rootdir;
> +}
> +EXPORT_SYMBOL_GPL(dmaengine_get_debugfs_root);
> +
> +static void dmaengine_dbg_summary_show(struct seq_file *s,
> +				       struct dma_device *dma_dev)
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
> +static int dmaengine_summary_show(struct seq_file *s, void *data)
> +{
> +	struct dma_device *dma_dev = NULL;
> +
> +	mutex_lock(&dma_list_mutex);
> +	list_for_each_entry(dma_dev, &dma_device_list, global_node) {
> +		seq_printf(s, "dma%d (%s): number of channels: %u\n",
> +			   dma_dev->dev_id, dev_name(dma_dev->dev),
> +			   dma_dev->chancnt);
> +
> +		if (dma_dev->dbg_summary_show)
> +			dma_dev->dbg_summary_show(s, dma_dev);
> +		else
> +			dmaengine_dbg_summary_show(s, dma_dev);
> +
> +		if (!list_is_last(&dma_dev->global_node, &dma_device_list))
> +			seq_puts(s, "\n");
> +	}
> +	mutex_unlock(&dma_list_mutex);
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(dmaengine_summary);
> +
> +static int __init dmaengine_debugfs_init(void)
> +{
> +	rootdir = debugfs_create_dir("dmaengine", NULL);
> +
> +	/* /sys/kernel/debug/dmaengine */
> +	debugfs_create_file("summary", 0444, rootdir, NULL,
> +			    &dmaengine_summary_fops);
> +	return 0;
> +}
> +late_initcall(dmaengine_debugfs_init);
> +
> +#endif	/* DEBUG_FS */
> diff --git a/drivers/dma/dmaengine.h b/drivers/dma/dmaengine.h
> index e8a320c9e57c..72cd7fe33638 100644
> --- a/drivers/dma/dmaengine.h
> +++ b/drivers/dma/dmaengine.h
> @@ -182,4 +182,10 @@ dmaengine_desc_callback_valid(struct dmaengine_desc_callback *cb)
>  struct dma_chan *dma_get_slave_channel(struct dma_chan *chan);
>  struct dma_chan *dma_get_any_slave_channel(struct dma_device *device);
>  
> +#ifdef CONFIG_DEBUG_FS
> +#include <linux/debugfs.h>
> +
> +struct dentry *dmaengine_get_debugfs_root(void);

this needs to have an else defined with NULL return so that we dont
force users to wrap the code under CONFIG_DEBUG_FS..

-- 
~Vinod
