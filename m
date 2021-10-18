Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075C04310B1
	for <lists+dmaengine@lfdr.de>; Mon, 18 Oct 2021 08:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhJRGmM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 18 Oct 2021 02:42:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:46334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229847AbhJRGmM (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 18 Oct 2021 02:42:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6BCAD610A6;
        Mon, 18 Oct 2021 06:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634539201;
        bh=zpWw777UU9SBe2o8DtU9V2NXKXZg+xXUUw5hVZ5SYd0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pQsso9xJh/t3Iu75YqOI3VSbMns9PJN5D1waNn1CevV73nfcN2i+SFQQchFcQ19RJ
         uKcRT05oW6pKAAseIBVdndALZqCF8zgVAe10/VN0mGQhlgYzaXhxfXU5UWmG9YqeEs
         ED668pJuJzex7AExyPmG5rEW5LHemI7r5rvshydfl6y4pa1CyRm0Z/Zx9LXqzyaKwx
         bIo5/cWT3EeAKBohTuB7/fSdsLvI7COGABuAavpOShd0lAzmAxSUeinbs/VMXP1vL3
         Tpr+OmhNqOybQ1Hm4DqtfpiqChOeumS7Zs7RZi+i3LOT67hqRZKn8QRXaxGtsjHjPJ
         o88JmJX/TZ51A==
Date:   Mon, 18 Oct 2021 12:09:57 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Joy Zou <joy.zou@nxp.com>
Cc:     yibin.gong@nxp.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/1] dmaengine: fsl-edma: support edma memcpy
Message-ID: <YW0WvYoUDolJEF5e@matsya>
References: <20211011103623.456865-1-joy.zou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211011103623.456865-1-joy.zou@nxp.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 11-10-21, 18:36, Joy Zou wrote:
> add memcpy in edma.

can you describe the changes?

> 
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> Reported-by: kernel test robot <lkp@intel.com>

how is the support reported by the bot?

> ---
>  drivers/dma/fsl-edma-common.c | 32 +++++++++++++++++++++++++++++++-
>  drivers/dma/fsl-edma-common.h |  4 ++++
>  drivers/dma/fsl-edma.c        |  7 +++++++
>  3 files changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
> index 930ae268c497..8a451855c3be 100644
> --- a/drivers/dma/fsl-edma-common.c
> +++ b/drivers/dma/fsl-edma-common.c
> @@ -348,7 +348,7 @@ static void fsl_edma_set_tcd_regs(struct fsl_edma_chan *fsl_chan,
>  	struct fsl_edma_engine *edma = fsl_chan->edma;
>  	struct edma_regs *regs = &fsl_chan->edma->regs;
>  	u32 ch = fsl_chan->vchan.chan.chan_id;
> -
> +	u16 csr = 0;

blank line would look better after this

>  	/*
>  	 * TCD parameters are stored in struct fsl_edma_hw_tcd in little
>  	 * endian format. However, we need to load the TCD registers in
> @@ -373,6 +373,12 @@ static void fsl_edma_set_tcd_regs(struct fsl_edma_chan *fsl_chan,
>  	edma_writel(edma, (s32)tcd->dlast_sga,
>  			&regs->tcd[ch].dlast_sga);
>  
> +	if (fsl_chan->is_sw) {
> +		csr = le16_to_cpu(tcd->csr);
> +		csr |= EDMA_TCD_CSR_START;
> +		tcd->csr = cpu_to_le16(csr);
> +	}
> +
>  	edma_writew(edma, (s16)tcd->csr, &regs->tcd[ch].csr);
>  }
>  
> @@ -587,6 +593,29 @@ struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
>  }
>  EXPORT_SYMBOL_GPL(fsl_edma_prep_slave_sg);
>  
> +struct dma_async_tx_descriptor *fsl_edma_prep_memcpy(
> +		struct dma_chan *chan, dma_addr_t dma_dst,
> +		dma_addr_t dma_src, size_t len, unsigned long flags)
> +{
> +	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
> +	struct fsl_edma_desc *fsl_desc;
> +
> +	fsl_desc = fsl_edma_alloc_desc(fsl_chan, 1);
> +	if (!fsl_desc)
> +		return NULL;
> +	fsl_desc->iscyclic = false;
> +
> +	fsl_chan->is_sw = true;
> +
> +	/* To match with copy_align and max_seg_size so 1 tcd is enough */
> +	fsl_edma_fill_tcd(fsl_desc->tcd[0].vtcd, dma_src, dma_dst,
> +			EDMA_TCD_ATTR_SSIZE_32BYTE | EDMA_TCD_ATTR_DSIZE_32BYTE,
> +			32, len, 0, 1, 1, 32, 0, true, true, false);
> +
> +	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
> +}
> +EXPORT_SYMBOL_GPL(fsl_edma_prep_memcpy);
> +
>  void fsl_edma_xfer_desc(struct fsl_edma_chan *fsl_chan)
>  {
>  	struct virt_dma_desc *vdesc;
> @@ -652,6 +681,7 @@ void fsl_edma_free_chan_resources(struct dma_chan *chan)
>  	vchan_dma_desc_free_list(&fsl_chan->vchan, &head);
>  	dma_pool_destroy(fsl_chan->tcd_pool);
>  	fsl_chan->tcd_pool = NULL;
> +	fsl_chan->is_sw = false;
>  }
>  EXPORT_SYMBOL_GPL(fsl_edma_free_chan_resources);
>  
> diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
> index ec1169741de1..004ec4a6bc86 100644
> --- a/drivers/dma/fsl-edma-common.h
> +++ b/drivers/dma/fsl-edma-common.h
> @@ -121,6 +121,7 @@ struct fsl_edma_chan {
>  	struct fsl_edma_desc		*edesc;
>  	struct dma_slave_config		cfg;
>  	u32				attr;
> +	bool                            is_sw;

what does is_sw mean?

>  	struct dma_pool			*tcd_pool;
>  	dma_addr_t			dma_dev_addr;
>  	u32				dma_dev_size;
> @@ -240,6 +241,9 @@ struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
>  		struct dma_chan *chan, struct scatterlist *sgl,
>  		unsigned int sg_len, enum dma_transfer_direction direction,
>  		unsigned long flags, void *context);
> +struct dma_async_tx_descriptor *fsl_edma_prep_memcpy(
> +		struct dma_chan *chan, dma_addr_t dma_dst, dma_addr_t dma_src,
> +		size_t len, unsigned long flags);
>  void fsl_edma_xfer_desc(struct fsl_edma_chan *fsl_chan);
>  void fsl_edma_issue_pending(struct dma_chan *chan);
>  int fsl_edma_alloc_chan_resources(struct dma_chan *chan);
> diff --git a/drivers/dma/fsl-edma.c b/drivers/dma/fsl-edma.c
> index 90bb72af306c..76cbf54aec58 100644
> --- a/drivers/dma/fsl-edma.c
> +++ b/drivers/dma/fsl-edma.c
> @@ -17,6 +17,7 @@
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_dma.h>
> +#include <linux/dma-mapping.h>
>  
>  #include "fsl-edma-common.h"
>  
> @@ -372,6 +373,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
>  	dma_cap_set(DMA_PRIVATE, fsl_edma->dma_dev.cap_mask);
>  	dma_cap_set(DMA_SLAVE, fsl_edma->dma_dev.cap_mask);
>  	dma_cap_set(DMA_CYCLIC, fsl_edma->dma_dev.cap_mask);
> +	dma_cap_set(DMA_MEMCPY, fsl_edma->dma_dev.cap_mask);
>  
>  	fsl_edma->dma_dev.dev = &pdev->dev;
>  	fsl_edma->dma_dev.device_alloc_chan_resources
> @@ -381,6 +383,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
>  	fsl_edma->dma_dev.device_tx_status = fsl_edma_tx_status;
>  	fsl_edma->dma_dev.device_prep_slave_sg = fsl_edma_prep_slave_sg;
>  	fsl_edma->dma_dev.device_prep_dma_cyclic = fsl_edma_prep_dma_cyclic;
> +	fsl_edma->dma_dev.device_prep_dma_memcpy = fsl_edma_prep_memcpy;
>  	fsl_edma->dma_dev.device_config = fsl_edma_slave_config;
>  	fsl_edma->dma_dev.device_pause = fsl_edma_pause;
>  	fsl_edma->dma_dev.device_resume = fsl_edma_resume;
> @@ -392,6 +395,10 @@ static int fsl_edma_probe(struct platform_device *pdev)
>  	fsl_edma->dma_dev.dst_addr_widths = FSL_EDMA_BUSWIDTHS;
>  	fsl_edma->dma_dev.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
>  
> +	fsl_edma->dma_dev.copy_align = DMAENGINE_ALIGN_32_BYTES;
> +	/* Per worst case 'nbytes = 1' take CITER as the max_seg_size */
> +	dma_set_max_seg_size(fsl_edma->dma_dev.dev, 0x3fff);
> +
>  	platform_set_drvdata(pdev, fsl_edma);
>  
>  	ret = dma_async_device_register(&fsl_edma->dma_dev);
> -- 
> 2.25.1

-- 
~Vinod
