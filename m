Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3677484AE9
	for <lists+dmaengine@lfdr.de>; Tue,  4 Jan 2022 23:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235585AbiADWu6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Jan 2022 17:50:58 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:42814 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235054AbiADWu5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 4 Jan 2022 17:50:57 -0500
Received: by mail-oi1-f182.google.com with SMTP id w80so23225348oie.9;
        Tue, 04 Jan 2022 14:50:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u4kviz+vXJjA0Xr/GvLPvVjzKhQXUWXW9U7sAVz/Kws=;
        b=Dyj0xXu7Jxk3f9uJkYSW2xH6yZiDPxXuXE+GY6c3f3pd0gAfwacDunvSZ+ixwZiLK+
         fartT3oeKa1s4/yU+/RoyCsJbRg2qEua089dxCACY3EXs1VyoHX5FnEc5jY9qz4DUxQY
         VrDOfKJc1lzsRKvprNUHLh2yBnrQ5OGEVUyJTVICC1zfeiQHledWWs4OVUBUSXYe5Wtu
         eaYk/9ar57rsxUllnxsidUpyB8d4mUvFFxpcHcx8rrYRXutOLccJRBMvYC8yKkt7NI3J
         knE8IHgjfhEIFYkhYXPdtFpsdg+5jvnbkrjRtJbs2Vvg6a6zFf5SAX0g4smYk+/ZkG85
         PsHA==
X-Gm-Message-State: AOAM53313doRik/hAMnmXdDqAjfNGejgUdrKFlvX5POuDFFQBKFGVjUS
        hRFE6ayLdd9rxyQTxpW6EUu+uKyhbg==
X-Google-Smtp-Source: ABdhPJwNFO/5L0PEn5FdLvaYheNkhb4dr8Lab3trw39GjJ7qdog3DNOeJn9PGF5FSEP9yNDsP3qu6A==
X-Received: by 2002:aca:2b07:: with SMTP id i7mr390628oik.141.1641336657260;
        Tue, 04 Jan 2022 14:50:57 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bh12sm10157694oib.25.2022.01.04.14.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 14:50:56 -0800 (PST)
Received: (nullmailer pid 1599613 invoked by uid 1000);
        Tue, 04 Jan 2022 22:50:55 -0000
Date:   Tue, 4 Jan 2022 16:50:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, dmaengine@vger.kernel.org,
        Phil Elwell <phil@raspberrypi.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lukas Wunner <lukas@wunner.de>,
        linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH RFC 02/11] dt-bindings: dma: Convert brcm,bcm2835-dma to
 json-schema
Message-ID: <YdTPT4osjSDYzzRg@robh.at.kernel.org>
References: <1640606743-10993-1-git-send-email-stefan.wahren@i2se.com>
 <1640606743-10993-3-git-send-email-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1640606743-10993-3-git-send-email-stefan.wahren@i2se.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Dec 27, 2021 at 01:05:36PM +0100, Stefan Wahren wrote:
> This convert the BCM2835 DMA bindings to YAML format.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  .../devicetree/bindings/dma/brcm,bcm2835-dma.txt   |  83 ----------------
>  .../devicetree/bindings/dma/brcm,bcm2835-dma.yaml  | 107 +++++++++++++++++++++
>  2 files changed, 107 insertions(+), 83 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt
>  create mode 100644 Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt b/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt
> deleted file mode 100644
> index b6a8cc0..0000000
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
> index 0000000..44cb83f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.yaml
> @@ -0,0 +1,107 @@
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
> +description: |

Don't need '|' unless there is formatting to preserve.

> +  The BCM2835 DMA controller has 16 channels in total.
> +  Only the lower 13 channels have an associated IRQ.
> +  Some arbitrary channels are used by the firmware
> +  (1,3,6,7 in the current firmware version).
> +  The channels 0,2 and 3 have special functionality
> +  and should not be used by the driver.

Re-wrap the lines.

> +
> +allOf:
> +  - $ref: "dma-controller.yaml#"
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

The names must be defined. You can do:

items:
  pattern: ...

> +
> +  "#dma-cells":
> +    const: 1
> +    description: >
> +      DMA clients must use the format described in dma.txt, giving a phandle

Please read dma.txt.

> +      to the DMA controller while the second cell in the dmas property of the

Cells don't include the phandle, so 'second cell' is odd. Reword all 
this to be just what is specific to this binding.

> +      client device represents the DREQ number.
> +
> +  brcm,dma-channel-mask:
> +    description:
> +      Bit mask representing the channels not used by the firmware in
> +      ascending order, i.e. first channel corresponds to LSB.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - "#dma-cells"
> +  - brcm,dma-channel-mask
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    dma: dma-controller@7e007000 {
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
> +        brcm,dma-channel-mask = <0x7f35>;
> +    };
> +
> +...
> -- 
> 2.7.4
> 
> 
