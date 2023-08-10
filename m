Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4600A77804C
	for <lists+dmaengine@lfdr.de>; Thu, 10 Aug 2023 20:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235012AbjHJSf1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Aug 2023 14:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjHJSf1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Aug 2023 14:35:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2605D2712;
        Thu, 10 Aug 2023 11:35:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7697B65995;
        Thu, 10 Aug 2023 18:35:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFA41C433C7;
        Thu, 10 Aug 2023 18:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691692524;
        bh=xfjlfRaVHyNDxaHERql/K3X32fbh27hAOake+ptYZtk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PRUXEURoDnrQd5HHCHEg5XvLTan1NlCqYygvEFGt28td5BeCZMuvF+wOG0JZ9b3Ou
         YQKkS0ikkyLHecHlViA059WbPzNvh8LisUMpybBBx8joViZV7Tf1b3N/TcXXAdjEMX
         wknA+NtG+UQKxj69wDDYvePCdbgsB52oeEATnrIyJNMrCbtQmruDuIE6gtkufoTeSq
         oUoq+acwwW/oX7kZjLtGTpypouVEXEcjSTqoLkPw/PoH7j66ESbDM4JuX8K7lc3BLe
         jr4qDXbi8sUVR/hzoqf4iiXZVWmpU16lZz1MCuT2pEhKfQ+AoopeGVkcxHiNq0qB6x
         LvsqGfF4lgd1w==
Date:   Thu, 10 Aug 2023 19:35:20 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: dma: ti: k3-bcdma: Describe cfg
 register regions
Message-ID: <20230810-prelaw-payback-9388222dd6d3@spud>
References: <20230810174356.3322583-1-vigneshr@ti.com>
 <20230810174356.3322583-2-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hy+rd1947X41UhRn"
Content-Disposition: inline
In-Reply-To: <20230810174356.3322583-2-vigneshr@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--hy+rd1947X41UhRn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 10, 2023 at 11:13:53PM +0530, Vignesh Raghavendra wrote:
> Block copy DMA(BCDMA)module on K3 SoCs have ring cfg, TX and RX
> channel cfg register regions which are usually configured by a Device
> Management firmware. But certain entities such as bootloader (like
> U-Boot) may have to access them directly. Describe this region in the
> binding documentation for completeness of module description.
>=20
> Keep the binding compatible with existing DTS files by requiring first
> five regions to be present at least.
>=20
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  .../devicetree/bindings/dma/ti/k3-bcdma.yaml  | 25 +++++++++++++------
>  1 file changed, 17 insertions(+), 8 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml b/Doc=
umentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
> index 4ca300a42a99..d166e284532b 100644
> --- a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
> +++ b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
> @@ -37,11 +37,11 @@ properties:
> =20
>    reg:
>      minItems: 3
> -    maxItems: 5
> +    maxItems: 8

How come none of these reg entries have a description? What
differentiates a "gcfg" from a "cfg" for example?

> =20
>    reg-names:
>      minItems: 3
> -    maxItems: 5
> +    maxItems: 8
> =20
>    "#dma-cells":
>      const: 3
> @@ -161,14 +161,19 @@ allOf:
>        properties:
>          reg:
>            minItems: 5
> +          maxItems: 8
> =20
>          reg-names:
> +          minItems: 5
>            items:
>              - const: gcfg
>              - const: bchanrt
>              - const: rchanrt
>              - const: tchanrt
>              - const: ringrt
> +            - const: cfg
> +            - const: tchan
> +            - const: rchan
> =20
>        required:
>          - ti,sci-rm-range-bchan
> @@ -216,12 +221,16 @@ examples:
>              main_bcdma: dma-controller@485c0100 {
>                  compatible =3D "ti,am64-dmss-bcdma";
> =20
> -                reg =3D <0x0 0x485c0100 0x0 0x100>,
> -                      <0x0 0x4c000000 0x0 0x20000>,
> -                      <0x0 0x4a820000 0x0 0x20000>,
> -                      <0x0 0x4aa40000 0x0 0x20000>,
> -                      <0x0 0x4bc00000 0x0 0x100000>;
> -                reg-names =3D "gcfg", "bchanrt", "rchanrt", "tchanrt", "=
ringrt";
> +                reg =3D <0x00 0x485c0100 0x00 0x100>,

Why have you added extra zeros? (0x00)

Thanks,
Conor.

> +                      <0x00 0x4c000000 0x00 0x20000>,
> +                      <0x00 0x4a820000 0x00 0x20000>,
> +                      <0x00 0x4aa40000 0x00 0x20000>,
> +                      <0x00 0x4bc00000 0x00 0x100000>,
> +                      <0x00 0x48600000 0x00 0x8000>,
> +                      <0x00 0x484a4000 0x00 0x2000>,
> +                      <0x00 0x484c2000 0x00 0x2000>;
> +                reg-names =3D "gcfg", "bchanrt", "rchanrt", "tchanrt", "=
ringrt",
> +                            "cfg", "tchan", "rchan";
>                  msi-parent =3D <&inta_main_dmss>;
>                  #dma-cells =3D <3>;
> =20
> --=20
> 2.41.0
>=20

--hy+rd1947X41UhRn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNUt6AAKCRB4tDGHoIJi
0s88AP9ckxn/7qNPWkQ0s/NJZZQvBPDQh/iTfduUH9NmovrdigD/S+xmMkFsCX2w
YXPFIUnSv9qL4bpWzkUCGGmOXW8bOg0=
=pc+/
-----END PGP SIGNATURE-----

--hy+rd1947X41UhRn--
