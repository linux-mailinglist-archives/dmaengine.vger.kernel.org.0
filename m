Return-Path: <dmaengine+bounces-8964-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJqtAfvtlWlTWwIAu9opvQ
	(envelope-from <dmaengine+bounces-8964-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 18 Feb 2026 17:51:07 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B323157E26
	for <lists+dmaengine@lfdr.de>; Wed, 18 Feb 2026 17:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 87E823003818
	for <lists+dmaengine@lfdr.de>; Wed, 18 Feb 2026 16:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A613298CB2;
	Wed, 18 Feb 2026 16:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NFAw8i/C"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6571E285CB3;
	Wed, 18 Feb 2026 16:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771433460; cv=none; b=FPrebDzswhslV4wmFpVz+QEcw3rGI7GEHMRxIKnU3rlJ+PT+yUDCYOUE7lwG1tH2i3Rr3tA2KCzLvPaqNtuTlFNA+kA1HyBnNyvtZXnECsFQdIUvBatcqCQJXo9jHrRSSUev3GJ79bhFG01sPURwNSTx68YLkBE20diMOC/IwtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771433460; c=relaxed/simple;
	bh=cUVbs0M7H+hui7yG0/VlORqcHtg5yIVZFG39ExIV538=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aP/6jJtD+v0VOg9GxXHNStDWF0PNMXK/7Du0dDHwudAwkTM2FZOe/HeVI9F4ytqbH341Auy41ZMr146LaJ9MUoSiOFdhIAivz1jGcTbejm+gQirhM8CxuzJ22qiBsv1f+codCOIcyVVceyQSVwtYZa8niFmFLR/yU21V52EbzRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NFAw8i/C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A106AC116D0;
	Wed, 18 Feb 2026 16:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771433459;
	bh=cUVbs0M7H+hui7yG0/VlORqcHtg5yIVZFG39ExIV538=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NFAw8i/CBWZQf5Jg5TZCZAZfKro2+BsLLZSo+gkmDGLr11y7W69bwcpFyeLTqxTbX
	 5CZqqaLKubSBXk0uymdoqTg3AiUy60aM4Kkbxm45nsQhODowqHfFBtiZ9XuWJxta0O
	 w5a52tHfcS1cObAU5Crbx9v7tusvI5kEswOdkfK+SZ+MlKn78+aRrVUBEVc2k2eF7E
	 8bMJKqSaSaEXyTMZRj8BOdElGxSPFmQsF5P8tA1MOtCAAS28lxVL73FtkXdxNMFSwM
	 L6PEMIqXfCbbJbjYRGmBIMKlltwxSuXzRXrltQx1DeV0iy5c0C0R7y7wuZWENyFpbC
	 ruWL/MEWCuFfg==
Date: Wed, 18 Feb 2026 17:50:40 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: mani@kernel.org, vkoul@kernel.org, Frank.Li@kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] dmaengine: dw-edma: Interrupt-emulation doorbell
 support
Message-ID: <aZXt23tgJWyzTOOT@ryzen>
References: <20260215152216.3393561-1-den@valinux.co.jp>
 <2p7rmtp7aak6czf2yinbdqa6w3c2j55pw7dxahsmzeiuceg2pk@4rzpd772kcbq>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2p7rmtp7aak6czf2yinbdqa6w3c2j55pw7dxahsmzeiuceg2pk@4rzpd772kcbq>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8964-lists,dmaengine=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassel@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,get_maintainers.pl:url]
X-Rspamd-Queue-Id: 1B323157E26
X-Rspamd-Action: no action

Hello Koichiro,

On Thu, Feb 19, 2026 at 01:19:02AM +0900, Koichiro Den wrote:
> On Mon, Feb 16, 2026 at 12:22:14AM +0900, Koichiro Den wrote:
> > Hi,
> > 
> > Some DesignWare eDMA instances support "interrupt emulation", where a
> > software write can assert the IRQ line without setting the normal
> > DONE/ABORT status bits.
> > 
> > In the current mainline, on implementations that support interrupt
> > emulation, writing once to DMA_{WRITE,READ}_INT_STATUS_OFF is sufficient
> > to leave the level-triggered IRQ line asserted. Since the shared dw-edma
> > IRQ handlers only look at DONE/ABORT bits and do not perform any
> > deassertion sequence for interrupt emulation, the IRQ remains asserted
> > and is eventually disabled by the generic IRQ layer:
> > 
> >   $ sudo devmem2 0xe65d50a0 w 0
> > 
> >   [   47.189557] irq 48: nobody cared (try booting with the "irqpoll" option)
> >   ...
> >   [   47.190383] handlers:
> >   [   47.199837] [<00000000a5ecb36e>] dw_edma_interrupt_common
> >   [   47.200214] Disabling IRQ #48
> > 
> > In other words, a single interrupt-emulation write can leave the IRQ
> > line stuck asserted and render the DMA engine unusable until reboot.
> > 
> > This series fixes the problem by:
> > 
> >   - adding a core hook to deassert an emulated interrupt
> >   - wiring a requestable Linux virtual IRQ whose .irq_ack performs the
> >     deassert sequence
> >   - raising that virtual IRQ from the dw-edma IRQ path to ensure the
> >     deassert sequence is always executed
> > 
> > This makes interrupt emulation safe and also enables platform users to
> > expose it as a doorbell via the exported db_irq and db_offset.
> > 
> > This is a spin-off from:
> > https://lore.kernel.org/linux-pci/20260209125316.2132589-1-den@valinux.co.jp/
> > 
> > Based on dmaengine.git next branch latest:
> > Commit ab736ed52e34 ("dmaengine: add Frank Li as reviewer")
> > 
> > Thanks for reviewing,
> > 
> > 
> > Koichiro Den (2):
> >   dmaengine: dw-edma: Add interrupt-emulation hooks
> >   dmaengine: dw-edma: Add virtual IRQ for interrupt-emulation doorbells
> > 
> >  drivers/dma/dw-edma/dw-edma-core.c    | 127 +++++++++++++++++++++++++-
> >  drivers/dma/dw-edma/dw-edma-core.h    |  17 ++++
> >  drivers/dma/dw-edma/dw-edma-v0-core.c |  21 +++++
> >  drivers/dma/dw-edma/dw-hdma-v0-core.c |   7 ++
> >  include/linux/dma/edma.h              |   6 ++
> >  5 files changed, 173 insertions(+), 5 deletions(-)
> 
> +CC: Niklas
> 
> Niklas provided valuable feedback in the previous iterations and also helped
> test the earlier (non-split) series mentioned above. During testing, he
> identified that on platforms where chip->nr_irqs > 1, the interrupt emulation
> IRQ could be randomly delivered to one of the shared channel IRQs [1]. That
> observation was the main motivation for the rework.
> 
> I missed Niklas in CC earlier, sorry about that. I had naively relied on
> get_maintainers.pl. I'll be more careful.

Thank you for CC:ing me.

I'm happy to help with testing.

For reviewing, I will limit myself to drivers/pci/endpoint.
(I don't really have spare cycles to also review drivers/dma/dw-edma patches.)


Kind regards,
Niklas


