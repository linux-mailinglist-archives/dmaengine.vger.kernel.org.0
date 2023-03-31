Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360DA6D1FD4
	for <lists+dmaengine@lfdr.de>; Fri, 31 Mar 2023 14:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbjCaMOx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 31 Mar 2023 08:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbjCaMOw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 31 Mar 2023 08:14:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4021E71D;
        Fri, 31 Mar 2023 05:14:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 375C962879;
        Fri, 31 Mar 2023 12:14:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11638C433EF;
        Fri, 31 Mar 2023 12:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680264890;
        bh=if9Nh6m53l+HgQMTZo/iK9TlEU1LEmyak8p0fBlFn5o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KLNe2q6O4M12nFeT/ShXw1i4wX24M32SS+bIbGc6OCDh6FhY1TCUx+C2b6KOWbAQ7
         5ntidHMF7ETy99975t5lxgkPCfhMHjGrr/rvfJYCdfP7U4yhOTEcVOly54XbDayERb
         fIDu45LCnzVloeLHqoVJAuTmoeDD0jwH6YX+BP0V4ZGgY1fMI3c8MP2CHLzSqsGn/i
         JegLt/yUtcsFNyawcPCyxkSloDDic2fufouYbeQIeqLFoZ3faWHxWwtXzZkDLR5Ep0
         EANbs5EUNSKJa/TvVDGWsDe0qcPErhyXVbwWGQ7RJZbU0E19fwmTHpH0EkNadMgDLd
         pQewu5VAXjbHg==
Date:   Fri, 31 Mar 2023 17:44:46 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/3] dmaengine: sh: rz-dmac: Reinitialize lmdescriptor
 head
Message-ID: <ZCbOtrbTUlxGVWHd@matsya>
References: <20230324094957.115071-1-biju.das.jz@bp.renesas.com>
 <20230324094957.115071-2-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324094957.115071-2-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 24-03-23, 09:49, Biju Das wrote:
> Reinitialize link mode descriptor head during terminate_all().
> It fixes the incorrect serial messages during serial transfer when
> DMA is enabled.
> 
> Based on a patch in the BSP by Long Luu
> <long.luu.ur@renesas.com>
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  drivers/dma/sh/rz-dmac.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index 6b62e01ba658..a04a37ce03fd 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -534,11 +534,18 @@ rz_dmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
>  static int rz_dmac_terminate_all(struct dma_chan *chan)
>  {
>  	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
> +	struct rz_lmdesc *lmdesc = channel->lmdesc.base;
>  	unsigned long flags;
> +	unsigned int i;
> +
>  	LIST_HEAD(head);
>  
>  	rz_dmac_disable_hw(channel);
>  	spin_lock_irqsave(&channel->vc.lock, flags);
> +
> +	for (i = 0; i < DMAC_NR_LMDESC; i++)
> +		lmdesc[i].header = 0;

Any reason not to use memset for this?

> +
>  	list_splice_tail_init(&channel->ld_active, &channel->ld_free);
>  	list_splice_tail_init(&channel->ld_queue, &channel->ld_free);
>  	spin_unlock_irqrestore(&channel->vc.lock, flags);
> -- 
> 2.25.1

-- 
~Vinod
