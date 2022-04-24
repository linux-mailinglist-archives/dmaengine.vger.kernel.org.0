Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D15750D50F
	for <lists+dmaengine@lfdr.de>; Sun, 24 Apr 2022 22:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbiDXUUK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 24 Apr 2022 16:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbiDXUUJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 24 Apr 2022 16:20:09 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881C0AE79;
        Sun, 24 Apr 2022 13:17:07 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id be20so7894712edb.12;
        Sun, 24 Apr 2022 13:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9VAG5BBA2iAQtjhaIG6w6TukavvgoXR4CgW17q/Z4pE=;
        b=kkm33j3638R2NpIgI/Vm/OVl/hBBHzOkTG9ILJXcelS5KYsTKrKLGh1vfoKC2p86Aq
         WQ4csDBH4jNSEkHPZU2EK9IcfLeR52KX3VaeGd4k5Qt0U3LIE5LPGrc0X9X5wpqSI9u4
         tl1EPL/ax8CSc6wkvhe71qthn+dcHiroJnfyryUNSHkCftvKWfKq/JtadKMDQLaIHKQA
         mdc+dL0F7FPmlpzvx516it3eGzS0RGhjjBDtk0VrShLvZ6BRlb7O15uu8KiPTFGYreVN
         lCfDqh0W7A5mvKCmdER8xvae1X1t/Wt9NGnU5ltz5eLU8X4wiIt3OFeY41vcs2VQlUJd
         l6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9VAG5BBA2iAQtjhaIG6w6TukavvgoXR4CgW17q/Z4pE=;
        b=jkxGr1uJ5fw3gqivvcmUCHOIDL04HRAvFobutPlc914rwtnwKz7FfpLx9d9sGMkenx
         W7QRvlKaVk14FVYhEkfM+mzPHERuI2QnVqspz350M66E7ONiYaTI4d8eltA+d6szaHDS
         +zL6dZCy43QTI6jlUPt96Y4mRvKJMM6rmIMAn4QV3+WH05/QjS2lDZxpsQVKmva8iDkj
         6dM4hMGujN7ozM6X64UVfCmLMl7E+glAgHc19u/AODh6LHkczXafxzz5socathaJeAs8
         rquXYdxmzvlhN9o5TWVKKDNDS6BKj+8ta9Lxz2LAkJZU43gQJOhmpR2rzdWfDbhCB67k
         hN6g==
X-Gm-Message-State: AOAM533ffF7aKYJPUO2OFHBoYZDHIK8UTJl/7qTDu6xWpUHCD3v8pwBz
        tPypyzWt1UK0kSZfv/PO67E=
X-Google-Smtp-Source: ABdhPJzUaEOTLO9BMikvPCDcowUWeT20fWyIYhS/9ZbHRwVE4K0VmqxO3vkkhUzfOle/E+ueMAuMrQ==
X-Received: by 2002:a05:6402:5c5:b0:425:e014:f1bc with SMTP id n5-20020a05640205c500b00425e014f1bcmr4040255edx.361.1650831426135;
        Sun, 24 Apr 2022 13:17:06 -0700 (PDT)
Received: from kista.localnet (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id ah13-20020a1709069acd00b006e8a0b3e071sm2902063ejc.110.2022.04.24.13.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 13:17:05 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v3 3/4] dmaengine: sun6i: Add support for 34-bit physical addresses
Date:   Sun, 24 Apr 2022 22:17:04 +0200
Message-ID: <10068288.nUPlyArG6x@kista>
In-Reply-To: <20220424172759.33383-4-samuel@sholland.org>
References: <20220424172759.33383-1-samuel@sholland.org> <20220424172759.33383-4-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Dne nedelja, 24. april 2022 ob 19:27:57 CEST je Samuel Holland napisal(a):
> Recent Allwinner SoCs support >4 GiB of DRAM, so those variants of the
> DMA engine support >32 bit physical addresses. This is accomplished by
> placing the high bits in the "para" word in the DMA descriptor.
> 
> DMA descriptors themselves can be located at >32 bit addresses by
> putting the high bits in the LSBs of the descriptor address register,
> taking advantage of the required DMA descriptor alignment. However,
> support for this is not really necessary, so we can avoid the
> complication by allocating them from the DMA_32 zone.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej Skrabec

> ---
> 
> Changes in v3:
>  - Fix shift warnings for 32-bit dma_addr_t and 32-bit phys_addr_t
>  - Make explicit that v_lli->src/dst only hold the low 32 bits
> 
> Changes in v2:
>  - Fix `checkpatch.pl --strict` style issues (missing spaces)
> 
>  drivers/dma/sun6i-dma.c | 53 +++++++++++++++++++++++++++++------------
>  1 file changed, 38 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index 4436fbd70445..1eb3bafa7324 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -90,6 +90,14 @@
>  
>  #define DMA_CHAN_CUR_PARA	0x1c
>  
> +/*
> + * LLI address mangling
> + *
> + * The LLI link physical address is also mangled, but we avoid dealing
> + * with that by allocating LLIs from the DMA32 zone.
> + */
> +#define SRC_HIGH_ADDR(x)		(((x) & 0x3U) << 16)
> +#define DST_HIGH_ADDR(x)		(((x) & 0x3U) << 18)
>  
>  /*
>   * Various hardware related defines
> @@ -132,6 +140,7 @@ struct sun6i_dma_config {
>  	u32 dst_burst_lengths;
>  	u32 src_addr_widths;
>  	u32 dst_addr_widths;
> +	bool has_high_addr;
>  	bool has_mbus_clk;
>  };
>  
> @@ -623,6 +632,18 @@ static int set_config(struct sun6i_dma_dev *sdev,
>  	return 0;
>  }
>  
> +static inline void sun6i_dma_set_addr(struct sun6i_dma_dev *sdev,
> +				      struct sun6i_dma_lli *v_lli,
> +				      dma_addr_t src, dma_addr_t 
dst)
> +{
> +	v_lli->src = lower_32_bits(src);
> +	v_lli->dst = lower_32_bits(dst);
> +
> +	if (sdev->cfg->has_high_addr)
> +		v_lli->para |= SRC_HIGH_ADDR(upper_32_bits(src)) |
> +			       DST_HIGH_ADDR(upper_32_bits(dst));
> +}
> +
>  static struct dma_async_tx_descriptor *sun6i_dma_prep_dma_memcpy(
>  		struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
>  		size_t len, unsigned long flags)
> @@ -645,16 +666,15 @@ static struct dma_async_tx_descriptor 
*sun6i_dma_prep_dma_memcpy(
>  	if (!txd)
>  		return NULL;
>  
> -	v_lli = dma_pool_alloc(sdev->pool, GFP_NOWAIT, &p_lli);
> +	v_lli = dma_pool_alloc(sdev->pool, GFP_DMA32 | GFP_NOWAIT, &p_lli);
>  	if (!v_lli) {
>  		dev_err(sdev->slave.dev, "Failed to alloc lli 
memory\n");
>  		goto err_txd_free;
>  	}
>  
> -	v_lli->src = src;
> -	v_lli->dst = dest;
>  	v_lli->len = len;
>  	v_lli->para = NORMAL_WAIT;
> +	sun6i_dma_set_addr(sdev, v_lli, src, dest);
>  
>  	burst = convert_burst(8);
>  	width = convert_buswidth(DMA_SLAVE_BUSWIDTH_4_BYTES);
> @@ -705,7 +725,7 @@ static struct dma_async_tx_descriptor 
*sun6i_dma_prep_slave_sg(
>  		return NULL;
>  
>  	for_each_sg(sgl, sg, sg_len, i) {
> -		v_lli = dma_pool_alloc(sdev->pool, GFP_NOWAIT, &p_lli);
> +		v_lli = dma_pool_alloc(sdev->pool, GFP_DMA32 | 
GFP_NOWAIT, &p_lli);
>  		if (!v_lli)
>  			goto err_lli_free;
>  
> @@ -713,8 +733,9 @@ static struct dma_async_tx_descriptor 
*sun6i_dma_prep_slave_sg(
>  		v_lli->para = NORMAL_WAIT;
>  
>  		if (dir == DMA_MEM_TO_DEV) {
> -			v_lli->src = sg_dma_address(sg);
> -			v_lli->dst = sconfig->dst_addr;
> +			sun6i_dma_set_addr(sdev, v_lli,
> +					   sg_dma_address(sg),
> +					   sconfig->dst_addr);
>  			v_lli->cfg = lli_cfg;
>  			sdev->cfg->set_drq(&v_lli->cfg, DRQ_SDRAM, 
vchan->port);
>  			sdev->cfg->set_mode(&v_lli->cfg, 
LINEAR_MODE, IO_MODE);
> @@ -726,8 +747,9 @@ static struct dma_async_tx_descriptor 
*sun6i_dma_prep_slave_sg(
>  				sg_dma_len(sg), flags);
>  
>  		} else {
> -			v_lli->src = sconfig->src_addr;
> -			v_lli->dst = sg_dma_address(sg);
> +			sun6i_dma_set_addr(sdev, v_lli,
> +					   sconfig->src_addr,
> +					   sg_dma_address(sg));
>  			v_lli->cfg = lli_cfg;
>  			sdev->cfg->set_drq(&v_lli->cfg, vchan->port, 
DRQ_SDRAM);
>  			sdev->cfg->set_mode(&v_lli->cfg, IO_MODE, 
LINEAR_MODE);
> @@ -786,7 +808,7 @@ static struct dma_async_tx_descriptor 
*sun6i_dma_prep_dma_cyclic(
>  		return NULL;
>  
>  	for (i = 0; i < periods; i++) {
> -		v_lli = dma_pool_alloc(sdev->pool, GFP_NOWAIT, &p_lli);
> +		v_lli = dma_pool_alloc(sdev->pool, GFP_DMA32 | 
GFP_NOWAIT, &p_lli);
>  		if (!v_lli) {
>  			dev_err(sdev->slave.dev, "Failed to alloc 
lli memory\n");
>  			goto err_lli_free;
> @@ -796,14 +818,16 @@ static struct dma_async_tx_descriptor 
*sun6i_dma_prep_dma_cyclic(
>  		v_lli->para = NORMAL_WAIT;
>  
>  		if (dir == DMA_MEM_TO_DEV) {
> -			v_lli->src = buf_addr + period_len * i;
> -			v_lli->dst = sconfig->dst_addr;
> +			sun6i_dma_set_addr(sdev, v_lli,
> +					   buf_addr + 
period_len * i,
> +					   sconfig->dst_addr);
>  			v_lli->cfg = lli_cfg;
>  			sdev->cfg->set_drq(&v_lli->cfg, DRQ_SDRAM, 
vchan->port);
>  			sdev->cfg->set_mode(&v_lli->cfg, 
LINEAR_MODE, IO_MODE);
>  		} else {
> -			v_lli->src = sconfig->src_addr;
> -			v_lli->dst = buf_addr + period_len * i;
> +			sun6i_dma_set_addr(sdev, v_lli,
> +					   sconfig->src_addr,
> +					   buf_addr + 
period_len * i);
>  			v_lli->cfg = lli_cfg;
>  			sdev->cfg->set_drq(&v_lli->cfg, vchan->port, 
DRQ_SDRAM);
>  			sdev->cfg->set_mode(&v_lli->cfg, IO_MODE, 
LINEAR_MODE);
> @@ -1174,8 +1198,6 @@ static struct sun6i_dma_config sun50i_a64_dma_cfg = {
>  };
>  
>  /*
> - * TODO: Add support for more than 4g physical addressing.
> - *
>   * The A100 binding uses the number of dma channels from the
>   * device tree node.
>   */
> @@ -1194,6 +1216,7 @@ static struct sun6i_dma_config sun50i_a100_dma_cfg = {
>  			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
>  			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
>  			     BIT(DMA_SLAVE_BUSWIDTH_8_BYTES),
> +	.has_high_addr = true,
>  	.has_mbus_clk = true,
>  };
>  
> -- 
> 2.35.1
> 
> 


