Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3303C6BEFC3
	for <lists+dmaengine@lfdr.de>; Fri, 17 Mar 2023 18:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjCQRg3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Mar 2023 13:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCQRg1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Mar 2023 13:36:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8405FC083A;
        Fri, 17 Mar 2023 10:36:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25DDCB8265B;
        Fri, 17 Mar 2023 17:36:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 033C0C433D2;
        Fri, 17 Mar 2023 17:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679074583;
        bh=WgaEumNAhponm7f5t3p0u/VAa21CfQiv3YN4Tt9H328=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=svUUcsoDYAyRlkH2RXjRDL9MfNu6rB9EiBsAIo81lTreka+5iuEDlLY2on+atLgGG
         uP/Nj3W9I3GbKNDVtk4Q5QE2zSt6lXLddNLSGOd3m7y+g6XKa8JT9Qndb1nbI821nT
         jdaT1xQDIPPfw0jOR589y2/J4sO40hBFzMwNFVPHzMu3gIU3Qr9ekotm0/eHvQscHF
         sqB+wgvpI8bKvdrhLs+4uxYmHGmhqmQrn5pALgVz4+2dlE/68rqqqbfVY+GIAt9FC1
         hsBWJ7FYfrixS3+88tKHe340viD7CsBkxQhqe3kZLIIy0dUlhuUB7XuXGZbY1pW81G
         x+vmO4XfcLsDQ==
Date:   Fri, 17 Mar 2023 23:06:19 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Walker Chen <walker.chen@starfivetech.com>
Cc:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 2/3] dmaengine: dw-axi-dmac: Add support for StarFive
 JH7110 DMA
Message-ID: <ZBSlE/oV4rEwqRIK@matsya>
References: <20230314083537.22571-1-walker.chen@starfivetech.com>
 <20230314083537.22571-3-walker.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314083537.22571-3-walker.chen@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14-03-23, 16:35, Walker Chen wrote:
> Add DMA reset operation in device probe and use different configuration
> on CH_CFG registers according to match data. Update all uses of
> of_device_is_compatible with of_device_get_match_data.
> 
> Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
> ---
>  .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 40 ++++++++++++++++---
>  drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  1 +
>  2 files changed, 35 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> index 4169e1d7d5ca..4390c91af522 100644
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> @@ -21,10 +21,12 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/of_dma.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/property.h>
> +#include <linux/reset.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
>  
> @@ -46,6 +48,10 @@
>  	DMA_SLAVE_BUSWIDTH_32_BYTES	| \
>  	DMA_SLAVE_BUSWIDTH_64_BYTES)
>  
> +#define AXI_DMA_FLAG_HAS_APB_REGS	BIT(0)
> +#define AXI_DMA_FLAG_HAS_RESETS		BIT(1)
> +#define AXI_DMA_FLAG_USE_CFG2		BIT(2)
> +
>  static inline void
>  axi_dma_iowrite32(struct axi_dma_chip *chip, u32 reg, u32 val)
>  {
> @@ -86,7 +92,8 @@ static inline void axi_chan_config_write(struct axi_dma_chan *chan,
>  
>  	cfg_lo = (config->dst_multblk_type << CH_CFG_L_DST_MULTBLK_TYPE_POS |
>  		  config->src_multblk_type << CH_CFG_L_SRC_MULTBLK_TYPE_POS);
> -	if (chan->chip->dw->hdata->reg_map_8_channels) {
> +	if (chan->chip->dw->hdata->reg_map_8_channels &&
> +	    !chan->chip->dw->hdata->use_cfg2) {
>  		cfg_hi = config->tt_fc << CH_CFG_H_TT_FC_POS |
>  			 config->hs_sel_src << CH_CFG_H_HS_SEL_SRC_POS |
>  			 config->hs_sel_dst << CH_CFG_H_HS_SEL_DST_POS |
> @@ -1140,7 +1147,7 @@ static int dma_chan_terminate_all(struct dma_chan *dchan)
>  	axi_chan_disable(chan);
>  
>  	ret = readl_poll_timeout_atomic(chan->chip->regs + DMAC_CHEN, val,
> -					!(val & chan_active), 1000, 10000);
> +					!(val & chan_active), 1000, 200000);

why is timeout increased, if there is a reason that needs to be
documented and preferably in a separate patch

>  	if (ret == -ETIMEDOUT)
>  		dev_warn(dchan2dev(dchan),
>  			 "%s failed to stop\n", axi_chan_name(chan));
> @@ -1367,10 +1374,11 @@ static int parse_device_properties(struct axi_dma_chip *chip)
>  
>  static int dw_probe(struct platform_device *pdev)
>  {
> -	struct device_node *node = pdev->dev.of_node;
>  	struct axi_dma_chip *chip;
>  	struct dw_axi_dma *dw;
>  	struct dw_axi_dma_hcfg *hdata;
> +	struct reset_control *resets;
> +	unsigned int flags;
>  	u32 i;
>  	int ret;
>  
> @@ -1398,12 +1406,25 @@ static int dw_probe(struct platform_device *pdev)
>  	if (IS_ERR(chip->regs))
>  		return PTR_ERR(chip->regs);
>  
> -	if (of_device_is_compatible(node, "intel,kmb-axi-dma")) {
> +	flags = (uintptr_t)of_device_get_match_data(&pdev->dev);
> +	if (flags & AXI_DMA_FLAG_HAS_APB_REGS) {
>  		chip->apb_regs = devm_platform_ioremap_resource(pdev, 1);
>  		if (IS_ERR(chip->apb_regs))
>  			return PTR_ERR(chip->apb_regs);
>  	}
>  
> +	if (flags & AXI_DMA_FLAG_HAS_RESETS) {
> +		resets = devm_reset_control_array_get_exclusive(&pdev->dev);
> +		if (IS_ERR(resets))
> +			return PTR_ERR(resets);
> +
> +		ret = reset_control_deassert(resets);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	chip->dw->hdata->use_cfg2 = !!(flags & AXI_DMA_FLAG_USE_CFG2);
> +
>  	chip->core_clk = devm_clk_get(chip->dev, "core-clk");
>  	if (IS_ERR(chip->core_clk))
>  		return PTR_ERR(chip->core_clk);
> @@ -1554,8 +1575,15 @@ static const struct dev_pm_ops dw_axi_dma_pm_ops = {
>  };
>  
>  static const struct of_device_id dw_dma_of_id_table[] = {
> -	{ .compatible = "snps,axi-dma-1.01a" },
> -	{ .compatible = "intel,kmb-axi-dma" },
> +	{
> +		.compatible = "snps,axi-dma-1.01a"
> +	}, {
> +		.compatible = "intel,kmb-axi-dma",
> +		.data = (void *)AXI_DMA_FLAG_HAS_APB_REGS,
> +	}, {
> +		.compatible = "starfive,jh7110-axi-dma",
> +		.data = (void *)(AXI_DMA_FLAG_HAS_RESETS | AXI_DMA_FLAG_USE_CFG2),
> +	},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, dw_dma_of_id_table);
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
> index e9d5eb0fd594..eb267cb24f67 100644
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
> @@ -33,6 +33,7 @@ struct dw_axi_dma_hcfg {
>  	/* Register map for DMAX_NUM_CHANNELS <= 8 */
>  	bool	reg_map_8_channels;
>  	bool	restrict_axi_burst_len;
> +	bool	use_cfg2;
>  };
>  
>  struct axi_dma_chan {
> -- 
> 2.17.1

-- 
~Vinod
