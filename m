Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 197D665EAD
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jul 2019 19:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbfGKRdo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 11 Jul 2019 13:33:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:38228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728268AbfGKRdo (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 11 Jul 2019 13:33:44 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CEFF20863;
        Thu, 11 Jul 2019 17:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562866422;
        bh=zqhPb2oAGKoCkNFyISU+5AP+rwJicpwT0WCuFuDmmfY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mcSl8FdX2iGtSqxD6gKtzKChXuIH1McE33wG65Fu4kog2+zxp0w4pd5vkManrJzJT
         X788MV26q6BjJdmnvG7Mvxtc2ZTdPqjKpFJ/ETjI+peCvVygIZSEjpGc6GtNMm6xjo
         YOp5S64IdB9IgUybWec0FxJGs1hbsQWBCP+Ut6CQ=
Received: by mail-qk1-f175.google.com with SMTP id r21so4285702qke.2;
        Thu, 11 Jul 2019 10:33:42 -0700 (PDT)
X-Gm-Message-State: APjAAAVIicSEBbsX3jfqenCNEaVwhikRP+oqKBQcCXFI8UoCvNrpM+UV
        /+kstZa7mF3BWTIJkiCqoCIVsFzpEXsECDuNQA==
X-Google-Smtp-Source: APXvYqxiQdcwj4k5sQshf/YxJBG3tGFJGkg/XguY+QAVpESWH2Q0zZl+I1EhiBoulpQ6D5vcPivvknOAwfJkwC3o4Wo=
X-Received: by 2002:a05:620a:1447:: with SMTP id i7mr2913253qkl.254.1562866421381;
 Thu, 11 Jul 2019 10:33:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190711092158.14678-1-maxime.ripard@bootlin.com>
In-Reply-To: <20190711092158.14678-1-maxime.ripard@bootlin.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 11 Jul 2019 11:33:30 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLh8QEwa-3v9-Vs=e55k3GyyvwsNVxmdBMWMD_VxqKMyA@mail.gmail.com>
Message-ID: <CAL_JsqLh8QEwa-3v9-Vs=e55k3GyyvwsNVxmdBMWMD_VxqKMyA@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: dma: Add YAML schemas for the generic
 DMA bindings
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Jul 11, 2019 at 3:34 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> The DMA controllers and consumers have a bunch of generic properties that
> are needed in a device tree. Add a YAML schemas for those.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  .../devicetree/bindings/dma/dma-consumer.yaml |  60 +++++++++

This already exists in the dt-schema/schemas/dma/dma.yaml though not
the descriptions because that needs relicensing.

Looks like we need NVidia's (Jon H) and TI's (Peter U) permission.

>  .../bindings/dma/dma-controller.yaml          |  79 ++++++++++++
>  Documentation/devicetree/bindings/dma/dma.txt | 114 +-----------------
>  3 files changed, 140 insertions(+), 113 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/dma-consumer.yaml
>  create mode 100644 Documentation/devicetree/bindings/dma/dma-controller.yaml
>
> diff --git a/Documentation/devicetree/bindings/dma/dma-consumer.yaml b/Documentation/devicetree/bindings/dma/dma-consumer.yaml
> new file mode 100644
> index 000000000000..2f6315863ad1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/dma-consumer.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/dma-consumer.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: DMA Consumer Generic Binding
> +
> +maintainers:
> +  - Vinod Koul <vkoul@kernel.org>
> +
> +select: true
> +
> +properties:
> +  dmas:
> +    description:
> +      List of one or more DMA specifiers, each consisting of
> +          - A phandle pointing to DMA controller node
> +          - A number of integer cells, as determined by the
> +            \#dma-cells property in the node referenced by phandle
> +            containing DMA controller specific information. This
> +            typically contains a DMA request line number or a
> +            channel number, but can contain any data that is
> +            required for configuring a channel.
> +
> +  dma-names:
> +    description:
> +      Contains one identifier string for each DMA specifier in the
> +      dmas property. The specific strings that can be used are defined
> +      in the binding of the DMA client device.  Multiple DMA
> +      specifiers can be used to represent alternatives and in this
> +      case the dma-names for those DMA specifiers must be identical
> +      (see examples).
> +
> +dependencies:
> +  dma-names: [ dmas ]
> +
> +examples:
> +  - |
> +    /* A device with one DMA read channel, one DMA write channel */
> +    i2c1: i2c@1 {
> +         /* ... */
> +         dmas = <&dma 2>,      /* read channel */
> +                <&dma 3>;      /* write channel */
> +        dma-names = "rx", "tx";
> +        /* ... */
> +    };
> +
> +  - |
> +    /* A single read-write channel with three alternative DMA controllers */
> +    dmas = <&dma1 5>, <&dma2 7>, <&dma3 2>;
> +    dma-names = "rx-tx", "rx-tx", "rx-tx";
> +
> +  - |
> +    /* A device with three channels, one of which has two alternatives */
> +    dmas = <&dma1 2>,          /* read channel */
> +           <&dma1 3>,          /* write channel */
> +           <&dma2 0>,          /* error read */
> +           <&dma3 0>;          /* alternative error read */
> +    dma-names = "rx", "tx", "error", "error";
> diff --git a/Documentation/devicetree/bindings/dma/dma-controller.yaml b/Documentation/devicetree/bindings/dma/dma-controller.yaml
> new file mode 100644
> index 000000000000..17c650131b78
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/dma-controller.yaml
> @@ -0,0 +1,79 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/dma-controller.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: DMA Controller Generic Binding
> +
> +maintainers:
> +  - Vinod Koul <vkoul@kernel.org>
> +
> +description:
> +  Generic binding to provide a way for a driver using DMA Engine to
> +  retrieve the DMA request or channel information that goes from a
> +  hardware device to a DMA controller.
> +
> +properties:
> +  $nodename:
> +    pattern: "^dma-controller(@.*)?$"
> +
> +  "#dma-cells":
> +    # minimum: 1
> +    description:
> +      Used to provide DMA controller specific information.
> +
> +  dma-channel-masks:
> +    $ref: /schemas/types.yaml#definitions/uint32
> +    description:
> +      Bitmask of available DMA channels in ascending order that are
> +      not reserved by firmware and are available to the
> +      kernel. i.e. first channel corresponds to LSB.
> +
> +  dma-channels:
> +    $ref: /schemas/types.yaml#definitions/uint32
> +    description:
> +      Number of DMA channels supported by the controller.
> +
> +  dma-masters:
> +    $ref: /schemas/types.yaml#definitions/phandle-array
> +    description:
> +      DMA routers are transparent IP blocks used to route DMA request
> +      lines from devices to the DMA controller. Some SoCs (like TI
> +      DRA7x) have more peripherals integrated with DMA requests than
> +      what the DMA controller can handle directly.
> +
> +      In such a case, dma-masters is an array of phandle to the DMA
> +      controllers the router can direct the signal to.
> +
> +  dma-requests:
> +    $ref: /schemas/types.yaml#definitions/uint32
> +    description:
> +      Number of DMA request signals supported by the controller.
> +
> +examples:
> +  - |
> +    dma: dma@48000000 {

dma-controller@...

This is a case where I'd like some check that the schema is actually
applied to the schema's example.

> +        compatible = "ti,omap-sdma";
> +        reg = <0x48000000 0x1000>;
> +        interrupts = <0 12 0x4
> +                      0 13 0x4
> +                      0 14 0x4
> +                      0 15 0x4>;
> +        #dma-cells = <1>;
> +        dma-channels = <32>;
> +        dma-requests = <127>;
> +        dma-channel-mask = <0xfffe>;
> +    };
> +
> +  - |
> +    sdma_xbar: dma-router@4a002b78 {
> +        compatible = "ti,dra7-dma-crossbar";
> +        reg = <0x4a002b78 0xfc>;
> +        #dma-cells = <1>;
> +        dma-requests = <205>;
> +        ti,dma-safe-map = <0>;
> +        dma-masters = <&sdma>;
> +    };
> +
> +...
> diff --git a/Documentation/devicetree/bindings/dma/dma.txt b/Documentation/devicetree/bindings/dma/dma.txt
> index eeb4e4d1771e..90a67a016a48 100644
> --- a/Documentation/devicetree/bindings/dma/dma.txt
> +++ b/Documentation/devicetree/bindings/dma/dma.txt
> @@ -1,113 +1 @@
> -* Generic DMA Controller and DMA request bindings
> -
> -Generic binding to provide a way for a driver using DMA Engine to retrieve the
> -DMA request or channel information that goes from a hardware device to a DMA
> -controller.
> -
> -
> -* DMA controller
> -
> -Required property:
> -- #dma-cells:          Must be at least 1. Used to provide DMA controller
> -                       specific information. See DMA client binding below for
> -                       more details.
> -
> -Optional properties:
> -- dma-channels:        Number of DMA channels supported by the controller.
> -- dma-requests:        Number of DMA request signals supported by the
> -                       controller.
> -- dma-channel-mask:    Bitmask of available DMA channels in ascending order
> -                       that are not reserved by firmware and are available to
> -                       the kernel. i.e. first channel corresponds to LSB.
> -
> -Example:
> -
> -       dma: dma@48000000 {
> -               compatible = "ti,omap-sdma";
> -               reg = <0x48000000 0x1000>;
> -               interrupts = <0 12 0x4
> -                             0 13 0x4
> -                             0 14 0x4
> -                             0 15 0x4>;
> -               #dma-cells = <1>;
> -               dma-channels = <32>;
> -               dma-requests = <127>;
> -               dma-channel-mask = <0xfffe>
> -       };
> -
> -* DMA router
> -
> -DMA routers are transparent IP blocks used to route DMA request lines from
> -devices to the DMA controller. Some SoCs (like TI DRA7x) have more peripherals
> -integrated with DMA requests than what the DMA controller can handle directly.
> -
> -Required property:
> -- dma-masters:         phandle of the DMA controller or list of phandles for
> -                       the DMA controllers the router can direct the signal to.
> -- #dma-cells:          Must be at least 1. Used to provide DMA router specific
> -                       information. See DMA client binding below for more
> -                       details.
> -
> -Optional properties:
> -- dma-requests:        Number of incoming request lines the router can handle.
> -- In the node pointed by the dma-masters:
> -       - dma-requests: The router driver might need to look for this in order
> -                       to configure the routing.
> -
> -Example:
> -       sdma_xbar: dma-router@4a002b78 {
> -               compatible = "ti,dra7-dma-crossbar";
> -               reg = <0x4a002b78 0xfc>;
> -               #dma-cells = <1>;
> -               dma-requests = <205>;
> -               ti,dma-safe-map = <0>;
> -               dma-masters = <&sdma>;
> -       };
> -
> -* DMA client
> -
> -Client drivers should specify the DMA property using a phandle to the controller
> -followed by DMA controller specific data.
> -
> -Required property:
> -- dmas:                        List of one or more DMA specifiers, each consisting of
> -                       - A phandle pointing to DMA controller node
> -                       - A number of integer cells, as determined by the
> -                         #dma-cells property in the node referenced by phandle
> -                         containing DMA controller specific information. This
> -                         typically contains a DMA request line number or a
> -                         channel number, but can contain any data that is
> -                         required for configuring a channel.
> -- dma-names:           Contains one identifier string for each DMA specifier in
> -                       the dmas property. The specific strings that can be used
> -                       are defined in the binding of the DMA client device.
> -                       Multiple DMA specifiers can be used to represent
> -                       alternatives and in this case the dma-names for those
> -                       DMA specifiers must be identical (see examples).
> -
> -Examples:
> -
> -1. A device with one DMA read channel, one DMA write channel:
> -
> -       i2c1: i2c@1 {
> -               ...
> -               dmas = <&dma 2          /* read channel */
> -                       &dma 3>;        /* write channel */
> -               dma-names = "rx", "tx";
> -               ...
> -       };
> -
> -2. A single read-write channel with three alternative DMA controllers:
> -
> -       dmas = <&dma1 5
> -               &dma2 7
> -               &dma3 2>;
> -       dma-names = "rx-tx", "rx-tx", "rx-tx";
> -
> -3. A device with three channels, one of which has two alternatives:
> -
> -       dmas = <&dma1 2                 /* read channel */
> -               &dma1 3                 /* write channel */
> -               &dma2 0                 /* error read */
> -               &dma3 0>;               /* alternative error read */
> -       dma-names = "rx", "tx", "error", "error";
> +This file has been moved to dma-controller.yaml.
> --
> 2.21.0
>
