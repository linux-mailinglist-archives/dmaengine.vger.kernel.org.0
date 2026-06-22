Return-Path: <dmaengine+bounces-11732-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TscCFCduOWq2sgcAu9opvQ
	(envelope-from <dmaengine+bounces-11732-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 19:17:27 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8009F6B16C7
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 19:17:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZTlltqDv;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11732-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11732-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EAE37300B181
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 17:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B1533F5AF;
	Mon, 22 Jun 2026 17:17:22 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F452E7F39;
	Mon, 22 Jun 2026 17:17:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782148642; cv=none; b=u39npyINLE2b9dDr7wKUngrlCEUsYwCi2aEGEiz0e7LCGssC44qxS0ooyAMZ6y++1ljP00ZDm1o2QBhL3cVf8sZiRunR0zG3oDFQvloYpcsV9WMl8pR1lAz5Fhzh4BCLWAXTgeAWoETa9tBPnKxLerML5EbFy3cT8WYA0BbtPo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782148642; c=relaxed/simple;
	bh=IoxRqDzW/YusH97TjyW2ECanEv4Zamve7IMGFB0B5pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmhv+fyeEWcT1c94b+j0grX4GE3i6UtjDuET03LLBeY+vDmvfD4uOaCR7chi+PceWRODvj0xw4QvUXaxxCRW3b8wViWcfJuCdbX48L0iR9bPPAtvSjaH5YjbS3lGRR+OosfTVYiWZOhfyDrdUa0F29z57Vy1kuhb4yLSHnt9PAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTlltqDv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204171F000E9;
	Mon, 22 Jun 2026 17:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782148641;
	bh=YGkyB08LSwfG3jOi5aBUi+D7lklfNHZo+RPl42buynE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZTlltqDvqyJYG3a03TZfHyc2f2P+tyf/JRiGuG4Eyfc7c/c0Dzw8NRSq0hGFoemVg
	 WjiZuXiLGZ0waoPpYAgvA5ao/Fj2Mwn7Exj2OcpMXlrumETsnsaTWK7lPkRNWpM/1D
	 dxd9KfBplpaR1w7KCjE9jLsuHt1JUV4H1dgHnTPcDMGKdsFNkhDS4AahTbcrP04OoK
	 IV3ZXBhPT0epaX2jfgMSE9hG9CNJKqxGOy3G2+0vIKvPVja+ip/moFMbCXeNGpqrWG
	 ULccuLsK33waAlSJVkGacIL5dPc/5bH0OaOb8Zv20m24n+guDjNw0lgfuGT6wP6aL+
	 VOWETkloHTafQ==
Date: Mon, 22 Jun 2026 18:17:15 +0100
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
Subject: Re: [PATCH 10/11] regulator: db8500: Add power domain regulators
Message-ID: <68c010de-8716-45c7-9d2c-71bd7dcb2410@sirena.org.uk>
References: <20260618-ux500-power-domains-v7-1-v1-0-eb5e50b1a588@kernel.org>
 <20260618-ux500-power-domains-v7-1-v1-10-eb5e50b1a588@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b4s6q5sc4PEIczEO"
Content-Disposition: inline
In-Reply-To: <20260618-ux500-power-domains-v7-1-v1-10-eb5e50b1a588@kernel.org>
X-Cookie: Now I am depressed ...
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.76 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-11732-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,sirena.org.uk:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8009F6B16C7


--b4s6q5sc4PEIczEO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 18, 2026 at 07:00:56AM +0200, Linus Walleij wrote:

> +static int db8500_regulator_get_voltage(struct regulator_dev *rdev)
> +{
> +	struct db8500_regulator_info *info = rdev_get_drvdata(rdev);
> +
> +	if (!info->desc.fixed_uV)
> +		return -EINVAL;
> +
> +	return info->desc.fixed_uV;
> +}

The core supports single fixed voltages, set desc->fixed_uV.

--b4s6q5sc4PEIczEO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmo5bhoACgkQJNaLcl1U
h9CpRQf/dOhQq9/GU7zTV3JsdHIbbJMAd7F3IoT2PBCjFzrNdXng1yds9DFZYkyO
DK8dDx608Y0kOUwZ2q0tKuuKniQ9hzyVJqvdJ93s9XvP18H08nbcVULBETg2EtBj
HnznimPSnu2TYLd1PffHpG3qzK3VZV8U2tO5ui2iu8H76IpkadTxARyvBPDFTW7B
4zzPy6zZxBCPrJz0kXzRtDEUDxVeMmgxMjgkfpYeFVrZI5Hl2G024Hww/oMODKb5
rbQZcNj5U4lKmTNdtWuozV35pk6SeARJgJhy0zyGTVU2slW/ByHUO6opXL51m/rL
1XVzYaLz8lpJkfkMjZu/YQBQKrRQ4w==
=CpDw
-----END PGP SIGNATURE-----

--b4s6q5sc4PEIczEO--

