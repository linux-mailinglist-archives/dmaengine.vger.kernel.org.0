Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B87E7D6F50
	for <lists+dmaengine@lfdr.de>; Wed, 25 Oct 2023 16:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbjJYOMc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 Oct 2023 10:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234937AbjJYOMb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 25 Oct 2023 10:12:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BF0191;
        Wed, 25 Oct 2023 07:12:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B295C433C7;
        Wed, 25 Oct 2023 14:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698243146;
        bh=q8F2mFd6CImLzNK99x7rHDG+F1bVa1gJCgNVAIBLG/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fa2CjzMmnPB1Vv5v/Pj+OQfsAWkGvN3dFH2tb5BEpfxZMBT11FWppbZPhXnuKKCAo
         rEwTYJmjaj7cwFStsB0PBCQZq+Z0hV25Kz4qfJ9reXiVVSsJ0QapbtZ5PqK+1KzlT6
         VkPg0YH1xriRN7GlydwW2Gv9QeuFIRKS7MM8cbWfz8z79Z9M05A+AyiFLt2SF6Wy94
         ccqqFHYWiDwlX4OKAccp5W/zFZ3NKn1xh7BCXkrfw1KE8E3i64YortLQocPE0s6kPI
         8bE8GX0n+FJuim5VtjYXs25em/+oaM4oL2gAsQYsaPtanJ5Qk0sB1pjQD0JWas6ru7
         gLwz9f17C1NVA==
Date:   Wed, 25 Oct 2023 15:12:20 +0100
From:   Conor Dooley <conor@kernel.org>
To:     shravan chippa <shravan.chippa@microchip.com>
Cc:     green.wan@sifive.com, vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, conor+dt@kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        nagasuresh.relli@microchip.com, praveen.kumar@microchip.com
Subject: Re: [PATCH v3 4/4] riscv: dts: microchip: add specific compatible
 for mpfs' pdma
Message-ID: <20231025-pang-unstuffed-4d8bf48baf21@spud>
References: <20231025102251.3369472-1-shravan.chippa@microchip.com>
 <20231025102251.3369472-5-shravan.chippa@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qwZ+jMYzinWm1SqJ"
Content-Disposition: inline
In-Reply-To: <20231025102251.3369472-5-shravan.chippa@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--qwZ+jMYzinWm1SqJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 03:52:51PM +0530, shravan chippa wrote:
> From: Shravan Chippa <shravan.chippa@microchip.com>
>=20
> Add specific compatible for PolarFire SoC for The SiFive PDMA driver
>=20

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
> ---
>  arch/riscv/boot/dts/microchip/mpfs.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/boot/dts/microchip/mpfs.dtsi b/arch/riscv/boot/dt=
s/microchip/mpfs.dtsi
> index 104504352e99..f43486e9a090 100644
> --- a/arch/riscv/boot/dts/microchip/mpfs.dtsi
> +++ b/arch/riscv/boot/dts/microchip/mpfs.dtsi
> @@ -221,7 +221,7 @@ plic: interrupt-controller@c000000 {
>  		};
> =20
>  		pdma: dma-controller@3000000 {
> -			compatible =3D "sifive,fu540-c000-pdma", "sifive,pdma0";
> +			compatible =3D "microchip,mpfs-pdma", "sifive,pdma0";
>  			reg =3D <0x0 0x3000000 0x0 0x8000>;
>  			interrupt-parent =3D <&plic>;
>  			interrupts =3D <5 6>, <7 8>, <9 10>, <11 12>;
> --=20
> 2.34.1
>=20

--qwZ+jMYzinWm1SqJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTkiRAAKCRB4tDGHoIJi
0sEJAQCHzvvzlWORtnYlb+uw/EMYHDQckws0ffM81OhwMCFujAD/bvpu5fSldrSt
ZlX/mfkXv0hoIFwpIi4+lGF8Y7p/Jgw=
=ip81
-----END PGP SIGNATURE-----

--qwZ+jMYzinWm1SqJ--
