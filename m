Return-Path: <dmaengine+bounces-1954-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2896B8B1D5F
	for <lists+dmaengine@lfdr.de>; Thu, 25 Apr 2024 11:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5103BB262D0
	for <lists+dmaengine@lfdr.de>; Thu, 25 Apr 2024 09:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E4784E10;
	Thu, 25 Apr 2024 09:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8GF5ar9"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A53684E04;
	Thu, 25 Apr 2024 09:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714035858; cv=none; b=mvem8MK+b+earJInyomy3wanlQgf9kHq9lQS4wNIcWJxU6urMNpS+9pZf6msvk/mj4+Mx8ltJuh8MzY0gT3wTWXL/VgseecCDTZj4fOER3SqrHcU73HOWj3RXXj+FMvru4rqF4BknFVINwGIbj0O5huj33K8jM/qJXzhBg+Heh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714035858; c=relaxed/simple;
	bh=shrNbSpov1s6eEL8cOPectBeWnoWaBh+qGBrCjqo5T4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+K0gVeFYQUjBtu4NBd7Z4yMipS7bBEUpJ14AaiTRR6yY25qkVClZzVK95d1sSANTqMmCY2CVSx3fGeh6Gh5jgLMZVKz27HWorglwKConlqxym7C9hBHkTbysXxajRmEjMDYdOsOSZEpqZtadZkAgQYm7TRso+3FQndbVnrEiIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8GF5ar9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A146C113CC;
	Thu, 25 Apr 2024 09:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714035858;
	bh=shrNbSpov1s6eEL8cOPectBeWnoWaBh+qGBrCjqo5T4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p8GF5ar9yLaskEOKuKkE9poD8VEe36ZHkjTlVnVHgaSkz7DvZcjv6zethmaP06dSV
	 6rBbkug81eIUCaB4yWzW02AZcrc5H5nEmFxszUNbpXodSB0G2EH2e6Qw4IecPeGcgz
	 M6he4/IjFg8e9cVcbOa9kiIHrjBQU+zNPO5qcYNsnZMA/wHeJlscTozVjdyj6m60qa
	 epETuoI1JvN/ZP8ouMkEqQMhu36MwX+7WVeJKhvT7pMnBnczcRGysJAshhqbaT9kLt
	 43FxupTvq16/kb7R67H6yqVftzmfYUnmrC8Q44z8LZhGWQ7IUkXJAAAYrjqt5odxUw
	 lqB6qrNODZfRg==
Date: Thu, 25 Apr 2024 14:34:13 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Ma Ke <make_ruc2021@163.com>, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	dmaengine@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: mxs-dma: Add check for dma_set_max_seg_size()
Message-ID: <ZiocjS6tbeTt2mPD@matsya>
References: <20240423143205.1420976-1-make_ruc2021@163.com>
 <ZiiFZZ8kwDeRWhjR@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiiFZZ8kwDeRWhjR@lizhi-Precision-Tower-5810>

On 24-04-24, 00:07, Frank Li wrote:
> On Tue, Apr 23, 2024 at 10:32:05PM +0800, Ma Ke wrote:

> > -	dma_set_max_seg_size(mxs_dma->dma_device.dev, MAX_XFER_BYTES);
> > +	ret = dma_set_max_seg_size(mxs_dma->dma_device.dev, MAX_XFER_BYTES);
> > +	if (ret)
> > +		return ret;
> 
> How error happen? 
> 
> static inline int dma_set_max_seg_size(struct device *dev, unsigned int size)
> {
> 	if (dev->dma_parms) {
> 		dev->dma_parms->max_segment_size = size;
> 		return 0;
> 	}
> 	return -EIO;
> }
> 
> Only possible dev->dma_parms is null. but mxs-dma is platform device, it
> point to platform's dma_parms field. Look like impossible it is null.

Yep, checking for the sake of checking is bad. It needs to be logical

-- 
~Vinod

