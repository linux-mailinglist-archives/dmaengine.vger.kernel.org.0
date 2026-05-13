Return-Path: <dmaengine+bounces-10448-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOrvDbn4BGpwRAIAu9opvQ
	(envelope-from <dmaengine+bounces-10448-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 00:18:33 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B84E853B5D8
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 00:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ADBC2301842B
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 22:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2594A38CFF8;
	Wed, 13 May 2026 22:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJfyMixe"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA7B38B12E
	for <dmaengine@vger.kernel.org>; Wed, 13 May 2026 22:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778710683; cv=none; b=Bd1HyB+E/u04rbxUg/3ac61IiqwsQ74RDAmzG27i1s2zsGYLL6yg3sQtdRkAzYUUAckv5R+SVdlo9f4Tm5JUVrKaQrOqZJp6wL9JQwC1de9G+dPqm+X3Pg9nmCUuCDEValzkY9TrcYijhAQzjyjxbeliS/zAxIlXn5iIVRBDyKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778710683; c=relaxed/simple;
	bh=ijBlDbTdd26R1W9Xub9ewrV2eh++UeQXkeySoCJyc/k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HNWjxCgLQIMK9vCtzrkeJR7fsdrmlhRig5RlkofZ2GGWc9naIbpCDbMKNX8Pxw7pBzO2wqSSbwSkx6ihmDTB0qB+9uEEWw9GY+4aEDlgmk6PyDo1j/qGz+NPMRGL51SgKQGtK0zTdBeb0VcoqxY7+C941mI/Q1PIaer5RK8ih9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJfyMixe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E623FC19425;
	Wed, 13 May 2026 22:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778710683;
	bh=ijBlDbTdd26R1W9Xub9ewrV2eh++UeQXkeySoCJyc/k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=IJfyMixeAsdd96zl1Pni1jmfyS7fxVuEj4mKjSTlCdtX/QyU7z3DQAJiang5uJory
	 RW1ZQZOnKiVjkhh3nsIT6+FBcKcvHZE8Vpyw1tCoAjJKoxjX3vP+Bjw+CsXCWE5F2j
	 wJW4BYjxYLikfjYgOMhDsrzRQ6AL5w8SBiQ+tau/++uOrZEaN/uCrHFPcDU0+hOC+2
	 m9wyBGKvX5HeucY4PlwmnApwc1FSeJMdMTgD1pko5+4KaujzONQXkRh4NWKWFD0aL3
	 taDoBHt9BbNoVsaz7onUrDBRyolUqGtzquLjt2WuaQZ0XJZIGgLDy3ftn2wRfJ/i4A
	 NlXZKxhNjJ1Iw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 03/17] dmaengine: sh: rz-dmac: Use
 list_first_entry_or_null()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea.uj@bp.renesas.com>
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, wsa+renesas@sang-engineering.com, vkoul@kernel.org
In-Reply-To: <20260512121219.216159-4-claudiu.beznea.uj@bp.renesas.com>
References: <20260512121219.216159-4-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 22:18:02 +0000
Message-Id: <20260513221802.E623FC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: B84E853B5D8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10448-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,renesas.com:email,smtp.kernel.org:mid,sashiko.dev:url,lists.linux.dev:replyto];
	RCVD_COUNT_THREE(0.00)[4];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Pre-existing severe race condition exposing uninitialized descript=
ors to hardware execution queues, causing transfers to permanently hang.
--

commit 47f89a64a0228eb1a1e5b15d4e627cac741a15c7
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

dmaengine: sh: rz-dmac: Use list_first_entry_or_null()

This commit simplifies descriptor allocation by replacing an open-coded
list_empty() check and list_first_entry() call with a single call to
list_first_entry_or_null().

> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index 6d80cb668957f..1717b407ab9e9 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -503,11 +503,10 @@ rz_dmac_prep_dma_memcpy(struct dma_chan *chan, dma_=
addr_t dest, dma_addr_t src,
>  		__func__, channel->index, &src, &dest, len);
> =20
>  	scoped_guard(spinlock_irqsave, &channel->vc.lock) {
> -		if (list_empty(&channel->ld_free))
> +		desc =3D list_first_entry_or_null(&channel->ld_free, struct rz_dmac_de=
sc, node);
> +		if (!desc)
>  			return NULL;
> =20
> -		desc =3D list_first_entry(&channel->ld_free, struct rz_dmac_desc, node=
);
> -
>  		desc->type =3D RZ_DMAC_DESC_MEMCPY;
>  		desc->src =3D src;
>  		desc->dest =3D dest;

This isn't a bug introduced by this commit, but there appears to be a
pre-existing race condition in the functionally modified block.

At the end of the scoped_guard block for channel->vc.lock, the descriptor is
moved from ld_free to ld_queue, and then the lock is dropped. Outside the
lock, vchan_tx_prep() is called.

If rz_dmac_irq_handler_thread() runs in the exact window between dropping t=
he
lock and vchan_tx_prep(), could it prematurely pull the descriptor from
ld_queue?

It would then call rz_dmac_xfer_desc(), which checks vchan_next_desc().
Because the descriptor hasn't been fully initialized or submitted to virt-d=
ma
yet, vchan_next_desc() would return NULL, causing rz_dmac_xfer_desc() to
return 0 without programming the hardware.

The IRQ handler would then erroneously move the descriptor to ld_active. La=
ter,
when the client finally calls rz_dmac_issue_pending(), it would find ld_que=
ue
empty and do nothing.

Would this cause the transfer to remain stuck in ld_active and never execut=
e?

Note that this issue is fixed later in the patch series by commit "dmaengin=
e:
sh: rz-dmac: Use virt-dma APIs for channel descriptor processing".

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512121219.2161=
59-1-claudiu.beznea.uj@bp.renesas.com?part=3D3

