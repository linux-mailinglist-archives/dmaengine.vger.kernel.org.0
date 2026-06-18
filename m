Return-Path: <dmaengine+bounces-11588-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dV53BRFVM2pE/gUAu9opvQ
	(envelope-from <dmaengine+bounces-11588-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 04:16:49 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C36169D1DC
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 04:16:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MRzK18kh;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11588-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11588-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8BDE300DF47
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 02:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B97211466;
	Thu, 18 Jun 2026 02:16:46 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF781D9663;
	Thu, 18 Jun 2026 02:16:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781749006; cv=none; b=Qy/dClkXo97wJl8X425Qz7KL6FoEkiZoURjlE8vGIJGgoQMs2YRy3HjX7qfw9huhH7OJbdbPGuqCPPxUrId8xJgmYMyc8qcAKST/Bsl4TKlvMOCuPmWU3auXr255/a+7w3ef3tbY7ytQppMOk4NVxFmh3FkiYYfReMVVvK5EHKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781749006; c=relaxed/simple;
	bh=lSHjqzVrlddUsMwDb+Oxb7cBANZj44D00S9yHZcTeQI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ai3zLxhI8GC2FeAFtoYwB/pCIATdgMNbDlWHYJH/FUcFpD0Nvot8BuTeK9jPDWoehJSh3k3g5VvI9BNAuDLloFY9JBPYMy5v+ihS9o3DEPoBLtYNCG1RLsfBDS9UlttVHZXKmzDFO9FRcipkRvYzMFFk0xB4PYf34x49FNWT/go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRzK18kh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 506581F000E9;
	Thu, 18 Jun 2026 02:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781749004;
	bh=A3Jx5tfjdh+QIbNxY5dHfCOAlHbvLXE/ZO2DTdaEjjA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MRzK18khMISIZPS5V8gJZniablQIK9OERs5Zc53DhRhgf19uMpRDoDeDds97r9Z+m
	 Fy8FzsFdZKiW9dct0UqQvdVWISWlJx5ZXaXsx65maSXqgn0ZY5SU+rAsuGDSvuy9bx
	 AHpMDEak5Agtopy9WIx+j16UdYRMY5rDJOQrtNQmfvZ7NbUL5SHm9eoLm7xXtuMoL7
	 aW0Riuz/p+skSZ8zlmWIvJVEK7gezNcx/oE0prfSrWWBjufYK2Do1RILguesSltotN
	 SRmVx0r3U5rSYWQmI4ozbBfL9FCWPG1RwKWu6/lV4yVnEhhKhUQzP2WmuPoXP79My9
	 fQE/ZrCuEKPUg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] dmaengine: sun6i-dma: Fix memory leak in
 sun6i_dma_terminate_all
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hongling Zeng" <zenghongling@kylinos.cn>
Cc: linux-sunxi@lists.linux.dev, vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260618020609.1155962-1-zenghongling@kylinos.cn>
References: <20260618020609.1155962-1-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 02:16:43 +0000
Message-Id: <20260618021644.506581F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-11588-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,kylinos.cn:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zenghongling@kylinos.cn,m:linux-sunxi@lists.linux.dev,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4C36169D1DC

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lockless read of `vchan->phy` causes a Time-of-Check to Time-of-Us=
e (TOCTOU) race, leading to cross-channel list corruption and improper hard=
ware state modifications.
- [High] Lack of synchronization between `sun6i_dma_terminate_all` and the =
hardirq handler `sun6i_dma_interrupt` leads to an unmitigated NULL pointer =
dereference.
--

commit 0f302155373f5ca26acb89959d317a9f6c68ecc0
Author: Hongling Zeng <zenghongling@kylinos.cn>

dmaengine: sun6i-dma: Fix memory leak in sun6i_dma_terminate_all

This commit fixes a memory leak when terminating DMA transfers by using
vchan_terminate_vdesc() to handle both cyclic and non-cyclic descriptors.
It also prevents completed descriptors from being double-added to the list.

> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index a9a254dbf8cb9..f47a326dd7ffa 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -945,16 +945,13 @@ static int sun6i_dma_terminate_all(struct dma_chan =
*chan)
> =20
>  	spin_lock_irqsave(&vchan->vc.lock, flags);
> =20
> -	if (vchan->cyclic) {
> -		vchan->cyclic =3D false;
> -		if (pchan && pchan->desc) {
> -			struct virt_dma_desc *vd =3D &pchan->desc->vd;
> -			struct virt_dma_chan *vc =3D &vchan->vc;
> +	if (pchan && pchan->desc && pchan->desc !=3D pchan->done) {
> +		struct virt_dma_desc *vd =3D &pchan->desc->vd;
> =20
> -			list_add_tail(&vd->node, &vc->desc_completed);
> -		}
> +		vchan_terminate_vdesc(vd);

[Severity: High]
This is a pre-existing issue, but by calling vchan_terminate_vdesc() here,
does this code now trigger list corruption or a lockdep splat?

Earlier in sun6i_dma_terminate_all(), the physical channel is read lockless=
ly:

    struct sun6i_pchan *pchan =3D vchan->phy;

If a concurrent DMA tasklet frees and reassigns this physical channel to a
completely different virtual channel before spin_lock_irqsave() is acquired,
we evaluate a stale pchan. Passing this foreign descriptor into
vchan_terminate_vdesc() will attempt to add it to desc_terminated while
holding the wrong lock, corrupting the list.

>  	}
> =20
> +	vchan->cyclic =3D false;
>  	vchan_get_all_descriptors(&vchan->vc, &head);
> =20
>  	if (pchan) {

[Severity: High]
This is a pre-existing issue, but does clearing the physical channel state
here lead to a NULL pointer dereference in the interrupt handler?

Just below this hunk in sun6i_dma_terminate_all(), the code sets
pchan->desc =3D NULL without synchronizing with the IRQ handler:

    if (pchan) {
        writel(DMA_CHAN_ENABLE_STOP, pchan->base + DMA_CHAN_ENABLE);
        writel(DMA_CHAN_PAUSE_RESUME, pchan->base + DMA_CHAN_PAUSE);
        vchan->phy =3D NULL;
        pchan->vchan =3D NULL;
        pchan->desc =3D NULL;
        pchan->done =3D NULL;
    }

If sun6i_dma_interrupt() is running concurrently on another CPU, it
could be executing vchan_cookie_complete(&pchan->desc->vd) or
vchan_cyclic_callback(&pchan->desc->vd). Without synchronize_irq()
or similar to wait for pending handlers, this will pass a NULL offset
to those helpers, which then dereference vd->tx.chan.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618020609.1155=
962-1-zenghongling@kylinos.cn?part=3D1

