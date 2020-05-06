Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACFCC1C70E4
	for <lists+dmaengine@lfdr.de>; Wed,  6 May 2020 14:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbgEFMzH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 May 2020 08:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728081AbgEFMzG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 May 2020 08:55:06 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B52DC061A0F
        for <dmaengine@vger.kernel.org>; Wed,  6 May 2020 05:55:06 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id w2so1814396edx.4
        for <dmaengine@vger.kernel.org>; Wed, 06 May 2020 05:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nNKGk6BbzRMTmQMq+gs/nkbr+iCdW2o+wuRBue20xaw=;
        b=rYGag4veryirO7Cs6u4A2qaboGhV9JjLBha+aFH3F8u0JTc08qS7cCo5GncJr98wnL
         TXINLADcXmNN9sXnAtoiKn4KnrRwcp6PnU2mwCmDwym0vVwtVbWQb4+s79MknUgE5S+r
         ZTa8Ff1pcXOMFzxSvo553WMcHGCvGflNA4f9UbU6DyFxfccOGhnV6ir6Cw3V1JqggmuH
         NjP/RP+j4hN5Ejm02mUk9DSDrQT7Pk5xmJGZqMBlmYaHZbR3Hqf8idE7NdWK6clKujT3
         jC2yfpFAU9MHLVebxsUxO9wOPs7h0bQLXsvPAjZ0DCbKtyH8edAv9prW0tcXamP/qzSc
         8xtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nNKGk6BbzRMTmQMq+gs/nkbr+iCdW2o+wuRBue20xaw=;
        b=NEab3zXKfBehAUP7PIyeLrffNnc1Ibb6xqV91XhnIVMEszdBhNnmzazuGgKxiL3KNb
         CyNyuIRRuEAFuNpMkjXhAqowdhE++lk2iL881SylxWKqlGR3heRXWxCa/SOC0sPm7OTV
         rEE54P7bGUCYoF2LPPqOG/mzLFqU3pprsJh1bsfSHCopzE8tbFohixa7QeIBHFeP1a/+
         WVo86Jo2unAuR0UeWMn3ScmQqP6+IjX9BxHsTM61/VECIQS07xpAu4e8s+nTbKP4Yb14
         EbLnYiSLKBQrLdNwUoI4W63weSklCy7kf4mzWbwZw1kj/7pJ9sbJXKEBMTC9MxL/YifQ
         jIlQ==
X-Gm-Message-State: AGi0PuZxS2fNLeEGslfl/n0YYm4DtxVnz/b9oSgZmUnS1WgtA0/5bElf
        suHQQoNoQAAnGLCdAPofLBiQhvCE8Sm620UXD1M=
X-Google-Smtp-Source: APiQypJ1z3WwUYAdLmTIQt8t0S0iG8l2nXCgCwNcpESzzQ9sKoevR0szr9hGTGxiBwUoNSJ4ZRTwhLPOH35mzPlNvyU=
X-Received: by 2002:aa7:c795:: with SMTP id n21mr6896218eds.6.1588769705047;
 Wed, 06 May 2020 05:55:05 -0700 (PDT)
MIME-Version: 1.0
References: <1588761371-9078-1-git-send-email-amittomer25@gmail.com>
 <1588761371-9078-3-git-send-email-amittomer25@gmail.com> <1c285ad4-a366-db08-e4e8-c2e1437cc505@arm.com>
In-Reply-To: <1c285ad4-a366-db08-e4e8-c2e1437cc505@arm.com>
From:   Amit Tomer <amittomer25@gmail.com>
Date:   Wed, 6 May 2020 18:24:28 +0530
Message-ID: <CABHD4K9mqpcO7jo4NQov__8jEGhAJr2o8JTiX1N+Z=zb9vG0OQ@mail.gmail.com>
Subject: Re: [PATCH RFC 2/8] dmaengine: Actions: Add support for S700 DMA engine
To:     =?UTF-8?Q?Andr=C3=A9_Przywara?= <andre.przywara@arm.com>
Cc:     vkoul@kernel.org,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        dan.j.williams@intel.com, cristian.ciocaltea@gmail.com,
        dmaengine@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-actions@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

Thanks for quick review

> You should mention (at least in the commit message) why this is needed.
> And please move this into a separate function, this indentation is
> becoming mad here

There is not much documented about it, and all I see is GIC crash
if I keep it open for S700. Would figure out more details about it and
update in next version.
.
>
> > +             for (i = 0; i < od->nr_pchans; i++) {
> > +                     pchan = &od->pchans[i];
> > +                     chan_irq_pending = pchan_readl(pchan,
> > +                                                    OWL_DMAX_INT_CTL) &
> > +                                        pchan_readl(pchan,
> > +                                                    OWL_DMAX_INT_STATUS)
> > +                                                     ;
> > +
> > +                     /* Dummy read to ensure OWL_DMA_IRQ_PD0 value is
> > +                      * updated
> > +                      */
> > +                     dma_readl(od, OWL_DMA_IRQ_PD0);
> >
> > -             global_irq_pending = dma_readl(od, OWL_DMA_IRQ_PD0);
> > +                     global_irq_pending = dma_readl(od,
> > +                                                    OWL_DMA_IRQ_PD0);
> >
> > -             if (chan_irq_pending && !(global_irq_pending & BIT(i))) {
> > -                     dev_dbg(od->dma.dev,
> > -                             "global and channel IRQ pending match err\n");
> > +                     if (chan_irq_pending && !(global_irq_pending &
> > +                                               BIT(i))) {
> > +                             dev_dbg(od->dma.dev,
> > +                     "global and channel IRQ pending match err\n");
> >
> > -                     /* Clear IRQ status for this pchan */
> > -                     pchan_update(pchan, OWL_DMAX_INT_STATUS,
> > -                                  0xff, false);
> > +                             /* Clear IRQ status for this pchan */
> > +                             pchan_update(pchan, OWL_DMAX_INT_STATUS,
> > +                                          0xff, false);
> >
> > -                     /* Update global IRQ pending */
> > -                     pending |= BIT(i);
> > +                             /* Update global IRQ pending */
> > +                             pending |= BIT(i);
> > +                     }
> >               }
> >       }
> >
> > @@ -720,6 +743,7 @@ static int owl_dma_resume(struct dma_chan *chan)
> >
> >  static u32 owl_dma_getbytes_chan(struct owl_dma_vchan *vchan)
> >  {
> > +     struct owl_dma *od = to_owl_dma(vchan->vc.chan.device);
> >       struct owl_dma_pchan *pchan;
> >       struct owl_dma_txd *txd;
> >       struct owl_dma_lli *lli;
> > @@ -741,9 +765,15 @@ static u32 owl_dma_getbytes_chan(struct owl_dma_vchan *vchan)
> >               list_for_each_entry(lli, &txd->lli_list, node) {
> >                       /* Start from the next active node */
> >                       if (lli->phys == next_lli_phy) {
> > -                             list_for_each_entry(lli, &txd->lli_list, node)
> > -                                     bytes += lli->hw[OWL_DMADESC_FLEN] &
> > -                                              GENMASK(19, 0);
> > +                             list_for_each_entry(lli, &txd->lli_list, node) {
> > +                                     if (od->devid == S700_DMA)
> > +                                             bytes +=
> > +                                             lli->hw[OWL_DMADESC_FLEN];
> > +                                     else
> > +                                             bytes +=
> > +                                             lli->hw[OWL_DMADESC_FLEN] &
> > +                                             GENMASK(19, 0);
>
> You should have an accessor for getting the frame len, that should avoid
> the insane wrapping here. Or factor this out into a helper function.
> Alternatively revert the if statement and continue, that saves you one
> level of indentation.
>
> I guess flen is limited to 20 bits anyway, so you might want to apply
> the 20-bit mask unconditionally.

Actually, on S700 flen uses 24 bits , so we should not use 20-bit mask.

For accessor function, shall this be okay ?

+static u32 llc_hw_flen(struct owl_dma *od,
+                       struct owl_dma_lli *lli)
+{
+       u32 bit_mask;
+
+       if (od->devid == S700_DMA)
+               bit_mask = 23;
+       else
+               bit_mask = 19;
+
+       return lli->hw[OWL_DMADESC_FLEN] & GENMASK(bit_mask, 0);
+
+}

Thanks
Amit
