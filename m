Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B9E50E53B
	for <lists+dmaengine@lfdr.de>; Mon, 25 Apr 2022 18:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239905AbiDYQNf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Apr 2022 12:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240524AbiDYQNd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 25 Apr 2022 12:13:33 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E14941F8F;
        Mon, 25 Apr 2022 09:10:28 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id t186so115460qke.10;
        Mon, 25 Apr 2022 09:10:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y7QIeyoBv/NN5w3ex6p2Av6+P6QG1isXV6ZS4mt/fi8=;
        b=8CXUlIg2bnfmZM8kh3f4fkokKuG2Ysm8VPtProTR18du9L6aoKabDhHLJtRPoeAQGe
         PQROx2wDE9dwvzovRGFVtvYW1fJPzlTC2lh0GTYzOAbg3jF2vCoEgfl2GKhT+ITub2e+
         CbLl0iaY/vtwJQ1n9PrRHxcEvvhQheDXuqfue/Auvx6PrSLSO/e2Evhwd8v3X51dAVT6
         6NeV5TgWYBcZjET7j0x5qx5IdgR3ZU7cdLMTRTwrFExOCGQ+d5qq7c2e19AwYY9yS99l
         CvATPg5z3vdSLrb4dTT+qo2p0sxen5a717inxjQe23LzpreBvbsaeZiSIY/8nzJky9uT
         ksLw==
X-Gm-Message-State: AOAM533/Akus5a7rLxcetV8E5azhJhvIw+hYVLkkVqLBYGz2+IvR22e1
        nEucK3ba4/w/LA7ubAyo4vohqJuj9FSYoA==
X-Google-Smtp-Source: ABdhPJzQXKoj5b73K6xL/vB3tk6/AIypnw6rV4nLQd10yvYVXQhIUHgMTxJQA3Xpexh54Rgzt7oXQA==
X-Received: by 2002:a37:55c2:0:b0:479:8293:d7d0 with SMTP id j185-20020a3755c2000000b004798293d7d0mr10651271qkb.182.1650903026746;
        Mon, 25 Apr 2022 09:10:26 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id d13-20020a37c40d000000b0069ebc29ddc1sm5032374qki.136.2022.04.25.09.10.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 09:10:26 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id w187so18527915ybe.2;
        Mon, 25 Apr 2022 09:10:26 -0700 (PDT)
X-Received: by 2002:a25:d84c:0:b0:648:7d5e:e2d4 with SMTP id
 p73-20020a25d84c000000b006487d5ee2d4mr3001137ybg.6.1650903025972; Mon, 25 Apr
 2022 09:10:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220421085112.78858-1-miquel.raynal@bootlin.com> <20220421085112.78858-5-miquel.raynal@bootlin.com>
In-Reply-To: <20220421085112.78858-5-miquel.raynal@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 25 Apr 2022 18:10:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVVP6_8ejyJ8v0-L2cG=vhncw9EZGgAfzemAp4BO-FF3Q@mail.gmail.com>
Message-ID: <CAMuHMdVVP6_8ejyJ8v0-L2cG=vhncw9EZGgAfzemAp4BO-FF3Q@mail.gmail.com>
Subject: Re: [PATCH v11 4/9] soc: renesas: rzn1-sysc: Export function to set dmamux
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
> The dmamux register is located within the system controller.
>
> Without syscon, we need an extra helper in order to give write access to
> this register to a dmamux driver.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Acked-by: Stephen Boyd <sboyd@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
