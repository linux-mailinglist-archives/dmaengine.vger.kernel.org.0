Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF81222C22
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jul 2020 21:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbgGPTru (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Jul 2020 15:47:50 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41930 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728788AbgGPTru (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Jul 2020 15:47:50 -0400
Received: by mail-io1-f66.google.com with SMTP id p205so7303345iod.8;
        Thu, 16 Jul 2020 12:47:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JhCyixCktHEpyKaSj8J8HBrewJpvrxr4Dobi9P1P5eg=;
        b=eWeQt50AI0ovORy09vCEUPrLeoRo1dgKTcRP4zZUHc4OLFmKDKiVjKawplydYMvd+6
         70EJQty7vJpNbIw17epGsrgOO7T0NA5QWXN6C9bacXY1YkfAgqApKjkBCRU4KVjFS4tG
         mxZHJepg6huB2cVFugJvMO4N/GvWtv9FR+B8JAgHh/+47RC7YAKCjYJ2zDUukcSzS7oz
         p+QfgKxalPkfnw7M9lmPAG9LG9BsfailvjjZI/Un2sc3qrnBy8KXcQ7vS3uQDmGAJpHS
         5xZ8ikJNzBoI+FAJCO5ryBUeirNd5wU+gSHQKSZcyxHGBIPKDrsJFXavj0//Rukuaw3h
         XmNg==
X-Gm-Message-State: AOAM530VaHqA5TmLqdJ4koOgHjwReQy6u8PNO/Okfbc7azIkeyboE28f
        KakDDDVZ34h74ZKt4QIf5w==
X-Google-Smtp-Source: ABdhPJzNpwEG5H8u/oWt6PabRVpHiT4bMEtqypidWvr8oM/6+PNVOrAOA5uh9w5O8XFY9KPSmwmwTQ==
X-Received: by 2002:a02:5e88:: with SMTP id h130mr7093109jab.116.1594928868688;
        Thu, 16 Jul 2020 12:47:48 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id v13sm3195024iox.12.2020.07.16.12.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 12:47:48 -0700 (PDT)
Received: (nullmailer pid 2731552 invoked by uid 1000);
        Thu, 16 Jul 2020 19:47:46 -0000
Date:   Thu, 16 Jul 2020 13:47:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     vkoul@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        dan.j.williams@intel.com, angelo@sysam.it, kernel@pengutronix.de,
        linux-imx@nxp.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 6/9] dt-bindings: dma: add fsl-edma3 yaml
Message-ID: <20200716194746.GA2716872@bogus>
References: <1594748508-22179-1-git-send-email-yibin.gong@nxp.com>
 <1594748508-22179-7-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594748508-22179-7-git-send-email-yibin.gong@nxp.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Jul 15, 2020 at 01:41:45AM +0800, Robin Gong wrote:
> Add device binding doc for fsl-edma3 driver.
> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> ---
>  .../devicetree/bindings/dma/nxp,fsl-edma3.yaml     | 134 +++++++++++++++++++++
>  1 file changed, 134 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/nxp,fsl-edma3.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dma/nxp,fsl-edma3.yaml b/Documentation/devicetree/bindings/dma/nxp,fsl-edma3.yaml
> new file mode 100644
> index 00000000..ebdad90
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/nxp,fsl-edma3.yaml
> @@ -0,0 +1,134 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/nxp,fsl-edma3.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP eDMA3 Controller
> +
> +maintainers:
> +  - Robin Gong <yibin.gong@nxp.com>
> +
> +allOf:
> +  - $ref: "dma-controller.yaml#"
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - fsl,imx8qm-edma  # i.mx8qm/qxp
> +
> +  reg:
> +    minItems: 2
> +    maxItems: 32

Needs some sort of description as to what each region is.
 
> +
> +  interrupts:
> +    minItems: 2
> +    maxItems: 32

ditto

> +
> +  interrupt-names:
> +    minItems: 2
> +    maxItems: 32
> +    items:
> +      - pattern: "^edma[0-2]-chan([0-9]|[1-2][0-9]|3[0-1])-tx|rx+$"
> +      - pattern: "^edma[0-2]-chan([0-9]|[1-2][0-9]|3[0-1])-tx|rx+$"
> +      - pattern: "^edma[0-2]-chan([0-9]|[1-2][0-9]|3[0-1])-tx|rx+$"
> +      - pattern: "^edma[0-2]-chan([0-9]|[1-2][0-9]|3[0-1])-tx|rx+$"
> +      - pattern: "^edma[0-2]-chan([0-9]|[1-2][0-9]|3[0-1])-tx|rx+$"
> +      - pattern: "^edma[0-2]-chan([0-9]|[1-2][0-9]|3[0-1])-tx|rx+$"
> +      - pattern: "^edma[0-2]-chan([0-9]|[1-2][0-9]|3[0-1])-tx|rx+$"
> +      - pattern: "^edma[0-2]-chan([0-9]|[1-2][0-9]|3[0-1])-tx|rx+$"

What about interrupts 8-31? If you want a pattern for all entries, you 
do:

items:
  pattern: "^edma[0-2]-chan([0-9]|[1-2][0-9]|3[0-1])-tx|rx+$"

(If 'items' is a schema instead of a list, then it applies to all 
entries.)

What does edma[0-2] correspond to? The names should be local to the 
instance.

Really, what's the point of names that just have the channel number in 
them? The driver can create names dynamically if needed. We already have 
properties to define how many channels and a mask of present channels.

> +
> +  '#dma-cells':
> +    const: 3
> +    description: |
> +      The 1st cell specifies the channel ID.
> +
> +      The 2nd cell specifies the channel priority.
> +
> +      The 3rd cell specifies the channel attributes:
> +        bit0 transmit or receive.
> +          0 = transmit
> +          1 = receive
> +        bit1 local or remote access.
> +          0 = local
> +          1 = remote
> +        bit2 dualfifo case or not(only in Audio cyclic now).
> +          0 = not dual fifo case
> +          1 =  dualfifo case.
> +
> +  dma-channels:
> +    minimum: 2
> +    maximum: 32
> +
> +  power-domains:
> +    minItems: 2
> +    maxItems: 32
> +
> +  power-domain-names:
> +    minItems: 2
> +    maxItems: 32
> +    items:
> +      - pattern: "^edma[0-2]-chan([0-9]|[1-2][0-9]|3[0-1])+$"
> +      - pattern: "^edma[0-2]-chan([0-9]|[1-2][0-9]|3[0-1])+$"
> +      - pattern: "^edma[0-2]-chan([0-9]|[1-2][0-9]|3[0-1])+$"
> +      - pattern: "^edma[0-2]-chan([0-9]|[1-2][0-9]|3[0-1])+$"
> +      - pattern: "^edma[0-2]-chan([0-9]|[1-2][0-9]|3[0-1])+$"
> +      - pattern: "^edma[0-2]-chan([0-9]|[1-2][0-9]|3[0-1])+$"
> +      - pattern: "^edma[0-2]-chan([0-9]|[1-2][0-9]|3[0-1])+$"
> +      - pattern: "^edma[0-2]-chan([0-9]|[1-2][0-9]|3[0-1])+$"

Again, why do you need names here?

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-names
> +  - '#dma-cells'
> +  - dma-channels
> +  - power-domains
> +  - power-domain-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/firmware/imx/rsrc.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    edma2: dma-controller@5a1f0000 {
> +        compatible = "fsl,imx8qm-edma";
> +        reg = <0x5a280000 0x10000>, /* channel8 UART0 rx */
> +              <0x5a290000 0x10000>, /* channel9 UART0 tx */
> +              <0x5a2a0000 0x10000>, /* channel10 UART1 rx */
> +              <0x5a2b0000 0x10000>, /* channel11 UART1 tx */
> +              <0x5a2c0000 0x10000>, /* channel12 UART2 rx */
> +              <0x5a2d0000 0x10000>, /* channel13 UART2 tx */
> +              <0x5a2e0000 0x10000>, /* channel14 UART3 rx */
> +              <0x5a2f0000 0x10000>; /* channel15 UART3 tx */
> +        #dma-cells = <3>;
> +        dma-channels = <8>;
> +        interrupts = <GIC_SPI 434 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 435 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 436 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 437 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 438 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 439 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 440 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 441 IRQ_TYPE_LEVEL_HIGH>;
> +       interrupt-names = "edma2-chan8-rx", "edma2-chan9-tx",
> +                         "edma2-chan10-rx", "edma2-chan11-tx",
> +                         "edma2-chan12-rx", "edma2-chan13-tx",
> +                         "edma2-chan14-rx", "edma2-chan15-tx";
> +       power-domains = <&pd IMX_SC_R_DMA_2_CH8>,
> +                       <&pd IMX_SC_R_DMA_2_CH9>,
> +                       <&pd IMX_SC_R_DMA_2_CH10>,
> +                       <&pd IMX_SC_R_DMA_2_CH11>,
> +                       <&pd IMX_SC_R_DMA_2_CH12>,
> +                       <&pd IMX_SC_R_DMA_2_CH13>,
> +                       <&pd IMX_SC_R_DMA_2_CH14>,
> +                       <&pd IMX_SC_R_DMA_2_CH15>;
> +       power-domain-names = "edma2-chan8", "edma2-chan9",
> +                            "edma2-chan10", "edma2-chan11",
> +                            "edma2-chan12", "edma2-chan13",
> +                            "edma2-chan14", "edma2-chan15";
> +    };
> -- 
> 2.7.4
> 
