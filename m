Return-Path: <dmaengine+bounces-1479-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A36887C70
	for <lists+dmaengine@lfdr.de>; Sun, 24 Mar 2024 12:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12349281790
	for <lists+dmaengine@lfdr.de>; Sun, 24 Mar 2024 11:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E8F175A5;
	Sun, 24 Mar 2024 11:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qdOmj8Ip"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EA87F9;
	Sun, 24 Mar 2024 11:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711278648; cv=none; b=WN9EB/GJiNR7G+U+fG3aqB7VeFb6UpIduVmbQMMclvj1Nd3Pii1o284Y/b4CkgK2i8BIdNRoTDlIxd1IETwitwPx6+kYrbvsm2MTnO2E6uN1D7n8Chf4kFntUIZL19+UK90nMs4QQn10Gwuse7Jg/iSWO8Z4zCJUtroqS2Fev+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711278648; c=relaxed/simple;
	bh=SliL9lrMTLlb02DVUsEIoBH8kLWyicIpi30CBkLACAo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AzLipZMaqjkBBHaCv0ODOKvQJJ5H+6LYx9MfbDUEAUAgvwO+jvo/98cf8urchR5Vra7X5kG6ynKN3XsK3BO3SYZE0GYvQZ33v4wAAamXgqMsIB2AGOdDCEj57Cd1rXvv0mvRt6aB52rl6Bl5r5Qwbc92zhafuAqj8yL/H+dUoxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qdOmj8Ip; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 070DBC433C7;
	Sun, 24 Mar 2024 11:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711278647;
	bh=SliL9lrMTLlb02DVUsEIoBH8kLWyicIpi30CBkLACAo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qdOmj8IpSvL3J1HmB8y+mew6CrhOA5NEiJ+Rg96N5Ypb0+1f6aHFpehOcU8yMYb1T
	 K+47LI2WbRdPyAtvyY5X9mIQEBr9Pt+UpiFubwh09VFW0BMVCFaSPhauvft+3QF0ta
	 9/ZFA5SCCUitIIwkoOTDD3W2+ivaUkMR2V7NgvG6xR2tqP65XaCWCFY2JQRU4TtM4S
	 CxIYu4u5VRpCBy2i5e+K5CELBbNGfgrL6KbZOWBh2Yn5WZRVpuU8qauoXFqQga+Ucl
	 Z5wWRlAxqQv/w5DNHX2WaHoSzjmRBN42Kzg//5BJDZT4VmaLFknBalJp5xjyeSY43z
	 TLSSlAUd1MY9w==
Date: Sun, 24 Mar 2024 11:10:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Paul Cercueil <paul@crapouillou.net>
Cc: Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, Jonathan
 Corbet <corbet@lwn.net>, Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul
 <vkoul@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, Nuno Sa
 <nuno.sa@analog.com>, Michael Hennerich <michael.hennerich@analog.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v9 0/6] iio: new DMABUF based API
Message-ID: <20240324111029.3c57b885@jic23-huawei>
In-Reply-To: <20240310124836.31863-1-paul@crapouillou.net>
References: <20240310124836.31863-1-paul@crapouillou.net>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 10 Mar 2024 13:48:29 +0100
Paul Cercueil <paul@crapouillou.net> wrote:

> Hi Jonathan,
> 
> Here's the final-er version of the IIO DMABUF patchset.
> 
> This v9 fixes the few issues reported by the kernel bot.
> 
> This was based on next-20240308.
> 
> Changelog:
> 
> - [3/6]:
>     - Select DMA_SHARED_BUFFER in Kconfig
>     - Remove useless forward declaration of 'iio_dma_fence'
>     - Import DMA-BUF namespace
>     - Add missing __user tag to iio_buffer_detach_dmabuf() argument

Merge window is coming to an end, and whilst we obviously have
plenty of time left in this cycle, I would like to get this queued
up fairly early so any issues can shake out and the various series
that will build on this can progress.

Hopefully Paul has addressed all remaining comments.
So I'm looking for RB or Ack for DMABUF and dmaengine parts from
respective reviewers/maintainers.

Thanks

Jonathan

> 
> Cheers,
> -Paul
> 
> Paul Cercueil (6):
>   dmaengine: Add API function dmaengine_prep_peripheral_dma_vec()
>   dmaengine: dma-axi-dmac: Implement device_prep_peripheral_dma_vec
>   iio: core: Add new DMABUF interface infrastructure
>   iio: buffer-dma: Enable support for DMABUFs
>   iio: buffer-dmaengine: Support new DMABUF based userspace API
>   Documentation: iio: Document high-speed DMABUF based API
> 
>  Documentation/iio/iio_dmabuf_api.rst          |  54 ++
>  Documentation/iio/index.rst                   |   1 +
>  drivers/dma/dma-axi-dmac.c                    |  40 ++
>  drivers/iio/Kconfig                           |   1 +
>  drivers/iio/buffer/industrialio-buffer-dma.c  | 181 ++++++-
>  .../buffer/industrialio-buffer-dmaengine.c    |  59 ++-
>  drivers/iio/industrialio-buffer.c             | 462 ++++++++++++++++++
>  include/linux/dmaengine.h                     |  27 +
>  include/linux/iio/buffer-dma.h                |  31 ++
>  include/linux/iio/buffer_impl.h               |  30 ++
>  include/uapi/linux/iio/buffer.h               |  22 +
>  11 files changed, 891 insertions(+), 17 deletions(-)
>  create mode 100644 Documentation/iio/iio_dmabuf_api.rst
> 


