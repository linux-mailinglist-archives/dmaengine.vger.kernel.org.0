Return-Path: <dmaengine+bounces-10753-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAXKGdB1EGoZXgYAu9opvQ
	(envelope-from <dmaengine+bounces-10753-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 17:27:12 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0EF5B6DE1
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 17:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5E433003614
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 15:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4932B421F07;
	Fri, 22 May 2026 15:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7wANgo8"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F623769F7
	for <dmaengine@vger.kernel.org>; Fri, 22 May 2026 15:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779463427; cv=none; b=oGBxTyM9NdnbVxVEHB6v12wRSPKtZyxgnDjzdZhP2FHCPzexrMF2FBRiLFksqXB09H09zQcgHnmGU+3pxcpsTxucyrEdBpYLZPGwWW92HgmYFFnf9zxgUWcy3MV+PGLY5lpxFjH2E4G+Z7PD/tWGPKGlUeCAUQUl5P8Q0C7zD7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779463427; c=relaxed/simple;
	bh=x5ayczbGXHBD7EvevWHlXIzoPY5htg7bNtENmbJRUwo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pzXK4NreeUCuQST55e1MVbehbuobKCHtC2QNi/hwfaz+Ga3vTz7mYh1o+gQ5YPm0ueacJqWLdAQ79zxvTzfhAPN/Dqwu3nJYoMAl7oNWKswmAGzoPMMp68IxAQlTvT8SGpTk+3fZcGmukDQiXeYuzuvhh+QZaO5LrgJlVpTvkaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7wANgo8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C511F000E9;
	Fri, 22 May 2026 15:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779463424;
	bh=Pwm3V4e5hjNw+xzLvgrOpNGah6yuufX9NslTrKziUp8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V7wANgo8GqFkgcWoI/s16QCYSkxTDmhjAGnDHRpILvVNxqLywnu8/ABwyiFMGWeLH
	 gawF62CC8RdXheeWMbCusVF6dGR/29zD+KUyLv9bcGcxsM6YWnbisldpeFKOTT75Dk
	 yZvWTM9yV8NQKHu5MEDBFLP+cKsYWUCcYYPMNA7gpc86wKF8bMmWwlVQxhxM1EJOJe
	 OftLALPsoJ4ltkcF1LwnjF8I1wYO4csIapXOlmPdekGqoDyKwhcpQj+CxQRy3nihLN
	 0DuentYBiCOoXP4TNi69Cb3Pfg2TS0zSa3LLM0y5oo/jh6GYcp+Tvc+Jiwd08RRr82
	 8d8tV6XI/u5UA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] dmaengine: mpc512x: fix dead empty check in
 mpc_dma_prep_slave_sg()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maoyi Xie" <maoyixie.tju@gmail.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260522150214.95651-1-maoyixie.tju@gmail.com>
References: <20260522150214.95651-1-maoyixie.tju@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 15:23:43 +0000
Message-Id: <20260522152343.E6C511F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-10753-lists,dmaengine=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,smtp.kernel.org:mid,sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Queue-Id: BF0EF5B6DE1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incorrect calculation of `tcd->nbytes` using an encoded bus width =
enum instead of the actual byte count, leading to hardware misconfiguration=
 and potential division by zero.
- [High] Activating the previously dead error recovery path triggers severe=
 concurrency issues, including client deadlocks and cookie state corruption.
--

commit 534ce02bd48f83d7760dd6fe18bd31e5103a4bad
Author: Maoyi Xie <maoyixie.tju@gmail.com>

dmaengine: mpc512x: fix dead empty check in mpc_dma_prep_slave_sg()

This commit changes the list_first_entry() call to
list_first_entry_or_null() in mpc_dma_prep_slave_sg() to correctly
handle an empty free list. This ensures the empty case returns NULL and
allows the existing recovery path to execute.

> diff --git a/drivers/dma/mpc512x_dma.c b/drivers/dma/mpc512x_dma.c
> index 0adc8e01057e1..f5934136efc4c 100644
> --- a/drivers/dma/mpc512x_dma.c
> +++ b/drivers/dma/mpc512x_dma.c
> @@ -706,8 +706,8 @@ mpc_dma_prep_slave_sg(struct dma_chan *chan, struct s=
catterlist *sgl,
>  	for_each_sg(sgl, sg, sg_len, i) {
>  		spin_lock_irqsave(&mchan->lock, iflags);
> =20
> -		mdesc =3D list_first_entry(&mchan->free,
> -						struct mpc_dma_desc, node);
> +		mdesc =3D list_first_entry_or_null(&mchan->free,
> +						 struct mpc_dma_desc, node);
>  		if (!mdesc) {
>  			spin_unlock_irqrestore(&mchan->lock, iflags);
>  			/* Try to free completed descriptors */

[Severity: High]
This isn't a bug introduced by this patch, but activating the recovery path
exposes a design flaw. Is it safe to call mpc_dma_process_completed()
from process context here?

As seen just below this diff, the recovery path calls
mpc_dma_process_completed(mdma). DMA clients often hold a spinlock during
dmaengine_prep_slave_sg() and expect to acquire it in their callback. Since
mpc_dma_process_completed() invokes client callbacks inline, could this
lead to a double-lock deadlock?

Additionally, mpc_dma_process_completed() drops mchan->lock to run
callbacks. Concurrently, mpc_dma_tasklet can execute, process newer
completions, and update mchan->chan.completed_cookie. When process
context resumes, it reacquires the lock and overwrites completed_cookie
with its older last_cookie, rolling the DMA state backwards.

Furthermore, this recovery path iterates over and flushes completions for
all DMA channels, which might disrupt other clients.

[ ... ]

[Severity: High]
This is a pre-existing issue, but further down in mpc_dma_prep_slave_sg(), =
is
the minor loop byte count calculated correctly?

drivers/dma/mpc512x_dma.c:mpc_dma_prep_slave_sg() {
...
		tcd->ssize =3D buswidth_to_dmatsize(mchan->swidth);
		tcd->dsize =3D buswidth_to_dmatsize(mchan->dwidth);

		if (mdma->is_mpc8308) {
...
		} else {
			len =3D sg_dma_len(sg);
			tcd->nbytes =3D tcd_nunits * tcd->ssize;
			if (!IS_ALIGNED(len, tcd->nbytes))
				goto err_prep;

			iter =3D len / tcd->nbytes;
...
}

The value tcd->ssize is an encoded hardware value (log2 of the bus width),
not the actual byte size. If mchan->swidth is 1 byte,
buswidth_to_dmatsize(1) returns 0, making tcd->ssize 0 and
tcd->nbytes 0.

If len =3D=3D 0, IS_ALIGNED(0, 0) is true, which could trigger a division by
zero when calculating iter.

If len > 0, it unconditionally fails the alignment check, which would render
1-byte transfers broken. For larger widths (e.g., 4 bytes), tcd->ssize is 2,
causing the hardware to be misconfigured with an incorrect transfer size.

Additionally, for DMA_MEM_TO_DEV, does this incorrectly mix the peripheral
maxburst with the memory bus width?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522150214.9565=
1-1-maoyixie.tju@gmail.com?part=3D1

