Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1EC5304BFC
	for <lists+dmaengine@lfdr.de>; Tue, 26 Jan 2021 23:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbhAZVy0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 Jan 2021 16:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbhAZVtt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 26 Jan 2021 16:49:49 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDC5C06174A;
        Tue, 26 Jan 2021 13:49:08 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E62C42C1;
        Tue, 26 Jan 2021 22:49:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1611697745;
        bh=LplyXulbPXrXuvaecCE9pwLK5CV2NpJXldimMYOoU6E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W5/JirBumHHDqY8/gvtF3HYkNqVMRlR2q/gwb6T+0GKqE+Hlwe0nKg+FmiSr08ciu
         raxqEasMbRLTDaeUYnn8GtEQF9vC3jDgNdAsynIjWFZIGAmh7x+VZ4DC/Sr8JfvFL4
         v+CvCAq4bMDsWtr8s49i7m/hTQQ2OWWkzqAqlrG4=
Date:   Tue, 26 Jan 2021 23:48:45 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: renesas,rcar-dmac: Add r8a779a0
 support
Message-ID: <YBCOPXTh8n4Tk0+y@pendragon.ideasonboard.com>
References: <20210125142431.1049668-1-geert+renesas@glider.be>
 <20210125142431.1049668-2-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210125142431.1049668-2-geert+renesas@glider.be>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Mon, Jan 25, 2021 at 03:24:28PM +0100, Geert Uytterhoeven wrote:
> Document the compatible value for the Direct Memory Access Controller
> blocks in the Renesas R-Car V3U (R8A779A0) SoC.
> 
> The most visible difference with DMAC blocks on other R-Car SoCs is the
> move of the per-channel registers to a separate register block.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> v2:
>   - Add Reviewed-by.
> ---
>  .../bindings/dma/renesas,rcar-dmac.yaml       | 76 ++++++++++++-------
>  1 file changed, 48 insertions(+), 28 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml
> index c07eb6f2fc8d2f12..7f2a54bc732d3a19 100644
> --- a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml
> +++ b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml
> @@ -14,34 +14,37 @@ allOf:
>  
>  properties:
>    compatible:
> -    items:
> -      - enum:
> -          - renesas,dmac-r8a7742  # RZ/G1H
> -          - renesas,dmac-r8a7743  # RZ/G1M
> -          - renesas,dmac-r8a7744  # RZ/G1N
> -          - renesas,dmac-r8a7745  # RZ/G1E
> -          - renesas,dmac-r8a77470 # RZ/G1C
> -          - renesas,dmac-r8a774a1 # RZ/G2M
> -          - renesas,dmac-r8a774b1 # RZ/G2N
> -          - renesas,dmac-r8a774c0 # RZ/G2E
> -          - renesas,dmac-r8a774e1 # RZ/G2H
> -          - renesas,dmac-r8a7790  # R-Car H2
> -          - renesas,dmac-r8a7791  # R-Car M2-W
> -          - renesas,dmac-r8a7792  # R-Car V2H
> -          - renesas,dmac-r8a7793  # R-Car M2-N
> -          - renesas,dmac-r8a7794  # R-Car E2
> -          - renesas,dmac-r8a7795  # R-Car H3
> -          - renesas,dmac-r8a7796  # R-Car M3-W
> -          - renesas,dmac-r8a77961 # R-Car M3-W+
> -          - renesas,dmac-r8a77965 # R-Car M3-N
> -          - renesas,dmac-r8a77970 # R-Car V3M
> -          - renesas,dmac-r8a77980 # R-Car V3H
> -          - renesas,dmac-r8a77990 # R-Car E3
> -          - renesas,dmac-r8a77995 # R-Car D3
> -      - const: renesas,rcar-dmac
> -
> -  reg:
> -    maxItems: 1
> +    oneOf:
> +      - items:
> +          - enum:
> +              - renesas,dmac-r8a7742  # RZ/G1H
> +              - renesas,dmac-r8a7743  # RZ/G1M
> +              - renesas,dmac-r8a7744  # RZ/G1N
> +              - renesas,dmac-r8a7745  # RZ/G1E
> +              - renesas,dmac-r8a77470 # RZ/G1C
> +              - renesas,dmac-r8a774a1 # RZ/G2M
> +              - renesas,dmac-r8a774b1 # RZ/G2N
> +              - renesas,dmac-r8a774c0 # RZ/G2E
> +              - renesas,dmac-r8a774e1 # RZ/G2H
> +              - renesas,dmac-r8a7790  # R-Car H2
> +              - renesas,dmac-r8a7791  # R-Car M2-W
> +              - renesas,dmac-r8a7792  # R-Car V2H
> +              - renesas,dmac-r8a7793  # R-Car M2-N
> +              - renesas,dmac-r8a7794  # R-Car E2
> +              - renesas,dmac-r8a7795  # R-Car H3
> +              - renesas,dmac-r8a7796  # R-Car M3-W
> +              - renesas,dmac-r8a77961 # R-Car M3-W+
> +              - renesas,dmac-r8a77965 # R-Car M3-N
> +              - renesas,dmac-r8a77970 # R-Car V3M
> +              - renesas,dmac-r8a77980 # R-Car V3H
> +              - renesas,dmac-r8a77990 # R-Car E3
> +              - renesas,dmac-r8a77995 # R-Car D3
> +          - const: renesas,rcar-dmac
> +
> +      - items:
> +          - const: renesas,dmac-r8a779a0 # R-Car V3U
> +
> +  reg: true
>  
>    interrupts:
>      minItems: 9
> @@ -110,6 +113,23 @@ required:
>    - power-domains
>    - resets
>  
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - renesas,dmac-r8a779a0
> +then:
> +  properties:
> +    reg:
> +      items:
> +        - description: Base register block
> +        - description: Channel register block
> +else:
> +  properties:
> +    reg:
> +      maxItems: 1
> +
>  additionalProperties: false
>  
>  examples:

-- 
Regards,

Laurent Pinchart
