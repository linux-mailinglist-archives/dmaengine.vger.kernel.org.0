Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042C250E521
	for <lists+dmaengine@lfdr.de>; Mon, 25 Apr 2022 18:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235796AbiDYQIw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Apr 2022 12:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235505AbiDYQIv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 25 Apr 2022 12:08:51 -0400
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0E93D490;
        Mon, 25 Apr 2022 09:05:47 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id e17so12096911qvj.11;
        Mon, 25 Apr 2022 09:05:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WBB3hJAHggg/Ymff4O89TctaqpmLz5c/VRSvQSPD6EU=;
        b=Parj+JdMS+7P/atDGKVlzVylPEIdEQeItI0RPe4FKg/lcrpLysFz7UIoFTp9vCdMHu
         pqQBb/XjKSK5qctQxA6Bo4o2LskF55SYQn5YBkySGAq2NAAUZLZanRe3xWib6oCBG4IS
         ijMMG9jQWUx9+kbQC4LdUq9jEGt1VS+pD+V6Nh7l+Pa6JqI2v2VuXmst5yfSQAI4hIUx
         U/lfUSOf6p7Tjso4Jm0rS2RKrvXvM6L76bROgYOZJ/PU3YMAxVOoRvO6XVy8LXqcOZQy
         97fIRxJDW5Kf/dBAzDJF9ootnOYCECjIRLmNgI9W8Eei6HyK4CAwcCwtCPEhNuM3CG4P
         HC/g==
X-Gm-Message-State: AOAM531qm6Z6ixXBfCin138O/dUPvOSdO/3sGsN8UQrwXPXWzsHlGyp/
        xwCkP2h/td/ql5Kr1ZX644K2abfdjGaaQQ==
X-Google-Smtp-Source: ABdhPJzgvTjHlgO41b046TZZXPUlZ1cbIJMoPrw3ADSVutUEaYSOUrknjJdHiD6A2ezNJuVoAGuPqg==
X-Received: by 2002:a05:6214:e64:b0:446:3d57:d320 with SMTP id jz4-20020a0562140e6400b004463d57d320mr13034649qvb.87.1650902745825;
        Mon, 25 Apr 2022 09:05:45 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id 2-20020a05620a06c200b0069ea498aec7sm5176862qky.16.2022.04.25.09.05.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 09:05:45 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id r189so27907232ybr.6;
        Mon, 25 Apr 2022 09:05:45 -0700 (PDT)
X-Received: by 2002:a5b:24e:0:b0:63d:cba0:3d55 with SMTP id
 g14-20020a5b024e000000b0063dcba03d55mr16307751ybp.613.1650902745080; Mon, 25
 Apr 2022 09:05:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220421085112.78858-1-miquel.raynal@bootlin.com>
In-Reply-To: <20220421085112.78858-1-miquel.raynal@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 25 Apr 2022 18:05:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU6Mb9k_g7yBCknmL9DMjUSzk=W_5wiMNDMsTN6RpkcLg@mail.gmail.com>
Message-ID: <CAMuHMdU6Mb9k_g7yBCknmL9DMjUSzk=W_5wiMNDMsTN6RpkcLg@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Miquel,

On Thu, Apr 21, 2022 at 10:51 AM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
> This is the series bringing DMA support to RZN1 platforms.
> Other series follow with eg. UART and RTC support as well.

Thanks for your series!

> There is no other conflicting dependency with the other series, so this
> series can now entirely be merged in the dmaengine tree I believe.
>
> Changes in v11:
> * Renamed two defines.
> * Changed the way the bitmap is declared.
> * Updated the cover letter: this series can now go in through the
>   dmaengine tree.

/me confused

> Miquel Raynal (9):
>   dt-bindings: dmaengine: Introduce RZN1 dmamux bindings
>   dt-bindings: clock: r9a06g032-sysctrl: Reference the DMAMUX subnode
>   dt-bindings: dmaengine: Introduce RZN1 DMA compatible
>   soc: renesas: rzn1-sysc: Export function to set dmamux
>   dmaengine: dw: dmamux: Introduce RZN1 DMA router support
>   clk: renesas: r9a06g032: Probe possible children
>   dmaengine: dw: Add RZN1 compatible
>   ARM: dts: r9a06g032: Add the two DMA nodes
>   ARM: dts: r9a06g032: Describe the DMA router

The last two DTS parts have to go in through the renesas-arm-dt and
soc trees.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
