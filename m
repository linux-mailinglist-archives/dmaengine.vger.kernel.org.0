Return-Path: <dmaengine+bounces-44-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 861D57E031D
	for <lists+dmaengine@lfdr.de>; Fri,  3 Nov 2023 13:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 406112819F5
	for <lists+dmaengine@lfdr.de>; Fri,  3 Nov 2023 12:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1E116435;
	Fri,  3 Nov 2023 12:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhSq3YzN"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40378473;
	Fri,  3 Nov 2023 12:46:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F8CEC433C7;
	Fri,  3 Nov 2023 12:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699015581;
	bh=it+Ur90waa0oim08aoAhpIaY4KZFUL1HCU6OwZvCS/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OhSq3YzN9otpUbZjupxrkxUum2SOI8/ixCfg/TcXthjyIqz0QXU67ZZyjbiXUUtIH
	 xi8mjd9LTIIXG3VSv8aO+mG3v6ouLi3QmJuaT+yny3JqPH/HIwJ79WAmCTO6EE9Ywl
	 /H0blyzj93vLYrG3WkxWWdrbtzZ51SyzT30t4S2d+br46+Tp8zhv4P1h3EiuSB4wle
	 nPpmb4jhJ8TkiZKdoPcx/NQzWRepNeO7S8BYA2si+AiOWW+ewRZNVT11+w6gQKyIvk
	 kWCMzuZM2g9tcH3kJzj9NkiUPhS8OIfFMxreT28Q8yKSL7LP5U2oAQkSQiM9uPvxAo
	 q8We0ynRvRMCQ==
Date: Fri, 3 Nov 2023 12:46:16 +0000
From: Conor Dooley <conor@kernel.org>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] dt-bindings: dma: rz-dmac: Document RZ/Five SoC
Message-ID: <20231103-depress-dispersed-c5965a853c8a@spud>
References: <20231102203922.548353-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="d4uRiJ5fk19L4hXt"
Content-Disposition: inline
In-Reply-To: <20231102203922.548353-1-prabhakar.mahadev-lad.rj@bp.renesas.com>


--d4uRiJ5fk19L4hXt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 02, 2023 at 08:39:22PM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> The DMAC block on the RZ/Five SoC is identical to one found on the RZ/G2UL
> SoC. "renesas,r9a07g043-dmac" compatible string will be used on the
> RZ/Five SoC so to make this clear, update the comment to include RZ/Five
> SoC.
>=20
> No driver changes are required as generic compatible string
> "renesas,rz-dmac" will be used as a fallback on RZ/Five SoC.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml b=
/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> index c284abc6784a..a42b6a26a6d3 100644
> --- a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> +++ b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> @@ -16,7 +16,7 @@ properties:
>    compatible:
>      items:
>        - enum:
> -          - renesas,r9a07g043-dmac # RZ/G2UL
> +          - renesas,r9a07g043-dmac # RZ/G2UL and RZ/Five

Possibly the most unnecessary ack I've given to date, but
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

>            - renesas,r9a07g044-dmac # RZ/G2{L,LC}
>            - renesas,r9a07g054-dmac # RZ/V2L
>        - const: renesas,rz-dmac
> --=20
> 2.34.1
>=20

--d4uRiJ5fk19L4hXt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZUTrmAAKCRB4tDGHoIJi
0gzIAP9omTAPzecIsVU2EmGnnXwI4uLH2ZAEbuainbbgWH4eYQD7BEzDVcYB3ioD
IcCHf+Ye7G5eM1gLWF6LWdJTEmfi9wg=
=NqOm
-----END PGP SIGNATURE-----

--d4uRiJ5fk19L4hXt--

