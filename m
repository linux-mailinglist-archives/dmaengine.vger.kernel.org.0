Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D8855DB64
	for <lists+dmaengine@lfdr.de>; Tue, 28 Jun 2022 15:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344424AbiF1LEJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Jun 2022 07:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242226AbiF1LEH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Jun 2022 07:04:07 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC04C30F6D;
        Tue, 28 Jun 2022 04:04:06 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id by38so14416495ljb.10;
        Tue, 28 Jun 2022 04:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/8pU2gScmMW6polZpgp4B71BlGG/FUv4k+/v6LUH1/0=;
        b=bky/Bhn0cY13mgxukdilwlhr5+lAOlxcGYy6kAvfvTBelfCzahaGV8UvN9cqUEeN7Y
         XBLEJ3ZadScFZdMmRpm1ZR48lKzjqev39XsszP0QgThb2ib6BaEpm938emdir4nAIO8M
         7e/C+4pzw+unC5Ef+0smMPs7B6VNirDrMrOPMkntO3q97JOfHS+4nMNL35iL59PNhd6W
         t5UNdmfEPbNUQ/65Gv5Ne4wDCdyMZcnYVCZt17l/Psc2SCLhuxq1e+bx8DPIEjqXVh3E
         W71ONBZQdfp1LTwv+ScSaXWD4uv2xYmxDSAuHT4wnNZgMCT2EpraMyrwHS5pwLahAZ0I
         AEQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/8pU2gScmMW6polZpgp4B71BlGG/FUv4k+/v6LUH1/0=;
        b=5yrOBFZ6zt4sWYfAPT/fNotg2Z9Xng7y/n2ouHjTp12BekH6lfD/iL70ou+xC6hjKf
         SI6xX4KBbbM6UZR9jKSzWrkryh+NzGCmQXDOpeaiQtIArZciHSzCqTnivsAvZj5wXFMp
         wdozapdkPUvem5ICdQCw13NBnC8CK6jgRgZaPV9HrAjqJ9Jxpk7wb6J9+sUqFXRlOS5u
         ltGIX0Odhn/reYrDLlnuPpBMDZjJqUBSvFI032nHFU4RAnLySQ7PXq/1FOoCAcU+ckG6
         iySPciWuVZMuZqeCwktfjFovtTtfFwr+mo17Vw9LVLDY5asS3fcgNZK7t41xs5W+GiUZ
         Op3w==
X-Gm-Message-State: AJIora8zVe2UgRPXQCbqXLBZGXdyTxG5g/dqY7HhQNnwWUj9UFM3U7MN
        UUAy8f3z8IYh0nUzy4bvkbg=
X-Google-Smtp-Source: AGRyM1t9+uICFWO0tG/T7UXS6lTPnI1Wc64vAYk9Ch5AqWX88peQMeamaNU0eBwE3tD3fcJyxIVoJw==
X-Received: by 2002:a2e:b891:0:b0:25a:9175:3282 with SMTP id r17-20020a2eb891000000b0025a91753282mr9640485ljp.78.1656414245063;
        Tue, 28 Jun 2022 04:04:05 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id e13-20020a05651c038d00b00258f1e0fb32sm1752156ljp.23.2022.06.28.04.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 04:04:04 -0700 (PDT)
Date:   Tue, 28 Jun 2022 14:04:01 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh@kernel.org>
Cc:     Conor Dooley <Conor.Dooley@microchip.com>,
        Conor Dooley <mail@conchuod.ie>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod <vkoul@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
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
Subject: Re: [PATCH 04/14] dt-bindings: dma: add Canaan k210 to Synopsys
 DesignWare DMA
Message-ID: <20220628110401.o6jy2kuyw3hhk3yy@mobilestation>
References: <20220618123035.563070-1-mail@conchuod.ie>
 <20220618123035.563070-5-mail@conchuod.ie>
 <20220627232919.GA3158390-robh@kernel.org>
 <40d76866-34e3-baef-c3fe-8836cd2430f6@microchip.com>
 <CAMuHMdXjXGBi8S+bTG105q63zZw2ScQb9nXBSp2baiLNWKQAkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXjXGBi8S+bTG105q63zZw2ScQb9nXBSp2baiLNWKQAkg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Jun 28, 2022 at 09:08:32AM +0200, Geert Uytterhoeven wrote:
> Hi Conor,
> 
> On Tue, Jun 28, 2022 at 8:30 AM <Conor.Dooley@microchip.com> wrote:
> > On 28/06/2022 00:29, Rob Herring wrote:
> > > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > >
> > > On Sat, Jun 18, 2022 at 01:30:26PM +0100, Conor Dooley wrote:
> > >> From: Conor Dooley <conor.dooley@microchip.com>
> > >>
> > >> The Canaan k210 apparently has a Sysnopsys Designware AXI DMA
> > >> controller, but according to the documentation & devicetree it has 6
> > >> interrupts rather than the standard one. Add a custom compatible that
> > >> supports the 6 interrupt configuration which falls back to the standard
> > >> binding which is currently the one in use in the devicetree entry.
> > >

> > > But it works with only 1 interrupt?
> >
> > Seemingly...
> 
> The Linux driver uses the only first interrupt.

Folks, there v2 of this series. A more suitable and justified solution has
been given there:
Link: https://lore.kernel.org/lkml/20220627213450.ukqai4bsjzcwhnlp@mobilestation/

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
