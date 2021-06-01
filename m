Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D83139796D
	for <lists+dmaengine@lfdr.de>; Tue,  1 Jun 2021 19:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234597AbhFARrF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 1 Jun 2021 13:47:05 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:35796 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbhFARrF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 1 Jun 2021 13:47:05 -0400
Received: by mail-oi1-f173.google.com with SMTP id v22so205241oic.2;
        Tue, 01 Jun 2021 10:45:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D/RwutDeiUE8RoJ6NiieivInKsIh5wCxpSy1RciiElU=;
        b=d+BjN3tFef4zR6n7uTAPc2qwEs2Z2SRd5ciWNtgILFMTSU9rOS3DACqxE7Q+GTq6w5
         ZRF01MdXu645/rvrlYxAvMvXzXa9ox2oDM0J3DD2HiPeaybr/CQutJT1uVxCo5aiR6SU
         oS924KRxanrGFzaiLrg9rVl/y1ABRMGaFZX4yBDq2mc6n2aSDzqav25UoDhZq68GPjuX
         ouKLVyZPXDJQvbaW2l1DRx8PLC1OCa9VMzzmPWnLjp8k4xrpx7RMbsy5nyEAy6j05VBi
         Q1mKqayZ3/z6jcvMDrqiwvu/7OM2+PbtWNZ/kUuB9TPz+eli1JBFUJsqiw7NoJb3IRSZ
         WrWA==
X-Gm-Message-State: AOAM5331Us+pDrvwhnYXfeRRmBKJHT8W5VXVrHh/kUNNEelKBaCpPHm8
        DsCihmgfO0+q2VtslaRNJgKs8TGvaQ==
X-Google-Smtp-Source: ABdhPJzvNU9U33YqpbUUxKRtRnym65kpSninZ/cD0ub81YCj0r4m8yLb2ew3h563MJZYBCJh6BxCow==
X-Received: by 2002:a05:6808:1592:: with SMTP id t18mr18633949oiw.123.1622569522240;
        Tue, 01 Jun 2021 10:45:22 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z9sm3554897oog.25.2021.06.01.10.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 10:45:21 -0700 (PDT)
Received: (nullmailer pid 684833 invoked by uid 1000);
        Tue, 01 Jun 2021 17:45:19 -0000
Date:   Tue, 1 Jun 2021 12:45:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Benoit Parrot <bparrot@ti.com>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, dmaengine@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2 15/18] media: dt-bindings: Convert Cadence CSI2RX
 binding to YAML
Message-ID: <20210601174519.GA666193@robh.at.kernel.org>
References: <20210526152308.16525-1-p.yadav@ti.com>
 <20210526152308.16525-16-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526152308.16525-16-p.yadav@ti.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, May 26, 2021 at 08:53:05PM +0530, Pratyush Yadav wrote:
> Convert the Cadence CSI2RX binding to use YAML schema.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> 
> ---
> 
> Changes in v2:
> - New in v2.
> 
>  .../devicetree/bindings/media/cdns,csi2rx.txt | 100 -----------
>  .../bindings/media/cdns,csi2rx.yaml           | 164 ++++++++++++++++++
>  2 files changed, 164 insertions(+), 100 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/media/cdns,csi2rx.txt
>  create mode 100644 Documentation/devicetree/bindings/media/cdns,csi2rx.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/cdns,csi2rx.txt b/Documentation/devicetree/bindings/media/cdns,csi2rx.txt
> deleted file mode 100644
> index 6b02a0657ad9..000000000000
> --- a/Documentation/devicetree/bindings/media/cdns,csi2rx.txt
> +++ /dev/null
> @@ -1,100 +0,0 @@
> -Cadence MIPI-CSI2 RX controller
> -===============================
> -
> -The Cadence MIPI-CSI2 RX controller is a CSI-2 bridge supporting up to 4 CSI
> -lanes in input, and 4 different pixel streams in output.
> -
> -Required properties:
> -  - compatible: must be set to "cdns,csi2rx" and an SoC-specific compatible
> -  - reg: base address and size of the memory mapped region
> -  - clocks: phandles to the clocks driving the controller
> -  - clock-names: must contain:
> -    * sys_clk: main clock
> -    * p_clk: register bank clock
> -    * pixel_if[0-3]_clk: pixel stream output clock, one for each stream
> -                         implemented in hardware, between 0 and 3
> -
> -Optional properties:
> -  - phys: phandle to the external D-PHY, phy-names must be provided
> -  - phy-names: must contain "dphy", if the implementation uses an
> -               external D-PHY
> -
> -Required subnodes:
> -  - ports: A ports node with one port child node per device input and output
> -           port, in accordance with the video interface bindings defined in
> -           Documentation/devicetree/bindings/media/video-interfaces.txt. The
> -           port nodes are numbered as follows:
> -
> -           Port Description
> -           -----------------------------
> -           0    CSI-2 input
> -           1    Stream 0 output
> -           2    Stream 1 output
> -           3    Stream 2 output
> -           4    Stream 3 output
> -
> -           The stream output port nodes are optional if they are not
> -           connected to anything at the hardware level or implemented
> -           in the design.Since there is only one endpoint per port,
> -           the endpoints are not numbered.
> -
> -
> -Example:
> -
> -csi2rx: csi-bridge@0d060000 {
> -	compatible = "cdns,csi2rx";
> -	reg = <0x0d060000 0x1000>;
> -	clocks = <&byteclock>, <&byteclock>
> -		 <&coreclock>, <&coreclock>,
> -		 <&coreclock>, <&coreclock>;
> -	clock-names = "sys_clk", "p_clk",
> -		      "pixel_if0_clk", "pixel_if1_clk",
> -		      "pixel_if2_clk", "pixel_if3_clk";
> -
> -	ports {
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		port@0 {
> -			reg = <0>;
> -
> -			csi2rx_in_sensor: endpoint {
> -				remote-endpoint = <&sensor_out_csi2rx>;
> -				clock-lanes = <0>;
> -				data-lanes = <1 2>;
> -			};
> -		};
> -
> -		port@1 {
> -			reg = <1>;
> -
> -			csi2rx_out_grabber0: endpoint {
> -				remote-endpoint = <&grabber0_in_csi2rx>;
> -			};
> -		};
> -
> -		port@2 {
> -			reg = <2>;
> -
> -			csi2rx_out_grabber1: endpoint {
> -				remote-endpoint = <&grabber1_in_csi2rx>;
> -			};
> -		};
> -
> -		port@3 {
> -			reg = <3>;
> -
> -			csi2rx_out_grabber2: endpoint {
> -				remote-endpoint = <&grabber2_in_csi2rx>;
> -			};
> -		};
> -
> -		port@4 {
> -			reg = <4>;
> -
> -			csi2rx_out_grabber3: endpoint {
> -				remote-endpoint = <&grabber3_in_csi2rx>;
> -			};
> -		};
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/media/cdns,csi2rx.yaml b/Documentation/devicetree/bindings/media/cdns,csi2rx.yaml
> new file mode 100644
> index 000000000000..ff5dd4211ac9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/cdns,csi2rx.yaml
> @@ -0,0 +1,164 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/cdns,csi2rx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cadence MIPI-CSI2 RX controller
> +
> +description: |
> +  The Cadence MIPI-CSI2 RX controller is a CSI-2 bridge supporting up to 4 CSI
> +  lanes in input, and 4 different pixel streams in output.
> +
> +maintainers:
> +  - Pratyush Yadav <p.yadav@ti.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: cdns,csi2rx

Since there has to be an SoC specific compatible, this should be:

compatible:
  contains:
    const: cdns,csi2rx

> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 3
> +    maxItems: 6
> +
> +  clock-names:
> +    minItems: 3
> +    maxItems: 6
> +    items:
> +      - const: sys_clk # main clock
> +      - const: p_clk # register bank clock
> +      - const: pixel_if0_clk # pixel stream 0 output clock
> +      - const: pixel_if1_clk # pixel stream 1 output clock
> +      - const: pixel_if2_clk # pixel stream 2 output clock
> +      - const: pixel_if3_clk # pixel stream 3 output clock
> +
> +  phys:
> +    maxItems: 1
> +    description: phandle to the external D-PHY
> +
> +  phy-names:
> +    items:
> +      - const: dphy
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description: CSI-2 input
> +
> +        properties:
> +          endpoint:
> +            $ref: video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +            properties:
> +              clock-lanes:
> +                maxItems: 1
> +
> +              data-lanes:
> +                maxItems: 1

If there's only 1 lane, are you assigning between clock and data lanes? 
If not, then there's no mapping needed.

> +
> +            required:
> +              - clock-lanes
> +              - data-lanes
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: Stream 0 output
> +
> +      port@2:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: Stream 1 output
> +
> +      port@3:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: Stream 2 output
> +
> +      port@4:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: Stream 3 output
> +
> +    required:
> +      - port@0
> +
> +
> +dependencies:
> +  phys: [ 'phy-names' ]
> +  phy-names: [ 'phys' ]
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    csi2rx: csi-bridge@d060000 {
> +      compatible = "cdns,csi2rx";
> +      reg = <0x0d060000 0x1000>;
> +      clocks = <&byteclock>, <&byteclock>,
> +        <&coreclock>, <&coreclock>,
> +        <&coreclock>, <&coreclock>;
> +      clock-names = "sys_clk", "p_clk",
> +              "pixel_if0_clk", "pixel_if1_clk",
> +              "pixel_if2_clk", "pixel_if3_clk";
> +      phys = <&dphy0>;
> +      phy-names = "dphy";
> +
> +      ports {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        port@0 {
> +          reg = <0>;
> +
> +          csi2rx_in_sensor: endpoint {
> +            remote-endpoint = <&sensor_out_csi2rx>;
> +            clock-lanes = <0>;
> +            data-lanes = <1 2>;
> +          };
> +        };
> +
> +        port@1 {
> +          reg = <1>;
> +
> +          csi2rx_out_grabber0: endpoint {
> +            remote-endpoint = <&grabber0_in_csi2rx>;
> +          };
> +        };
> +
> +        port@2 {
> +          reg = <2>;
> +
> +          csi2rx_out_grabber1: endpoint {
> +            remote-endpoint = <&grabber1_in_csi2rx>;
> +          };
> +        };
> +
> +        port@3 {
> +          reg = <3>;
> +
> +          csi2rx_out_grabber2: endpoint {
> +            remote-endpoint = <&grabber2_in_csi2rx>;
> +          };
> +        };
> +
> +        port@4 {
> +          reg = <4>;
> +
> +          csi2rx_out_grabber3: endpoint {
> +            remote-endpoint = <&grabber3_in_csi2rx>;
> +          };
> +        };
> +      };
> +    };
> -- 
> 2.30.0
