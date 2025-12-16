Return-Path: <dmaengine+bounces-7677-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5A5CC3E8B
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 16:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5C27B302C5D9
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 15:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828A3366DCD;
	Tue, 16 Dec 2025 15:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJnxXBfP"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53809366DCB;
	Tue, 16 Dec 2025 15:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765898765; cv=none; b=Xs/LeXH/o2QJDlVR/nBQFll5gvRqAEBSa7qsJgirxIQr2vk04WZapGx4jr1JaMyPhPcXGd09jwgDeNTgckTzUD0CXAlwfXixDDyIpnQZ1YsEOtpI2f+wFMneI00oxURJNEAE3nQH1UtxMb52HFve2TmsYNDriV1bg63OVnGjmts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765898765; c=relaxed/simple;
	bh=oPBT1uvFdNEw1M57O3taYeispOFBCMR0ND78csytjM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lf3H9gdZ9D+N1C4RiPjshA+zQ9qd+N8m+JXQZAlxAiPSRhofHRbllK2t7P1PyA99cmTY5xjlXBLLoCCscCVNuUUNvPJ4ecuBCoYoKIlfkqsj7vQg7ihSk3DO6q8PEkEVPX8utz4S9Pn1u30PW6zvQL6jQgih3nE/lNrGxAwsZvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJnxXBfP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CBD2C4CEF1;
	Tue, 16 Dec 2025 15:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765898764;
	bh=oPBT1uvFdNEw1M57O3taYeispOFBCMR0ND78csytjM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GJnxXBfPGtoNsJLWtS7GgJZuvk3Uw1qUsM/wE8UZrz3dp+hHdytF0KiRmmboyVLJ9
	 MfBmfGXr0HLGBcnae0jiS6cebsQKQ/EOdaSsTMRqfFyk/quob+d0X8vpmuTWfS1ipd
	 o4mX5DK8y+wmcRxiEbcXEvwfKg7jp774WHtYdE+QsQSMY3qmvMFKUqt5cGPJTi5Y6C
	 VRIR9c8g6yj8tJzoUsr/wLWKr4UanbkyYE+7iQLvBGddjfBnzQJs4yU9oXu5B1Tdwu
	 92eOz5pJz7bt0cd3+n825hi5gowGfCYIhy5wdjQ5nL9K5hdP4A6LIEfANxoR3yps20
	 llOoN+cNHBNKA==
Date: Tue, 16 Dec 2025 20:56:01 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: jeanmichel.hautbois@yoseli.org, Angelo Dureghello <angelo@sysam.it>,
	Greg Ungerer <gerg@linux-m68k.org>, imx@lists.linux.dev,
	dmaengine@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] dma: mcf-edma: Add per-channel IRQ naming for
 debugging
Message-ID: <aUF6CdS6WVZuEP24@vaman>
References: <20251126-dma-coldfire-v2-0-5b1e4544d609@yoseli.org>
 <20251126-dma-coldfire-v2-2-5b1e4544d609@yoseli.org>
 <aScnArV/22L5VmxP@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aScnArV/22L5VmxP@lizhi-Precision-Tower-5810>

On 26-11-25, 11:12, Frank Li wrote:
> On Wed, Nov 26, 2025 at 09:36:03AM +0100, Jean-Michel Hautbois via B4 Relay wrote:
> > From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
> >
> > Add dynamic per-channel IRQ naming to make DMA interrupt identification
> > easier in /proc/interrupts and debugging tools.
> >
> > Instead of all channels showing "eDMA", they now show:
> > - "eDMA-0" through "eDMA-15" for channels 0-15
> > - "eDMA-16" through "eDMA-55" for channels 16-55
> > - "eDMA-tx-56" for the shared channel 56-63 interrupt
> > - "eDMA-err" for the error interrupt
> >
> > This aids debugging DMA issues by making it clear which channel's
> > interrupt is being serviced.
> >
> > Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
> > ---
> >  drivers/dma/mcf-edma-main.c | 26 ++++++++++++++++++--------
> >  1 file changed, 18 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/dma/mcf-edma-main.c b/drivers/dma/mcf-edma-main.c
> > index f95114829d80..6a7d88895501 100644
> > --- a/drivers/dma/mcf-edma-main.c
> > +++ b/drivers/dma/mcf-edma-main.c
> > @@ -81,8 +81,14 @@ static int mcf_edma_irq_init(struct platform_device *pdev,
> >  	if (!res)
> >  		return -1;
> >
> > -	for (ret = 0, i = res->start; i <= res->end; ++i)
> > -		ret |= request_irq(i, mcf_edma_tx_handler, 0, "eDMA", mcf_edma);
> > +	for (ret = 0, i = res->start; i <= res->end; ++i) {
> > +		char *irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
> > +						"eDMA-%d", (int)(i - res->start));
> > +		if (!irq_name)
> > +			return -ENOMEM;
> > +
> > +		ret |= request_irq(i, mcf_edma_tx_handler, 0, irq_name, mcf_edma);
> > +	}
> >  	if (ret)
> >  		return ret;
> 
> The existing code have problem, it should use devm_request_irq(). if one
> irq request failure, return here,  requested irq will not free.

Why is that an error!

> 
> You'd better add patch before this one to change to use devm_request_irq()

Not really, devm_ is a not always good option.

-- 
~Vinod

