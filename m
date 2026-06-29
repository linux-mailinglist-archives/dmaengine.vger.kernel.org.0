Return-Path: <dmaengine+bounces-11837-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lZiYNcszQmrt1gkAu9opvQ
	(envelope-from <dmaengine+bounces-11837-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 10:58:51 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB766D7C6F
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 10:58:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YNgMHjj8;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11837-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11837-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 65658302E0CE
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 08:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C130E3F8252;
	Mon, 29 Jun 2026 08:57:18 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C7A3F86FE;
	Mon, 29 Jun 2026 08:57:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782723438; cv=none; b=cMjspu+Ueac2E75+dSoxcNyU7D7NH+qbCbEdUYun/snybj1RJz5mHwsJe7KR1jSJrd7gczkQB/L4dPRUBeMj4O1MFGHqqadHiCwgd42aL5iu1yMaQbrngSnkciBXuLG0veEgo0f2p696jCpitIpaQYBBPCk1EvzY7aWy+E6H8/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782723438; c=relaxed/simple;
	bh=r63rqj+v243+woh4M/Yipi0zZJtyJ2kEHSO4lwGbUpc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gDh5pNy/rYHsfpuIYebOSZF3K9lSKlKJEMpnjLuLgP1JMjMFebbfFGHnApWSEghJ8xV3MONdq+Nod8VHOV14LqbBhShYcPikP0oI/rf+XyqjqCojKX8F5m3cJS7byX68iLnCOtHHGepuit91dGbLxFaWHmHzkLN53mXYLU+4BT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNgMHjj8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D203C1F000E9;
	Mon, 29 Jun 2026 08:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782723437;
	bh=bvWv20F6csq3sQ6PJOHnkAMoUqErurDwXxQNT8qudtY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YNgMHjj8tTaqJvBrp0pnI5rp00CUjc4BNniK88nHx2VU/sy1KyJHGLebnem2hoPGr
	 9hNBtVxAw+Jgf5a//qt3VkrIsMH03Z1pqaeEXS5kF68eK2VgeQbwEmrE9tlwyf/oaX
	 fwdbu1kl9VTWbBaMCUEOsO9MfLaORqLXG1g1ovr49tfBsO3zck6DjhLMXq2CRc8NuH
	 hp6BTJTQOMiBdWIXgGv8ty4JwCfykYZ42noqX5F1mr36IgceCQT9HIdlRLWQrAy2hA
	 R51wI1iBgR9kqn/sYpxw6m3Z8UU8hm1nO2dEZvM16FfCIzep6xS8csH+rWtvh+euTI
	 zd0WWGiVr/RNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] dmaengine: dw-edma: Implement device_synchronize()
 callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manivannan Sadhasivam via B4 Relay" <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Cc: linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260629-mhi-ep-flush-v1-1-714e0d56e87c@oss.qualcomm.com>
References: <20260629-mhi-ep-flush-v1-0-714e0d56e87c@oss.qualcomm.com>
 <20260629-mhi-ep-flush-v1-1-714e0d56e87c@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 08:57:16 +0000
Message-Id: <20260629085716.D203C1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11837-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,sashiko.dev:url,lists.linux.dev:replyto,qualcomm.com:email,smtp.kernel.org:mid];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org,m:linux-pci@vger.kernel.org,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:devnull@kernel.org,s:lists@lfdr.de];
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
	TAGGED_RCPT(0.00)[dmaengine,manivannan.sadhasivam.oss.qualcomm.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6CB766D7C6F

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [Critical] dw_edma_device_synchronize() silently fails if the timeout is =
reached, returning to the caller while the hardware channel is still active.
- [High] dw_edma_device_synchronize() implements a 5000ms busy-wait loop us=
ing cpu_relax() in a sleepable context.
- [Medium] Lockless read of chan->status without READ_ONCE() or memory barr=
iers in dw_edma_device_synchronize().

Pre-existing issues:
- [High] dw_edma_device_terminate_all() fails to flush pending virt-dma des=
criptor queues, causing memory leaks and the risk of stale transfers resumi=
ng.
- [High] Virt-DMA descriptors are permanently leaked during channel teardow=
n because vchan_free_chan_resources() is not called.
- [High] dw_edma_device_terminate_all() modifies channel state without hold=
ing the required spinlock.
--

commit dde223ef8e9950c9d18889da8638ba0fd963f5d8
Author: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

dmaengine: dw-edma: Implement device_synchronize() callback

device_synchronize() callback is required by the client drivers to ensure
all the DMA operations are completed so that they can free the memory
associated with the complete callbacks.

So implement this callback by first making sure that all the in-flight DMA
operations are completed and then call vchan_synchronize() to drain the
DMA tasklet.

> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> index c2feb3adc79fa..7b12dfe8cfd3e 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -331,6 +331,21 @@ static int dw_edma_device_terminate_all(struct dma_c=
han *dchan)

[Severity: High]
This is a pre-existing issue, but looking at dw_edma_device_terminate_all(),
it seems to lack the necessary virt-dma calls (like vchan_get_all_descripto=
rs)
to extract and free pending descriptors:

    } else {
        chan->request =3D EDMA_REQ_STOP;
    }

Since dmaengine_terminate_all() requires all active and pending descriptors
to be aborted and removed from the channel's queues, could setting this
software flag without flushing the virt-dma descriptor lists cause queued
descriptors to remain in vc->desc_issued and vc->desc_submitted?

If a client later submits new transfers, might the hardware unintentionally
resume processing the old, supposedly terminated descriptors?

[Severity: High]
This is a pre-existing issue, but does dw_edma_device_terminate_all()
modify channel state without holding the required spinlock?

    } else if (chan->status =3D=3D EDMA_ST_PAUSE) {
        chan->status =3D EDMA_ST_IDLE;
        chan->configured =3D false;

Since chan->status, chan->request, and chan->configured are concurrently
accessed and updated by the interrupt handler and issue pending paths under
chan->vc.lock, does modifying them unlocked introduce a race condition?

Could this corrupt the channel's internal state machine when a client
calls dmaengine_terminate_all() during interrupt processing?

>  	return err;
>  }
> =20
> +static void dw_edma_device_synchronize(struct dma_chan *dchan)
> +{
> +	struct dw_edma_chan *chan =3D dchan2dw_edma_chan(dchan);
> +	unsigned long timeout =3D jiffies + msecs_to_jiffies(5000);
> +
> +	/*
> +	 * Make sure all the in-flight DMA operations are completed before
> +	 * draining the tasklet using vchan_synchronize().
> +	 */
> +	while (chan->status =3D=3D EDMA_ST_BUSY && time_before(jiffies, timeout=
))

[Severity: Medium]
Since chan->status is concurrently mutated by the interrupt handler under
vc->lock, does reading it locklessly in this while loop without READ_ONCE()
or memory barriers constitute a data race?

Could this cause synchronization bypass if the state update is observed out
of order relative to the tasklet scheduling?

> +		cpu_relax();

[Severity: High]
Is it safe to implement a 5000ms busy-wait loop using cpu_relax() in a
sleepable context like dw_edma_device_synchronize()?

Since busy-waiting for up to 5 seconds blocks a CPU core entirely, could
this starve other tasks and trigger soft lockups when a client driver calls
dmaengine_synchronize() to wait for DMA completion? Since this callback is
explicitly allowed to sleep, should a sleeping wait like wait_event_timeout=
()
or msleep() be used instead?

> +
> +	vchan_synchronize(&chan->vc);

[Severity: Critical]
Does dw_edma_device_synchronize() silently fail if the timeout is reached?

If the 5-second timeout expires while the channel is still busy, the loop
exits and the function returns to the caller without stopping the ongoing
hardware transfer or warning the client.

Since the client relies on device_synchronize() to ensure all active DMA
operations have fully completed before unmapping and freeing memory, could
this lead to silent data corruption and a use-after-free if the hardware
is still actively transferring data?

Should the function either wait indefinitely or forcefully abort the hardwa=
re
and emit a warning on timeout?

> +}

[ ... ]

[Severity: High]
This is a pre-existing issue, but does dw_edma_free_chan_resources()
permanently leak virt-dma descriptors during channel teardown?

Looking at dw_edma_free_chan_resources():

    static void dw_edma_free_chan_resources(struct dma_chan *dchan)
    {
        ...
        // No call to vchan_free_chan_resources(&chan->vc)
    }

When a DMA channel is released via dma_release_channel(), this teardown
function is called. Because dw_edma_device_terminate_all() leaves
uncompleted descriptors on the virt-dma lists, and this function fails to
invoke vchan_free_chan_resources(), are any pending or submitted
descriptors permanently leaked during a client driver unbind operation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-mhi-ep-flu=
sh-v1-0-714e0d56e87c@oss.qualcomm.com?part=3D1

