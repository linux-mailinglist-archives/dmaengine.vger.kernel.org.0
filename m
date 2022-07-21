Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3EB957C830
	for <lists+dmaengine@lfdr.de>; Thu, 21 Jul 2022 11:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiGUJzN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Jul 2022 05:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbiGUJzM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Jul 2022 05:55:12 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB63B2ACB;
        Thu, 21 Jul 2022 02:55:09 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id l14so869397qtv.4;
        Thu, 21 Jul 2022 02:55:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qWg5wy/YCcBAB7ojxq/3p5ugY5Ap/K3ukl7WCYLvhLM=;
        b=OUtbFfQpYGOiG6iEpyh27XG78RdQ45HKtHrCR0OtHfd03hcaxv3vnM8B+fMiJ1vB+4
         6+61opjOkiLdMyspnkweNKeIzv5HC41DJ/jCzZBT+HwT90JbN2lxOlYwNgtD6hJuiQZt
         7fUOKWT58S0QSmBdyapzT01kWwmj3o9VIxIhnWK9jV8B1DfUK2gCoT6SoMsjhEEseTEM
         GAUBiQ2ulns6kZfLD8PAsvxFFEbDB/8ZI0DoYdNQjWRYPhfg3jEFoqoMsrIDcaeZnCFU
         zF/jrQmQl7JHhB7tZs2i7X7f8zd8d3boV7hfM/aK6NIZcNnZwnhmVlksFQ56hBr1ijzK
         bfNA==
X-Gm-Message-State: AJIora/moltXXED2DZmMfPIMb688dUqKZ575Lxvw2nwg9IsIDRhxSSKn
        k5ye9KxnuAlQPSmeVBlmw3h5dT9kg5zwdg==
X-Google-Smtp-Source: AGRyM1vLNCeU4dCts9JNa6sOAFjF3R+OLEolpp41ArRGBe/eYj0EzBjtM1fFmD61epP6vBmQfN2CHw==
X-Received: by 2002:a05:622a:5d4:b0:31e:e357:f843 with SMTP id d20-20020a05622a05d400b0031ee357f843mr20018467qtb.588.1658397308782;
        Thu, 21 Jul 2022 02:55:08 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id w38-20020a05622a192600b0031bba2e05aesm1012733qtc.58.2022.07.21.02.55.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 02:55:08 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 64so1870576ybt.12;
        Thu, 21 Jul 2022 02:55:07 -0700 (PDT)
X-Received: by 2002:a25:f06:0:b0:670:1685:d31d with SMTP id
 6-20020a250f06000000b006701685d31dmr22243872ybp.380.1658397307407; Thu, 21
 Jul 2022 02:55:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220719150000.383722-1-biju.das.jz@bp.renesas.com> <CAMuHMdVoU4LHiZmxM_DsGz5kMFAbRzvwJwtkcgCKp3SBtYW6ww@mail.gmail.com>
In-Reply-To: <CAMuHMdVoU4LHiZmxM_DsGz5kMFAbRzvwJwtkcgCKp3SBtYW6ww@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 21 Jul 2022 11:54:56 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXE36V9dB9C4UmoYnfiYLp-u2XM0fdSwmQpB1DgGoBthA@mail.gmail.com>
Message-ID: <CAMuHMdXE36V9dB9C4UmoYnfiYLp-u2XM0fdSwmQpB1DgGoBthA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dmaengine: sh: rz-dmac: Add device_synchronize callback
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Colin Ian King <colin.king@intel.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Biju,

On Thu, Jul 21, 2022 at 11:47 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Tue, Jul 19, 2022 at 5:00 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > Some on-chip peripheral modules(for eg:- rspi) on RZ/G2L SoC
> > use the same signal for both interrupt and DMA transfer requests.
> > The signal works as a DMA transfer request signal by setting
> > DMARS, and subsequent interrupt requests to the interrupt controller
> > are masked.
> >
> > We can enable the interrupt by clearing the DMARS.
>
> re-enable?
>
> >
> > This patch adds device_synchronize callback for clearing
> > DMARS and thereby allowing DMA consumers to switch to
> > DMA mode.
>
> interrupt mode
>
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> > v1->v2:
> >  * No change
>
> With the above fixed:
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> > +static void rz_dmac_device_synchronize(struct dma_chan *chan)
> > +{
> > +       struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
> > +       struct rz_dmac *dmac = to_rz_dmac(chan->device);
> > +

Actually this should check if the DMA operation has been completed
or terminated, and wait (sleep) if needed.

> > +       rz_dmac_set_dmars_register(dmac, channel->index, 0);
> > +}

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
