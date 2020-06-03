Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADA4A1ED4F8
	for <lists+dmaengine@lfdr.de>; Wed,  3 Jun 2020 19:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgFCR2l (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 Jun 2020 13:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgFCR2l (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 3 Jun 2020 13:28:41 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28744C08C5C0;
        Wed,  3 Jun 2020 10:28:41 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id w7so2449697edt.1;
        Wed, 03 Jun 2020 10:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WVI6luCOohmM6qtuTKw9WrRMCZTsi+C83iXVnslX7rA=;
        b=GJEAx+43WdEYHTT43ATJjegpGSMYXCQIeBqog4TyBcmkCi3byjhhsFZEyyCkr7UFRE
         6PeB2iNz86LyDeFJjUNQ3lpoWcW0xuuvi4X7v1rdyT7qTteOfOfp0JGiTuT0gyBws/iX
         gxLVfJpFcOIMjD8+OWiGSZvrc6cTwF/WzkkW+b3YFYLgb2PBltRDN4N30gb/EZdElnWR
         lWYsC+Q2H+YAvDXN52wiN4R1/WxoYu8k0/Su1nubUzZlnwcRJadcbuJ20ZYC90aN130b
         RqppjXZPdST0NQplnNaGbL/Rs8x2iyn+LQKAK9uuiODxHoSOtEUrvx+xmUgtdCZqcnbS
         aT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WVI6luCOohmM6qtuTKw9WrRMCZTsi+C83iXVnslX7rA=;
        b=YFCEoOFUFgmBWigByOg/sI0ll//zs8Om2kMiNqt/UVeAK/quG1cw4MWOqcR0dyaCGR
         YbFBzpiOFpSqLXQ7ERh1UUZsnRUwstn/Uum9klvgT6tQZULWNHG7Z59a3PYEbypv66GT
         kxx/QS7ts7cOHpKyQJ9XhWQGD5q+D2ANS7I6wkh2SeP6Dm8h0Ci2xH1JSSDZFZIi28y+
         MtZq1jGal+ArA4mvsuRygkxl+m3+VYvJSnhdI08nW9bfV66lLyfQvrVcgvxdNaZgVKJ6
         IWg083a0OfioV9RP1CWTa3CPIBaBH0IOl/cCt2Gc3A2PUkHruIMKuk9RKvneb2ID5oeG
         PyOw==
X-Gm-Message-State: AOAM530cE4UjyKMFtziV6B5u4yhlIl39SMaa15xQDODHjzj6eCRjy2qE
        +Dn6NrnTbtvY8y3tNvT9gtox/10R1QGWuZuaXio=
X-Google-Smtp-Source: ABdhPJxOeyPwfHr68BPk1LyMY14u7d6PVWFDNWe+GFxbBEkzVXCYLZG+MS363P7oNsScacZSmnMly8Af3Rtiz2JqdQ4=
X-Received: by 2002:a50:fe94:: with SMTP id d20mr488426edt.254.1591205319745;
 Wed, 03 Jun 2020 10:28:39 -0700 (PDT)
MIME-Version: 1.0
References: <1591119192-18538-1-git-send-email-amittomer25@gmail.com>
 <1591119192-18538-2-git-send-email-amittomer25@gmail.com> <3D3E2940-11E3-4093-8F60-82EB2C11B617@linaro.org>
In-Reply-To: <3D3E2940-11E3-4093-8F60-82EB2C11B617@linaro.org>
From:   Amit Tomer <amittomer25@gmail.com>
Date:   Wed, 3 Jun 2020 22:58:02 +0530
Message-ID: <CABHD4K-jee4GM1WybAoqaCJTkVO7FC7fJC3U_zZwP_XbH4kpOA@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] dmaengine: Actions: get rid of bit fields from
 dma descriptor
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Vinod Koul <vkoul@kernel.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        dan.j.williams@intel.com, cristian.ciocaltea@gmail.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-actions@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

Thanks for having a look.

On Wed, Jun 3, 2020 at 12:52 PM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
> Individual comments for these enums?

I was expecting this comment , and thought these fields are self explanatory
But if you prefer to have description about it, I would have it in next version.

> >+enum owl_dmadesc_offsets {
> >+      OWL_DMADESC_NEXT_LLI = 0,
> >+      OWL_DMADESC_SADDR,
> >+      OWL_DMADESC_DADDR,
> >+      OWL_DMADESC_FLEN,
> >+      OWL_DMADESC_SRC_STRIDE,
> >+      OWL_DMADESC_DST_STRIDE,
> >+      OWL_DMADESC_CTRLA,
> >+      OWL_DMADESC_CTRLB,
> >+      OWL_DMADESC_CONST_NUM,
> >+      OWL_DMADESC_SIZE
> > };
> >
> > /**
> >@@ -153,7 +144,7 @@ struct owl_dma_lli_hw {
> >  * @node: node for txd's lli_list
> >  */
> > struct owl_dma_lli {
> >-      struct  owl_dma_lli_hw  hw;
> >+      u32                     hw[OWL_DMADESC_SIZE];
> >       dma_addr_t              phys;
> >       struct list_head        node;
> > };
> >@@ -320,6 +311,11 @@ static inline u32 llc_hw_ctrlb(u32 int_ctl)
> >       return ctl;
> > }
> >
> >+static u32 llc_hw_flen(struct owl_dma_lli *lli)
> >+{
> >+      return lli->hw[OWL_DMADESC_FLEN] & GENMASK(19, 0);
> >+}
> >+
> > static void owl_dma_free_lli(struct owl_dma *od,
> >                            struct owl_dma_lli *lli)
> > {
> >@@ -351,8 +347,9 @@ static struct owl_dma_lli *owl_dma_add_lli(struct
> >owl_dma_txd *txd,
> >               list_add_tail(&next->node, &txd->lli_list);
> >
> >       if (prev) {
> >-              prev->hw.next_lli = next->phys;
> >-              prev->hw.ctrla |= llc_hw_ctrla(OWL_DMA_MODE_LME, 0);
> >+              prev->hw[OWL_DMADESC_NEXT_LLI] = next->phys;
> >+              prev->hw[OWL_DMADESC_CTRLA] |=
> >+                                      llc_hw_ctrla(OWL_DMA_MODE_LME, 0);
> >       }
> >
> >       return next;
> >@@ -365,8 +362,7 @@ static inline int owl_dma_cfg_lli(struct
> >owl_dma_vchan *vchan,
> >                                 struct dma_slave_config *sconfig,
> >                                 bool is_cyclic)
> > {
> >-      struct owl_dma_lli_hw *hw = &lli->hw;
> >-      u32 mode;
> >+      u32 mode, ctrlb;
> >
> >       mode = OWL_DMA_MODE_PW(0);
> >
> >@@ -407,22 +403,22 @@ static inline int owl_dma_cfg_lli(struct
> >owl_dma_vchan *vchan,
> >               return -EINVAL;
> >       }
> >
> >-      hw->next_lli = 0; /* One link list by default */
> >-      hw->saddr = src;
> >-      hw->daddr = dst;
> >-
> >-      hw->fcnt = 1; /* Frame count fixed as 1 */
> >-      hw->flen = len; /* Max frame length is 1MB */
> >-      hw->src_stride = 0;
> >-      hw->dst_stride = 0;
> >-      hw->ctrla = llc_hw_ctrla(mode,
> >-                               OWL_DMA_LLC_SAV_LOAD_NEXT |
> >-                               OWL_DMA_LLC_DAV_LOAD_NEXT);
> >+      lli->hw[OWL_DMADESC_CTRLA] = llc_hw_ctrla(mode,
> >+                                                OWL_DMA_LLC_SAV_LOAD_NEXT |
> >+                                                OWL_DMA_LLC_DAV_LOAD_NEXT);
> >
> >       if (is_cyclic)
> >-              hw->ctrlb = llc_hw_ctrlb(OWL_DMA_INTCTL_BLOCK);
> >+              ctrlb = llc_hw_ctrlb(OWL_DMA_INTCTL_BLOCK);
> >       else
> >-              hw->ctrlb = llc_hw_ctrlb(OWL_DMA_INTCTL_SUPER_BLOCK);
> >+              ctrlb = llc_hw_ctrlb(OWL_DMA_INTCTL_SUPER_BLOCK);
> >+
> >+      lli->hw[OWL_DMADESC_NEXT_LLI] = 0;
>
> Again, please preserve the old comments.

Sure, would do it.
>
> >+      lli->hw[OWL_DMADESC_SADDR] = src;
> >+      lli->hw[OWL_DMADESC_DADDR] = dst;
> >+      lli->hw[OWL_DMADESC_SRC_STRIDE] = 0;
> >+      lli->hw[OWL_DMADESC_DST_STRIDE] = 0;
> >+      lli->hw[OWL_DMADESC_FLEN] = len | FCNT_VAL << 20;
>
> Please explain what you're doing here.

Actually , in next the patch 2/10 there is comment that explains a bit
about it.

        /*
         * S700 put flen and fcnt at offset 0x0c and 0x1c respectively,
         * whereas S900 put flen and fcnt at offset 0x0c.
         */

Shall I add more details to it in the next patch 02/10 ?

Thanks
-Amit.
