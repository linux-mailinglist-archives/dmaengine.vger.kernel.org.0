Return-Path: <dmaengine+bounces-129-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 103BB7EED2B
	for <lists+dmaengine@lfdr.de>; Fri, 17 Nov 2023 09:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41D0F1C204AB
	for <lists+dmaengine@lfdr.de>; Fri, 17 Nov 2023 08:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83CDDDDC;
	Fri, 17 Nov 2023 08:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUfA0Pj8"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85F9D529
	for <dmaengine@vger.kernel.org>; Fri, 17 Nov 2023 08:08:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA81C433C7;
	Fri, 17 Nov 2023 08:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700208529;
	bh=HJEtSlR2M5HLiOxVxrCGWQb4pam62naOtP++t26z2iM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cUfA0Pj8JG63mQwdDf3sR2/Dn/dhIdm3bHnL5P+aRL89q9qLinL77fiJiTECUxBen
	 Vx5jBSPVYDw/Ey1JmqFOJb93v2oft1VP8bOjHG5Gi4BQklNejRNuopPknmf4kRmlpu
	 JVCKKeysqMFLilK8BmhEXMIUdhJ4PckONU0sB4CnkPP4ew89GZVY76GHPizoBIDPtW
	 33+Y+xmFZwXaV39BirtxxadqwyKiRGKylIuqXfp56upviS5bdrzQto3IwJiIIA0WO6
	 QwK6S1rgKwUdcstRLJRdHkkxrcBbkvnVU6gUs3ArjntPZ1ayzET0Q+wgrjyh7ijgp8
	 l5b3YM0nYBw+A==
Date: Fri, 17 Nov 2023 13:38:43 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Vinod Koul <vkoul@kernel.org>, Cai Huoqing <cai.huoqing@linux.dev>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH v5 6/6] dmaengine: dw-edma: eDMA: Add sync read before
 starting the DMA transfer in remote setup
Message-ID: <20231117080843.GE10361@thinkpad>
References: <20231114-b4-feature_hdma_mainline-v5-0-7bc86d83c6f7@bootlin.com>
 <20231114-b4-feature_hdma_mainline-v5-6-7bc86d83c6f7@bootlin.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231114-b4-feature_hdma_mainline-v5-6-7bc86d83c6f7@bootlin.com>

On Tue, Nov 14, 2023 at 03:51:59PM +0100, Kory Maincent wrote:
> The Linked list element and pointer are not stored in the same memory as
> the eDMA controller register. If the doorbell register is toggled before
> the full write of the linked list a race condition error will occur.
> In remote setup we can only use a readl to the memory to assure the full
> write has occurred.
> 
> Fixes: 7e4b8a4fbe2c ("dmaengine: Add Synopsys eDMA IP version 0 support")
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

Same comment as patch 5/6. With that addressed,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> 
> Changes in v2:
> - New patch
> 
> Changes in v4:
> - Update git commit message.
> ---
>  drivers/dma/dw-edma/dw-edma-v0-core.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> index b38786f0ad79..6245b720fbfe 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> @@ -346,6 +346,20 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
>  	dw_edma_v0_write_ll_link(chunk, i, control, chunk->ll_region.paddr);
>  }
>  
> +static void dw_edma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
> +{
> +	/*
> +	 * In case of remote eDMA engine setup, the DW PCIe RP/EP internals
> +	 * configuration registers and Application memory are normally accessed
> +	 * over different buses. Ensure LL-data reaches the memory before the
> +	 * doorbell register is toggled by issuing the dummy-read from the remote
> +	 * LL memory in a hope that the posted MRd TLP will return only after the
> +	 * last MWr TLP is completed
> +	 */
> +	if (!(chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
> +		readl(chunk->ll_region.vaddr.io);
> +}
> +
>  static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  {
>  	struct dw_edma_chan *chan = chunk->chan;
> @@ -412,6 +426,9 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  		SET_CH_32(dw, chan->dir, chan->id, llp.msb,
>  			  upper_32_bits(chunk->ll_region.paddr));
>  	}
> +
> +	dw_edma_v0_sync_ll_data(chunk);
> +
>  	/* Doorbell */
>  	SET_RW_32(dw, chan->dir, doorbell,
>  		  FIELD_PREP(EDMA_V0_DOORBELL_CH_MASK, chan->id));
> 
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

