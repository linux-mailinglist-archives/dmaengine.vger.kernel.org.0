Return-Path: <dmaengine+bounces-11804-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IikEHjU1PmrrBQkAu9opvQ
	(envelope-from <dmaengine+bounces-11804-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 10:15:49 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C507B6CB40A
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 10:15:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=gYDtPdfK;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11804-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11804-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 988473015475
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 08:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6C631F9BA;
	Fri, 26 Jun 2026 08:15:47 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C9027FD43;
	Fri, 26 Jun 2026 08:15:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782461747; cv=none; b=Mhm+xn7XTkfw6RYhurkfcED1EW+PVIBpHUpax4/Fi4ebKiqSubXbmqkz+MlzObHwOArfZ19QNH4yRGwNZ/ftK5ljO5eOkQ7JYBWAfqdLrQkDYaYbT7PIxgIhO384tiSs7DFcPLxpCxt6pchRuG0RuUT84AS8WTqs+jNNknYYRr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782461747; c=relaxed/simple;
	bh=FSpoo9SK7Ccz2UIDW/xjZ2+jXOrE4r8QxIzWwq4B4ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mj/jJHS3OWUdurUNNt4FqGKeqXX7sigPXX7lKcgtEos0kVKONMCtZ2uhuro3biUaJPkujliC4hFqpDwiNyN+6U8VwokJPvv8GzxHd30stwD5ZyJwI1peOjtecVc4PuQka0tmvB+X686McLdXCX3e0J3LBi8tb4e1V3lY4VOWARQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYDtPdfK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23ECA1F000E9;
	Fri, 26 Jun 2026 08:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782461741;
	bh=UjdJOdYkJ840W0oSZDEwNaxUJAvwyJYWZ+XcDw5k27Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gYDtPdfKwzWLU3NcZhsHdVpI3ptP8a6ltHZ7Qe0uj/1d4BSNbVeDmzhawjTMCxL12
	 E1dyuGspTQGTnzNOQf+A59A3hve5xucLZIbYBkebA2TEveAXRYNJokWcSBvxL1yeC5
	 AH2qsTDkkii5TOJ1k2K4wVEFUnCkMgrLrtHmGdjKNaLvVL3l514LA4BFcro3O+2orm
	 Xo1wQMvhkZH07hhWSVCMH1xn2obV2wh5PxEykNtf9yGEocanYG0CBuXTHY6GKFUd4L
	 RvnSaGdZeDbyjaOJOvLxtg5ASLbxXOu+qlQS1X8b4pqTyd2vPhX2nJLvPubkD6S/es
	 MtY+6KnK89CQw==
Date: Fri, 26 Jun 2026 10:15:38 +0200
From: Vinod Koul <vkoul@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Niklas Cassel <cassel@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/17] dmaengine: dw-edma: Support dynamic LL appends
Message-ID: <aj41KvHARdenWnk8@vaman>
References: <20260615154111.2174161-1-den@valinux.co.jp>
 <tau5svk3bcatzeapqeb6mun7dxi4ifk56g5ltkk366ljozjzit@vepneiac3f26>
 <ajlEGS99fQT5rGkf@ryzen>
 <wmwhekjfeqomzehfyqczzxel3knkxlfgfyrifeqpcqpqq6viwq@abwyzxaibkio>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wmwhekjfeqomzehfyqczzxel3knkxlfgfyrifeqpcqpqq6viwq@abwyzxaibkio>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:den@valinux.co.jp,m:mani@kernel.org,m:cassel@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11804-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,vaman:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C507B6CB40A

On 23-06-26, 14:56, Koichiro Den wrote:
> Hi Niklas, Mani,
> 
> On Mon, Jun 22, 2026 at 04:18:01PM +0200, Niklas Cassel wrote:
> > On Mon, Jun 22, 2026 at 04:38:49PM +0900, Koichiro Den wrote:
> > > On Tue, Jun 16, 2026 at 12:40:54AM +0900, Koichiro Den wrote:
> > > 
> > > Hi Frank, Niklas, all,
> > > 
> > > I am looking for a good way to stress PCIe controller DMA engines, such as
> > > eDMA/HDMA, and measure their upper-bound throughput.
> > > 
> > > nvmet_pci_epf is useful since it is a real in-tree consumer, but it is not a
> > > very direct benchmark for the DMA engine itself. So I wonder if
> > > pci_endpoint_test would be a reasonable place to add an opt-in DMA performance
> > > mode.
> > > 
> > > One possible option I have in mind is:
> > > 
> > >   - a new fixture, pci_ep_dma_perf
> > >   - opt-in execution, for example with PCITEST_PERF=1 environment variable
> > >   - a few variants such as single and sg, possibly with a few knobs:
> > >      - PCITEST_PERF_NUM_WORKERS, to use multiple EP-side workers
> > >      - PCITEST_PERF_NUM_CHANS, to use multiple DMA channels
> > >      - perhaps other knobs for SG entry size, number of entries, etc.
> > >   - the new tests: READ_PERF_TEST and WRITE_PERF_TEST
>        `--- (A)
> 
> > > 
> > > For the other possible places I could think of, this still seems to fit best in
> > > pci_endpoint_test. For example, extending dmatest does not seem to fit well
>                                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > because this needs both EP and RC side setup. A separate kselftest also feels
>     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>                          `--- (B)
> 
> > > like it would duplicate a lot of pci_endpoint_test code. That said, I might be
> > > missing something.
> > > 
> > > What do you think? Any thoughts or suggestions would be much appreciated.
> > 
> > There are two existing (out-of-tree) tests for eDMA that I know of:
> > 
> > 1)
> > https://patchwork.kernel.org/project/linux-pci/patch/cc195ac53839b318764c8f6502002cd6d933a923.1547230339.git.gustavo.pimentel@synopsys.com/
> > 
> > But as you can see, the comment was to use dmatest instead.
> > AFAICT, dmatest currently only supports DMA_MEMCPY, which, by hardware design,
> > cannot be supported by DWC eDMA HW (since it only allows remote to local, or
> > local to remote, and remote has to be a PCI address, while local is local
> > physical address).
> > 
> > Perhaps it is possible to add DMA_SLAVE support to dmatest.
> 
> Thanks for the pointers, Niklas.
> 
> The first one looks like a host-side test on top of dw-edma-pcie, where the
> RC-side driver programs the eDMA through BARs. That is useful, but it is a bit
> different from what I had in mind here.
> 
> What I am looking for is closer to pci_endpoint_test READ_TEST/WRITE_TEST, but
> with a perf/stress mode: the RC side provides the buffers, while EP Linux
> drives the EP-local DMA engine and reports the throughput.
> 
> I agree that, if we extend dmatest with DMA_SLAVE support, then Vinod should be
> involved early. In theory that could cover this too, if dmatest also had a way
> to set up RC-side buffers and pass their PCI addresses to the EP side. That is
> the part that makes me unsure dmatest is the right fit here (see (B) above).
> Before going too far down that path, I wanted to check whether the PCI endpoint
> test stack would be an acceptable home for this EP-driven case.
> 
> > 
> > 
> > 2)
> > https://github.com/rockchip-linux/kernel/blob/develop-6.1/drivers/pci/controller/dwc/pcie-dw-dmatest.c
> > https://github.com/rockchip-linux/kernel/blob/develop-6.1/drivers/pci/controller/rockchip-pcie-dma.h
> > 
> > 
> > Anyway, since Vinod is the maintainer, it is probably him you need to talk
> > to come up with a way forward. To not waste your time, I would talk to him
> > before you spend a lot of time implementing something :)
> 
> Yes, that makes sense. I will keep Vinod in the loop. :)

Thanks, I am not sure it makes sense for dmatest to support slave
transfers. We need a hardware signalling for these dma transfers to
work and data is pushed/pulled from hardware.

I know it can be made to work for some kind of slave transfers like
possibly pcie etc and(there was another attempt to add a
driver for slave tests) but it is not really right as it would confuse
folks who might want to test it for slave transfers which typically cant
be done

So I am not is support of supporting this

-- 
~Vinod

