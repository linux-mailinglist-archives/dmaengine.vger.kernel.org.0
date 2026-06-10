Return-Path: <dmaengine+bounces-11409-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8AXPHI/BKWo8cwMAu9opvQ
	(envelope-from <dmaengine+bounces-11409-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 21:57:03 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E0766CA0B
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 21:57:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="kqo/q8ud";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11409-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11409-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8457F3130255
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 19:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C5C37BE60;
	Wed, 10 Jun 2026 19:53:31 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2094637D128
	for <dmaengine@vger.kernel.org>; Wed, 10 Jun 2026 19:53:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781121211; cv=none; b=AH5PtoDZheLn8AEs6ucdtlpwFKZEjLW2KLZ6fs0dOsNyC6SXXARWmzAfu6ekLF2rdvhPDKrngrioreMcpoBvGX/6hxS/fWlBZR35pgJvW8ki0LRhCkJCrNt2QD4hfoCo+uHLWkvKRmsWFqgbZnw/JR2WDGdJEawcj45DcCczK1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781121211; c=relaxed/simple;
	bh=NQub1lg/jIgI3TCrk9M50SawHaRHgqZ4Mn6Hf5lx3e8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XIR6oTZIYMY7Wtp2nyu9coKNd6I9d/hhjINobaGuIj2NuZvQ373JC2bzwH5942JmLRvfJWdmIKbaf/ONCUQgkW3MVSk3+qRYoaVZFGWjzr6AcBUrmaJa5zvIkd6izmKr0NuT7ErfVdhT9SBiLvQyf4HQyr+Oqp7zvnEwk2m2ppA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqo/q8ud; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F431F00898;
	Wed, 10 Jun 2026 19:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781121210;
	bh=Wo6tVPUDL8gYNgmxq/I4LZSFmBqIuw5OsHgJsCLmK1U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kqo/q8ud/3iXZWvSAkGlpHN83cQgsM7fV101mC7kZ3LYGNFJF3H4gMQLMDmqh0HPC
	 R5ZtxkeTcFjemmPi95XK1zQXk8JOaYiHkigaAAi+i9Ke5Nq6AGPhT5tj4vAXSeMh0V
	 J3whuPtmYDz8AybyD7TPEE0u2xkzjuu8CVwpC6YXt0dib9K2+eJxlkLkEhw5aV+NCM
	 foItN6Khjxs92i8LXdKKhE/PGaZnjgcqawSglTMfnNsYU0ysZSJBkCwxmnbmAyCd6Q
	 5xY9CT5fBZAp0IAwhUCaue8HDoqCp5P1Of9o1I7sKeK7VM3ikn3C6O6rZVLZiU7t/a
	 R/7q3rqngofMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dmaengine: ti: k3-udma: Use common error handling code
 in udma_prep_slave_sg_pkt()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Elfring" <Markus.Elfring@web.de>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <225b97d8-425c-46ea-bee2-df73753bca8c@web.de>
References: <225b97d8-425c-46ea-bee2-df73753bca8c@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 19:53:29 +0000
Message-Id: <20260610195329.C8F431F00898@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11409-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[web.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Markus.Elfring@web.de,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B6E0766CA0B

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The error handling label `free_hwdesc` is inappropriately placed in=
side an unrelated conditional block, creating non-linear control flow.
--

commit 8ea86eb1521c2e6195625764d7c02223ede1fd79
Author: Markus Elfring <elfring@users.sourceforge.net>

dmaengine: ti: k3-udma: Use common error handling code in udma_prep_slave_s=
g_pkt()

This commit introduces a new goto label to reuse error handling code when
descriptor allocation fails. The cleanup logic is now consolidated to avoid
duplication.

> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index c964ebfcf3b68..b56ee3ca848ef 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c

[ ... ]

> @@ -3309,6 +3306,7 @@ udma_prep_slave_sg_pkt(struct udma_chan *uc, struct=
 scatterlist *sgl,
>  		dev_err(uc->ud->dev,
>  			"%s: Transfer size %u is over the supported 4M range\n",
>  			__func__, d->residue);
> +free_hwdesc:

[Severity: Low]
Does placing this error handling label inside the unrelated residue bounds
check block create confusing control flow?

Jumping into the middle of the if (d->residue >=3D SZ_4M) block works curre=
ntly,
but could it silently break the descriptor allocation error path if this
bounds check block is ever modified or removed in the future?

>  		udma_free_hwdesc(uc, d);
>  		kfree(d);
>  		return NULL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/225b97d8-425c-46ea-=
bee2-df73753bca8c@web.de?part=3D1

