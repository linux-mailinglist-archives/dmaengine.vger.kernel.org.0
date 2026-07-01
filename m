Return-Path: <dmaengine+bounces-11933-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LCmbFxFJRWpM+AoAu9opvQ
	(envelope-from <dmaengine+bounces-11933-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 19:06:25 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0666F0276
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 19:06:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="f/w4hSph";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11933-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11933-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8427D3004C35
	for <lists+dmaengine@lfdr.de>; Wed,  1 Jul 2026 16:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC79379C5E;
	Wed,  1 Jul 2026 16:59:27 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED38372064;
	Wed,  1 Jul 2026 16:59:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782925167; cv=none; b=OpxtkbhBl5ynkocIGN8lSFgYvuYthOgtF41G0/EHJFgUUvLU1qrQd28K8MxKh81Y4wHqjtzViEYTWL7EtwtkmGVGqhfLpFP5DFaw987Ojw+C39fNjbGG8N0lIG/TGqvIy/1GxvFxNvER8x+v9c1ybUw5L6Y8TrIfpWoKno+rcNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782925167; c=relaxed/simple;
	bh=IrFZsnUmW0yIArlQLTrgfC5aQins48K9v6hYbAT2Tl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVTs2ac5Bsp92a79YPzIhbhmqzLoLnhsPwb54eLIeP1VbJ3LYd7SIp8yq0gRhtdcChgmXZ+1X0vPBGMOlgsk+jdgGxpWsXRiT+kaliOOWGnMqrX6HNevaAg1eI09xIt/SsqzBMdTunlpbUv5Ck7vtMVqgyp4ozz/XxFfZichKpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/w4hSph; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA861F000E9;
	Wed,  1 Jul 2026 16:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782925166;
	bh=IrFZsnUmW0yIArlQLTrgfC5aQins48K9v6hYbAT2Tl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=f/w4hSphSkhrF275HYBKpE3cR+xWiEZ6Grf+3aTfW9XXs7R0IzjxQdU0iZc9POURe
	 I4//UBTHXLfdBFJ1R1WNUouug6IAbNvaAkfdt4hqzriT3dtdeZW+CBASufQCich8/U
	 iix2Y1E+qWlNTh3oR8ag9en4qbl70CYHtavF2Xqp3l5g9ZySLDqjLzm86/W0k6UlpM
	 kBna67CTm73CFdyaZQOCIk1c8OWQ5VwXLys/qw2iHzAQZByoYacrUvjP3PAqtdRBTT
	 /D6XlIe/T/UuzEZ+t6s91f1oDe3E0ftrJ6kRHSgwJSjS68V5WGLi3jNgf0O2sDPij9
	 ZpJqFtEeJOabg==
Date: Wed, 1 Jul 2026 17:59:21 +0100
From: Conor Dooley <conor@kernel.org>
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: Sean Wang <sean.wang@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Long Cheng <long.cheng@mediatek.com>, kernel@collabora.com,
	dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dma: mediatek,uart-dma: add support for
 MT8189 SoC
Message-ID: <20260701-escargot-unearth-233b3f1da093@spud>
References: <20260701-mt8189-dt-bindings-uart-dma-v1-1-c7106216a40d@collabora.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LiqYd8uyhb+nmNno"
Content-Disposition: inline
In-Reply-To: <20260701-mt8189-dt-bindings-uart-dma-v1-1-c7106216a40d@collabora.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.76 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11933-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[conor@kernel.org,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_RECIPIENTS(0.00)[m:louisalexis.eyraud@collabora.com,m:sean.wang@mediatek.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:long.cheng@mediatek.com,m:kernel@collabora.com,m:dmaengine@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[mediatek.com,kernel.org,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DB0666F0276

--LiqYd8uyhb+nmNno
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--LiqYd8uyhb+nmNno
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCakVHaQAKCRB4tDGHoIJi
0iAeAQDw8UZ2gVBadrMgzz0CFwnC6zMw9K3G93fmyHt5QjKqawD8CT22JOXLwJgl
07e428SiKjL2teJ4dkqvY5MIihGKSgQ=
=8VBS
-----END PGP SIGNATURE-----

--LiqYd8uyhb+nmNno--

