Return-Path: <dmaengine+bounces-12088-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +XzPOQe4TWri9QEAu9opvQ
	(envelope-from <dmaengine+bounces-12088-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 04:37:59 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FA372136B
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 04:37:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="k5JrUB/h";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12088-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12088-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95B923019504
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jul 2026 02:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AED390616;
	Wed,  8 Jul 2026 02:37:32 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA53E420896
	for <dmaengine@vger.kernel.org>; Wed,  8 Jul 2026 02:37:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783478252; cv=none; b=sBTS2VZ/bgM8M9RLqi19Xm4IYBrf5qD6jdMjHL/79MZ5kBROGghSNCimcv7xlDMdEEKuv9g3sv9ZzdUBhF/a6HCWlqqqp87u7Fl+Ykyi19sHtFGa2rD6n8o9J9NA9KqPJDo9fd6hWd9J84rdRy6MGcSE5xRAu3fJuuKDN/4r6mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783478252; c=relaxed/simple;
	bh=9nJpcKklYoJL/l552EIDU42GV7oZbqWaLnIM4UCT/dY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qSC2f9OC3s/QEzIfaTOSV6+L93vmv/3qTQNA2SlMgw9fPL+6tXfg2RmyXPm4owcSUWlAX+0/s3W9T+0M9MxTtWQIc/pOHCdjZ1qWUKT3j2k85x5UXuUfutEHXk5MpJUcc/RwFsjiFa7CLHdVYa1NLVGH8I9zjT7ix0XEEnNOh3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5JrUB/h; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 237E21F000E9;
	Wed,  8 Jul 2026 02:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783478251;
	bh=q+eT+5o9y4wFfs4nIF52o81Pf67ScMAaeb6+viMm33A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k5JrUB/h9L8StYuRvWUHj3x6a0qJJhcBUJ9okPU/cfLMM5kLOYB5pGY5Z0KmCLG2C
	 couyAVN55/oShuFLnzDu0ASYaEihaxXZGyCsQg5lnmNL7YyTUx5vQeUYQZyIMkuNGS
	 1isQ5OIsrt4p26Is3NtSlIydlsm3hw3XmNdeRgMEsRP1fwIMcaUAg0G98I8JzXeV2J
	 Nxzyixqg6vFBlY5UGcS41DiVSTLadVwwnH9aMVcejOwukXh1Ob9pIioVF3RH91x6zh
	 GfNCzdEh+HwA/bTB1Mf7ZomJy3qma0f4x9BAsVhwLEEQQezTuksYBd2A4OxTiB/JzR
	 n5Zdcbnpr5/iA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] dma: at_hdmac: Fix use-after-free by proper tasklet
  cleanup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hongling Zeng" <zenghongling@kylinos.cn>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260708022405.24266-1-zenghongling@kylinos.cn>
References: <20260708022405.24266-1-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 02:37:30 +0000
Message-Id: <20260708023731.237E21F000E9@smtp.kernel.org>
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
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-12088-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:zenghongling@kylinos.cn,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,kylinos.cn:email,smtp.kernel.org:mid,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lists.linux.dev:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 57FA372136B

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Meaningful code and commit message mismatch: The v3 changelog ex=
plicitly claims to keep a defensive NULL check, but no such check exists in=
 the code.
--

--- Patch [1]: [PATCH v3] dma: at_hdmac: Fix use-after-free by proper taskl=
et  cleanup ---
commit e05118b092320af0ba75bbb64dc2f10dd2eff233
Author: Hongling Zeng <zenghongling@kylinos.cn>

dma: at_hdmac: Fix use-after-free by proper tasklet cleanup

This commit fixes a use-after-free vulnerability by reordering the probe and
remove cleanup paths. It ensures that free_irq is called before killing
tasklets, preventing IRQ handlers from scheduling new tasklets on freed mem=
ory.

Closes: https://lore.kernel.org/all/20260604073945.54B311F00898@smtp.kernel=
.org/

> Change in v3:
> - Reorder probe error path to match remove() cleanup order
> - Keep defensive NULL check for channels cleanup

[Severity: Medium]
This isn't a bug in the code, but the changelog states a defensive NULL
check was kept for the channels cleanup.

Looking at the newly added cleanup function in the diff:

> diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
> --- a/drivers/dma/at_hdmac.c
> +++ b/drivers/dma/at_hdmac.c
[ ... ]
> +static void at_dma_cleanup_channels(struct at_dma *atdma)
> +{
> +	struct dma_chan *chan, *_chan;
> +	int i =3D 0;
> +
> +	list_for_each_entry_safe(chan, _chan, &atdma->dma_device.channels,
> +			device_node) {

Was the defensive check accidentally dropped in at_dma_cleanup_channels,
or does the commit message just need to be updated?

While the code appears safe because the error paths were correctly reordered
to avoid reaching this function with an uninitialized list, the changelog
mismatch might cause confusion.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708022405.2426=
6-1-zenghongling@kylinos.cn?part=3D1

