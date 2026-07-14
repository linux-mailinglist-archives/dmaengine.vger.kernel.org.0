Return-Path: <dmaengine+bounces-12464-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vr0QHADqVWryvgAAu9opvQ
	(envelope-from <dmaengine+bounces-12464-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 09:49:20 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D21D0752105
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 09:49:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mP6wINOx;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12464-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-12464-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 185BD301DDBB
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 07:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F30D35A3A9;
	Tue, 14 Jul 2026 07:48:58 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A38B308F0A;
	Tue, 14 Jul 2026 07:48:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784015338; cv=none; b=eCamhvl7WdbFTj7+b38bcYAxOCvaiH7eenYUflATSeGSTDcTJKbdCwZ40V8/ZoPAZ7Ycctsb7LeH1dcNt+ru4yCs1BJFmg7aNHMJgiEQN6le9lf3hzBg4wQ6GWu0TO07H+jhY3befDPNrS+YmBnI3pmgtDgw31p0xcRjnMK4X/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784015338; c=relaxed/simple;
	bh=OzE33GcltAjDW5tcXG9BRYvtFttzRWQQ0noGuMNwYt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9ox51miozR+jcFM1m5P9fvLQk0tX0G8psHSV7YtjvDLPIEAAr3jgbZQFWXEPmXd894KK0YwxUXpKlsNQqaWRkA+NZIJvZqYlqcgwyvJTIvZzo5eRco2XWWf0UOlE5E3i5jubSnz1BbJjMilfnz7RjPqYYkGZvUjhtIz1yhcgjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mP6wINOx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 711981F000E9;
	Tue, 14 Jul 2026 07:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784015336;
	bh=VQ6gzOozAQGk1FXpGVGaPrA/5KbS2tcHpdPlcbzeLl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mP6wINOxIeFgFZrQH8Iu6SkRjKy5vO/wP2I5GaNxw2Tzv7t4erJrtyh1Gymeb9OrX
	 4qAEW0o3lkSWfW5iXcaq0Hx/zzmDcR5gJDCpclvXyGmAf/NBUgx3XyXIxnv1mITGtR
	 VzsFqsLblUVQOpQ2joHJ+J/2hzKeZsuCoVrNfyKp8kghZ2ZbRIA5GmZJLVNtt1K1Gl
	 QfrhhLByCxd5sTvtkM/Rnf9qT00M2ZAtQu5od9txx3Lw8X/nMaMs2Oyt197gHt8d73
	 UurX7TJWJpozp9uS07D1QNZssFv3YIZrdqk24EKA4aZ72/q08scQD1bPitVhHgxUQ9
	 jBI4rDo/tRwqg==
Date: Tue, 14 Jul 2026 09:48:50 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: 
	Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, 
	vkoul@kernel.org, Frank.Li@kernel.org
Subject: Re: [PATCH 1/3] dmaengine: dw-edma: Implement device_synchronize()
 callback
Message-ID: <moxonhzmvp6mofmaabywhfe6xucxut6fgjjlfg73uadanghwx5@mhisbkzznlar>
References: <20260629-mhi-ep-flush-v1-0-714e0d56e87c@oss.qualcomm.com>
 <20260629-mhi-ep-flush-v1-1-714e0d56e87c@oss.qualcomm.com>
 <20260629085716.D203C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260629085716.D203C1F000E9@smtp.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org,m:linux-pci@vger.kernel.org,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:devnull@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[mani@kernel.org,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-12464-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mani@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,manivannan.sadhasivam.oss.qualcomm.com];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,qualcomm.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D21D0752105

On Mon, Jun 29, 2026 at 08:57:16AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 6 potential issue(s) to consider:
> 
> New issues:
> - [Critical] dw_edma_device_synchronize() silently fails if the timeout is reached, returning to the caller while the hardware channel is still active.
> - [High] dw_edma_device_synchronize() implements a 5000ms busy-wait loop using cpu_relax() in a sleepable context.
> - [Medium] Lockless read of chan->status without READ_ONCE() or memory barriers in dw_edma_device_synchronize().
> 
> Pre-existing issues:
> - [High] dw_edma_device_terminate_all() fails to flush pending virt-dma descriptor queues, causing memory leaks and the risk of stale transfers resuming.
> - [High] Virt-DMA descriptors are permanently leaked during channel teardown because vchan_free_chan_resources() is not called.
> - [High] dw_edma_device_terminate_all() modifies channel state without holding the required spinlock.
> --
> 
> commit dde223ef8e9950c9d18889da8638ba0fd963f5d8
> Author: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> dmaengine: dw-edma: Implement device_synchronize() callback
> 
> device_synchronize() callback is required by the client drivers to ensure
> all the DMA operations are completed so that they can free the memory
> associated with the complete callbacks.
> 
> So implement this callback by first making sure that all the in-flight DMA
> operations are completed and then call vchan_synchronize() to drain the
> DMA tasklet.
> 
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > index c2feb3adc79fa..7b12dfe8cfd3e 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > @@ -331,6 +331,21 @@ static int dw_edma_device_terminate_all(struct dma_chan *dchan)
> 
> [Severity: High]
> This is a pre-existing issue, but looking at dw_edma_device_terminate_all(),
> it seems to lack the necessary virt-dma calls (like vchan_get_all_descriptors)
> to extract and free pending descriptors:
> 
>     } else {
>         chan->request = EDMA_REQ_STOP;
>     }
> 
> Since dmaengine_terminate_all() requires all active and pending descriptors
> to be aborted and removed from the channel's queues, could setting this
> software flag without flushing the virt-dma descriptor lists cause queued
> descriptors to remain in vc->desc_issued and vc->desc_submitted?
> 
> If a client later submits new transfers, might the hardware unintentionally
> resume processing the old, supposedly terminated descriptors?
> 
> [Severity: High]
> This is a pre-existing issue, but does dw_edma_device_terminate_all()
> modify channel state without holding the required spinlock?
> 
>     } else if (chan->status == EDMA_ST_PAUSE) {
>         chan->status = EDMA_ST_IDLE;
>         chan->configured = false;
> 
> Since chan->status, chan->request, and chan->configured are concurrently
> accessed and updated by the interrupt handler and issue pending paths under
> chan->vc.lock, does modifying them unlocked introduce a race condition?
> 
> Could this corrupt the channel's internal state machine when a client
> calls dmaengine_terminate_all() during interrupt processing?
> 
> >  	return err;
> >  }
> >  
> > +static void dw_edma_device_synchronize(struct dma_chan *dchan)
> > +{
> > +	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> > +	unsigned long timeout = jiffies + msecs_to_jiffies(5000);
> > +
> > +	/*
> > +	 * Make sure all the in-flight DMA operations are completed before
> > +	 * draining the tasklet using vchan_synchronize().
> > +	 */
> > +	while (chan->status == EDMA_ST_BUSY && time_before(jiffies, timeout))
> 
> [Severity: Medium]
> Since chan->status is concurrently mutated by the interrupt handler under
> vc->lock, does reading it locklessly in this while loop without READ_ONCE()
> or memory barriers constitute a data race?
> 

Using READ_ONCE() for 'chan->status' makes sense.

> Could this cause synchronization bypass if the state update is observed out
> of order relative to the tasklet scheduling?
> 
> > +		cpu_relax();
> 
> [Severity: High]
> Is it safe to implement a 5000ms busy-wait loop using cpu_relax() in a
> sleepable context like dw_edma_device_synchronize()?
> 

I was just following the existing pattern which uses the busy-wait loop in
dw_edma_free_chan_resources().

> Since busy-waiting for up to 5 seconds blocks a CPU core entirely, could
> this starve other tasks and trigger soft lockups when a client driver calls
> dmaengine_synchronize() to wait for DMA completion? Since this callback is
> explicitly allowed to sleep, should a sleeping wait like wait_event_timeout()
> or msleep() be used instead?
> 
> > +
> > +	vchan_synchronize(&chan->vc);
> 
> [Severity: Critical]
> Does dw_edma_device_synchronize() silently fail if the timeout is reached?
> 
> If the 5-second timeout expires while the channel is still busy, the loop
> exits and the function returns to the caller without stopping the ongoing
> hardware transfer or warning the client.
> 
> Since the client relies on device_synchronize() to ensure all active DMA
> operations have fully completed before unmapping and freeing memory, could
> this lead to silent data corruption and a use-after-free if the hardware
> is still actively transferring data?
> 
> Should the function either wait indefinitely or forcefully abort the hardware
> and emit a warning on timeout?
> 

Forcefully aboring the transfer will impact other channels also. So may be the
safe bet would be to wait indefinitely.

For the loop, I'll use read_poll_timeout() with timeout of 0.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

