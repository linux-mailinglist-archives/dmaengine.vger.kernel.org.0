Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA6CFB140
	for <lists+dmaengine@lfdr.de>; Wed, 13 Nov 2019 14:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfKMNYa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 Nov 2019 08:24:30 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35100 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbfKMNYa (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 13 Nov 2019 08:24:30 -0500
Received: by mail-oi1-f196.google.com with SMTP id n16so1755350oig.2;
        Wed, 13 Nov 2019 05:24:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UdUwgi/Z598oAywZUsvitg46KvJjV1+JNbxQsild5s0=;
        b=r2k/xdbh+j9StNmrHhm7Ilxh9o78l/Y11Ohmdh7NKiHuv80z6arYdq24SGy7Za7y39
         l3PEDEXPq9JNPKj+EBUITDTyTb6kMNuwsUp4hAgpZ+W/jQaeNfdgsdstWaSXLhel4xcc
         3ig+bqjULRsTTapHU1JI386RX3OGa5sLKLP7nBwGefas/AEHauoXsJAgxW60KmwetRbx
         Uqahd2PxPASpJCpoSaYcZQpwNQcS4hmO5ZXL3g33LX8s6Bc8pLGsuS8xLgp/tIH4bRLe
         N8RBQShMXvjjP6l92aDF050cYVJmOZZm79zkWe/BVJ+5Yxn0uuvl77NxdfK80VaiQ+6N
         x8Lg==
X-Gm-Message-State: APjAAAWga00K8d8hD5ZSklt8KjNLLISbp6d1M1xiOmDTn8rjT7n86Hv5
        jP32Z4ECRfj69p6jEB1VOw6yq6w=
X-Google-Smtp-Source: APXvYqxNPNSYrdrd91ycPVbcewYxneN8b9VqGJ+eOzurTYTlJhzd3AsGAYLLO2DjkbtFH7NZKBYhmw==
X-Received: by 2002:aca:3ac6:: with SMTP id h189mr3615919oia.177.1573651469483;
        Wed, 13 Nov 2019 05:24:29 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 47sm702659otu.37.2019.11.13.05.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 05:24:28 -0800 (PST)
Date:   Wed, 13 Nov 2019 07:24:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     dmaengine@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt: bindings: dma: xilinx: dpdma: DT bindings for
 Xilinx DPDMA
Message-ID: <20191113132428.GA15957@bogus>
References: <20191107021400.16474-1-laurent.pinchart@ideasonboard.com>
 <20191107021400.16474-2-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107021400.16474-2-laurent.pinchart@ideasonboard.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Nov 07, 2019 at 04:13:57AM +0200, Laurent Pinchart wrote:
> The ZynqMP includes the DisplayPort subsystem with its own DMA engine
> called DPDMA. The DPDMA IP comes with 6 individual channels
> (4 for display, 2 for audio). This documentation describes DT bindings
> of DPDMA.
> 
> Signed-off-by: Hyun Kwon <hyun.kwon@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> Changes since v1:
> 
> - Convert the DT bindings to YAML
> - Drop the DT child nodes
> ---
>  .../dma/xilinx/xlnx,zynqmp-dpdma.yaml         | 68 +++++++++++++++++++
>  MAINTAINERS                                   |  8 +++
>  include/dt-bindings/dma/xlnx-zynqmp-dpdma.h   | 16 +++++
>  3 files changed, 92 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml
>  create mode 100644 include/dt-bindings/dma/xlnx-zynqmp-dpdma.h
> 
> diff --git a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml
> new file mode 100644
> index 000000000000..b677b2c4f302
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: GPL-2.0

For new bindings:

# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/xlnx,zynqmp-dpdma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx ZynqMP DisplayPort DMA Controller Device Tree Bindings
> +
> +description: |
> +  These bindings describe the DMA engine included in the Xilinx ZynqMP
> +  DisplayPort Subsystem. The DMA engine supports up to 6 DMA channels (3
> +  channels for a video stream, 1 channel for a graphics stream, and 2 channels
> +  for an audio stream).
> +
> +maintainers:
> +  - Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> +
> +allOf:
> +  - $ref: "dma-controller.yaml#"
> +
> +properties:
> +  "#dma-cells":
> +    const: 1
> +    description: |
> +      The cell is the DMA channel ID (see dt-bindings/dma/xlnx-zynqmp-dpdma.h
> +      for a list of channel IDs).
> +
> +  compatible:
> +    const: xlnx,zynqmp-dpdma
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    description: The AXI clock
> +    maxItems: 1
> +
> +  clock-names:
> +    const: axi_clk
> +
> +required:
> +  - "#dma-cells"
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    dma: dma-controller@fd4c0000 {
> +      compatible = "xlnx,zynqmp-dpdma";
> +      reg = <0x0 0xfd4c0000 0x0 0x1000>;
> +      interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
> +      interrupt-parent = <&gic>;
> +      clocks = <&dpdma_clk>;
> +      clock-names = "axi_clk";
> +      #dma-cells = <1>;
> +    };
> +
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cba1095547fd..457b39bc2320 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17898,6 +17898,14 @@ F:	drivers/misc/Kconfig
>  F:	drivers/misc/Makefile
>  F:	include/uapi/misc/xilinx_sdfec.h
>  
> +XILINX ZYNQMP DPDMA DRIVER
> +M:	Hyun Kwon <hyun.kwon@xilinx.com>
> +M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> +L:	dmaengine@vger.kernel.org
> +S:	Supported
> +F:	Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml
> +F:	include/dt-bindings/dma/xlnx-zynqmp-dpdma.h
> +
>  XILLYBUS DRIVER
>  M:	Eli Billauer <eli.billauer@gmail.com>
>  L:	linux-kernel@vger.kernel.org
> diff --git a/include/dt-bindings/dma/xlnx-zynqmp-dpdma.h b/include/dt-bindings/dma/xlnx-zynqmp-dpdma.h
> new file mode 100644
> index 000000000000..3719cda5679d
> --- /dev/null
> +++ b/include/dt-bindings/dma/xlnx-zynqmp-dpdma.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> +/*
> + * Copyright 2019 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> + */
> +
> +#ifndef __DT_BINDINGS_DMA_XLNX_ZYNQMP_DPDMA_H__
> +#define __DT_BINDINGS_DMA_XLNX_ZYNQMP_DPDMA_H__
> +
> +#define ZYNQMP_DPDMA_VIDEO0		0
> +#define ZYNQMP_DPDMA_VIDEO1		1
> +#define ZYNQMP_DPDMA_VIDEO2		2
> +#define ZYNQMP_DPDMA_GRAPHICS		3
> +#define ZYNQMP_DPDMA_AUDIO0		4
> +#define ZYNQMP_DPDMA_AUDIO1		5
> +
> +#endif /* __DT_BINDINGS_DMA_XLNX_ZYNQMP_DPDMA_H__ */
> -- 
> Regards,
> 
> Laurent Pinchart
> 
