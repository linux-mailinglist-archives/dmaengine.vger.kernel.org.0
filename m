Return-Path: <dmaengine+bounces-7980-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 762A5CEA3B4
	for <lists+dmaengine@lfdr.de>; Tue, 30 Dec 2025 17:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27F37301BE94
	for <lists+dmaengine@lfdr.de>; Tue, 30 Dec 2025 16:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4EA32695F;
	Tue, 30 Dec 2025 16:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C81TwN0I"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B9D326950;
	Tue, 30 Dec 2025 16:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767113669; cv=none; b=o+TmnvM+3VLGDaI4CdDvL3nUDQTkNUSweC1D0UsMA/8vH6s6OIaN2XJd0Vr1PntSq99UcUsKgzQgNSXa3MBc9rNoktmNCoGFC+NJf1J2ViG9OMON4PnrXO2LcVlVqiFqq/9c/dXWX2/hitEwx5HIlekKErckN/y891sg/WyeP50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767113669; c=relaxed/simple;
	bh=vnL8kfRl+GH4yPapjEPyZLI8PJpzYRw1llbZVWshViE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZW0uq6ow0UiPaVuCPyHfDIrzCv9ruZvXXLABAZfoGFq68rQXoSt1dpSWjX9ZamSmjMYCl19GnYFZ6lorfxcAEbQfTsH5DCadslPotRQwKqiumAZNm16aPU+XKLqMw1LPlopL0zNw6HuYKAigJQ5uZydfUy890+uYV0AO/7rZLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C81TwN0I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A7BC4CEFB;
	Tue, 30 Dec 2025 16:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767113669;
	bh=vnL8kfRl+GH4yPapjEPyZLI8PJpzYRw1llbZVWshViE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C81TwN0IFwymVNw7dw2eIX7t1fWSG3OEXuxt8QZRG5G2oTxxMHWsecfZ9g+FE2+gT
	 QWd5BbZn8y2PwcOqGIC3ZGeva7gJT0OPvaSdRZSog5hRGHmXxlOLnRVKW5XC8ywJAT
	 GXhfjoX4ICCpgYkogt0z66rzHtrBiPX5lajo9NwTsXBmkAcck84y4peDmkbRYFkCwT
	 UKqj6F1NLXSknBcRhChwCg5IvYj32ZekyJF3j2eUsRfYZroLS/oFQT64vDNNSdPEWF
	 sNNsHByfHNiggLn6PhIROKTVt0qC8AsMLxuM1MyZLXvNioR1QYN9wFIZHCywEJEPL4
	 Vrh5RyFSJBLlQ==
Date: Tue, 30 Dec 2025 22:24:20 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Christoph Hellwig <hch@lst.de>, Niklas Cassel <cassel@kernel.org>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-nvme@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH 09/11] dmaengine: dw-edma: Use common
 dw_edma_core_start() for both edma and hdmi
Message-ID: <lo5yj5eaqny4m5m4dxic4i2hnftnlgs32loed7x7wlwxpl72lj@bccj3ayuuyf5>
References: <20251212-edma_ll-v1-0-fc863d9f5ca3@nxp.com>
 <20251212-edma_ll-v1-9-fc863d9f5ca3@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251212-edma_ll-v1-9-fc863d9f5ca3@nxp.com>

On Fri, Dec 12, 2025 at 05:24:48PM -0500, Frank Li wrote:
> Use common dw_edma_core_start() for both edma and hdmi. Remove .start()

s/edma/eDMA
s/hdmi/HDMA

Here and below.

> callback functions at edma and hdmi.
> 
> HDMI set CYCLE_BIT for each chunk. Now only set it when first is true. The
> logic is the same because previous ll_max is -1, so first is always true.
> 

How ll_max is related to 'desc->xfer_sz'?

- Mani

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/dma/dw-edma/dw-edma-core.c    | 24 ++++++++++++++++--
>  drivers/dma/dw-edma/dw-edma-core.h    |  7 -----
>  drivers/dma/dw-edma/dw-edma-v0-core.c | 48 -----------------------------------
>  drivers/dma/dw-edma/dw-hdma-v0-core.c | 43 +++----------------------------
>  4 files changed, 25 insertions(+), 97 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index 5b12af20cb37156a8dec440401d956652b890d53..37918f733eb4d36c7ced6418b85a885affadc8f7 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -163,9 +163,29 @@ static void vchan_free_desc(struct virt_dma_desc *vdesc)
>  	dw_edma_free_desc(vd2dw_edma_desc(vdesc));
>  }
>  
> +static void dw_edma_core_start(struct dw_edma_chunk *chunk, bool first)
> +{
> +	struct dw_edma_chan *chan = chunk->chan;
> +	struct dw_edma_burst *child;
> +	u32 i = 0;
> +	int j;
> +
> +	j = chunk->bursts_alloc;
> +	list_for_each_entry(child, &chunk->burst->list, list) {
> +		j--;
> +		dw_edma_core_ll_data(chan, child, i++, chunk->cb, !j);
> +	}
> +
> +	dw_edma_core_ll_link(chan, i, chunk->cb, chan->ll_region.paddr);
> +
> +	if (first)
> +		dw_edma_core_ch_enable(chan);
> +
> +	dw_edma_core_ch_doorbell(chan);
> +}
> +
>  static int dw_edma_start_transfer(struct dw_edma_chan *chan)
>  {
> -	struct dw_edma *dw = chan->dw;
>  	struct dw_edma_chunk *child;
>  	struct dw_edma_desc *desc;
>  	struct virt_dma_desc *vd;
> @@ -183,7 +203,7 @@ static int dw_edma_start_transfer(struct dw_edma_chan *chan)
>  	if (!child)
>  		return 0;
>  
> -	dw_edma_core_start(dw, child, !desc->xfer_sz);
> +	dw_edma_core_start(child, !desc->xfer_sz);
>  	desc->xfer_sz += child->xfer_sz;
>  	dw_edma_free_burst(child);
>  	list_del(&child->list);
> diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
> index 2b5defae133c360f142394f9fab35c4748a893da..7a0d8405eb7feaedf4b19fd83bbeb5d24781bb7b 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.h
> +++ b/drivers/dma/dw-edma/dw-edma-core.h
> @@ -124,7 +124,6 @@ struct dw_edma_core_ops {
>  	enum dma_status (*ch_status)(struct dw_edma_chan *chan);
>  	irqreturn_t (*handle_int)(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
>  				  dw_edma_handler_t done, dw_edma_handler_t abort);
> -	void (*start)(struct dw_edma_chunk *chunk, bool first);
>  	void (*ll_data)(struct dw_edma_chan *chan, struct dw_edma_burst *burst,
>  			u32 idx, bool cb, bool irq);
>  	void (*ll_link)(struct dw_edma_chan *chan, u32 idx, bool cb, u64 addr);
> @@ -195,12 +194,6 @@ dw_edma_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
>  	return dw_irq->dw->core->handle_int(dw_irq, dir, done, abort);
>  }
>  
> -static inline
> -void dw_edma_core_start(struct dw_edma *dw, struct dw_edma_chunk *chunk, bool first)
> -{
> -	dw->core->start(chunk, first);
> -}
> -
>  static inline
>  void dw_edma_core_ch_config(struct dw_edma_chan *chan)
>  {
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> index 59ee219f1abddd48806dec953ce96afdc87ffdab..c5f381d00b9773e52c1134cfea3ac3a04c7bef52 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> @@ -379,36 +379,6 @@ static void dw_edma_v0_core_ch_enable(struct dw_edma_chan *chan)
>  		  upper_32_bits(chan->ll_region.paddr));
>  }
>  
> -static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
> -{
> -	struct dw_edma_burst *child;
> -	struct dw_edma_chan *chan = chunk->chan;
> -	u32 control = 0, i = 0;
> -	int j;
> -
> -	if (chunk->cb)
> -		control = DW_EDMA_V0_CB;
> -
> -	j = chunk->bursts_alloc;
> -	list_for_each_entry(child, &chunk->burst->list, list) {
> -		j--;
> -		if (!j) {
> -			control |= DW_EDMA_V0_LIE;
> -			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
> -				control |= DW_EDMA_V0_RIE;
> -		}
> -
> -		dw_edma_v0_write_ll_data(chan, i++, control, child->sz,
> -					 child->sar, child->dar);
> -	}
> -
> -	control = DW_EDMA_V0_LLP | DW_EDMA_V0_TCB;
> -	if (!chunk->cb)
> -		control |= DW_EDMA_V0_CB;
> -
> -	dw_edma_v0_write_ll_link(chan, i, control, chan->ll_region.paddr);
> -}
> -
>  static void dw_edma_v0_sync_ll_data(struct dw_edma_chan *chan)
>  {
>  	/*
> @@ -423,23 +393,6 @@ static void dw_edma_v0_sync_ll_data(struct dw_edma_chan *chan)
>  		readl(chan->ll_region.vaddr.io);
>  }
>  
> -static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> -{
> -	struct dw_edma_chan *chan = chunk->chan;
> -	struct dw_edma *dw = chan->dw;
> -
> -	dw_edma_v0_core_write_chunk(chunk);
> -
> -	if (first)
> -		dw_edma_v0_core_ch_enable(chan);
> -
> -	dw_edma_v0_sync_ll_data(chan);
> -
> -	/* Doorbell */
> -	SET_RW_32(dw, chan->dir, doorbell,
> -		  FIELD_PREP(EDMA_V0_DOORBELL_CH_MASK, chan->id));
> -}
> -
>  static void dw_edma_v0_core_ch_config(struct dw_edma_chan *chan)
>  {
>  	struct dw_edma *dw = chan->dw;
> @@ -562,7 +515,6 @@ static const struct dw_edma_core_ops dw_edma_v0_core = {
>  	.ch_count = dw_edma_v0_core_ch_count,
>  	.ch_status = dw_edma_v0_core_ch_status,
>  	.handle_int = dw_edma_v0_core_handle_int,
> -	.start = dw_edma_v0_core_start,
>  	.ll_data = dw_edma_v0_core_ll_data,
>  	.ll_link = dw_edma_v0_core_ll_link,
>  	.ch_doorbell = dw_edma_v0_core_ch_doorbell,
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> index 94350bb2bdcd6e29d8a42380160a5bd77caf4680..7f9fe3a6edd94583fd09c80a8d79527ed6383a8c 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> @@ -217,26 +217,10 @@ static void dw_hdma_v0_core_ch_enable(struct dw_edma_chan *chan)
>  		  lower_32_bits(chan->ll_region.paddr));
>  	SET_CH_32(dw, chan->dir, chan->id, llp.msb,
>  		  upper_32_bits(chan->ll_region.paddr));
> -}
> -
> -static void dw_hdma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
> -{
> -	struct dw_edma_chan *chan = chunk->chan;
> -	struct dw_edma_burst *child;
> -	u32 control = 0, i = 0;
> -
> -	if (chunk->cb)
> -		control = DW_HDMA_V0_CB;
> -
> -	list_for_each_entry(child, &chunk->burst->list, list)
> -		dw_hdma_v0_write_ll_data(chan, i++, control, child->sz,
> -					 child->sar, child->dar);
> -
> -	control = DW_HDMA_V0_LLP | DW_HDMA_V0_TCB;
> -	if (!chunk->cb)
> -		control |= DW_HDMA_V0_CB;
>  
> -	dw_hdma_v0_write_ll_link(chan, i, control, chunk->chan->ll_region.paddr);
> +	/* Set consumer cycle */
> +	SET_CH_32(dw, chan->dir, chan->id, cycle_sync,
> +		  HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
>  }
>  
>  static void dw_hdma_v0_sync_ll_data(struct dw_edma_chan *chan)
> @@ -253,26 +237,6 @@ static void dw_hdma_v0_sync_ll_data(struct dw_edma_chan *chan)
>  		readl(chan->ll_region.vaddr.io);
>  }
>  
> -static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> -{
> -	struct dw_edma_chan *chan = chunk->chan;
> -	struct dw_edma *dw = chan->dw;
> -
> -	dw_hdma_v0_core_write_chunk(chunk);
> -
> -	if (first)
> -		dw_hdma_v0_core_ch_enable(chan);
> -
> -	/* Set consumer cycle */
> -	SET_CH_32(dw, chan->dir, chan->id, cycle_sync,
> -		  HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
> -
> -	dw_hdma_v0_sync_ll_data(chan);
> -
> -	/* Doorbell */
> -	SET_CH_32(dw, chan->dir, chan->id, doorbell, HDMA_V0_DOORBELL_START);
> -}
> -
>  static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)
>  {
>  	struct dw_edma *dw = chan->dw;
> @@ -332,7 +296,6 @@ static const struct dw_edma_core_ops dw_hdma_v0_core = {
>  	.ch_count = dw_hdma_v0_core_ch_count,
>  	.ch_status = dw_hdma_v0_core_ch_status,
>  	.handle_int = dw_hdma_v0_core_handle_int,
> -	.start = dw_hdma_v0_core_start,
>  	.ll_data = dw_hdma_v0_core_ll_data,
>  	.ll_link = dw_hdma_v0_core_ll_link,
>  	.ch_doorbell = dw_hdma_v0_core_ch_doorbell,
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

