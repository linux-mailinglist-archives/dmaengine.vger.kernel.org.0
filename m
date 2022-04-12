Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0104FDB67
	for <lists+dmaengine@lfdr.de>; Tue, 12 Apr 2022 12:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240742AbiDLKCZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Apr 2022 06:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380843AbiDLIWn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 12 Apr 2022 04:22:43 -0400
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05884F9CF;
        Tue, 12 Apr 2022 00:52:39 -0700 (PDT)
Received: by mail-qv1-f49.google.com with SMTP id n11so4721963qvl.0;
        Tue, 12 Apr 2022 00:52:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3EWUkumYa767x1xmZsomqu/jb1QeueIdmUOwM+PNwgA=;
        b=IYv/jDoGqZk7JQt+6B7Mb3wUEjLP/BoxWvxam4fe+YlUpfCc9PoU9b4HQMTRa4tnY6
         MKBARZvcV+lMqklkfiRhU3/8V7VLXJfq/1Ows/APowEk17W1qvNdu3c2+Z46W0W3Wf4m
         D92wgntjdLj3QhDyBd528oQjHWex7b/T4CPiJOlYsNE+hXFlFMZ6JHZi2be4gH/dBAFg
         m3wEts89vg2RZTt9rc4pdG5ON6jbsvXZ6Sj4CUjXyLLf9VCPmfaInF5C97q64VpibdHJ
         IhByvhbqD4ut5yS5/F2/VJ3ahTUbPuOJC4Dee12qlQcfHeAWIV8lm5T4tQVvdFyzfXRF
         9Pgg==
X-Gm-Message-State: AOAM530I6EPlChBwcbtuFn4oYnCPgveEpmdRVVNsE6Ozbym0BG1eRICQ
        knaCI1BrkoTZM+XpZDEdWoAqrKZfbGe5jRGs
X-Google-Smtp-Source: ABdhPJy/ENtEDzuTB185TBUyi9LMz8oqVDPQUGwLpqzCEAkQv6tLw7ll3Tny8urvFYdMukaTgJxF+Q==
X-Received: by 2002:a05:6214:daa:b0:441:7161:de4b with SMTP id h10-20020a0562140daa00b004417161de4bmr30072940qvh.48.1649749958645;
        Tue, 12 Apr 2022 00:52:38 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id j19-20020a05622a039300b002ecc2ebfd87sm10050735qtx.32.2022.04.12.00.52.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 00:52:38 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id i20so10531607ybj.7;
        Tue, 12 Apr 2022 00:52:37 -0700 (PDT)
X-Received: by 2002:a25:c049:0:b0:634:6751:e8d2 with SMTP id
 c70-20020a25c049000000b006346751e8d2mr26038321ybf.6.1649749956492; Tue, 12
 Apr 2022 00:52:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220406161856.1669069-1-miquel.raynal@bootlin.com>
 <20220407004511.3A6D1C385A3@smtp.kernel.org> <20220407101605.7d2a17cc@xps13>
 <CAMuHMdUZFTm+0NFLUFoXT7ujtxDot_Y+gya9ETK1FOai2MXfvA@mail.gmail.com>
 <20220412093155.090de9d6@xps13> <CAMuHMdVpfHuJi1+bm2jvsz8ZpMn8u=5bNYqHBRv7DYykyrC-XQ@mail.gmail.com>
 <20220412094338.382e8754@xps13>
In-Reply-To: <20220412094338.382e8754@xps13>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Apr 2022 09:52:25 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVaWskmiqUEyGyz7HKUjgzFhx+5hAJxd5od7Hp4hFD1KA@mail.gmail.com>
Message-ID: <CAMuHMdVaWskmiqUEyGyz7HKUjgzFhx+5hAJxd5od7Hp4hFD1KA@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Miquel,

On Tue, Apr 12, 2022 at 9:43 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> geert@linux-m68k.org wrote on Tue, 12 Apr 2022 09:37:22 +0200:
> > On Tue, Apr 12, 2022 at 9:32 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > > geert@linux-m68k.org wrote on Mon, 11 Apr 2022 17:09:50 +0200:
> > > > On Thu, Apr 7, 2022 at 10:16 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > > > > sboyd@kernel.org wrote on Wed, 06 Apr 2022 17:45:09 -0700:
> > > > > > Quoting Miquel Raynal (2022-04-06 09:18:47)
> > > > > > > Here is a first series bringing DMA support to RZN1 platforms. Soon a
> > > > > > > second series will come with changes made to the UART controller
> > > > > > > driver, in order to interact with the RZN1 DMA controller.
> > > > > > >
> > > > > > > Stephen acked the sysctrl patch (in the clk driver) but somehow I feel
> > > > > > > like it would be good to have this patch applied on both sides
> > > > > > > (dmaengine and clk) because more changes will depend on the addition of
> > > > > > > this helper, that are not related to DMA at all. I'll let you folks
> > > > > > > figure out what is best.
> > > > > >
> > > > > > Are you sending more patches in the next 7 weeks or so that will touch
> > > > > > the same area? If so, then it sounds like I'll need to take the clk
> > > > > > patch through clk tree. I don't know what is best because I don't have
> > > > > > the information about what everyone plans to do in that file.
> > > > >
> > > > > This series brings DMA support and needs to access the dmamux registers
> > > > > that are in the sysctrl area.
> > > > >
> > > > > I've sent an RTC series which needs to access this area as well, but
> > > > > it is not fully ready yet as it was advised to go for a reset
> > > > > controller in this case. The reset controller would be registered by
> > > > > the clock driver, so yes it would touch the same file.
> > > > >
> > > > > Finally, there is an USB series that is coming soon, I don't know if
> > > > > it will be ready for merge for 5.19, but it needs to access a specific
> > > > > register in this area as well (h2mode).
> > > > >
> > > > > So provided that we are able to contribute this reset driver quickly
> > > > > enough, I would argue that it is safer to merge the clk changes in the
> > > > > clk tree.
> > > >
> > > > The clk tree or the renesas-clk tree? ;-)
> > >
> > > Actually I forgot about this tree, would you mind to merge *all* the
> > > patches that depend on the sysctrl changes in the renesas/renesas-clk
> > > tree? This also stands for the UART and RTC for instance. Otherwise
> > > you'll need to set up immutable branches and share them with the
> > > dmaengine, serial and rtc trees. I'm fine either way, it's just much
> > > less work in the first situation IMHO.
> >
> > Sure, I can do that, given acks from the DMA, UART, and RTC
> > maintainers.
>
> Ok, I'll say so in the cover letter of the v9.
>
> > So far I've been rather terse in giving feedback on these series,
> > as I'm in wait-and-see mode w.r.t. what else you've planned for the
> > sysctrl DT node[1] and clock/sys controller code...
> >
> > [1] Did I say I'm not that fond of child nodes? But for the dmamux,
> >     it looks like a good solution to handle this.
>
> O:-)
>
> I plan in the coming days to write a proper reset controller driver
> that will be queried by the rtc driver (as proposed by Alexandre).

OK.

> Which means I'll have to declare this reset controller as a child of
> the systrl node. If you disagree with it, you may jump-in, see this
> thread :
>
>         Subject: Re: [PATCH 2/7] soc: renesas: rzn1-sysc: Export a
>                  function to  enable/disable the RTC
>         Date: Wed, 6 Apr 2022 10:32:31 +0200

But do you need a child node for that? All(most all) other Renesas
clock drivers provide reset functionality, and none of them use a
child node for that.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
