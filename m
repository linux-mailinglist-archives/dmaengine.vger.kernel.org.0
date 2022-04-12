Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DD84FDB6D
	for <lists+dmaengine@lfdr.de>; Tue, 12 Apr 2022 12:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354588AbiDLKDj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Apr 2022 06:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355537AbiDLIIb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 12 Apr 2022 04:08:31 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4561EAF;
        Tue, 12 Apr 2022 00:37:36 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id bb38so3505920qtb.3;
        Tue, 12 Apr 2022 00:37:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sju++ztFGWh+V8NuvYNnn8xfQchBMBltAHAO3s39Z8k=;
        b=2M8avMGi86TQhn4sBd37R69XQoNn2fM1odo1WemkhQYVk7scFF6khtTsUXdGKOYU7K
         W/ZM12BXJMEIsl/MHSBp23LEXzPAN6iUvHHva4YWhAQn1p03f/lVzLT1UF/RbHkfBc+6
         jti2On7M5ZbqVqb2Wd1cEYO4y25D1zczyW7A//hTV6b6ggIDFRZysDLTDwkgnjgsR9q3
         TUHDlP8Qm4dKeopceD8JVhQs3RDQM7eiL/S6nP1obq4eWyw6GmCmLf2+5dXqxQyvjeyo
         Uybae/rh/qG7rl8eSdpYZxeP/n6CQQq2s/f+1R/QV7LpcrLFpt6SYLKpD9DK5C8UKA/7
         8Yfw==
X-Gm-Message-State: AOAM5326Thx93oKLJ9BVa6qUvIzmIL+qwyFeZZGtGWglxRzLoHKEsRFI
        FuJpI1knpp/d48FfhebK1MgxYnawMPAbdQgB
X-Google-Smtp-Source: ABdhPJxwDNiiKwUSnwbzZvP2H+H+3GoKCQzp3NGQUr5JFvKWH4Kpv+yw6iIPGCR2L2+ARROXrJTkQw==
X-Received: by 2002:ac8:5e10:0:b0:2e1:cb3e:bb87 with SMTP id h16-20020ac85e10000000b002e1cb3ebb87mr2398455qtx.4.1649749055431;
        Tue, 12 Apr 2022 00:37:35 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id r7-20020ac85c87000000b002e234014a1fsm27598557qta.81.2022.04.12.00.37.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 00:37:34 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-2ed65e63afcso32361177b3.9;
        Tue, 12 Apr 2022 00:37:34 -0700 (PDT)
X-Received: by 2002:a81:4782:0:b0:2eb:1cb1:5441 with SMTP id
 u124-20020a814782000000b002eb1cb15441mr28177896ywa.479.1649749054017; Tue, 12
 Apr 2022 00:37:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220406161856.1669069-1-miquel.raynal@bootlin.com>
 <20220407004511.3A6D1C385A3@smtp.kernel.org> <20220407101605.7d2a17cc@xps13>
 <CAMuHMdUZFTm+0NFLUFoXT7ujtxDot_Y+gya9ETK1FOai2MXfvA@mail.gmail.com> <20220412093155.090de9d6@xps13>
In-Reply-To: <20220412093155.090de9d6@xps13>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Apr 2022 09:37:22 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVpfHuJi1+bm2jvsz8ZpMn8u=5bNYqHBRv7DYykyrC-XQ@mail.gmail.com>
Message-ID: <CAMuHMdVpfHuJi1+bm2jvsz8ZpMn8u=5bNYqHBRv7DYykyrC-XQ@mail.gmail.com>
Subject: Re: [PATCH v8 0/9] RZN1 DMA support
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
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
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Miquel,

On Tue, Apr 12, 2022 at 9:32 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> geert@linux-m68k.org wrote on Mon, 11 Apr 2022 17:09:50 +0200:
> > On Thu, Apr 7, 2022 at 10:16 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > > sboyd@kernel.org wrote on Wed, 06 Apr 2022 17:45:09 -0700:
> > > > Quoting Miquel Raynal (2022-04-06 09:18:47)
> > > > > Here is a first series bringing DMA support to RZN1 platforms. Soon a
> > > > > second series will come with changes made to the UART controller
> > > > > driver, in order to interact with the RZN1 DMA controller.
> > > > >
> > > > > Stephen acked the sysctrl patch (in the clk driver) but somehow I feel
> > > > > like it would be good to have this patch applied on both sides
> > > > > (dmaengine and clk) because more changes will depend on the addition of
> > > > > this helper, that are not related to DMA at all. I'll let you folks
> > > > > figure out what is best.
> > > >
> > > > Are you sending more patches in the next 7 weeks or so that will touch
> > > > the same area? If so, then it sounds like I'll need to take the clk
> > > > patch through clk tree. I don't know what is best because I don't have
> > > > the information about what everyone plans to do in that file.
> > >
> > > This series brings DMA support and needs to access the dmamux registers
> > > that are in the sysctrl area.
> > >
> > > I've sent an RTC series which needs to access this area as well, but
> > > it is not fully ready yet as it was advised to go for a reset
> > > controller in this case. The reset controller would be registered by
> > > the clock driver, so yes it would touch the same file.
> > >
> > > Finally, there is an USB series that is coming soon, I don't know if
> > > it will be ready for merge for 5.19, but it needs to access a specific
> > > register in this area as well (h2mode).
> > >
> > > So provided that we are able to contribute this reset driver quickly
> > > enough, I would argue that it is safer to merge the clk changes in the
> > > clk tree.
> >
> > The clk tree or the renesas-clk tree? ;-)
>
> Actually I forgot about this tree, would you mind to merge *all* the
> patches that depend on the sysctrl changes in the renesas/renesas-clk
> tree? This also stands for the UART and RTC for instance. Otherwise
> you'll need to set up immutable branches and share them with the
> dmaengine, serial and rtc trees. I'm fine either way, it's just much
> less work in the first situation IMHO.

Sure, I can do that, given acks from the DMA, UART, and RTC
maintainers.

So far I've been rather terse in giving feedback on these series,
as I'm in wait-and-see mode w.r.t. what else you've planned for the
sysctrl DT node[1] and clock/sys controller code...

[1] Did I say I'm not that fond of child nodes? But for the dmamux,
    it looks like a good solution to handle this.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
