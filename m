Return-Path: <dmaengine+bounces-2325-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 777C490156B
	for <lists+dmaengine@lfdr.de>; Sun,  9 Jun 2024 11:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB62AB21530
	for <lists+dmaengine@lfdr.de>; Sun,  9 Jun 2024 09:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1640208AD;
	Sun,  9 Jun 2024 09:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUsxWfKD"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736D3208A0;
	Sun,  9 Jun 2024 09:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717927176; cv=none; b=PhLVmcK+kaKBU0pKiaMG93KDeppXjFN8uFMPXsihp/HzC1BaJOmSfm2wdlaz5nDHypJRtaZZqLpyFK5Vyj+TnFcpQexybOiBvawINlKMo0HyULnx9brDenvFVFpNewzWovatLFB/FeL0CBcGde4fQ/y949JSmCB6Jc1MU21ccNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717927176; c=relaxed/simple;
	bh=ZTNgbFcLomcG6cpe2haGjWOTw7BlkgzB0g3ZWexUBPg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mILcsd0NxCtDQYcdOf/tJCIyt4ewt4FqB/lxgbJ+en24sZ2PTmTpfaNZp93Cz0ZF1/em4Ky4nObXGIjo/kDpWnaxh53g/7TjGswm3hV7IRrf5LCNvymaVaEsa9sIkQMnhig0YQ4GWvOtjsrlEf/061OnOgSpFYNuD3ByGThA3Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUsxWfKD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8389C2BD10;
	Sun,  9 Jun 2024 09:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717927176;
	bh=ZTNgbFcLomcG6cpe2haGjWOTw7BlkgzB0g3ZWexUBPg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SUsxWfKDwq9uaDBZLEK9BO1+qDdiuCsJlTzwxXZUZzuY1WK9NlYBeiOT7909A+4bQ
	 0QzRcgCBUPMCOGlp26CgYVY5HcN1KUJTpY6oRcoqr2Ti9I8GXv1fvbSEtYDmvIStvA
	 u9QV3W4AGxsPvXV8LqptOQEFbzp79cNu/ZaR/3GjPKvoO0cK+0rnU8WyJJCFT02eS+
	 rSKMLjfSd2BKtI1VE221Kg0oaFofgCQNznOvbHzgJjoRr3a5PLrG9uqGYy/zC9Rf4R
	 X6Ch6wAd8uOaXMOt4YgPs9Xz3snZhuu0undsBf8oDtnyz7llZGasXvqnFZjPvbZJri
	 xtcFMxxSpbOSg==
Date: Sun, 9 Jun 2024 10:58:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Paul Cercueil <paul@crapouillou.net>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Jonathan Corbet <corbet@lwn.net>, Nuno Sa
 <nuno.sa@analog.com>, linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v10 0/6] iio: new DMABUF based API v10
Message-ID: <20240609105853.54d01475@jic23-huawei>
In-Reply-To: <20240605110845.86740-1-paul@crapouillou.net>
References: <20240605110845.86740-1-paul@crapouillou.net>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Jun 2024 13:08:39 +0200
Paul Cercueil <paul@crapouillou.net> wrote:

> Hi Jonathan,
> 
> Here is a revised (and hopefully final?) version of my DMABUF patchset.

Fingers crossed it's just docs changes for v11.

So on to the details of how to merge this...
For the DMAEngine maintainers:
Given IIO changes dominate this series it makes sense for me to pick it up
through IIO.

Do you want an immutable branch with the first patch on it, or is this
unlikely to cause merge conflicts with any other ongoing work in dmabuffer
land?

I'm fine either way and if I don't hear back on this will do an immutable
branch and announce it when I apply v11 (I hope!)

Jonathan

> 
> This v10 removes the extra "flags" parameter of
> dmaengine_prep_peripheral_dma_vec(), and adds kernel doc to the function
> as Vinod requested.
> 
> As Nuno upstreamed support for output buffers, I (slightly) modified
> patch 5/6 and now output buffers are supported with the DMABUF API.
> All I did was remove a "fail if output" check really.
> 
> This was based on next-20240605.
> 
> Changelog:
> - [1/6]:
>   - Add kernel doc to dmaengine_prep_peripheral_dma_vec()
>   - Remove extra flags parameter
> - [2/6]:
>   - Use the new function prototype (without the extra prep_flags).
> - [5/6]:
>   - Remove extra flags parameter to dmaengine_prep_peripheral_dma_vec()
>   - Add support for TX transfers
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
>  drivers/iio/buffer/industrialio-buffer-dma.c  | 180 ++++++-
>  .../buffer/industrialio-buffer-dmaengine.c    |  62 ++-
>  drivers/iio/industrialio-buffer.c             | 462 ++++++++++++++++++
>  include/linux/dmaengine.h                     |  33 ++
>  include/linux/iio/buffer-dma.h                |  31 ++
>  include/linux/iio/buffer_impl.h               |  30 ++
>  include/uapi/linux/iio/buffer.h               |  22 +
>  11 files changed, 896 insertions(+), 20 deletions(-)
>  create mode 100644 Documentation/iio/iio_dmabuf_api.rst
> 


