Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3039D4CBF03
	for <lists+dmaengine@lfdr.de>; Thu,  3 Mar 2022 14:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiCCNnB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Mar 2022 08:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbiCCNnA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 3 Mar 2022 08:43:00 -0500
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9879D18A79E;
        Thu,  3 Mar 2022 05:42:14 -0800 (PST)
Received: by mail-oo1-f49.google.com with SMTP id x6-20020a4a4106000000b003193022319cso5795140ooa.4;
        Thu, 03 Mar 2022 05:42:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z0y5GAHHBXUabdP29H45OGCTi0pJFGkuEdFh5jBbOJE=;
        b=YUbN/uAoWmU49nH2TgWT9JozsXKqhYV/rlrlh6CWI9OSzCPULxyQajwykVFDmd8JIT
         LL1A2aLqZ0kXeGrnKbb4ffJp3SKd+ZfbQv2G/w6oLLsyPhC833UzNS1BaeWHdCRM5N9H
         NLtziHMUXWJtYoHo8ByjfzvcdCu4zLR529gPbk9oGkk/g4HZojCkf/lpHU2O89GcjSz1
         sIY3EWoNL9jFypMjiAEm/V/QoaTAzCUfNcgOV932LT7EPRobfATsMYfnlqrqUGcjuU88
         fwMc1KFyZ/Sxn5/7JPsc7TIuqW5oEoIdwf1EeO62upl5fUrRd8HdWeSvedl0pCnHWufQ
         v8Ww==
X-Gm-Message-State: AOAM5324lVY8eOxhCXx6wxITUuV1J2EsxmGWkNlFjHabvaLM0cFbQbX7
        wkbb2G8ROwTek120Nge5LQ==
X-Google-Smtp-Source: ABdhPJy8jFFRsHPWCtBjc6J0UoOl1dzwjcqx+x5MClx5x4UV+ugoQdJc5iruRkhAJVVJIf5+G1t+NQ==
X-Received: by 2002:a05:6870:51d0:b0:d7:1e2a:2587 with SMTP id b16-20020a05687051d000b000d71e2a2587mr4028837oaj.176.1646314933848;
        Thu, 03 Mar 2022 05:42:13 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l7-20020a9d4c07000000b005afa8981a42sm914321otf.8.2022.03.03.05.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 05:42:12 -0800 (PST)
Received: (nullmailer pid 1490403 invoked by uid 1000);
        Thu, 03 Mar 2022 13:42:11 -0000
Date:   Thu, 3 Mar 2022 07:42:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v3 1/7] dt-bindings: dma: Introduce RZN1 dmamux bindings
Message-ID: <YiDFs0gfBsWt0edy@robh.at.kernel.org>
References: <20220225112403.505562-1-miquel.raynal@bootlin.com>
 <20220225112403.505562-2-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225112403.505562-2-miquel.raynal@bootlin.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Feb 25, 2022 at 12:23:56PM +0100, Miquel Raynal wrote:
> The Renesas RZN1 DMA IP is a based on a DW core, with eg. an additional
> dmamux register located in the system control area which can take up to
> 32 requests (16 per DMA controller). Each DMA channel can be wired to
> two different peripherals.

This should be a child of and referenced by the 'system control area' 
schema. Also, add a reg property for the register.


> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  .../bindings/dma/renesas,rzn1-dmamux.yaml     | 42 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/renesas,rzn1-dmamux.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dma/renesas,rzn1-dmamux.yaml b/Documentation/devicetree/bindings/dma/renesas,rzn1-dmamux.yaml
> new file mode 100644
> index 000000000000..e2c82e43b8b1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/renesas,rzn1-dmamux.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/renesas,rzn1-dmamux.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas RZ/N1 DMA mux
> +
> +maintainers:
> +  - Miquel Raynal <miquel.raynal@bootlin.com>
> +
> +allOf:
> +  - $ref: "dma-router.yaml#"
> +
> +properties:
> +  compatible:
> +    const: renesas,rzn1-dmamux
> +
> +  '#dma-cells':
> +    const: 6
> +    description:
> +      The first four cells are dedicated to the master DMA controller. The fifth
> +      cell gives the DMA mux bit index that must be set starting from 0. The
> +      sixth cell gives the binary value that must be written there, ie. 0 or 1.
> +
> +  dma-masters:
> +    minItems: 1
> +    maxItems: 2
> +
> +  dma-requests:
> +    const: 32
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    dma-router {
> +      compatible = "renesas,rzn1-dmamux";
> +      #dma-cells = <6>;
> +      dma-masters = <&dma0 &dma1>;
> +      dma-requests = <32>;
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ea3e6c914384..c70c9c39a2f3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18636,6 +18636,7 @@ SYNOPSYS DESIGNWARE DMAC DRIVER
>  M:	Viresh Kumar <vireshk@kernel.org>
>  R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/dma/renesas,rzn1-dmamux.yaml
>  F:	Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml
>  F:	drivers/dma/dw/
>  F:	include/dt-bindings/dma/dw-dmac.h
> -- 
> 2.27.0
> 
> 
