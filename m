Return-Path: <dmaengine+bounces-10380-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MiWCgxeA2qE5QEAu9opvQ
	(envelope-from <dmaengine+bounces-10380-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 19:06:20 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD7E5256C5
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 19:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B52CA305663C
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 16:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCF63D5C10;
	Tue, 12 May 2026 16:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXGjvPJ8"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868E33D0C00;
	Tue, 12 May 2026 16:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778605048; cv=none; b=Sc9iTE6OiFPuA6Gt+5tjxR7towDSNxfM5kJTHU+O+NMWeNlyuyCzftVZ6tVz0/smWGYqtbVkPYblsFZiJOx3jOUk2vexUWRnmQC/4/oHIFPgjhxljN7Umke8VZMdcFNoYYSoGv0+OpSTL1I7xyQIzMB4VEiKJMrbJbpMIGs/QWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778605048; c=relaxed/simple;
	bh=zQgnsAnbOUnV0Z18dbHGn7S65VpWXuaQb4J/vp+qMTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SEDyP2pq73OajSUIlFgW18zu8M6bpQa9DZwK3p4JzAHHvTuSzZzV2aERG8ZEnljlwcBqR6l9UOLfXnuCP9H4eMl1um3mJdwBnHnyy74A/OjPS/CQ/G94MJ95wk+V/utpHoudtecNvaucKicjXlby3CsxjRQYaP7tiUvhQYhKplQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXGjvPJ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C88EC2BCB0;
	Tue, 12 May 2026 16:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778605048;
	bh=zQgnsAnbOUnV0Z18dbHGn7S65VpWXuaQb4J/vp+qMTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nXGjvPJ85nYR64f3RYSlct3Z8PEyqwIBsLDolAjbgYm77ty69cYgpnKjOnSYHTXuB
	 u72AlRHulJ+XFi5QR5ya/znUH8NHqzFDZ739DT2Vs6rZCCPpUP6HGDti0XmScQmvkr
	 0z74l3rNyk5lroHdIPldtLHqoNILGk1n3tHt+wV09IvkeJrPU2DVFcSuQi8CGMbcJL
	 79Q/0DXTclNL/sBBNkiIdM4/QDSHbsh/0v5lbYfu3FT+pT0PZg+WyZQoo/5k1i1mO8
	 h0TjVAhbuNihHqdisYm9cGRIZUzUMAKcvKvXFqc9Hugeqx2KWAaVY6HhOxVft5cbDH
	 rCJgsHwUD+y9g==
Date: Tue, 12 May 2026 17:57:22 +0100
From: Conor Dooley <conor@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Longbin Li <looong.bin@gmail.com>, Yixun Lan <dlan@kernel.org>,
	"Anton D. Stavinskii" <stavinsky@gmail.com>,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, sophgo@lists.linux.dev,
	linux-riscv@lists.infradead.org, Yixun Lan <dlan@gentoo.org>
Subject: Re: [PATCH v6 1/2] dt-bindings: dma: snps,dw-axi-dmac: Add fallback
 compatible for CV1800B
Message-ID: <20260512-shudder-repressed-204473e32978@spud>
References: <20260511063818.463877-1-inochiama@gmail.com>
 <20260511063818.463877-2-inochiama@gmail.com>
 <20260511-crave-sworn-3b43371ce11a@spud>
 <agJSPkA88GcTYS86@inochi.infowork>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TsyhsMpKyZFWvNGP"
Content-Disposition: inline
In-Reply-To: <agJSPkA88GcTYS86@inochi.infowork>
X-Rspamd-Queue-Id: BDD7E5256C5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10380-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[synopsys.com,kernel.org,outlook.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,gentoo.org];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,microchip.com:email]
X-Rspamd-Action: no action


--TsyhsMpKyZFWvNGP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 06:04:36AM +0800, Inochi Amaoto wrote:
> On Mon, May 11, 2026 at 05:01:01PM +0100, Conor Dooley wrote:
> > On Mon, May 11, 2026 at 02:38:16PM +0800, Inochi Amaoto wrote:
> > > The previous version of the binding change only add compatible
> > > string without adding the fallback compatible, this breaks
> > > backward compatibility. Add the needed fallback compatible to
> > > fix this.
> >=20
> > I don't understand how adding a specific comaptible affected backwards
> > compatibility. Did the dts originally use the snps compatible before the
> > device specific one was added?
> >=20
>=20
> Yes, the device is already in DTS, and since I find an quirk for
> it. A new compatible with fallback is necessary.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--TsyhsMpKyZFWvNGP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCagNb8QAKCRB4tDGHoIJi
0m2jAQCCqdHTz8+DIxjGnMEK5qAR/BRwBOVIK/8wBLWhokLAUQD/YpQVzxp7MkA/
PQAEfkisMNOAv29mXwapa7xQ+VTiUQw=
=LsvR
-----END PGP SIGNATURE-----

--TsyhsMpKyZFWvNGP--

