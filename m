Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C207B18A4
	for <lists+dmaengine@lfdr.de>; Thu, 28 Sep 2023 12:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjI1Kyi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Sep 2023 06:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjI1Kyi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Sep 2023 06:54:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4850C126;
        Thu, 28 Sep 2023 03:54:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59EADC433C8;
        Thu, 28 Sep 2023 10:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695898474;
        bh=uYkzoSuk+8k840ZzRDVFN9ZAHdxAYvdbGmTtbbj7LLA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cejLGD5IofYWcTWrU92hf13DVSd0GXPcTMDzIFPr8oP4I0hC+QCmHLfigHBtUt30A
         eFTpQdTn62x6xLgvw6518mnRkzht82J/mFMDn/NYkn0lk9BnFoUDYqlAR829TjCEoc
         hv8SZrMMgcaxx+XzNfGTcCQ4AaSfxnwX1Vk6FO6kqaU1A7/0OZafPzLGsP0dRYN+a/
         qapxhUOQR/SD6jQqlFXoHE1LjN3BEbeN7OBLrwF1hZ0Ln3/wkGsitPLOgeqN9bbHIi
         y+eC0f2+iEES04x+mhoGhyQpPdEylr2icwdi+DKmuLTJTYjxAtS99JRDXP9vwXSbmO
         S24cyy8IvzCYg==
Date:   Thu, 28 Sep 2023 16:24:31 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>,
        Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
        Michal Simek <michal.simek@amd.com>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dmaengine: xilinx: xdma: Support cyclic transfers
Message-ID: <ZRVbZwQz13hL2QfY@matsya>
References: <20230922162056.594933-1-miquel.raynal@bootlin.com>
 <20230922162056.594933-3-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922162056.594933-3-miquel.raynal@bootlin.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 22-09-23, 18:20, Miquel Raynal wrote:

> @@ -583,7 +690,36 @@ static int xdma_alloc_chan_resources(struct dma_chan *chan)
>  static enum dma_status xdma_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
>  				      struct dma_tx_state *state)
>  {
> -	return dma_cookie_status(chan, cookie, state);
> +	struct xdma_chan *xdma_chan = to_xdma_chan(chan);
> +	struct xdma_desc *desc = NULL;
> +	struct virt_dma_desc *vd;
> +	enum dma_status ret;
> +	unsigned long flags;
> +	unsigned int period_idx;
> +	u32 residue = 0;
> +
> +	ret = dma_cookie_status(chan, cookie, state);
> +	if (ret == DMA_COMPLETE)
> +		return ret;
> +
> +	spin_lock_irqsave(&xdma_chan->vchan.lock, flags);
> +
> +	vd = vchan_find_desc(&xdma_chan->vchan, cookie);
> +	if (vd)
> +		desc = to_xdma_desc(vd);

vd is not used in below check, so should be done after below checks, why
do this for cyclic case?

Otherwise series lgtm, just fix the error reported by test bot

> +	if (!desc || !desc->cyclic) {
> +		spin_unlock_irqrestore(&xdma_chan->vchan.lock, flags);
> +		return ret;
> +	}
-- 
~Vinod
