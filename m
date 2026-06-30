Return-Path: <dmaengine+bounces-11885-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VihZHB6sQ2r4egoAu9opvQ
	(envelope-from <dmaengine+bounces-11885-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 13:44:30 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D59B16E3C3E
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 13:44:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nFSXSQrg;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11885-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11885-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C7553106FED
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 11:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B8F40B367;
	Tue, 30 Jun 2026 11:38:40 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759FF4071D6;
	Tue, 30 Jun 2026 11:38:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782819520; cv=none; b=CkIAiRX/bwPUnKJjC1YSeWw1V1k3jv2TxemK9Sa+M2WuVW8Tr1q73Nwf2SFpGSNp2zrScmTN7ahBLaN9+/RFltkcRowAkLeUfn9Ca8OWODlWhbqYfT9TGV1fWETV5riB+MiGkFHBeYYsKZ/VmO5IwCsQTh3bWjxRWxL29sGvUE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782819520; c=relaxed/simple;
	bh=TYmlMKfpCdf6CgrNLlC1hrbFPAspNdrX9KX2AjzhlSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7I4k/97jyi+w0A7qyTrSOFnYPy8OE5YlECVqgMFgiN1SRKRda85AfuNB4cvJGwXT7W/wf6sYgSJx9vv/2KRy0W/w92vRe0J0/jqo1NcQXLbVqfqe1eHrBdByb3qqsOXdqpSQ5o60CY3jtpxC8DDRWKRzErlxx8INuvzNwK4sSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFSXSQrg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D09DD1F000E9;
	Tue, 30 Jun 2026 11:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782819519;
	bh=SEvI5vX03gNO5qyv+rKrpeZ2JCKTONuzX9dwl5POz6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nFSXSQrgMiaulk6axNDe1w7YiD4EIAOjMOFIGsmfLvdduLpNLF9DUrOSZv7aXtJtu
	 1uGH6SmiHFaeCFPoi1ZqLNkn/kExdKfrYOm5dONKn2ZfVDkdlFyWSZx5D3vXhQ6lhh
	 F4SrHzybn6MwGZtc+HdXbX0CT8anfvWIfYxs7Jna8+i26fwrG/JKnFfSw0bLJCkG8K
	 Nt7OeK35TlBZQMhp6FxtVF8w5RZANN+CedDcBC99GQzRlx6oDGwF7mhHy37D2mLny+
	 qWgMFFNFmufxsF5kaOut6WCW4Mi+5cXUzduN6pqMG61Kov9obWRjUD5CuXS5YEd1cW
	 JkKJvVZPydtSg==
Date: Tue, 30 Jun 2026 13:38:32 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Koichiro Den <den@valinux.co.jp>, Frank Li <Frank.Li@kernel.org>, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/17] dmaengine: dw-edma: Support dynamic LL appends
Message-ID: <rf22kgt3tyradxuxg6c7nifas6olde7jdslkavf3qbbgdb2qlb@fl4wgcrrihcx>
References: <20260615154111.2174161-1-den@valinux.co.jp>
 <tau5svk3bcatzeapqeb6mun7dxi4ifk56g5ltkk366ljozjzit@vepneiac3f26>
 <ajlEGS99fQT5rGkf@ryzen>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajlEGS99fQT5rGkf@ryzen>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:cassel@kernel.org,m:den@valinux.co.jp,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[mani@kernel.org,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11885-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mani@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D59B16E3C3E

On Mon, Jun 22, 2026 at 04:18:01PM +0200, Niklas Cassel wrote:
> On Mon, Jun 22, 2026 at 04:38:49PM +0900, Koichiro Den wrote:
> > On Tue, Jun 16, 2026 at 12:40:54AM +0900, Koichiro Den wrote:
> > 
> > Hi Frank, Niklas, all,
> > 
> > I am looking for a good way to stress PCIe controller DMA engines, such as
> > eDMA/HDMA, and measure their upper-bound throughput.
> > 
> > nvmet_pci_epf is useful since it is a real in-tree consumer, but it is not a
> > very direct benchmark for the DMA engine itself. So I wonder if
> > pci_endpoint_test would be a reasonable place to add an opt-in DMA performance
> > mode.
> > 

I think including DMA performance tests to pci-epf-test would overload it.
pci-epf-test already provides the bare minimum read/write benchmark, which I
feel is sufficient enough.

> > One possible option I have in mind is:
> > 
> >   - a new fixture, pci_ep_dma_perf
> >   - opt-in execution, for example with PCITEST_PERF=1 environment variable
> >   - a few variants such as single and sg, possibly with a few knobs:
> >      - PCITEST_PERF_NUM_WORKERS, to use multiple EP-side workers
> >      - PCITEST_PERF_NUM_CHANS, to use multiple DMA channels
> >      - perhaps other knobs for SG entry size, number of entries, etc.
> >   - the new tests: READ_PERF_TEST and WRITE_PERF_TEST
> > 
> > For the other possible places I could think of, this still seems to fit best in
> > pci_endpoint_test. For example, extending dmatest does not seem to fit well
> > because this needs both EP and RC side setup. A separate kselftest also feels
> > like it would duplicate a lot of pci_endpoint_test code. That said, I might be
> > missing something.
> > 
> > What do you think? Any thoughts or suggestions would be much appreciated.
> 
> There are two existing (out-of-tree) tests for eDMA that I know of:
> 
> 1)
> https://patchwork.kernel.org/project/linux-pci/patch/cc195ac53839b318764c8f6502002cd6d933a923.1547230339.git.gustavo.pimentel@synopsys.com/
> 
> But as you can see, the comment was to use dmatest instead.
> AFAICT, dmatest currently only supports DMA_MEMCPY, which, by hardware design,
> cannot be supported by DWC eDMA HW (since it only allows remote to local, or
> local to remote, and remote has to be a PCI address, while local is local
> physical address).
> 
> Perhaps it is possible to add DMA_SLAVE support to dmatest.
> 

Since Vinod is not in favor of it, you can also think about adding eDMA/HDMA
specific kselftests. It makes lot of sense to write a  standalone test since
we can configure this IP from both host and endpoint side.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

