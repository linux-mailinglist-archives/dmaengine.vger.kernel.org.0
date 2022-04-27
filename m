Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B47511B7F
	for <lists+dmaengine@lfdr.de>; Wed, 27 Apr 2022 16:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbiD0MvC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 Apr 2022 08:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234905AbiD0Mu7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 Apr 2022 08:50:59 -0400
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E409726C846;
        Wed, 27 Apr 2022 05:47:47 -0700 (PDT)
Received: by mail-qk1-f174.google.com with SMTP id z126so1171854qkb.2;
        Wed, 27 Apr 2022 05:47:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TMmGS6c32HL6vZEYBwhI0fq95j7k7//2c1xWGzdtpbM=;
        b=H7q7vn3dsjrd57W/MJdUWX5gCFUekcXixX7qSzdILsAyraHNoeR4TJsKdvF5ScLqOk
         3Hknm3FZpIrwpnSGnyEniQqhwef/UYgvSVDfPD8IiRGxge3sDxAQM+sLvlDu9KM9bCbW
         gonPdRYn+1t29TJDGWb9tjmRWiUZeJbe4OlOX8d61WpqlEcXsdkmZgYGn7RkiWo17NNg
         E2NSkp8aK8cN8/gWJD0Oj++HImEVoCsJALwZYLCXWAu8fVREMfO3vn0yOPcRC8QseCnB
         +yrRaOVdZp7HQG6QSrptY1SsXW2E2YeH3a9jsh3YzUsHidsaNQGiBowVr23eZNNvwGbt
         plhA==
X-Gm-Message-State: AOAM532BK1ulZZfTfJ0Bh4j7ZWDf9sYfXKAcmieMUoyaMoNw4+C3B23t
        nuaIaec4OD/QNtYWtfBD1SJ9DxaUEtv/XA==
X-Google-Smtp-Source: ABdhPJzLwqZ0sa7Lrg2FzGercxa52XKA2EsYGkiDjWVk3jDd8LQvJeBkSqYe2ybgvOMwmL7sjocQAQ==
X-Received: by 2002:a05:620a:d87:b0:67b:311c:ecbd with SMTP id q7-20020a05620a0d8700b0067b311cecbdmr16158763qkl.146.1651063666816;
        Wed, 27 Apr 2022 05:47:46 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id 2-20020ac84e82000000b002f1f95ce5fbsm9968117qtp.3.2022.04.27.05.47.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 05:47:46 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-2ef5380669cso17045617b3.9;
        Wed, 27 Apr 2022 05:47:46 -0700 (PDT)
X-Received: by 2002:a81:618b:0:b0:2db:d952:8a39 with SMTP id
 v133-20020a81618b000000b002dbd9528a39mr26953403ywb.132.1651063666063; Wed, 27
 Apr 2022 05:47:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220427095653.91804-1-miquel.raynal@bootlin.com> <20220427095653.91804-7-miquel.raynal@bootlin.com>
In-Reply-To: <20220427095653.91804-7-miquel.raynal@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 27 Apr 2022 14:47:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXTHxrFHXbFRKQx-dX4z+0OLSZkV+BFGTBVPB_yCTVm-Q@mail.gmail.com>
Message-ID: <CAMuHMdXTHxrFHXbFRKQx-dX4z+0OLSZkV+BFGTBVPB_yCTVm-Q@mail.gmail.com>
Subject: Re: [PATCH v12 6/9] clk: renesas: r9a06g032: Probe possible children
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

On Wed, Apr 27, 2022 at 11:57 AM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
> The clock controller device on r9a06g032 takes all the memory range that
> is described as being a system controller. This range contains many
> different (unrelated?) registers besides the ones belonging to the clock
> controller, that can necessitate to be accessed from other peripherals.
>
> For instance, the dmamux registers are there. The dmamux "device" will
> be described as a child node of the clock/system controller node, which
> means we need the top device driver (the clock controller driver in this
> case) to populate its children manually. In case of error when
> populating the children, we do not fail the probe on purpose to keep the
> clk driver up and running.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Acked-by: Stephen Boyd <sboyd@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
