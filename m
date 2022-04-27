Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C42511B6E
	for <lists+dmaengine@lfdr.de>; Wed, 27 Apr 2022 16:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbiD0Mwu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 Apr 2022 08:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234796AbiD0Mwt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 Apr 2022 08:52:49 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE162BFC3A;
        Wed, 27 Apr 2022 05:49:38 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id c1so1136584qkf.13;
        Wed, 27 Apr 2022 05:49:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Jp0v9pbUM9yFGwsPlv8tqGi+Rr3prTWvALgldiDZ9E=;
        b=ImDGihnXJzBoGI8pOtwMosYFg9+Y/WMo86CYRIRgueq+7Ndn+AJvC6MgqG0+s2ngus
         CblUiZsWN7JJB0OEmmRS5iR4juD/mtU2ZQpjGb7uxSlL1wIDC+Cp8QqIfZBFiqDUjjws
         VVZ4KJFel9xVvBChyZRD9pwnFBfKepsAQzUfUFJJW2n/dCw8QsmuSymjvwep96qdPAyO
         8aMpa8cgwKuQDBU4H6TKJt5/CTVxeQ5fIWFaNYV9CVWJH3lPBRCFoJWRREhG2lZ+BMmU
         apynLPHuON569efhIwv3Jjr00RHXy5FNPYyWutLcrB5K86EEcHVNbDMZlxOfMj1E87gT
         dgKg==
X-Gm-Message-State: AOAM530ZeKDvEiREn9zEi6kbYIDx/Qavv19mgs5TYEKwg6ikANsMC4MW
        b7C5sI8pxt26iWrZn7bT7GOLGcjjWrWS0g==
X-Google-Smtp-Source: ABdhPJy3njATvfBvr7/xBSa61sriY5+cQjdtujuypVrImMthLXmn/CHiBPdjXkzE9YNdB3J05eDyew==
X-Received: by 2002:a37:ad0e:0:b0:69e:d516:21 with SMTP id f14-20020a37ad0e000000b0069ed5160021mr16145839qkm.474.1651063777429;
        Wed, 27 Apr 2022 05:49:37 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id d71-20020a37684a000000b0069f9b166a09sm99522qkc.90.2022.04.27.05.49.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 05:49:36 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-2f7d7e3b5bfso17239957b3.5;
        Wed, 27 Apr 2022 05:49:36 -0700 (PDT)
X-Received: by 2002:a81:1cd5:0:b0:2f4:c3fc:2174 with SMTP id
 c204-20020a811cd5000000b002f4c3fc2174mr27573015ywc.512.1651063776385; Wed, 27
 Apr 2022 05:49:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220427095653.91804-1-miquel.raynal@bootlin.com> <20220427095653.91804-5-miquel.raynal@bootlin.com>
In-Reply-To: <20220427095653.91804-5-miquel.raynal@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 27 Apr 2022 14:49:25 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV+JfPu_w=0YAGGAhpDHh=8e6hO2hcDVMfo9BHgJqgRzA@mail.gmail.com>
Message-ID: <CAMuHMdV+JfPu_w=0YAGGAhpDHh=8e6hO2hcDVMfo9BHgJqgRzA@mail.gmail.com>
Subject: Re: [PATCH v12 4/9] clk: renesas: r9a06g032: Export function to set dmamux
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
        <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
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

On Wed, Apr 27, 2022 at 11:57 AM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
> The dmamux register is located within the system controller.
>
> Without syscon, we need an extra helper in order to give write access to
> this register to a dmamux driver.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
