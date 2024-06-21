Return-Path: <dmaengine+bounces-2498-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8382F9121D0
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jun 2024 12:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3DEE1C23644
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jun 2024 10:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3250217109D;
	Fri, 21 Jun 2024 10:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rzIJDagQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D8A16E892;
	Fri, 21 Jun 2024 10:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718964639; cv=none; b=YRo/+TFyFTyrmqc8CYtNzZ0wtleE+K6rv/1bPfpKEn4VbYKnoo6oh5wtSStnQZsGK8zSpzy1wKLKlRquNW/yOzTXj2aKpMGxY5jRTY+CTQ3Li3IoyJNMSTYPw4W7ktQbn/Rtg56bkPSSMdD8YIArCjWPlb3bybJHMF8TqcIxbQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718964639; c=relaxed/simple;
	bh=2Yi3+MeiUnusqowgqbAbrIq7kxVvPD51ALy39yD86vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RbYJr8T3+acIeVYEpeuPhqUhEyBXtYM6Ysba/Ety+vmj6iNZsI8+pjpLDtbCOspBD9arjlZGkXqbCmOVBwGPcfa/epR8xPC0R7rrMSqGE5Bt9j26OYD5prTSzc+dpQcD3IFlYM9858OKFe3XuBBMfjvh/74gAwOoux9cdVqxFG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rzIJDagQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C6EC2BBFC;
	Fri, 21 Jun 2024 10:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718964638;
	bh=2Yi3+MeiUnusqowgqbAbrIq7kxVvPD51ALy39yD86vo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rzIJDagQIE3R0pU/M5rskebUl+aHYaBSrmr01jiLJIdPDlgvbckNiO3dFm6IhwojN
	 uMYXnAKl9oYrkuIGmRpw0ZFU+FV0iySCwweJFML6f3bixkiRYQpPyjju8F9tiTV7u/
	 pAyJM2ygE3B6wFb3jX+tX34lLsCQIz6ReZ7BiTnbnYm0RDMYx2WgTNy8B4/sX5jR/o
	 QMqbhmXRKn1bA/7juRNzlrGWHRf8fehuu5CMAO2syECbcLSsB+act95iLPDJIIV8qr
	 vqp5zf5A0Pawcg5ctPVk7qVJdwnZxHHviCiFxQhzSVXMdKlqyfyL98vn+RE7A96gjH
	 cBMT08hOiNM6w==
Date: Fri, 21 Jun 2024 15:40:34 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Paul Cercueil <paul@crapouillou.net>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Jonathan Corbet <corbet@lwn.net>, Nuno Sa <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v12 0/7] iio: new DMABUF based API v12
Message-ID: <ZnVRmsziiGxOVq-4@matsya>
References: <20240620122726.41232-1-paul@crapouillou.net>
 <ZnRW2axOg7gtKzz0@matsya>
 <20240620201150.72c11599@jic23-huawei>
 <ZnVRCY3PGPag0fSj@matsya>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnVRCY3PGPag0fSj@matsya>

On 21-06-24, 15:38, Vinod Koul wrote:
> On 20-06-24, 20:11, Jonathan Cameron wrote:
> > On Thu, 20 Jun 2024 21:50:41 +0530
> > Vinod Koul <vkoul@kernel.org> wrote:
> > 
> > > On 20-06-24, 14:27, Paul Cercueil wrote:
> > > > Hi Jonathan,  
> > > 
> > > Hey Jonathan,
> > > 
> > > Assuming we are fine with this series, how would you like to proceed.
> > > Would you be fine with me picking the dmaengine bits and providing a
> > > signed tag for you to pull?
> > > 
> > 
> > Hi Vinod,
> > 
> > Yes. That will work nicely.
> > From my side it all looks good.
> 
> Great, here it is:
> 
> The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:
> 
>   Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git topic/dma_vec_api

Sorry, sent branch instead of signed tag: here is the signed tag

    git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git dmaengine_topic_dma_vec

> for you to fetch changes up to 380afccc2a55e8015adae4266e8beff96ab620be:
> 
>   Documentation: dmaengine: Document new dma_vec API (2024-06-21 15:31:57 +0530)
> 
> ----------------------------------------------------------------
> Paul Cercueil (3):
>       dmaengine: Add API function dmaengine_prep_peripheral_dma_vec()
>       dmaengine: dma-axi-dmac: Implement device_prep_peripheral_dma_vec
>       Documentation: dmaengine: Document new dma_vec API
> 
>  Documentation/driver-api/dmaengine/client.rst   |  9 ++++++
>  Documentation/driver-api/dmaengine/provider.rst | 10 +++++++
>  drivers/dma/dma-axi-dmac.c                      | 40 +++++++++++++++++++++++++
>  include/linux/dmaengine.h                       | 33 ++++++++++++++++++++
>  4 files changed, 92 insertions(+)
> 
> 
> Thanks
> -- 
> ~Vinod



-- 
~Vinod

