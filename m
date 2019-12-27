Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74ACA12B182
	for <lists+dmaengine@lfdr.de>; Fri, 27 Dec 2019 06:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbfL0Fqv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 27 Dec 2019 00:46:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:59726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbfL0Fqv (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 27 Dec 2019 00:46:51 -0500
Received: from localhost (unknown [106.201.34.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E94EB20838;
        Fri, 27 Dec 2019 05:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577425610;
        bh=v9Vd8KjGScnrBXq0TWB3fP0uEwBBn78x/45NcMCLmEg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s7soXC0baqB+EEGFiuvaw5eKC1RvfKU2VrvwAIkfyc6UjoD/XGoaX2K0/HGx5D15G
         XI3D4sSptpRG0TqJkHU1J6IIVJkpaT2QMjffMR96ARqytrlYbB1/FZU/3HzZ3kGfjS
         AZ+1UgSVsImUrVZUaKSkVvnqlTMiaEVv5hokB2+8=
Date:   Fri, 27 Dec 2019 11:16:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.j.williams@intel.com, tony.luck@intel.com, jing.lin@intel.com,
        ashok.raj@intel.com, sanjay.k.kumar@intel.com, megha.dey@intel.com,
        jacob.jun.pan@intel.com, yi.l.liu@intel.com, axboe@kernel.dk,
        akpm@linux-foundation.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, fenghua.yu@intel.com, hpa@zytor.com
Subject: Re: [PATCH RFC v3 05/14] dmaengine: add dma_request support functions
Message-ID: <20191227054645.GC3006@vkoul-mobl>
References: <157662541786.51652.7666763291600764054.stgit@djiang5-desk3.ch.intel.com>
 <157662560983.51652.13439786918385685865.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157662560983.51652.13439786918385685865.stgit@djiang5-desk3.ch.intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 17-12-19, 16:33, Dave Jiang wrote:
> In order to provide a lockless submission path, the request context needs
> to be pre-allocated rather than pulling from a memory pool.
> Use the common request allocation call request_from_pages_alloc() to
> accomplish this. The sbitmap code will be used to get the next
> free request context. This is a simplified version of what blk-mq does
> (not sbitmap_queue). The config option DMA_ENGINE_REQUEST is added so that
> only drivers that supports dma request would enable the code.

Can you give more context on this requirement of lockless submission
path? I see this and next patch are adding another set of dma APIs, so
we need a good justification, documentation and why this cant be added
to existing code :)

> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/dma/Kconfig       |    6 +++
>  drivers/dma/Makefile      |    1 
>  drivers/dma/dma-request.c |   96 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/dmaengine.h |   57 +++++++++++++++++++++++++++
>  4 files changed, 160 insertions(+)
>  create mode 100644 drivers/dma/dma-request.c
> 
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 6fa1eba9d477..52a3c2086dcb 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -56,6 +56,12 @@ config DMA_OF
>  	depends on OF
>  	select DMA_ENGINE
>  
> +config DMA_ENGINE_REQUEST
> +	def_bool n
> +	depends on DMA_ENGINE
> +	select SBITMAP
> +	select CONTEXT_ALLOC
> +
>  #devices
>  config ALTERA_MSGDMA
>  	tristate "Altera / Intel mSGDMA Engine"
> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> index 42d7e2fc64fa..f80720075399 100644
> --- a/drivers/dma/Makefile
> +++ b/drivers/dma/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_DMA_ENGINE) += dmaengine.o
>  obj-$(CONFIG_DMA_VIRTUAL_CHANNELS) += virt-dma.o
>  obj-$(CONFIG_DMA_ACPI) += acpi-dma.o
>  obj-$(CONFIG_DMA_OF) += of-dma.o
> +obj-$(CONFIG_DMA_ENGINE_REQUEST) += dma-request.o
>  
>  #dmatest
>  obj-$(CONFIG_DMATEST) += dmatest.o
> diff --git a/drivers/dma/dma-request.c b/drivers/dma/dma-request.c
> new file mode 100644
> index 000000000000..43462fadf777
> --- /dev/null
> +++ b/drivers/dma/dma-request.c
> @@ -0,0 +1,96 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/* Copyright(c) 2019 Intel Corporation. All rights reserved.  */
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/mm.h>
> +#include <linux/device.h>
> +#include <linux/dmaengine.h>
> +#include <linux/mempool.h>
> +
> +struct dma_request *dma_chan_alloc_request(struct dma_chan *chan)
> +{
> +	int nr;
> +	struct dma_request *req;
> +
> +	nr = sbitmap_get(&chan->sbmap, 0, false);
> +	if (nr < 0)
> +		return NULL;
> +
> +	req = chan->rqs[nr];
> +	req->rq_private = NULL;
> +	req->callback = NULL;
> +	memset(&req->result, 0, sizeof(struct dmaengine_result));
> +	return req;
> +}
> +EXPORT_SYMBOL_GPL(dma_chan_alloc_request);
> +
> +void dma_chan_free_request(struct dma_chan *chan, struct dma_request *rq)
> +{
> +	sbitmap_clear_bit(&chan->sbmap, rq->id);
> +}
> +EXPORT_SYMBOL_GPL(dma_chan_free_request);
> +
> +void dma_chan_free_request_resources(struct dma_chan *chan)
> +{
> +	context_free_from_pages(&chan->page_list);
> +	kfree(chan->rqs);
> +}
> +EXPORT_SYMBOL_GPL(dma_chan_free_request_resources);
> +
> +static void dma_chan_assign_request(void *ctx, void *ptr, int idx)
> +{
> +	struct dma_chan *chan = (struct dma_chan *)ctx;
> +	struct dma_request *rq = ptr;
> +
> +	chan->rqs[idx] = rq;
> +}
> +
> +int dma_chan_alloc_request_resources(struct dma_chan *chan)
> +{
> +	int i, node, rc, id = 0;
> +	size_t rq_size;
> +
> +	/* Requests are already allocated */
> +	if (chan->rqs)
> +		return 0;
> +
> +	node = dev_to_node(chan->device->dev);
> +	rc = sbitmap_init_node(&chan->sbmap, chan->depth, -1,
> +			       GFP_KERNEL, node);
> +	if (rc < 0)
> +		return rc;
> +
> +	chan->rqs = kcalloc_node(chan->depth, sizeof(struct dma_request *),
> +				 GFP_KERNEL, node);
> +	if (!chan->rqs) {
> +		rc = -ENOMEM;
> +		goto fail;
> +	}
> +
> +	INIT_LIST_HEAD(&chan->page_list);
> +
> +	rq_size = round_up(sizeof(struct dma_request) +
> +			chan->max_sgs * sizeof(struct scatterlist),
> +			cache_line_size());
> +
> +	rc = context_alloc_from_pages((void *)chan, chan->depth, rq_size,
> +				      &chan->page_list, 4, node,
> +				      dma_chan_assign_request);
> +	if (rc < 0)
> +		goto fail;
> +
> +	for (i = 0; i < rc; i++) {
> +		struct dma_request *rq = chan->rqs[i];
> +
> +		rq->id = id++;
> +		rq->chan = chan;
> +	}
> +
> +	return 0;
> +
> + fail:
> +	sbitmap_free(&chan->sbmap);
> +	dma_chan_free_request_resources(chan);
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(dma_chan_alloc_request_resources);
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 0202d44a17a5..7bc8c3f8283f 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -12,6 +12,8 @@
>  #include <linux/scatterlist.h>
>  #include <linux/bitmap.h>
>  #include <linux/types.h>
> +#include <linux/sbitmap.h>
> +#include <linux/bvec.h>
>  #include <asm/page.h>
>  
>  /**
> @@ -176,6 +178,8 @@ struct dma_interleaved_template {
>   * @DMA_PREP_CMD: tell the driver that the data passed to DMA API is command
>   *  data and the descriptor should be in different format from normal
>   *  data descriptors.
> + *  @DMA_SUBMIT_NONBLOCK: tell the driver do not wait for resources if submit
> + *  is not possible.
>   */
>  enum dma_ctrl_flags {
>  	DMA_PREP_INTERRUPT = (1 << 0),
> @@ -186,6 +190,7 @@ enum dma_ctrl_flags {
>  	DMA_PREP_FENCE = (1 << 5),
>  	DMA_CTRL_REUSE = (1 << 6),
>  	DMA_PREP_CMD = (1 << 7),
> +	DMA_SUBMIT_NONBLOCK = (1 << 8),
>  };
>  
>  /**
> @@ -268,6 +273,13 @@ struct dma_chan {
>  	struct dma_router *router;
>  	void *route_data;
>  
> +	/* DMA request */
> +	int max_sgs;
> +	int depth;
> +	struct sbitmap sbmap;
> +	struct dma_request **rqs;
> +	struct list_head page_list;
> +
>  	void *private;
>  };
>  
> @@ -511,6 +523,25 @@ struct dma_async_tx_descriptor {
>  #endif
>  };
>  
> +struct dma_request {
> +	int id;
> +	struct dma_chan *chan;
> +	enum dma_transaction_type cmd;
> +	enum dma_ctrl_flags flags;
> +	struct bio_vec bvec;
> +	dma_addr_t pg_dma;
> +	int sg_nents;
> +	void *rq_private;
> +
> +	/* Set by driver */
> +	dma_async_tx_callback_result callback;
> +	struct dmaengine_result result;
> +	void *callback_param;
> +
> +	/* Leave as last member for flexible array of scatterlist */
> +	struct scatterlist sg[];
> +};
> +
>  #ifdef CONFIG_DMA_ENGINE
>  static inline void dma_set_unmap(struct dma_async_tx_descriptor *tx,
>  				 struct dmaengine_unmap_data *unmap)
> @@ -1359,6 +1390,32 @@ static inline int dma_get_slave_caps(struct dma_chan *chan,
>  }
>  #endif
>  
> +#ifdef CONFIG_DMA_ENGINE_REQUEST
> +struct dma_request *dma_chan_alloc_request(struct dma_chan *chan);
> +void dma_chan_free_request(struct dma_chan *chan, struct dma_request *rq);
> +void dma_chan_free_request_resources(struct dma_chan *chan);
> +int dma_chan_alloc_request_resources(struct dma_chan *chan);
> +#else
> +static inline struct dma_request *dma_chan_alloc_request(struct dma_chan *chan)
> +{
> +	return NULL;
> +}
> +
> +static inline void dma_chan_free_request(struct dma_chan *chan,
> +					 struct dma_request *rq)
> +{
> +}
> +
> +static inline void dma_chan_free_request_resources(struct dma_chan *chan)
> +{
> +}
> +
> +static inline int dma_chan_alloc_request_resources(struct dma_chan *chan)
> +{
> +	return -EOPNOTSUPP;
> +}
> +#endif
> +
>  #define dma_request_slave_channel_reason(dev, name) dma_request_chan(dev, name)
>  
>  static inline int dmaengine_desc_set_reuse(struct dma_async_tx_descriptor *tx)

-- 
~Vinod
