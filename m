Return-Path: <dmaengine+bounces-7978-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB05CCEA2D9
	for <lists+dmaengine@lfdr.de>; Tue, 30 Dec 2025 17:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AA793026A92
	for <lists+dmaengine@lfdr.de>; Tue, 30 Dec 2025 16:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB6F2641FC;
	Tue, 30 Dec 2025 16:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0B7Q66U"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F643A1E82;
	Tue, 30 Dec 2025 16:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767112258; cv=none; b=RhIj0vYaBITeJ3fhM6Ap19LeTb8The8DS0gER3JWyr2SWUM2y0X9sZSzYnf26tYERdTyIU0kZMdFCBK3WH5mJ5uN7ttE5PlX0Yq5wAwqe1ex8xscjc6mhKtQCrASaLw1HGSF1mXxlKSGEJxK5hiivu7AHGhbPaFKLokUNv9FmgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767112258; c=relaxed/simple;
	bh=xBkplaWe3jxxylobUpSj/kmtOngI9khErBF92jtJ7Ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQTk1fdzf163HNEQhvCakGM7KWvu8yMDRbZQFXT30YRQHYMwgd5vH+K6EGerMx0GG/A2+YTIpV2x+duJVlaN9asHg5Wpasw+kEtaeDzMlJvEzvD5HZyBBT3B/yRIhU3Vt+tjl23vqVmzL/Foh9Q70u4TPl4lQcKwGWs/JzFO5tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p0B7Q66U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8AD5C4CEFB;
	Tue, 30 Dec 2025 16:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767112258;
	bh=xBkplaWe3jxxylobUpSj/kmtOngI9khErBF92jtJ7Ag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p0B7Q66UP68nuME1SLqJlEaLnd6guein2q2GVriVleGpkIbJi/3FzCgdqLRe6tVut
	 VyfauZPJ/+h5e1eTVwCM/xL5J0XeV8k5MxgaL9GpsN8Yhz2NQJX5a9PKdBPahkCBH1
	 eXafAuIE/q3h5SEidXfVZr6hsNyMjTy//tXFzWbSOMn6HNhegXnkY4az7ZlExVJ6mH
	 tnzEfhmF3bcW5eYVOqm035d/SoEiemt0Sj+iYxPjuWJi7TCpeKlXbmXcJNQNPw0GAQ
	 B62bmAR3eXaxana49jJlMzaoRpsh77TPI2p1rbUwLqhEftidQFxTnHe8P4m8yy3t5L
	 fvcg789xk9OSA==
Date: Tue, 30 Dec 2025 22:00:49 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Christoph Hellwig <hch@lst.de>, Niklas Cassel <cassel@kernel.org>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-nvme@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH 01/11] dmaengine: dw-edma: Add spinlock to protect
 DONE_INT_MASK and ABORT_INT_MASK
Message-ID: <u5morpcx47pgyg7emt6yhhyivevwtbgvp7xme4uf6ssrcvew2n@yznzt7mj4ns3>
References: <20251212-edma_ll-v1-0-fc863d9f5ca3@nxp.com>
 <20251212-edma_ll-v1-1-fc863d9f5ca3@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251212-edma_ll-v1-1-fc863d9f5ca3@nxp.com>

On Fri, Dec 12, 2025 at 05:24:40PM -0500, Frank Li wrote:
> The DONE_INT_MASK and ABORT_INT_MASK registers are shared by all DMA
> channels, and modifying them requires a read-modify-write sequence.
> Because this operation is not atomic, concurrent calls to
> dw_edma_v0_core_start() can introduce race conditions if two channels
> update these registers simultaneously.
> 
> Add a spinlock to serialize access to these registers and prevent race
> conditions.
> 

dw_edma_v0_core_start() is called by dw_edma_start_transfer() in 3 places, and
protected by 'chan->vc.lock' in 2 places. Only in dw_edma_device_resume(), it is
not protected. Don't you need to protect it instead?

- Mani

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/dma/dw-edma/dw-edma-v0-core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> index b75fdaffad9a4ea6cd8d15e8f43bea550848b46c..2850a9df80f54d00789144415ed2dfe31dea3965 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> @@ -364,6 +364,7 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  {
>  	struct dw_edma_chan *chan = chunk->chan;
>  	struct dw_edma *dw = chan->dw;
> +	unsigned long flags;
>  	u32 tmp;
>  
>  	dw_edma_v0_core_write_chunk(chunk);
> @@ -408,6 +409,8 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  			}
>  		}
>  		/* Interrupt unmask - done, abort */
> +		raw_spin_lock_irqsave(&dw->lock, flags);
> +
>  		tmp = GET_RW_32(dw, chan->dir, int_mask);
>  		tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
>  		tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
> @@ -416,6 +419,9 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  		tmp = GET_RW_32(dw, chan->dir, linked_list_err_en);
>  		tmp |= FIELD_PREP(EDMA_V0_LINKED_LIST_ERR_MASK, BIT(chan->id));
>  		SET_RW_32(dw, chan->dir, linked_list_err_en, tmp);
> +
> +		raw_spin_unlock_irqrestore(&dw->lock, flags);
> +
>  		/* Channel control */
>  		SET_CH_32(dw, chan->dir, chan->id, ch_control1,
>  			  (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

