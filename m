Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83C5504D13
	for <lists+dmaengine@lfdr.de>; Mon, 18 Apr 2022 09:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbiDRHTz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 18 Apr 2022 03:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiDRHTy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 18 Apr 2022 03:19:54 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A0717044;
        Mon, 18 Apr 2022 00:17:16 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id x33so22979831lfu.1;
        Mon, 18 Apr 2022 00:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EtudBkhIRXiTjoTsW3U6yb45/EgiT2GM/oIAgk3gVTo=;
        b=aIYBW8cHIXICHiSxDTuasOkDbJTCCNb38lk/7JEbkOre3fKU0A2c0UCd2HI7UZjfB8
         N2N4OgC7etbBpyGJx9aBZ4KunQSzBKbY2ANdtclnfRTCn/OvrJguwS8oxpS1TWCF4Rq1
         WhaWgvs+fBDDV9IFhL/GYn57mnSyN+Lh3lAlWRQ+8sAZhuAEMuPvxdR0LZ1154tPMEKt
         nW4FT0I70P5iSyrOOGekadvQDxGtYW2xzX3rs5rxsngQoQg1Eyx3DZr1vrfwHHhabZTq
         zuWnG/7/j3grqOjvGq/icu+GnWa8yCPdU0/4kEylFAjyOlNOFOrs7LGfJ7JaP21feJg9
         c1Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EtudBkhIRXiTjoTsW3U6yb45/EgiT2GM/oIAgk3gVTo=;
        b=k1+TT2yOCYwpFii+ZOh8pMv6uydMd3Q0JQct38+/RrtK2MZlwqo/58VYeuxuFmrFMy
         j6cC5410TcpDBF3oKlMHUjYLiBrEMCNJo6zAeHE4PjOAZ3n4BCg+nDPBpctQ7QMcW2OZ
         l8QN3AIDbkU5oUrFneKVWy3078sGxvcSf47fu1rh5dXIaw3DUGoG8d77lIi4qfyTWVM7
         L4mxfY53U4xLdMDHRUaDNj7n9jmLHMMho97eDSIHPBvwA8L8/J47Fm4NFQDE/Q/bL5Qe
         EY+vgp47hWF218F1C9g6mpGuH/RkI9+JJSdKZwiM2sHZ7fd9dJ8pUvx6p/ehgBwpqjpK
         9pxQ==
X-Gm-Message-State: AOAM531Be7Aju9QTOeAHrjSmHnucAA1ChTv4NcWl06k4owqDTpdx5Ft9
        YgZj2tAyJ6b1nTHyClCSUZ0=
X-Google-Smtp-Source: ABdhPJwz2arqnrzhV1gQusTUsrW2DjZsRXKHsOpcLWA3bDTEdcjiITz/LCem+3Ia0aqXYxTXAUuM0Q==
X-Received: by 2002:a19:7717:0:b0:46b:be15:db05 with SMTP id s23-20020a197717000000b0046bbe15db05mr7175546lfc.326.1650266234719;
        Mon, 18 Apr 2022 00:17:14 -0700 (PDT)
Received: from mobilestation ([95.79.134.149])
        by smtp.gmail.com with ESMTPSA id s5-20020a05651c048500b0024cea5f82e1sm1110489ljc.0.2022.04.18.00.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 00:17:14 -0700 (PDT)
Date:   Mon, 18 Apr 2022 10:17:12 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/25] dmaengine: dw-edma: Convert DebugFS descs to being
 kz-allocated
Message-ID: <20220418071712.ahws4na2bjpbjcsk@mobilestation>
References: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
 <20220324014836.19149-16-Sergey.Semin@baikalelectronics.ru>
 <20220325060349.GA4675@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325060349.GA4675@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Mar 25, 2022 at 11:33:49AM +0530, Manivannan Sadhasivam wrote:
> On Thu, Mar 24, 2022 at 04:48:26AM +0300, Serge Semin wrote:
> > Currently all the DW eDMA DebugFS nodes descriptors are allocated on
> > stack, while the DW eDMA driver private data and CSR limits are statically
> > preserved. Such design won't work for the multi-eDMA platforms.
> 
> Can you please explain why?
> 
> > As a
> > preparation to adding the multi-eDMA system setups support we need to have
> > each DebugFS node separately allocated and described. Afterwards we'll put
> > an addition info there like Read/Write channel flag, channel ID, DW eDMA
> > private data reference.
> > 
> > Note this conversion is mainly required due to having the legacy DW eDMA
> > controllers with indirect Read/Write channels context CSRs access. If we
> > didn't need to have a synchronized access to these registers the DebugFS
> > code of the driver would have been much simpler.
> > 
> 

> I fail to understand how this change is beneficial or the exact issue.

Just to be clear. It has only one benefit - an ability to preserve a
device-specific data in the dw_edma_debugfs_entry structure. That data
will be the dw_edma private data instance, which in it turn will be
used to access the register spin lock. All of that in general is
required to support more than one DW eDMA controllers in the system.

> 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > ---
> >  drivers/dma/dw-edma/dw-edma-v0-debugfs.c | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> > index afd519d9568b..7eb0147912fa 100644
> > --- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> > +++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> > @@ -53,7 +53,8 @@ struct dw_edma_debugfs_entry {
> >  
> >  static int dw_edma_debugfs_u32_get(void *data, u64 *val)
> >  {
> > -	void __iomem *reg = data;
> > +	struct dw_edma_debugfs_entry __iomem *entry = data;
> 

> Why the entry has to be of __iomem?

Good question. It has just slipped through my fingers in from the
previous code. You are right. I should drop it.

-Sergey

> 
> Thanks,
> Mani
> 
> > +	void __iomem *reg = entry->reg;
> >  
> >  	if (dw->chip->mf == EDMA_MF_EDMA_LEGACY &&
> >  	    reg >= (void __iomem *)&regs->type.legacy.ch) {
> > @@ -94,14 +95,22 @@ static int dw_edma_debugfs_u32_get(void *data, u64 *val)
> >  }
> >  DEFINE_DEBUGFS_ATTRIBUTE(fops_x32, dw_edma_debugfs_u32_get, NULL, "0x%08llx\n");
> >  
> > -static void dw_edma_debugfs_create_x32(const struct dw_edma_debugfs_entry entries[],
> > +static void dw_edma_debugfs_create_x32(const struct dw_edma_debugfs_entry ini[],
> >  				       int nr_entries, struct dentry *dir)
> >  {
> > +	struct dw_edma_debugfs_entry *entries;
> >  	int i;
> >  
> > +	entries = devm_kcalloc(dw->chip->dev, nr_entries, sizeof(*entries),
> > +			       GFP_KERNEL);
> > +	if (!entries)
> > +		return;
> > +
> >  	for (i = 0; i < nr_entries; i++) {
> > +		entries[i] = ini[i];
> > +
> >  		debugfs_create_file_unsafe(entries[i].name, 0444, dir,
> > -					   entries[i].reg, &fops_x32);
> > +					   &entries[i], &fops_x32);
> >  	}
> >  }
> >  
> > -- 
> > 2.35.1
> > 
