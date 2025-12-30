Return-Path: <dmaengine+bounces-7981-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5ADBCEA3E2
	for <lists+dmaengine@lfdr.de>; Tue, 30 Dec 2025 18:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D9611301B814
	for <lists+dmaengine@lfdr.de>; Tue, 30 Dec 2025 17:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410C02C21F0;
	Tue, 30 Dec 2025 17:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JoO1GjzU"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D03414F9D6;
	Tue, 30 Dec 2025 17:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767114097; cv=none; b=scfGsHnddlYbGdiggECcSoJ7EXgx2b8QY90K9k5zPs5uF4UIB/1PQXIFqpOCkUY8NNqQQYStnEsQVbSmjuj/Dsw0KOGVEOFoe0Xjol5TQwglfFCz1X5FjGnv8hPqYCqLLIv1ao7mBVnDea6wyOptTDX28KjKWTuu4knSQ5oH3mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767114097; c=relaxed/simple;
	bh=3VnALxAJ8sDGakcD3yctJqlVkoErim7xAtZJILR5H+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fAvS+V8f4BLkJ+1wdMG2GLtBc2S7DWFFzGWJ2J1eQtTbsqpoqwHGdHCZJpWnjkV4HcpfkJauy00uHQWeKr9nAFxs7emOCpYQtLcPQlYzHG1S2mMlqWkTJt0gGzcPgJHQHfPh6lG3CYDlSX7faBwb9RHUvRvpWdQaP8RzJnYXlrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JoO1GjzU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 325D1C116C6;
	Tue, 30 Dec 2025 17:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767114096;
	bh=3VnALxAJ8sDGakcD3yctJqlVkoErim7xAtZJILR5H+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JoO1GjzUeqE3X2GEOY3/uDYes/7Zxk14dxSgVOozzH4No14e2fcAwneozcN7jAJX3
	 ylMysOfStPwrepIt0IZPMyvP9kv9r3fQgRB1audzsvE4+PBBShJBwJcCbJ9WV4y+CE
	 vfUP7Zo2rlDgwRdPF7CPDVxVuZESHJOrO7Oj8451bV0BSzmZ3i91A8H+yTItJ0I3W0
	 kJes6QwItTE0I+eZXOz+nmNVtOfxDlWu7wgpkANQ5JzUUo3N5M34Ne2hpctGiLD78W
	 gWq2yfEKpsVqkE7gBQrEbFW/MoI/FrG2q1pyIdPkRDrflAPCzv0Bm8j2WM/8MFKLPt
	 +Nkdn4ioJtIRA==
Date: Tue, 30 Dec 2025 22:31:28 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Christoph Hellwig <hch@lst.de>, Niklas Cassel <cassel@kernel.org>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-nvme@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH 11/11] dmaengine: dw-edma: Remove struct dw_edma_chunk
Message-ID: <5l2vl7sfnqjylmhve47pyi6tchqkn2n77zskkdisyynfxx3ftp@x55amadqlxph>
References: <20251212-edma_ll-v1-0-fc863d9f5ca3@nxp.com>
 <20251212-edma_ll-v1-11-fc863d9f5ca3@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251212-edma_ll-v1-11-fc863d9f5ca3@nxp.com>

On Fri, Dec 12, 2025 at 05:24:50PM -0500, Frank Li wrote:
> The current descriptor layout is:
> 
>   struct dw_edma_desc *desc
>    └─ chunk list
>         └─ burst[]
> 
> Creating a DMA descriptor requires at least two kzalloc() calls because
> each chunk is allocated as a linked-list node. Since the number of bursts
> is already known when the descriptor is created, this linked-list layer is
> unnecessary.
> 
> Move the burst array directly into struct dw_edma_desc and remove the
> struct dw_edma_chunk layer entirely.
> 
> Use start_burst and done_burst to track the current bursts, which current
> are in the DMA link list.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/dma/dw-edma/dw-edma-core.c | 130 ++++++++++++-------------------------
>  drivers/dma/dw-edma/dw-edma-core.h |  24 ++++---
>  2 files changed, 57 insertions(+), 97 deletions(-)
> 

[...]

>  static struct dma_async_tx_descriptor *
> @@ -551,8 +499,14 @@ static void dw_hdma_set_callback_result(struct virt_dma_desc *vd,
>  		return;
>  
>  	desc = vd2dw_edma_desc(vd);
> -	if (desc)
> -		residue = desc->alloc_sz - desc->xfer_sz;
> +	residue = desc->alloc_sz;

Now you dereference desc without checking for NULL.

> +
> +	if (desc) {
> +		if (result == DMA_TRANS_NOERROR)
> +			residue -= desc->burst[desc->start_burst - 1].xfer_sz;
> +		else if (desc->done_burst)
> +			residue -= desc->burst[desc->done_burst - 1].xfer_sz;
> +	}
>  
>  	res = &vd->tx_result;
>  	res->result = result;
> @@ -571,7 +525,7 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
>  		switch (chan->request) {
>  		case EDMA_REQ_NONE:
>  			desc = vd2dw_edma_desc(vd);
> -			if (!desc->chunks_alloc) {
> +			if (desc->start_burst >= desc->nburst) {
>  				dw_hdma_set_callback_result(vd,
>  							    DMA_TRANS_NOERROR);
>  				list_del(&vd->node);
> @@ -936,7 +890,7 @@ int dw_edma_probe(struct dw_edma_chip *chip)
>  		goto err_irq_free;
>  
>  	/* Turn debugfs on */
> -	dw_edma_core_debugfs_on(dw);
> +	//dw_edma_core_debugfs_on(dw);

debug code?

>  
>  	chip->dw = dw;
>  
> diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
> index 1930c3bce2bf33fdfbf4e8d99002483a4565faed..ba83c42dee5224dccdf34cec6481e9404a607702 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.h
> +++ b/drivers/dma/dw-edma/dw-edma-core.h
> @@ -46,15 +46,8 @@ struct dw_edma_burst {
>  	u64				sar;
>  	u64				dar;
>  	u32				sz;
> -};
> -
> -struct dw_edma_chunk {
> -	struct list_head		list;
> -	struct dw_edma_chan		*chan;
> -	u8				cb;
> +	/* precalulate summary of previous burst total size */
>  	u32				xfer_sz;
> -	u32                             nburst;
> -	struct dw_edma_burst            burst[] __counted_by(nburst);
>  };
>  
>  struct dw_edma_desc {
> @@ -66,6 +59,12 @@ struct dw_edma_desc {
>  
>  	u32				alloc_sz;
>  	u32				xfer_sz;
> +
> +	u32				done_burst;
> +	u32				start_burst;
> +	u8				cb;
> +	u32				nburst;
> +	struct dw_edma_burst            burst[] __counted_by(nburst);
>  };
>  
>  struct dw_edma_chan {
> @@ -126,7 +125,6 @@ struct dw_edma_core_ops {
>  	void (*ll_link)(struct dw_edma_chan *chan, u32 idx, bool cb, u64 addr);
>  	void (*ch_doorbell)(struct dw_edma_chan *chan);
>  	void (*ch_enable)(struct dw_edma_chan *chan);
> -
>  	void (*ch_config)(struct dw_edma_chan *chan);
>  	void (*debugfs_on)(struct dw_edma *dw);
>  };
> @@ -166,6 +164,14 @@ struct dw_edma_chan *dchan2dw_edma_chan(struct dma_chan *dchan)
>  	return vc2dw_edma_chan(to_virt_chan(dchan));
>  }
>  
> +static inline u64 dw_edma_core_get_ll_paddr(struct dw_edma_chan *chan)

No need of inline.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

