Return-Path: <dmaengine+bounces-11794-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id D1L6DYFWPWpL1ggAu9opvQ
	(envelope-from <dmaengine+bounces-11794-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 18:25:37 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 246366C7762
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 18:25:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CPb2stxq;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11794-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-11794-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D4B04304CFF1
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 16:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89083E8C64;
	Thu, 25 Jun 2026 16:22:03 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB573E2751;
	Thu, 25 Jun 2026 16:22:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782404523; cv=none; b=mlLtzOwNFQNpg1a07rOjR5TWtvUf7uyaI0wsXxaHJ+Cp6qIAD8CqKdQDNJzzedMltslWlXMT4rJEumpoIx6NQRU61JLL77hALxyK0/rCyWTuU5bzYbqnDs5lxWUs371XUUhOVdnckrCocKyqTN3mhghq57VCF1aIYBwxix5S56c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782404523; c=relaxed/simple;
	bh=5F4KQo/LXvQMJy9qOTC9S3grc/gHruRxFqZpg6KBf04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n3XnusCT9MMjptJ4EPj74i5CejMxn6Jdw+EWZN6fVNjttHO76gsw2r1qMcq/PKswaidmlW/flR+oQL0ZsQdXlPgjKuiE39ygEAMopiXwYL68AdTya5NGMn+LXPX2YB8lYpL0/wllgBVSxXZg4ISr51FYj5rkgKaGT/DRfA66VLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPb2stxq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F871F000E9;
	Thu, 25 Jun 2026 16:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782404522;
	bh=5F4KQo/LXvQMJy9qOTC9S3grc/gHruRxFqZpg6KBf04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CPb2stxq2fbb5nyx10ATYrdvRljtwQNBjpQPpbtK+MDdx5+qmjvZi3vjTeKoRNsDf
	 U5nEbMn4qJKg3LoBsM1BLKS1hLFOrn+QaOM0vf3ESt1y3Rvryi+JK/oTCoJNX0bkVF
	 hZKGcF5KwypW+/Bs9zKlYxLP4D5e4UYCUQb6t5al4mZ0vMUnUV3Zxb6IScXf2OD1p8
	 e16imCYj9iYV/76yz312gV9GocAk/EO86j7p+3JiW4i1haku3JoeLoNSkK17yBIoqW
	 3awiBgZTF/0ee0CcGpUrzr2ZeoU52jpjL9SNdmNEzhzRYGOQwhcM/+JU3zRb/CSYqz
	 4kKCi2MeX95Sg==
Date: Thu, 25 Jun 2026 17:21:58 +0100
From: Conor Dooley <conor@kernel.org>
To: Suraj Gupta <suraj.gupta2@amd.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, michal.simek@amd.com,
	radhey.shyam.pandey@amd.com, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dma: xlnx,axi-dma: Restore xlnx,flush-fsync
 as u32
Message-ID: <20260625-deviator-wobble-61d333ac6f49@spud>
References: <20260625161016.1249570-1-suraj.gupta2@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xYKvzKvso3jUBxOS"
Content-Disposition: inline
In-Reply-To: <20260625161016.1249570-1-suraj.gupta2@amd.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.76 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[conor@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:suraj.gupta2@amd.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:michal.simek@amd.com,m:radhey.shyam.pandey@amd.com,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11794-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,spud:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,microchip.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 246366C7762


--xYKvzKvso3jUBxOS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--xYKvzKvso3jUBxOS
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaj1VpgAKCRB4tDGHoIJi
0hBYAQCNVVgdgCzxxO2gAoULpvUyskuiTrcqKn/RmNfGzVdb9QEA5Ne9VcnFMY3O
ywb2Y78gEz2yNU+2gRTJlDk/4KUtfg0=
=4B50
-----END PGP SIGNATURE-----

--xYKvzKvso3jUBxOS--

