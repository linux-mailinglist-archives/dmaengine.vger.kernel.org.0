Return-Path: <dmaengine+bounces-10981-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPC6Gy0JF2pB2AcAu9opvQ
	(envelope-from <dmaengine+bounces-10981-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 27 May 2026 17:09:33 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF105E6980
	for <lists+dmaengine@lfdr.de>; Wed, 27 May 2026 17:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AF6FD3075AEB
	for <lists+dmaengine@lfdr.de>; Wed, 27 May 2026 14:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D413426EB3;
	Wed, 27 May 2026 14:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="av2//UI8"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DF5428462;
	Wed, 27 May 2026 14:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779893906; cv=none; b=NGfrfdgZm2oUhiYoaHPfa+bjXfNZVX+wdUktN53j+6QXhI1U36ufrDR38qHXL1wDM5SP21uGaC63UqSM4auuysmE9t9HpnyBTlJHBtRn/bjpBXZpxtwI2OyFMeJPbOCS8IgakOTEE61oF0aTVPnlBZtq9hWq4hksL9u/e1qCi3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779893906; c=relaxed/simple;
	bh=MRLICiZ+rjJsed3vguC9Zgv35Sc8atS94GZHY7uBqqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jqwwd+6vq7yT9uKrzXylHDpXEvIX+PaBnWFz5se3S25AtJ/Hg5q488VNARqv/yNpnd3Qhb2rssJ5nB8RYVYXbnaPu59AA3g4i4eUFlyaJ5H6N6QCveokXPJiKNzErIxs1Cxgxz5UNZIGSpCVdAwOXplDrfnU8RvThZVHoJ4b9yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=av2//UI8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72AF81F000E9;
	Wed, 27 May 2026 14:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779893904;
	bh=DHo3mmxyjC2BUGhmNPlIkKerVXLTLbx5FTRg7KoVcyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=av2//UI8EGTCsbZTUGHUlnE0Z/GwLivyUm0f8dAiq5HnFkRLuFoWMEwX36j6CLIm4
	 rL00g5qKGdf6zTfLg42uSKXet6AAvDhD1PXtocJqBR8Us6EyZCncdQC3ZvkvIDvbbC
	 O/7rpY4GDCIbqpvPgRlmWTH9Q0vX7QgiZXYxs/hXBmZaPJRiM0/nERMbAJY+YKxGle
	 j7hYyyBz89zB9IGadqSvaLiYMgq0zQK2J++nJPJ7BLgEbj5h5vsQEwJ/epyrmna86B
	 HgrO0feq7RMiBDWDBz+SOAgrYwQsCPTZSSNEnlkPCTapeCvw6SSo5MvP0wUA3p2Uje
	 Ylx4IiftvnZEw==
Date: Wed, 27 May 2026 15:58:20 +0100
From: Conor Dooley <conor@kernel.org>
To: CL Wang <cl634@andestech.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, kees@kernel.org,
	gustavoars@kernel.org, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, tim609@andestech.com
Subject: Re: [PATCH v3 1/3] dt-bindings: dmaengine: Add support for
 ATCDMAC300 DMA engine
Message-ID: <20260527-lazy-rimless-eb6e8f159aa9@spud>
References: <20260527132815.1211195-1-cl634@andestech.com>
 <20260527132815.1211195-2-cl634@andestech.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XtUveJaYn/QeRoGU"
Content-Disposition: inline
In-Reply-To: <20260527132815.1211195-2-cl634@andestech.com>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10981-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devicetree.org:url,microchip.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6CF105E6980
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--XtUveJaYn/QeRoGU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 09:28:13PM +0800, CL Wang wrote:
> Document devicetree bindings for Andes ATCDMAC300 DMA engine
>=20
> ATCDMAC300 is the IP name, which is embedded in AndesCore-based
> platforms or SoCs such as AE350 and Qilai.
>=20
> Signed-off-by: CL Wang <cl634@andestech.com>
>=20
> ---
>   Changes for v3:
>     - Rename DT binding file from andestech,qilai-dma.yaml to
>       andestech,ae350-dma.yaml
>     - Deprecate IP-core-based compatible usage and align with
>       SoC/platform-based
>     - Dropped Acked-by tag from Conor Dooley due to the above change.
> ---
>  .../bindings/dma/andestech,ae350-dma.yaml     | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/andestech,ae350=
-dma.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/dma/andestech,ae350-dma.ya=
ml b/Documentation/devicetree/bindings/dma/andestech,ae350-dma.yaml
> new file mode 100644
> index 000000000000..0f5ffdf1d160
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/andestech,ae350-dma.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/andestech,ae350-dma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Andes ATCDMAC300 DMA Controller
> +
> +maintainers:
> +  - CL Wang <cl634@andestech.com>
> +
> +allOf:
> +  - $ref: dma-controller.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - andestech,qilai-dma
> +          - const: andestech,ae350-dma
> +      - const: andestech,ae350-dma
> +
> +  reg:
> +    minItems: 1
> +    maxItems: 2
> +    description:
> +      First entry is the DMA controller register range (required).
> +      Second entry is the cache control in IOCP controller (optional).

This can be an items list FYI. Syntax is
reg:
  minItems: 1
  items:
    - description: foo
    - description: bar

Fix that and you can re-add my ack
Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: changes-requested

--XtUveJaYn/QeRoGU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCahcGjAAKCRB4tDGHoIJi
0sIbAQC97jy6WNEB4GXyd9hiuJ2x13THdVio1JcQ5/ZcvUN/OAD/Z69K8zj2+32t
ZFKkk2MhZP/biASRh38BsVR0Adl/mAA=
=9boa
-----END PGP SIGNATURE-----

--XtUveJaYn/QeRoGU--

