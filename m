Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92B84E6E34
	for <lists+dmaengine@lfdr.de>; Fri, 25 Mar 2022 07:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353849AbiCYGdP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 25 Mar 2022 02:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348432AbiCYGdP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 25 Mar 2022 02:33:15 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850E0C683B
        for <dmaengine@vger.kernel.org>; Thu, 24 Mar 2022 23:31:41 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id x2so7081645plm.7
        for <dmaengine@vger.kernel.org>; Thu, 24 Mar 2022 23:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gbWkfWp6J4H3XXyeKe68Z66N6YCdMtgzmMKex+e1KQI=;
        b=k0iJTCPI3/Q9T3uqUAAEpTXkI1CbOQYZA9PZB0beey9FZseowzuPncHnFdzXZ+KOGs
         /RYQCmjMkYfsWMqr6MeZHNZS8Ha93qdE5Tawk4NYoYk29cRyVnsjtPA/f3zF59jedHF9
         1LwWECoevSHw5yGNFLp5j3mvw9rkoo/yTR5jgjFj2KWBGmZcw8ni/1cz4BYxY8dCxhBU
         RXZ1Q679ievRu78ojmLY29Ob/+6PUmluqbGr/ELW+19QhDBshpB5Q5HWcAWnb8IW3+Eb
         y0ctrNIaZb4xkhOXHrhTMwE6tRqbqqPwuOz4aQgXVa2hTDqsyVjEFcCu4V/z44+rFIkS
         yOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gbWkfWp6J4H3XXyeKe68Z66N6YCdMtgzmMKex+e1KQI=;
        b=XMhAlZ1JKqhHRLSPYcH6D8msgHlBPBBrcPNU1s215jSs+ddC9qe+ZqwOFcLPS2i0V3
         +2N7XssXCV3pmit/GUHD+HdpwcS/nesxHvU5RsoPK+O2EInIL9Ej30YgXHnvzGJTVUKE
         2nA2gS4eq8HXa70pTVA93p8pLRE7rM15eT+ZxOWdeIKJxxCFxCDkCAxlXmQZcUQKlCuA
         b5POuvOOSi4bKQLN27Cnbb5x3mrWtM4UP7P7vVturAAopFHVix2MbqCYmjx4Nr9lftiW
         bnKn1AU7eXyJKJ1qKHsO0NrU7HbGpCG8DTIbdmgxilPvj5kwk6rkRK0Tb3FkjXwQnRwk
         iCsA==
X-Gm-Message-State: AOAM531nu0UrImAPPEB+skwQQeGxPuFVvVbv4J8vvQr4/0NgKj0MKe1Q
        EiyPOYTLFzbpSy9VNJZ8cVLk
X-Google-Smtp-Source: ABdhPJz3O7K/qRxSRjgYVNbXxuj8AdvhXmK8k93ZkIp7BCn6JLj3whclf3/Av1m7VVs7GSGY4/Rj3w==
X-Received: by 2002:a17:90b:1d82:b0:1c7:1d3:f4 with SMTP id pf2-20020a17090b1d8200b001c701d300f4mr23103147pjb.223.1648189900916;
        Thu, 24 Mar 2022 23:31:40 -0700 (PDT)
Received: from thinkpad ([27.111.75.218])
        by smtp.gmail.com with ESMTPSA id y20-20020aa78054000000b004f6f267dcc9sm5270651pfm.187.2022.03.24.23.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 23:31:40 -0700 (PDT)
Date:   Fri, 25 Mar 2022 12:01:33 +0530
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
Subject: Re: [PATCH 16/25] dmaengine: dw-edma: Simplify the DebugFS context
 CSRs init procedure
Message-ID: <20220325063133.GC4675@thinkpad>
References: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
 <20220324014836.19149-17-Sergey.Semin@baikalelectronics.ru>
 <20220325062708.GB4675@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325062708.GB4675@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Mar 25, 2022 at 11:57:16AM +0530, Manivannan Sadhasivam wrote:
> On Thu, Mar 24, 2022 at 04:48:27AM +0300, Serge Semin wrote:
> > DW eDMA v4.70a and older have the read and write channels context CSRs
> > indirectly accessible. It means the CSRs like Channel Control, Xfer size,
> > SAR, DAR and LLP address are accessed over at a fixed MMIO address, but
> > their reference to the corresponding channel is determined by the Viewport
> > CSR. In order to have a coherent access to these registers the CSR IOs are
> > supposed to be protected with a spin-lock. DW eDMA v4.80a and newer
> > normally have unrolled Read/Write channel context registers. That is all
> > CSRs denoted before are directly mapped in the controller MMIO space.
> > 
> > Since both normal and viewport-based registers are exposed via the DebugFS
> > nodes, the original code author decided to implement an algorithm based on
> > the unrolled CSRs mapping with the viewport addresses recalculation if
> > it's required. The problem is that such implementation turned to be first
> > unscalable (supports a platform with only single eDMA available since a
> > base address statically preserved) and second needlessly overcomplicated
> > (it loops over all Rd/Wr context addresses and re-calculates the viewport
> > base address on each DebugFS node access). The algorithm can be greatly
> > simplified just by adding the channel ID and it's direction fields in the
> > eDMA DebugFS node descriptor. These new parameters can be used to find a
> > CSR offset within the corresponding channel registers space. The DW eDMA
> > DebugFS node getter afterwards will also use them in order to activate the
> > respective context CSRs viewport before reading data from the specified
> > register. In case of the unrolled version of the CSRs mapping there won't
> > be any spin-lock taken/released, no viewport activation as before this
> > modification.
> > 
> > Note this modification fixes the REGISTER() macros using an externally
> > defined local variable. The same problem with the rest of the macro will
> > be fixed in the next commit.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > ---
> >  drivers/dma/dw-edma/dw-edma-v0-debugfs.c | 84 +++++++++++-------------
> >  1 file changed, 38 insertions(+), 46 deletions(-)
> > 
> > diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> > index 7eb0147912fa..b34a68964232 100644
> > --- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> > +++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> > @@ -15,9 +15,27 @@
> >  
> >  #define REGS_ADDR(name) \
> >  	((void __iomem *)&regs->name)
> > +
> > +#define REGS_CH_ADDR(name, _dir, _ch)						\
> > +	({									\
> > +		struct dw_edma_v0_ch_regs __iomem *__ch_regs;			\
> > +										\
> > +		if ((dw)->chip->mf == EDMA_MF_EDMA_LEGACY)			\
> > +			__ch_regs = &regs->type.legacy.ch;			\
> > +		else if (_dir == EDMA_DIR_READ)					\
> > +			__ch_regs = &regs->type.unroll.ch[_ch].rd;		\
> > +		else								\
> > +			__ch_regs = &regs->type.unroll.ch[_ch].wr;		\
> > +										\
> > +		(void __iomem *)&__ch_regs->name;				\
> > +	})
> > +
> >  #define REGISTER(name) \
> >  	{ #name, REGS_ADDR(name) }
> >  
> > +#define CTX_REGISTER(name, dir, ch) \
> > +	{ #name, REGS_CH_ADDR(name, dir, ch), dir, ch }
> 
> What is the need of "dir, ch" at the end?
> 

Ignore this comment. I failed to notice that your addition.

Thanks,
Mani

> > +
> >  #define WR_REGISTER(name) \
> >  	{ #name, REGS_ADDR(wr_##name) }
> >  #define RD_REGISTER(name) \
> > @@ -41,14 +59,11 @@
> >  static struct dw_edma				*dw;
> >  static struct dw_edma_v0_regs			__iomem *regs;
> >  
> > -static struct {
> > -	void					__iomem *start;
> > -	void					__iomem *end;
> > -} lim[2][EDMA_V0_MAX_NR_CH];
> > -
> >  struct dw_edma_debugfs_entry {
> >  	const char				*name;
> >  	void __iomem				*reg;
> > +	enum dw_edma_dir			dir;
> > +	u16					ch;
> >  };
> >  
> >  static int dw_edma_debugfs_u32_get(void *data, u64 *val)
> > @@ -58,33 +73,16 @@ static int dw_edma_debugfs_u32_get(void *data, u64 *val)
> >  
> >  	if (dw->chip->mf == EDMA_MF_EDMA_LEGACY &&
> >  	    reg >= (void __iomem *)&regs->type.legacy.ch) {
> > -		void __iomem *ptr = &regs->type.legacy.ch;
> > -		u32 viewport_sel = 0;
> >  		unsigned long flags;
> > -		u16 ch;
> > -
> > -		for (ch = 0; ch < dw->wr_ch_cnt; ch++)
> > -			if (lim[0][ch].start >= reg && reg < lim[0][ch].end) {
> > -				ptr += (reg - lim[0][ch].start);
> > -				goto legacy_sel_wr;
> > -			}
> > -
> > -		for (ch = 0; ch < dw->rd_ch_cnt; ch++)
> > -			if (lim[1][ch].start >= reg && reg < lim[1][ch].end) {
> > -				ptr += (reg - lim[1][ch].start);
> > -				goto legacy_sel_rd;
> > -			}
> > -
> > -		return 0;
> > -legacy_sel_rd:
> > -		viewport_sel = BIT(31);
> > -legacy_sel_wr:
> > -		viewport_sel |= FIELD_PREP(EDMA_V0_VIEWPORT_MASK, ch);
> > +		u32 viewport_sel;
> > +
> > +		viewport_sel = entry->dir == EDMA_DIR_READ ? BIT(31) : 0;
> > +		viewport_sel |= FIELD_PREP(EDMA_V0_VIEWPORT_MASK, entry->ch);
> >  
> >  		raw_spin_lock_irqsave(&dw->lock, flags);
> >  
> >  		writel(viewport_sel, &regs->type.legacy.viewport_sel);
> > -		*val = readl(ptr);
> > +		*val = readl(reg);
> >  
> >  		raw_spin_unlock_irqrestore(&dw->lock, flags);
> >  	} else {
> > @@ -114,19 +112,19 @@ static void dw_edma_debugfs_create_x32(const struct dw_edma_debugfs_entry ini[],
> >  	}
> >  }
> >  
> > -static void dw_edma_debugfs_regs_ch(struct dw_edma_v0_ch_regs __iomem *regs,
> > +static void dw_edma_debugfs_regs_ch(enum dw_edma_dir edma_dir, u16 ch,
> >  				    struct dentry *dir)
> 
> Using "dir" for directory would be confusing since it could also refer
> direction. I'd suggest to use "dentry".
> 
> Thanks,
> Mani
> 
> >  {
> > -	const struct dw_edma_debugfs_entry debugfs_regs[] = {
> > -		REGISTER(ch_control1),
> > -		REGISTER(ch_control2),
> > -		REGISTER(transfer_size),
> > -		REGISTER(sar.lsb),
> > -		REGISTER(sar.msb),
> > -		REGISTER(dar.lsb),
> > -		REGISTER(dar.msb),
> > -		REGISTER(llp.lsb),
> > -		REGISTER(llp.msb),
> > +	struct dw_edma_debugfs_entry debugfs_regs[] = {
> > +		CTX_REGISTER(ch_control1, edma_dir, ch),
> > +		CTX_REGISTER(ch_control2, edma_dir, ch),
> > +		CTX_REGISTER(transfer_size, edma_dir, ch),
> > +		CTX_REGISTER(sar.lsb, edma_dir, ch),
> > +		CTX_REGISTER(sar.msb, edma_dir, ch),
> > +		CTX_REGISTER(dar.lsb, edma_dir, ch),
> > +		CTX_REGISTER(dar.msb, edma_dir, ch),
> > +		CTX_REGISTER(llp.lsb, edma_dir, ch),
> > +		CTX_REGISTER(llp.msb, edma_dir, ch),
> >  	};
> >  	int nr_entries;
> >  
> > @@ -191,10 +189,7 @@ static void dw_edma_debugfs_regs_wr(struct dentry *dir)
> >  
> >  		ch_dir = debugfs_create_dir(name, regs_dir);
> >  
> > -		dw_edma_debugfs_regs_ch(&regs->type.unroll.ch[i].wr, ch_dir);
> > -
> > -		lim[0][i].start = &regs->type.unroll.ch[i].wr;
> > -		lim[0][i].end = &regs->type.unroll.ch[i].padding_1[0];
> > +		dw_edma_debugfs_regs_ch(EDMA_DIR_WRITE, i, ch_dir);
> >  	}
> >  }
> >  
> > @@ -256,10 +251,7 @@ static void dw_edma_debugfs_regs_rd(struct dentry *dir)
> >  
> >  		ch_dir = debugfs_create_dir(name, regs_dir);
> >  
> > -		dw_edma_debugfs_regs_ch(&regs->type.unroll.ch[i].rd, ch_dir);
> > -
> > -		lim[1][i].start = &regs->type.unroll.ch[i].rd;
> > -		lim[1][i].end = &regs->type.unroll.ch[i].padding_2[0];
> > +		dw_edma_debugfs_regs_ch(EDMA_DIR_READ, i, ch_dir);
> >  	}
> >  }
> >  
> > -- 
> > 2.35.1
> > 
