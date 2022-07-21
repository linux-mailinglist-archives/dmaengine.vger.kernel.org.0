Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFBE57D0BF
	for <lists+dmaengine@lfdr.de>; Thu, 21 Jul 2022 18:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiGUQJs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+dmaengine@lfdr.de>); Thu, 21 Jul 2022 12:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiGUQJr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Jul 2022 12:09:47 -0400
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34C71CB35;
        Thu, 21 Jul 2022 09:09:46 -0700 (PDT)
Received: by mail-qv1-f54.google.com with SMTP id y18so1499539qvo.11;
        Thu, 21 Jul 2022 09:09:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iZhX9BXmhapBYhh7KlsStxCLgDjnJhYWOhB5MjqD2i0=;
        b=vX473uiXeTw4Q8ErgQ3mFJytOjo6wt8vZMLUxVRyUUAiHO4zNT0zkjgwtI9SxN9IVa
         yAkFFm6GWQbsT8K8YLwAEJWFrQGch2kuf2fiILaZADmiUj46hAb8uqwgP/cFmgVfna8Y
         Ir+VBnT2oNqDbBtJu2TeoTuBjc9KyNx2BMmrrCacXEknOz6ZBx+9H3YoKh5kJo4TYWmU
         QFvKJqyDGuTfvUucDefI84YwHWp5BQ2ZHCWBQSspnN8OG2IdscEH1iOVRLpfJG3nf8Tj
         stJ07PHVFKGXDsdl33PrEMivA7XaIG8d/IagIG2RHOABwBK3Eco4iVa/K3q+4X8EzePx
         /lXw==
X-Gm-Message-State: AJIora8lbAfmAwstedlTSYghNTTssPgV8KZtY+u0B6MV/Cp/jIwVU+89
        9l95ybA/XD5D9PYJdfy9QZTfYsh8eazJng==
X-Google-Smtp-Source: AGRyM1sWJk7jmGkHsWMW6D32D799xpurxZ3QJXXd2hlXQdpcfPtF5f2vrATLYdjN0ToUnGkw+2JMvA==
X-Received: by 2002:a05:6214:21a7:b0:473:1671:9fba with SMTP id t7-20020a05621421a700b0047316719fbamr34359515qvc.62.1658419785859;
        Thu, 21 Jul 2022 09:09:45 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id bq20-20020a05622a1c1400b00304efba3d84sm1416538qtb.25.2022.07.21.09.09.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 09:09:44 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-31bf3656517so22150067b3.12;
        Thu, 21 Jul 2022 09:09:44 -0700 (PDT)
X-Received: by 2002:a0d:c787:0:b0:31b:a963:e1de with SMTP id
 j129-20020a0dc787000000b0031ba963e1demr46025549ywd.283.1658419784329; Thu, 21
 Jul 2022 09:09:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220721144708.880293-1-biju.das.jz@bp.renesas.com>
 <CAMuHMdVgXA2T0bcxuVUaDW2jeh7tmjEaXroqf8hkeSVmNc2ZcA@mail.gmail.com> <OS0PR01MB5922D9885E8C485DF4FB9D8286919@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922D9885E8C485DF4FB9D8286919@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 21 Jul 2022 18:09:33 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVXdm6e6HveWfYA65_gnLg7f3cUaOpramsFL_wCudMM+Q@mail.gmail.com>
Message-ID: <CAMuHMdVXdm6e6HveWfYA65_gnLg7f3cUaOpramsFL_wCudMM+Q@mail.gmail.com>
Subject: Re: [PATCH v3] dmaengine: sh: rz-dmac: Add device_synchronize callback
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Colin Ian King <colin.king@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
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

On Thu, Jul 21, 2022 at 6:06 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > Subject: Re: [PATCH v3] dmaengine: sh: rz-dmac: Add device_synchronize
> > callback
> >
> > On Thu, Jul 21, 2022 at 4:49 PM Biju Das <biju.das.jz@bp.renesas.com>
> > wrote:
> > > Some on-chip peripheral modules(for eg:- rspi) on RZ/G2L SoC use the
> > > same signal for both interrupt and DMA transfer requests.
> > > The signal works as a DMA transfer request signal by setting DMARS,
> > > and subsequent interrupt requests to the interrupt controller are
> > > masked.
> > >
> > > We can re-enable the interrupt by clearing the DMARS.
> > >
> > > This patch adds device_synchronize callback for clearing DMARS and
> > > thereby allowing DMA consumers to switch to interrupt mode.
> > >
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > ---
> > > v2->v3:
> > >  * Fixed commit description
> > >  * Added check if the DMA operation has been completed or terminated,
> > >    and wait (sleep) if needed.
> >
> > Thanks for the uodate!
> >
> > > --- a/drivers/dma/sh/rz-dmac.c
> > > +++ b/drivers/dma/sh/rz-dmac.c
> > > @@ -12,6 +12,7 @@
> > >  #include <linux/dma-mapping.h>
> > >  #include <linux/dmaengine.h>
> > >  #include <linux/interrupt.h>
> > > +#include <linux/iopoll.h>
> > >  #include <linux/list.h>
> > >  #include <linux/module.h>
> > >  #include <linux/of.h>
> > > @@ -630,6 +631,21 @@ static void rz_dmac_virt_desc_free(struct
> > virt_dma_desc *vd)
> > >          */
> > >  }
> > >
> > > +static void rz_dmac_device_synchronize(struct dma_chan *chan) {
> > > +       struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
> > > +       struct rz_dmac *dmac = to_rz_dmac(chan->device);
> > > +       u32 chstat;
> > > +       int ret;
> > > +
> > > +       ret = read_poll_timeout(rz_dmac_ch_readl, chstat, !(chstat &
> > CHSTAT_EN),
> > > +                               10, 1000, false, channel, CHSTAT, 1);
> >
> > Isn't 1000 µs = 1 ms a bit short?
> > IIUIC, I can submit a DMA operation for transfering a 64 KiB (or larger)
> > block, and call dmaengine_synchronize() immediately after that?
>
> Will increase to 100 msec?? is it ok?

Probably.  As this is a sleeping wait, it doesn't hurt to be conservative.
Do you know what's the maximum transfer size/maximum time a DMA
transfer could take?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
