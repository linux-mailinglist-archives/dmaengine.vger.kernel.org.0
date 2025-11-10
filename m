Return-Path: <dmaengine+bounces-7128-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 254CEC4784A
	for <lists+dmaengine@lfdr.de>; Mon, 10 Nov 2025 16:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E94874F5815
	for <lists+dmaengine@lfdr.de>; Mon, 10 Nov 2025 15:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870063128AB;
	Mon, 10 Nov 2025 15:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMbris1l"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B3D22FDEA;
	Mon, 10 Nov 2025 15:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762787881; cv=none; b=C6DNfQB1gQWgeS8Az/AZbLvOxmExcehfXzf1/UKCWNd9/VB5bNjHWupNNj+YA/aa+NHFUdaoWVa66PXaFG/7OpuLhbaX3wdDj4jRm7BWfJcApCNv6TUy8zIHDBTdkG4zAZxVIEKh5BPLkglnRPSV99yu2LtKBc8+jHtoQLMhLdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762787881; c=relaxed/simple;
	bh=bXd9TtF3dk2wRq/oyzyztTa7C2oi3PkIcAOa05k8Tlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2YY4gNnJPHCC01tJJeyqx02n1cgur6F66B3aWVp5QOMB8fjPbgsNqYBMSfPj2KNzp1tgmu6i3oIrW4V0SNEcb+7GpdFjLGLZoq61xMTX7yGE0nZ/o+qQ6qDboFwM2CsQeuuzIEXS6NiHwkQg6jpNXAEer4D99n78wLBqNTcX30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMbris1l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43FDBC4CEF5;
	Mon, 10 Nov 2025 15:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762787880;
	bh=bXd9TtF3dk2wRq/oyzyztTa7C2oi3PkIcAOa05k8Tlc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TMbris1lF1zUOR+rGlAjOMgRPn2kNYoJHRbnvYFQWaaIX14n+LHehqDy0FcnNZa5v
	 hwc5SOnQDIhKdThiA/NIwcIbGGcIsksIDSVbZBNxyQr8VaaYKF9Zi9BFzHgKNlB67E
	 vRNE7hp+l1PUBjxVkQ2B1Xg2oeOiaxcjHNl7XgxwZJhl3FoA0A5XJYNFareLSD+B13
	 IZI+uziLiPWuqSoo8y0FZXBO6Ec2by7B5cDqiXUUrxYxRUV24bABkd1QnqWrO+6vwx
	 Uosw+h6nEz+AAWMEzPQnBCCXb3zJGZU0GpcfGkIWB1DtbBARyGyE8Qz8vlENswZHZn
	 ozHwZ7m8HVdUg==
Date: Mon, 10 Nov 2025 09:22:06 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Stefan Wahren <wahrenst@gmx.net>, Vinod Koul <vkoul@kernel.org>, 
	Thomas Andreatta <thomasandreatta2000@gmail.com>, Caleb Sander Mateos <csander@purestorage.com>, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, Olivier Dautricourt <olivierdautricourt@gmail.com>, 
	Stefan Roese <sr@denx.de>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Daniel Mack <daniel@zonque.org>, 
	Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>, 
	Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>, Michal Simek <michal.simek@amd.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 00/13] dmaengine: introduce sg_nents_for_dma() and
 convert users
Message-ID: <h4twbib3pxrcmohckzg7d64moo5v5gjtdu3pz5wtroegdylcuh@7po5qbe3h2au>
References: <20251110103805.3562136-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110103805.3562136-1-andriy.shevchenko@linux.intel.com>

On Mon, Nov 10, 2025 at 11:23:27AM +0100, Andy Shevchenko wrote:
> A handful of the DMAengine drivers use same routine to calculate the number of
> SG entries needed for the given DMA transfer. Provide a common helper for them
> and convert.
> 
> I left the new helper on SG level of API because brief grepping shows potential
> candidates outside of DMA engine, e.g.:
> 
>   drivers/crypto/chelsio/chcr_algo.c:154:  nents += DIV_ROUND_UP(less, entlen);
>   drivers/spi/spi-stm32.c:1495:  /* Count the number of entries needed */
> 

Comment in patch 1, but for the rest.

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> Changelog v2:
> - dropped outdated patches (only 9 years passed :-)
> - rebased on top of the current kernel
> - left API SG wide It might
> 
> v1: https://patchwork.kernel.org/project/linux-dmaengine/patch/20161021173535.100245-1-andriy.shevchenko@linux.intel.com/
> 
> Andy Shevchenko (13):
>   scatterlist: introduce sg_nents_for_dma() helper
>   dmaengine: altera-msgdma: use sg_nents_for_dma() helper
>   dmaengine: axi-dmac: use sg_nents_for_dma() helper
>   dmaengine: bcm2835-dma: use sg_nents_for_dma() helper
>   dmaengine: dw-axi-dmac: use sg_nents_for_dma() helper
>   dmaengine: k3dma: use sg_nents_for_dma() helper
>   dmaengine: lgm: use sg_nents_for_dma() helper
>   dmaengine: pxa-dma: use sg_nents_for_dma() helper
>   dmaengine: qcom: adm: use sg_nents_for_dma() helper
>   dmaengine: qcom: bam_dma: use sg_nents_for_dma() helper
>   dmaengine: sa11x0: use sg_nents_for_dma() helper
>   dmaengine: sh: use sg_nents_for_dma() helper
>   dmaengine: xilinx: xdma: use sg_nents_for_dma() helper
> 
>  drivers/dma/altera-msgdma.c                   |  5 ++--
>  drivers/dma/bcm2835-dma.c                     | 19 +-------------
>  drivers/dma/dma-axi-dmac.c                    |  5 +---
>  .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    |  6 ++---
>  drivers/dma/k3dma.c                           |  9 ++-----
>  drivers/dma/lgm/lgm-dma.c                     |  9 ++-----
>  drivers/dma/pxa_dma.c                         |  5 ++--
>  drivers/dma/qcom/bam_dma.c                    |  9 ++-----
>  drivers/dma/qcom/qcom_adm.c                   |  9 +++----
>  drivers/dma/sa11x0-dma.c                      |  6 ++---
>  drivers/dma/sh/shdma-base.c                   |  5 ++--
>  drivers/dma/xilinx/xdma.c                     |  6 ++---
>  include/linux/scatterlist.h                   |  2 ++
>  lib/scatterlist.c                             | 25 +++++++++++++++++++
>  14 files changed, 51 insertions(+), 69 deletions(-)
> 
> -- 
> 2.50.1
> 
> 

