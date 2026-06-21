Return-Path: <dmaengine+bounces-11692-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id X60xFgFdOGoGbgcAu9opvQ
	(envelope-from <dmaengine+bounces-11692-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 21 Jun 2026 23:52:01 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A046ABA8B
	for <lists+dmaengine@lfdr.de>; Sun, 21 Jun 2026 23:52:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=R52RlkBP;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11692-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11692-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7605D3028B24
	for <lists+dmaengine@lfdr.de>; Sun, 21 Jun 2026 21:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35F7370AF6;
	Sun, 21 Jun 2026 21:51:05 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B3A7081A;
	Sun, 21 Jun 2026 21:51:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782078665; cv=none; b=a9jWigmCXHwvGbW5fp7NOVTquNRBNHkDeWn5t8t3xKkdonzK1q6asdtsYvuqFIYjpD4eoIO8I/TdCSfqEwHWfHvW/oOPEaiLgaCV/uyRlmnycDUQpPIyWvOHaoadq3n6GCIbctcF7YxnVBcaXUl34KqthOkEvvVOwatNwuTkyYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782078665; c=relaxed/simple;
	bh=DYIFjkjiyQWapfheP3oF/cbj+4btoWQ77XdCnsT+pug=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ju1wJ3SGEcKyiIIOPGMfO+H0gKwUAbqpyFf2Vlp8PB0oewbfdwOAGLIwga7kcOzw8PCDYewuzpZ8ifJFDyvQrpHndlBthXBTH5jAKfJFcCxiRF027aUYsYpFTj4cERauf/K0AIdEH0ODZx4G82WarEhtxq1jeElE9d1ehvtlnqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R52RlkBP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED171F000E9;
	Sun, 21 Jun 2026 21:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782078664;
	bh=KTXGMqhioCdRGhDFxdKDCKqq7izBHMAWl7Vh+OOYQQE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R52RlkBPOQEigjHIxQmcSKNEKsTaZaeeax5h6ueGXgMYq/2gJlXmLt/+MG0XBzcrx
	 zVPzdgC0uVuk++OEfQQotDs+nX1yEbOVpXNBTLUiJKTC12ONjbfs8bH2XEhZsmKCOr
	 KPKoH2xdgHi1qF0ld/UB6/OD7soN1z8BYHSk6OikbWWzttH41d2H2IeIV0fLl2xSen
	 htBESGWNuBwdMCu7ut+wuGeEo4YOWuIZsH18rQ2DTkpL7PfenAlxBi43mrwiauVYIJ
	 qZGJ5u1tpMUC4L4d8X3Ah5oF2T6sIc7zRxiaNSfkmBhYxG8CDfaH6Oy9eD3v1Unncp
	 3Pi55U/cBxZyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/5] dmaengine: sun6i-dma: Add set_addr function
 pointer for variable address widths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yuanshen Cao" <alex.caoys@gmail.com>
Cc: robh@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org, linux-sunxi@lists.linux.dev, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260621-sun60i-a733-dma-v2-2-340f205891cc@gmail.com>
References: <20260621-sun60i-a733-dma-v2-0-340f205891cc@gmail.com>
 <20260621-sun60i-a733-dma-v2-2-340f205891cc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 21 Jun 2026 21:51:03 +0000
Message-Id: <20260621215103.EED171F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-11692-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:alex.caoys@gmail.com,m:robh@kernel.org,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,m:linux-sunxi@lists.linux.dev,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:alexcaoys@gmail.com,m:conor@kernel.org,s:lists@lfdr.de];
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
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,smtp.kernel.org:mid,sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B0A046ABA8B

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free during error path cleanup in sun6i_dma_prep_slave_s=
g and sun6i_dma_prep_dma_cyclic.
--

commit 9bdc9020fe709f46ed0cba2bea4a233b8e23c603
Author: Yuanshen Cao <alex.caoys@gmail.com>

dmaengine: sun6i-dma: Add set_addr function pointer for variable address wi=
dths

This commit refactors the sun6i DMA driver by moving the address setting lo=
gic
into a function pointer within the configuration structure. This allows
handling of different hardware variations, specifically adding support for
the A733's 32G high-address bits while preserving legacy behavior for
older generations.

> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index ef3052c4ab363..9984b9033cbb9 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -138,6 +139,8 @@ struct sun6i_dma_config {
>  	void (*set_burst_length)(u32 *p_cfg, s8 src_burst, s8 dst_burst);
>  	void (*set_drq)(u32 *p_cfg, s8 src_drq, s8 dst_drq);
>  	void (*set_mode)(u32 *p_cfg, s8 src_mode, s8 dst_mode);
> +	void (*set_addr)(struct sun6i_dma_dev *sdev, struct sun6i_dma_lli *v_ll=
i,
> +		dma_addr_t src, dma_addr_t dst);
>  	void (*dump_com_regs)(struct sun6i_dma_dev *sdev);

[ ... ]

[Severity: High]
This is a pre-existing issue, but I noticed a potential use-after-free
in the error cleanup paths.

Looking at sun6i_dma_prep_slave_sg():

err_lli_free:
	for (p_lli =3D txd->p_lli, v_lli =3D txd->v_lli; v_lli;
	     p_lli =3D v_lli->p_lli_next, v_lli =3D v_lli->v_lli_next)
		dma_pool_free(sdev->pool, v_lli, p_lli);

Does this loop cause a use-after-free? The dma_pool_free() call frees
v_lli, but the loop increment step then dereferences it via
v_lli =3D v_lli->v_lli_next.

This exact same pattern also appears in sun6i_dma_prep_dma_cyclic():

err_lli_free:
	for (p_lli =3D txd->p_lli, v_lli =3D txd->v_lli; v_lli;
	     p_lli =3D v_lli->p_lli_next, v_lli =3D v_lli->v_lli_next)
		dma_pool_free(sdev->pool, v_lli, p_lli);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260621-sun60i-a73=
3-dma-v2-0-340f205891cc@gmail.com?part=3D2

