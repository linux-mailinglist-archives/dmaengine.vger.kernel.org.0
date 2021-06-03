Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB7C339A0BE
	for <lists+dmaengine@lfdr.de>; Thu,  3 Jun 2021 14:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhFCMZ5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Jun 2021 08:25:57 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44618 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbhFCMZ5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 3 Jun 2021 08:25:57 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 153CO0qS093714;
        Thu, 3 Jun 2021 07:24:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622723040;
        bh=ai1clPbxvAZw8thc0Ws/5DLpv7Z63ynOCpq+k0vWHJ0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=qiW1o0OinAOjZCA+tAlPiuxEAqh6/Gb0NxwWGp9stR39YdbRVheFCit7ODLKxWa51
         1dpsxqC0X5jKwgrSTD0ouiSZ0EqiZ+yrNGc9DN9BNvhF//Lp+BX215uRC5u7wnPk0d
         I1i/Qwtla96Kop2tx8AAfcl5DBjkEFbh0ByNZz/E=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 153CO0rS093633
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Jun 2021 07:24:00 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 3 Jun
 2021 07:24:00 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 3 Jun 2021 07:24:00 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 153CNxRY026458;
        Thu, 3 Jun 2021 07:23:59 -0500
Date:   Thu, 3 Jun 2021 17:53:58 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Rob Herring <robh@kernel.org>
CC:     Maxime Ripard <mripard@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Benoit Parrot <bparrot@ti.com>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <dmaengine@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2 15/18] media: dt-bindings: Convert Cadence CSI2RX
 binding to YAML
Message-ID: <20210603122356.7tsjb3rfmpr4p7k6@ti.com>
References: <20210526152308.16525-1-p.yadav@ti.com>
 <20210526152308.16525-16-p.yadav@ti.com>
 <20210601174519.GA666193@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210601174519.GA666193@robh.at.kernel.org>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 01/06/21 12:45PM, Rob Herring wrote:
> On Wed, May 26, 2021 at 08:53:05PM +0530, Pratyush Yadav wrote:
> > Convert the Cadence CSI2RX binding to use YAML schema.
> > 
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > 
> > ---
> > 
> > Changes in v2:
> > - New in v2.
> > 
> >  .../devicetree/bindings/media/cdns,csi2rx.txt | 100 -----------
> >  .../bindings/media/cdns,csi2rx.yaml           | 164 ++++++++++++++++++
> >  2 files changed, 164 insertions(+), 100 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/media/cdns,csi2rx.txt
> >  create mode 100644 Documentation/devicetree/bindings/media/cdns,csi2rx.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/media/cdns,csi2rx.txt b/Documentation/devicetree/bindings/media/cdns,csi2rx.txt
> > deleted file mode 100644
> > index 6b02a0657ad9..000000000000
> > --- a/Documentation/devicetree/bindings/media/cdns,csi2rx.txt
> > +++ /dev/null
> > @@ -1,100 +0,0 @@
> > -Cadence MIPI-CSI2 RX controller
> > -===============================
> > -
> > -The Cadence MIPI-CSI2 RX controller is a CSI-2 bridge supporting up to 4 CSI
> > -lanes in input, and 4 different pixel streams in output.
> > -
> > -Required properties:
> > -  - compatible: must be set to "cdns,csi2rx" and an SoC-specific compatible
> > -  - reg: base address and size of the memory mapped region
> > -  - clocks: phandles to the clocks driving the controller
> > -  - clock-names: must contain:
> > -    * sys_clk: main clock
> > -    * p_clk: register bank clock
> > -    * pixel_if[0-3]_clk: pixel stream output clock, one for each stream
> > -                         implemented in hardware, between 0 and 3
> > -
> > -Optional properties:
> > -  - phys: phandle to the external D-PHY, phy-names must be provided
> > -  - phy-names: must contain "dphy", if the implementation uses an
> > -               external D-PHY
> > -
> > -Required subnodes:
> > -  - ports: A ports node with one port child node per device input and output
> > -           port, in accordance with the video interface bindings defined in
> > -           Documentation/devicetree/bindings/media/video-interfaces.txt. The
> > -           port nodes are numbered as follows:
> > -
> > -           Port Description
> > -           -----------------------------
> > -           0    CSI-2 input
> > -           1    Stream 0 output
> > -           2    Stream 1 output
> > -           3    Stream 2 output
> > -           4    Stream 3 output
> > -
> > -           The stream output port nodes are optional if they are not
> > -           connected to anything at the hardware level or implemented
> > -           in the design.Since there is only one endpoint per port,
> > -           the endpoints are not numbered.
> > -
> > -
> > -Example:
> > -
> > -csi2rx: csi-bridge@0d060000 {
> > -	compatible = "cdns,csi2rx";
> > -	reg = <0x0d060000 0x1000>;
> > -	clocks = <&byteclock>, <&byteclock>
> > -		 <&coreclock>, <&coreclock>,
> > -		 <&coreclock>, <&coreclock>;
> > -	clock-names = "sys_clk", "p_clk",
> > -		      "pixel_if0_clk", "pixel_if1_clk",
> > -		      "pixel_if2_clk", "pixel_if3_clk";
> > -
> > -	ports {
> > -		#address-cells = <1>;
> > -		#size-cells = <0>;
> > -
> > -		port@0 {
> > -			reg = <0>;
> > -
> > -			csi2rx_in_sensor: endpoint {
> > -				remote-endpoint = <&sensor_out_csi2rx>;
> > -				clock-lanes = <0>;
> > -				data-lanes = <1 2>;
> > -			};
> > -		};
> > -
> > -		port@1 {
> > -			reg = <1>;
> > -
> > -			csi2rx_out_grabber0: endpoint {
> > -				remote-endpoint = <&grabber0_in_csi2rx>;
> > -			};
> > -		};
> > -
> > -		port@2 {
> > -			reg = <2>;
> > -
> > -			csi2rx_out_grabber1: endpoint {
> > -				remote-endpoint = <&grabber1_in_csi2rx>;
> > -			};
> > -		};
> > -
> > -		port@3 {
> > -			reg = <3>;
> > -
> > -			csi2rx_out_grabber2: endpoint {
> > -				remote-endpoint = <&grabber2_in_csi2rx>;
> > -			};
> > -		};
> > -
> > -		port@4 {
> > -			reg = <4>;
> > -
> > -			csi2rx_out_grabber3: endpoint {
> > -				remote-endpoint = <&grabber3_in_csi2rx>;
> > -			};
> > -		};
> > -	};
> > -};
> > diff --git a/Documentation/devicetree/bindings/media/cdns,csi2rx.yaml b/Documentation/devicetree/bindings/media/cdns,csi2rx.yaml
> > new file mode 100644
> > index 000000000000..ff5dd4211ac9
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/cdns,csi2rx.yaml
> > @@ -0,0 +1,164 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/media/cdns,csi2rx.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Cadence MIPI-CSI2 RX controller
> > +
> > +description: |
> > +  The Cadence MIPI-CSI2 RX controller is a CSI-2 bridge supporting up to 4 CSI
> > +  lanes in input, and 4 different pixel streams in output.
> > +
> > +maintainers:
> > +  - Pratyush Yadav <p.yadav@ti.com>
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: cdns,csi2rx
> 
> Since there has to be an SoC specific compatible, this should be:
> 
> compatible:
>   contains:
>     const: cdns,csi2rx

Ok.

> 
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    minItems: 3
> > +    maxItems: 6
> > +
> > +  clock-names:
> > +    minItems: 3
> > +    maxItems: 6
> > +    items:
> > +      - const: sys_clk # main clock
> > +      - const: p_clk # register bank clock
> > +      - const: pixel_if0_clk # pixel stream 0 output clock
> > +      - const: pixel_if1_clk # pixel stream 1 output clock
> > +      - const: pixel_if2_clk # pixel stream 2 output clock
> > +      - const: pixel_if3_clk # pixel stream 3 output clock
> > +
> > +  phys:
> > +    maxItems: 1
> > +    description: phandle to the external D-PHY
> > +
> > +  phy-names:
> > +    items:
> > +      - const: dphy
> > +
> > +  ports:
> > +    $ref: /schemas/graph.yaml#/properties/ports
> > +
> > +    properties:
> > +      port@0:
> > +        $ref: /schemas/graph.yaml#/$defs/port-base
> > +        unevaluatedProperties: false
> > +        description: CSI-2 input
> > +
> > +        properties:
> > +          endpoint:
> > +            $ref: video-interfaces.yaml#
> > +            unevaluatedProperties: false
> > +
> > +            properties:
> > +              clock-lanes:
> > +                maxItems: 1
> > +
> > +              data-lanes:
> > +                maxItems: 1
> 
> If there's only 1 lane, are you assigning between clock and data lanes? 
> If not, then there's no mapping needed.

There can be 4 data lanes, so my first thought after reading your 
message was that this should have minItems: 1 and maxItems: 4. I 
wondered why dt_binding_check never picked this up because the example 
uses 2 data lanes.

I went and looked at it a bit more. It seems like maxItems: 1 is the 
right thing to do. There will only be one element in the data-lanes 
property. The list of data lanes is a tuple with multiple members like: 
data-lanes = <1 2 3>. So we need a way to add constraints on the members 
of a tuple. I am not sure how that can be done. I need to learn more 
about JSON schema I guess (any hints welcome though ;-)

> 
> > +
> > +            required:
> > +              - clock-lanes
> > +              - data-lanes
> > +
> > +      port@1:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description: Stream 0 output
> > +
> > +      port@2:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description: Stream 1 output
> > +
> > +      port@3:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description: Stream 2 output
> > +
> > +      port@4:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description: Stream 3 output
> > +
> > +    required:
> > +      - port@0
> > +
> > +
> > +dependencies:
> > +  phys: [ 'phy-names' ]
> > +  phy-names: [ 'phys' ]
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - clock-names
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    csi2rx: csi-bridge@d060000 {
> > +      compatible = "cdns,csi2rx";
> > +      reg = <0x0d060000 0x1000>;
> > +      clocks = <&byteclock>, <&byteclock>,
> > +        <&coreclock>, <&coreclock>,
> > +        <&coreclock>, <&coreclock>;
> > +      clock-names = "sys_clk", "p_clk",
> > +              "pixel_if0_clk", "pixel_if1_clk",
> > +              "pixel_if2_clk", "pixel_if3_clk";
> > +      phys = <&dphy0>;
> > +      phy-names = "dphy";
> > +
> > +      ports {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        port@0 {
> > +          reg = <0>;
> > +
> > +          csi2rx_in_sensor: endpoint {
> > +            remote-endpoint = <&sensor_out_csi2rx>;
> > +            clock-lanes = <0>;
> > +            data-lanes = <1 2>;
> > +          };
> > +        };
> > +
> > +        port@1 {
> > +          reg = <1>;
> > +
> > +          csi2rx_out_grabber0: endpoint {
> > +            remote-endpoint = <&grabber0_in_csi2rx>;
> > +          };
> > +        };
> > +
> > +        port@2 {
> > +          reg = <2>;
> > +
> > +          csi2rx_out_grabber1: endpoint {
> > +            remote-endpoint = <&grabber1_in_csi2rx>;
> > +          };
> > +        };
> > +
> > +        port@3 {
> > +          reg = <3>;
> > +
> > +          csi2rx_out_grabber2: endpoint {
> > +            remote-endpoint = <&grabber2_in_csi2rx>;
> > +          };
> > +        };
> > +
> > +        port@4 {
> > +          reg = <4>;
> > +
> > +          csi2rx_out_grabber3: endpoint {
> > +            remote-endpoint = <&grabber3_in_csi2rx>;
> > +          };
> > +        };
> > +      };
> > +    };
> > -- 
> > 2.30.0

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
