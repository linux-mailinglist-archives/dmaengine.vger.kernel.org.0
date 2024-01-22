Return-Path: <dmaengine+bounces-777-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2398361EF
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jan 2024 12:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A8A41F27B32
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jan 2024 11:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709533FE29;
	Mon, 22 Jan 2024 11:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOFz3uNI"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449E93FE20;
	Mon, 22 Jan 2024 11:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705922854; cv=none; b=PCG2Zb1VUwQR4svPN9uOCULR1mpwq9KeXwXy+xkC6EW/m2dhMpjRD8aZxNOywc48Oq+ra/nUISpo7NtxpzlgiUtieQYMrfxDdToQFy5y8bIizQ6mOUWNq1f52KBwHBchcOMaAWjVlVtk/4FY8hxaJz2Ng5TuvHXR6fcvfvnW0xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705922854; c=relaxed/simple;
	bh=IOtL/1l3eNennUM4no86ztpLcWr9CqAsQwvfWH0uZJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPhpDa6RtqIoFrSbDkpg9B47iSOkodNBd2A46Cd62ucVxEh9OfAyCUJmnLQU1DeEsN7eY76F49uCAZ2bUsOXKMXuBgcmcQ3ITUhNzfuTH9iaURW2xlcue8K8q7z7U3Bn1kXIe3HZm+1fOGx+GokH69XKBdXMQMko8F3GaFXCMmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOFz3uNI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 057B6C433C7;
	Mon, 22 Jan 2024 11:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705922853;
	bh=IOtL/1l3eNennUM4no86ztpLcWr9CqAsQwvfWH0uZJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GOFz3uNIQq0tLT6FSbdqdug4jloaxHBf9c4w3FnUBckfbeu4RHdt2Bc5pNjMQakkZ
	 SoyPTuC9Cpl/GulchIEIfZ6X8bBaDpnGTDzJwkR6yQ0P/5K9wPQNskCdgYsvh0WaGu
	 Y+3c8th1q9SJ1tN2TwobMzl4Q2nWjKi+XL6MDbCng2ffXaJ4yuIbNwk6nCeeWTbKaM
	 W2xkeE+6jxY+hpk1zCuJBy4UFM1LSrg6x7HPR1om8silys1OfIgFyx2joLj1B73GtD
	 1u+l6JCOtiUwTWqRHFyEIDiOYJNg6FAknfVXV/9ewOzEGTm1sez21tr1o9C+Gw7Naa
	 RHeoh7+GP+nWw==
Date: Mon, 22 Jan 2024 16:57:29 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, Peng Fan <peng.fan@nxp.com>,
	Arnd Bergmann <arnd@arndb.de>, Fabio Estevam <festevam@denx.de>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH] dmaengine: fsl-edma: fix Makefile logic
Message-ID: <Za5RIcRK6sXglPxp@matsya>
References: <20240110232255.1099757-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110232255.1099757-1-arnd@kernel.org>

Hey Arnd,

On 11-01-24, 00:03, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> A change to remove some unnecessary exports ended up removing some
> necessary ones as well, and caused a build regression by trying to
> link a single source file into two separate modules:
> 
> scripts/Makefile.build:243: drivers/dma/Makefile: fsl-edma-common.o is added to multiple modules: fsl-edma mcf-edma
> 
> While the two drivers cannot be used on the same CPU architecture,
> building both is still possible for compile testing.

Do you have an update for this patch? I noticed kbot complain as well

> 
> Fixes: 66aac8ea0a6c ("dmaengine: fsl-edma: clean up EXPORT_SYMBOL_GPL in fsl-edma-common.c")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/dma/Makefile          |  8 ++++----
>  drivers/dma/fsl-edma-common.c | 17 +++++++++++++++++
>  2 files changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> index dfd40d14e408..302b7b0fbb8e 100644
> --- a/drivers/dma/Makefile
> +++ b/drivers/dma/Makefile
> @@ -31,10 +31,10 @@ obj-$(CONFIG_DW_AXI_DMAC) += dw-axi-dmac/
>  obj-$(CONFIG_DW_DMAC_CORE) += dw/
>  obj-$(CONFIG_DW_EDMA) += dw-edma/
>  obj-$(CONFIG_EP93XX_DMA) += ep93xx_dma.o
> -obj-$(CONFIG_FSL_DMA) += fsldma.o
> -fsl-edma-objs := fsl-edma-main.o fsl-edma-common.o
> -obj-$(CONFIG_FSL_EDMA) += fsl-edma.o
> -mcf-edma-objs := mcf-edma-main.o fsl-edma-common.o
> +obj-$(CONFIG_FSL_DMA) += fsldma.o fsl-edma-common.o
> +fsl-edma-objs := fsl-edma-main.o
> +obj-$(CONFIG_FSL_EDMA) += fsl-edma.o fsl-edma-common.o
> +mcf-edma-objs := mcf-edma-main.o
>  obj-$(CONFIG_MCF_EDMA) += mcf-edma.o
>  obj-$(CONFIG_FSL_QDMA) += fsl-qdma.o
>  obj-$(CONFIG_FSL_RAID) += fsl_raid.o
> diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
> index b53f46245c37..05b31985a93b 100644
> --- a/drivers/dma/fsl-edma-common.c
> +++ b/drivers/dma/fsl-edma-common.c
> @@ -67,6 +67,7 @@ void fsl_edma_tx_chan_handler(struct fsl_edma_chan *fsl_chan)
>  
>  	spin_unlock(&fsl_chan->vchan.lock);
>  }
> +EXPORT_SYMBOL_GPL(fsl_edma_tx_chan_handler);
>  
>  static void fsl_edma3_enable_request(struct fsl_edma_chan *fsl_chan)
>  {
> @@ -159,6 +160,7 @@ void fsl_edma_disable_request(struct fsl_edma_chan *fsl_chan)
>  		iowrite8(EDMA_CEEI_CEEI(ch), regs->ceei);
>  	}
>  }
> +EXPORT_SYMBOL_GPL(fsl_edma_disable_request);
>  
>  static void mux_configure8(struct fsl_edma_chan *fsl_chan, void __iomem *addr,
>  			   u32 off, u32 slot, bool enable)
> @@ -212,6 +214,7 @@ void fsl_edma_chan_mux(struct fsl_edma_chan *fsl_chan,
>  	else
>  		mux_configure8(fsl_chan, muxaddr, ch_off, slot, enable);
>  }
> +EXPORT_SYMBOL_GPL(fsl_edma_chan_mux);
>  
>  static unsigned int fsl_edma_get_tcd_attr(enum dma_slave_buswidth addr_width)
>  {
> @@ -235,6 +238,7 @@ void fsl_edma_free_desc(struct virt_dma_desc *vdesc)
>  			      fsl_desc->tcd[i].ptcd);
>  	kfree(fsl_desc);
>  }
> +EXPORT_SYMBOL_GPL(fsl_edma_free_desc);
>  
>  int fsl_edma_terminate_all(struct dma_chan *chan)
>  {
> @@ -255,6 +259,7 @@ int fsl_edma_terminate_all(struct dma_chan *chan)
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(fsl_edma_terminate_all);
>  
>  int fsl_edma_pause(struct dma_chan *chan)
>  {
> @@ -270,6 +275,7 @@ int fsl_edma_pause(struct dma_chan *chan)
>  	spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(fsl_edma_pause);
>  
>  int fsl_edma_resume(struct dma_chan *chan)
>  {
> @@ -285,6 +291,7 @@ int fsl_edma_resume(struct dma_chan *chan)
>  	spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(fsl_edma_resume);
>  
>  static void fsl_edma_unprep_slave_dma(struct fsl_edma_chan *fsl_chan)
>  {
> @@ -345,6 +352,7 @@ int fsl_edma_slave_config(struct dma_chan *chan,
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(fsl_edma_slave_config);
>  
>  static size_t fsl_edma_desc_residue(struct fsl_edma_chan *fsl_chan,
>  		struct virt_dma_desc *vdesc, bool in_progress)
> @@ -425,6 +433,7 @@ enum dma_status fsl_edma_tx_status(struct dma_chan *chan,
>  
>  	return fsl_chan->status;
>  }
> +EXPORT_SYMBOL_GPL(fsl_edma_tx_status);
>  
>  static void fsl_edma_set_tcd_regs(struct fsl_edma_chan *fsl_chan,
>  				  struct fsl_edma_hw_tcd *tcd)
> @@ -644,6 +653,7 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
>  
>  	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
>  }
> +EXPORT_SYMBOL_GPL(fsl_edma_prep_dma_cyclic);
>  
>  struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
>  		struct dma_chan *chan, struct scatterlist *sgl,
> @@ -740,6 +750,7 @@ struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
>  
>  	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
>  }
> +EXPORT_SYMBOL_GPL(fsl_edma_prep_slave_sg);
>  
>  struct dma_async_tx_descriptor *fsl_edma_prep_memcpy(struct dma_chan *chan,
>  						     dma_addr_t dma_dst, dma_addr_t dma_src,
> @@ -762,6 +773,7 @@ struct dma_async_tx_descriptor *fsl_edma_prep_memcpy(struct dma_chan *chan,
>  
>  	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
>  }
> +EXPORT_SYMBOL_GPL(fsl_edma_prep_memcpy);
>  
>  void fsl_edma_xfer_desc(struct fsl_edma_chan *fsl_chan)
>  {
> @@ -797,6 +809,7 @@ void fsl_edma_issue_pending(struct dma_chan *chan)
>  
>  	spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
>  }
> +EXPORT_SYMBOL_GPL(fsl_edma_issue_pending);
>  
>  int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
>  {
> @@ -807,6 +820,7 @@ int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
>  				32, 0);
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(fsl_edma_alloc_chan_resources);
>  
>  void fsl_edma_free_chan_resources(struct dma_chan *chan)
>  {
> @@ -830,6 +844,7 @@ void fsl_edma_free_chan_resources(struct dma_chan *chan)
>  	fsl_chan->is_sw = false;
>  	fsl_chan->srcid = 0;
>  }
> +EXPORT_SYMBOL_GPL(fsl_edma_free_chan_resources);
>  
>  void fsl_edma_cleanup_vchan(struct dma_device *dmadev)
>  {
> @@ -841,6 +856,7 @@ void fsl_edma_cleanup_vchan(struct dma_device *dmadev)
>  		tasklet_kill(&chan->vchan.task);
>  	}
>  }
> +EXPORT_SYMBOL_GPL(fsl_edma_cleanup_vchan);
>  
>  /*
>   * On the 32 channels Vybrid/mpc577x edma version, register offsets are
> @@ -877,5 +893,6 @@ void fsl_edma_setup_regs(struct fsl_edma_engine *edma)
>  		edma->regs.inth = edma->membase + EDMA64_INTH;
>  	}
>  }
> +EXPORT_SYMBOL_GPL(fsl_edma_setup_regs);
>  
>  MODULE_LICENSE("GPL v2");
> -- 
> 2.39.2
> 

-- 
~Vinod

