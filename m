Return-Path: <dmaengine+bounces-12301-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id U9i8DDCvUGq03QIAu9opvQ
	(envelope-from <dmaengine+bounces-12301-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:37:04 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 189BB7388D3
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:37:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=JLcnlZtU;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12301-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12301-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EDF80305C3D9
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 08:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5FD3EFFA8;
	Fri, 10 Jul 2026 08:24:26 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B2A3EF650
	for <dmaengine@vger.kernel.org>; Fri, 10 Jul 2026 08:24:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783671866; cv=none; b=tctm+QcvGvkuYTn8bXN+7yeGxiklJcLCuefk66e3CU0GVnxxMj6obuhrROk0Gk01hHTUi/4ndFiGI6Y1+bcmw9CeTwSXPWxfWjf792D38T9Az7+n7qoyKJ8qwRfvlXYvrco4bS3D4LSXEC7sJH9sq4CJCuceJp8+izQQAIg3bEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783671866; c=relaxed/simple;
	bh=BjqJFUPVJzmZ+ZupdNdilNohfzgAhHtf7gJ59M5I4kE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ep8J37EemGcZIzp/XbdAsnHKXY1yF8owSzFgNPrhCMFYWbXK6xiB9e2oxL0A42EfDtj9t0jVSHBC83pMviRQ0Fms/+flEc+goEcYS6zkzgkC07NENR6hk/PTnelriG9gjiVy65JsG2EvVgVvNFSAl0WW/+Qt1ZdZiBAS+aiFLgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JLcnlZtU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD7B1F00A3A;
	Fri, 10 Jul 2026 08:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783671864;
	bh=PMPTc48n44L7RPsf84Wcf1OeVhJgsjZwq0Q30hEgUR4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JLcnlZtUvyf0gSX0CljqS4/qsLkFBLDGXLLOEsvTAF0qpeU2V8wv+XYUoiP8j0p/c
	 a4wY6vMoOep4PKO4LDwbg6xt0MJ9iLI3x4w2uctkOt9PAgXgpegK+J3yvuZ4X/O+wD
	 rBSZ2JhlGiXJ4rDbcbV9H6UeFBIhnsusRu11ZXt4vuZxUagYG+hAf1LGr9lV6carRb
	 gRRBotiaU4VaXCSz1IgPUDfKrNgS1plfZ62h/bjwYZ99xdMMFVJ6xhlYww4myQOmQ2
	 wpiZ1YGhsSPzIfrGMSLaWewt+M8eSnC/DFTyEhmvXi04pknTuegIxnq3AsFLYpRn7f
	 S0iI4sxRc7ISA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/7] dmaengine: dw-edma: Clean up vchan descriptors on
 termination
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: Frank.Li@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260710080903.2392888-4-den@valinux.co.jp>
References: <20260710080903.2392888-1-den@valinux.co.jp>
 <20260710080903.2392888-4-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 08:24:24 +0000
Message-Id: <20260710082424.6CD7B1F00A3A@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-12301-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,valinux.co.jp:email,smtp.kernel.org:mid,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lists.linux.dev:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 189BB7388D3

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Data race in dw_edma_abort_interrupt leads to permanently stalled =
DMA channels.
- [High] Missing lock protection in pause and resume paths leads to list co=
rruption and data races.
--

--- Patch [3]: [PATCH 3/7] dmaengine: dw-edma: Clean up vchan descriptors o=
n termination ---
commit 7bc17c43c74d58634aed20f3d0b0b4c9f907d26a
Author: Koichiro Den <den@valinux.co.jp>

dmaengine: dw-edma: Clean up vchan descriptors on termination

This patch cleans up virtual channel descriptors when a channel is terminat=
ed.
It moves issued and submitted descriptors to the terminated list whenever a
termination request completes, preventing leaked descriptors or restarting
work that was already terminated. It also changes the busy-polling wait
loop to use usleep_range() and cond_resched() instead of busy-polling.

> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> index 4e0dc52397e2e..1b493c104a5b1 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
[ ... ]
> @@ -313,20 +337,25 @@ static int dw_edma_device_resume(struct dma_chan *d=
chan)
>  static int dw_edma_device_terminate_all(struct dma_chan *dchan)
>  {

[Severity: High]
This is a pre-existing issue, but can the lack of lock protection in the
pause and resume paths lead to list corruption and data races?

In dw_edma_device_resume() and dw_edma_device_pause(), the channel state is
modified concurrently without holding chan->vc.lock:

dw_edma_device_resume() {
    ...
    } else {
        chan->status =3D EDMA_ST_BUSY;
        dw_edma_start_transfer(chan);
    }
    ...
}

Calling dw_edma_start_transfer() unlocked invokes vchan_next_desc() (which
triggers lockdep_assert_held()) and modifies child->list with list_del().
Concurrent calls to dw_edma_device_pause() or dw_edma_device_resume(), or
in-flight interrupts, will corrupt the list pointers leading to a kernel
panic.

Should these functions acquire chan->vc.lock before modifying state and
calling dw_edma_start_transfer()?

>  	struct dw_edma_chan *chan =3D dchan2dw_edma_chan(dchan);
> +	unsigned long flags;
>  	int err =3D 0;
> =20
> +	spin_lock_irqsave(&chan->vc.lock, flags);
>  	if (!chan->configured) {
[ ... ]
> @@ -680,7 +710,7 @@ static void dw_edma_done_interrupt(struct dw_edma_cha=
n *chan)
>  			break;
> =20
>  		case EDMA_REQ_STOP:
> -			dw_edma_terminate_vdesc(vd);
> +			dw_edma_terminate_all_descs(chan);
>  			chan->request =3D EDMA_REQ_NONE;
>  			chan->status =3D EDMA_ST_IDLE;
>  			break;

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a potential data
race in dw_edma_abort_interrupt() that could lead to permanently stalled
DMA channels.

In dw_edma_abort_interrupt(), the spinlock is released before chan->request
and chan->status are updated:

dw_edma_abort_interrupt() {
    ...
    spin_unlock_irqrestore(&chan->vc.lock, flags);
    chan->request =3D EDMA_REQ_NONE;
    chan->status =3D EDMA_ST_IDLE;
}

If a client concurrently calls dw_edma_device_issue_pending(), it will
acquire the lock, observe the old state (not IDLE), and skip starting the
transfer. Then the interrupt handler updates the state to IDLE outside the
lock. The pending descriptors remain on the queue but the hardware is never
started.

Could the state updates be moved inside the locked region to prevent this?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710080903.2392=
888-1-den@valinux.co.jp?part=3D3

