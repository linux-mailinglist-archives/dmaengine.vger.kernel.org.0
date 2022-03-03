Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54D84CC732
	for <lists+dmaengine@lfdr.de>; Thu,  3 Mar 2022 21:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236350AbiCCUnz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Mar 2022 15:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236332AbiCCUnx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 3 Mar 2022 15:43:53 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDA6CCC7C
        for <dmaengine@vger.kernel.org>; Thu,  3 Mar 2022 12:43:07 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id g7-20020a17090a708700b001bb78857ccdso8871151pjk.1
        for <dmaengine@vger.kernel.org>; Thu, 03 Mar 2022 12:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=B07u8PwztIDT/t6XfdN5+sheHaP7KOymmsGZ6gm7cvQ=;
        b=g35UOZ2H2BUbeBCNpKfxn2d++rHQqBdGKgSqyF9IlKxDEMjB8jqH4437yhcwo3v6DK
         /ixM6hpQFMCxOspVS9T1nLyhrNFe64Nse3uB/kd9lmaMpglfhOZjzy6D2gpTfGw7IaRd
         IR2HOKsex0l4U8co5RVxieOxvigwyso/QO0XcaAv0I+jKsLifYi6NH/jsnuah2oA2qE9
         7RAt+Yv6W5MfXUL015UENVFuDxJzgGnbp613COC+mdTV0QghAy55Z1LNCsO68+YtYskv
         WkY6tpu4MsMRSaiHjqzeri5UPzRrjRmBhiEdvn5L4Oj/BBNIbdSl/XHW2ug+rXQWoUi9
         w5OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=B07u8PwztIDT/t6XfdN5+sheHaP7KOymmsGZ6gm7cvQ=;
        b=WI4ibIqsf7vizoBJ/5XBsZScCc5dXcMfbSIF453UKq1gW/XXCi8HNX+VFA3uAyWKvu
         mtV2jXY24mkMo7UTWiZbXdHWr/pEVl6DoFXiMA9aHTlMKjP4kv33ftJ7B0DIfN6uQikq
         dMjEvFB0RdqIB96IEXW3CR1KZFClIrJOeET0p1GFV9GZvHgMCS4r4S3NQp4L1AW7zSSc
         lsOy9ATXEq7YaKcSwnnegj2WTNZc9xKllHb/ajlGdp1ulvNni0LftpUex1/iB1EdoJWz
         nNCxcmHEqQNnedlyTH7OnzuANoTs1zAITpFhxE+/YUJqoS2Ukr82JsD+ZJOqKnedPpA3
         NNhw==
X-Gm-Message-State: AOAM533kbwxQRC2y2Wa6CNeTD/ySggQ8esfK5GLR56FgL9iDRSEMgNtZ
        0LloAFAyPZAfSKh8FMMYoEdFXg==
X-Google-Smtp-Source: ABdhPJzqWrdGV/V4cZ9E62uIW3uerWRtG11PeC/+Dyn1oLPg/pGjvxJCA+OYLmguFq+xUhW6gSCO9g==
X-Received: by 2002:a17:902:dacd:b0:150:4f5:1158 with SMTP id q13-20020a170902dacd00b0015004f51158mr37292546plx.67.1646340186649;
        Thu, 03 Mar 2022 12:43:06 -0800 (PST)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id k190-20020a633dc7000000b0037c921abb5bsm268485pga.23.2022.03.03.12.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 12:43:06 -0800 (PST)
Date:   Thu, 03 Mar 2022 12:43:06 -0800 (PST)
X-Google-Original-Date: Thu, 03 Mar 2022 12:39:36 PST (-0800)
Subject:     Re: [PATCH v5 3/3] dmaengine: sf-pdma: Get number of channel by device tree
In-Reply-To: <CANXhq0p-Jv2HMNu9NaG=03yudanoqV6MH=LhiCspHbj5nTn+GQ@mail.gmail.com>
CC:     vkoul@kernel.org, robh+dt@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, krzysztof.kozlowski@canonical.com,
        conor.dooley@microchip.com, geert@linux-m68k.org,
        bin.meng@windriver.com, green.wan@sifive.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     zong.li@sifive.com
Message-ID: <mhng-956767d2-f9fc-4d96-8a05-f7a618e3a16b@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, 15 Feb 2022 22:52:14 PST (-0800), zong.li@sifive.com wrote:
> On Tue, Feb 15, 2022 at 8:06 PM Vinod Koul <vkoul@kernel.org> wrote:
>>
>> On 07-02-22, 14:30, Zong Li wrote:
>> > It currently assumes that there are always four channels, it would
>> > cause the error if there is actually less than four channels. Change
>> > that by getting number of channel from device tree.
>> >
>> > For backwards-compatibility, it uses the default value (i.e. 4) when
>> > there is no 'dma-channels' information in dts.
>> >
>> > Signed-off-by: Zong Li <zong.li@sifive.com>
>> > ---
>> >  drivers/dma/sf-pdma/sf-pdma.c | 21 ++++++++++++++-------
>> >  drivers/dma/sf-pdma/sf-pdma.h |  8 ++------
>> >  2 files changed, 16 insertions(+), 13 deletions(-)
>> >
>> > diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
>> > index f12606aeff87..2ae10b61dfa1 100644
>> > --- a/drivers/dma/sf-pdma/sf-pdma.c
>> > +++ b/drivers/dma/sf-pdma/sf-pdma.c
>> > @@ -482,9 +482,7 @@ static void sf_pdma_setup_chans(struct sf_pdma *pdma)
>> >  static int sf_pdma_probe(struct platform_device *pdev)
>> >  {
>> >       struct sf_pdma *pdma;
>> > -     struct sf_pdma_chan *chan;
>> >       struct resource *res;
>> > -     int len, chans;
>> >       int ret;
>> >       const enum dma_slave_buswidth widths =
>> >               DMA_SLAVE_BUSWIDTH_1_BYTE | DMA_SLAVE_BUSWIDTH_2_BYTES |
>> > @@ -492,13 +490,21 @@ static int sf_pdma_probe(struct platform_device *pdev)
>> >               DMA_SLAVE_BUSWIDTH_16_BYTES | DMA_SLAVE_BUSWIDTH_32_BYTES |
>> >               DMA_SLAVE_BUSWIDTH_64_BYTES;
>> >
>> > -     chans = PDMA_NR_CH;
>> > -     len = sizeof(*pdma) + sizeof(*chan) * chans;
>> > -     pdma = devm_kzalloc(&pdev->dev, len, GFP_KERNEL);
>> > +     pdma = devm_kzalloc(&pdev->dev, sizeof(*pdma), GFP_KERNEL);
>> >       if (!pdma)
>> >               return -ENOMEM;
>> >
>> > -     pdma->n_chans = chans;
>> > +     ret = of_property_read_u32(pdev->dev.of_node, "dma-channels",
>> > +                                &pdma->n_chans);
>> > +     if (ret) {
>> > +             dev_notice(&pdev->dev, "set number of channels to default value: 4\n");
>>
>> This is useful for only debug i think, so dev_dbg perhaps
>>
>
> Thanks for your suggestion, let me change it in the next version.

Not sure if I'm missing something, but I don't see a v6.  I'm going to 
assume that one will be sent, but the suggested changes look minor 
enough so 

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

LMK if you guys were expecting this to go in via the RISC-V tree, 
otherwise I'll assume this aimed at the dmaengine tree.  Probably best to keep
all three together, so feel free to take the DTS updates as well -- having some
shared tag never hurts, but the DTs don't move that much so any conflicts
should be straight-forward to just fix at merge time.

Thanks!

>> > +             pdma->n_chans = PDMA_MAX_NR_CH;
>> > +     }
>> > +
>> > +     if (pdma->n_chans > PDMA_MAX_NR_CH) {
>> > +             dev_err(&pdev->dev, "the number of channels exceeds the maximum\n");
>> > +             return -EINVAL;
>> > +     }
>> >
>> >       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> >       pdma->membase = devm_ioremap_resource(&pdev->dev, res);
>> > @@ -556,7 +562,7 @@ static int sf_pdma_remove(struct platform_device *pdev)
>> >       struct sf_pdma_chan *ch;
>> >       int i;
>> >
>> > -     for (i = 0; i < PDMA_NR_CH; i++) {
>> > +     for (i = 0; i < pdma->n_chans; i++) {
>> >               ch = &pdma->chans[i];
>> >
>> >               devm_free_irq(&pdev->dev, ch->txirq, ch);
>> > @@ -574,6 +580,7 @@ static int sf_pdma_remove(struct platform_device *pdev)
>> >
>> >  static const struct of_device_id sf_pdma_dt_ids[] = {
>> >       { .compatible = "sifive,fu540-c000-pdma" },
>> > +     { .compatible = "sifive,pdma0" },
>> >       {},
>> >  };
>> >  MODULE_DEVICE_TABLE(of, sf_pdma_dt_ids);
>> > diff --git a/drivers/dma/sf-pdma/sf-pdma.h b/drivers/dma/sf-pdma/sf-pdma.h
>> > index 0c20167b097d..8127d792f639 100644
>> > --- a/drivers/dma/sf-pdma/sf-pdma.h
>> > +++ b/drivers/dma/sf-pdma/sf-pdma.h
>> > @@ -22,11 +22,7 @@
>> >  #include "../dmaengine.h"
>> >  #include "../virt-dma.h"
>> >
>> > -#define PDMA_NR_CH                                   4
>> > -
>> > -#if (PDMA_NR_CH != 4)
>> > -#error "Please define PDMA_NR_CH to 4"
>> > -#endif
>> > +#define PDMA_MAX_NR_CH                                       4
>> >
>> >  #define PDMA_BASE_ADDR                                       0x3000000
>> >  #define PDMA_CHAN_OFFSET                             0x1000
>> > @@ -118,7 +114,7 @@ struct sf_pdma {
>> >       void __iomem            *membase;
>> >       void __iomem            *mappedbase;
>> >       u32                     n_chans;
>> > -     struct sf_pdma_chan     chans[PDMA_NR_CH];
>> > +     struct sf_pdma_chan     chans[PDMA_MAX_NR_CH];
>>
>> why waste memory allocating max, we know number of channels in probe,
>> why not allocate runtime?
>>
>
> I kept it there because I'd like to do minimum change in this patch
> set. You're right, let me change it in the next version.
>
>> --
>> ~Vinod
