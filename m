Return-Path: <dmaengine+bounces-2878-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EA4954EFE
	for <lists+dmaengine@lfdr.de>; Fri, 16 Aug 2024 18:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DD34B21ECB
	for <lists+dmaengine@lfdr.de>; Fri, 16 Aug 2024 16:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022B91BCA1C;
	Fri, 16 Aug 2024 16:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwiPTZ2V"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9C76F2F0;
	Fri, 16 Aug 2024 16:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723826306; cv=none; b=IAW3AgoY2SBDdYk3UY9wfyxpItg7B0rXRwdU9WxWIS9+YQTferK60MM+kG9Zy6Vo61xeWO+ODwbBh/sde0BotxAa91UNgpGHa2AyYHx+OsHSdmJlJiZI127p12YDc2kSY2TdjJEvj95VLFDCvl8xfzaaRiSXo5YljfoGjr6Gj54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723826306; c=relaxed/simple;
	bh=yN7uSPMNWaqA5XsiTCjzR7XxYl6sedkSD2fLgGmfhkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAYf5hXQuvTnxWLHtIVz3KmQHGX1FsZXkGmCUPpfjsrWA1a+0Dl33TSKCoyZWOYvTZyMDsklElF2q+MK9P4OaW7CKzoirTgc10oq6Sh4WPH1EUBKujK7fVtaOn3JoE72R+vmpuEIqvlBwynqPGAaP9z8xZqoZZyqGYiekCEkw4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwiPTZ2V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB2DAC32782;
	Fri, 16 Aug 2024 16:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723826306;
	bh=yN7uSPMNWaqA5XsiTCjzR7XxYl6sedkSD2fLgGmfhkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mwiPTZ2VFkUHm50EbfKLXSN8r5etmTBCgdQSCf3Q+z6aYaDTbCijy0WNCuRAXtsOl
	 CzaFIMZeFQ7TNkDH5wsf+ARFZdyAK1K3XVjCEF1+aH8nfUelje0ef44FliRoGEW7eK
	 4F9nEAEAYgHozV1WWpt67xu77GzEa8Hu0ORImKDKIOTwNvazobCCBJJwAPtdqoXfGb
	 zIxkVf3sI0ZrwDfoXb+r4IaIvKGgKVxgXfcuUXq5oUA/cffJKAmpmchobqlbOGAlFa
	 t7pI3MnLOtgqKcHBJ4YEWKimkhrrFyL2dxxmvlvbnfoydAsUqf4Tb7IRy5al/iIcq+
	 Yf79xJq8FdIRg==
Date: Fri, 16 Aug 2024 11:38:22 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: vkoul@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, konradybcio@kernel.org, thara.gopinath@gmail.com, 
	herbert@gondor.apana.org.au, davem@davemloft.net, gustavoars@kernel.org, 
	u.kleine-koenig@pengutronix.de, kees@kernel.org, agross@kernel.org, 
	linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, quic_srichara@quicinc.com, 
	quic_varada@quicinc.com, quic_utiwari@quicinc.com
Subject: Re: [PATCH v2 10/16] crypto: qce - Add support for lock aquire,lock
 release api.
Message-ID: <n625hyjcbiidnlskzlubrmrflguwyurq5rp4l2hsnqf2g2wzik@ftz4wvvifft5>
References: <20240815085725.2740390-1-quic_mdalam@quicinc.com>
 <20240815085725.2740390-11-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815085725.2740390-11-quic_mdalam@quicinc.com>

On Thu, Aug 15, 2024 at 02:27:19PM GMT, Md Sadre Alam wrote:
> Add support for lock acquire and lock release api.
> When multiple EE's(Execution Environment) want to access
> CE5 then there will be race condition b/w multiple EE's.
> 
> Since each EE's having their dedicated BAM pipe, BAM allows
> Locking and Unlocking on BAM pipe. So if one EE's requesting
> for CE5 access then that EE's first has to LOCK the BAM pipe
> while setting LOCK bit on command descriptor and then access
> it. After finishing the request EE's has to UNLOCK the BAM pipe
> so in this way we race condition will not happen.

Does the lock/unlock need to happen on a dummy access before and after
the actual sequence? Is it not sufficient to lock/unlock on the first
and last operation?

Please squash this with the previous commit, if kept as explicit
operations, please squash it with the previous patch that introduces the
flags.

> 
> Added these two API qce_bam_acquire_lock() and qce_bam_release_lock()
> for the same.
> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---
> 
> Change in [v2]
> 
> * No chnage
> 
> Change in [v1]
> 
> * Added initial support for lock_acquire and lock_release
>   api.
> 
>  drivers/crypto/qce/common.c | 36 ++++++++++++++++++++++++++++++++++++
>  drivers/crypto/qce/core.h   |  2 ++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/drivers/crypto/qce/common.c b/drivers/crypto/qce/common.c
> index ff96f6ba1fc5..a8eaffe41101 100644
> --- a/drivers/crypto/qce/common.c
> +++ b/drivers/crypto/qce/common.c
> @@ -617,3 +617,39 @@ void qce_get_version(struct qce_device *qce, u32 *major, u32 *minor, u32 *step)
>  	*minor = (val & CORE_MINOR_REV_MASK) >> CORE_MINOR_REV_SHIFT;
>  	*step = (val & CORE_STEP_REV_MASK) >> CORE_STEP_REV_SHIFT;
>  }
> +
> +int qce_bam_acquire_lock(struct qce_device *qce)
> +{
> +	int ret;
> +
> +	qce_clear_bam_transaction(qce);

It's not entirely obvious that a "lock" operation will invalidate any
pending operations.

> +
> +	/* This is just a dummy write to acquire lock on bam pipe */
> +	qce_write_reg_dma(qce, REG_AUTH_SEG_CFG, 0, 1);
> +
> +	ret = qce_submit_cmd_desc(qce, QCE_DMA_DESC_FLAG_LOCK);
> +	if (ret) {
> +		dev_err(qce->dev, "Error in Locking cmd descriptor\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +int qce_bam_release_lock(struct qce_device *qce)

What would be a reasonable response from the caller if this release
operation returns a failure? How do you expect it to recover?

> +{
> +	int ret;
> +
> +	qce_clear_bam_transaction(qce);
> +

In particularly not on "unlock".

Regards,
Bjorn

> +	/* This just dummy write to release lock on bam pipe*/
> +	qce_write_reg_dma(qce, REG_AUTH_SEG_CFG, 0, 1);
> +
> +	ret = qce_submit_cmd_desc(qce, QCE_DMA_DESC_FLAG_UNLOCK);
> +	if (ret) {
> +		dev_err(qce->dev, "Error in Un-Locking cmd descriptor\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> diff --git a/drivers/crypto/qce/core.h b/drivers/crypto/qce/core.h
> index bf28dedd1509..d01d810b60ad 100644
> --- a/drivers/crypto/qce/core.h
> +++ b/drivers/crypto/qce/core.h
> @@ -68,4 +68,6 @@ int qce_read_reg_dma(struct qce_device *qce, unsigned int offset, void *buff,
>  void qce_clear_bam_transaction(struct qce_device *qce);
>  int qce_submit_cmd_desc(struct qce_device *qce, unsigned long flags);
>  struct qce_bam_transaction *qce_alloc_bam_txn(struct qce_dma_data *dma);
> +int qce_bam_acquire_lock(struct qce_device *qce);
> +int qce_bam_release_lock(struct qce_device *qce);
>  #endif /* _CORE_H_ */
> -- 
> 2.34.1
> 

