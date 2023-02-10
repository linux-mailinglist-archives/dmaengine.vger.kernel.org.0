Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB69A691A80
	for <lists+dmaengine@lfdr.de>; Fri, 10 Feb 2023 09:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbjBJI7d (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Feb 2023 03:59:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbjBJI7a (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Feb 2023 03:59:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2114A1D2;
        Fri, 10 Feb 2023 00:59:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 672CB61CDC;
        Fri, 10 Feb 2023 08:59:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37DC0C433EF;
        Fri, 10 Feb 2023 08:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676019567;
        bh=2Q1YlvwNymVHCAJA7z8rYoDTg4mMIzYexR8YRdQiSOw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tVum6c+/+iO5J2TRKtYVj0dS32KT9pKUFl5ksEpo+9zzQ5YRroj/Mo6QN5X5lzeyj
         5QsWaDoJp30AoY6qSWsmYJ/3TkEYulL9W2XMJMN1lh76mEIvkT80BmJPOP4s2mS9p5
         QPALwYLrsv/WJ14bXL/o9ZF1DM5h0DaitLtAd6xc/3pln/7EkiribfanG8E1MbUw9T
         1Ynl18jNwUPYPP0Ygyqj+cwAFrOmsN4SeFp7riRe1VbmROALJCaz3pECQa+vqKJE8N
         nnkd2H/bCwkt/3nn/lIKzem1At+7LbXed3HtJRuRyb9Uw2m6rDbfPe099pOGaQkwP9
         mxpb0Zir7Ibmg==
Date:   Fri, 10 Feb 2023 14:29:23 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Walker Chen <walker.chen@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] dma: dw-axi-dmac: Add support for StarFive DMA
Message-ID: <Y+YHa7jVpTs9Qg73@matsya>
References: <20230206113811.23133-1-walker.chen@starfivetech.com>
 <20230206113811.23133-3-walker.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206113811.23133-3-walker.chen@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06-02-23, 19:38, Walker Chen wrote:
> Adding DMA reset operation in device probe, and using different
> registers according to the hardware handshake number.

subsystem tag is dmaengine: xxx

> 
> Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
> ---
>  .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 25 ++++++++++++++++---
>  drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  3 +++
>  2 files changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> index a183d93bd7e2..3581810033d2 100644
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> @@ -25,6 +25,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/property.h>
> +#include <linux/reset.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
>  
> @@ -86,7 +87,8 @@ static inline void axi_chan_config_write(struct axi_dma_chan *chan,
>  
>  	cfg_lo = (config->dst_multblk_type << CH_CFG_L_DST_MULTBLK_TYPE_POS |
>  		  config->src_multblk_type << CH_CFG_L_SRC_MULTBLK_TYPE_POS);
> -	if (chan->chip->dw->hdata->reg_map_8_channels) {
> +	if (chan->chip->dw->hdata->reg_map_8_channels &&
> +	    !chan->chip->dw->hdata->use_cfg2) {

what about older/other platforms that dont have use_cfg2?

>  		cfg_hi = config->tt_fc << CH_CFG_H_TT_FC_POS |
>  			 config->hs_sel_src << CH_CFG_H_HS_SEL_SRC_POS |
>  			 config->hs_sel_dst << CH_CFG_H_HS_SEL_DST_POS |
> @@ -541,8 +543,6 @@ static void dw_axi_dma_set_hw_channel(struct axi_dma_chan *chan, bool set)
>  			(chan->id * DMA_APB_HS_SEL_BIT_SIZE));
>  	reg_value |= (val << (chan->id * DMA_APB_HS_SEL_BIT_SIZE));
>  	lo_hi_writeq(reg_value, chip->apb_regs + DMAC_APB_HW_HS_SEL_0);
> -
> -	return;
>  }
>  
>  /*
> @@ -1136,7 +1136,7 @@ static int dma_chan_terminate_all(struct dma_chan *dchan)
>  	axi_chan_disable(chan);
>  
>  	ret = readl_poll_timeout_atomic(chan->chip->regs + DMAC_CHEN, val,
> -					!(val & chan_active), 1000, 10000);
> +					!(val & chan_active), 1000, DMAC_TIMEOUT_US);
>  	if (ret == -ETIMEDOUT)
>  		dev_warn(dchan2dev(dchan),
>  			 "%s failed to stop\n", axi_chan_name(chan));
> @@ -1323,6 +1323,12 @@ static int parse_device_properties(struct axi_dma_chip *chip)
>  
>  	chip->dw->hdata->m_data_width = tmp;
>  
> +	ret = device_property_read_u32(dev, "snps,num-hs-if", &tmp);
> +	if (!ret) {
> +		if (tmp > 16)
> +			chip->dw->hdata->use_cfg2 = true;
> +	}
> +
>  	ret = device_property_read_u32_array(dev, "snps,block-size", carr,
>  					     chip->dw->hdata->nr_channels);
>  	if (ret)
> @@ -1410,6 +1416,16 @@ static int dw_probe(struct platform_device *pdev)
>  	if (IS_ERR(chip->cfgr_clk))
>  		return PTR_ERR(chip->cfgr_clk);
>  
> +	if (of_device_is_compatible(node, "starfive,axi-dma")) {
> +		chip->resets = devm_reset_control_array_get_exclusive(&pdev->dev);
> +		if (IS_ERR(chip->resets))
> +			return PTR_ERR(chip->resets);
> +
> +		ret = reset_control_deassert(chip->resets);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	ret = parse_device_properties(chip);
>  	if (ret)
>  		return ret;
> @@ -1554,6 +1570,7 @@ static const struct dev_pm_ops dw_axi_dma_pm_ops = {
>  static const struct of_device_id dw_dma_of_id_table[] = {
>  	{ .compatible = "snps,axi-dma-1.01a" },
>  	{ .compatible = "intel,kmb-axi-dma" },
> +	{ .compatible = "starfive,axi-dma" },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, dw_dma_of_id_table);
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
> index e9d5eb0fd594..761d95691c02 100644
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
> @@ -21,6 +21,7 @@
>  #define DMAC_MAX_CHANNELS	16
>  #define DMAC_MAX_MASTERS	2
>  #define DMAC_MAX_BLK_SIZE	0x200000
> +#define DMAC_TIMEOUT_US		200000
>  
>  struct dw_axi_dma_hcfg {
>  	u32	nr_channels;
> @@ -33,6 +34,7 @@ struct dw_axi_dma_hcfg {
>  	/* Register map for DMAX_NUM_CHANNELS <= 8 */
>  	bool	reg_map_8_channels;
>  	bool	restrict_axi_burst_len;
> +	bool	use_cfg2;
>  };
>  
>  struct axi_dma_chan {
> @@ -70,6 +72,7 @@ struct axi_dma_chip {
>  	struct clk		*core_clk;
>  	struct clk		*cfgr_clk;
>  	struct dw_axi_dma	*dw;
> +	struct reset_control	*resets;
>  };
>  
>  /* LLI == Linked List Item */
> -- 
> 2.17.1

-- 
~Vinod
