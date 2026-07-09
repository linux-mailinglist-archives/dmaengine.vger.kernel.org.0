Return-Path: <dmaengine+bounces-12154-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5queBsP8TmrQYQIAu9opvQ
	(envelope-from <dmaengine+bounces-12154-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 03:43:31 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1F372BBA7
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 03:43:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="GWU2uo/m";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12154-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-12154-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 22D403016B7D
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 01:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F552227BB9;
	Thu,  9 Jul 2026 01:43:27 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F169C2E413;
	Thu,  9 Jul 2026 01:43:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783561407; cv=none; b=jqVbFkgP3Aef6nAmPzxZbmjeO4r+N5VqtKMeGFlPM8wRlXYOzWhOhXzz/6Y89r4znw52N4COM9wZ6PFmqKn9+oVxkWK8VOO0iJXxk9U341D83FQ4+CVPInqcjiQhqk+hCzhral1W7nb+nvp8xnLpcEmLZ1MRtgdrj6SAWHFcdQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783561407; c=relaxed/simple;
	bh=QucKtjW5Es2Y6XWtiKnZTxDy5OsDpzR4eW2SF73IBYs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dr+mgfhzq5/5y+Jyz+Ok4xUjQrLY5gdzIe2NRhpviToxTCfhMLTQQGhzWPN+8D0SDwMe5nBZjx4v6Ul201uJekiVdK1ez1xYpNsRR7bLhungOIDK+wLYVpxPWaT9HfNpr2tzxeVfbC5Cdpmgo9nxNgHqJm8qhzl7ryja3GWUClA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWU2uo/m; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40ACB1F00A3E;
	Thu,  9 Jul 2026 01:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783561405;
	bh=Sau3igwgMM10PDaSFaKsGh3W1fSSFijGO4LQJddaYe4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GWU2uo/mMoSrxybGCoqw5EeN71hmPXDmES+hpXfQujzG90GEDlIB4LHSvZw8uG2b1
	 WlUF7a/qf26TnnYC3+Zo11VJ0S/8QXzCpBNarEBBzAJ1JqdNHswuL2+Q8LY1QTHYDC
	 4HHA/zkOp96St+gaL3Ac1y0RXvD3D148QwS3oEXE5wI872qYZRG+mkr2NzpEOVnEky
	 7bSO9mUPfa3Yr9DyRTi8tmSd2P81qUX85d3PA+fndW56UpTgNpi8n13TXdmQRq8+z5
	 1o9LA8c/dtugWQXbIcsODN96wuXL+cb7FP05SZAKpIIDZPyDIQXvC4ZDtSGx450FSJ
	 6KwU1e77HrwYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] dmaengine: sun6i-dma: Fix use-after-free in error
 handling paths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hongling Zeng" <zenghongling@kylinos.cn>
Cc: Frank.Li@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org, linux-sunxi@lists.linux.dev
In-Reply-To: <20260709013118.616467-1-zenghongling@kylinos.cn>
References: <20260709013118.616467-1-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 01:43:24 +0000
Message-Id: <20260709014325.40ACB1F00A3E@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12154-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lists.linux.dev:replyto,kylinos.cn:email,sashiko.dev:url,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zenghongling@kylinos.cn,m:Frank.Li@kernel.org,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:linux-sunxi@lists.linux.dev,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9F1F372BBA7

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Deadlock in sun6i_dma_terminate_all and sun6i_dma_pause due to uns=
afe lock context.
- [High] Race condition in sun6i_dma_terminate_all, sun6i_dma_pause, and su=
n6i_dma_resume due to lockless read of vchan->phy, causing memory corruptio=
n and state inconsistency.
- [High] Race condition causing a NULL pointer dereference in sun6i_dma_int=
errupt.
--

--- Patch [1]: [PATCH v5] dmaengine: sun6i-dma: Fix use-after-free in error=
 handling paths ---
commit 4eb50f2f9528d3f1d66f48feef49a56e2cf57490
Author: Hongling Zeng <zenghongling@kylinos.cn>

dmaengine: sun6i-dma: Fix use-after-free in error handling paths

In error handling paths, the for loop frees v_lli in the loop body,
then accesses v_lli->v_lli_next and v_lli->p_lli_next in the
increment expression, which is use-after-free.

Fix by refactoring the cleanup into a helper function sun6i_dma_free_desc()
that saves both the next virtual and physical pointers before freeing the
current node, preventing the use-after-free.

> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index a9a254dbf8cb9..7a79f346250a5 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -406,16 +406,12 @@ static inline void sun6i_dma_dump_lli(struct sun6i_=
vchan *vchan,
>  		v_lli->len, v_lli->para, v_lli->p_lli_next);
>  }
> =20
> -static void sun6i_dma_free_desc(struct virt_dma_desc *vd)
> +static void sun6i_dma_free_desc(struct sun6i_dma_dev *sdev,
> +				struct sun6i_desc *txd)
>  {

[ ... ]

[Severity: High]
This is a pre-existing issue, but can this cause a deadlock?

In sun6i_dma_terminate_all() and sun6i_dma_pause(), we acquire the lock
without disabling softirqs:

drivers/dma/sun6i-dma.c:sun6i_dma_terminate_all() {
    ...
	spin_lock(&sdev->lock);
	list_del_init(&vchan->node);
	spin_unlock(&sdev->lock);
    ...
}

If a hardware interrupt for the DMA controller fires on the same CPU while
this lock is held, the hardirq handler will execute and schedule
sun6i_dma_tasklet. Upon return from the hardware interrupt, softirqs are
processed immediately on the same CPU, forcing the tasklet to execute.

The tasklet unconditionally attempts to acquire sdev->lock using
spin_lock_irq():

drivers/dma/sun6i-dma.c:sun6i_dma_tasklet() {
    ...
	spin_lock_irq(&sdev->lock);
    ...
}

Because the lock is already held by the interrupted process context on the
same CPU, won't the tasklet spin forever and deadlock the CPU? Should these
use spin_lock_bh() or spin_lock_irqsave()?

[Severity: High]
This isn't a bug introduced by this patch, but does this lockless read of
vchan->phy create a race condition?

drivers/dma/sun6i-dma.c:sun6i_dma_terminate_all() {
	struct sun6i_pchan *pchan =3D vchan->phy;
    ...
	spin_lock(&sdev->lock);
	list_del_init(&vchan->node);
	spin_unlock(&sdev->lock);

	spin_lock_irqsave(&vchan->vc.lock, flags);
    ...
	if (pchan) {
		writel(DMA_CHAN_ENABLE_STOP, pchan->base + DMA_CHAN_ENABLE);
		writel(DMA_CHAN_PAUSE_RESUME, pchan->base + DMA_CHAN_PAUSE);
		vchan->phy =3D NULL;
	}
    ...
}

pchan =3D vchan->phy is read at the very beginning of the function, outside
of any locks.

Concurrently, sun6i_dma_tasklet() can acquire sdev->lock, assign a physical
channel to vchan->phy, and start the hardware transfer. If this race occurs,
sun6i_dma_terminate_all() sees pchan as NULL.

It subsequently acquires the necessary locks but skips the if (pchan) block,
failing to write DMA_CHAN_ENABLE_STOP to the hardware.

Will this function then return success, deceiving the caller into believing
the channel is stopped and descriptors are freed, while the hardware contin=
ues
transferring data into freed memory?

The same lockless read in sun6i_dma_resume() also seems to allow the virtual
channel to be re-added to the pending list while already having an active
physical channel.

[Severity: High]
This is a pre-existing issue, but can this sequence lead to a NULL pointer
dereference?

drivers/dma/sun6i-dma.c:sun6i_dma_interrupt() {
    ...
			if (vchan && (status & vchan->irq_type)) {
				if (vchan->cyclic) {
					vchan_cyclic_callback(&pchan->desc->vd);
				} else {
					spin_lock(&vchan->vc.lock);
					vchan_cookie_complete(&pchan->desc->vd);
    ...
}

In sun6i_dma_interrupt(), if the channel is not cyclic, the code blocks on
spin_lock(&vchan->vc.lock).

Concurrently, a process context thread running sun6i_dma_terminate_all()
can acquire vchan->vc.lock, stop the channel, and set pchan->desc =3D NULL.

Once sun6i_dma_terminate_all() releases the lock, the interrupt handler
unblocks and immediately calls vchan_cookie_complete(&pchan->desc->vd).

Since pchan->desc has just been nullified, won't dereferencing
pchan->desc->vd cause a kernel oops?

Additionally, if vchan->cyclic is true, the interrupt handler calls
vchan_cyclic_callback(&pchan->desc->vd) without taking any locks, exposing
pchan->desc to concurrent nullification.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709013118.6164=
67-1-zenghongling@kylinos.cn?part=3D1

