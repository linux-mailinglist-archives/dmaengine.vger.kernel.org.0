Return-Path: <dmaengine+bounces-10845-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFYsAf8JFGrVJAcAu9opvQ
	(envelope-from <dmaengine+bounces-10845-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 10:36:15 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CF55C7D5E
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 10:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CD54730089B2
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 08:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269443E4C66;
	Mon, 25 May 2026 08:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QuLi6Dzr"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B183E3DA8;
	Mon, 25 May 2026 08:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779698154; cv=none; b=HyYKVJLt0hJOntP267kmR3SBFE6YxdIUbjFz9+goh+aFD7hd3fC2EWsjG0iJLvswXHKDa7oN8VGG6aYp338I+cPpvDxM/rERAyc7m+kvEora1rPCN+koi62TN0PzuesBU61ma7qC8bRxzo0OUm6JddvgJPdSM8CDAM6zEw8dYow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779698154; c=relaxed/simple;
	bh=cWGHMjYYFvv9ikdhkbkpx3TAnmqIeAE6bFaAbcy+UNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tNNn23yiWj51n8z1Ik2HiFlgeVhy17iWFBc+OvWGdDiYt1XFICnKYy8j+t53Kx4weJv0GHFXRG6rKvCURyigJVMV484T0zWt34aNxqzAwXoq5jgu0BNbWdegZG14AdS3xHY1QId6B79GbjefQ/UakzAhtOFDIroFxQ1dCT23nn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QuLi6Dzr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71401F00A3E;
	Mon, 25 May 2026 08:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779698152;
	bh=WhhFXKFog9xZdGtrRmo6Zl9SceNoNBHUujnjb1u7fNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QuLi6Dzrc7bh5qbnYhaFhJT3MdPKKXL+L6SQ47xKSdgP2IZLGFEyyo+cZS9+BoTEM
	 iSKZElexdjTI7IN1Qp/9S7s5Q4IARAjXCNxelIF3+jvEVaXcyjFgmDpqo2gdVwYiNQ
	 VftColp+LbeFiUodSOCt/+ygM9MqeZdtRONbf/H88mTQXSwv0Cvci2uzesP0Q0Ywcr
	 feo5a/oi46ay/27pXszQ/L0RKj1K07EelMT9o4l9Ip8bkT/jfUSvPXFpEUauIg2rQE
	 0sFUXc/H4DOMhis+iDw/GCSkE4CcMiwRbtmDAGrqkti67orn79v6gEGOxDR6O2QkV1
	 yLiiZGtjARCaw==
Date: Mon, 25 May 2026 10:35:46 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vinod Koul <vkoul@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 0/3] PCI: endpoint: Add PCI DMA endpoint function
 (part 3/3)
Message-ID: <ahQJ4kuaBKMhj52L@ryzen>
References: <20260525063456.3317509-1-den@valinux.co.jp>
 <xnfnxv64hpil6if4ikyohxnarvsekbmjcc37k5zej264ix46z3@qtu6xj2uy3xi>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xnfnxv64hpil6if4ikyohxnarvsekbmjcc37k5zej264ix46z3@qtu6xj2uy3xi>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10845-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassel@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E0CF55C7D5E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 04:05:02PM +0900, Koichiro Den wrote:
> 
> I would like to ask you for your high-level opinion on the direction of this
> series.
> 
> Previously, I have tried two different approaches for the same objective:
> avoiding the extra CPU memcpy (or local DMA memcpy) in NTB transport on both EP
> and RC sides.
> 
> 1. Put dw-edma-specific handling under drivers/ntb/hw and let the (new) NTB
>    driver carry the metadata needed for channel delegation.
> 
>    [RFC PATCH v4 00/38] NTB transport backed by PCI EP embedded DMA
>    https://lore.kernel.org/all/20260118135440.1958279-1-den@valinux.co.jp/
> 
> 2. Treat endpoint DMA as a first-class part of vNTB. The RC-side ntb_hw_epf
>    would create an auxiliary device, and a new dw-edma-aux driver would create
>    the delegated DMA channels on the RC side.
> 
>    [PATCH 00/15] PCI: endpoint: Remote DMA support via vNTB
>    https://lore.kernel.org/linux-pci/20260312165005.1148676-1-den@valinux.co.jp/
> 
>    I added an ASCII diagram for the overview as a follow-up comment here:
>    https://lore.kernel.org/all/sn67hi7kljh7cgmgodatb3naz2astlaklqfobdbxyyzgoohxqb@4nnetbhqwba4/)
> 
> Now, this v2 series takes a third direction. It moves the DMA controller out of
> vNTB/NTB-specific ABI and exposes it as a separate PCI endpoint DMA function.
> The host then discovers it as a DMA controller function. The initial host-side
> driver is the existing dw-edma-pcie driver, and dw-edma-aux is no longer needed.
> 
> My current thinking is that this is the cleanest among the previous attempts.
> But this is mostly an architecture question, so I would like to know whether
> this direction looks acceptable to you.
> 
> In short, do you agree with the direction of this series, that endpoint DMA
> channel delegation should be modeled as a separate PCI endpoint DMA function?
> 
> If you think the vNTB-integrated direction is preferable, or if this should be
> modeled differently in the endpoint framework, I would rather adjust the
> direction as early as possible, before building the NTB transport on top of it.

Hello Koichiro,

I think it would have been nice if your overall goal was more clearly
described in the cover letter.

AFAICT, you goal is for "upper layer NTB consumers" to be able to use these
DMA channels.


Since these DMAengine channels will exposed on the host side, I assume that
these "upper layer NTB consumers" are also on the host side.
Could you perhaps give some specific examples of drivers on the host side
that will use these DMA channels?

How will these drivers on the host side know to use the correct DMA channel,
i.e. the DMA channel that is backed by this new PCI DMA EPF?
(And not some other random DMA channel, in case the SoC has multiple DMA
channels.)

If you need to configure your endpoint SoC to bind to the PCI DMA EPF,
don't you need the endpoint SoC to bind to the pci-epf-ntb or pci-epf-vntb
driver? I know that some endpoint controllers can bind to multiple EPFs.
Is the intention for the endpoint SoC to bind both to this new and PCI
DMA EPF and pci-epf-vntb ?

If so, but do really all endpoint controllers / endpoint controller drivers
support binding to multiple EPFs?


Kind regards,
Niklas

