Return-Path: <dmaengine+bounces-12174-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BI0PJQCfT2rTlAIAu9opvQ
	(envelope-from <dmaengine+bounces-12174-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 15:15:44 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A191D731793
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 15:15:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="ZeYDuZ/L";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12174-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-12174-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BF0123000B95
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 13:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2FC1A683E;
	Thu,  9 Jul 2026 13:15:39 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDADC1FF7C8
	for <dmaengine@vger.kernel.org>; Thu,  9 Jul 2026 13:15:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783602939; cv=none; b=U65AXSK+XNsjz0zOlCE+im3P7/FkybUohAhVxq9Rk3g6b2b7a4Qv2TzTUr6lpu5L+Rb8Bi46vi92W+0PweVrkkHgaQwn19VAn/cpMAvU1wDXeUHfEp9rIsz6Pyul86EcDaib8oTDCtmw8LUC+772O8GzCE6tfu+k/zrOXUSV8/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783602939; c=relaxed/simple;
	bh=DBdviOTCUCScCLkN3ZastM0yDfWbpSXtKY3K3TrJ3H0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gYkaCy04l+zAIblegTQiPvzz5adfXB7xo7LEfahFd2LZ6bVsvlxCiG5Mi34W3YUqK+LevD3B0qzCvX064hfq3q5zwu5Q5Ou3xvTQmBujoGi4e3HDgcXxIo6Khg9cogWy8RDUAu3g/Rk7g3OoigCO6hNonv7Gf9X+W8ow5NAiY1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZeYDuZ/L; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA6B1F000E9;
	Thu,  9 Jul 2026 13:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783602937;
	bh=KmJe+KqJ4RIUMsLhUnfUz/n5RMTwQedUyWPBJEraxcg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZeYDuZ/Lac2Uzr5MLm6C+0a/gtpCnuo7ms0JwOyQ4evCZIIiPi5KQKb/bLN9bwzjC
	 3+ltQlx31Hdn5XSiZ9M5kpQ25Fl1Pv8h1OT9wBkYgSrvVr54rgSWcYdv2XGjzg14ip
	 /qp5HEY65nT5eBvVx3zXbUGDriul9FCr8RSTnwUeWdAEL90KKNzAJ3i5yZdvjbeMtY
	 bP3PjPZzb5a5PkMABlteJ1eRqoYQDcyQFw3rgcZhGBARJ6rju7dxHllXVwQjU7L+j7
	 CDUz6AW2NMHQ+o5jYbadcvojTfxnNtO7coPQCjm2XO0vgjX1ivM95V7+3ZIazrcXDF
	 reM95JkhRk6Jw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dmaengine: pl330: Fix NULL pointer dereference in
 tasklet during channel release
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mayank Mishra" <mayankmishraa@google.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260709125914.1079328-1-mayankmishraa@google.com>
References: <20260709125914.1079328-1-mayankmishraa@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 13:15:36 +0000
Message-Id: <20260709131537.4CA6B1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-12174-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:mayankmishraa@google.com,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,smtp.kernel.org:mid,vger.kernel.org:from_smtp,sashiko.dev:url,lists.linux.dev:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A191D731793

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Critical] Newly introduced non-recursive spinlock self-deadlock in pl330=
_free_chan_resources() when aborting pending descriptors.

Pre-existing issues:
- [Critical] Concurrent modifications to the shared `desc_pool` without acq=
uiring `pool_lock` causes linked-list corruption.
- [Critical] Client callbacks for aborted descriptors can be invoked asynch=
ronously after the client has freed the channel.
- [Critical] Out-of-bounds array access in pl330_update() upon spurious har=
dware events.
- [High] Missing pch->thread validation in fill_queue() leaves a NULL point=
er dereference vulnerability, rendering the patch's fix incomplete.
--

--- Patch [1]: [PATCH] dmaengine: pl330: Fix NULL pointer dereference in ta=
sklet during channel release ---
commit 46db9642cb9437f521f1604962399f1fd25810d2
Author: Mayank Mishra <mayankmishraa@google.com>

dmaengine: pl330: Fix NULL pointer dereference in tasklet during channel re=
lease

When a DMA transfer aborts, the interrupt handler schedules completion
callbacks and marks descriptors as DONE. Subsequent channel release via
pl330_free_chan_resources() clears the hardware thread by calling
pl330_release_channel(), which sets pch->thread to NULL. This commit
adds pch->lock inside pl330_free_chan_resources() to avoid a TOCTOU race
condition where pl330_tasklet() dereferences pch->thread after it is set
to NULL.

> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
> index 25ba84b187041..acb9949f4a626 100644
> --- a/drivers/dma/pl330.c
> +++ b/drivers/dma/pl330.c
> @@ -2086,12 +2086,23 @@ static void pl330_tasklet(struct tasklet_struct *=
t)
>  	fill_queue(pch);

[Severity: High]
This is a pre-existing issue, but might the missing pch->thread validation
in fill_queue() result in a NULL pointer dereference, leaving the patch's f=
ix
incomplete?

The patch correctly identifies that pch->thread can be set to NULL
asynchronously, but it only adds validation checks after fill_queue() is
executed inside pl330_tasklet().

If the tasklet runs after pch->thread is cleared, fill_queue() iterates over
pch->work_list and passes the NULL thread to pl330_submit_req():

drivers/dma/pl330.c:fill_queue() {
    ...
    ret =3D pl330_submit_req(pch->thread, desc);
    ...
}

Could passing a NULL pch->thread directly lead to a crash when it is
dereferenced?

>  	if (list_empty(&pch->work_list)) {
> -		spin_lock(&pch->thread->dmac->lock);
> -		_stop(pch->thread);
> -		spin_unlock(&pch->thread->dmac->lock);
> -		power_down =3D true;
> -		pch->active =3D false;
> -	} else {
> +		/*
> +		 * Verify pch->thread is still valid before dereferencing
> +		 * it, as it could be set to NULL asynchronously during
> +		 * channel release after transfer aborts.
> +		 */
> +		if (pch->thread) {

[ ... ]

> @@ -2357,7 +2369,14 @@ static void pl330_free_chan_resources(struct dma_c=
han *chan)
>  	tasklet_kill(&pch->task);

[Severity: Critical]
This isn't a bug introduced by this patch, but could client callbacks for
aborted descriptors be invoked asynchronously after the client has freed the
channel?

During channel release, pl330_free_chan_resources() invokes tasklet_kill()
early to synchronize. However, pl330_release_channel() subsequently aborts
active descriptors and calls dma_pl330_rqcb(), which reschedules the taskle=
t:

drivers/dma/pl330.c:dma_pl330_rqcb() {
    ...
    tasklet_schedule(&pch->task);
    ...
}

pl330_free_chan_resources() then returns, prompting the client driver to
fully free its DMA context. Will the scheduled tasklet execute later and
invoke dmaengine_desc_callback_invoke() on the freed client memory?

>  	pm_runtime_get_sync(pch->dmac->ddma.dev);
> -	spin_lock_irqsave(&pl330->lock, flags);
> +	/*
> +	 * Acquire pch->lock before pl330->lock to respect the locking hierarchy
> +	 * (pch->lock -> pl330->lock) used inside the tasklet. This ensures
> +	 * that setting pch->thread to NULL and checking it inside the tasklet
> +	 * is fully synchronized, preventing TOCTOU race conditions.
> +	 */
> +	spin_lock_irqsave(&pch->lock, flags);
> +	spin_lock(&pl330->lock);
> =20
>  	pl330_release_channel(pch->thread);

[Severity: Critical]
Will acquiring pch->lock here result in a non-recursive spinlock
self-deadlock when aborting pending descriptors?

If a client releases a channel with active descriptors,
pl330_free_chan_resources() now acquires pch->lock and calls
pl330_release_channel(), which attempts to abort active descriptors by
calling dma_pl330_rqcb().

Looking at dma_pl330_rqcb(), it unconditionally attempts to acquire the exa=
ct
same non-recursive lock:

drivers/dma/pl330.c:dma_pl330_rqcb() {
    ...
    spin_lock_irqsave(&pch->lock, flags);
    ...
}

Will this cause the executing CPU to hang?

>  	pch->thread =3D NULL;
> @@ -2365,7 +2384,8 @@ static void pl330_free_chan_resources(struct dma_ch=
an *chan)
>  	if (pch->cyclic)
>  		list_splice_tail_init(&pch->work_list, &pch->dmac->desc_pool);

[Severity: Critical]
This is a pre-existing issue, but is it safe to splice work_list into
desc_pool here without acquiring pool_lock?

In pl330_free_chan_resources(), pl330_tasklet(), and pl330_terminate_all(),
items are spliced or moved into the shared pl330->desc_pool while only
holding pch->lock or pl330->lock.

The pool_lock appears explicitly required to protect desc_pool, as seen in
pluck_desc().

Can multiple channels terminating simultaneously corrupt the shared list?

> -	spin_unlock_irqrestore(&pl330->lock, flags);
> +	spin_unlock(&pl330->lock);
> +	spin_unlock_irqrestore(&pch->lock, flags);
>  	pm_runtime_put_autosuspend(pch->dmac->ddma.dev);
>  	pl330_unprep_slave_fifo(pch);
>  }

[Severity: Critical]
This is a pre-existing issue, but could an unhandled event index trigger an
out-of-bounds array access in pl330_update()?

If a hardware event fires for an event index 'ev' that is currently
unallocated, pl330->events[ev] is set to -1. pl330_update() reads this and
uses it directly as an array index without validation:

drivers/dma/pl330.c:pl330_update() {
    ...
    id =3D pl330->events[ev];
    thrd =3D &pl330->channels[id];
    ...
}

Does this out-of-bounds memory read and subsequent memory write corrupt
adjacent kernel structures when thrd->req_running is evaluated?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709125914.1079=
328-1-mayankmishraa@google.com?part=3D1

