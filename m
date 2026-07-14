Return-Path: <dmaengine+bounces-12495-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9PEIIUAtVmop0wAAu9opvQ
	(envelope-from <dmaengine+bounces-12495-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 14:36:16 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DE47549D2
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 14:36:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DzWvJk4n;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12495-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12495-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7605030570E7
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 12:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88790448CEF;
	Tue, 14 Jul 2026 12:31:37 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF73448CE7;
	Tue, 14 Jul 2026 12:31:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784032293; cv=none; b=mDcVypPFIoz/ubJAHh63rdVgEZpIgARGkEgdUW+19ezU3fyYTe5s9/xjbcjjwy3AXrqYwXm1de+cKLc6Mw1u11Ao7bEclUB24HKA764j+bLGzb4HudcgE98ZPs+2unauPQqC/nwK6E0NOYnnGjJ2oDDGHmoi/31GQKx649fgRtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784032293; c=relaxed/simple;
	bh=3lfRFueK4cAvOjjB0V8i20PcT0VQjJ+RAlmWV0joEuA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oYtfWh0DgXfV8LC2/xf3AX/iwrAEEM0nKTnFvUZae5xYDWuVGnfNZAi53uSyFOV4Xod+mnj5ZEqmDlhKy74ITMq6FtcHMLg+1b8kz+PlsfG9rC0vukxDRmsPJvXixD7dvMT3X92WDqmFTnw9KLO1+oTgWBBUGhoTpbxChl83pV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzWvJk4n; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA091F000E9;
	Tue, 14 Jul 2026 12:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784032286;
	bh=08uSKT70yJluBJb/4HDjVzeUN+VvjnSjb9VJvESow5k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DzWvJk4neQYktlTaHxJrtxNZdgrAO0b+aluJwV+X3xTUXf4iRobK94IZJLVSN2uLf
	 1pj0Lkf7QNwTAmyOk9G6h4I2RI8AoCFbnmhILtp0saeik67HD6imzkxQIpRpknaaPS
	 78rD8Vze1e/x2ExpnjoF4tsIJ2AlPaJ7GEhYyEgNsLzummQ0iCcKziq6XRg7ftrBqs
	 BTA1qFKmgpmrcDVKXwRxt4ovqvq8VA6Gceb9pGsZDMkcXCjXkaPO1xOz7U/hQN5vxQ
	 9PYxQBm01ipqL+s5syGH3jYB0UB1q8XE3BC0/vEgA6c6Q9rrv+EktwuUPd7fopYXov
	 ldlK5pBrb7+ug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] bus: mhi: ep: Add mhi_cntrl->flush_async()
 callback to flush the async read/write
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manivannan Sadhasivam" <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Frank.Li@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260714-mhi-ep-flush-v2-2-b6a9db011e85@oss.qualcomm.com>
References: <20260714-mhi-ep-flush-v2-0-b6a9db011e85@oss.qualcomm.com>
 <20260714-mhi-ep-flush-v2-2-b6a9db011e85@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 12:31:25 +0000
Message-Id: <20260714123126.5FA091F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-12495-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,smtp.kernel.org:mid,vger.kernel.org:from_smtp,qualcomm.com:email,lists.linux.dev:replyto];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:manivannan.sadhasivam@oss.qualcomm.com,m:Frank.Li@kernel.org,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:linux-pci@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D1DE47549D2

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Draining async transfers *after* sending a disconnect notification=
 causes out-of-order successful callbacks to be delivered to a disconnected=
 client.
- [High] Controller-wide `flush_async()` called inside a per-channel loop d=
isrupts active channels and causes livelocks.

Pre-existing issues:
- [Critical] The `MHI_PKT_TYPE_RESET_CHAN_CMD` handler frees the transfer r=
ing without flushing in-flight async DMA operations.
- [High] Lockless TOCTOU race on `mhi_chan->xfer_cb` in completion handlers=
 leads to a Use-After-Free.
- [High] Null pointer dereference on `mhi_chan->mhi_dev` in `mhi_ep_process=
_ch_ring` during controller teardown.
--

--- Patch [2]: [PATCH v2 2/3] bus: mhi: ep: Add mhi_cntrl->flush_async() ca=
llback to flush the async read/write ---
commit 2e23a5ef008c4098d55a3f07d062a8941cc90ccd
Author: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: bus: mhi: ep: Add mhi_cntrl->flush_async() callback to flush the a=
sync read/write

This patch introduces a flush_async() callback to the MHI EP controller and
invokes it during device removal. It aims to prevent use-after-free issues
by ensuring that any in-flight asynchronous DMA operations are completed
before the channel's transfer callback is unregistered.

> diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
> --- a/drivers/bus/mhi/ep/main.c
> +++ b/drivers/bus/mhi/ep/main.c

[ ... ]

> @@ -1636,6 +1637,12 @@ static void mhi_ep_remove(struct device *dev)
>  		}
> =20
>  		mhi_chan->state =3D MHI_CH_STATE_DISABLED;
> +		mutex_unlock(&mhi_chan->lock);
> +
> +		if (mhi_cntrl->flush_async)
> +			mhi_cntrl->flush_async(mhi_cntrl);
> +

[Severity: High]
Does this sequence result in successful callbacks being delivered after the
client has already been notified of disconnection?

When mhi_ep_remove() sends -ENOTCONN to mhi_chan->xfer_cb(), it signals the
client to free its context. If we then drop the lock and block on
flush_async() while xfer_cb is still registered, pending DMA completions
can invoke mhi_ep_read_completion():

mhi_ep_read_completion()
    if (mhi_chan->xfer_cb) {
        ...
        mhi_chan->xfer_cb(mhi_dev, &result);
    }

Can this lead to the client driver receiving a success callback after it has
already freed its resources in response to the -ENOTCONN notification?

[Severity: High]
Can calling a controller-wide flush operation inside a per-channel loop
disrupt other active channels or cause a livelock?

The code loops over the device's channels (UL then DL). When disabling the =
UL
channel, it calls mhi_cntrl->flush_async(). Since flush_async() operates on
the controller context and MHI EP architectures typically share RX/TX DMA
channels across the entire controller, the DL channel might still be active
and queuing new transfers.

Could waiting for all controller DMAs to flush while other channels are act=
ive
cause a livelock or drain traffic inappropriately?

> +		mutex_lock(&mhi_chan->lock);
>  		mhi_chan->xfer_cb =3D NULL;
>  		mutex_unlock(&mhi_chan->lock);
>  	}

[Severity: High]
This is a pre-existing issue, but does conditionally skipping the flush
leave the fallback path unprotected against concurrent teardown?

If mhi_cntrl->flush_async is NULL, the flush is skipped. However, DMA
completion handlers evaluate the callback pointer locklessly:

mhi_ep_read_completion()
    if (mhi_chan->xfer_cb) {
        ...
        mhi_chan->xfer_cb(mhi_dev, &result);
    }

If the thread is preempted here, mhi_ep_remove() can run, set
mhi_chan->xfer_cb =3D NULL, and free the device. When the handler resumes, =
it
could invoke the stale callback pointer. Does the lockless read of xfer_cb
lack the necessary synchronization?

While reviewing this file, I also noticed a couple of pre-existing issues
elsewhere in the code:

[Severity: Critical]
This is a pre-existing issue, but does resetting the channel ring without
flushing async DMAs lead to a NULL pointer dereference?

When the host sends a reset command, mhi_ep_process_ctrl_interrupt() calls
mhi_ep_ring_reset() which frees ring->ring_cache. Because this path does not
cancel in-flight async DMAs, a pending DMA completion handler might execute
shortly after:

mhi_ep_read_completion()
    struct mhi_ring_element *el =3D &ring->ring_cache[ring->rd_offset];

Can this result in a crash if the completion handler dereferences the clear=
ed
ring_cache?

[Severity: High]
This is a pre-existing issue, but is there a risk of a NULL pointer
dereference during controller teardown?

In mhi_ep_abort_transfer(), client devices are destroyed using
device_for_each_child(), which sets mhi_chan->mhi_dev =3D NULL. Because the
channel rings are not stopped until later, a doorbell interrupt can fire and
queue mhi_ep_ch_ring_worker().

The worker calls mhi_ep_process_ch_ring() which checks for a missing client
driver:

mhi_ep_process_ch_ring()
    if (!mhi_chan->xfer_cb) {
        dev_err(&mhi_chan->mhi_dev->dev, "Client driver not available\n");

Since mhi_dev is now NULL, can this dev_err() call trigger a panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-mhi-ep-flu=
sh-v2-0-b6a9db011e85@oss.qualcomm.com?part=3D2

