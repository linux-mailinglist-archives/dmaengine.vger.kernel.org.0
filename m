Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5B4537659
	for <lists+dmaengine@lfdr.de>; Mon, 30 May 2022 10:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiE3IHE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 30 May 2022 04:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiE3IHD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 30 May 2022 04:07:03 -0400
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8A13ED14;
        Mon, 30 May 2022 01:07:01 -0700 (PDT)
Received: by mail-qv1-f48.google.com with SMTP id c12so201699qvr.3;
        Mon, 30 May 2022 01:07:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8KDfY4dQwlNAmncMm2pCzSPhY1XaCkL0xC+jiRDhr8M=;
        b=LTq8DnzHn6yKSWk8PoN1MwJeeQ3Vmev33gp39evw9XWNo/AEAm4BmbDSDZNDfuLjzt
         JdGIN8IPeoap11URDNeHrLj2dc43j6Ymi/FPKXizrIsDs5ry3gl2oKTVtTU4mGidV/iB
         zyiaXfzFVfeu6KzfGXduVm1vAbDSGxK5jd+yTQM5Wh/y6XDQPhJoHo03nk0C37/TBpwE
         mzOwDrLvas/YqOBROfucF2enGiuJvGPw/5E1xvpGam/Y/iOIy0CK1aukqdJpAO/CKpGh
         Hbc1TA4esyO4zZa5ZLjPkHpdZxulm9A53Gz+IK/Mg3+idEX/XX5pFZTq0As6TymRxEKC
         rtDQ==
X-Gm-Message-State: AOAM533SnqwQ9VFtij2zOf/AwaftrFMGL86/mBtc/RLcyCBETTGbt7mz
        caS14UijSmlY3L9c7M2Zco5mJnGwPza7XA==
X-Google-Smtp-Source: ABdhPJwOokFmvwRP4f/heywtDP1NBeu1tI/Qgnw40bnTUuzIZIVwhcBJkLKZFcVqMFlqkVNsr1Wigw==
X-Received: by 2002:a05:6214:f02:b0:462:2876:2938 with SMTP id gw2-20020a0562140f0200b0046228762938mr34846494qvb.116.1653898020068;
        Mon, 30 May 2022 01:07:00 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id c17-20020a05620a269100b006a37eb728cfsm7307904qkp.1.2022.05.30.01.06.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 May 2022 01:06:59 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id x137so17758365ybg.5;
        Mon, 30 May 2022 01:06:58 -0700 (PDT)
X-Received: by 2002:a25:7307:0:b0:65c:b98a:f592 with SMTP id
 o7-20020a257307000000b0065cb98af592mr6483502ybc.380.1653898018583; Mon, 30
 May 2022 01:06:58 -0700 (PDT)
MIME-Version: 1.0
References: <164978679251.2361020.5856734256126725993.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <164978679251.2361020.5856734256126725993.stgit@djiang5-desk3.ch.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 30 May 2022 10:06:39 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVjDTAW-84c9Fh21f_GWOhnD4+VW2nqSTQ6EK-m+KG=vQ@mail.gmail.com>
Message-ID: <CAMuHMdVjDTAW-84c9Fh21f_GWOhnD4+VW2nqSTQ6EK-m+KG=vQ@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: add verification of DMA_INTERRUPT capability
 for dmatest
To:     Dave Jiang <dave.jiang@intel.com>, Vinod <vkoul@kernel.org>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Dave, Vinod,

On Wed, Apr 13, 2022 at 12:58 AM Dave Jiang <dave.jiang@intel.com> wrote:
> Looks like I forgot to add DMA_INTERRUPT cap setting to the idxd driver and
> dmatest is still working regardless of this mistake. Add an explicit check
> of DMA_INTERRUPT capability for dmatest to make sure the DMA device being used
> actually supports interrupt before the test is launched and also that the
> driver is programmed correctly.
>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Thanks for your patch, which is now commit a8facc7b988599f8
("dmaengine: add verification of DMA_INTERRUPT capability for
dmatest") upstream.

> --- a/drivers/dma/dmatest.c
> +++ b/drivers/dma/dmatest.c
> @@ -675,10 +675,16 @@ static int dmatest_func(void *data)
>         /*
>          * src and dst buffers are freed by ourselves below
>          */
> -       if (params->polled)
> +       if (params->polled) {
>                 flags = DMA_CTRL_ACK;
> -       else
> -               flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
> +       } else {
> +               if (dma_has_cap(DMA_INTERRUPT, dev->cap_mask)) {
> +                       flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
> +               } else {
> +                       pr_err("Channel does not support interrupt!\n");
> +                       goto err_pq_array;
> +               }
> +       }
>
>         ktime = ktime_get();
>         while (!(kthread_should_stop() ||
> @@ -906,6 +912,7 @@ static int dmatest_func(void *data)

Shimoda-san reports that this commit breaks dmatest on rcar-dmac.
Like most DMA engine drivers, rcar-dmac does not set the DMA_INTERRUPT
capability flag, hence dmatest now fails to start:

    dmatest: Channel does not support interrupt!

To me, it looks like the new check is bogus, as I believe it confuses
two different concepts:

  1. Documentation/driver-api/dmaengine/provider.rst says:

       - DMA_INTERRUPT

         - The device is able to trigger a dummy transfer that will
           generate periodic interrupts

  2. In non-polled mode, dmatest sets DMA_PREP_INTERRUPT.
     include/linux/dmaengine.h says:

       * @DMA_PREP_INTERRUPT - trigger an interrupt (callback) upon
completion of
       *  this transaction

As dmatest uses real transfers, I think it does not depend on
the ability to use interrupts from dummy transfers.

Do you agree?
Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
