Return-Path: <dmaengine+bounces-2303-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 031AB8FFE16
	for <lists+dmaengine@lfdr.de>; Fri,  7 Jun 2024 10:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83F56283DD7
	for <lists+dmaengine@lfdr.de>; Fri,  7 Jun 2024 08:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA2515B115;
	Fri,  7 Jun 2024 08:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="O0RSlYsw"
X-Original-To: dmaengine@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C503615AD9B;
	Fri,  7 Jun 2024 08:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717749274; cv=none; b=DDJD4hvU3WWJPe3xvTT0V43l7Xv3giFLqmXSE+S5ijnlVnMeYYpThGE92br/bAW8/2SIGCn8u7knXyXpvrfjoczA3HMovU6DgYtKTINFAen+WpjwV6edz0A9QJKCkUaWcvyabH54Brcl3ruYARvNoZv92FLRfYwwg3ZiQ1WGBo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717749274; c=relaxed/simple;
	bh=/Nzeasn5SDIllA/M0CyzgW1HWkP+BnqHZ1wN9YJUFDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cOiEk/21CPA7PdCn0TPxaHASTxgg+JFr4VRplRcbaAX5StKmdIts9lIK/s3NGTWjOLLULiUNpM0HMCsQAF3GtenZDduJdf2YFzkSp9CN0Y1kS8igoPjB3ywRrvFsP88p3Zw9IMB+m8UltFuoW5lDkKtzZVU9tROexQon7IqjC6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=O0RSlYsw; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7B79C40002;
	Fri,  7 Jun 2024 08:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1717749271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R4etCTB/NBjKK0WpeKqWipiUTv2zbFBVaX2GovjFzXA=;
	b=O0RSlYswp5a0bEVWELBfy0AZXlKWR4UHGUVWbngpm7eSTs0FAbiTUb8m9+mu8Y14DgxJKv
	NhIbL6j/hN9ZmcC1jLK6XjFJTSi1AVy4CYioS1vCJuMekVc97+IqQ8K8reai63ZxHv1nxH
	eMKHHQHcunaxXHbdOfLCLhFkPm/HAtaS5s7KqM6bD8l5INpdwQ8plNM+Ojsz/4LJMHu4Ra
	a5wTyoPD0LpyKQrmaC80hf5X5R1auF4psJTyTF9dP4+h4PRFan/+TAxEbtOkS/8TEgmUKk
	MQNUZRVjxgKd7mo2Op5wrzNM48ODJ+yDSZAGgQgB9biPa2qAmUFWAwfOGEO42w==
Date: Fri, 7 Jun 2024 10:34:29 +0200
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Brian Xu <brian.xu@amd.com>, Lizhi Hou <lizhi.hou@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
	Vinod Koul <vkoul@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dmaengine: xilinx: xdma: Fixes possible threading issue
Message-ID: <ZmLGFXPEP-FqgUdn@localhost.localdomain>
Mail-Followup-To: Markus Elfring <Markus.Elfring@web.de>,
	dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Brian Xu <brian.xu@amd.com>, Lizhi Hou <lizhi.hou@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
	Vinod Koul <vkoul@kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20240527-xdma-fixes-v1-1-f31434b56842@bootlin.com>
 <f0eaf77b-eed9-4f8e-8009-983250fa56a8@web.de>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f0eaf77b-eed9-4f8e-8009-983250fa56a8@web.de>
X-GND-Sasl: louis.chauvet@bootlin.com

Le 27/05/24 - 20:32, Markus Elfring a écrit :
> > The current interrupt handler in xdma.c was using xdma->stop_request
> > before locking the vchan lock.
> 
> 1. Will an additional imperative wording become helpful here?
>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.10-rc1#n94
> 
> 2. How do you think about to use the summary phrase “Fix data synchronisation in xdma_channel_isr()”?

I changed the commit message and summary in the v2.
 
> 3. Will development interests grow for the usage of a statement like “guard(spin)(&xchan->vchan.lock);”?
>    https://elixir.bootlin.com/linux/v6.10-rc1/source/include/linux/cleanup.h#L124

I don't feel comfortable switching `guard` as the rest of the driver is 
not using it yet. Since this is a fix, I prefer to maintain consistency 
with the style of the rest of the driver.

Thanks,
Louis Chauvet

> 
> Regards,
> Markus
> 

-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

