Return-Path: <dmaengine+bounces-9679-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJ9FCk9/xWkk+wQAu9opvQ
	(envelope-from <dmaengine+bounces-9679-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 19:47:43 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA1E33A5D1
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 19:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C79D930432F4
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 18:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD3639FCDF;
	Thu, 26 Mar 2026 18:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLQ8s2Ys"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4735D288CA3;
	Thu, 26 Mar 2026 18:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774550083; cv=none; b=FO012ERhgBqTnWvKVgPaAjZJM/pIEzfmyWwCbxX9TkIPXNzXEne2iuCR7D1eKRmzyhc6T/W0vMiVmnbk2ClMPpIbZwpYuvgL0lJfr/ARttqgoM2lkEmN7NrrZgbXzZnR0Ljzn4U4rx2jkjdbvYDKOs2I7oy0dKNZ+VUyu8qUpH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774550083; c=relaxed/simple;
	bh=+WFhHAP+I6U56ZY1SPoQXhOLT+bdcm5oHSlV3lm2fRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AmHB+gFBIok+m/Y7Ubt0ETEhYQNvLq56BuqJACvQkZsJ5wsqw4a7TNWBtpmWRhOZrqALdg9yjnpDUrKu7sEWwbPSofT2NoQp/7r23An4WrGhpCN+vD4zK7+b9A+pQcK9OVuroCHMXx8Wl4cQhlb269GgeBklAx5KyFvbaowouus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLQ8s2Ys; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 588ACC116C6;
	Thu, 26 Mar 2026 18:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774550083;
	bh=+WFhHAP+I6U56ZY1SPoQXhOLT+bdcm5oHSlV3lm2fRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YLQ8s2Ys1REk6EW7Qhg3mlYZf3hKzj8IindqDfPFSPV9j2xX5TipAVNqRAUNL+Wea
	 x4Y0N8d3LK8wCT2DArdswnWLaR795pWrpELuTVswjw2gttc7K7J4eNtCdjcjpqbJlz
	 yK/HKpZlVj7Z37+hYHahAhIkr6dwVwIfBpaLT3hLCoQEgAeJNgF7DSLH3zUsKsCDi2
	 ckkp3Xk9BU37wOBORGkLpHEm38eeWkBZRrpzO5xlZPT4MNuBpD4kU3BAl74GVvgSo5
	 NsK/KDCX/pTx8/NsY9pHgcp5u+/sfcKA5UVl8fiQSP8dqqxQ67uoL7JcWFreNn9cnY
	 ZF0JxhevI/KOQ==
Date: Thu, 26 Mar 2026 18:34:37 +0000
From: Conor Dooley <conor@kernel.org>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yixun Lan <dlan@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Guodong Xu <guodong@riscstar.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 2/7] dt-bindings: dmaengine: Add SpacemiT K3 DMA
 compatible string
Message-ID: <20260326-explode-surplus-24c0e0813099@spud>
References: <20260326-k3-pdma-v2-0-ca94ca7bb595@linux.spacemit.com>
 <20260326-k3-pdma-v2-2-ca94ca7bb595@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3c5c3SbeQ5J8Cvcr"
Content-Disposition: inline
In-Reply-To: <20260326-k3-pdma-v2-2-ca94ca7bb595@linux.spacemit.com>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9679-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 7FA1E33A5D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--3c5c3SbeQ5J8Cvcr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 04:17:17PM +0800, Troy Mitchell wrote:
> From: Guodong Xu <guodong@riscstar.com>
>=20
> Add k3 compatible string.

That's obvious. What you need to explain is why it is not compatible with
the existing k1.
pw-bot: changes-requested
Cheers,
Conor.

>=20
> Signed-off-by: Guodong Xu <guodong@riscstar.com>
> Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> ---
>  Documentation/devicetree/bindings/dma/spacemit,k1-pdma.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/dma/spacemit,k1-pdma.yaml =
b/Documentation/devicetree/bindings/dma/spacemit,k1-pdma.yaml
> index ec06235baf5c..62ce6d81526b 100644
> --- a/Documentation/devicetree/bindings/dma/spacemit,k1-pdma.yaml
> +++ b/Documentation/devicetree/bindings/dma/spacemit,k1-pdma.yaml
> @@ -14,7 +14,9 @@ allOf:
> =20
>  properties:
>    compatible:
> -    const: spacemit,k1-pdma
> +    enum:
> +      - spacemit,k1-pdma
> +      - spacemit,k3-pdma
> =20
>    reg:
>      maxItems: 1
>=20
> --=20
> 2.53.0
>=20

--3c5c3SbeQ5J8Cvcr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCacV8PQAKCRB4tDGHoIJi
0iSJAQCYik/5JNh07McaFHFAtO7PKvqeDrCRfWwv0LzCc+MAOQD+I6kaG8JvSER/
6z5GZ8MFkLGErIBUFMmIqZJuwKZldAo=
=sPth
-----END PGP SIGNATURE-----

--3c5c3SbeQ5J8Cvcr--

