Return-Path: <dmaengine+bounces-12309-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id D60NAQCvUGqi3QIAu9opvQ
	(envelope-from <dmaengine+bounces-12309-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:36:16 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 428D87388B1
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:36:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VWbs1gd6;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12309-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12309-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E715C3090B40
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 08:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9110C3F0743;
	Fri, 10 Jul 2026 08:28:33 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555AA33262F
	for <dmaengine@vger.kernel.org>; Fri, 10 Jul 2026 08:28:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783672113; cv=none; b=H1O99HuxEpPJUxYxxCYNt7clW/qIzn8NRghiIsFvV+7h4o7jrsqxOlCNZqpFVZUXoAnsYn/8LdPfTMHQzRtOSn2hl7LQAkN5FMAskMbkaGyNSmKvs3CB+F8a1JNTo9DqNB8+/7HXEEtFwjGBm3JFgo0NFlIKhTLzi8TdXHHA6xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783672113; c=relaxed/simple;
	bh=3Lh9phID3AKzVg+cUDax8M3Nl+bJgfAx54WRxyvk3mU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ah7NR9uvB3EKBpyQSPI1Wkl5mvxgAqbfEeOcRuSc0xJGfPAPCX5znBmdNgkpDRs+ifMWEqlZFDUAgrCM5lCDXM61BIECPbaoO57WgBUItyrUU54/oYGmGb7E/Gda6mOgcSoiwUnlnj2xYWYJb5WROT5AdWbGPH20+hvYQVPOBxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VWbs1gd6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBBED1F00A3D;
	Fri, 10 Jul 2026 08:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783672110;
	bh=QgdtKcmK9BJBgoGSEzWsnXOMGcHaOwIbtqCUZ3vacK4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VWbs1gd6HrmYySY/itHCqe3OknLgTRzU5ZWmKqiLGKRc2BwhkhdkmmCPpTt9x4jKz
	 7+L4WnHma8xleE9qvTa0OGdENtBroAwrQgnb2zcxpnxLkFSB/3/BiR7guYcuBxreCN
	 9c5PayL8dlPbtWNTX4oeNQNVhMXWxKb8cjXYgkyIgxbHVNw1ZaZl9MvtxT71Xu1XU9
	 BVyo7yG9rCK2LTNMn2ydw6RZSHecxt0FDf1zBviEt/7wZnb2y0yJw3KF1Ro6lYR7P0
	 /TGjnAn/0cUl5FgU+oanpuPd3P81h9VPXmcPMLLpk8FMlgKqUpWC/funKkVQ07Uqzq
	 UgVey2Lh1B/KA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/7] dmaengine: dw-edma: Serialize channel state checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260710080903.2392888-5-den@valinux.co.jp>
References: <20260710080903.2392888-1-den@valinux.co.jp>
 <20260710080903.2392888-5-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 08:28:29 +0000
Message-Id: <20260710082829.EBBED1F00A3D@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-12309-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:den@valinux.co.jp,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sashiko.dev:url,smtp.kernel.org:mid,valinux.co.jp:email,lists.linux.dev:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 428D87388B1

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Resuming a channel paused on the final chunk of a descriptor c=
auses a permanent deadlock due to bypassed descriptor completion.
- [High] Race condition in `dw_edma_abort_interrupt` updating state outside=
 of `vc.lock`
- [High] `dw_edma_device_terminate_all()` fails to reset `chan->request`, p=
ermanently wedging the channel on false-busy or timeout.
--

--- Patch [4]: [PATCH 4/7] dmaengine: dw-edma: Serialize channel state chec=
ks ---
commit d1992615b101e2e305e248b8535efc7b3e2c9e5f
Author: Koichiro Den <den@valinux.co.jp>
dmaengine: dw-edma: Serialize channel state checks

pause() and resume() read and update channel state without holding vc.lock,
while the interrupt handlers update the same state under it. Take the same
lock around those state checks so that request, status, and configured stay
consistent.

> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> index 1b493c104a5b1..5664421c6f15b 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
[ ... ]
> @@ -318,8 +321,10 @@ static int dw_edma_device_pause(struct dma_chan *dch=
an)
>  static int dw_edma_device_resume(struct dma_chan *dchan)
>  {
>  	struct dw_edma_chan *chan =3D dchan2dw_edma_chan(dchan);
> +	unsigned long flags;
>  	int err =3D 0;
> =20
> +	spin_lock_irqsave(&chan->vc.lock, flags);
>  	if (!chan->configured) {
>  		err =3D -EPERM;
>  	} else if (chan->status !=3D EDMA_ST_PAUSE) {
> @@ -330,6 +335,7 @@ static int dw_edma_device_resume(struct dma_chan *dch=
an)
>  		chan->status =3D EDMA_ST_BUSY;
>  		dw_edma_start_transfer(chan);
>  	}

[Severity: Critical]
This is a pre-existing issue, but I wanted to point out a potential deadlock
when resuming a paused channel.

If a channel is paused exactly as the final chunk of a descriptor finishes,
the interrupt handler dw_edma_done_interrupt() bypasses the normal chunk
depletion check:

drivers/dma/dw-edma/dw-edma-core.c:dw_edma_done_interrupt() {
    ...
		case EDMA_REQ_PAUSE:
			chan->request =3D EDMA_REQ_NONE;
			chan->status =3D EDMA_ST_PAUSE;
			break;
    ...
}

This leaves the depleted descriptor in the issued queue. Later, when resume=
 is
called, dw_edma_start_transfer() attempts to start this empty descriptor,
finds no chunks, and returns 0.

However, dw_edma_device_resume() ignores this return value and unconditiona=
lly
sets chan->status =3D EDMA_ST_BUSY. Would this result in the hardware never
starting and the channel remaining irreversibly stuck in the EDMA_ST_BUSY
state?

> +	spin_unlock_irqrestore(&chan->vc.lock, flags);
> =20
>  	return err;
>  }

While looking at the state locking changes in this patch, I noticed a couple
of other pre-existing issues in this file related to state transitions:

[Severity: High]
This isn't a bug introduced by this patch, but does dw_edma_abort_interrupt=
()
have a similar race condition to the ones being fixed here?

drivers/dma/dw-edma/dw-edma-core.c:dw_edma_abort_interrupt() {
    ...
	spin_lock_irqsave(&chan->vc.lock, flags);
	vd =3D vchan_next_desc(&chan->vc);
	if (vd) {
		dw_hdma_set_callback_result(vd, DMA_TRANS_ABORTED);
		list_del(&vd->node);
		vchan_cookie_complete(vd);
	}
	spin_unlock_irqrestore(&chan->vc.lock, flags);
	chan->request =3D EDMA_REQ_NONE;
	chan->status =3D EDMA_ST_IDLE;
}

The lock is dropped before updating chan->request and chan->status.

If dw_edma_device_issue_pending() executes on another CPU in this unprotect=
ed
window, it could acquire vc.lock, observe a stale EDMA_ST_BUSY state, and
correctly skip starting the hardware for newly queued descriptors. Once
dw_edma_abort_interrupt() resumes and sets the state to EDMA_ST_IDLE, would
the engine remain stopped, leaving the new descriptors stranded forever?

[Severity: High]
This is also a pre-existing issue, but does dw_edma_device_terminate_all()
need to clear chan->request in its error paths?

drivers/dma/dw-edma/dw-edma-core.c:dw_edma_device_terminate_all() {
    ...
	} else if (dw_edma_core_ch_status(chan) =3D=3D DMA_COMPLETE) {
		/*
		 * The channel is in a false BUSY state, probably didn't
		 * receive or lost an interrupt
		 */
		dw_edma_terminate_all_descs(chan);
		chan->status =3D EDMA_ST_IDLE;
		chan->configured =3D false;
	}
    ...
}

If a channel is paused (chan->request =3D=3D EDMA_REQ_PAUSE) and the transf=
er
finished in hardware but the interrupt was lost, it seems we take this bran=
ch
and set chan->status =3D EDMA_ST_IDLE without clearing chan->request.

Since future calls to dw_edma_device_issue_pending() require chan->request =
=3D=3D
EDMA_REQ_NONE, would this stale request state persist and indefinitely wedge
the channel?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710080903.2392=
888-1-den@valinux.co.jp?part=3D4

