Return-Path: <dmaengine+bounces-7666-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 827FDCC33B4
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 14:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 08D7830345AF
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 13:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4A533BBC8;
	Tue, 16 Dec 2025 13:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/mH6mX0"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E977E339874;
	Tue, 16 Dec 2025 13:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765890012; cv=none; b=RU8awzhCciVLPEsSsOmxry3hq40wD438XqONaSWJZjrIi2wVNevjH9Er5t49zfuEBvBYQjliTEfqqsKI16A9h2Xslf9Io1KQEaRYmeTcDD7trWtSlyVkKtvBSVInI3r+5d4w49tJ5aAiF+Ralv+KOpvH+5/sSTtb04kPEYiseK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765890012; c=relaxed/simple;
	bh=mQBluV4vo6oktVQMR47MWjsZkZHvF2VHMeD3tqW78+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixXeHfbuFKK+5n3BrvNZYDNvh99QjjE76B/RRgAAoM9hPDwWMiqJ3m13jDQoBKnm5v9u8J6kNOkAIIbJaydCwVgoAa+H/zf4k1hjATfxEETS6+4aQ2r8/mlxyZpi6PweM+AQjzvA9mnQtMvgcaT1pG7insxGj+wbi98bmsfjxlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/mH6mX0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E575C4CEF1;
	Tue, 16 Dec 2025 13:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765890011;
	bh=mQBluV4vo6oktVQMR47MWjsZkZHvF2VHMeD3tqW78+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d/mH6mX0eV2p9m7sYxhd3qcf37tLj1VmfJt7vEv1GsrZWMEkcY1dHcUW73Z60Nzds
	 cWCIqM4gY0hwzYxK5rT52lPxMBFfIv9esPpLkPVpFRQp6t56HAnArMzaOtuxGZzxft
	 OsMqKHkYP1TwMTdsFqEHM3Usjhg475XALpCMK/pUFaGAW20gLipDJqU0UCzratyv7N
	 mBXvX6HS9s+6xpRIeGW/mgZOqB8vCGfvvkH1Rdt1jDmBVC0kV02cbZ6vClscrWkzc9
	 sFBlYPqiOSqMahw2Yz3H2ISEjmR68Q0yTx2t02J/BlYQldHlj5cMMqYA/kx1J52gk7
	 BUSGWdUOsjmRQ==
Date: Tue, 16 Dec 2025 18:30:07 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Udit Tiwari <quic_utiwari@quicinc.com>,
	Daniel Perez-Zoghbi <dperezzo@quicinc.com>,
	Md Sadre Alam <mdalam@qti.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>, dmaengine@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v9 03/11] dmaengine: qcom: bam_dma: implement support for
 BAM locking
Message-ID: <aUFX14nz8cQj8EIb@vaman>
References: <20251128-qcom-qce-cmd-descr-v9-0-9a5f72b89722@linaro.org>
 <20251128-qcom-qce-cmd-descr-v9-3-9a5f72b89722@linaro.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128-qcom-qce-cmd-descr-v9-3-9a5f72b89722@linaro.org>

On 28-11-25, 12:44, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Use metadata operations in DMA descriptors to allow BAM users to pass
> additional information to the engine. To that end: define a new
> structure - struct bam_desc_metadata - as a medium and define two new
> commands: for locking and unlocking the BAM respectively. Handle the
> locking in the .attach() callback.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/dma/qcom/bam_dma.c       | 59 +++++++++++++++++++++++++++++++++++++++-
>  include/linux/dma/qcom_bam_dma.h | 12 ++++++++
>  2 files changed, 70 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index c9ae1fffe44d79c5eb59b8bbf7f147a8fa3aa0bd..d1dc80b29818897b333cd223ec7306a169cc51fd 100644
> --- a/drivers/dma/qcom/bam_dma.c
> +++ b/drivers/dma/qcom/bam_dma.c
> @@ -30,6 +30,7 @@
>  #include <linux/module.h>
>  #include <linux/interrupt.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/dma/qcom_bam_dma.h>
>  #include <linux/scatterlist.h>
>  #include <linux/device.h>
>  #include <linux/platform_device.h>
> @@ -391,6 +392,8 @@ struct bam_chan {
>  	struct list_head desc_list;
>  
>  	struct list_head node;
> +
> +	bool bam_locked;
>  };
>  
>  static inline struct bam_chan *to_bam_chan(struct dma_chan *common)
> @@ -655,6 +658,53 @@ static int bam_slave_config(struct dma_chan *chan,
>  	return 0;
>  }
>  
> +static int bam_metadata_attach(struct dma_async_tx_descriptor *desc, void *data, size_t len)
> +{
> +	struct virt_dma_desc *vd = container_of(desc, struct virt_dma_desc, tx);
> +	struct bam_async_desc *async_desc = container_of(vd, struct bam_async_desc,  vd);
> +	struct bam_desc_hw *hw_desc = async_desc->desc;
> +	struct bam_desc_metadata *metadata = data;
> +	struct bam_chan *bchan = to_bam_chan(metadata->chan);
> +	struct bam_device *bdev = bchan->bdev;
> +
> +	if (!data)
> +		return -EINVAL;
> +
> +	if (metadata->op == BAM_META_CMD_LOCK || metadata->op == BAM_META_CMD_UNLOCK) {
> +		if (!bdev->dev_data->bam_pipe_lock)
> +			return -EOPNOTSUPP;
> +
> +		/* Expecting a dummy write when locking, only one descriptor allowed. */
> +		if (async_desc->num_desc != 1)
> +			return -EINVAL;
> +	}
> +
> +	switch (metadata->op) {
> +	case BAM_META_CMD_LOCK:
> +		if (bchan->bam_locked)
> +			return -EBUSY;
> +
> +		hw_desc->flags |= DESC_FLAG_LOCK;

Why does this flag imply for the hardware.

I do not like the interface designed here. This is overloading. Can we
look at doing something better here.

-- 
~Vinod

