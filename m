Return-Path: <dmaengine+bounces-11551-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L+VPMjLrMGrtYgUAu9opvQ
	(envelope-from <dmaengine+bounces-11551-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jun 2026 08:20:34 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA1568C76A
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jun 2026 08:20:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=GcFA6XYQ;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11551-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11551-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 342023034A81
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jun 2026 06:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD873D0C07;
	Tue, 16 Jun 2026 06:16:57 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630A53C9EC3;
	Tue, 16 Jun 2026 06:16:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781590617; cv=none; b=uFZdeAu6euMqBFeOPQWLuO/kDx5w5Eftgb5NNP1z3lqMYLqHIjtQjb4HgeNIoC7UFZ7ivVXpoYGjK723/VEoMr5+Q2X7BAM22NiPXpBzCVo9X926BZ450l/FO0KEQgIORqhueFcoS7Yhs+RO09jGTcmjnnZ1Iv1KyBuBSg6V2Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781590617; c=relaxed/simple;
	bh=/vmV2nqhbY3Vga9iBtrJv+GbUyrIVvrzHAldnyl402Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m4l6C5SijwF1ftjiLlHA/dGu59r3ayK7FQX0h3nyJTul0L8xoQGHKVR0pJy7Xx/RtZEygs7s4JpVvYOvcBEEhuhM/R3vbP3LPXgApXX1P/0F5HTO3ZClCebkTbHh0bIbTFeiHdHAUhjwcJHyVLYuAPCsQSyLOtt4bPcIOihl0Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GcFA6XYQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFD3B1F000E9;
	Tue, 16 Jun 2026 06:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781590616;
	bh=GkBd15AhsKLpfNu+SMogjUdc2j4O8fk7Pk5YeqjFtwk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GcFA6XYQaKXTtu9hUq03iHJtkYHzwN2DExKEdrBE+X1ZxBt+EWrNFlN1VRobatXFH
	 qYSXp569vaZtlGUZdvn85SB/ErHAaDY42H4OjuZkFYhSpyKyL1i9HcYi6H221i85ty
	 4BebqQZ1AtfKPybotliGFdkOP71oocStjvTsjBKhfyBru0CpuPu46Xb8ovOCCtq7+M
	 BJ69xBJ4W65bFnhMYPoudwmT1uuMlbkIPgWY0UYnuBtXqHcfwCu5m+Gcq+Zz0jKp49
	 w1vo3AR9CxfG73plTMeseUOJaMj9Xu+PihhZRRmm6fQCXg9CQRn0Xzpn7IgCwnKpW2
	 fH2j0lC6+DOBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] dmaengine: sun6i-dma: Fix memory leak in
 sun6i_dma_terminate_all
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hongling Zeng" <zenghongling@kylinos.cn>
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org, linux-sunxi@lists.linux.dev
In-Reply-To: <20260616060449.42225-1-zenghongling@kylinos.cn>
References: <20260616060449.42225-1-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 06:16:55 +0000
Message-Id: <20260616061655.CFD3B1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-11551-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url,kylinos.cn:email,vger.kernel.org:from_smtp,lists.linux.dev:replyto];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zenghongling@kylinos.cn,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:linux-sunxi@lists.linux.dev,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1AA1568C76A

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Lockless read of `vchan->phy` in `sun6i_dma_terminate_all` lea=
ds to a TOCTOU race condition that can hijack and corrupt another channel's=
 physical state.
- [High] Concurrent execution of `sun6i_dma_terminate_all` and `sun6i_dma_i=
nterrupt` can lead to a fatal NULL pointer dereference.
- [High] Terminating an active cyclic transfer frees the descriptor without=
 clearing the virt-dma cyclic pointer, leading to a Use-After-Free.
- [High] Plain `spin_lock` on `sdev->lock` in process context deadlocks wit=
h softirq tasklet.
--

commit f08a1b576e146ed2d00cd844a90cf04a64b43397
Author: Hongling Zeng <zenghongling@kylinos.cn>

dmaengine: sun6i-dma: Fix memory leak in sun6i_dma_terminate_all

This commit addresses a memory leak for non-cyclic DMA transfers. It ensures
both cyclic and non-cyclic active descriptors are added to the desc_complet=
ed
list before cleanup to prevent them from being permanently leaked.

> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index a9a254dbf8cb9..46c837e87e6e4 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -945,16 +945,14 @@ static int sun6i_dma_terminate_all(struct dma_chan =
*chan)
> =20
>  	spin_lock_irqsave(&vchan->vc.lock, flags);

[Severity: High]
This is a pre-existing issue, but does acquiring sdev->lock earlier in this
function create a deadlock risk?

sun6i_dma_terminate_all() calls spin_lock(&sdev->lock) without disabling
softirqs. If a hardware interrupt fires on the same CPU while the lock is
held, the kernel processes pending softirqs upon returning from the interru=
pt.

This runs sun6i_dma_tasklet(), which attempts to acquire the lock using
spin_lock_irq(&sdev->lock). Will this cause a self-deadlock since the
interrupted process context already holds the lock?

> =20
> -	if (vchan->cyclic) {
> -		vchan->cyclic =3D false;
> -		if (pchan && pchan->desc) {
> -			struct virt_dma_desc *vd =3D &pchan->desc->vd;
> -			struct virt_dma_chan *vc =3D &vchan->vc;
> +	if (pchan && pchan->desc && pchan->desc !=3D pchan->done) {

[Severity: Critical]
This isn't a bug introduced by this patch, but does this code have a race
condition that can corrupt another channel?

At the top of sun6i_dma_terminate_all(), the pchan pointer is cached
locklessly from vchan->phy before taking any locks.

Concurrently, sun6i_dma_tasklet() can complete a transfer, set
vchan->phy =3D NULL, and reassign this exact pchan to a different virtual
channel.

When this code subsequently acquires vchan->vc.lock, wouldn't it use the
stale pchan pointer to inappropriately access descriptors and halt hardware
belonging to the newly assigned channel?

> +		struct virt_dma_desc *vd =3D &pchan->desc->vd;
> +		struct virt_dma_chan *vc =3D &vchan->vc;
> =20
> -			list_add_tail(&vd->node, &vc->desc_completed);
> -		}
> +		list_add_tail(&vd->node, &vc->desc_completed);

[Severity: High]
This is a pre-existing issue, but does terminating an active cyclic transfer
leave a dangling pointer here?

The active descriptor is added to desc_completed so it can be freed by
vchan_dma_desc_free_list(), but the virt-dma pointer vc->cyclic is never
cleared.

If vchan_complete() runs asynchronously from the tasklet, couldn't it see a
non-NULL vc->cyclic and dereference the freed descriptor? Standard virt-dma
drivers typically use vchan_terminate_vdesc() to clear this.

>  	}
> =20
> +	vchan->cyclic =3D false;
>  	vchan_get_all_descriptors(&vchan->vc, &head);
> =20
>  	if (pchan) {

[ ... ]

>  		vchan->phy =3D NULL;
>  		pchan->vchan =3D NULL;
>  		pchan->desc =3D NULL;

[Severity: High]
This isn't a bug introduced by this patch, but can clearing pchan->desc here
race with the interrupt handler and cause a NULL pointer dereference?

In sun6i_dma_interrupt(), vchan->cyclic is read locklessly. If it evaluates
to false, the handler blocks on spin_lock(&vchan->vc.lock):

sun6i_dma_interrupt() {
    ...
    if (!vchan->cyclic) {
        spin_lock(&vchan->vc.lock);
        vchan_cookie_complete(&pchan->desc->vd);
        ...
}

If sun6i_dma_terminate_all() concurrently acquires the lock and sets
pchan->desc =3D NULL, when the interrupt handler unblocks, wouldn't
evaluating &pchan->desc->vd crash the kernel?

>  		pchan->done =3D NULL;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616060449.4222=
5-1-zenghongling@kylinos.cn?part=3D1

