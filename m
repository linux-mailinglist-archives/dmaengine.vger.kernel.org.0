Return-Path: <dmaengine+bounces-11671-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8WxKKrvKNmrSEwcAu9opvQ
	(envelope-from <dmaengine+bounces-11671-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 19:15:39 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C2D6A9572
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 19:15:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=iQQ5GY2E;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11671-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11671-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8BFC3002B73
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 17:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75951317160;
	Sat, 20 Jun 2026 17:15:37 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6250B315D49
	for <dmaengine@vger.kernel.org>; Sat, 20 Jun 2026 17:15:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781975737; cv=none; b=PLeWoDN9HvbbSzcuu4+8z4K5S1WdW/P/QcT0dTPJZWVMnarZo26Zn7ja3gwllyjaAjtqg4coh4CInj+/AaQZCs6P9J3oYlvLn2GbM1YbZVy/eGOGRIigBvimWon2XFEJUnxl2IPhcAXrI0BHO6t/K9pAhBqWeTIzIuqLE0c9nIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781975737; c=relaxed/simple;
	bh=W6Ip3VzTSX1GghWMhk1a6ZIkR0xLkespQXt0ltlF4i4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tEU7so2i6oAutEZ8hk5DcBRk8qe4JiADvYtTfs74ajVe2lLjTpH0tQmooeme6qDqI/qp4CpoLN13xfIoQON1f6Mklvdbn8pydrDaW7CcLLoiQmJZmOwjTaPViK5wx8g+xkW1cGamzHwoPCKzrwnsCqL7D1wYKxBfln3VzJZjG0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQQ5GY2E; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE831F000E9;
	Sat, 20 Jun 2026 17:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781975736;
	bh=nzbStgpTOJS/WBHjus8DjMPj85MAcJ5XvKJFJ6PrmSA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iQQ5GY2Eo5ktIFQRIXzVCfac5kZygBCjOBwpVMaFoOcIq0hXZJpPDLO6OiBipL/fB
	 Gk+/JYP8A+mGC7uTdW7B89QhoqNZ7U5KJzXWr0sp5U9Bxej8p7wkyh4utMC/j7slSt
	 t1fwp0tW7wn98AqfEiinhIaviWXZqBl4Y2FDp1KelFYFHfiCQ81nLb88aRCp+gq3Mr
	 7wxGGeqpRr3IJ3ULlZ0ChOxhdyB17lIuE+w2ZDiEAF7hTluYbHAdORPXeKSUPecbxG
	 k3CSrubax/aS9QopcyJ1TJjLNBhgKshK0DSCL4wud2xQxemCNmL9TCPVz6pWcrylR2
	 8cKu73Rl7DSDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/13] dmaengine: dw-edma: Add core quiesce
 operations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: Frank.Li@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260620170040.3756043-3-den@valinux.co.jp>
References: <20260620170040.3756043-1-den@valinux.co.jp>
 <20260620170040.3756043-3-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 17:15:35 +0000
Message-Id: <20260620171536.0DE831F000E9@smtp.kernel.org>
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
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11671-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:den@valinux.co.jp,m:Frank.Li@kernel.org,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lists.linux.dev:replyto,vger.kernel.org:from_smtp,valinux.co.jp:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 03C2D6A9572

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The v0 eDMA `ch_quiesce` operation globally disables the DMA engin=
e and clobbers interrupt states for all channels in the direction.
- [High] `dw_edma_v0_core_dir_off` modifies the shared direction-wide `int_=
mask` register without holding `dw->lock`, causing a data race.
--

commit d7eb32d006bf71fa3372ef97f6fa793fa851c5c8
Author: Koichiro Den <den@valinux.co.jp>

dmaengine: dw-edma: Add core quiesce operations

This adds core operations to quiesce only the resources represented by a
dw-edma instance. It implements per-channel and per-direction quiesce
operations for v0 eDMA and HDMA compatible register layouts.

> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/=
dw-edma-v0-core.c
> index 1781ba4f022ec..316d8c94eff9c 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c

[ ... ]

> @@ -160,6 +160,15 @@ static inline u32 readl_ch(struct dw_edma *dw, enum =
dw_edma_dir dir, u16 ch,
>  	readl_ch(dw, dir, ch, &(__dw_ch_regs(dw, dir, ch)->name))
> =20
>  /* eDMA management callbacks */
> +static void dw_edma_v0_core_dir_off(struct dw_edma *dw, enum dw_edma_dir=
 dir)
> +{
> +	SET_RW_32(dw, dir, int_mask,
> +		  EDMA_V0_DONE_INT_MASK | EDMA_V0_ABORT_INT_MASK);

[Severity: High]
Does this modification of the shared int_mask register need to be
protected by dw->lock?

In dw_edma_v0_core_start(), modifications to int_mask are protected by
raw_spin_lock_irqsave(&dw->lock, flags). However,
dw_edma_v0_core_dir_off() directly overwrites the entire int_mask
register without acquiring dw->lock.

Could this cause a data race where a concurrent read-modify-write cycle
in dw_edma_v0_core_start() clobbers the mask state configured here,
leaving the interrupt configuration inconsistent?

> +	SET_RW_32(dw, dir, int_clear,
> +		  EDMA_V0_DONE_INT_MASK | EDMA_V0_ABORT_INT_MASK);
> +	SET_RW_32(dw, dir, engine_en, 0);
> +}

[ ... ]

> +static void dw_edma_v0_core_ch_quiesce(struct dw_edma_chan *chan)
> +{
> +	dw_edma_v0_core_dir_off(chan->dw, chan->dir);
> +}

[Severity: High]
Will this globally disable the DMA engine and clobber interrupt states
for all active channels in this direction?

The .ch_quiesce operation is intended as a per-channel action. However,
dw_edma_v0_core_ch_quiesce() wraps dw_edma_v0_core_dir_off(), which
writes 0 to engine_en and masks all interrupts for the entire direction.

If a device has multiple active channels in the same direction, would
releasing one delegated channel halt and silently drop pending interrupts
for all other active channels in that direction?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620170040.3756=
043-1-den@valinux.co.jp?part=3D2

