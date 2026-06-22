Return-Path: <dmaengine+bounces-11720-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RhFIO28WOWqCmgcAu9opvQ
	(envelope-from <dmaengine+bounces-11720-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 13:03:11 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D835A6AEEEB
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 13:03:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cUuWXWvv;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11720-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-11720-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D573B3009388
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 11:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE75379C20;
	Mon, 22 Jun 2026 11:03:04 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388C13793A9;
	Mon, 22 Jun 2026 11:03:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782126184; cv=none; b=TguU/ZOYzIAiDTGRMJEtv6E6yJUkwPXo7NUlOXCztLHSIRbVOkyPsGUti2f4KzaG3rHyoiR5uBhblAQdZuqYlHMURPQfiNJE453OrR6UCIDHgmmx8OXei4kMwQTae714Pi6KPXZ2/kHEmGPaiFmGkFEry64KiipPtdqdCbw2p5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782126184; c=relaxed/simple;
	bh=soCCb/qqcor7YOsqcDgZpD4kqOQExcgQHIU/hxZoPnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMyXcg6IC/xvXxZhLHjdAhgqRsXTAjMnTP6YCtn5v1CtujqHe/kz4lU5SN08+RnXF/++EjOCi7LPApotJE7RvkOS3Hg5+6fbvDHT7svzGyu0rI5ZpToVZNOakcThitgDRiG6yQ1+/1npKJE134ChLE4M04OzyilPLmv3/qAIovU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUuWXWvv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3BBF1F000E9;
	Mon, 22 Jun 2026 11:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782126182;
	bh=soCCb/qqcor7YOsqcDgZpD4kqOQExcgQHIU/hxZoPnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cUuWXWvvFScX3vy2Lk1wKqpow2Zs9ZYXoikPy5C6W5tbFCu2SRdG3YnaiOsAKg//4
	 dFIXSXeDBzxwCXrwPWi3qwz6kSEubHpik5M5VKneb/zCcrPxN+TSkxFwQtyZDNKsm1
	 BjDXupe4EH+0dGL16Uswz8RZEhLUykLy2DZfzM8GOGO1H6vKgjLoI7ZYmdWteS91wU
	 ZMn+js6raYOT38MILewRnhqvRolEEx5pXyTFirmMo/7mz6q0BM7ozBTIfFSOvEjE2P
	 2gykRRSsR53SGY2kuppFumaSUUwwgA4KjBULaOjWk8EDiswboRD83xZa9moml+6dzs
	 NGtjRRVVjCyPA==
Date: Mon, 22 Jun 2026 13:02:58 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Golla Nagendra <nagendra.golla@amd.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, michal.simek@amd.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	jay.buddhabhatti@amd.com, harini.katakam@amd.com, m.tretter@pengutronix.de, 
	radhey.shyam.pandey@amd.com, abin.joseph@amd.com, kees@kernel.org, 
	sakari.ailus@linux.intel.com, git@amd.com, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/3] dt-bindings: dma: xilinx: Add optional resets
 property for ZDMA
Message-ID: <20260622-ubiquitous-emerald-manul-daa5bb@quoll>
References: <20260618071056.2024286-1-nagendra.golla@amd.com>
 <20260618071056.2024286-2-nagendra.golla@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260618071056.2024286-2-nagendra.golla@amd.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11720-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:nagendra.golla@amd.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:michal.simek@amd.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:jay.buddhabhatti@amd.com,m:harini.katakam@amd.com,m:m.tretter@pengutronix.de,m:radhey.shyam.pandey@amd.com,m:abin.joseph@amd.com,m:kees@kernel.org,m:sakari.ailus@linux.intel.com,m:git@amd.com,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[krzk@kernel.org,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D835A6AEEEB

On Thu, Jun 18, 2026 at 12:40:54PM +0530, Golla Nagendra wrote:
> From: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
>=20
> Newer SoCs such as Versal Gen2 and Versal=E2=80=91Net expose a reset line
> for ZDMA. Older SoCs do not have this provision. Add an optional
> resets property to describe this reset.

It should be then restricted further per each variant/device in
allOf:if:then: (see example-schema for syntax - ": false").

>=20
> Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
> Co-developed-by: Golla Nagendra <nagendra.golla@amd.com>
> Signed-off-by: Golla Nagendra <nagendra.golla@amd.com>

Best regards,
Krzysztof


