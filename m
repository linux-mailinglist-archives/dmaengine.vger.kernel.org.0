Return-Path: <dmaengine+bounces-11083-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMpOOULZHGopTQkAu9opvQ
	(envelope-from <dmaengine+bounces-11083-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 01 Jun 2026 02:58:42 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B3F618907
	for <lists+dmaengine@lfdr.de>; Mon, 01 Jun 2026 02:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD9433011F01
	for <lists+dmaengine@lfdr.de>; Mon,  1 Jun 2026 00:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A43F1A680A;
	Mon,  1 Jun 2026 00:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqcwTmkl"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58297126C03
	for <dmaengine@vger.kernel.org>; Mon,  1 Jun 2026 00:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780275506; cv=none; b=d7NABHs4HJtjRka88+4DBVcPqEnyT67fx4W53P+dr2vNrmrFuUnVEm0dqYuqVH0z3p38wz1wVvlYRHQgCQLlTMnljfxMTXhHXn55AFqduOnrhWEkSYwuQtUfvqrJLFsF4Aa2RmE45dhIhHhBoFTCA/7tmfzNlTEfsOVWy+4du5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780275506; c=relaxed/simple;
	bh=aSJm9GNzplJwDtEfJfHhmw/LNOAnGX+lUdoLarj1P5Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lcChLqnY/7tbiWlsLv1Qi678zDLzKZ1LU6dELvf2JVLUqPtiI3hrFBW3QmqB402iP+zg0VhGvDclkic0GywECOn2c3M0DcZQZe1ueZ1CTdWbdYbsVicFGP41CGoiF18rt0J4SLeZzgDUTxowxOgzz1otXwc1VWfbvufcekoaRmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JqcwTmkl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B101F00893;
	Mon,  1 Jun 2026 00:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780275504;
	bh=Tz6p1AMJ79D1W1CoRJqOF1yGp8kV7uhZTHpx7Ct+gtw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JqcwTmklipnzfC8RVgpX31PDUhrDBFPhp75lg/MMHfYo6tTHaphD+CqmYYS8m0Tc9
	 rMEfl6HpWbcHcEQZaSyrZNz9N/bdEvkJqj1BpwMwvnh0CkEn0dRnxnxq8VdNV5Cmfh
	 b5T9+lnM6GIUnAdKfj+JTTgBRfsmCeaDgPr0AeBXqhcIIVFRnX0Mht3MZR6DwtNj8f
	 9ZZ3w7OK+6jGfr9Z/KUeuTu1GhiWFavl2Vvxfw29PeSLk5AszsJrxgL6r0EqBStxnV
	 dsMh7wZ/NWAeLt2boBvY5nMOQaZW/u0BokOW5gBWfTiGsQiD4EdbV9xu0JgMcDEk1f
	 xACoeBNQ5bGbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/5] dmaengine: ti: omap-dma: fix notifier leak in
 remove
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260601003553.72573-3-rosenp@gmail.com>
References: <20260601003553.72573-3-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 00:58:24 +0000
Message-Id: <20260601005824.B7B101F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11083-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 41B3F618907
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Potential Use-After-Free of notifier_block due to missing RCU =
synchronization.
--

commit 5e6f29c5f10bea4aff2b71ed41a418296a887ddf
Author: Rosen Penev <rosenp@gmail.com>

dmaengine: ti: omap-dma: fix notifier leak in remove

This commit fixes a notifier leak during driver removal. It ensures the CPU=
 PM
notifier is unregistered if either the needs_busy_check or may_lose_context
flag is set, rather than only checking may_lose_context.

> diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
> --- a/drivers/dma/ti/omap-dma.c
> +++ b/drivers/dma/ti/omap-dma.c
> @@ -1853,7 +1853,7 @@ static void omap_dma_remove(struct platform_device =
*pdev)
>  	struct omap_dmadev *od =3D platform_get_drvdata(pdev);
>  	int irq;
> =20
> -	if (od->cfg->may_lose_context)
> +	if (od->cfg->needs_busy_check || od->cfg->may_lose_context)
>  		cpu_pm_unregister_notifier(&od->nb);

[Severity: Critical]
This is a pre-existing issue, but does this unregister path leave the
notifier_block vulnerable to a use-after-free?

In omap_dma_remove(), cpu_pm_unregister_notifier() unlinks the notifier
block from the raw notifier chain but does not wait for an RCU grace period.
Because the od structure is managed by devres (allocated via devm_kzalloc),
it gets freed automatically shortly after omap_dma_remove() returns.

If a concurrent CPU PM transition (like another CPU entering or exiting idle
states) traverses the raw notifier chain using rcu_read_lock(), couldn't the
traversing CPU dereference the freshly freed notifier_block?

Would adding a synchronization mechanism for RCU before the driver is
released prevent this regression?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601003553.7257=
3-1-rosenp@gmail.com?part=3D2

