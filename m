Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D72517FD0
	for <lists+dmaengine@lfdr.de>; Tue,  3 May 2022 10:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbiECIjo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 May 2022 04:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiECIjm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 May 2022 04:39:42 -0400
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4EB326E9;
        Tue,  3 May 2022 01:36:11 -0700 (PDT)
Received: by mail-qk1-f182.google.com with SMTP id a22so10016731qkl.5;
        Tue, 03 May 2022 01:36:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZaxxGPUIoPfhOui+EnU4QI4ko0DjdQJEmL5+IwqH6p4=;
        b=f+6pMESd4yc6xSJEM9DoaCFjC2DSMM8YN6bon1m/trnl0ZIwO7E2YJSAew73S78rSF
         KvrLv+y6iq12+paglnciiv6RkdZmCGkOXuzXmeF6GLni3L+wveg32HuNif+fZr5czcy5
         +0cVaI0OAjNxD4MH+kaTQfmszV2RcChwDoQysaGtCySXCxvskezMro6Yaq1mRWVUBlC+
         +6jAKzk1UsZAEb3y4yrYrvGYJmWkIpgIHdeeqrbWtlFZ5LxGnkLgbrr2osPOF8X0kSNU
         MiZMU3sT8pkMHKWu0voT9ptxI4REeBOcQFc0uunPtpP5N7Vcg9WYR+g29oCHYIqeg1/4
         wBww==
X-Gm-Message-State: AOAM5332vZIXWNM2AR/qUvSQTqdpoyTmUYIcatvskt+gv/iO9Xqf96i6
        K7ye+DnWSL5zHsqzew11h7Ah6YH6SHvTlw==
X-Google-Smtp-Source: ABdhPJxAi5iFL2jP2VxeIg+rIfbZtXJHIFUFRwZgG2KZX/6xo9KWsHcKW4oboHnZ4gU03X6/8szROQ==
X-Received: by 2002:a37:5d2:0:b0:69f:a41b:9bda with SMTP id 201-20020a3705d2000000b0069fa41b9bdamr10716643qkf.761.1651566970450;
        Tue, 03 May 2022 01:36:10 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id l63-20020a37bb42000000b0069fc13ce1fdsm5587627qkf.46.2022.05.03.01.36.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 01:36:09 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id y2so29914996ybi.7;
        Tue, 03 May 2022 01:36:09 -0700 (PDT)
X-Received: by 2002:a05:6902:120e:b0:634:6f29:6b84 with SMTP id
 s14-20020a056902120e00b006346f296b84mr13444438ybu.604.1651566969228; Tue, 03
 May 2022 01:36:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220427095653.91804-1-miquel.raynal@bootlin.com> <20220427095653.91804-9-miquel.raynal@bootlin.com>
In-Reply-To: <20220427095653.91804-9-miquel.raynal@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 3 May 2022 10:35:58 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXVb+hz9p1QUfHqMw787hrS90QR4_Uf0SLwxcsB4NGsZg@mail.gmail.com>
Message-ID: <CAMuHMdXVb+hz9p1QUfHqMw787hrS90QR4_Uf0SLwxcsB4NGsZg@mail.gmail.com>
Subject: Re: [PATCH v12 8/9] ARM: dts: r9a06g032: Add the two DMA nodes
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

On Wed, Apr 27, 2022 at 11:57 AM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
> Describe the two DMA controllers available on this SoC.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Queuing in renesas-devel for v5.19.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
