Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A8F552E60
	for <lists+dmaengine@lfdr.de>; Tue, 21 Jun 2022 11:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348834AbiFUJci (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 Jun 2022 05:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347196AbiFUJch (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 21 Jun 2022 05:32:37 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9ADA13CF4;
        Tue, 21 Jun 2022 02:32:36 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id i18so7717850lfu.8;
        Tue, 21 Jun 2022 02:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KVxqgQkmpuz9sfivRrmvLlkvyXCsZ/UVRlJX8Kn06s0=;
        b=baOjPn3HMnQGhZj1nBS+hjUUnJUJ+Qaef24QVnmcEHRl7vEXdUjo5QRsBfEgNpCnf1
         Jm2mGhGNtiWo638Mh2HKumHhvcYmxsqdqaKFiIY93JNSLRKOtYQlJpKBnZGURLayjob+
         /MB/FkKHC8pVilIrHz6/2s03W4EKJQLZphbVT9pgnKGGgCYWlbAKxlSPmKCXeDMSOGEz
         k4bqKGBybgmOLqK4EsPHVpmL5fxyLVBFK/CNU2l5aGa83kOmEMKiC50ivmJ883ZTIT77
         lTZMo0A50VvPHdVjC+D1Xe9WkvlxRXsvrK+2mvS5A9BpF2X8NlUaokkHL1Dw0Q1ZNI3b
         GQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KVxqgQkmpuz9sfivRrmvLlkvyXCsZ/UVRlJX8Kn06s0=;
        b=iyH0w6OPzvVBnyZnQGbpZ7Tuh8DECJdVFN7Es7YD91Z9oTupcexeDf37P4iKjBr9Sg
         8nS173bCxi6myK1+Ko9x/9BGXqWneRiSXakLy8lhqfBIg/sGXSmuysyJC1r+Y4kkxcSg
         Gftks8jiKT4/ehe9ZEUzUuhCJibe8dI7FbRGVFcvExrZEMOy/m+hHodNk3JTcAfA7uME
         KqHRWbr7H0VFh3lsHkuxT+xaLXLs7Nb9nebSGC9b8aQTN8LZ6C7kv2Mrmpi4uF+FfOGu
         1RkSXYsney1rqt2VROu8PiVAib2O1iCPXq0ZzdbjvL7m6HwjjtLy3TaXfohqEdQTBHkk
         4KwA==
X-Gm-Message-State: AJIora8gm6cmnZu59UMvnJflMydpWp0HrcBPIDwt8bKO0Cezklq4PH8p
        x1bAWD5llBKaTL+wnC9oJGA=
X-Google-Smtp-Source: AGRyM1tUHbN/43UfLBdEExbn+1p4lZ6hBmumkDYlyBIRa9Zw3iDqI9SetAAfAkHiF5XrbJVvOtVraA==
X-Received: by 2002:a05:6512:2808:b0:47f:51c4:1dea with SMTP id cf8-20020a056512280800b0047f51c41deamr12102421lfb.390.1655803954972;
        Tue, 21 Jun 2022 02:32:34 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id h21-20020a19ca55000000b00477a287438csm916926lfj.2.2022.06.21.02.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 02:32:34 -0700 (PDT)
Date:   Tue, 21 Jun 2022 12:32:31 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Conor Dooley <mail@conchuod.ie>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Dillon Min <dillon.minfei@gmail.com>,
        Heng Sia <jee.heng.sia@intel.com>,
        Jose Abreu <joabreu@synopsys.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 06/14] spi: dt-bindings: dw-apb-ssi: update
 spi-{r,t}x-bus-width for dwc-ssi
Message-ID: <20220621093231.tytrh6fimzfxgzm2@mobilestation>
References: <20220618123035.563070-1-mail@conchuod.ie>
 <20220618123035.563070-7-mail@conchuod.ie>
 <20220620205654.g7fyipwytbww5757@mobilestation>
 <CAMuHMdWDcnAxjxdwpnbfUiDUoo=RGvQm537-EboAmaQTmxpY-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWDcnAxjxdwpnbfUiDUoo=RGvQm537-EboAmaQTmxpY-g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Geert

On Tue, Jun 21, 2022 at 09:03:25AM +0200, Geert Uytterhoeven wrote:
> Hi Serge,
> 
> On Mon, Jun 20, 2022 at 10:56 PM Serge Semin <fancer.lancer@gmail.com> wrote:
> > On Sat, Jun 18, 2022 at 01:30:28PM +0100, Conor Dooley wrote:
> > > From: Conor Dooley <conor.dooley@microchip.com>
> > >

[...]

> > > +
> > > +        spi-rx-bus-width:
> > > +          const: 1
> > > +
> > > +        spi-tx-bus-width:
> > > +          const: 1
> >
> > You can just use a more relaxed constraint "enum: [1 2 4 8]" here
> > irrespective from the compatible string. The modern DW APB SSI
> > controllers of v.4.* and newer also support the enhanced SPI Modes too
> > (Dual, Quad and Octal). Since the IP-core version is auto-detected at
> > run-time there is no way to create a DT-schema correctly constraining
> > the Rx/Tx SPI bus widths. So let's keep the
> > compatible-string-independent "patternProperties" here but just extend
> > the set of acceptable "spi-rx-bus-width" and "spi-tx-bus-width"
> > properties values.
> >

> > Note the DW APB SSI/AHB SSI driver currently doesn't support the
> > enhanced SPI modes. So I am not sure whether the multi-lines Rx/Tx SPI
> > bus indeed works for Canaan K210 AHB SSI controller. AFAICS from the
> > DW APB SSI v4.01a manual the Enhanced SPI mode needs to be properly
> > activated by means of the corresponding CSR. So most likely the DW AHB
> > SSI controllers need some specific setups too.
> 
> That doesn't matter here, as DT describes hardware, not software
> limitations.

Can't argue with that.) My note regarding the current DW APB SSI
driver was mainly addressed for the Canaan K210 users, since
should the SoC-based board really have the Quad Tx/Rx SPI bus
most likely the interface won't work with the full bandwidth.
So it is a good reason to perform the platform research and if
possible alter the driver accordingly.

-Sergey

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
