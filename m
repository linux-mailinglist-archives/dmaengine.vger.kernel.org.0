Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315A4517FD6
	for <lists+dmaengine@lfdr.de>; Tue,  3 May 2022 10:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbiECIkF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 May 2022 04:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiECIkE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 May 2022 04:40:04 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A47326E9;
        Tue,  3 May 2022 01:36:32 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id t11so12829273qto.11;
        Tue, 03 May 2022 01:36:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v6J1Z4u+meRqTje/A0YLpsvHhdUJQ7OAkYJCO4xjV5I=;
        b=S5N8cgfqj8Keda4sUNr0l3qEWqkd9mR6m0Hc7TkrG11aYXNNiMRFZffKpp8FDqXQ1x
         VKlvSJq+ayJA4A14aNOP1yJnQYluDHXZHbAcnBrU4/UiE7w14noO5Jbw7WYuGBQQ80e0
         N1KW3h1HxIeISanpbuISfNK+1Pw8d7DlG6yH4OAv4ASAr2vw24NEgB8eR7zldSkCbsFG
         LJu6A1pxuWgjr3uOI5X2USAkVy/dUIxnc8uBKxqz7MLi9J9OGejbgP3FKRYPAd9cRNF0
         XBxDdB7YWHT1PvukmPZd5YHXTcqAAT6rX45+fGy2qz0QAXzPTYGiVGLfwi6bLMyPHW2r
         5iLg==
X-Gm-Message-State: AOAM533X+ee2ZwOMGgCOcgHOnPZBvbGPTfTJtC17GCe/+YaCNh+Bs4Ol
        8POyp1pioQiHKtDPPaexRuGm360iGuwugQ==
X-Google-Smtp-Source: ABdhPJy78MKxXHCKx4Ql5Fts89KdUUQ56J75DqBguLX1RoR0uWmgE6FwZaCGgLO8jDtzGthPQVXZbA==
X-Received: by 2002:a05:622a:110f:b0:2f3:3f89:d38 with SMTP id e15-20020a05622a110f00b002f33f890d38mr13465640qty.346.1651566991538;
        Tue, 03 May 2022 01:36:31 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id m133-20020a37a38b000000b0069fc13ce251sm5375222qke.130.2022.05.03.01.36.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 01:36:30 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id f38so29988404ybi.3;
        Tue, 03 May 2022 01:36:30 -0700 (PDT)
X-Received: by 2002:a05:6902:389:b0:633:31c1:d0f7 with SMTP id
 f9-20020a056902038900b0063331c1d0f7mr12712609ybs.543.1651566990120; Tue, 03
 May 2022 01:36:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220427095653.91804-1-miquel.raynal@bootlin.com> <20220427095653.91804-10-miquel.raynal@bootlin.com>
In-Reply-To: <20220427095653.91804-10-miquel.raynal@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 3 May 2022 10:36:19 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXXCTWuYytGPd2=vqWvZK=RmXCT2EGff6BRutcKQgOu6Q@mail.gmail.com>
Message-ID: <CAMuHMdXXCTWuYytGPd2=vqWvZK=RmXCT2EGff6BRutcKQgOu6Q@mail.gmail.com>
Subject: Re: [PATCH v12 9/9] ARM: dts: r9a06g032: Describe the DMA router
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
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Apr 27, 2022 at 11:57 AM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
> There is a dmamux on this SoC which allows picking two different sources
> for a single DMA request.
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
