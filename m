Return-Path: <dmaengine+bounces-2733-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEC093BC32
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jul 2024 07:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B76FB21A39
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jul 2024 05:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0E61CD32;
	Thu, 25 Jul 2024 05:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpidYFZq"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04ACA1BC43;
	Thu, 25 Jul 2024 05:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721886671; cv=none; b=H0P17JaI4lXkPVjRNAyGz5gP4l54x/XuvfdNPMZyXUxhA69GjHIDYSTQTAANyc7iuR3psmzzRmJtidTZOrJDWWgOFkRcTSNGcyG7Fkgpc1cK7fPhPj8w+tZj98yLUEhjFTTecInmEbHFR78czpAXdOEuU9e9GJCghHSYv2lK1V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721886671; c=relaxed/simple;
	bh=/A9NAsn/VM9v7m4m+IepAXROAxVNPOGJaU/7RULXU8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zfmezp31TjQJ5GheXnry9uXqyvv2I0g0Gi9qKVvZ77aWTjB71J9e1Xm7UyMjCMQoVd81BIHsMF3gFzNo518OdQ0HWjnGbbJnDlE6S/dJsQXaqXLdpxlhDv0XkeDUazEQ/V48NQxADmQVAcxQRpmpOznnSNMVuu4yRMqQsB2jvb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpidYFZq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C27B9C116B1;
	Thu, 25 Jul 2024 05:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721886670;
	bh=/A9NAsn/VM9v7m4m+IepAXROAxVNPOGJaU/7RULXU8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TpidYFZq2mlMfxGraBAQqtsZGoUzNzXzD9pxr53u1kv3rLme4QcD6KHIORPyLWrX7
	 /jKhHLWCV4/7+t8HvDaHzxS7NLOppvpu22+4P12mrE48fVLTl/zOUARk0iAf80MgGH
	 A5Z9CqE0Tq5nexRA/IAkBLCbLRYPVMsIZtkEmwOLUHBkPbOEwEnxEDQhCOVmWCivfD
	 ahShert4AvcMePVGCEN7mndeSjCicXuGCpOagBozDOppEpe20jj75n0TTB+4fpmCR0
	 F1tBCJLsqvcgpnLjmZOzZAoL5jB2bjYByyRvNxlDXOl62vhQgvG0kp7ffyEfhV4UKh
	 xcjDVA19HC7zQ==
Date: Thu, 25 Jul 2024 11:21:06 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Sinan Kaya <okaya@kernel.org>, kernel@quicinc.com,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] dmaengine: qcom: add missing MODULE_DESCRIPTION() macros
Message-ID: <ZqHnynG0pFPryn3E@matsya>
References: <20240603-md-drivers-dma-qcom-v1-1-d1bd919352bf@quicinc.com>
 <171778244108.276050.8818140072679051239.b4-ty@kernel.org>
 <36f5502c-a07f-4809-aa24-7f996afc0a88@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36f5502c-a07f-4809-aa24-7f996afc0a88@quicinc.com>

On 23-07-24, 11:36, Jeff Johnson wrote:
> On 6/7/2024 10:47 AM, Vinod Koul wrote:
> > 
> > On Mon, 03 Jun 2024 10:06:42 -0700, Jeff Johnson wrote:
> >> make allmodconfig && make W=1 C=1 reports:
> >> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/qcom/hdma_mgmt.o
> >> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/qcom/hdma.o
> >>
> >> Add the missing invocations of the MODULE_DESCRIPTION() macro, using
> >> the descriptions from the associated Kconfig items.
> >>
> >> [...]
> > 
> > Applied, thanks!
> > 
> > [1/1] dmaengine: qcom: add missing MODULE_DESCRIPTION() macros
> >       commit: 8e9d83d7228f663ef340ebb339eaffc677277bd4
> > 
> 
> Hi Vinod,
> I see this landed in linux-next, but is not currently in Linus' tree for 6.11.
> Will you be able to have this pulled during the merge window?
> I'm trying to eradicate all of these warnings before 6.11 rc-final.

We are still in merge window!
FWIW, this is in linus's tree now

-- 
~Vinod

