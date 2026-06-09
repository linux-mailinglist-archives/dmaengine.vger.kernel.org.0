Return-Path: <dmaengine+bounces-11377-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aRhfDkiWKGo5GgMAu9opvQ
	(envelope-from <dmaengine+bounces-11377-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 00:40:08 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 867E1664A07
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 00:40:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=aYPspgnh;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11377-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11377-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4151230177B2
	for <lists+dmaengine@lfdr.de>; Tue,  9 Jun 2026 22:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F2217A309;
	Tue,  9 Jun 2026 22:31:33 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89ABC3438A0
	for <dmaengine@vger.kernel.org>; Tue,  9 Jun 2026 22:31:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781044293; cv=none; b=eiVjIerKZI9SXOtv9j3K9GnCo3L2BYKJsCqKImRxnaiL4JbrE+bvd8zYlUc/IPIssKGrXM4yFA8OT2Sp0GIf9/1X7F/s6OqgWEfyXHkBesCBnf7I2A8LLGo6bJVdUWnZ+/rkLYRvkcOum2xVEOYwnrYZF+bJKTZ0TvB3ljMH7uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781044293; c=relaxed/simple;
	bh=p0ZlgPgxaXE3TjfCoLNGgcEJ5r4QoEWdPk+1Xsjd30I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VE20uQSmfG9gHlNBr40ZuMgBDsFliMTE4YK5b3Po6OWf81OQiGjTIcTW3tIfhBZ6RNP4+XBNSVd5JhGTm8FZMTNa4Oz0du/cCGRkGpqY17+Bye5fq8TTufF6uFur6Rb8htgb3bssDLL0Jrx8qDoMY+Yt/B+YmfFgDPHUBsQIPlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYPspgnh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 060021F00893;
	Tue,  9 Jun 2026 22:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781044292;
	bh=iTwi7p2fTp1jHNGCOgXdNjXhOqs+2J3Wb2O90H7QSCc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aYPspgnh4Z2nFsIO/H1Y/tE8kHzpJXWviE7EHakgoGUeA4H5hZewERY9M4eprXsgy
	 rtBnYYwWA7K79HqQ5lM+c4B/VnmW753YbZL3FTi7sPbLwKTseBmAEjiz+CL3gKehg9
	 RUIqrfsd8QP86WrLmgxS+VCwQmp15nu4JsU6d+e9o4TG4oRseedDNneWPlNS6N7Qsy
	 TUSce+ErPcJbMP8w7CNxk4HNNfMZSD9GvUnH+L92iyA6M2R480tHGTxZJkAlTj97sM
	 WrJdfWkEFmW/bnV8GTSe5/cfYfnwwZhDxD1tnlq8ZzQu2pJ2XsNcWmO0qAhhd7q63g
	 quvYJQ554U1Ag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv3 01/15] dmaengine: fsldma: kill tasklet before removing
 channel
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260609221926.35538-2-rosenp@gmail.com>
References: <20260609221926.35538-2-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 22:31:31 +0000
Message-Id: <20260609223132.060021F00893@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-11377-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,lists.linux.dev:replyto,sashiko.dev:url,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 867E1664A07

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unhandled Error Return from dma_async_device_register() leads to s=
ilent probe failure and resource leaks.
- [High] Off-by-one error in the fsldma_request_irqs() error unwind path at=
tempts to free the IRQ that just failed to be requested.
- [High] Double unlock in fsldma_suspend_late() error path causes unbalance=
d spinlocks.
- [High] Client callback is invoked with the channel descriptor spinlock he=
ld, which can lead to a self-deadlock.
--

commit 89849d3f67e5b5c4ccce67310ff8f24602b221dc
Author: Rosen Penev <rosenp@gmail.com>

dmaengine: fsldma: kill tasklet before removing channel
   =20
Add tasklet_kill() in fsl_dma_chan_remove() to prevent a race
where the tasklet, scheduled by the IRQ handler, runs after
the channel has been freed.

> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> index 22d62d958abd9..0e2f84862261c 100644
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c
> @@ -1205,6 +1205,7 @@ static int fsl_dma_chan_probe(struct fsldma_device =
*fdev,
> =20
>  static void fsl_dma_chan_remove(struct fsldma_chan *chan)
>  {
> +	tasklet_kill(&chan->tasklet);
>  	irq_dispose_mapping(chan->irq);
>  	list_del(&chan->common.device_node);
>  	iounmap(chan->regs);

[Severity: High]
This is a pre-existing issue, but does fsldma_of_probe() ignore the return
value of dma_async_device_register()?

If registration fails due to an IDA allocation error, the probe function
unconditionally returns 0, falsely reporting success to the driver core.
Later, when the device is removed, fsldma_of_remove() will call
dma_async_device_unregister() on a device that was never fully registered.

Can this corrupt IDA states or trigger assertions and kernel panics?

Will allocated resources like memory, IRQs, and iomappings leak because the
error cleanup path is bypassed?

drivers/dma/fsldma.c:fsldma_of_probe() {
    ...
	dma_async_device_register(&fdev->common);
	return 0;
}

[Severity: High]
This is a pre-existing issue, but could the rollback loop in
fsldma_request_irqs() be missing a decrement of 'i' before the first
iteration?

If request_irq() fails for a channel at index 'i', the code jumps to
out_unwind and begins the cleanup loop starting at the exact same index 'i'.
It unconditionally calls free_irq() for this channel. Because request_irq()
just failed, the IRQ was never successfully allocated.

Will calling free_irq() on an unrequested IRQ trigger a kernel warning?

drivers/dma/fsldma.c:fsldma_request_irqs() {
    ...
out_unwind:
	for (/* none */; i >=3D 0; i--) {
		chan =3D fdev->chan[i];
		if (!chan)
			continue;

		if (!chan->irq)
			continue;

		free_irq(chan->irq, chan);
	}
}

[Severity: High]
This is a pre-existing issue, but are we double unlocking chan->desc_lock
in the error path of fsldma_suspend_late()?

In fsldma_suspend_late(), the forward loop acquires the lock, updates state,
and releases it. If a subsequent channel is not idle, it jumps to out: and
iterates backward, unlocking all previously processed channels:

drivers/dma/fsldma.c:fsldma_suspend_late() {
    ...
out:
	for (; i >=3D 0; i--) {
		chan =3D fdev->chan[i];
		if (!chan)
			continue;
		chan->pm_state =3D RUNNING;
		spin_unlock_bh(&chan->desc_lock);
	}
}

Since the locks for these earlier channels were already released during the
forward iteration, might this corrupt the lock state and local_bh preemption
count, leading to warnings and potential crashes?

[Severity: High]
This is a pre-existing issue, but is the client callback invoked with the
channel descriptor spinlock held?

In dma_do_tasklet(), chan->desc_lock is acquired before cleaning up complet=
ed
descriptors:

drivers/dma/fsldma.c:dma_do_tasklet() {
    ...
	spin_lock(&chan->desc_lock);

	/* the hardware is now idle and ready for more */
	chan->idle =3D true;

	/* Run all cleanup for descriptors which have been completed */
	fsldma_cleanup_descriptors(chan);
    ...
}

The cleanup chain eventually calls dmaengine_desc_get_callback_invoke()
without dropping the spinlock:

drivers/dma/fsldma.c:fsldma_run_tx_complete_actions() {
    ...
		/* Run the link descriptor callback function */
		dmaengine_desc_get_callback_invoke(txd, NULL);
    ...
}

If the client callback attempts to submit new transfers, it reaches
fsl_dma_tx_submit() which attempts to acquire the same non-recursive lock:

drivers/dma/fsldma.c:fsl_dma_tx_submit() {
    ...
	spin_lock_bh(&chan->desc_lock);
    ...
}

Could this lead to a self-deadlock?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609221926.3553=
8-2-rosenp@gmail.com?part=3D1

