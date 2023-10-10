Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454F17BFFDD
	for <lists+dmaengine@lfdr.de>; Tue, 10 Oct 2023 16:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbjJJO7W (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Oct 2023 10:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbjJJO7V (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 10 Oct 2023 10:59:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE9D9E;
        Tue, 10 Oct 2023 07:59:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF85C433C7;
        Tue, 10 Oct 2023 14:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696949959;
        bh=P9LG2dSjceMRQqznAdK4gwF7zqt3DuU49ysbI5+pOfQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Om4QRJ3l0iQFau8382Vn9c7ET+eUt/cdIijQ5Rv4pa0bekSOZSDQKAeHSOBWKTOYi
         Tmh2BWL/4BKUKRmPN3Ro2M7GcV3THvBEBblyvdvKVufCPH95+6hqKabrYx2dyjoFnw
         gJIypwfgM5hDVQJ8g8Deg2BACXxxRMjg/PsTH3UQMpRJEqrZzLPWxDqJduGXjTMP+q
         ygGGUBW/W3YoaZZRVAKKm0wZ0lksxBo5KQnVzdDFqkS4VpAvKkW6fICu17XzaCV1LR
         2/wj6K2it1V/UeikHV88/erykfND+g00GaSzrxwJ0fi63ygVanT3XYvWNZ1I6Na57V
         zMZyAacoMMfew==
Date:   Tue, 10 Oct 2023 20:29:06 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     =?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>
Cc:     Cai Huoqing <cai.huoqing@linux.dev>,
        Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH v2 2/5] dmaengine: dw-edma: Typos fixes
Message-ID: <20231010145906.GL4884@thinkpad>
References: <20231002131749.2977952-1-kory.maincent@bootlin.com>
 <20231002131749.2977952-3-kory.maincent@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231002131749.2977952-3-kory.maincent@bootlin.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Oct 02, 2023 at 03:17:46PM +0200, Köry Maincent wrote:
> From: Kory Maincent <kory.maincent@bootlin.com>
> 
> Fix "HDMA_V0_REMOTEL_STOP_INT_EN" typo error.
> Fix "HDMA_V0_LOCAL_STOP_INT_EN" to "HDMA_V0_LOCAL_ABORT_INT_EN" as the STOP
> bit is already set in the same line.
> 

You should split this into two patches. First one is a typo and is harmless, but
the second is a _bug_.

- Mani

> Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> ---
>  drivers/dma/dw-edma/dw-hdma-v0-core.c | 2 +-
>  drivers/dma/dw-edma/dw-hdma-v0-regs.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> index 3e78d4fd3955..0afafc683a9e 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> @@ -235,7 +235,7 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  		/* Interrupt enable&unmask - done, abort */
>  		tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup) |
>  		      HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK |
> -		      HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_STOP_INT_EN;
> +		      HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_ABORT_INT_EN;
>  		SET_CH_32(dw, chan->dir, chan->id, int_setup, tmp);
>  		/* Channel control */
>  		SET_CH_32(dw, chan->dir, chan->id, control1, HDMA_V0_LINKLIST_EN);
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-regs.h b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> index a974abdf8aaf..eab5fd7177e5 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> @@ -15,7 +15,7 @@
>  #define HDMA_V0_LOCAL_ABORT_INT_EN		BIT(6)
>  #define HDMA_V0_REMOTE_ABORT_INT_EN		BIT(5)
>  #define HDMA_V0_LOCAL_STOP_INT_EN		BIT(4)
> -#define HDMA_V0_REMOTEL_STOP_INT_EN		BIT(3)
> +#define HDMA_V0_REMOTE_STOP_INT_EN		BIT(3)
>  #define HDMA_V0_ABORT_INT_MASK			BIT(2)
>  #define HDMA_V0_STOP_INT_MASK			BIT(0)
>  #define HDMA_V0_LINKLIST_EN			BIT(0)
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
