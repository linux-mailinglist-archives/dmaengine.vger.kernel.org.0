Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936176D1FDB
	for <lists+dmaengine@lfdr.de>; Fri, 31 Mar 2023 14:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbjCaMSD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 31 Mar 2023 08:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbjCaMSC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 31 Mar 2023 08:18:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65B81EFD3;
        Fri, 31 Mar 2023 05:18:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78F8E62879;
        Fri, 31 Mar 2023 12:18:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51731C433EF;
        Fri, 31 Mar 2023 12:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680265080;
        bh=SXJQ3TrR+dUVz06v8+gTB9EbZI+oFmVuvn1fAztqsS8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lcfNb4qw0CG6gJHruZ+5x3WNzgYG/Gc066N/YeyyA5kfGHSBBsjqs372XdxcPKi9k
         Q5Stb93aaO2z2crJxHws/O7HTVSu4QjsV6PWVQoyZuOmUQsBl907/M249iUDRHvamb
         TQoDuIjXF3dg99aQr2ZCkd2LaHMIUjpvuEDRwzKrG2ZTlhE+HZYxzH70Rzi1AgO8ea
         mLqZwsDmuXsDsvHV3ftm2DOTkk2qn1vcbyqupbj33yk6LwrVmumAQXpvRWzvxsObu0
         boTLnXJFtBai1o6hpPKsKfRPNOjthPIRDrFhI7gMpAPUABs1KBPvuSkH1oxsbXsvn9
         Ps3Bps1F2ch2Q==
Date:   Fri, 31 Mar 2023 17:47:56 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 3/3] dmaengine: sh: rz-dmac: Add device_pause() callback
Message-ID: <ZCbPdEyAcvRUwyLz@matsya>
References: <20230324094957.115071-1-biju.das.jz@bp.renesas.com>
 <20230324094957.115071-4-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324094957.115071-4-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 24-03-23, 09:49, Biju Das wrote:
> The device_pause() callback is needed for serial DMA (RZ/G2L
> SCIFA). Add support for device_pause() callback.
> 
> Based on a patch in the BSP by Long Luu
> <long.luu.ur@renesas.com>
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  drivers/dma/sh/rz-dmac.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index 3625925d9f9f..a0cfb8f75534 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -822,6 +822,25 @@ static enum dma_status rz_dmac_tx_status(struct dma_chan *chan,
>  	return status;
>  }
>  
> +static int rz_dmac_device_pause(struct dma_chan *chan)
> +{
> +	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
> +	struct rz_dmac *dmac = to_rz_dmac(chan->device);
> +	unsigned int i;
> +	u32 chstat;
> +
> +	for (i = 0; i < 1024; i++) {
> +		chstat = rz_dmac_ch_readl(channel, CHSTAT, 1);
> +		if (!(chstat & CHSTAT_EN))
> +			break;
> +		udelay(1);
> +	}
> +
> +	rz_dmac_set_dmars_register(dmac, channel->index, 0);
> +
> +	return 0;
> +}
> +
>  /*
>   * -----------------------------------------------------------------------------
>   * IRQ handling
> @@ -1111,6 +1130,7 @@ static int rz_dmac_probe(struct platform_device *pdev)
>  	engine->device_terminate_all = rz_dmac_terminate_all;
>  	engine->device_issue_pending = rz_dmac_issue_pending;
>  	engine->device_synchronize = rz_dmac_device_synchronize;
> +	engine->device_pause = rz_dmac_device_pause;

No resume?

>  
>  	engine->copy_align = DMAENGINE_ALIGN_1_BYTE;
>  	dma_set_max_seg_size(engine->dev, U32_MAX);
> -- 
> 2.25.1

-- 
~Vinod
