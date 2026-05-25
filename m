Return-Path: <dmaengine+bounces-10882-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qF3/IrmAFGqnNwcAu9opvQ
	(envelope-from <dmaengine+bounces-10882-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 19:02:49 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F347C5CD1F0
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 19:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D31E5301389B
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 17:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F2D37FF5F;
	Mon, 25 May 2026 17:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3jII8hr"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877D1296BD2;
	Mon, 25 May 2026 17:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779728565; cv=none; b=qzUm5Y+v5wqP/slTFbra84nvSbmEmWmhYnWvF0stX7ZcJ7NazrZKyGFkjgHiX3HEH7Jy2mLNd2+UbqsiiZ7u2BC/y52SDD1LI1xlvVCPomxkrqBjyO6KCF+ug/XCisUWJlPQso1UQ7fyeYPVJWs/dyJSKKkt9mkoZsBmtlklvQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779728565; c=relaxed/simple;
	bh=dmES4eRVPot78YiCdGqnycIjk82FC6rNrzAMMbYNBW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jd1cWNYyT37FOpsaWMA36wUZZTB2wLM1EDwCwCVvgr6y004AkMjgZfnqkNVYqzRogs+WRveid7Vd42tPUt4jaIiLxKhhtaBsWRU/rVg0mDJq6pUE874KJNN8jNHUlYLwkN4pNsXtlgdCcFSRg0W0FlcgsyGZCePgWofcucc5VkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3jII8hr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8366B1F000E9;
	Mon, 25 May 2026 17:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779728564;
	bh=GwPeMjic3Th7i5kOyvfSWg6LXy21REeh4Cn2CKuk7SY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K3jII8hrQMeLGBHyEplOafrFd237M0ao4WnKdYpFTIafa84KPZlpCpZcBnDN6wqXJ
	 4ZWUkn2NgD0xwzkqd7yBnd4hRA1QFYCmTo8Pp//rIyN1gp5h3XasD0O/DSwI6T5h0H
	 0B1OgDEX9Mc0azTSQY1QJ2n4Q3BfX1it7NEJ08yTbFnH2xRufyZTMvlkgmdA6w9SUB
	 o5es6K537mCRAxJDu6D2BeF7sH8iFKi2yotSDJOcEDzijM3ib0HvMgySdDDEJ3ZsO4
	 jAbV5ZNdOxQ9CgEciKvx03bqqT5OXaAY/RUoYUFbAZWbnhOqDI+fbPpwZ8DArSQ2dU
	 90IPjtIs1hXmA==
Date: Mon, 25 May 2026 18:02:40 +0100
From: Conor Dooley <conor@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Golla Nagendra <nagendra.golla@amd.com>, devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org, robh@kernel.org, vkoul@kernel.org,
	Frank.Li@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: dma: xilinx: Add optional resets
 property for ZDMA
Message-ID: <20260525-petition-yogurt-27f2999d4968@spud>
References: <20260525105042.2249542-2-nagendra.golla@amd.com>
 <20260525110025.E5A6A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cz5aGclJT9zaVrfA"
Content-Disposition: inline
In-Reply-To: <20260525110025.E5A6A1F00A3A@smtp.kernel.org>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10882-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,amd.com:email]
X-Rspamd-Queue-Id: F347C5CD1F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--cz5aGclJT9zaVrfA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 11:00:25AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] The `resets` property is added globally without conditional co=
nstraints, allowing it to pass validation on older SoCs that do not support=
 it in hardware.
> --
>=20
> commit 832c482914e7639cb1a410d061bf9d631b41ae68
> Author: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
>=20
> dt-bindings: dma: xilinx: Add optional resets property for ZDMA
>=20
> This commit adds an optional resets property for ZDMA on newer SoCs like
> Versal Gen2 and Versal-Net. Older SoCs do not have a reset line provision.
>=20
> > diff --git a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-d=
ma-1.0.yaml b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-=
1.0.yaml
> > index 2da86037ad79e..dff16763e11b9 100644
> > --- a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.=
yaml
> > +++ b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.=
yaml
> > @@ -56,6 +56,9 @@ properties:
> >    iommus:
> >      maxItems: 1
> > =20
> > +  resets:
> > +    maxItems: 1
> > +
>=20
> [Severity: Medium]
> The commit message notes that older SoCs do not support this reset line.
> Since the resets property is added to the top-level properties block, will
> this allow device trees for older hardware to erroneously define a reset =
line
> and silently pass validation?
>=20
> Should this be guarded by an allOf conditional block restricting the rese=
ts
> property to the newer hardware compatible strings?

Additionally, should it be required on the new platforms?


Either way,
pw-bot: changes-requested


>=20
> >    power-domains:
> >      maxItems: 1
>=20
> --=20
> Sashiko AI review =B7 https://sashiko.dev/#/patchset/20260525105042.22495=
42-1-nagendra.golla@amd.com?part=3D1

--cz5aGclJT9zaVrfA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCahSAsAAKCRB4tDGHoIJi
0vScAQCDUZYTHy5y++xcAAKjjtZ9MX9q2pMxK17KEBLlYtlzQgEAwBVwMquD97EL
O0TT81zmra87DbBuPwPtQCkd1ZJaugQ=
=CJIC
-----END PGP SIGNATURE-----

--cz5aGclJT9zaVrfA--

