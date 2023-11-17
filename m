Return-Path: <dmaengine+bounces-128-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B61D17EED19
	for <lists+dmaengine@lfdr.de>; Fri, 17 Nov 2023 09:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48C9AB209B7
	for <lists+dmaengine@lfdr.de>; Fri, 17 Nov 2023 08:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB969DF69;
	Fri, 17 Nov 2023 08:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OriicWON"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07C9DDDC
	for <dmaengine@vger.kernel.org>; Fri, 17 Nov 2023 08:07:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA21AC433C8;
	Fri, 17 Nov 2023 08:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700208434;
	bh=8mPk0+JYm3DQ/U1OTjZqnq0hA5XUiluL2NaSKKnbAJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OriicWONuG8ZI22bAM9PCopeJt/Z9pIhW1mOi/bs1Dt1V7534fiCKWT/uAJQKnxv6
	 o20fTzhj7ro3gXNxZxV5913jOUQGvWe+iAL2I6IcXlw8GyjyJmL458pxG3BkAGR+wN
	 +yng31p5VYm1wweQ8QTOFi//29G3IPyUEPP/eKz6mXIpAiG+keEpA7yhTKI40kN8p5
	 dqfI1HrWOygp1iDSIwleHGMsCJ7LswnKNDkoVRmVy/b91ONEo6XtSdq7Djo5OcVVrg
	 iRhYwFZT57GQb6CmK561NK3/TKPBYG1niWSxndq361GKJpTQLXPIOVlDxf5thCHMCu
	 XBGyvBUIkj9Gw==
Date: Fri, 17 Nov 2023 13:37:08 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Vinod Koul <vkoul@kernel.org>, Cai Huoqing <cai.huoqing@linux.dev>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH v5 5/6] dmaengine: dw-edma: HDMA: Add sync read before
 starting the DMA transfer in remote setup
Message-ID: <20231117080708.GD10361@thinkpad>
References: <20231114-b4-feature_hdma_mainline-v5-0-7bc86d83c6f7@bootlin.com>
 <20231114-b4-feature_hdma_mainline-v5-5-7bc86d83c6f7@bootlin.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231114-b4-feature_hdma_mainline-v5-5-7bc86d83c6f7@bootlin.com>

On Tue, Nov 14, 2023 at 03:51:58PM +0100, Kory Maincent wrote:
> The Linked list element and pointer are not stored in the same memory as
> the HDMA controller register. If the doorbell register is toggled before
> the full write of the linked list a race condition error will occur.
> In remote setup we can only use a readl to the memory to assure the full
> write has occurred.
> 
> Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Few nitpicks below. With those addressed,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

> ---
> 
> Changes in v2:
> - Move the sync read in a function.
> - Add commments
> 
> Changes in v4:
> - Update git commit message.
> ---
>  drivers/dma/dw-edma/dw-hdma-v0-core.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> index 04b0bcb6ded9..13b6aec6a6de 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> @@ -222,6 +222,20 @@ static void dw_hdma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
>  	dw_hdma_v0_write_ll_link(chunk, i, control, chunk->ll_region.paddr);
>  }
>  
> +static void dw_hdma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
> +{
> +	/*
> +	 * In case of remote HDMA engine setup, the DW PCIe RP/EP internals

s/internals/internal

> +	 * configuration registers and Application memory are normally accessed

s/Application/application

> +	 * over different buses. Ensure LL-data reaches the memory before the
> +	 * doorbell register is toggled by issuing the dummy-read from the remote
> +	 * LL memory in a hope that the posted MRd TLP will return only after the

MRd TLP is not posted.

- Mani

> +	 * last MWr TLP is completed
> +	 */
> +	if (!(chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
> +		readl(chunk->ll_region.vaddr.io);
> +}
> +
>  static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  {
>  	struct dw_edma_chan *chan = chunk->chan;
> @@ -252,6 +266,9 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  	/* Set consumer cycle */
>  	SET_CH_32(dw, chan->dir, chan->id, cycle_sync,
>  		  HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
> +
> +	dw_hdma_v0_sync_ll_data(chunk);
> +
>  	/* Doorbell */
>  	SET_CH_32(dw, chan->dir, chan->id, doorbell, HDMA_V0_DOORBELL_START);
>  }
> 
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

