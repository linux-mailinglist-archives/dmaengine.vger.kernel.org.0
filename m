Return-Path: <dmaengine+bounces-12092-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WgNLCIPFTWoU+AEAu9opvQ
	(envelope-from <dmaengine+bounces-12092-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 05:35:31 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7149F72164F
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 05:35:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=NmOKfR8E;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12092-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-12092-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CCCBD301F155
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jul 2026 03:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82723271FD;
	Wed,  8 Jul 2026 03:35:08 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD6631352D;
	Wed,  8 Jul 2026 03:35:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783481708; cv=none; b=BMMDZFtUtRLZNz5fr2bTBXxMq+R2JwUJQvDcOM0/EH/dF+Ahlu0bS9WSWVw6TddUYDKmjYd5UwXaa3b+2VP8+RDLd2gewyN/gYRUEilRR1gVuU1qOXwRn9/E1nKeDRE78SyIAAsBIZ7lpEGh1i2SszWYVLXMzgs8P8+J+Beq8Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783481708; c=relaxed/simple;
	bh=Bd8XlKUwTt3BUhsvLG69h3UIokTAfX+gwpcMi+PWjSM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lsY9wPiG6gjm2uAMK+1viIbxIzYtDc/3ZgFBW0240JXy1iD+EQbyHQWCjWiyIV+i8OhtqoxdnVukBGT1Piu0nRQ/X/3vKfIDHg8Jlvk9d/W1zBEgi07Xjeml0zeRghif9PO/2wzWOIZau6Pju9fwGwzkNFNriiS1zKqzq7l4+LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmOKfR8E; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD02C1F000E9;
	Wed,  8 Jul 2026 03:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783481707;
	bh=iB7NhzEXBQXgyDgw0NREyuShHTwFJABRgSW/Abcweqk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NmOKfR8Eon4O/uEheMAc/JCdqvesZmxLWKjXY1+jOZG/KjQj1a6aUF8Epd5IH/nBg
	 wwZC78bmVOYJwWoTGTsittI0VEiG0cFcUXMvFT4gEeOTXC4JII005TNEN4pJBVFwdz
	 DTx7YTm7KAg1fv8TI7u71jWW6rNNZmSHT//CJJ13X7dUeuaXx48GvCTJiErLQcI+xA
	 +QwI3UEOouegqzPjxVZpCU7tSA2MWfrO0CVf60sVZjZccb1xHaraTyFuiFIh6rSPlN
	 CBNm4E3Q6syzz5zETjxwWj2tsXdrbvsoGv6REKrMZdKAoOvaNRR9Vt6wESZzwVWfT3
	 A8gsBs9qFZ26Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] dmaengine: sun6i-dma: Fix use-after-free in error
 handling paths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hongling Zeng" <zenghongling@kylinos.cn>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, linux-sunxi@lists.linux.dev, dmaengine@vger.kernel.org
In-Reply-To: <20260708032518.50886-1-zenghongling@kylinos.cn>
References: <20260708032518.50886-1-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 03:35:06 +0000
Message-Id: <20260708033506.CD02C1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12092-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,smtp.kernel.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url,vger.kernel.org:from_smtp,lists.linux.dev:replyto];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zenghongling@kylinos.cn,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:linux-sunxi@lists.linux.dev,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7149F72164F

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Race condition in IRQ handler leading to NULL pointer dereference
- [High] Missing tasklet_schedule in sun6i_dma_resume causes stalled transf=
ers
--

--- Patch [1]: [PATCH v4] dmaengine: sun6i-dma: Fix use-after-free in error=
 handling paths ---
commit ece21d8f10ca9ff0dd6adbfa89c44eada4329522
Author: Hongling Zeng <zenghongling@kylinos.cn>

dmaengine: sun6i-dma: Fix use-after-free in error handling paths

The commit refactors the error handling paths in the sun6i-dma driver by
introducing the helper functions sun6i_dma_free_desc() and
sun6i_dma_free_desc_virt(). This resolves a use-after-free issue when
iterating and freeing a virtual LLI list in sun6i_dma_prep_slave_sg() and
sun6i_dma_prep_dma_cyclic().

> drivers/dma/sun6i-dma.c:sun6i_dma_interrupt() {
> ...
> 			if (vchan && (status & vchan->irq_type)) {
> 				if (vchan->cyclic) {
> 					vchan_cyclic_callback(&pchan->desc->vd);
> 				} else {
> 					spin_lock(&vchan->vc.lock);
> 					vchan_cookie_complete(&pchan->desc->vd);
> 					pchan->done =3D pchan->desc;
> 					spin_unlock(&vchan->vc.lock);
> 				}
> 			}
> ...
> }

[Severity: High]
This is a pre-existing issue, but could this cause a NULL pointer dereferen=
ce?

Looking at sun6i_dma_terminate_all(), it clears pchan->desc:

> drivers/dma/sun6i-dma.c:sun6i_dma_terminate_all() {
> ...
> 	if (pchan) {
> 		writel(DMA_CHAN_ENABLE_STOP, pchan->base + DMA_CHAN_ENABLE);
> 		writel(DMA_CHAN_PAUSE_RESUME, pchan->base + DMA_CHAN_PAUSE);
>=20
> 		vchan->phy =3D NULL;
> 		pchan->vchan =3D NULL;
> 		pchan->desc =3D NULL;
> 		pchan->done =3D NULL;
> 	}
> ...
> }

If sun6i_dma_terminate_all() runs concurrently with sun6i_dma_interrupt() on
SMP systems, sun6i_dma_terminate_all() holds vchan->vc.lock, stops the
hardware, and sets pchan->desc =3D NULL. Meanwhile, the IRQ handler reads
pchan->vchan locklessly.

If the IRQ handler evaluates this before it is cleared, it will proceed. For
non-cyclic transfers, the IRQ handler blocks on vchan->vc.lock. When
sun6i_dma_terminate_all() releases the lock, the IRQ handler continues and
evaluates &pchan->desc->vd. Since pchan->desc is NULL, could this pass a NU=
LL
pointer to vchan_cookie_complete() and cause a kernel panic? For cyclic
transfers, the race appears even wider since the handler evaluates
&pchan->desc->vd completely locklessly.

> drivers/dma/sun6i-dma.c:sun6i_dma_resume() {
> ...
> 	} else if (!list_empty(&vchan->vc.desc_issued)) {
> 		spin_lock(&sdev->lock);
> 		list_add_tail(&vchan->node, &sdev->pending);
> 		spin_unlock(&sdev->lock);
> 	}
> ...
> }

[Severity: High]
This is a pre-existing issue, but does this code leave transfers stalled
indefinitely?

If a DMA channel is paused (sun6i_dma_pause) while it has pending descripto=
rs
but is not yet assigned to a physical hardware channel (pchan =3D=3D NULL),=
 it is
removed from the sdev->pending list.

When the channel is later resumed here in sun6i_dma_resume(), it is re-added
to sdev->pending. However, sun6i_dma_resume() fails to call
tasklet_schedule(&sdev->task). Since the tasklet is responsible for pulling
virtual channels off the pending list and assigning them to physical channe=
ls,
will this channel sit in the pending queue indefinitely until an independent
event schedules the tasklet?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708032518.5088=
6-1-zenghongling@kylinos.cn?part=3D1

