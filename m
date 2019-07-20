Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AACE56EE97
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jul 2019 11:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfGTJYZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 20 Jul 2019 05:24:25 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:51571 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbfGTJYZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 20 Jul 2019 05:24:25 -0400
X-Originating-IP: 91.163.65.175
Received: from localhost (91-163-65-175.subs.proxad.net [91.163.65.175])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id C3495C0005;
        Sat, 20 Jul 2019 09:24:21 +0000 (UTC)
Date:   Sat, 20 Jul 2019 11:24:21 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/3] dt-bindings: dma: Add YAML schemas for the generic
 DMA bindings
Message-ID: <20190720092421.bqbsyrk3atejqgsf@flea>
References: <20190720064123.15411-1-maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="s3wrpdsnzbasx2vv"
Content-Disposition: inline
In-Reply-To: <20190720064123.15411-1-maxime.ripard@bootlin.com>
User-Agent: NeoMutt/20180716
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--s3wrpdsnzbasx2vv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jul 20, 2019 at 08:41:21AM +0200, Maxime Ripard wrote:
> The DMA controllers and consumers have a bunch of generic properties that
> are needed in a device tree. Add a YAML schemas for those.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
>
> ---
>
> Changes from v1:
>   - Dropped the dma consumer schemas
>   - Fixed the node name of the examples
>   - Enhanced a bit the description for dma-requests in case of a router
>   - Split the bindings in two to handle the router and controller case
>     separately
>   - Made #dma-cells required
> ---
>  .../devicetree/bindings/dma/dma-common.yaml   |  43 +++++++
>  .../bindings/dma/dma-controller.yaml          |  35 ++++++
>  .../devicetree/bindings/dma/dma-router.yaml   |  50 ++++++++
>  Documentation/devicetree/bindings/dma/dma.txt | 114 +-----------------
>  4 files changed, 129 insertions(+), 113 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/dma-common.yaml
>  create mode 100644 Documentation/devicetree/bindings/dma/dma-controller.yaml
>  create mode 100644 Documentation/devicetree/bindings/dma/dma-router.yaml
>
> diff --git a/Documentation/devicetree/bindings/dma/dma-common.yaml b/Documentation/devicetree/bindings/dma/dma-common.yaml
> new file mode 100644
> index 000000000000..422fd6c8b0ce
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/dma-common.yaml
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/dma-common.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: DMA Engine Generic Binding
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
> +  "#dma-cells":
> +    minimum: 1
> +    # Should be enough
> +    maximum: 255
> +    description:
> +      Used to provide DMA controller specific information.

We need a select statement here, otherwise it will try to validate
every node and report dma-cells as missing. I'll send a v3.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--s3wrpdsnzbasx2vv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXTLdvgAKCRDj7w1vZxhR
xdEIAP9SpwDUkxDQ+DapyYxUkorj6+UJDJBYRlJBNOXYMiAgfQEAxr4NNseBz5i8
bXSG0DZSuo0iCBaU3l1PDEiGg26h2Qo=
=aOju
-----END PGP SIGNATURE-----

--s3wrpdsnzbasx2vv--
