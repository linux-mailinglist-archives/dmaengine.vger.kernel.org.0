Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAC87B80D9
	for <lists+dmaengine@lfdr.de>; Wed,  4 Oct 2023 15:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbjJDN3W (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Oct 2023 09:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242582AbjJDN3V (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 Oct 2023 09:29:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0455A9
        for <dmaengine@vger.kernel.org>; Wed,  4 Oct 2023 06:29:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8274C433C7;
        Wed,  4 Oct 2023 13:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696426156;
        bh=M6YfTC8h5m38Sf7lVbQ5/h66p8TGmPFzgb20twQPEps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SuLcNx3epSLyNYN++jCD0cQZetp8utOU8azUi47B3wfxadn1ilXDaq6VJd1Ka0PFZ
         9Mle6a9KB9SCnUXRc7sEt2oUscTrDTk8v0hbX7J8v2vx7m1GwP5bicrVyLpqDgCNyn
         9jN4oCy5Z8DmDN8+XusHA3PXa5FLTy7mV4zmoqTUagNzmqixoI++PrKjAjp1kXoSA3
         QVILSDDdmKN/XIIqTVJZKHV+d8dzVMHwB0easchx6ohwIPFKMKUw7Caq60fYnMgPGJ
         yzhSW66Vo9UVLdoOLcHQyCF4D3iuKBeLyjnYeqZeFjFyhdtHriu7vh/sm0fyM+NSC3
         Hayee9oRNEPiw==
Date:   Wed, 4 Oct 2023 18:59:10 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Tan En De <ende.tan@starfivetech.com>
Cc:     dmaengine@vger.kernel.org, Eugeniy.Paltsev@synopsys.com
Subject: Re: [v2,1/1] dmaengine: dw-axi-dmac: Support src_maxburst and
 dst_maxburst
Message-ID: <ZR1optUInIcCgTxN@matsya>
References: <20230913110425.1271-1-ende.tan@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913110425.1271-1-ende.tan@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 13-09-23, 19:04, Tan En De wrote:
> Current implementation has hardcoded CHx_CTL.SRC_MSIZE and
> CHx_CTL.DST_MSIZE with a constant, namely DWAXIDMAC_BURST_TRANS_LEN_4.
> 
> However, to support hardware with different source/destination burst
> transaction length, the aforementioned values shall be configurable
> based on dma_slave_config set by client driver.

Are client drivers setting this today, will there be regression if not
set?

> 
> So, this commit is to allow client driver to configure
> - CHx_CTL.SRC_MSIZE via dma_slave_config.src_maxburst
> - CHx_CTL.DST_MSIZE via dma_slave_config.dst_maxburst
> 
> Signed-off-by: Tan En De <ende.tan@starfivetech.com>
> ---
> v1 -> v2:
> - Fixed typo (replaced `return -EINVAL` with `goto err_desc_get` in dma_chan_prep_dma_memcpy()).
> ---
>  .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 38 +++++++++++++++----
>  drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  3 +-
>  2 files changed, 33 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> index dd02f84e404d..f234097dffb9 100644
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> @@ -610,7 +610,7 @@ static int dw_axi_dma_set_hw_desc(struct axi_dma_chan *chan,
>  	size_t axi_block_ts;
>  	size_t block_ts;
>  	u32 ctllo, ctlhi;
> -	u32 burst_len;
> +	u32 burst_len, src_burst_trans_len, dst_burst_trans_len;
>  
>  	axi_block_ts = chan->chip->dw->hdata->block_size[chan->id];
>  
> @@ -674,8 +674,20 @@ static int dw_axi_dma_set_hw_desc(struct axi_dma_chan *chan,
>  
>  	hw_desc->lli->block_ts_lo = cpu_to_le32(block_ts - 1);
>  
> -	ctllo |= DWAXIDMAC_BURST_TRANS_LEN_4 << CH_CTL_L_DST_MSIZE_POS |
> -		 DWAXIDMAC_BURST_TRANS_LEN_4 << CH_CTL_L_SRC_MSIZE_POS;
> +	dst_burst_trans_len = chan->config.dst_maxburst ?
> +				__ffs(chan->config.dst_maxburst) - 1 :
> +				DWAXIDMAC_BURST_TRANS_LEN_4;
> +	if (dst_burst_trans_len > DWAXIDMAC_BURST_TRANS_LEN_MAX)
> +		return -EINVAL;
> +	ctllo |= dst_burst_trans_len << CH_CTL_L_DST_MSIZE_POS;
> +
> +	src_burst_trans_len = chan->config.src_maxburst ?
> +				__ffs(chan->config.src_maxburst) - 1 :
> +				DWAXIDMAC_BURST_TRANS_LEN_4;
> +	if (src_burst_trans_len > DWAXIDMAC_BURST_TRANS_LEN_MAX)
> +		return -EINVAL;
> +	ctllo |= src_burst_trans_len << CH_CTL_L_SRC_MSIZE_POS;
> +
>  	hw_desc->lli->ctl_lo = cpu_to_le32(ctllo);
>  
>  	set_desc_src_master(hw_desc);
> @@ -878,7 +890,7 @@ dma_chan_prep_dma_memcpy(struct dma_chan *dchan, dma_addr_t dst_adr,
>  	size_t block_ts, max_block_ts, xfer_len;
>  	struct axi_dma_hw_desc *hw_desc = NULL;
>  	struct axi_dma_desc *desc = NULL;
> -	u32 xfer_width, reg, num;
> +	u32 xfer_width, reg, num, src_burst_trans_len, dst_burst_trans_len;
>  	u64 llp = 0;
>  	u8 lms = 0; /* Select AXI0 master for LLI fetching */
>  
> @@ -936,9 +948,21 @@ dma_chan_prep_dma_memcpy(struct dma_chan *dchan, dma_addr_t dst_adr,
>  		}
>  		hw_desc->lli->ctl_hi = cpu_to_le32(reg);
>  
> -		reg = (DWAXIDMAC_BURST_TRANS_LEN_4 << CH_CTL_L_DST_MSIZE_POS |
> -		       DWAXIDMAC_BURST_TRANS_LEN_4 << CH_CTL_L_SRC_MSIZE_POS |
> -		       xfer_width << CH_CTL_L_DST_WIDTH_POS |
> +		dst_burst_trans_len = chan->config.dst_maxburst ?
> +					__ffs(chan->config.dst_maxburst) - 1 :
> +					DWAXIDMAC_BURST_TRANS_LEN_4;
> +		if (dst_burst_trans_len > DWAXIDMAC_BURST_TRANS_LEN_MAX)
> +			goto err_desc_get;
> +		reg |= dst_burst_trans_len << CH_CTL_L_DST_MSIZE_POS;
> +
> +		src_burst_trans_len = chan->config.src_maxburst ?
> +					__ffs(chan->config.src_maxburst) - 1 :
> +					DWAXIDMAC_BURST_TRANS_LEN_4;
> +		if (src_burst_trans_len > DWAXIDMAC_BURST_TRANS_LEN_MAX)
> +			goto err_desc_get;
> +		reg |= src_burst_trans_len << CH_CTL_L_SRC_MSIZE_POS;

this is wrong, mempcy should never use slave config value. These values
are for peripheral and not meant for mem-mem transfers

You should try max throughput by aligning the txn to bus width available
on this system

> +
> +		reg = (xfer_width << CH_CTL_L_DST_WIDTH_POS |
>  		       xfer_width << CH_CTL_L_SRC_WIDTH_POS |
>  		       DWAXIDMAC_CH_CTL_L_INC << CH_CTL_L_DST_INC_POS |
>  		       DWAXIDMAC_CH_CTL_L_INC << CH_CTL_L_SRC_INC_POS);
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
> index eb267cb24f67..877bff395740 100644
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
> @@ -265,7 +265,8 @@ enum {
>  	DWAXIDMAC_BURST_TRANS_LEN_128,
>  	DWAXIDMAC_BURST_TRANS_LEN_256,
>  	DWAXIDMAC_BURST_TRANS_LEN_512,
> -	DWAXIDMAC_BURST_TRANS_LEN_1024
> +	DWAXIDMAC_BURST_TRANS_LEN_1024,
> +	DWAXIDMAC_BURST_TRANS_LEN_MAX  = DWAXIDMAC_BURST_TRANS_LEN_1024
>  };
>  
>  #define CH_CTL_L_DST_WIDTH_POS		11
> 
> base-commit: 3669558bdf354cd352be955ef2764cde6a9bf5ec
> -- 
> 2.34.1

-- 
~Vinod
