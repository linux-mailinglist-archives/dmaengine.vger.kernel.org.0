Return-Path: <dmaengine+bounces-11693-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RRs6LyhdOGoMbgcAu9opvQ
	(envelope-from <dmaengine+bounces-11693-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 21 Jun 2026 23:52:40 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A856ABA99
	for <lists+dmaengine@lfdr.de>; Sun, 21 Jun 2026 23:52:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XCQCRIWP;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11693-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11693-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57618300952E
	for <lists+dmaengine@lfdr.de>; Sun, 21 Jun 2026 21:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFDB370D52;
	Sun, 21 Jun 2026 21:52:36 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CCC7081A;
	Sun, 21 Jun 2026 21:52:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782078756; cv=none; b=mO34O/SGb7n+J852oq46NMW4xk1eNt6o6HSPQkl0HTWtj7e0F/csWWUGih/to+P4jnAudxvRG6oV/SUFWoShdNKvp7VRY1GDACfJ7d+JTKalWJ2nEYhLsDNTT47lGZh+BO9PwVD5i8wXC3agqmHFhgBm9kDsEfc/csYYAjKY5N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782078756; c=relaxed/simple;
	bh=1Lp2Jh5BpGIWy5fI2anJJCAcbum8prQM8bwA2LSpvn4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EzSBos6DURE4fTGMk0lerIqDSzJM916utaxvriZmGSBYNOpB7PXtkN7w5a4IOHNC/Z/5Mmy0dkJvlfoeQHSiYTCrRZU9pf6EeMmU6IBAtKylqXeaAeSRAdW0ygT/FMJ1EJSzHa2m7UpSg8uFDIHtMCMtUsQndNfu0+BzCHPB75I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCQCRIWP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13FF01F000E9;
	Sun, 21 Jun 2026 21:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782078755;
	bh=x+cQuudKwvowxRCePrb1+W8aySTiWbR2EO4JumEe1YE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XCQCRIWPCoqhXTcxgZM08rapvkyuIu1oxD2RmxR0Z78LsdoTNLR/8nkdgcSXQF4Av
	 OaqASYwK5tudEumZvDIHGsZcTLwr7wEnKzJgknxIHew6L/xrOw6ls1uoK0wRiDZyZ2
	 6F4or4xzVJq9GFNOZjLqZCuA/wHAq7gDot8EgyCz21ml/jN+yw/dBVrm3T9CtL3d42
	 1Pb5vcTM2Eu5c97K8uqsajX3QNeBxVreR0yeJswQ3QgrllE0VJpgCYlZW6UAIDYsxS
	 5ZijAbfavjd06EVnEJ0rgRTwB5tK24waKOEQ36A+MoeLiWOC4X6SDGgD8wK38DKRVB
	 SMJCJGaHXodVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/5] dt-bindings: dma: sun50i-a64-dma: Add
 allwinner,sun60i-a733-dma compatible string
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yuanshen Cao" <alex.caoys@gmail.com>
Cc: linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org, robh@kernel.org, dmaengine@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260621-sun60i-a733-dma-v2-4-340f205891cc@gmail.com>
References: <20260621-sun60i-a733-dma-v2-0-340f205891cc@gmail.com>
 <20260621-sun60i-a733-dma-v2-4-340f205891cc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 21 Jun 2026 21:52:34 +0000
Message-Id: <20260621215235.13FF01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-11693-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:alex.caoys@gmail.com,m:linux-sunxi@lists.linux.dev,m:devicetree@vger.kernel.org,m:Frank.Li@kernel.org,m:vkoul@kernel.org,m:robh@kernel.org,m:dmaengine@vger.kernel.org,m:conor+dt@kernel.org,m:alexcaoys@gmail.com,m:conor@kernel.org,s:lists@lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,sashiko.dev:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 62A856ABA99

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The IRQ handler loop skips trailing DMA channels if the total numb=
er of physical channels is not an exact multiple of the channels per regist=
er.
--

commit 1a8550cc9da2ef939f555f682f0d5ea9606e1907
Author: Yuanshen Cao <alex.caoys@gmail.com>

dt-bindings: dma: sun50i-a64-dma: Add allwinner,sun60i-a733-dma compatible =
string

Add `allwinner,sun60i-a733-dma` to the list of compatible strings for the
`sun50i-a64-dma` dtbinding documentation.

>     While the A733 DMA controller shares many similarities with the sun50=
i-a64
>     DMA controller, it requires a specific configuration due to differenc=
es in:
>     - Interrupt register layout and mapping.
>     - Number of channels per interrupt register.

[Severity: High]
This isn't a bug introduced by this patch, but could this truncating
integer division skip trailing DMA channels if the total number of physical
channels is not an exact multiple of the channels per register?

In drivers/dma/sun6i-dma.c:sun6i_dma_interrupt(), the loop condition
determines which interrupt registers to poll:

    for (i =3D 0; i < sdev->num_pchans / sdev->cfg->num_channels_per_reg; i=
++) {

For a controller with 12 physical channels (e.g., sun8i_h3_dma_cfg sets
nr_max_channels =3D 12) and 8 channels per register, 12 / 8 evaluates to 1.

Consequently, the loop only iterates once (for i=3D0), checking interrupts
for the first 8 channels and completely ignoring the remaining 4 channels.
Any DMA transfers on channels 8-11 will never have their completion
interrupts handled, leading to system hangs or driver timeouts.

Could this be updated to use DIV_ROUND_UP() to ensure all applicable
interrupt registers are processed?

>     - Support for higher (32G) address widths in LLI parameters.
>    =20
>     Signed-off-by: Yuanshen Cao <alex.caoys@gmail.com>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260621-sun60i-a73=
3-dma-v2-0-340f205891cc@gmail.com?part=3D4

