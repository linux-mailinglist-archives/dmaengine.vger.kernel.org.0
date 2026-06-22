Return-Path: <dmaengine+bounces-11721-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H3EFECVEOWplpgcAu9opvQ
	(envelope-from <dmaengine+bounces-11721-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 16:18:13 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B296B0402
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 16:18:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=EVLTbodT;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11721-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11721-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3A1873007B27
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 14:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D2A3B992E;
	Mon, 22 Jun 2026 14:18:06 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B373B3C1A;
	Mon, 22 Jun 2026 14:18:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782137886; cv=none; b=JXHgOfxqT5oWgREU4FZ+IBmtXyI7Jc/MwC5+kqts3vP0sHjzcosJLG1tdn5EHmtb9ziuDk0tJnJrkBFbEBBAadmb2Hc6Wzi/NNzAzwvXOEc4xV/JreESXV9lOB/2Qluln4Cwbj7qleEe0W+mAun4qO4r41bXP+NTRDKPpolwgOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782137886; c=relaxed/simple;
	bh=vVOJCSwU/AlhedmvgwGw2qqdbBdYbj30GIUA5SvAdF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RwZk9oTPukFD8C4D+ul61GsMXIQP+ht0k7jp4NrBRdocfGwg6SbHpMyoVnbv0eojfRZhImIm0YApKzvfQ008TpDOA5+uIqa8YzWcyIBkUMqqsEbwnov4f0eay/NtgcrFrKK/20SuTpLtCNxXJHObDOM/ZZ9OgVBVFl4nbuKAYyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVLTbodT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C131F000E9;
	Mon, 22 Jun 2026 14:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782137884;
	bh=0ox8zRkJx0LI6GwcR7V69/qg6tR/JvYMLzclarSfrHI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EVLTbodTk8ejKM86Nbx/4+i26Oph2bbTATtmSnKgbQPyhQSwiJnyefZh1tyGvODZU
	 QdkTDGV4qW2YvI0SE2wmQlEDxkVc1VipHb/xcXthjiC7lqI9xbDJrtTITNoC+Qebqq
	 ZwvBxgTMs2dnXBXYE2MBo6wAr8UPlaJLZzVtGA9AO2NRrikEadQNpygXZJLtreTwYK
	 7R17rhtJ/n3RKYDucquA1dsFsFrcsDmovDdX1a29vKtxwOY1azbS848ZVptYdKgtSw
	 KrAy8r07L1rkBWMiso5vqr7ES6mfNYLWxS5+M5cZtL+2tVqBd7+NBPeoUxNF96AWSm
	 wpRNuK0+Zh+Hg==
Date: Mon, 22 Jun 2026 16:18:01 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH 00/17] dmaengine: dw-edma: Support dynamic LL appends
Message-ID: <ajlEGS99fQT5rGkf@ryzen>
References: <20260615154111.2174161-1-den@valinux.co.jp>
 <tau5svk3bcatzeapqeb6mun7dxi4ifk56g5ltkk366ljozjzit@vepneiac3f26>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tau5svk3bcatzeapqeb6mun7dxi4ifk56g5ltkk366ljozjzit@vepneiac3f26>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:den@valinux.co.jp,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mani@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[cassel@kernel.org,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11721-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassel@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,ryzen:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 30B296B0402

On Mon, Jun 22, 2026 at 04:38:49PM +0900, Koichiro Den wrote:
> On Tue, Jun 16, 2026 at 12:40:54AM +0900, Koichiro Den wrote:
> 
> Hi Frank, Niklas, all,
> 
> I am looking for a good way to stress PCIe controller DMA engines, such as
> eDMA/HDMA, and measure their upper-bound throughput.
> 
> nvmet_pci_epf is useful since it is a real in-tree consumer, but it is not a
> very direct benchmark for the DMA engine itself. So I wonder if
> pci_endpoint_test would be a reasonable place to add an opt-in DMA performance
> mode.
> 
> One possible option I have in mind is:
> 
>   - a new fixture, pci_ep_dma_perf
>   - opt-in execution, for example with PCITEST_PERF=1 environment variable
>   - a few variants such as single and sg, possibly with a few knobs:
>      - PCITEST_PERF_NUM_WORKERS, to use multiple EP-side workers
>      - PCITEST_PERF_NUM_CHANS, to use multiple DMA channels
>      - perhaps other knobs for SG entry size, number of entries, etc.
>   - the new tests: READ_PERF_TEST and WRITE_PERF_TEST
> 
> For the other possible places I could think of, this still seems to fit best in
> pci_endpoint_test. For example, extending dmatest does not seem to fit well
> because this needs both EP and RC side setup. A separate kselftest also feels
> like it would duplicate a lot of pci_endpoint_test code. That said, I might be
> missing something.
> 
> What do you think? Any thoughts or suggestions would be much appreciated.

There are two existing (out-of-tree) tests for eDMA that I know of:

1)
https://patchwork.kernel.org/project/linux-pci/patch/cc195ac53839b318764c8f6502002cd6d933a923.1547230339.git.gustavo.pimentel@synopsys.com/

But as you can see, the comment was to use dmatest instead.
AFAICT, dmatest currently only supports DMA_MEMCPY, which, by hardware design,
cannot be supported by DWC eDMA HW (since it only allows remote to local, or
local to remote, and remote has to be a PCI address, while local is local
physical address).

Perhaps it is possible to add DMA_SLAVE support to dmatest.


2)
https://github.com/rockchip-linux/kernel/blob/develop-6.1/drivers/pci/controller/dwc/pcie-dw-dmatest.c
https://github.com/rockchip-linux/kernel/blob/develop-6.1/drivers/pci/controller/rockchip-pcie-dma.h


Anyway, since Vinod is the maintainer, it is probably him you need to talk
to come up with a way forward. To not waste your time, I would talk to him
before you spend a lot of time implementing something :)


Kind regards,
Niklas

