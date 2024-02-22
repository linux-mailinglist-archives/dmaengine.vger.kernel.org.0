Return-Path: <dmaengine+bounces-1066-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE35185FA32
	for <lists+dmaengine@lfdr.de>; Thu, 22 Feb 2024 14:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E4BDB297CB
	for <lists+dmaengine@lfdr.de>; Thu, 22 Feb 2024 13:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAA01339B8;
	Thu, 22 Feb 2024 13:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPYcxwwB"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85D558ADF;
	Thu, 22 Feb 2024 13:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708609628; cv=none; b=QF6NhjKpdBVBdiBF77Fb96hMnfjguJmSWuNRobs/pI7zfqBo99j15tlIL/bmtcNYO6qpQzCFP4xfp2ZLij4b4/i9ihh5TR2JN1wIxHq8Bd2tTkBq4p4oBZUOn4/zpCWtCoAmUsJcukpjJKqdFjvrT6VbRuest7RPUC0//v9J4w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708609628; c=relaxed/simple;
	bh=aAkb71uaG7bEs8LOfMCDfKO2FHHwbVImI5+22zd2L68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppeOgTb1f9aypeH7j6fYJcPYxVQts67cmsF30HqphogiyENr6ROYs6jVPT0yNrSb03H6+JRfnFhOCE83+VTrZTUugLZpLVwDpddhxy+sohqhSGTKaP37NNKX9NJMHy1jrlA6COzDslWGFX6oGR88EitR75Sas9QROpctMZcZkKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPYcxwwB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07225C433C7;
	Thu, 22 Feb 2024 13:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708609627;
	bh=aAkb71uaG7bEs8LOfMCDfKO2FHHwbVImI5+22zd2L68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iPYcxwwB3QaqCQy7d9saeV4mtm5mGIXaFfX/921oXth2O8u9EUE2Me/gONDNgPLxN
	 3p5ZG24Plvnm2bz4OOGbfbwHpsLK10FWJjWGWhzkZata1PxFdhbWfWs5W7x7jlFiKw
	 nNKT1lH48sH3CHDxcDPoII1SDocHAdWLIl8bZM6an5QdgedYmlEPS0pLdD6avoZcdb
	 QkkAXGdEL6lOINxUKa9D8v+iYGpUsTFCwUZGYG8RH2ojj5qmkQuMID4wzAOloZBr5m
	 6eSbmZlB3PebaXPPRm7uymprC0U2RspDvqR4GUzans+HI7BpCp/5ZdE4s+J7nKLRvR
	 T9vcv1stRH3Kg==
Date: Thu, 22 Feb 2024 19:17:03 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>,
	"open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" <dmaengine@vger.kernel.org>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dmaengine: mxs-dma: switch from dma_coherent to
 dma_pool
Message-ID: <ZddQVzs-VvjraJAf@matsya>
References: <20240219155728.606497-1-Frank.Li@nxp.com>
 <CAOMZO5C4XFGoWYgexdFLgHiXAoAP7-aMdi=K6CG3adQE_mHAmA@mail.gmail.com>
 <ZdTjrzYIiD8pwHk8@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZdTjrzYIiD8pwHk8@lizhi-Precision-Tower-5810>

On 20-02-24, 12:38, Frank Li wrote:
> On Mon, Feb 19, 2024 at 01:23:22PM -0300, Fabio Estevam wrote:
> > On Mon, Feb 19, 2024 at 12:57 PM Frank Li <Frank.Li@nxp.com> wrote:
> > >
> > > From: Han Xu <han.xu@nxp.com>
> > >
> > > Using dma_pool to manage dma descriptor memory.
> > 
> > Please clearly describe the motivation for doing this.
> 
> This try to fix a cma_alloc failure. But it is not correct to use dma_pool.
> let's work out a better method.

Good one, but this should be in log :-)

> 
> Frank

-- 
~Vinod

