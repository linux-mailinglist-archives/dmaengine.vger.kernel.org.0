Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 115222E0646
	for <lists+dmaengine@lfdr.de>; Tue, 22 Dec 2020 08:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725878AbgLVHAx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 22 Dec 2020 02:00:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgLVHAx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 22 Dec 2020 02:00:53 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9367C0613D3;
        Mon, 21 Dec 2020 23:00:12 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 822B49E6;
        Tue, 22 Dec 2020 08:00:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1608620409;
        bh=lYWlNG3hg5EQEMRIv3R8A9ky7wtOsmqZ+PHWm7X2Dq4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pfp8CWZg+6dOyHxREN3KNVBN7r6rKmyStNsacuZHCJLAI5P7xcR9s5TrQHfwJ7CBL
         3KbXfs9uiI4JVcD/+sJSHpGbafw+Rc3KoOOs1B3LfpTRPxFUHIZdST11k86YeCG/MB
         2UqjimU33MsYT1PN2ZVsgIsOCsnGih/LXnPWBJt4=
Date:   Tue, 22 Dec 2020 09:00:01 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        dri-devel@lists.freedesktop.org, dmaengine@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Drop redundant maxItems/items
Message-ID: <X+GZcXJoZ15vgxB2@pendragon.ideasonboard.com>
References: <20201222040645.1323611-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201222040645.1323611-1-robh@kernel.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Rob,

Thank you for the patch.

On Mon, Dec 21, 2020 at 09:06:45PM -0700, Rob Herring wrote:
> 'maxItems' equal to the 'items' list length is redundant. 'maxItems' is
> preferred for a single entry while greater than 1 should have an 'items'
> list.
> 
> A meta-schema check for this is pending once these existing cases are
> fixed.
> 
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jassi Brar <jaswinder.singh@linaro.org>
> Cc: dri-devel@lists.freedesktop.org
> Cc: dmaengine@vger.kernel.org
> Cc: alsa-devel@alsa-project.org
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  .../devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml    | 1 -
>  Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml   | 1 -
>  Documentation/devicetree/bindings/mailbox/arm,mhu.yaml         | 1 -
>  .../devicetree/bindings/sound/nvidia,tegra30-hda.yaml          | 2 --
>  Documentation/devicetree/bindings/usb/renesas,usb-xhci.yaml    | 1 -
>  Documentation/devicetree/bindings/usb/renesas,usbhs.yaml       | 3 ---
>  6 files changed, 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml b/Documentation/devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml
> index 7b9d468c3e52..403d57977ee7 100644
> --- a/Documentation/devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml
> +++ b/Documentation/devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml
> @@ -98,7 +98,6 @@ properties:
>      maxItems: 1
>  
>    dmas:
> -    maxItems: 4
>      items:
>        - description: Video layer, plane 0 (RGB or luma)
>        - description: Video layer, plane 1 (U/V or U)
> diff --git a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml
> index b548e4723936..c07eb6f2fc8d 100644
> --- a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml
> +++ b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml
> @@ -73,7 +73,6 @@ properties:
>      maxItems: 1
>  
>    clock-names:
> -    maxItems: 1
>      items:
>        - const: fck
>  
> diff --git a/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml b/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
> index d43791a2dde7..d07eb00b97c8 100644
> --- a/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
> +++ b/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
> @@ -61,7 +61,6 @@ properties:
>        - description: low-priority non-secure
>        - description: high-priority non-secure
>        - description: Secure
> -    maxItems: 3
>  
>    clocks:
>      maxItems: 1
> diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.yaml
> index e543a6123792..b55775e21de6 100644
> --- a/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.yaml
> +++ b/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.yaml
> @@ -44,7 +44,6 @@ properties:
>      maxItems: 3
>  
>    clock-names:
> -    maxItems: 3
>      items:
>        - const: hda
>        - const: hda2hdmi
> @@ -54,7 +53,6 @@ properties:
>      maxItems: 3
>  
>    reset-names:
> -    maxItems: 3
>      items:
>        - const: hda
>        - const: hda2hdmi
> diff --git a/Documentation/devicetree/bindings/usb/renesas,usb-xhci.yaml b/Documentation/devicetree/bindings/usb/renesas,usb-xhci.yaml
> index 0f078bd0a3e5..22603256ddf8 100644
> --- a/Documentation/devicetree/bindings/usb/renesas,usb-xhci.yaml
> +++ b/Documentation/devicetree/bindings/usb/renesas,usb-xhci.yaml
> @@ -51,7 +51,6 @@ properties:
>      maxItems: 1
>  
>    phy-names:
> -    maxItems: 1
>      items:
>        - const: usb
>  
> diff --git a/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml b/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
> index 737c1f47b7de..54c361d4a7af 100644
> --- a/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
> +++ b/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
> @@ -74,11 +74,8 @@ properties:
>  
>    phys:
>      maxItems: 1
> -    items:
> -      - description: phandle + phy specifier pair.
>  
>    phy-names:
> -    maxItems: 1
>      items:
>        - const: usb
>  

-- 
Regards,

Laurent Pinchart
