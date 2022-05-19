Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21CCC52DC2F
	for <lists+dmaengine@lfdr.de>; Thu, 19 May 2022 20:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243622AbiESSBg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 19 May 2022 14:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243486AbiESSA7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 19 May 2022 14:00:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A2DA1BD;
        Thu, 19 May 2022 11:00:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36185B824A1;
        Thu, 19 May 2022 18:00:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5540FC385AA;
        Thu, 19 May 2022 18:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652983254;
        bh=tMwvvcFd7Pc3TDADnKu1IpLVMpBVRu1prfu10GKvoVQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TWIl28N9vBe+Kbo5ix6DGCxrW3rbrzUeJgHQN5Xz5xWmTOcJTRXjMf7CT5J08iuFE
         B4zaW/Fnn8X7I97NlUxtAFkBx7itzrexLh5vnMa2eBTPHJn3pHnR2i/UF+x9iFFoIm
         E/MpB7p/lirlqoqkK68qt3j9uHSDsc5J2AS06tsa3WDsSV9IKFprclElB8QtZXqe+Y
         Rx49V2RAcgWWw5BZQ2HCboxG5GcWUMbirDdnBZTIKjUWahMzdTtLLLWrGVWDM/nFeF
         bXxCgt8P2s1S+9ku6SmwtQK1FKqpWCMQa2Z9wjSEA8xHhCPFDZ3moCSzq7YXtIsifc
         VH5/8wpGKBsHA==
Date:   Thu, 19 May 2022 23:30:50 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     sean.wang@mediatek.com, matthias.bgg@gmail.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, nfraprado@collabora.com
Subject: Re: [PATCH v2 1/2] dmaengine: mediatek-cqdma: Add SoC-specific match
 data
Message-ID: <YoaF0mOudZ7zll/7@matsya>
References: <20220503140624.117213-1-angelogioacchino.delregno@collabora.com>
 <20220503140624.117213-2-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503140624.117213-2-angelogioacchino.delregno@collabora.com>
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
> On some SoCs the DST2 and SRC2 registers may be at a different offset:
> add a match data structure and assign it to mt6765 as a preparation
> for adding support for more SoCs.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/dma/mediatek/mtk-cqdma.c | 35 +++++++++++++++++++++++++-------
>  1 file changed, 28 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/dma/mediatek/mtk-cqdma.c b/drivers/dma/mediatek/mtk-cqdma.c
> index f8847c48ba03..a2fb538d9483 100644
> --- a/drivers/dma/mediatek/mtk-cqdma.c
> +++ b/drivers/dma/mediatek/mtk-cqdma.c
> @@ -48,8 +48,6 @@
>  #define MTK_CQDMA_DST			0x20
>  #define MTK_CQDMA_LEN1			0x24
>  #define MTK_CQDMA_LEN2			0x28
> -#define MTK_CQDMA_SRC2			0x60
> -#define MTK_CQDMA_DST2			0x64
>  
>  /* Registers setting */
>  #define MTK_CQDMA_EN_BIT		BIT(0)
> @@ -126,9 +124,20 @@ struct mtk_cqdma_vchan {
>  	bool issue_synchronize;
>  };
>  
> +/**
> + * struct mtk_cqdma_plat_data - SoC specific parameters
> + * @reg_dst2:               dst2 register offset
> + * @reg_src2:               src2 register offset
> + */
> +struct mtk_cqdma_plat_data {
> +	u8 reg_src2;
> +	u8 reg_dst2;
> +};
> +
>  /**
>   * struct mtk_cqdma_device - The struct holding info describing CQDMA
>   *                          device
> + * @plat:                   SoC-specific platform data
>   * @ddev:                   An instance for struct dma_device
>   * @clk:                    The clock that device internal is using
>   * @dma_requests:           The number of VCs the device supports to
> @@ -137,6 +146,7 @@ struct mtk_cqdma_vchan {
>   * @pc:                     The pointer to all the underlying PCs
>   */
>  struct mtk_cqdma_device {
> +	const struct mtk_cqdma_plat_data *plat;
>  	struct dma_device ddev;
>  	struct clk *clk;
>  
> @@ -231,6 +241,8 @@ static int mtk_cqdma_hard_reset(struct mtk_cqdma_pchan *pc)
>  static void mtk_cqdma_start(struct mtk_cqdma_pchan *pc,
>  			    struct mtk_cqdma_vdesc *cvd)
>  {
> +	struct mtk_cqdma_device *cqdma = to_cqdma_dev(cvd->ch);
> +
>  	/* wait for the previous transaction done */
>  	if (mtk_cqdma_poll_engine_done(pc, true) < 0)
>  		dev_err(cqdma2dev(to_cqdma_dev(cvd->ch)), "cqdma wait transaction timeout\n");
> @@ -243,17 +255,17 @@ static void mtk_cqdma_start(struct mtk_cqdma_pchan *pc,
>  	/* setup the source */
>  	mtk_dma_set(pc, MTK_CQDMA_SRC, cvd->src & MTK_CQDMA_ADDR_LIMIT);
>  #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
> -	mtk_dma_set(pc, MTK_CQDMA_SRC2, cvd->src >> MTK_CQDMA_ADDR2_SHFIT);
> +	mtk_dma_set(pc, cqdma->plat->reg_src2, cvd->src >> MTK_CQDMA_ADDR2_SHFIT);
>  #else
> -	mtk_dma_set(pc, MTK_CQDMA_SRC2, 0);
> +	mtk_dma_set(pc, cqdma->plat->reg_src2, 0);
>  #endif
>  
>  	/* setup the destination */
>  	mtk_dma_set(pc, MTK_CQDMA_DST, cvd->dest & MTK_CQDMA_ADDR_LIMIT);
>  #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
> -	mtk_dma_set(pc, MTK_CQDMA_DST2, cvd->dest >> MTK_CQDMA_ADDR2_SHFIT);
> +	mtk_dma_set(pc, cqdma->plat->reg_dst2, cvd->dest >> MTK_CQDMA_ADDR2_SHFIT);
>  #else
> -	mtk_dma_set(pc, MTK_CQDMA_DST2, 0);
> +	mtk_dma_set(pc, cqdma->plat->reg_dst2, 0);
>  #endif
>  
>  	/* setup the length */
> @@ -740,8 +752,13 @@ static void mtk_cqdma_hw_deinit(struct mtk_cqdma_device *cqdma)
>  	pm_runtime_disable(cqdma2dev(cqdma));
>  }
>  
> +static const struct mtk_cqdma_plat_data cqdma_mt6765 = {
> +	.reg_dst2 = 0x64,
> +	.reg_src2 = 0x60,

Please use the macros instead of magic numbers here

> +};
> +
>  static const struct of_device_id mtk_cqdma_match[] = {
> -	{ .compatible = "mediatek,mt6765-cqdma" },
> +	{ .compatible = "mediatek,mt6765-cqdma", .data = &cqdma_mt6765 },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, mtk_cqdma_match);
> @@ -758,6 +775,10 @@ static int mtk_cqdma_probe(struct platform_device *pdev)
>  	if (!cqdma)
>  		return -ENOMEM;
>  
> +	cqdma->plat = device_get_match_data(&pdev->dev);
> +	if (cqdma->plat)
> +		return -EINVAL;
> +
>  	dd = &cqdma->ddev;
>  
>  	cqdma->clk = devm_clk_get(&pdev->dev, "cqdma");
> -- 
> 2.35.1

-- 
~Vinod
