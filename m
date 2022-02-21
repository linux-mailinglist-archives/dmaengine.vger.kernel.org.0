Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF754BD3DF
	for <lists+dmaengine@lfdr.de>; Mon, 21 Feb 2022 03:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343927AbiBUCg6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 20 Feb 2022 21:36:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343938AbiBUCgy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 20 Feb 2022 21:36:54 -0500
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989AF299;
        Sun, 20 Feb 2022 18:36:31 -0800 (PST)
Received: by mail-il1-f177.google.com with SMTP id p11so8992040ils.1;
        Sun, 20 Feb 2022 18:36:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=QyX/i2/YrR/rW3J3vcQL5VJG0A8Hvyop2ZIeubiA5uY=;
        b=31BVrDMMHkfUoZhz/E4uchbtevPAmv2DARIy4BG6ZnmCbgdiANjL8c40C2i/jz5HDM
         4YVT6C6Nqi5eJoPVuBGppH4+QS1PU70XVltW0QNXIigSr6ah8T/qw7gXhAACwmPa86FQ
         hKFyNYWZ0qNy0IzP95SzszTAwOm9yvTWO44betxNJd5ZGrsJJFNctuQo0WkYbuKvO1JZ
         XrITdvo9ENscJEhe329jrqL505rYh5yIoBdJCeprqbg4dMV71wO/TzcS4I1NiHZbZDjj
         ofgjlKu7OvgslbMF3MwPrZA2Iwg+BI4YpcmeapUIm7S2APRBbyzoD1KLtw1pWhETs0oG
         Tlyw==
X-Gm-Message-State: AOAM533a+05RkWvkwoe7DpYTJ0ZZfBKQawA9JFkzvZyFSG2fz4S7eFU4
        DFX4xjRAw6jv5BGXfi3Ayg==
X-Google-Smtp-Source: ABdhPJzdwNs2TTvMMhPurie/Z2ze3Kaj4Y2IAOi9YjrL1pMLCBZwuYrSXPXRDjt2YTX9QydWacu9Kw==
X-Received: by 2002:a92:ca0f:0:b0:2bf:56d4:3aec with SMTP id j15-20020a92ca0f000000b002bf56d43aecmr14324732ils.220.1645410990890;
        Sun, 20 Feb 2022 18:36:30 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id h13sm7203330ili.28.2022.02.20.18.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 18:36:30 -0800 (PST)
Received: (nullmailer pid 2041543 invoked by uid 1000);
        Mon, 21 Feb 2022 02:36:09 -0000
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-clk@vger.kernel.org,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Vinod Koul <vkoul@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        dmaengine@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-renesas-soc@vger.kernel.org,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Laetitia MARIOTTINI <laetitia.mariottini@se.com>,
        devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
In-Reply-To: <20220218181226.431098-3-miquel.raynal@bootlin.com>
References: <20220218181226.431098-1-miquel.raynal@bootlin.com> <20220218181226.431098-3-miquel.raynal@bootlin.com>
Subject: Re: [PATCH 2/8] dt-bindings: dma: Introduce RZN1 DMA compatible
Date:   Sun, 20 Feb 2022 20:36:09 -0600
Message-Id: <1645410969.367667.2041542.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, 18 Feb 2022 19:12:20 +0100, Miquel Raynal wrote:
> Just like for the NAND controller that is also on this SoC, let's
> provide a SoC generic and a more specific couple of compatibles.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../devicetree/bindings/dma/snps,dma-spear1340.yaml       | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/renesas-nandc.example.dt.yaml: nand-controller@40102000: '#dma-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/renesas-nandc.example.dt.yaml: nand-controller@40102000: $nodename:0: 'nand-controller@40102000' does not match '^dma-controller(@.*)?$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/renesas-nandc.example.dt.yaml: nand-controller@40102000: clocks: [[4294967295, 117], [4294967295, 37]] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/renesas-nandc.example.dt.yaml: nand-controller@40102000: clock-names: ['hclk', 'eclk'] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/renesas-nandc.example.dt.yaml: nand-controller@40102000: Unevaluated properties are not allowed ('clocks', 'clock-names', '#address-cells', '#size-cells' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/renesas-nandc.example.dt.yaml: nand-controller@40102000: '#dma-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1594847

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

