Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0CD157CF44
	for <lists+dmaengine@lfdr.de>; Thu, 21 Jul 2022 17:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbiGUPf7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+dmaengine@lfdr.de>); Thu, 21 Jul 2022 11:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbiGUPfM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Jul 2022 11:35:12 -0400
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CADD26FF;
        Thu, 21 Jul 2022 08:35:07 -0700 (PDT)
Received: by mail-qv1-f45.google.com with SMTP id f9so1452940qvr.2;
        Thu, 21 Jul 2022 08:35:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=71IgnlFJ4uRW4C6nBmKDFFYOWPJZuY28gDjKGFFBu2Q=;
        b=2gU/S1iJdp5e8pmNFC0P70QyRrty/4d/rZxs8Rfka0WKPrVEz/PHvqiqzckJlGZ3M4
         vE1EPrLJIZFZWee3SL0m1Qa90SOrOP2cXXT4NTZ+7TZeHCO8Vz33JhGuob09LVOObImr
         4Rvcb+4yMXx8+hD+SbSDpJ8r0cyl67+IPwmcXfX9cZO1ITrp8olqfP1URfUifAzAJBAT
         nWJOxudScT/h3+DW+8kvdM5vaQMnAQcwQqeL9aF6U+k+jLeTBZLOzRHlI9ekaIZLZ64P
         pDwNWcp1ScfJlSn8ukxU6hDwoq4ijx9XgLBop1X2JPufSXTIwtQ35jTjbPRxc3E638vZ
         5wJQ==
X-Gm-Message-State: AJIora8wZBC1BXaWcijw36Btwtdc42LrJ3NCN69TlM6fQjp8aYQBBqBT
        LQGL3n3Ww2saT+/FH63R1PgACWBuOraaMg==
X-Google-Smtp-Source: AGRyM1v5xSHg8rnJ8FmZzrPICnlyKkeF7mRZiwUTCpK66A8f5sCSorLCiDP7nYqqoUMXJtzMemJuoQ==
X-Received: by 2002:a05:6214:20a8:b0:474:81b:fcc9 with SMTP id 8-20020a05621420a800b00474081bfcc9mr6264067qvd.97.1658417705815;
        Thu, 21 Jul 2022 08:35:05 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id cf5-20020a05622a400500b0031ee01443b4sm1333385qtb.74.2022.07.21.08.35.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 08:35:05 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-31e47ac84daso21616817b3.0;
        Thu, 21 Jul 2022 08:35:05 -0700 (PDT)
X-Received: by 2002:a81:6088:0:b0:31e:79fd:3dfa with SMTP id
 u130-20020a816088000000b0031e79fd3dfamr4938677ywb.47.1658417704849; Thu, 21
 Jul 2022 08:35:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220721144708.880293-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20220721144708.880293-1-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 21 Jul 2022 17:34:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVgXA2T0bcxuVUaDW2jeh7tmjEaXroqf8hkeSVmNc2ZcA@mail.gmail.com>
Message-ID: <CAMuHMdVgXA2T0bcxuVUaDW2jeh7tmjEaXroqf8hkeSVmNc2ZcA@mail.gmail.com>
Subject: Re: [PATCH v3] dmaengine: sh: rz-dmac: Add device_synchronize callback
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Colin Ian King <colin.king@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Biju,

On Thu, Jul 21, 2022 at 4:49 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> Some on-chip peripheral modules(for eg:- rspi) on RZ/G2L SoC
> use the same signal for both interrupt and DMA transfer requests.
> The signal works as a DMA transfer request signal by setting
> DMARS, and subsequent interrupt requests to the interrupt controller
> are masked.
>
> We can re-enable the interrupt by clearing the DMARS.
>
> This patch adds device_synchronize callback for clearing
> DMARS and thereby allowing DMA consumers to switch to
> interrupt mode.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v2->v3:
>  * Fixed commit description
>  * Added check if the DMA operation has been completed or terminated,
>    and wait (sleep) if needed.

Thanks for the uodate!

> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -12,6 +12,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/dmaengine.h>
>  #include <linux/interrupt.h>
> +#include <linux/iopoll.h>
>  #include <linux/list.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> @@ -630,6 +631,21 @@ static void rz_dmac_virt_desc_free(struct virt_dma_desc *vd)
>          */
>  }
>
> +static void rz_dmac_device_synchronize(struct dma_chan *chan)
> +{
> +       struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
> +       struct rz_dmac *dmac = to_rz_dmac(chan->device);
> +       u32 chstat;
> +       int ret;
> +
> +       ret = read_poll_timeout(rz_dmac_ch_readl, chstat, !(chstat & CHSTAT_EN),
> +                               10, 1000, false, channel, CHSTAT, 1);

Isn't 1000 µs = 1 ms a bit short?
IIUIC, I can submit a DMA operation for transfering a 64 KiB (or larger)
block, and call dmaengine_synchronize() immediately after that?

> +       if (ret < 0)
> +               dev_warn(dmac->dev, "DMA Timeout");
> +
> +       rz_dmac_set_dmars_register(dmac, channel->index, 0);
> +}
> +
>  /*
>   * -----------------------------------------------------------------------------
>   * IRQ handling

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
