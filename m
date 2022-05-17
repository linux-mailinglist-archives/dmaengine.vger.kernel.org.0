Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8299529CA4
	for <lists+dmaengine@lfdr.de>; Tue, 17 May 2022 10:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243430AbiEQIhO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 17 May 2022 04:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243431AbiEQIhK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 17 May 2022 04:37:10 -0400
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E143D1C0;
        Tue, 17 May 2022 01:37:09 -0700 (PDT)
Received: by mail-qv1-f43.google.com with SMTP id k8so360839qvm.9;
        Tue, 17 May 2022 01:37:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=diTzJoBHU8EeLBqHq5Me1Ruh4X/r4hmR4tb/bosfltw=;
        b=TGHLk+GfdqVDqmFqYbFcH/AkJXcHXTA1xCnr4TGBK2OLtMMFvQ57vHzNLL52/wXdN+
         6TJ8thNtdeSvBV6gmVkKuxOtLkr5VZlZI8U2FnBJl2dB38cA5fic6Ntu/G6RtIkPyLov
         6abQrdyttbx4J2feFHtl3hl+YShFIewCrIp7iCQb3RdxdpgBFqR9xc+DBHwPimDpwedY
         KuA4WC1Tut3pXe5/ULKVLgYIOMwlbo64FVVI2dKSr7rkYAHwMNISloJtcHmqSPTVisG/
         ZwRex7vL4GfEbMQ8L+Gj/mBWNFck8q/NcSvFBCXBqf9383GrhRN67iyM7MKHcq1EY1C0
         GmVA==
X-Gm-Message-State: AOAM5310EU90gVUiLko3SKyc2EzAZ7Jz3IE3dsD7VTabh3c82GqWPE88
        wUynEnveyTjd6aYVcyR/L/hhICoil3HWrA==
X-Google-Smtp-Source: ABdhPJxZ+2fjjI0hRydOPArGUCzxfW5JgkNPOtL8el9fcvWnxhjQ86EPaeczsqLKTZcKazkgmVpdDQ==
X-Received: by 2002:a05:6214:2523:b0:460:2238:59a0 with SMTP id gg3-20020a056214252300b00460223859a0mr19313180qvb.20.1652776628027;
        Tue, 17 May 2022 01:37:08 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id o7-20020a37be07000000b0069fc13ce203sm7761857qkf.52.2022.05.17.01.37.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 01:37:07 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-2ff155c239bso34448687b3.2;
        Tue, 17 May 2022 01:37:07 -0700 (PDT)
X-Received: by 2002:a81:ad11:0:b0:2fe:fb00:a759 with SMTP id
 l17-20020a81ad11000000b002fefb00a759mr9791139ywh.283.1652776627031; Tue, 17
 May 2022 01:37:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220427095653.91804-1-miquel.raynal@bootlin.com> <20220517103100.4da9ebe5@xps-13>
In-Reply-To: <20220517103100.4da9ebe5@xps-13>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 17 May 2022 10:36:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWF7W=cov89AAkscYAaK0nmshNPuzYLtQbEtRiOQTquYg@mail.gmail.com>
Message-ID: <CAMuHMdWF7W=cov89AAkscYAaK0nmshNPuzYLtQbEtRiOQTquYg@mail.gmail.com>
Subject: Re: [PATCH v12 0/9] RZN1 DMA support
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Miquel,

On Tue, May 17, 2022 at 10:31 AM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
> miquel.raynal@bootlin.com wrote on Wed, 27 Apr 2022 11:56:44 +0200:
> > This is the series bringing DMA support to RZN1 platforms.
> > The UART changes regarding DMA support has been merged into tty-next
> > already.
> >
> > There is no other conflicting dependency with the other series, so these
> > patches (all but DTS) can go though the dmaengine tree I believe.
>
> As all patches the patches in this series have received a fairly good
> amount of reviews, as well as all the necessary tags since a few weeks
> already, I was hoping to see it applied for the next merge window. Is
> there something still blocking its acceptance? Let me know if it is
> the case and I will do the necessary to make them fit.

> > Miquel Raynal (9):
> >   dt-bindings: dmaengine: Introduce RZN1 dmamux bindings
> >   dt-bindings: clock: r9a06g032-sysctrl: Reference the DMAMUX subnode
> >   dt-bindings: dmaengine: Introduce RZN1 DMA compatible
> >   clk: renesas: r9a06g032: Export function to set dmamux
> >   dmaengine: dw: dmamux: Introduce RZN1 DMA router support
> >   clk: renesas: r9a06g032: Probe possible children
> >   dmaengine: dw: Add RZN1 compatible
> >   ARM: dts: r9a06g032: Add the two DMA nodes
> >   ARM: dts: r9a06g032: Describe the DMA router

The DTS patches have been applied to renesas-devel, and have
already made their way to soc/for-next.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
