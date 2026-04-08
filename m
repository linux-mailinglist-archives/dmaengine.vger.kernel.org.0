Return-Path: <dmaengine+bounces-9942-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADJLAG6S1mmiGQgAu9opvQ
	(envelope-from <dmaengine+bounces-9942-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Apr 2026 19:37:50 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BBA3BFAD2
	for <lists+dmaengine@lfdr.de>; Wed, 08 Apr 2026 19:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7B18B303FC11
	for <lists+dmaengine@lfdr.de>; Wed,  8 Apr 2026 17:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0833D8139;
	Wed,  8 Apr 2026 17:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGkJ6eD4"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7BF3D6697;
	Wed,  8 Apr 2026 17:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775669704; cv=none; b=KSoCWVO3KcQ7asOALGMTbm+BOMKgM8M6XfX2vLrzUyFS1irLlaTS23s8SKm4f7fxHqkGs5d4eAw//G5UrY046PKBYvO4LE88CxX0Zh+pYtUc4qcTtILZDdR4w/HblGU7rt+r5Swqqs5NZw4ce2h/yS7cKfjJgwu/RnwDNbcGdXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775669704; c=relaxed/simple;
	bh=vQZDsXvdKb4qZKHoorIJk0+4gRZtoacbSshFkGdTfuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CjeJ0rWtoTXnfLmE/GOhf+ZPHlhFSSX7bGlC9sFbfvvTsiiGeh/V0vhdlovrqwNS1tIZuw8x9hkZaMelfnNiTTgavH9HY2/Dj0ZFRCfc0vWtEPzSdKWe8DBFaw5KFYbnRmqe4WIlsKbJDHnISaH5tiYbO0ilQ8b8P/RrCMXmGTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGkJ6eD4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC7ADC19421;
	Wed,  8 Apr 2026 17:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775669703;
	bh=vQZDsXvdKb4qZKHoorIJk0+4gRZtoacbSshFkGdTfuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IGkJ6eD46f1b1N59NzXFZ9zDrrYMNEtA9XWvlaVzyj9+HQIJslH5SBRFiFt7O+bZn
	 F6SPdFYxpM5rxmtfLvgcslI1cUVQQqs4khsmp1x5WAlEAR7MAen/9wBa3RVJ4QjqGx
	 1rDtOR3DMbEsFxp11qp22OGnnjDArXgUh7v42PmShMEpUs6MfJrzrkpq5O74FS8Wb6
	 WYLW42EPIGkhjM8Gu52X07yLSdzMG4fApxYFSmvjIK980NCy2apfpEib7tr6InRgO4
	 bfxSkc3iqy7ZAKM1H7Y+rs/ci88Z0DoIQDdHeK4gQj+dabSdM94dWxXI8xVqpwVcAK
	 5qNUnhtStWeig==
Date: Wed, 8 Apr 2026 18:34:58 +0100
From: Mark Brown <broonie@kernel.org>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, lgirdwood@gmail.com,
	perex@perex.cz, tiwai@suse.com, biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com, p.zabel@pengutronix.de,
	geert+renesas@glider.be, fabrizio.castro.jz@renesas.com,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v3 14/15] ASoC: renesas: rz-ssi: Use generic PCM
 dmaengine APIs
Message-ID: <030d76fa-12e2-4f3d-a1e8-3767e06915d0@sirena.org.uk>
References: <20260407133507.887404-1-claudiu.beznea.uj@bp.renesas.com>
 <20260407133507.887404-15-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="E2GqxnW5i02drv+Z"
Content-Disposition: inline
In-Reply-To: <20260407133507.887404-15-claudiu.beznea.uj@bp.renesas.com>
X-Cookie: Often things ARE as bad as they seem!
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9942-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,renesas.com:email,sirena.org.uk:mid]
X-Rspamd-Queue-Id: 96BBA3BFAD2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--E2GqxnW5i02drv+Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 07, 2026 at 04:35:06PM +0300, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> On Renesas RZ/G2L and RZ/G3S SoCs (where this was tested), captured audio
> files occasionally contained random spikes when viewed with a tool such
> as Audacity. These spikes were also audible as popping noises.

Acked-by: Mark Brown <broonie@kernel.org>

--E2GqxnW5i02drv+Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnWkcEACgkQJNaLcl1U
h9DNGQf/Spe5zItmC1xdBVTfIOGFsFpnHkAXgNuUHtIF4XoGE+yBrDTFbxBpz0vu
u537HAL/Aht+56pVWMYNZ4kfn4RD/4ydXnzBMoxDVRcIL5Q59nosWH2IX45/XuBs
s+I4xImUJ1tnlRfMr/FrFKUXapg7lR/BGNnhP+zr3ZLkxE7ZvXtCmPnQrV/sNKdl
XF2D8EGYUEjc/oU1IsMBkbJqsXlohFhiqxD4QN4nKjCbaMEBcKFtB7TlAaJi1sbU
L106vUryOF/2K/0LjyCTmZCBKaqyAWceok7gop7LYnZbi3aREKOfX8iIeTUouVrp
EN5HHQ1Di7VebLbCFvyLo8xpTT6N7w==
=s/Ub
-----END PGP SIGNATURE-----

--E2GqxnW5i02drv+Z--

