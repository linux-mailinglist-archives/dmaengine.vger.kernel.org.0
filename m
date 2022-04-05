Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDFA4F4F88
	for <lists+dmaengine@lfdr.de>; Wed,  6 Apr 2022 04:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242799AbiDFAw0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 5 Apr 2022 20:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573189AbiDESOb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 5 Apr 2022 14:14:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C759386E3A;
        Tue,  5 Apr 2022 11:12:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6208A618D5;
        Tue,  5 Apr 2022 18:12:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4B6C385A8;
        Tue,  5 Apr 2022 18:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649182351;
        bh=RtSQnyTH2bGhJA1/9COYZ3axzbF+DTRbMhYJaQmigK4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bJXWYYG/tvvtzQ7mynkQmNmp4oWLRn5127jXucil0ZLUP2QwdSLkBd5VLlbiifoVL
         MgsLY/BryAsTAHBk3L3Sqwke8Hs7z/Svxr1W1nPprI2+t4529BS7r4CQ986LY8AC/d
         VpHb41kMYECay1Rhodz0/QvluhQC2I2d67+dYNNz5M3Bw5D7vYXNb7J74ah5beA2Qd
         HJxJL8u8zj7a/ifUwE8hM3YLLOZdrQVuBi35vMjU9a+8qFX/bOR5RGWKdXyo0mvx5v
         L9StbjsctvN910jBX2Ls6y7Yk7VsE7ZW9DZcknWApQcyYPsTfQV5pkAHKkvVzTRnc+
         19d6NNVu+8Sjg==
Received: by mail-il1-f180.google.com with SMTP id x9so170651ilc.3;
        Tue, 05 Apr 2022 11:12:31 -0700 (PDT)
X-Gm-Message-State: AOAM531rrObIDBJhGG5oxmBRGK90USUAfsY5v8di4WSmnM0rjVVxPVuG
        GVqLF4VLPTT89asBePniNrzoC9YV6JQ9uCG42w==
X-Google-Smtp-Source: ABdhPJxl778BPyM18iwKU9BBEuG8FWmDp6WxR6Z3mTcc8vTqYUBuaCKKMi20g9YQGtWiXGmB8EkjpVPbfq9ItDZJ7Uc=
X-Received: by 2002:a05:6e02:2183:b0:2c7:fe42:7b07 with SMTP id
 j3-20020a056e02218300b002c7fe427b07mr2249890ila.302.1649182350732; Tue, 05
 Apr 2022 11:12:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220405081911.1349563-1-miquel.raynal@bootlin.com> <20220405081911.1349563-2-miquel.raynal@bootlin.com>
In-Reply-To: <20220405081911.1349563-2-miquel.raynal@bootlin.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 5 Apr 2022 13:12:19 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK3VJ=5VxF5DgZh58zkmWkaAHu9TL9dYOAeTw5nry1Xrg@mail.gmail.com>
Message-ID: <CAL_JsqK3VJ=5VxF5DgZh58zkmWkaAHu9TL9dYOAeTw5nry1Xrg@mail.gmail.com>
Subject: Re: [PATCH v7 1/9] dt-bindings: dmaengine: Introduce RZN1 dmamux bindings
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Vinod Koul <vkoul@kernel.org>,
        "open list:MEDIA DRIVERS FOR RENESAS - FCP" 
        <linux-renesas-soc@vger.kernel.org>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>,
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
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Apr 5, 2022 at 3:19 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> The Renesas RZN1 DMA IP is based on a DW core, with eg. an additional
> dmamux register located in the system control area which can take up to
> 32 requests (16 per DMA controller). Each DMA channel can be wired to
> two different peripherals.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/dma/renesas,rzn1-dmamux.yaml     | 51 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/renesas,rzn1-dmamux.yaml

Please send to the DT list so checks run. I've already reviewed this,
but what passes does change over time. Such as RiscV cpuidle patches
that were picked up after 2 months on Thurs and sent to Linus on
Fri... :(

Rob
