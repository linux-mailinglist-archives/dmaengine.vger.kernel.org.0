Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC8572A58F
	for <lists+dmaengine@lfdr.de>; Fri,  9 Jun 2023 23:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbjFIVsj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 9 Jun 2023 17:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232603AbjFIVsf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 9 Jun 2023 17:48:35 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A519E3A86;
        Fri,  9 Jun 2023 14:48:32 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-777b4c9e341so100204439f.0;
        Fri, 09 Jun 2023 14:48:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686347312; x=1688939312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qpfwtUB289deyJuENcBGM55nCDkXMSKNdGdYUHnuCU=;
        b=XNf7AmIHny1WOZ0PIzhzhMlDd2aNtQaDRQLe92/UiUXxruq1HsiI9sh+2ytd23D4nK
         1mxBJfosAqkjIK17TitpiBhN9F8oQ98+dvP3TZbMXRWSulsBp5Mw2bRdqlu7Vnx0PT+r
         lPAAPtMRbYxpQiNRGK8arDrU9aQrbdOnbcE5yRi7pjWo679S7UUffc85OjxLCxIalx+d
         ojKjLmuLO7Sz0/iOrhPIPMFgx/cpi3hmFKj0i+0pEdzj/xmId9AFFm/nAhW0lABezGNv
         S64qejS3BfY2l1/zvrE4XnTV9ZGJd+0mbbDGIXagYNkXxTRqy93KYTrD/UT4b0mJIKk9
         QhOw==
X-Gm-Message-State: AC+VfDxW+IkWDmvBiGQ3dK+4s+YUsqUr4jd9DkT+/n4uXE0i6V6L/HAM
        PNHBckbXpfWCNn8YUN8Btw==
X-Google-Smtp-Source: ACHHUZ47VZENLy/puA0Ka/EMeCy9/Ituyd85TfUdYllTCRogMKRllOm/YUoG9xFkK70Op6F8ZIz4Bg==
X-Received: by 2002:a5e:db07:0:b0:777:8e86:7636 with SMTP id q7-20020a5edb07000000b007778e867636mr2922948iop.15.1686347311726;
        Fri, 09 Jun 2023 14:48:31 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id ei5-20020a05663829a500b0041cd0951a93sm1191556jab.8.2023.06.09.14.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 14:48:31 -0700 (PDT)
Received: (nullmailer pid 2522025 invoked by uid 1000);
        Fri, 09 Jun 2023 21:48:28 -0000
Date:   Fri, 9 Jun 2023 15:48:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-pm@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH 03/10] dt-bindings: dma: convert bcm2835-dma bindings to
 YAML
Message-ID: <20230609214828.GA2519714-robh@kernel.org>
References: <20230604121223.9625-1-stefan.wahren@i2se.com>
 <20230604121223.9625-4-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230604121223.9625-4-stefan.wahren@i2se.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sun, Jun 04, 2023 at 02:12:16PM +0200, Stefan Wahren wrote:
> Convert the DT binding document for bcm2835-dma from .txt to YAML.
> Since brcm,dma-channel-mask is considered deprecated use the
> generic property.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  .../bindings/dma/brcm,bcm2835-dma.txt         | 83 ----------------
>  .../bindings/dma/brcm,bcm2835-dma.yaml        | 98 +++++++++++++++++++
>  2 files changed, 98 insertions(+), 83 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt
>  create mode 100644 Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt b/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt
> deleted file mode 100644
> index b6a8cc0978cd..000000000000
> --- a/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt
> +++ /dev/null
> @@ -1,83 +0,0 @@
> -* BCM2835 DMA controller
> -
> -The BCM2835 DMA controller has 16 channels in total.
> -Only the lower 13 channels have an associated IRQ.
> -Some arbitrary channels are used by the firmware
> -(1,3,6,7 in the current firmware version).
> -The channels 0,2 and 3 have special functionality
> -and should not be used by the driver.
> -
> -Required properties:
> -- compatible: Should be "brcm,bcm2835-dma".
> -- reg: Should contain DMA registers location and length.
> -- interrupts: Should contain the DMA interrupts associated
> -		to the DMA channels in ascending order.
> -- interrupt-names: Should contain the names of the interrupt
> -		   in the form "dmaXX".
> -		   Use "dma-shared-all" for the common interrupt line
> -		   that is shared by all dma channels.
> -- #dma-cells: Must be <1>, the cell in the dmas property of the
> -		client device represents the DREQ number.
> -- brcm,dma-channel-mask: Bit mask representing the channels
> -			 not used by the firmware in ascending order,
> -			 i.e. first channel corresponds to LSB.
> -
> -Example:
> -
> -dma: dma@7e007000 {
> -	compatible = "brcm,bcm2835-dma";
> -	reg = <0x7e007000 0xf00>;
> -	interrupts = <1 16>,
> -		     <1 17>,
> -		     <1 18>,
> -		     <1 19>,
> -		     <1 20>,
> -		     <1 21>,
> -		     <1 22>,
> -		     <1 23>,
> -		     <1 24>,
> -		     <1 25>,
> -		     <1 26>,
> -		     /* dma channel 11-14 share one irq */
> -		     <1 27>,
> -		     <1 27>,
> -		     <1 27>,
> -		     <1 27>,
> -		     /* unused shared irq for all channels */
> -		     <1 28>;
> -	interrupt-names = "dma0",
> -			  "dma1",
> -			  "dma2",
> -			  "dma3",
> -			  "dma4",
> -			  "dma5",
> -			  "dma6",
> -			  "dma7",
> -			  "dma8",
> -			  "dma9",
> -			  "dma10",
> -			  "dma11",
> -			  "dma12",
> -			  "dma13",
> -			  "dma14",
> -			  "dma-shared-all";
> -
> -	#dma-cells = <1>;
> -	brcm,dma-channel-mask = <0x7f35>;
> -};
> -
> -
> -DMA clients connected to the BCM2835 DMA controller must use the format
> -described in the dma.txt file, using a two-cell specifier for each channel.
> -
> -Example:
> -
> -bcm2835_i2s: i2s@7e203000 {
> -	compatible = "brcm,bcm2835-i2s";
> -	reg = <	0x7e203000 0x24>;
> -	clocks = <&clocks BCM2835_CLOCK_PCM>;
> -
> -	dmas = <&dma 2>,
> -	       <&dma 3>;
> -	dma-names = "tx", "rx";
> -};
> diff --git a/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.yaml b/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.yaml
> new file mode 100644
> index 000000000000..a09000a8131f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.yaml
> @@ -0,0 +1,98 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/brcm,bcm2835-dma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: BCM2835 DMA controller
> +
> +maintainers:
> +  - Nicolas Saenz Julienne <nsaenz@kernel.org>
> +
> +description:
> +  The BCM2835 DMA controller has 16 channels in total. Only the lower
> +  13 channels have an associated IRQ. Some arbitrary channels are used by the
> +  VideoCore firmware (1,3,6,7 in the current firmware version). The channels
> +  0, 2 and 3 have special functionality and should not be used by the driver.
> +
> +allOf:
> +  - $ref: "dma-controller.yaml#"

Drop quotes. Please check elsewhere in the series.

With that fixed,

Reviewed-by: Rob Herring <robh@kernel.org>

> +
> +properties:
> +  compatible:
> +    const: brcm,bcm2835-dma
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description:
> +      Should contain the DMA interrupts associated to the DMA channels in
> +      ascending order.
> +    minItems: 1
> +    maxItems: 16
> +
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 16
> +
> +  '#dma-cells':
> +    description: The single cell represents the DREQ number.
> +    const: 1
> +
> +  dma-channel-mask:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - "#dma-cells"
> +  - dma-channel-mask
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    dma-controller@7e007000 {
> +      compatible = "brcm,bcm2835-dma";
> +      reg = <0x7e007000 0xf00>;
> +      interrupts = <1 16>,
> +                   <1 17>,
> +                   <1 18>,
> +                   <1 19>,
> +                   <1 20>,
> +                   <1 21>,
> +                   <1 22>,
> +                   <1 23>,
> +                   <1 24>,
> +                   <1 25>,
> +                   <1 26>,
> +                   /* dma channel 11-14 share one irq */
> +                   <1 27>,
> +                   <1 27>,
> +                   <1 27>,
> +                   <1 27>,
> +                   /* unused shared irq for all channels */
> +                   <1 28>;
> +      interrupt-names = "dma0",
> +                        "dma1",
> +                        "dma2",
> +                        "dma3",
> +                        "dma4",
> +                        "dma5",
> +                        "dma6",
> +                        "dma7",
> +                        "dma8",
> +                        "dma9",
> +                        "dma10",
> +                        "dma11",
> +                        "dma12",
> +                        "dma13",
> +                        "dma14",
> +                        "dma-shared-all";
> +        #dma-cells = <1>;
> +        dma-channel-mask = <0x7f35>;
> +    };
> +
> +...
> -- 
> 2.34.1
> 
