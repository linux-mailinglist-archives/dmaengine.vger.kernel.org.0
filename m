Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9BB74956B
	for <lists+dmaengine@lfdr.de>; Thu,  6 Jul 2023 08:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbjGFGOu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 6 Jul 2023 02:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbjGFGOt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 6 Jul 2023 02:14:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2E810B;
        Wed,  5 Jul 2023 23:14:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88FC8615E6;
        Thu,  6 Jul 2023 06:14:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56BC4C433C7;
        Thu,  6 Jul 2023 06:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688624088;
        bh=LvtlnLmveQCjcNt5X0lMGVOaLLxeXhImbyrJLLftOUA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hcnhBH6rzZDvnqYjlTkqpQ0hCLUvyWVirAeQ6E8nCYg3vPLaaeBW/hP3bdKckcqCD
         YDpm5z1K9bQjejHAnERFmPkjJj/ZLxYKj5ovHTLvbeF0emsghykD9CrNIFM40rNI5y
         se7NG3Dgmr76/zMd0n0PWMaOjHKAJOxsdyi5A4LqBpKrykDPlozwmxqI5RdFuL8LoH
         2ZhFeGYDboN/jjPoUp1BbX2aIBwrXSipb2YEoDunKvzsYjnZXlGlC/FmsTb3eeLnZJ
         2d7XJwFq5NwZBs6m7aLoZ2PG+dxMLIVEUD1w2q7D30jn/0kn9x6ZHxj6DYhGxKkDAi
         C0Az8n8dTiV4w==
Date:   Thu, 6 Jul 2023 11:44:43 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Hien Huynh <hien.huynh.px@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dma: rz-dmac: Fix destination and source data
 size setting
Message-ID: <ZKZb0x/WCWfghIrr@matsya>
References: <20230630161716.586552-1-biju.das.jz@bp.renesas.com>
 <20230630161716.586552-3-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630161716.586552-3-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 30-06-23, 17:17, Biju Das wrote:
> From: Hien Huynh <hien.huynh.px@renesas.com>

patch title should be dmaengine: xxx

> 
> Before setting DDS and SDS values, we need to clear its value first
> otherwise, we get incorrect results when we change/update the DMA bus
> width several times due to the 'OR' expression.


> 
> Fixes: 5000d37042a6 ("dmaengine: sh: Add DMAC driver for RZ/G2L SoC")
> Signed-off-by: Hien Huynh <hien.huynh.px@renesas.com>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v1->v2:
>  * Updated patch header.
> ---
>  drivers/dma/sh/rz-dmac.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index 229f642fde6b..331ea80f21b0 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -145,8 +145,10 @@ struct rz_dmac {
>  #define CHCFG_REQD			BIT(3)
>  #define CHCFG_SEL(bits)			((bits) & 0x07)
>  #define CHCFG_MEM_COPY			(0x80400008)
> -#define CHCFG_FILL_DDS(a)		(((a) << 16) & GENMASK(19, 16))
> -#define CHCFG_FILL_SDS(a)		(((a) << 12) & GENMASK(15, 12))
> +#define CHCFG_FILL_DDS_MASK		GENMASK(19, 16)
> +#define CHCFG_FILL_DDS(a)		(((a) << 16) & CHCFG_FILL_DDS_MASK)
> +#define CHCFG_FILL_SDS_MASK		GENMASK(15, 12)
> +#define CHCFG_FILL_SDS(a)		(((a) << 12) & CHCFG_FILL_SDS_MASK)

Suggestion: Consider using FIELD_PREP and FIELD_GET for this

>  #define CHCFG_FILL_TM(a)		(((a) & BIT(5)) << 22)
>  #define CHCFG_FILL_AM(a)		(((a) & GENMASK(4, 2)) << 6)
>  #define CHCFG_FILL_LVL(a)		(((a) & BIT(1)) << 5)
> @@ -607,12 +609,14 @@ static int rz_dmac_config(struct dma_chan *chan,
>  	if (val == CHCFG_DS_INVALID)
>  		return -EINVAL;
>  
> +	channel->chcfg &= ~CHCFG_FILL_DDS_MASK;
>  	channel->chcfg |= CHCFG_FILL_DDS(val);
>  
>  	val = rz_dmac_ds_to_val_mapping(config->src_addr_width);
>  	if (val == CHCFG_DS_INVALID)
>  		return -EINVAL;
>  
> +	channel->chcfg &= ~CHCFG_FILL_SDS_MASK;
>  	channel->chcfg |= CHCFG_FILL_SDS(val);
>  
>  	return 0;
> -- 
> 2.25.1

-- 
~Vinod
