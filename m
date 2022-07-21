Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAD957CAAE
	for <lists+dmaengine@lfdr.de>; Thu, 21 Jul 2022 14:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbiGUMeA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Jul 2022 08:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233628AbiGUMd7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Jul 2022 08:33:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F398474CC7;
        Thu, 21 Jul 2022 05:33:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD6C1B8245B;
        Thu, 21 Jul 2022 12:33:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98705C3411E;
        Thu, 21 Jul 2022 12:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658406836;
        bh=PGV+noUBcZqBx15ZnN684+CnULiOuHKNRWDlzeezA1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rBf6IwdijioubyLK+bZRncAj4nNTUCZyWYVaVX8jaPrlnjG2ZX3JHzHb8Alc3q1ht
         /bk3Tf95H5nwl6rOG9vocT9lN5ovkBfCpU5XjNqKB/3kxTc+/kdUntcZzeSY4Tf9Rg
         1fIbd6cp+kmjuEnC6BNNzjrvz5D5s+SiftLI/+zritRUO3h1GoDBKnxcDHdyBOGdeX
         +bzzBUiNWeixcUa/BRYuWRp1qeBjx392k2ocxe81WfCNWzvi230wrITQ9PNqWW6Fiy
         Z1VrGr9WbJj9+Wg1ldYfrrT50wCdky4POkSfxn7NmRcpaEVMUuKKw81Xls/W3525T3
         lkrGYigfSB8YQ==
Date:   Thu, 21 Jul 2022 18:03:51 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Ben Dooks <ben.dooks@sifive.com>
Cc:     dmaengine@vger.kernel.org, Eugeniy.Paltsev@synopsys.com,
        linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>
Subject: Re: [PATCH 3/3] dmaengine: dw-axi-dmac: ignore interrupt if no
 descriptor
Message-ID: <YtlHr2gZQQg5mago@matsya>
References: <20220708170153.269991-1-ben.dooks@sifive.com>
 <20220708170153.269991-4-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708170153.269991-4-ben.dooks@sifive.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 08-07-22, 18:01, Ben Dooks wrote:
> If the channel has no descriptor and the interrupt is raised then the
> kernel will OOPS. Check the result of vchan_next_desc() in the handler
> axi_chan_block_xfer_complete() to avoid the error happening.

Applied, thanks

> 
> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
> ---
>  drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> index d6ef5f49f281..1fedf4376678 100644
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> @@ -1082,6 +1082,11 @@ static void axi_chan_block_xfer_complete(struct axi_dma_chan *chan)
>  
>  	/* The completed descriptor currently is in the head of vc list */
>  	vd = vchan_next_desc(&chan->vc);
> +	if (!vd) {
> +		dev_err(chan2dev(chan), "BUG: %s, IRQ with no descriptors\n",
> +			axi_chan_name(chan));
> +		goto out;
> +	}
>  
>  	if (chan->cyclic) {
>  		desc = vd_to_axi_desc(vd);
> @@ -1111,6 +1116,7 @@ static void axi_chan_block_xfer_complete(struct axi_dma_chan *chan)
>  		axi_chan_start_first_queued(chan);
>  	}
>  
> +out:
>  	spin_unlock_irqrestore(&chan->vc.lock, flags);
>  }
>  
> -- 
> 2.35.1

-- 
~Vinod
