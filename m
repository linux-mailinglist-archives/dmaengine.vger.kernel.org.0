Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE174700FDC
	for <lists+dmaengine@lfdr.de>; Fri, 12 May 2023 22:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238993AbjELUl5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 12 May 2023 16:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239005AbjELUly (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 12 May 2023 16:41:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442C6D87C;
        Fri, 12 May 2023 13:41:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F4FF654A9;
        Fri, 12 May 2023 20:41:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB64FC433EF;
        Fri, 12 May 2023 20:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683924061;
        bh=hP3d31o2Uy1uHcmbEyykVGmp60JVpaN4LTk0Cw67skw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=feEOWvMCfpoBTqrGYf2YvtPdar2YHXgGCd+lYjkncsiE3Evs0KMmH7uL6OQ68ZyGd
         vQEjq14hHuFQBi2kXz5YOh7xhmJgEyGfOLZRZM9ZOMeRp3jox4DI1PTkkum7p4q+ss
         8ZKIRkuyRUWzngOmQ/2re/kRzQrnKCnagCly2AEkBj6HfQkVew6tXXafBn2fz6hQ63
         kyoYG3h3gsMKu/cvpH295DvhUzFzkpCwDkf9y7pEWfTet5tE+6eN4JeqqK0Wwhvyx+
         MpHqlT9PC+vyxyko1afXkHd8ho4MuYWJl45Ush+sfNQJaQnxXp7UbHp/k8Iqe3NdII
         LS6NMF2K9ZrJA==
Date:   Fri, 12 May 2023 21:40:56 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Michal Simek <michal.simek@amd.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Conor Dooley <conor+dt@kernel.org>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] dt-bindings: dma: xilinx: Add power-domains to
 xlnx,zynqmp-dpdma
Message-ID: <20230512-urging-entrust-4cfe21b362dc@spud>
References: <8f5651634df338743f95a7253a741f9ddc92487d.1683891609.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dwj8cU9gNpq12C/4"
Content-Disposition: inline
In-Reply-To: <8f5651634df338743f95a7253a741f9ddc92487d.1683891609.git.michal.simek@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--dwj8cU9gNpq12C/4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 12, 2023 at 01:40:33PM +0200, Michal Simek wrote:
> DP DMA has own power domain that's why describe required power-domain
> property.
>=20
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>=20
> Changes in v3:
> - make power-domains as required property
> - also update commit message
>=20
> Changes in v2:
> - rewrite commit message - requested by Krzysztof
>=20
> The commit b06112cd5e08 ("arm64: dts: zynqmp: Add power domain for the
> DisplayPort DMA controller") added this property already in Linux that's
> why the patch is also fixing dts_check warnings.
>=20
> In v2 I got ack from Krzysztof but not adding it because of additional
> discussion about required property in v3.
> https://lore.kernel.org/r/029ba923-d13e-ea7c-018d-95e179dda2e5@linaro.org

It was not entirely clear reading that whether the driver actually
functions correctly if the property is omitted.
Is it the case that if the property is omitted, and the power domain
controller driver is enabled, that the dma controller will not operate
correctly?
If I am understanding correctly, it very much does sound like it
should be listed as required, so:
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

>=20
> ---
>  .../devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml   | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpd=
ma.yaml b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.ya=
ml
> index d6cbd95ec26d..2128f4645c98 100644
> --- a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml
> +++ b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml
> @@ -41,6 +41,9 @@ properties:
>    clock-names:
>      const: axi_clk
> =20
> +  power-domains:
> +    maxItems: 1
> +
>  required:
>    - "#dma-cells"
>    - compatible
> @@ -48,12 +51,14 @@ required:
>    - interrupts
>    - clocks
>    - clock-names
> +  - power-domains
> =20
>  additionalProperties: false
> =20
>  examples:
>    - |
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/power/xlnx-zynqmp-power.h>
> =20
>      dma: dma-controller@fd4c0000 {
>        compatible =3D "xlnx,zynqmp-dpdma";
> @@ -63,6 +68,7 @@ examples:
>        clocks =3D <&dpdma_clk>;
>        clock-names =3D "axi_clk";
>        #dma-cells =3D <1>;
> +      power-domains =3D <&zynqmp_firmware PD_DP>;
>      };
> =20
>  ...
> --=20
> 2.36.1
>=20

--dwj8cU9gNpq12C/4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZF6kWAAKCRB4tDGHoIJi
0kCmAP4pWHJt5dVzjarDpG7i4yvQm2I+n6YRflOinEHa8n0SlQEA3s/Qm+/y5iKZ
flaLeEDOHLlBvm3gwiZ9iG+fKv7cagE=
=TAVP
-----END PGP SIGNATURE-----

--dwj8cU9gNpq12C/4--
