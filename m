Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA174511B19
	for <lists+dmaengine@lfdr.de>; Wed, 27 Apr 2022 16:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235050AbiD0MyI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 Apr 2022 08:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235034AbiD0MyH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 Apr 2022 08:54:07 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974FF2C259B;
        Wed, 27 Apr 2022 05:50:56 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id o11so988246qtp.13;
        Wed, 27 Apr 2022 05:50:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+FsGG6ML55JyWb07rb2rElQSAfjQo5KUMUNvexzkcfc=;
        b=BKb032CNfel3jYjjsvtHSaZ/N5MKS4AxClULav9+4w0NXcNAbC+9Ig5jqyVhmeNxB7
         cN8FNPeY35l4z27Zaqq2TTmQDcluvd6WIMMYsyX3OG18YXNEQjfByjK+s+26JUg8eHHV
         pjCT05JtDoG5YXZ+xbNqT4hmHMgNvouw2tjPZnXTqkxQhkVOBWTE707vmrkn3iO+/eU5
         YzkjuFs6KTzN8VYtXCZKwDDaLI4ihcxeN2NrjJCBg2s0ILZmfyJk27a34U2lU7KOi87S
         K/nuWk1/AJU62U35PloWbydOFTDavkEegUa9S5NqyJxlBIE+335zVmRIGL/vcDead+zG
         DzMw==
X-Gm-Message-State: AOAM532vLQSq8fT8KNtS/GzRyNZRMSQ/YA8Sz0Ctk+T5YnDqVOTbiTst
        prfwImzcyVjVYKNx/mDW0PmxrldK984ntg==
X-Google-Smtp-Source: ABdhPJyFv5F603bAwFi5VI4ecbk46qlf8/nNDtcedW4E7Qq3+1TCcpw88I3sJD71BGg3gtuxfk1K/A==
X-Received: by 2002:a05:622a:c3:b0:2f3:66ce:251d with SMTP id p3-20020a05622a00c300b002f366ce251dmr10587121qtw.157.1651063855243;
        Wed, 27 Apr 2022 05:50:55 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id v23-20020ae9e317000000b0069ea555b54dsm7816680qkf.128.2022.04.27.05.50.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 05:50:54 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id w187so3198277ybe.2;
        Wed, 27 Apr 2022 05:50:54 -0700 (PDT)
X-Received: by 2002:a25:8087:0:b0:641:dd06:577d with SMTP id
 n7-20020a258087000000b00641dd06577dmr25319803ybk.207.1651063854230; Wed, 27
 Apr 2022 05:50:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220421085112.78858-1-miquel.raynal@bootlin.com>
 <CAMuHMdU6Mb9k_g7yBCknmL9DMjUSzk=W_5wiMNDMsTN6RpkcLg@mail.gmail.com> <20220426093232.350ed9f4@xps13>
In-Reply-To: <20220426093232.350ed9f4@xps13>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 27 Apr 2022 14:50:43 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUvD3xsObMJwhUtHVqPpAL-ehW8+sx0Ru8-zm18yWQVKA@mail.gmail.com>
Message-ID: <CAMuHMdUvD3xsObMJwhUtHVqPpAL-ehW8+sx0Ru8-zm18yWQVKA@mail.gmail.com>
Subject: Re: [PATCH v11 0/9] RZN1 DMA support
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Vinod Koul <vkoul@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
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

Hi Miquel,

On Tue, Apr 26, 2022 at 9:32 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> geert@linux-m68k.org wrote on Mon, 25 Apr 2022 18:05:34 +0200:
> > On Thu, Apr 21, 2022 at 10:51 AM Miquel Raynal
> > <miquel.raynal@bootlin.com> wrote:
> > > This is the series bringing DMA support to RZN1 platforms.
> > > Other series follow with eg. UART and RTC support as well.
> >
> > Thanks for your series!
> >
> > > There is no other conflicting dependency with the other series, so this
> > > series can now entirely be merged in the dmaengine tree I believe.
> > >
> > > Changes in v11:
> > > * Renamed two defines.
> > > * Changed the way the bitmap is declared.
> > > * Updated the cover letter: this series can now go in through the
> > >   dmaengine tree.
> >
> > /me confused
> >
> > > Miquel Raynal (9):
> > >   dt-bindings: dmaengine: Introduce RZN1 dmamux bindings
> > >   dt-bindings: clock: r9a06g032-sysctrl: Reference the DMAMUX subnode
> > >   dt-bindings: dmaengine: Introduce RZN1 DMA compatible
> > >   soc: renesas: rzn1-sysc: Export function to set dmamux
> > >   dmaengine: dw: dmamux: Introduce RZN1 DMA router support
> > >   clk: renesas: r9a06g032: Probe possible children
> > >   dmaengine: dw: Add RZN1 compatible
> > >   ARM: dts: r9a06g032: Add the two DMA nodes
> > >   ARM: dts: r9a06g032: Describe the DMA router
> >
> > The last two DTS parts have to go in through the renesas-arm-dt and
> > soc trees.
>
> Yes, DT usually never go in through subsystem trees anyway, of
> course they should be taken in through the Renesas tree. For the other
> patches I think its simpler if everything goes through the dmaengine
> tree, but I'm fine either way, I'll let you discuss this with the DMA
> folks if you disagree.

Fine for me.  I've acked the renesas-clk related patches, so they
can go in through the dmaengine tree.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
