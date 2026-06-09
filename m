Return-Path: <dmaengine+bounces-11378-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9MbEBFGWKGo7GgMAu9opvQ
	(envelope-from <dmaengine+bounces-11378-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 00:40:17 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB68664A0F
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 00:40:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jxpdsLj7;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11378-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11378-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E828E30071DB
	for <lists+dmaengine@lfdr.de>; Tue,  9 Jun 2026 22:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B66B17A309;
	Tue,  9 Jun 2026 22:32:05 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C1935A387
	for <dmaengine@vger.kernel.org>; Tue,  9 Jun 2026 22:32:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781044325; cv=none; b=fFjG/AUV3r4AWUVaKmIwEZMze9c5nqBnpMwvgJKc7yMjW7K+51ZAg87Tv/FrIINueWTMEVK7oSlQMAgqKugJBnPMzHBzC2ia3YI7+of+rcsEjJOweUFySf7zXsPh8kH+4sFIAdZorlSkYaZk6MPrsqoKNgLREY8tgebjbjzHvjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781044325; c=relaxed/simple;
	bh=/9YkbTZ5Bsx1Yhujs+V42U2WJ78wfzVKIgLo8lwLZZw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Bz82KntSXguPZXu6FZRd4jDr09pWok5+ljzyr6DfjHKf0RXc8lR0IaD20z7JZ2bi2gGM+wD8wm0hKZNbIuuvP/VpD9L23wFW4vubs38IhfFc8T7Ne5dlVSeDMtYtBh4RKs+ib09uKTK5sfz8Lpf/Vcu0MKniCxUGdXjRHk4gHI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxpdsLj7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B15D51F00893;
	Tue,  9 Jun 2026 22:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781044323;
	bh=97CdEc9NWuJbr5LAM6qTEgac5IchBi7yM/lx8tNXfxY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jxpdsLj7HjW85+Zmr1XvywIjjLkF6Te8HWBzu0WTBTXnQ1GD1gP4lHD20/yruM4KC
	 jyqGqLx72IAxroVzBHA1Mk04zywtLvvKzNoivf1yVRkimfIk3yOx5TyAmQi9l+RQuP
	 Tgu/bFCtquETj4PlWYK+1uF65p7T2q7NEgfm1CmoZsD6wmCfU2eBnRoPkglXB4Bz3X
	 ez2DAMS0JPAZs1r/CvI62zAv7CV5sIlyrkSmw7cT1RlU9Q9zT7U5eXVK0YW1DAozKa
	 cdT2bB/MJnpqzYvctwwiWJznoFqv7ybRhOy5YTWQBmF3P4iungRfv2Pp4o5GymaPaY
	 m7wL2ATeRLj5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv3 02/15] dmaengine: fsldma: drop desc_lock before
 invoking client callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: Frank.Li@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260609221926.35538-3-rosenp@gmail.com>
References: <20260609221926.35538-3-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 22:32:03 +0000
Message-Id: <20260609223203.B15D51F00893@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-11378-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:Frank.Li@kernel.org,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,lists.linux.dev:replyto,sashiko.dev:url,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9CB68664A0F

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Critical] Hardware State Corruption due to incorrect `chan->idle` assign=
ment.
- [Critical] Premature completion of active descriptors due to stale `curr_=
phys` caching.
- [High] Concurrency, callback ordering violation, and completion cookie re=
gression.
- [High] Use-After-Free / NULL pointer dereference of descriptor pool durin=
g teardown.

Pre-existing issues:
- [High] Missing `tasklet_kill()` in `fsl_dma_chan_remove` leading to Use-A=
fter-Free on `chan`.
--

commit 3632dcf83e269dafd0b93a77697b31d6b209bd8a
Author: Rosen Penev <rosenp@gmail.com>

dmaengine: fsldma: drop desc_lock before invoking client callback

This commit modifies the descriptor cleanup routine in the fsldma driver to
extract callback information under a lock, drop the lock, and invoke the cl=
ient
callback. This is intended to fix a self-deadlock when a client submits a n=
ew
transaction from the completion callback.

> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> index 22d62d958abd9..5c8a8fe25617d 100644
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c
[ ... ]
> @@ -603,22 +603,23 @@ static void fsldma_cleanup_descriptors(struct fsldm=
a_chan *chan)
>  {
>  	struct fsl_desc_sw *desc;
>  	dma_cookie_t cookie =3D 0;
>  	dma_addr_t curr_phys =3D get_cdar(chan);

[Severity: Critical]
Is it safe to cache curr_phys outside the while loop when dropping the lock
inside the loop?

If the lock is dropped inside the loop to invoke callbacks, a concurrent th=
read
could enter, process the remaining completed descriptors (including the one
matching this thread's cached curr_phys), and remove them from ld_running.

When the first thread reacquires the lock, its cached curr_phys is now stal=
e and
no longer matches any descriptor in the list. As a result, the loop's safety
break condition:

        if (desc->async_tx.phys =3D=3D curr_phys) {
            seen_current =3D 1;

will never be met. The first thread will erroneously process all remaining
descriptors in ld_running as completed, running their callbacks and freeing=
 them
even if the hardware is actively executing them.

>  	int seen_current =3D 0;
> =20
>  	fsldma_clean_completed_descriptor(chan);
> =20
[ ... ]
> @@ -662,9 +631,42 @@ static void fsldma_cleanup_descriptors(struct fsldma=
_chan *chan)
>  				break;
>  		}
> =20
> -		cookie =3D fsldma_run_tx_complete_actions(chan, desc, cookie);
> +		cookie =3D fsldma_run_tx_complete_actions(chan, desc, cookie, &cb);
> =20
> -		fsldma_clean_running_descriptor(chan, desc);
> +		/*
> +		 * Remove from the running list before dropping the lock so
> +		 * that terminate_all cannot free this descriptor while we
> +		 * call into the client below.
> +		 */
> +		list_del(&desc->node);
> +
> +		/*
> +		 * Prevent dma_run_dependencies() from calling
> +		 * fsl_chan_xfer_ld_queue() while we are not holding the
> +		 * lock.  That would splice pending descriptors into
> +		 * ld_running before they have been completed by hardware.
> +		 * fsl_chan_xfer_ld_queue at the end of this function will
> +		 * re-evaluate the situation.
> +		 */
> +		chan->idle =3D false;
> +
> +		/*
> +		 * Drop the lock before invoking the client callback, since
> +		 * the DMAengine API explicitly allows clients to submit new
> +		 * transactions from their completion callback.  Otherwise
> +		 * we self-deadlock on chan->desc_lock.
> +		 */
> +		spin_unlock(&chan->desc_lock);
> +		dmaengine_desc_callback_invoke(&cb, NULL);
> +		dma_run_dependencies(&desc->async_tx);
> +		spin_lock(&chan->desc_lock);

[Severity: High]
Does dropping the lock here expose the list iteration to concurrent executi=
on?

Since the lock is dropped within the loop over the shared ld_running list,
multiple threads (such as a tasklet and a thread calling fsl_tx_status()) c=
an
concurrently enter fsldma_cleanup_descriptors() and process descriptors
simultaneously.

This could cause callbacks to be invoked concurrently or out of order.

Additionally, each thread updates chan->common.completed_cookie at the end =
of
the function using their local cookie variable:

    if (cookie > 0)
        chan->common.completed_cookie =3D cookie;

If a thread processing an older descriptor finishes after a thread processi=
ng a
newer descriptor, the completed_cookie will regress to a smaller value, cau=
sing
clients waiting for DMA completion to hang.

> +
> +		chan->idle =3D true;

[Severity: Critical]
Can this unconditional assignment to chan->idle mask the active busy state
of the hardware?

If a descriptor completes, the loop drops the lock, runs the callback,
reacquires the lock, and sets chan->idle =3D true.

If the next descriptor in the queue is currently being executed by the hard=
ware,
the loop breaks. At this point, chan->idle incorrectly remains true from the
previous iteration, despite the hardware actively processing the current
descriptor.

When fsl_chan_xfer_ld_queue() is subsequently called at the end of the func=
tion,
it checks this variable:

drivers/dma/fsldma.c:fsl_chan_xfer_ld_queue() {
    ...
    if (!chan->idle) {
        chan_dbg(chan, "DMA controller still busy\n");
        return;
    }
    ...
}

Because chan->idle is improperly true, fsl_chan_xfer_ld_queue() will bypass=
 its
safety check, inappropriately restart the controller, and overwrite the har=
dware
registers while the hardware is actively running.

> +
> +		if (!async_tx_test_ack(&desc->async_tx))
> +			list_add_tail(&desc->node, &chan->ld_completed);
> +		else
> +			dma_pool_free(chan->desc_pool, desc, desc->async_tx.phys);

[Severity: High]
Is it possible for chan->desc_pool to be destroyed by concurrent teardown b=
efore
we call dma_pool_free() here?

Because chan->desc_lock was dropped earlier to invoke callbacks, this breaks
mutual exclusion with the channel teardown.

drivers/dma/fsldma.c:fsl_dma_free_chan_resources() {
    ...
    dma_pool_destroy(chan->desc_pool);
    chan->desc_pool =3D NULL;
    ...
}

If fsl_dma_free_chan_resources() runs on another CPU while the lock is drop=
ped
here, it can finish teardown and destroy the pool. When the lock is reacqui=
red
and this code is executed, it will dereference the destroyed (NULL) pool.

>  	}
> =20
>  	/*

[Severity: High]
This isn't a bug introduced by this patch, but is there a missing tasklet_k=
ill()
when removing the channel?

drivers/dma/fsldma.c:fsl_dma_chan_remove() {
    ...
    kfree(chan);
    ...
}

If a tasklet is scheduled (e.g., by an interrupt) just before or during cha=
nnel
removal, the tasklet will execute dma_do_tasklet() after chan has been free=
d,
dereferencing the freed pointer and causing a use-after-free.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609221926.3553=
8-3-rosenp@gmail.com?part=3D1

