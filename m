Return-Path: <dmaengine+bounces-11553-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MvyhJ5sNMWqKawUAu9opvQ
	(envelope-from <dmaengine+bounces-11553-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jun 2026 10:47:23 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7FA68D485
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jun 2026 10:47:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=OoTB7quQ;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11553-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11553-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3DC1303E2EA
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jun 2026 08:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E5D40E8E5;
	Tue, 16 Jun 2026 08:44:49 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4200430AD0A;
	Tue, 16 Jun 2026 08:44:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781599489; cv=none; b=tKORO+Pdbr1k/7R38irpP7PHsePRv8hRIBCQhde//4zSWkxHZijaDRyCpfxkf5IRL6WvEZuhILumYkHuh5QePEHBuXhkBND1CY+2e8uu3hWG/mGeO0tAqvqPw2SsEK4sKVqjbkqGx/W+UKwzlGSyhF4+bJ8dRpvkeUe9PyZfVyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781599489; c=relaxed/simple;
	bh=vU5CkjwusbK4oTshtz0qTyrjjkJfMFH1mI6MHUX9Lf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NqSZS8JDwF/vb4FY91WXHj2HsZwOadk5Fh86QaeUA784M9NbW6UeLfSEHIcOkbJ1950FYRtc2YftMJ5/EjrdguQrGKclAWthgP4jNg62krJmk+wxzub27y9XD3b6idEgz00fNvngcjHq0ZLHzcofmK/CSgVPyvqvyliHG9SfYgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OoTB7quQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D07FB1F000E9;
	Tue, 16 Jun 2026 08:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781599487;
	bh=/oYQ5/Jb6iFjya9RVTgs4HXzWqEW3bAB8XqQIRdPPM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OoTB7quQChG4Wuzmat03cFa0GB8SBI0UrHX3msdndFVJFvkvkrEubr4xQ0mjvFKG2
	 gDLWKmz4VrxKjIbRXVoX1KTjikdfDOua1XZEl4C71AMT4Vlf5DR4txJmU9r9SKqNw4
	 7R6xIjrhPMh603GkUw4MK50pgP/U3AWWOxv2i3sEUMGYwZ7fb94m1u+NsXJZXSztfK
	 XpD9y0Tq1sRcEhgd/hn1K7o1hHKfMJgnRo0gJh7z4TDTZS5ELx0fsU8N4V0/woM5f0
	 hnNH203ujgzyILmM/hQSueJi0c5i1hAt7IslgoMPqZdYOYj4eCibOCB5nCao0lvrIg
	 vpTfLF8ZXQQsg==
Date: Tue, 16 Jun 2026 14:14:33 +0530
From: Vinod Koul <vkoul@kernel.org>
To: "Golla, Nagendra" <Nagendra.Golla@amd.com>
Cc: sashiko-reviews@lists.linux.dev, robh@kernel.org,
	devicetree@vger.kernel.org, Frank.Li@kernel.org,
	dmaengine@vger.kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH 2/2] dmaengine: zynqmp_dma: Add per-channel reset support
Message-ID: <ajEM8QfB5brd3sOQ@vaman>
References: <20260525105042.2249542-3-nagendra.golla@amd.com>
 <20260525113349.68D6E1F00A3D@smtp.kernel.org>
 <efa45058-6724-45cb-8b8f-75427446f62c@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efa45058-6724-45cb-8b8f-75427446f62c@amd.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11553-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:Nagendra.Golla@amd.com,m:sashiko-reviews@lists.linux.dev,m:robh@kernel.org,m:devicetree@vger.kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:conor+dt@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EE7FA68D485

On 15-06-26, 14:59, Golla, Nagendra wrote:
> 
> 
> On 5/25/2026 5:03 PM, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> > 
> > Pre-existing issues:
> > - [High] The probe error path leaks a runtime PM usage counter reference, permanently breaking runtime PM and leaving hardware clocks enabled.
> > - [High] Dropping the spinlock inside `list_for_each_entry_safe` allows concurrent modification of the list, leading to memory corruption.
> > - [High] Hardware registers are accessed in the IRQ handler without verifying if the device is active, risking a kernel panic on spurious interrupts.
> > --
> > 
> > commit b2d2a678f48614c7188f8d81cbc70143b2bdfc0f
> > Author: Golla Nagendra <nagendra.golla@amd.com>
> > Subject: dmaengine: zynqmp_dma: Add per-channel reset support
> > 
> > This commit introduces per-channel reset support for Versal Gen 2 and
> > Versal Net SoCs. It adds reset handling in the channel probe path using
> > device_reset_optional() to trigger a reset pulse during initialization.
> > Platforms without per-channel reset are unaffected.
> > 
> > > diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
> > > index f6a812e49ddca..51c831760372c 100644
> > > --- a/drivers/dma/xilinx/zynqmp_dma.c
> > > +++ b/drivers/dma/xilinx/zynqmp_dma.c
> > [ ... ]
> > > @@ -916,6 +917,11 @@ static int zynqmp_dma_chan_probe(struct zynqmp_dma_device *zdev,
> > >   	if (IS_ERR(chan->regs))
> > >   		return PTR_ERR(chan->regs);
> > > +	err = device_reset_optional(&pdev->dev);
> > > +	if (err)
> > > +		return dev_err_probe(&pdev->dev, err,
> > > +				     "failed to reset channel\n");
> > > +
> > 
> > [Severity: High]
> > This isn't a bug introduced by this patch, but does this error path leak a
> > runtime PM usage counter reference?
> > 
> > In zynqmp_dma_probe(), pm_runtime_resume_and_get() is called to increment
> > the runtime PM usage counter and enable the device clocks. If a subsequent
> > initialization step fails, such as the newly added device_reset_optional()
> > returning -EPROBE_DEFER, the code jumps to the err_disable_pm label:
> > 
> > zynqmp_dma_probe()
> >      ...
> > 	ret = pm_runtime_resume_and_get(zdev->dev);
> >      ...
> > 	ret = zynqmp_dma_chan_probe(zdev, pdev);
> > 	if (ret) {
> > 		dev_err_probe(&pdev->dev, ret, "Probing channel failed\n");
> > 		goto err_disable_pm;
> > 	}
> >      ...
> > err_disable_pm:
> > 	if (!pm_runtime_enabled(zdev->dev))
> > 		zynqmp_dma_runtime_suspend(zdev->dev);
> > 	pm_runtime_disable(zdev->dev);
> > 	return ret;
> > 
> > Since the device is still runtime PM enabled, it skips
> > zynqmp_dma_runtime_suspend() and fails to drop the usage counter with
> > pm_runtime_put_noidle().
> > 
> > Because -EPROBE_DEFER is a normal occurrence during boot, this path can
> > be hit multiple times. Will this permanently leave the usage counter above
> > zero, preventing the device from ever entering runtime suspend and leaving
> > its clocks enabled indefinitely?
> > 
> > >   	chan->bus_width = ZYNQMP_DMA_BUS_WIDTH_64;
> > >   	chan->dst_burst_len = ZYNQMP_DMA_MAX_DST_BURST_LEN;
> > 
> > [Severity: High]
> > This is a pre-existing issue, but does dropping the spinlock inside
> > list_for_each_entry_safe() in zynqmp_dma_chan_desc_cleanup() allow concurrent
> > modification of the list, leading to memory corruption?
> > 
> > When zynqmp_dma_chan_desc_cleanup() temporarily drops the lock to invoke
> > the DMA callback:
> > 
> > zynqmp_dma_chan_desc_cleanup()
> >      ...
> > 	list_for_each_entry_safe(desc, next, &chan->done_list, node) {
> >          ...
> > 		if (dmaengine_desc_callback_valid(&cb)) {
> > 			spin_unlock_irqrestore(&chan->lock, irqflags);
> > 			dmaengine_desc_callback_invoke(&cb, NULL);
> > 			spin_lock_irqsave(&chan->lock, irqflags);
> > 		}
> > 
> > A client driver can concurrently invoke dmaengine_terminate_sync(), which
> > calls zynqmp_dma_device_terminate_all() and executes
> > zynqmp_dma_free_descriptors(). This moves all remaining elements, including
> > the prefetched next pointer, from done_list to free_list.
> > 
> > When zynqmp_dma_chan_desc_cleanup() reacquires the lock, won't it continue
> > iterating using the corrupted next pointer that now resides in free_list,
> > eventually interpreting the list head &chan->free_list as a struct
> > zynqmp_dma_desc_sw and resulting in out-of-bounds memory accesses?
> > 
> > [Severity: High]
> > This is a pre-existing issue, but are hardware registers accessed in the
> > IRQ handler without verifying if the device is active, risking a kernel
> > panic on spurious interrupts?
> 
> Hi,
> 
> Thanks for pointing this out.After reviewing the runtime PM guidelines and
> the driver behavior, I believe this is not a strict requirement for all IRQ
> handlers. The PM documentation does not mandate that
> pm_runtime_get_if_active() must be used before every register access in an
> ISR. It is mainly intended for cases where an interrupt can occur while the
> device might be runtime-suspended, such as shared IRQ or spurious interrupt
> scenarios.
> 
> In the case of the zynqmp DMA driver, the interrupt is generated only when
> the hardware is active during a transfer, and the driver ensures the device
> remains runtime-active while DMA operations are in progress. Because of
> this, the ISR is not expected to run when the device is suspended, and
> accessing registers directly should be safe.
> 
> So, in this context, adding pm_runtime_get_if_active() in the IRQ handler
> may not be necessary. That said, please let me know  if you see a scenario
> where the interrupt could be triggered while the device is
> runtime-suspended, and I can revisit accordingly.

We can have a spurious interrupt. if you have an isr registered, your
cide should be able to handle the invocation... I think it is indeed
pragmatic to handle this

-- 
~Vinod

