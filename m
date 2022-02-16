Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6F84B8119
	for <lists+dmaengine@lfdr.de>; Wed, 16 Feb 2022 08:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiBPHMO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Feb 2022 02:12:14 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiBPHMN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 16 Feb 2022 02:12:13 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7A8657A
        for <dmaengine@vger.kernel.org>; Tue, 15 Feb 2022 23:11:46 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id p22so2101628lfu.5
        for <dmaengine@vger.kernel.org>; Tue, 15 Feb 2022 23:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gjCi/HaXP+bc/Zw8WReu9bjIQ1k5GoBWpagMKd2Rfl0=;
        b=IgeglsV3Ccf40cqfZi33wnyMePOTDBS1Gj63ZrI9pUvFILQtGV9unvSUw8faEfUy7K
         kKoVrK5Wxjt/WSSaJhjW/Xmo1AKosOR6Mcy0NWvmAT/Hh3D2Mw8FiDGRRv2Hbmt3gZiU
         ESS5BZClYqWMuKOWKgJa6lrxHAeFFMfhFxla5BFuviqkVZJwZVFXZRg/U69ZwP84G6we
         CUBGkFGlnnuLpDwVoMrSlArTHFSrAqrXvmy9yaUpWtSEffK54ZAe5/5m5XsXwMfXwty6
         VIiAWTULGPYZmucLXgL8vYknVqPDEaHIT4bXnb6n5pwGkOEob4R6CV0OHLkXQcFv6QPC
         lDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gjCi/HaXP+bc/Zw8WReu9bjIQ1k5GoBWpagMKd2Rfl0=;
        b=SNkGsKhbNXwi4qD/OplNdvoDQ/3WXC9A76jBg76Kg3dkYnkwQJpRh7sPNNktykzmCm
         GyF1jXRdfhFP4nHeQayHH8eL12cTD+RbGRljKsTtRIcmRJHKcpE00cDbkUVCUHAKWQEE
         LB7PP6EGxCDneZ3dczFgFDsBODH2TZrJ2ptADdX7Tt9JD06XhM5l9/Z3vM8iXqV3VnoK
         2w+BNNJqznrt15U1O5TPeH57fek/WTAtiEiVQD4i71l2nIdrDsijx9dCUcVhqPhF3FC/
         AxKG3PSxWB9pPiVLTl6OfRwdw2lSRgijsZAn3rnDCn1vYANJaP/++w+P59Qo8wud3G3x
         UssQ==
X-Gm-Message-State: AOAM533zp/0FTkuuCsVpGPOvl88xmXOXEyrjXGGckY1qDleMVgGeNoUB
        TN1eU9UMW/ruZLyoSvjf1jD9WoJkAWB31y39S93c8dHhbpiA9g==
X-Google-Smtp-Source: ABdhPJzRa2uVf64r3DqFR9UHw6YBgNGoCCYRwHItiwnl8QbxzQYuOmfiTBLUXZ0paSS6h6rWhZbscI5mfu3Fe6s3Rvc=
X-Received: by 2002:ac2:4e4a:0:b0:430:5dc2:3877 with SMTP id
 f10-20020ac24e4a000000b004305dc23877mr1062162lfr.116.1644994346088; Tue, 15
 Feb 2022 22:52:26 -0800 (PST)
MIME-Version: 1.0
References: <cover.1644215230.git.zong.li@sifive.com> <df6c8d1c701b33fa735dd072de3cb585dc60f2c9.1644215230.git.zong.li@sifive.com>
 <YguXQJp/b/8SzjGX@matsya>
In-Reply-To: <YguXQJp/b/8SzjGX@matsya>
From:   Zong Li <zong.li@sifive.com>
Date:   Wed, 16 Feb 2022 14:52:14 +0800
Message-ID: <CANXhq0p-Jv2HMNu9NaG=03yudanoqV6MH=LhiCspHbj5nTn+GQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] dmaengine: sf-pdma: Get number of channel by
 device tree
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Bin Meng <bin.meng@windriver.com>,
        Green Wan <green.wan@sifive.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Feb 15, 2022 at 8:06 PM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 07-02-22, 14:30, Zong Li wrote:
> > It currently assumes that there are always four channels, it would
> > cause the error if there is actually less than four channels. Change
> > that by getting number of channel from device tree.
> >
> > For backwards-compatibility, it uses the default value (i.e. 4) when
> > there is no 'dma-channels' information in dts.
> >
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > ---
> >  drivers/dma/sf-pdma/sf-pdma.c | 21 ++++++++++++++-------
> >  drivers/dma/sf-pdma/sf-pdma.h |  8 ++------
> >  2 files changed, 16 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
> > index f12606aeff87..2ae10b61dfa1 100644
> > --- a/drivers/dma/sf-pdma/sf-pdma.c
> > +++ b/drivers/dma/sf-pdma/sf-pdma.c
> > @@ -482,9 +482,7 @@ static void sf_pdma_setup_chans(struct sf_pdma *pdma)
> >  static int sf_pdma_probe(struct platform_device *pdev)
> >  {
> >       struct sf_pdma *pdma;
> > -     struct sf_pdma_chan *chan;
> >       struct resource *res;
> > -     int len, chans;
> >       int ret;
> >       const enum dma_slave_buswidth widths =
> >               DMA_SLAVE_BUSWIDTH_1_BYTE | DMA_SLAVE_BUSWIDTH_2_BYTES |
> > @@ -492,13 +490,21 @@ static int sf_pdma_probe(struct platform_device *pdev)
> >               DMA_SLAVE_BUSWIDTH_16_BYTES | DMA_SLAVE_BUSWIDTH_32_BYTES |
> >               DMA_SLAVE_BUSWIDTH_64_BYTES;
> >
> > -     chans = PDMA_NR_CH;
> > -     len = sizeof(*pdma) + sizeof(*chan) * chans;
> > -     pdma = devm_kzalloc(&pdev->dev, len, GFP_KERNEL);
> > +     pdma = devm_kzalloc(&pdev->dev, sizeof(*pdma), GFP_KERNEL);
> >       if (!pdma)
> >               return -ENOMEM;
> >
> > -     pdma->n_chans = chans;
> > +     ret = of_property_read_u32(pdev->dev.of_node, "dma-channels",
> > +                                &pdma->n_chans);
> > +     if (ret) {
> > +             dev_notice(&pdev->dev, "set number of channels to default value: 4\n");
>
> This is useful for only debug i think, so dev_dbg perhaps
>

Thanks for your suggestion, let me change it in the next version.

> > +             pdma->n_chans = PDMA_MAX_NR_CH;
> > +     }
> > +
> > +     if (pdma->n_chans > PDMA_MAX_NR_CH) {
> > +             dev_err(&pdev->dev, "the number of channels exceeds the maximum\n");
> > +             return -EINVAL;
> > +     }
> >
> >       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >       pdma->membase = devm_ioremap_resource(&pdev->dev, res);
> > @@ -556,7 +562,7 @@ static int sf_pdma_remove(struct platform_device *pdev)
> >       struct sf_pdma_chan *ch;
> >       int i;
> >
> > -     for (i = 0; i < PDMA_NR_CH; i++) {
> > +     for (i = 0; i < pdma->n_chans; i++) {
> >               ch = &pdma->chans[i];
> >
> >               devm_free_irq(&pdev->dev, ch->txirq, ch);
> > @@ -574,6 +580,7 @@ static int sf_pdma_remove(struct platform_device *pdev)
> >
> >  static const struct of_device_id sf_pdma_dt_ids[] = {
> >       { .compatible = "sifive,fu540-c000-pdma" },
> > +     { .compatible = "sifive,pdma0" },
> >       {},
> >  };
> >  MODULE_DEVICE_TABLE(of, sf_pdma_dt_ids);
> > diff --git a/drivers/dma/sf-pdma/sf-pdma.h b/drivers/dma/sf-pdma/sf-pdma.h
> > index 0c20167b097d..8127d792f639 100644
> > --- a/drivers/dma/sf-pdma/sf-pdma.h
> > +++ b/drivers/dma/sf-pdma/sf-pdma.h
> > @@ -22,11 +22,7 @@
> >  #include "../dmaengine.h"
> >  #include "../virt-dma.h"
> >
> > -#define PDMA_NR_CH                                   4
> > -
> > -#if (PDMA_NR_CH != 4)
> > -#error "Please define PDMA_NR_CH to 4"
> > -#endif
> > +#define PDMA_MAX_NR_CH                                       4
> >
> >  #define PDMA_BASE_ADDR                                       0x3000000
> >  #define PDMA_CHAN_OFFSET                             0x1000
> > @@ -118,7 +114,7 @@ struct sf_pdma {
> >       void __iomem            *membase;
> >       void __iomem            *mappedbase;
> >       u32                     n_chans;
> > -     struct sf_pdma_chan     chans[PDMA_NR_CH];
> > +     struct sf_pdma_chan     chans[PDMA_MAX_NR_CH];
>
> why waste memory allocating max, we know number of channels in probe,
> why not allocate runtime?
>

I kept it there because I'd like to do minimum change in this patch
set. You're right, let me change it in the next version.

> --
> ~Vinod
