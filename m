Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD5F3529AE
	for <lists+dmaengine@lfdr.de>; Fri,  2 Apr 2021 12:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbhDBKYM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 2 Apr 2021 06:24:12 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:44926 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbhDBKYM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 2 Apr 2021 06:24:12 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5FD252C1;
        Fri,  2 Apr 2021 12:24:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1617359049;
        bh=tkld6UVERd3oCk44uMV+QIoIlJrSO79ZF4RjmGPJcxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iDm4EHpTx7uiNiABVNQbYuQZYE51oww2XBlvvVgvfvaZpgNm3HVdyjit3iSTvQVu7
         to/Cdzu8WZ4K1g4PbxinpFsto/U5AAWvYnkXOaQcSwOdJ3fklD7txo7uIUUs5UXaXH
         wdytP3eBHRN9xwptHjLnvmAmOaY0oixWKC4RGY5I=
Date:   Fri, 2 Apr 2021 13:23:25 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Benoit Parrot <bparrot@ti.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Alexandre Courbot <acourbot@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Helen Koike <helen.koike@collabora.com>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Peter Chen <peter.chen@nxp.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        dmaengine@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: Re: [PATCH 14/16] dt-bindings: phy: Convert Cadence DPHY binding to
 YAML
Message-ID: <YGbwnTNiL6WYoxPF@pendragon.ideasonboard.com>
References: <20210330173348.30135-1-p.yadav@ti.com>
 <20210330173348.30135-15-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210330173348.30135-15-p.yadav@ti.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Pratyush,

Thank you for the patch.

On Tue, Mar 30, 2021 at 11:03:46PM +0530, Pratyush Yadav wrote:
> Convert Cadence DPHY binding to YAML.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> ---
>  .../devicetree/bindings/phy/cdns,dphy.txt     | 20 --------
>  .../devicetree/bindings/phy/cdns,dphy.yaml    | 51 +++++++++++++++++++
>  2 files changed, 51 insertions(+), 20 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/phy/cdns,dphy.txt
>  create mode 100644 Documentation/devicetree/bindings/phy/cdns,dphy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/cdns,dphy.txt b/Documentation/devicetree/bindings/phy/cdns,dphy.txt
> deleted file mode 100644
> index 1095bc4e72d9..000000000000
> --- a/Documentation/devicetree/bindings/phy/cdns,dphy.txt
> +++ /dev/null
> @@ -1,20 +0,0 @@
> -Cadence DPHY
> -============
> -
> -Cadence DPHY block.
> -
> -Required properties:
> -- compatible: should be set to "cdns,dphy".
> -- reg: physical base address and length of the DPHY registers.
> -- clocks: DPHY reference clocks.
> -- clock-names: must contain "psm" and "pll_ref".
> -- #phy-cells: must be set to 0.
> -
> -Example:
> -	dphy0: dphy@fd0e0000{
> -		compatible = "cdns,dphy";
> -		reg = <0x0 0xfd0e0000 0x0 0x1000>;
> -		clocks = <&psm_clk>, <&pll_ref_clk>;
> -		clock-names = "psm", "pll_ref";
> -		#phy-cells = <0>;
> -	};
> diff --git a/Documentation/devicetree/bindings/phy/cdns,dphy.yaml b/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
> new file mode 100644
> index 000000000000..d1bbf96a8250
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/cdns,dphy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cadence DPHY Device Tree Bindings
> +
> +maintainers:
> +  - Pratyush Yadav <p.yadav@ti.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: cdns,dphy
> +
> +  reg:
> +    maxItems: 1
> +    description: Physical base address and length of the DPHY registers.

You can drop the description.

> +
> +  clocks:
> +    maxItems: 2
> +    description: DPHY reference clocks.

It's best to describe individual items, which will then allow dropping
the maxItems property:

  clocks:
    items:
      - description: Description of the psm clock
      - description: Description of the pll_ref clock

> +
> +  clock-names:
> +    items:
> +      - const: psm
> +      - const: pll_ref
> +
> +  "#phy-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - "#phy-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +
> +    dphy0: dphy@fd0e0000{

This is copied verbatim from the existing description, but while at it,
I'd rename the node from dphy@... to phy@..., as DT node are supposed to
be named according to the class of devices, not the specific device
type.

With these small issues addressed,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +        compatible = "cdns,dphy";
> +        reg = <0xfd0e0000 0x1000>;
> +        clocks = <&psm_clk>, <&pll_ref_clk>;
> +        clock-names = "psm", "pll_ref";
> +        #phy-cells = <0>;
> +    };

-- 
Regards,

Laurent Pinchart
