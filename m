Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9439D4E6E39
	for <lists+dmaengine@lfdr.de>; Fri, 25 Mar 2022 07:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244817AbiCYGhL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 25 Mar 2022 02:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244800AbiCYGhK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 25 Mar 2022 02:37:10 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE59C5587
        for <dmaengine@vger.kernel.org>; Thu, 24 Mar 2022 23:35:36 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id bc27so5702433pgb.4
        for <dmaengine@vger.kernel.org>; Thu, 24 Mar 2022 23:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ygQ6KzNJyrC8Co7cre33GRXB9soxWum63xwaFXIGC8M=;
        b=MGuPn9iEeiCeuUmaIkNf2eF/dvBtL1o8D7eIZ+8m8LkKKMxmPnhtPTYFWGmSWF9s1f
         67hG+NJiAIhdJyxH5hndivA9G/oGyreM0/UI6hwfk7vgTKbrRh7S3xyhn74AfDcuCj80
         YgN9WUD2Csk4RyL8vD7BcnKuGZmGKKESloHeVE+aj3s8US5P8IZNxa4gunB1lfepM4C3
         xV8Q4tgl+6S7rgQsi2NIkk6WJXyG+6iWEuq+0zKR/3QcrRuGrfZDWxyr3LjbUq+pdUvy
         BKP7tmLo8ZurXY5rFv6FqIwa0/Bnq8VxsZIcIMAyRU38rWqDVmfShYjr/FlTWB5QVmi9
         O2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ygQ6KzNJyrC8Co7cre33GRXB9soxWum63xwaFXIGC8M=;
        b=o15ilHY1HFOwVJdOU3iBXk5BMAcdwIN1B4KBEwMosVDNf+iHPsSlhdaySDkcYMYU14
         hn4KDVjq0/DT+ITAzUxldLr4HblCQJ0m4fKFzGNSG75Uhi7iuuJNYQ6W6qYshC1OxSSa
         cW/IB9ZaiRTYjbXy61ARx2lgfyvovQriIqc9rMne7a66q72Ype2bp7uo3XJGB5i50HNU
         BOZ9aisAXuWWhMeaxUlX1OFmyY4tHG09mgv3bg1Ds1/TpubEb5rpXRmyiru3mwTUPozE
         MauIM9STak6MOelHqxdxylKHDPCJ+yrlCH+LKUYVZEBrEGGFrNhuDrVhI2wCC9dwar4F
         M8eA==
X-Gm-Message-State: AOAM532bI6AXmoaUIIVRzkYiu3e7Yx4IxHaXyH3pNL0HZs6Wl1sS1ScU
        q5iEJ8c+FX8UU4FhJFxMco+q
X-Google-Smtp-Source: ABdhPJwhC/fUP8SB/U46TPdIK+mBlYUwzB+NT7gLv2qdOWMfYtV66DJWUjuhLagJCBmIMqfTqyYeyg==
X-Received: by 2002:a65:61a2:0:b0:380:caf8:cbb3 with SMTP id i2-20020a6561a2000000b00380caf8cbb3mr6802361pgv.249.1648190135772;
        Thu, 24 Mar 2022 23:35:35 -0700 (PDT)
Received: from thinkpad ([27.111.75.218])
        by smtp.gmail.com with ESMTPSA id o22-20020a056a0015d600b004fb03c903c3sm2140749pfu.71.2022.03.24.23.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 23:35:35 -0700 (PDT)
Date:   Fri, 25 Mar 2022 12:05:28 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/25] dmaengine: dw-edma: Move eDMA data pointer to
 DebugFS node descriptor
Message-ID: <20220325063528.GD4675@thinkpad>
References: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
 <20220324014836.19149-18-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324014836.19149-18-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Mar 24, 2022 at 04:48:28AM +0300, Serge Semin wrote:
> The last thing that really stops the DebugFS part of the eDMA driver from
> supporting the multi-eDMA platform in is keeping the eDMA private data
> pointer in the static area of the DebugFS module. Since the DebugFS node
> descriptors are now kz-allocated we can freely move that pointer to being
> preserved in the descriptors. After the DebugFS initialization procedure
> that pointer will be used in the DebugFS files getter to access the common
> CSRs space and the context CSRs spin-lock. So the main part of this change
> is connected with the DebugFS nodes descriptors initialization macros,
> which aside with already defined prototypes now require to have the DW
> eDMA private data pointer passed.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/dma/dw-edma/dw-edma-v0-debugfs.c | 240 +++++++++++------------
>  1 file changed, 118 insertions(+), 122 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> index b34a68964232..353269a3680b 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> @@ -13,53 +13,55 @@
>  #include "dw-edma-v0-regs.h"
>  #include "dw-edma-core.h"
>  
> -#define REGS_ADDR(name) \
> -	((void __iomem *)&regs->name)
> +#define REGS_ADDR(dw, name)							\
> +	({									\
> +		struct dw_edma_v0_regs __iomem *__regs = (dw)->chip->reg_base;	\
> +										\
> +		(void __iomem *)&__regs->name;					\
> +	})
>  
> -#define REGS_CH_ADDR(name, _dir, _ch)						\
> +#define REGS_CH_ADDR(dw, name, _dir, _ch)					\
>  	({									\
>  		struct dw_edma_v0_ch_regs __iomem *__ch_regs;			\
>  										\
>  		if ((dw)->chip->mf == EDMA_MF_EDMA_LEGACY)			\
> -			__ch_regs = &regs->type.legacy.ch;			\
> +			__ch_regs = REGS_ADDR(dw, type.legacy.ch);		\
>  		else if (_dir == EDMA_DIR_READ)					\
> -			__ch_regs = &regs->type.unroll.ch[_ch].rd;		\
> +			__ch_regs = REGS_ADDR(dw, type.unroll.ch[_ch].rd);	\
>  		else								\
> -			__ch_regs = &regs->type.unroll.ch[_ch].wr;		\
> +			__ch_regs = REGS_ADDR(dw, type.unroll.ch[_ch].wr);	\
>  										\
>  		(void __iomem *)&__ch_regs->name;				\
>  	})
>  
> -#define REGISTER(name) \
> -	{ #name, REGS_ADDR(name) }
> +#define REGISTER(dw, name) \
> +	{ dw, #name, REGS_ADDR(dw, name) }
>  
> -#define CTX_REGISTER(name, dir, ch) \
> -	{ #name, REGS_CH_ADDR(name, dir, ch), dir, ch }
> +#define CTX_REGISTER(dw, name, dir, ch) \
> +	{ dw, #name, REGS_CH_ADDR(dw, name, dir, ch), dir, ch }
>  
> -#define WR_REGISTER(name) \
> -	{ #name, REGS_ADDR(wr_##name) }
> -#define RD_REGISTER(name) \
> -	{ #name, REGS_ADDR(rd_##name) }
> +#define WR_REGISTER(dw, name) \
> +	{ dw, #name, REGS_ADDR(dw, wr_##name) }
> +#define RD_REGISTER(dw, name) \
> +	{ dw, #name, REGS_ADDR(dw, rd_##name) }
>  
> -#define WR_REGISTER_LEGACY(name) \
> -	{ #name, REGS_ADDR(type.legacy.wr_##name) }
> +#define WR_REGISTER_LEGACY(dw, name) \
> +	{ dw, #name, REGS_ADDR(dw, type.legacy.wr_##name) }
>  #define RD_REGISTER_LEGACY(name) \
> -	{ #name, REGS_ADDR(type.legacy.rd_##name) }
> +	{ dw, #name, REGS_ADDR(dw, type.legacy.rd_##name) }
>  
> -#define WR_REGISTER_UNROLL(name) \
> -	{ #name, REGS_ADDR(type.unroll.wr_##name) }
> -#define RD_REGISTER_UNROLL(name) \
> -	{ #name, REGS_ADDR(type.unroll.rd_##name) }
> +#define WR_REGISTER_UNROLL(dw, name) \
> +	{ dw, #name, REGS_ADDR(dw, type.unroll.wr_##name) }
> +#define RD_REGISTER_UNROLL(dw, name) \
> +	{ dw, #name, REGS_ADDR(dw, type.unroll.rd_##name) }
>  
>  #define WRITE_STR				"write"
>  #define READ_STR				"read"
>  #define CHANNEL_STR				"channel"
>  #define REGISTERS_STR				"registers"
>  
> -static struct dw_edma				*dw;
> -static struct dw_edma_v0_regs			__iomem *regs;
> -
>  struct dw_edma_debugfs_entry {
> +	struct dw_edma				*dw;
>  	const char				*name;
>  	void __iomem				*reg;
>  	enum dw_edma_dir			dir;
> @@ -69,10 +71,11 @@ struct dw_edma_debugfs_entry {
>  static int dw_edma_debugfs_u32_get(void *data, u64 *val)
>  {
>  	struct dw_edma_debugfs_entry __iomem *entry = data;
> +	struct dw_edma *dw = entry->dw;
>  	void __iomem *reg = entry->reg;
>  
>  	if (dw->chip->mf == EDMA_MF_EDMA_LEGACY &&
> -	    reg >= (void __iomem *)&regs->type.legacy.ch) {
> +	    reg >= REGS_ADDR(dw, type.legacy.ch)) {
>  		unsigned long flags;
>  		u32 viewport_sel;
>  
> @@ -81,7 +84,7 @@ static int dw_edma_debugfs_u32_get(void *data, u64 *val)
>  
>  		raw_spin_lock_irqsave(&dw->lock, flags);
>  
> -		writel(viewport_sel, &regs->type.legacy.viewport_sel);
> +		writel(viewport_sel, REGS_ADDR(dw, type.legacy.viewport_sel));
>  		*val = readl(reg);
>  
>  		raw_spin_unlock_irqrestore(&dw->lock, flags);
> @@ -93,7 +96,8 @@ static int dw_edma_debugfs_u32_get(void *data, u64 *val)
>  }
>  DEFINE_DEBUGFS_ATTRIBUTE(fops_x32, dw_edma_debugfs_u32_get, NULL, "0x%08llx\n");
>  
> -static void dw_edma_debugfs_create_x32(const struct dw_edma_debugfs_entry ini[],
> +static void dw_edma_debugfs_create_x32(struct dw_edma *dw,
> +				       const struct dw_edma_debugfs_entry ini[],
>  				       int nr_entries, struct dentry *dir)
>  {
>  	struct dw_edma_debugfs_entry *entries;
> @@ -112,62 +116,62 @@ static void dw_edma_debugfs_create_x32(const struct dw_edma_debugfs_entry ini[],
>  	}
>  }
>  
> -static void dw_edma_debugfs_regs_ch(enum dw_edma_dir edma_dir, u16 ch,
> -				    struct dentry *dir)
> +static void dw_edma_debugfs_regs_ch(struct dw_edma *dw, enum dw_edma_dir edma_dir,
> +				    u16 ch, struct dentry *dir)
>  {
>  	struct dw_edma_debugfs_entry debugfs_regs[] = {
> -		CTX_REGISTER(ch_control1, edma_dir, ch),
> -		CTX_REGISTER(ch_control2, edma_dir, ch),
> -		CTX_REGISTER(transfer_size, edma_dir, ch),
> -		CTX_REGISTER(sar.lsb, edma_dir, ch),
> -		CTX_REGISTER(sar.msb, edma_dir, ch),
> -		CTX_REGISTER(dar.lsb, edma_dir, ch),
> -		CTX_REGISTER(dar.msb, edma_dir, ch),
> -		CTX_REGISTER(llp.lsb, edma_dir, ch),
> -		CTX_REGISTER(llp.msb, edma_dir, ch),
> +		CTX_REGISTER(dw, ch_control1, edma_dir, ch),
> +		CTX_REGISTER(dw, ch_control2, edma_dir, ch),
> +		CTX_REGISTER(dw, transfer_size, edma_dir, ch),
> +		CTX_REGISTER(dw, sar.lsb, edma_dir, ch),
> +		CTX_REGISTER(dw, sar.msb, edma_dir, ch),
> +		CTX_REGISTER(dw, dar.lsb, edma_dir, ch),
> +		CTX_REGISTER(dw, dar.msb, edma_dir, ch),
> +		CTX_REGISTER(dw, llp.lsb, edma_dir, ch),
> +		CTX_REGISTER(dw, llp.msb, edma_dir, ch),
>  	};
>  	int nr_entries;
>  
>  	nr_entries = ARRAY_SIZE(debugfs_regs);
> -	dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, dir);
> +	dw_edma_debugfs_create_x32(dw, debugfs_regs, nr_entries, dir);
>  }
>  
> -static void dw_edma_debugfs_regs_wr(struct dentry *dir)
> +static void dw_edma_debugfs_regs_wr(struct dw_edma *dw, struct dentry *dir)
>  {
>  	const struct dw_edma_debugfs_entry debugfs_regs[] = {
>  		/* eDMA global registers */
> -		WR_REGISTER(engine_en),
> -		WR_REGISTER(doorbell),
> -		WR_REGISTER(ch_arb_weight.lsb),
> -		WR_REGISTER(ch_arb_weight.msb),
> +		WR_REGISTER(dw, engine_en),
> +		WR_REGISTER(dw, doorbell),
> +		WR_REGISTER(dw, ch_arb_weight.lsb),
> +		WR_REGISTER(dw, ch_arb_weight.msb),
>  		/* eDMA interrupts registers */
> -		WR_REGISTER(int_status),
> -		WR_REGISTER(int_mask),
> -		WR_REGISTER(int_clear),
> -		WR_REGISTER(err_status),
> -		WR_REGISTER(done_imwr.lsb),
> -		WR_REGISTER(done_imwr.msb),
> -		WR_REGISTER(abort_imwr.lsb),
> -		WR_REGISTER(abort_imwr.msb),
> -		WR_REGISTER(ch01_imwr_data),
> -		WR_REGISTER(ch23_imwr_data),
> -		WR_REGISTER(ch45_imwr_data),
> -		WR_REGISTER(ch67_imwr_data),
> -		WR_REGISTER(linked_list_err_en),
> +		WR_REGISTER(dw, int_status),
> +		WR_REGISTER(dw, int_mask),
> +		WR_REGISTER(dw, int_clear),
> +		WR_REGISTER(dw, err_status),
> +		WR_REGISTER(dw, done_imwr.lsb),
> +		WR_REGISTER(dw, done_imwr.msb),
> +		WR_REGISTER(dw, abort_imwr.lsb),
> +		WR_REGISTER(dw, abort_imwr.msb),
> +		WR_REGISTER(dw, ch01_imwr_data),
> +		WR_REGISTER(dw, ch23_imwr_data),
> +		WR_REGISTER(dw, ch45_imwr_data),
> +		WR_REGISTER(dw, ch67_imwr_data),
> +		WR_REGISTER(dw, linked_list_err_en),
>  	};
>  	const struct dw_edma_debugfs_entry debugfs_unroll_regs[] = {
>  		/* eDMA channel context grouping */
> -		WR_REGISTER_UNROLL(engine_chgroup),
> -		WR_REGISTER_UNROLL(engine_hshake_cnt.lsb),
> -		WR_REGISTER_UNROLL(engine_hshake_cnt.msb),
> -		WR_REGISTER_UNROLL(ch0_pwr_en),
> -		WR_REGISTER_UNROLL(ch1_pwr_en),
> -		WR_REGISTER_UNROLL(ch2_pwr_en),
> -		WR_REGISTER_UNROLL(ch3_pwr_en),
> -		WR_REGISTER_UNROLL(ch4_pwr_en),
> -		WR_REGISTER_UNROLL(ch5_pwr_en),
> -		WR_REGISTER_UNROLL(ch6_pwr_en),
> -		WR_REGISTER_UNROLL(ch7_pwr_en),
> +		WR_REGISTER_UNROLL(dw, engine_chgroup),
> +		WR_REGISTER_UNROLL(dw, engine_hshake_cnt.lsb),
> +		WR_REGISTER_UNROLL(dw, engine_hshake_cnt.msb),
> +		WR_REGISTER_UNROLL(dw, ch0_pwr_en),
> +		WR_REGISTER_UNROLL(dw, ch1_pwr_en),
> +		WR_REGISTER_UNROLL(dw, ch2_pwr_en),
> +		WR_REGISTER_UNROLL(dw, ch3_pwr_en),
> +		WR_REGISTER_UNROLL(dw, ch4_pwr_en),
> +		WR_REGISTER_UNROLL(dw, ch5_pwr_en),
> +		WR_REGISTER_UNROLL(dw, ch6_pwr_en),
> +		WR_REGISTER_UNROLL(dw, ch7_pwr_en),
>  	};
>  	struct dentry *regs_dir, *ch_dir;
>  	int nr_entries, i;
> @@ -176,11 +180,11 @@ static void dw_edma_debugfs_regs_wr(struct dentry *dir)
>  	regs_dir = debugfs_create_dir(WRITE_STR, dir);
>  
>  	nr_entries = ARRAY_SIZE(debugfs_regs);
> -	dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, regs_dir);
> +	dw_edma_debugfs_create_x32(dw, debugfs_regs, nr_entries, regs_dir);
>  
>  	if (dw->chip->mf == EDMA_MF_HDMA_COMPAT) {
>  		nr_entries = ARRAY_SIZE(debugfs_unroll_regs);
> -		dw_edma_debugfs_create_x32(debugfs_unroll_regs, nr_entries,
> +		dw_edma_debugfs_create_x32(dw, debugfs_unroll_regs, nr_entries,
>  					   regs_dir);
>  	}
>  
> @@ -189,47 +193,47 @@ static void dw_edma_debugfs_regs_wr(struct dentry *dir)
>  
>  		ch_dir = debugfs_create_dir(name, regs_dir);
>  
> -		dw_edma_debugfs_regs_ch(EDMA_DIR_WRITE, i, ch_dir);
> +		dw_edma_debugfs_regs_ch(dw, EDMA_DIR_WRITE, i, ch_dir);
>  	}
>  }
>  
> -static void dw_edma_debugfs_regs_rd(struct dentry *dir)
> +static void dw_edma_debugfs_regs_rd(struct dw_edma *dw, struct dentry *dir)
>  {
>  	const struct dw_edma_debugfs_entry debugfs_regs[] = {
>  		/* eDMA global registers */
> -		RD_REGISTER(engine_en),
> -		RD_REGISTER(doorbell),
> -		RD_REGISTER(ch_arb_weight.lsb),
> -		RD_REGISTER(ch_arb_weight.msb),
> +		RD_REGISTER(dw, engine_en),
> +		RD_REGISTER(dw, doorbell),
> +		RD_REGISTER(dw, ch_arb_weight.lsb),
> +		RD_REGISTER(dw, ch_arb_weight.msb),
>  		/* eDMA interrupts registers */
> -		RD_REGISTER(int_status),
> -		RD_REGISTER(int_mask),
> -		RD_REGISTER(int_clear),
> -		RD_REGISTER(err_status.lsb),
> -		RD_REGISTER(err_status.msb),
> -		RD_REGISTER(linked_list_err_en),
> -		RD_REGISTER(done_imwr.lsb),
> -		RD_REGISTER(done_imwr.msb),
> -		RD_REGISTER(abort_imwr.lsb),
> -		RD_REGISTER(abort_imwr.msb),
> -		RD_REGISTER(ch01_imwr_data),
> -		RD_REGISTER(ch23_imwr_data),
> -		RD_REGISTER(ch45_imwr_data),
> -		RD_REGISTER(ch67_imwr_data),
> +		RD_REGISTER(dw, int_status),
> +		RD_REGISTER(dw, int_mask),
> +		RD_REGISTER(dw, int_clear),
> +		RD_REGISTER(dw, err_status.lsb),
> +		RD_REGISTER(dw, err_status.msb),
> +		RD_REGISTER(dw, linked_list_err_en),
> +		RD_REGISTER(dw, done_imwr.lsb),
> +		RD_REGISTER(dw, done_imwr.msb),
> +		RD_REGISTER(dw, abort_imwr.lsb),
> +		RD_REGISTER(dw, abort_imwr.msb),
> +		RD_REGISTER(dw, ch01_imwr_data),
> +		RD_REGISTER(dw, ch23_imwr_data),
> +		RD_REGISTER(dw, ch45_imwr_data),
> +		RD_REGISTER(dw, ch67_imwr_data),
>  	};
>  	const struct dw_edma_debugfs_entry debugfs_unroll_regs[] = {
>  		/* eDMA channel context grouping */
> -		RD_REGISTER_UNROLL(engine_chgroup),
> -		RD_REGISTER_UNROLL(engine_hshake_cnt.lsb),
> -		RD_REGISTER_UNROLL(engine_hshake_cnt.msb),
> -		RD_REGISTER_UNROLL(ch0_pwr_en),
> -		RD_REGISTER_UNROLL(ch1_pwr_en),
> -		RD_REGISTER_UNROLL(ch2_pwr_en),
> -		RD_REGISTER_UNROLL(ch3_pwr_en),
> -		RD_REGISTER_UNROLL(ch4_pwr_en),
> -		RD_REGISTER_UNROLL(ch5_pwr_en),
> -		RD_REGISTER_UNROLL(ch6_pwr_en),
> -		RD_REGISTER_UNROLL(ch7_pwr_en),
> +		RD_REGISTER_UNROLL(dw, engine_chgroup),
> +		RD_REGISTER_UNROLL(dw, engine_hshake_cnt.lsb),
> +		RD_REGISTER_UNROLL(dw, engine_hshake_cnt.msb),
> +		RD_REGISTER_UNROLL(dw, ch0_pwr_en),
> +		RD_REGISTER_UNROLL(dw, ch1_pwr_en),
> +		RD_REGISTER_UNROLL(dw, ch2_pwr_en),
> +		RD_REGISTER_UNROLL(dw, ch3_pwr_en),
> +		RD_REGISTER_UNROLL(dw, ch4_pwr_en),
> +		RD_REGISTER_UNROLL(dw, ch5_pwr_en),
> +		RD_REGISTER_UNROLL(dw, ch6_pwr_en),
> +		RD_REGISTER_UNROLL(dw, ch7_pwr_en),
>  	};
>  	struct dentry *regs_dir, *ch_dir;
>  	int nr_entries, i;
> @@ -238,11 +242,11 @@ static void dw_edma_debugfs_regs_rd(struct dentry *dir)
>  	regs_dir = debugfs_create_dir(READ_STR, dir);
>  
>  	nr_entries = ARRAY_SIZE(debugfs_regs);
> -	dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, regs_dir);
> +	dw_edma_debugfs_create_x32(dw, debugfs_regs, nr_entries, regs_dir);
>  
>  	if (dw->chip->mf == EDMA_MF_HDMA_COMPAT) {
>  		nr_entries = ARRAY_SIZE(debugfs_unroll_regs);
> -		dw_edma_debugfs_create_x32(debugfs_unroll_regs, nr_entries,
> +		dw_edma_debugfs_create_x32(dw, debugfs_unroll_regs, nr_entries,
>  					   regs_dir);
>  	}
>  
> @@ -251,15 +255,15 @@ static void dw_edma_debugfs_regs_rd(struct dentry *dir)
>  
>  		ch_dir = debugfs_create_dir(name, regs_dir);
>  
> -		dw_edma_debugfs_regs_ch(EDMA_DIR_READ, i, ch_dir);
> +		dw_edma_debugfs_regs_ch(dw, EDMA_DIR_READ, i, ch_dir);
>  	}
>  }
>  
> -static void dw_edma_debugfs_regs(void)
> +static void dw_edma_debugfs_regs(struct dw_edma *dw)
>  {
>  	const struct dw_edma_debugfs_entry debugfs_regs[] = {
> -		REGISTER(ctrl_data_arb_prior),
> -		REGISTER(ctrl),
> +		REGISTER(dw, ctrl_data_arb_prior),
> +		REGISTER(dw, ctrl),
>  	};
>  	struct dentry *regs_dir;
>  	int nr_entries;
> @@ -267,23 +271,17 @@ static void dw_edma_debugfs_regs(void)
>  	regs_dir = debugfs_create_dir(REGISTERS_STR, dw->debugfs);
>  
>  	nr_entries = ARRAY_SIZE(debugfs_regs);
> -	dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, regs_dir);
> +	dw_edma_debugfs_create_x32(dw, debugfs_regs, nr_entries, regs_dir);
>  
> -	dw_edma_debugfs_regs_wr(regs_dir);
> -	dw_edma_debugfs_regs_rd(regs_dir);
> +	dw_edma_debugfs_regs_wr(dw, regs_dir);
> +	dw_edma_debugfs_regs_rd(dw, regs_dir);
>  }
>  
>  void dw_edma_v0_debugfs_on(struct dw_edma_chip *chip)
>  {
> -	if (!debugfs_initialized())
> -		return;
> -
> -	dw = chip->dw;
> -	if (!dw)
> -		return;
> +	struct dw_edma *dw = chip->dw;
>  
> -	regs = dw->chip->reg_base;
> -	if (!regs)
> +	if (!debugfs_initialized())
>  		return;
>  
>  	dw->debugfs = debugfs_create_dir(dw->name, NULL);
> @@ -292,14 +290,12 @@ void dw_edma_v0_debugfs_on(struct dw_edma_chip *chip)
>  	debugfs_create_u16("wr_ch_cnt", 0444, dw->debugfs, &dw->wr_ch_cnt);
>  	debugfs_create_u16("rd_ch_cnt", 0444, dw->debugfs, &dw->rd_ch_cnt);
>  
> -	dw_edma_debugfs_regs();
> +	dw_edma_debugfs_regs(dw);
>  }
>  
>  void dw_edma_v0_debugfs_off(struct dw_edma_chip *chip)
>  {
> -	dw = chip->dw;
> -	if (!dw)
> -		return;
> +	struct dw_edma *dw = chip->dw;
>  
>  	debugfs_remove_recursive(dw->debugfs);
>  	dw->debugfs = NULL;
> -- 
> 2.35.1
> 
