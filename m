Return-Path: <dmaengine+bounces-4679-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAE7A5A509
	for <lists+dmaengine@lfdr.de>; Mon, 10 Mar 2025 21:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78C893ACE62
	for <lists+dmaengine@lfdr.de>; Mon, 10 Mar 2025 20:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A0D1DE8A2;
	Mon, 10 Mar 2025 20:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVqzcS0W"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACC61DA0E1;
	Mon, 10 Mar 2025 20:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741638965; cv=none; b=IzS4sA3pT9iuFGpMykjDe2Ygz60La3/JtwG9s6RotMQ7k2QJ8/9hz9GuSmUIvL4Off063gnREulpbtm2x/5v6qIyKiOZubzYxvc7Cfxa7UYxrX0kNbpzYQ/FqW540Q8nCfc1tMd8CF83wWG1tDuprtxendK9Bq9QEVCeCCVvjVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741638965; c=relaxed/simple;
	bh=n/6h0Z82jvZ83HRGml+cdiqJusnQKh12WlsST6HByD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZHzicUZo7AaXqc9+nF6kd2HtNwNtrT08hu4GdEVyXFl4yWecyb8q9dJIURwbioxD4cKX5gtvZDIXhSyMHvwdShvax4ObxZvtwfaLmYVz3giQikfg0zT0KiFU0iePlS4k4/A9WcSk1fPuGVx60VXrb7uB3vM8H9pqMHe6Dy3qgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVqzcS0W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1AF6C4CEE5;
	Mon, 10 Mar 2025 20:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741638964;
	bh=n/6h0Z82jvZ83HRGml+cdiqJusnQKh12WlsST6HByD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cVqzcS0WzE689ZzKxkIMjMvAzkH1RcrRhNDakHt5i30SnK2JErbbLGES+UAptU7i7
	 /ZdNYwSQxST8A82WoQDcPWIfGO6QvGyAso6ss1XnCWioKcvJK8omSQTiFUIUM7IB+J
	 hwIUIVkf7MVKiM04QDUUVhXtewQaQBTtJvTt2LLQuNEmJ6b4ZyACe3DNX9XM4lqxye
	 u5umQq5F8FO+uOHXHXSPy8qZwCz3CqJPBp6iZYoMkpaEJUaUnnTGMrvGWYYBXu8hog
	 Ne6ix9Ej3rCJaTdVuCfPIxYZtHsfXrJ73a1UXg7l3D6oC/fdPYb/A5o0baKzqlAJaa
	 sFZ5klgwfJOKg==
Date: Tue, 11 Mar 2025 02:06:00 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: corbet@lwn.net, thara.gopinath@gmail.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, martin.petersen@oracle.com,
	enghua.yu@intel.com, u.kleine-koenig@baylibre.com,
	dmaengine@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, quic_utiwari@quicinc.com,
	quic_srichara@quicinc.com, quic_varada@quicinc.com
Subject: Re: [PATCH v6 02/12] dmaengine: add DMA_PREP_LOCK and
 DMA_PREP_UNLOCK flag
Message-ID: <Z89NMPF9TGmz9Js/@vaman>
References: <20250115103004.3350561-1-quic_mdalam@quicinc.com>
 <20250115103004.3350561-3-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115103004.3350561-3-quic_mdalam@quicinc.com>

On 15-01-25, 15:59, Md Sadre Alam wrote:
> Add lock and unlock flag support on command descriptor.
> Once lock set in requester pipe, then the bam controller
> will lock all others pipe and process the request only
> from requester pipe. Unlocking only can be performed from
> the same pipe.
> 
> If DMA_PREP_LOCK flag passed in command descriptor then requester
> of this transaction wanted to lock the BAM controller for this
> transaction so BAM driver should set LOCK bit for the HW descriptor.
> 
> If DMA_PREP_UNLOCK flag passed in command descriptor then requester
> of this transaction wanted to unlock the BAM controller.so BAM driver
> should set UNLOCK bit for the HW descriptor.
> 
> BAM IP version 1.4.0 and above only supports this LOCK/UNLOCK
> feature.

Have you aligned internally b/w team at Qualcomm to have this as single
approach for LOCK implementation. I would like to see ack from
Mukesh/Bjorn before proceeding ahead with this

> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---
> 
> Change in [v6]
> 
> * Change "BAM" to "DAM"
> 
> Change in [v5]
> 
> * Added DMA_PREP_LOCK and DMA_PREP_UNLOCK flag support
> 
> Change in [v4]
> 
> * This patch was not included in v4
> 
> Change in [v3]
> 
> * This patch was not included in v3
> 
> Change in [v2]
> 
> * This patch was not included in v2
>  
> Change in [v1]
> 
> * This patch was not included in v1
> 
>  Documentation/driver-api/dmaengine/provider.rst | 15 +++++++++++++++
>  include/linux/dmaengine.h                       |  6 ++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/Documentation/driver-api/dmaengine/provider.rst b/Documentation/driver-api/dmaengine/provider.rst
> index 3085f8b460fa..a032e55d0a4f 100644
> --- a/Documentation/driver-api/dmaengine/provider.rst
> +++ b/Documentation/driver-api/dmaengine/provider.rst
> @@ -628,6 +628,21 @@ DMA_CTRL_REUSE
>    - This flag is only supported if the channel reports the DMA_LOAD_EOT
>      capability.
>  
> +- DMA_PREP_LOCK
> +
> +  - If set, the DMA will lock all other pipes not related to the current
> +    pipe group, and keep handling the current pipe only.
> +
> +  - All pipes not within this group will be locked by this pipe upon lock
> +    event.
> +
> +  - only pipes which are in the same group and relate to the same Environment
> +    Execution(EE) will not be locked by a certain pipe.
> +
> +- DMA_PREP_UNLOCK
> +
> +  - If set, DMA will release all locked pipes
> +
>  General Design Notes
>  ====================
>  
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 346251bf1026..8ebd43a998a7 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -200,6 +200,10 @@ struct dma_vec {
>   *  transaction is marked with DMA_PREP_REPEAT will cause the new transaction
>   *  to never be processed and stay in the issued queue forever. The flag is
>   *  ignored if the previous transaction is not a repeated transaction.
> + *  @DMA_PREP_LOCK: tell the driver that there is a lock bit set on command
> + *  descriptor.
> + *  @DMA_PREP_UNLOCK: tell the driver that there is a un-lock bit set on command
> + *  descriptor.
>   */
>  enum dma_ctrl_flags {
>  	DMA_PREP_INTERRUPT = (1 << 0),
> @@ -212,6 +216,8 @@ enum dma_ctrl_flags {
>  	DMA_PREP_CMD = (1 << 7),
>  	DMA_PREP_REPEAT = (1 << 8),
>  	DMA_PREP_LOAD_EOT = (1 << 9),
> +	DMA_PREP_LOCK = (1 << 10),
> +	DMA_PREP_UNLOCK = (1 << 11),
>  };
>  
>  /**
> -- 
> 2.34.1

-- 
~Vinod

