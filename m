Return-Path: <dmaengine+bounces-10689-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KCYFEU1D2qSHgYAu9opvQ
	(envelope-from <dmaengine+bounces-10689-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 18:39:33 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6065A9726
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 18:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39666325BDE5
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 15:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8777532E696;
	Thu, 21 May 2026 15:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VrrRsk4G"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5533C322DAF
	for <dmaengine@vger.kernel.org>; Thu, 21 May 2026 15:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779378127; cv=none; b=MRmDIhOzFSmSSL/qXdr1cv3NYf7wN8G9DDlxA/GzbZczatK3ISdyOXx+AIET7ElX3YjNZs8xO7cOqjbwGem3pC7c8yBWqVo7pxXhaMCMEX8ZMQi71xclCXo66r36GsYMyt1vv+sbuwMllbffJJXDPCXn5syFYCHGmAg80JyxlKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779378127; c=relaxed/simple;
	bh=Qn9oyrlEoVBbfCWSfBdQ8Fnv8R7O4hGVZtRPZoD2tT4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tC8zbcSysswc6VmBz3YfSdFvg9ql7adOqX8DA4PKljbpFbNGv7GU3m/TL37/zw6kE8luoHQiPyHtDyP/DY/1InUVgacEtAj3BMTFoTxfXj8E1GUkTTTvsttAYOOBowCeakpqlmBZ+NyfJSPiXcLMSebU4ke0xhARxYfSx2iPiak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VrrRsk4G; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE4E1F000E9;
	Thu, 21 May 2026 15:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779378126;
	bh=dpyZlwJbZiiHW9bCuT2DUIqyNHPu853CLzBd4/GQ5ZE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VrrRsk4GJKkHDrM8cc+znbXNw6n7NaT5M0QgrxZEctzkftYdUxh2MpRgmeFHKq0+7
	 n/dwNBFqMQL0ZQRSDgoV4KK5KwiogQByhnheEra9htHtzzJySGWNtJwzrD1gQC2aug
	 d/P3beQxeeTMkTkAxK4t0FvrnMKG8+0xi/K6B4olF+GP9EzQxQZR7zi20Gk4z+W5tF
	 fVvNwbwCMVd+K5z7qpC1LC0wTpkIaYckWgjHfVQ3M/MNS8B+crXqp5U6M2fOXgD0SA
	 nKNLFGXrkqDlXBxBsKC4ULQ5LkETTzEkAppDN6bu93ShWi+uROBkkE7VAf6WYHbMM3
	 FoBae7735gSvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] dmaengine: mpc512x: fix dead empty check in
 mpc_dma_prep_slave_sg()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maoyi Xie" <maoyixie.tju@gmail.com>
Cc: wsa+renesas@sang-engineering.com, vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260521144755.3476353-2-maoyixie.tju@gmail.com>
References: <20260521144755.3476353-2-maoyixie.tju@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 15:42:05 +0000
Message-Id: <20260521154205.BCE4E1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10689-lists,dmaengine=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Queue-Id: 9C6065A9726
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incorrect minor loop byte count calculation causes hardware config=
uration errors and potential division by zero panic.
- [High] Direct C bitfield assignment to an __iomem pointer causes undefine=
d behavior and potential Machine Check Exceptions.
--

commit 843ae9154206865fe98175ccec56b456c8445f35
Author: Maoyi Xie <maoyixie.tju@gmail.com>

dmaengine: mpc512x: fix dead empty check in mpc_dma_prep_slave_sg()
   =20
mpc_dma_prep_slave_sg() reads mchan->free with list_first_entry()
and then tests the returned pointer against NULL. list_first_entry()
never returns NULL. On an empty free list it returns an aliased
pointer derived from the list head, making the recovery path dead code.

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
This isn't a bug introduced by this patch, but in mpc_dma_prep_slave_sg(),
the minor loop byte count is calculated using the register enum value
tcd->ssize instead of the actual transfer width:

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

For a 1-byte transfer width, tcd->ssize is 0, causing tcd->nbytes to be 0.
If a client submits a scatterlist with length 0, the IS_ALIGNED(len,
tcd->nbytes) check passes (since 0 & -1 =3D=3D 0), resulting in a division =
by
zero kernel panic when calculating iter.

Even for valid lengths, 1-byte transfers always fail the alignment check,
and transfers with other widths receive an incorrect minor loop
configuration, causing functional failures.

Could we update this to use the actual transfer width instead of the enum
value?


[Severity: High]
This is also a pre-existing issue, but in mpc_dma_execute(), a bitfield on
a memory-mapped I/O structure is modified directly via C assignment:

drivers/dma/mpc512x_dma.c:mpc_dma_execute() {
...
	/* Send first descriptor in chain into hardware */
	memcpy_toio(&mdma->tcd[cid], first->tcd, sizeof(struct mpc_dma_tcd));

	if (first !=3D prev)
		mdma->tcd[cid].e_sg =3D 1;
...
}

Since mdma->tcd is an __iomem pointer, does dereferencing it directly with
standard C assignments invoke undefined behavior and circumvent necessary
I/O accessors?

As struct mpc_dma_tcd is marked __packed__, the compiler may generate
byte-sized read-modify-write instructions. On PowerPC architectures, such
non-32-bit accesses to memory-mapped device registers can trigger Machine
Check Exceptions (MCE), leading to system crashes.

Is there a safer way to update this hardware register using appropriate
I/O accessors?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521144755.3476=
353-1-maoyixie.tju@gmail.com?part=3D1

