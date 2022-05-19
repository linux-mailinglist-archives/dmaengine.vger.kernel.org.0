Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3890052DC43
	for <lists+dmaengine@lfdr.de>; Thu, 19 May 2022 20:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243522AbiESSCG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 19 May 2022 14:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243526AbiESSCA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 19 May 2022 14:02:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5215AEC8;
        Thu, 19 May 2022 11:01:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B986BB82795;
        Thu, 19 May 2022 18:01:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7641C34113;
        Thu, 19 May 2022 18:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652983314;
        bh=5TB3amHvIS/8xulQW3QDR705oTNqy0oeeRwvOkTmj/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mUGdzAAJft9SNL3NkxRrCUzRXP10P1rYo8kaD+07aUq3fRCS/juZkMmfW/tl6f8ue
         16CktaD02X67HabtSTMHPBBzurRt9SaGHGR1vlZlJVGsSFZ/12Vziz6aRblY7ONbYL
         IZtiVXr5Pv+SYpgIs+zSjg4gUeIw3L7or4DFb8M1w13A9M9myzHkSGA8ZmtYgW5c8j
         YsPYVSsHsk5zlnC01s+yOA8KadFwNwlQHTO6bByxpAfsAuof09Rn3buGlJszx6BA8M
         Tj+XQdEpgLQpcpJLeGaZBWdcwXsR8d7ogL/08tkI5lFtAaUB1yx8Cp/FqADId7cuUB
         C1H8RJWwyuJkw==
Date:   Thu, 19 May 2022 23:31:50 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     sean.wang@mediatek.com, matthias.bgg@gmail.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, nfraprado@collabora.com
Subject: Re: [PATCH v2 2/2] dmaengine: mediatek-cqdma: Add support for
 MediaTek MT6795
Message-ID: <YoaGDjtg0R6NRMmg@matsya>
References: <20220503140624.117213-1-angelogioacchino.delregno@collabora.com>
 <20220503140624.117213-3-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503140624.117213-3-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03-05-22, 16:06, AngeloGioacchino Del Regno wrote:
> Add a compatible string and platform data for the Helio X10 MT6795 SoC.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/dma/mediatek/mtk-cqdma.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/dma/mediatek/mtk-cqdma.c b/drivers/dma/mediatek/mtk-cqdma.c
> index a2fb538d9483..e1772dbf50d5 100644
> --- a/drivers/dma/mediatek/mtk-cqdma.c
> +++ b/drivers/dma/mediatek/mtk-cqdma.c
> @@ -757,8 +757,14 @@ static const struct mtk_cqdma_plat_data cqdma_mt6765 = {
>  	.reg_src2 = 0x60,
>  };
>  
> +static const struct mtk_cqdma_plat_data cqdma_mt6795 = {
> +	.reg_dst2 = 0x44,
> +	.reg_src2 = 0x40,

Please define these registers

> +};
> +
>  static const struct of_device_id mtk_cqdma_match[] = {
>  	{ .compatible = "mediatek,mt6765-cqdma", .data = &cqdma_mt6765 },
> +	{ .compatible = "mediatek,mt6795-cqdma", .data = &cqdma_mt6795 },

where is this documented?

>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, mtk_cqdma_match);
> -- 
> 2.35.1

-- 
~Vinod
