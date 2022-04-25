Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668FF50E5E7
	for <lists+dmaengine@lfdr.de>; Mon, 25 Apr 2022 18:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243441AbiDYQgE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Apr 2022 12:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243429AbiDYQgD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 25 Apr 2022 12:36:03 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D539E07E8;
        Mon, 25 Apr 2022 09:32:57 -0700 (PDT)
Received: by mail-qk1-f170.google.com with SMTP id d198so11153972qkc.12;
        Mon, 25 Apr 2022 09:32:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gcw7C/y6qdW4TOp1I/CKA/m+Hg6rCjEHjP9qg6Euwb0=;
        b=qOP5kaOnl80fZNQ46p7rlMgRTF4Pt+B+jamkbHFGiKFKKz4FNVUk2+0Q8XB4VB5hDJ
         0XaJMZAHtlBumEwkUev2syleyhvMhA/7fexMJhyOlqfk6b1lrjk1zd7zs5G8uBsCXTh0
         Ja4FomrwyAZAVnFOFQjZXYHSjuMfZd2Ew7NhGhvAA7PY07p3t09bF/nnz8tG02kF9ky+
         rPKAHQwn0BrQNNIuZMc0LBaSXe+g/tuQJGbv3vH9NbiUQSKQv+M5ojUDJV4TGXFzyBOX
         VtOVUxwg7BvSGDr/6yl9e+U2OvwEEKwqCw6304uSo5/xJHgu04ALC6NbJKV5xsNehGTN
         7P3Q==
X-Gm-Message-State: AOAM531whoFsKoSiFgRd3q8vwXOa5JPK0RkQRyCkmz1kUFz8KZbnt8lR
        rz6GBd/zhEe+O4ACav5vUG4riVFgfOR6SQ==
X-Google-Smtp-Source: ABdhPJx6IeLzsz/j2QrxEpsDkjz2iltztY1aGZBrxpuVkqRRmjibvuuPbJqvwVJGOUE5bvWtj6JMJw==
X-Received: by 2002:a37:65d2:0:b0:69e:951d:7d12 with SMTP id z201-20020a3765d2000000b0069e951d7d12mr10562011qkb.37.1650904376772;
        Mon, 25 Apr 2022 09:32:56 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id d17-20020ac85d91000000b002f365edfd21sm2801655qtx.83.2022.04.25.09.32.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 09:32:56 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-2f16645872fso154343217b3.4;
        Mon, 25 Apr 2022 09:32:56 -0700 (PDT)
X-Received: by 2002:a81:4782:0:b0:2eb:1cb1:5441 with SMTP id
 u124-20020a814782000000b002eb1cb15441mr16508357ywa.479.1650904375899; Mon, 25
 Apr 2022 09:32:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220421085112.78858-1-miquel.raynal@bootlin.com> <20220421085112.78858-10-miquel.raynal@bootlin.com>
In-Reply-To: <20220421085112.78858-10-miquel.raynal@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 25 Apr 2022 18:32:44 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUQt-6fDsNF2Q_tpfbgg=6LmH6R6upLEj6d3p6Rc-SQWA@mail.gmail.com>
Message-ID: <CAMuHMdUQt-6fDsNF2Q_tpfbgg=6LmH6R6upLEj6d3p6Rc-SQWA@mail.gmail.com>
Subject: Re: [PATCH v11 9/9] ARM: dts: r9a06g032: Describe the DMA router
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

On Thu, Apr 21, 2022 at 10:51 AM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
> There is a dmamux on this SoC which allows picking two different sources
> for a single DMA request.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
