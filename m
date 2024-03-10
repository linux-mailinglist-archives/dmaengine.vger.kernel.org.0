Return-Path: <dmaengine+bounces-1327-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF57F87769D
	for <lists+dmaengine@lfdr.de>; Sun, 10 Mar 2024 13:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FEC7B21100
	for <lists+dmaengine@lfdr.de>; Sun, 10 Mar 2024 12:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E11322323;
	Sun, 10 Mar 2024 12:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hn884P6N"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117A916FF29;
	Sun, 10 Mar 2024 12:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710074511; cv=none; b=uY4JQMkEoNA4HJ9euNwZqTVC/rxYSqcM4XVZYybbp9CGjrTZ84/eWQgmmqJBkSnApyCht3OVtTVgMazQ81wfWtFy6eHXBcygKQ4gz6AguU4cpnjETVPOHJYG5uN3GCUhHRpX9en2/y5sVa6CocARCD4XGeWcCLdUuZz13r8BhfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710074511; c=relaxed/simple;
	bh=T2hnsj3TXxdQauhbrydhvVMlAp4FlGMF27ltKRC1xko=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DsbXEZ/R/HR1oXl2fEJxTmwr1FlinW7og1MUWy47uGdAj6Z5T6o95WDatU8UZcRboBf/URWDaBmHbVbsjM/Vn3LL/CG26kv7zypCirzWC/E5ZEwSJ02iHzm4W0XdPtf/Can9TUOpvbcs+SOkeW9/E2hMqi12nUCv9e4x6DxGjW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hn884P6N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD6CC433F1;
	Sun, 10 Mar 2024 12:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710074510;
	bh=T2hnsj3TXxdQauhbrydhvVMlAp4FlGMF27ltKRC1xko=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hn884P6NYCntbYCwhViso8xYitvz/SDSeAYZDfK/+/NNFWBfgkkuxX3gzjYVAT4X2
	 75YA8TLBgLTHDzXhVe9CfMjGsat0po8S88pq9OfxKLhWElwY7q8w398qcNRr7wwN5g
	 L5w8HVcrSrqFvtdBU1pSnG4cz71f0xxJMCuP9M5TjxD/GmmO3G4A3kP2ex7IuhABAK
	 uY76WFjb0LdEG8cy+J2DWRuRgFQhs8QF02ONHzFh4Uhfm5xBQ569mHBp6as4id/fWy
	 eCUPv+d/UamjMG0dqiKxynXZjHK2WenzLrZnNFt0PLWrVd3K/mhz/nx/8KLipkUqLE
	 tljcQNovP1rgw==
Date: Sun, 10 Mar 2024 12:41:33 +0000
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
Subject: Re: [PATCH v8 0/6] iio: new DMABUF based API
Message-ID: <20240310124133.683e8853@jic23-huawei>
In-Reply-To: <20240308170046.92899-1-paul@crapouillou.net>
References: <20240308170046.92899-1-paul@crapouillou.net>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  8 Mar 2024 18:00:40 +0100
Paul Cercueil <paul@crapouillou.net> wrote:

> Hi Jonathan,
> 
> Here's the final(tm) version of the IIO DMABUF patchset.
> 
> This v8 fixes the remaining few issues that Christian reported.
> 
> I also updated the documentation patch as there has been changes to
> index.rst.
> 
> This was based on next-20240308.
> 
> Changelog:
> 
> - [3/6]:
>     - Fix swapped fence direction
>     - Simplify fence wait mechanism
>     - Remove "Buffer closed with active transfers" print, as it was dead
>       code
>     - Un-export iio_buffer_dmabuf_{get,put}. They are not used anywhere
>       else so they can even be static.
>     - Prevent attaching already-attached DMABUFs
> - [6/6]:
>     Renamed dmabuf_api.rst -> iio_dmabuf_api.rst, and updated index.rst
>     whose format changed in iio/togreg.
> 
> Cheers,
> -Paul
Given nature of the build bug issues reported, I'm guessing you never
built this as a module :(  Not sure how one instance of a missing 
user marking got through but also easy to fix.

Anyhow, no need to wait before sending a v9 with those sorted.

0-day does it's job again - even better is that it's whilst it's
still your problem and not mine :)

Jonathan

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
>  drivers/iio/buffer/industrialio-buffer-dma.c  | 181 ++++++-
>  .../buffer/industrialio-buffer-dmaengine.c    |  59 ++-
>  drivers/iio/industrialio-buffer.c             | 462 ++++++++++++++++++
>  include/linux/dmaengine.h                     |  27 +
>  include/linux/iio/buffer-dma.h                |  31 ++
>  include/linux/iio/buffer_impl.h               |  30 ++
>  include/uapi/linux/iio/buffer.h               |  22 +
>  10 files changed, 890 insertions(+), 17 deletions(-)
>  create mode 100644 Documentation/iio/iio_dmabuf_api.rst
> 


