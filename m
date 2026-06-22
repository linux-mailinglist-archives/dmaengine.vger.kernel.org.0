Return-Path: <dmaengine+bounces-11731-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iCgpFctqOWomsQcAu9opvQ
	(envelope-from <dmaengine+bounces-11731-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 19:03:07 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AE36B15C8
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 19:03:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=n7sNwPJL;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11731-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11731-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0B75305B10D
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 17:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6DB33EB17;
	Mon, 22 Jun 2026 17:00:41 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02EF1C2324;
	Mon, 22 Jun 2026 17:00:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782147641; cv=none; b=GWa9M5wCaqpAkWHtBXPspLJvScGJ/Dg13JacECBRq+8if4fYkdSl0EgEQOxRnXEBfR5XEl7reXuVUWFQIfVJ3Ms4AXkSYVDF2/zHm1s9G1OWQhEyxJzpLbMcGDjcoFDfJogfWRnzKxJhBdR1O49fKtxuwcl5dLlZNBrMUP3HD2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782147641; c=relaxed/simple;
	bh=FBPNSe4CPrmYI7tdrVEFFESNM2AQv28THAVOyYtFOEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cG9Eq6bM5k8vdeOCL3e/g2mNYtv2JCeM4ProtlQfYedGTmOI7hHmf3QLJIBfwV4/qY34kAiCzgAzZcufLsGKtk8RPdBvrA4BN3+w1iadyFENDP1W4wQxJTpfAgJkbK+oB5rfBFbc50o1UaUMJtXiJXhA5H+yZzpuyLVgV2lZGd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7sNwPJL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 179101F00A3A;
	Mon, 22 Jun 2026 17:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782147638;
	bh=FBPNSe4CPrmYI7tdrVEFFESNM2AQv28THAVOyYtFOEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=n7sNwPJLODKiRXF3ckMys9a0madlZ0QlBOjYZTx2GavzrrW3/QRmV3JeyB24/EZv3
	 BRHFAExyTS2FzXigFI8UDWdLfavBXWAuhHMrapEic0JLHIohNnMHnohCRjYK3PUPLC
	 4Rl5EYkYprfryDf3jF89EjjuImusXvrM9H0WgPgEacIMbCPAxH7oPXuWbvPZrFUBVu
	 GwWHT/ScgXSiGewELPxVxuIfWHGkNtWAVyT11/AJf0F/5CJIqeonNdRebDGYbCo6I9
	 /AClqSuz6/0yFBwwPcQVSgR49SkKXOGd0x2fQ1S9mPE6/v767IrCuv0/SsYC25QLxd
	 VRKBj0ZycUhpQ==
Date: Mon, 22 Jun 2026 18:00:32 +0100
From: Mark Brown <broonie@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Lee Jones <lee@kernel.org>, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
	dri-devel@lists.freedesktop.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH 09/11] regulator: db8500-prcmu: Remove EPOD regulators
Message-ID: <70dd1974-3360-4169-8b3a-36e7e1cc4460@sirena.org.uk>
References: <20260618-ux500-power-domains-v7-1-v1-0-eb5e50b1a588@kernel.org>
 <20260618-ux500-power-domains-v7-1-v1-9-eb5e50b1a588@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rGlF+30zJ9UqBxku"
Content-Disposition: inline
In-Reply-To: <20260618-ux500-power-domains-v7-1-v1-9-eb5e50b1a588@kernel.org>
X-Cookie: Now I am depressed ...
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.76 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-11731-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[broonie@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS(0.00)[m:linusw@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:ulfh@kernel.org,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:airlied@gmail.com,m:simona@ffwll.ch,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:lee@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:devicetree@vger.kernel.org,m:linux-pm@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:dmaengine@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,suse.de,gmail.com,ffwll.ch,lists.infradead.org,vger.kernel.org,lists.freedesktop.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sirena.org.uk:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 95AE36B15C8


--rGlF+30zJ9UqBxku
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 18, 2026 at 07:00:55AM +0200, Linus Walleij wrote:
> Remove the obsolete DB8500 PRCMU regulator drivers.

Acked-by: Mark Brown <broonie@kernel.org>

--rGlF+30zJ9UqBxku
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmo5ai8ACgkQJNaLcl1U
h9BaJwf/cE6zFilqlprukQbzoS9v80E9/7Y2JJSaiLnvW6JjSjMvkSnz7MwKRKjV
5YmmCXijisVfGbkgQLL3ad/7NkhLD//cJnPh11Mp4W8IA1IGV41qH9W5gUgwo7QE
MHb+IChEB+Ba8VSWtCqsktqI6O3TNmd/SKnnheO8g88/ldpZ+keIlYk6Ox8zVVf4
JmMuWMMFBJR2ybHy/L2ok0OshjgcUKGaQS0QpAhPBJTQ2/+NJYGliH322Y/irXhe
exF9MfFUEJDjCI6RxKMOqAp+IChlNd2l9/5zJ4xG+1jPtgdCd8g8P/WMGjdebbhB
mELR4oOXs2c5uPurZH8ILur5P+kN8w==
=UUpz
-----END PGP SIGNATURE-----

--rGlF+30zJ9UqBxku--

