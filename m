Return-Path: <dmaengine+bounces-4059-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB95D9FBC80
	for <lists+dmaengine@lfdr.de>; Tue, 24 Dec 2024 11:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E8F518802F0
	for <lists+dmaengine@lfdr.de>; Tue, 24 Dec 2024 10:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554AC1ABEDC;
	Tue, 24 Dec 2024 10:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cjfsr1/+"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A37F156F54;
	Tue, 24 Dec 2024 10:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735036461; cv=none; b=lSNNiTQY+TAhcQXOJPhkZaLpf5tCDqPekLzoctV0wfW6qf6jD9avk6YuI+rez9B8Q21Itr4T8ayY8HXEYDnacnb1oZRIL2pM2WwD7zfFmVWf1OUXI72kEQkTlRa1SdQ1LJAwsqvKGlwa7ZQiN2J4M1mVcGoJWkRsmAwkoucsa0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735036461; c=relaxed/simple;
	bh=9dq5b3qgPFI9QCYffJk5mFBak/vrXyL/4DK0D+Zwpvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jvR5QqlCF54gW9McpxIJ8PUCucMdB8CWz+x2VmW11efR1z4NZQJCqvAA8wOB8RUvMvr/w7AfIOhbd9Gt6blRbG12wuaWo560on4Q6Gwf+4zsg9+vW/O/fcecb21dBaS7XwRxNCCeztZomsRT7idlMbQTclBZ6I9WCOFyJHmGziQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cjfsr1/+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E39D7C4CED0;
	Tue, 24 Dec 2024 10:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735036460;
	bh=9dq5b3qgPFI9QCYffJk5mFBak/vrXyL/4DK0D+Zwpvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cjfsr1/+qefECx0GzNATBEdM2XLoXfvhQkpjnZcfe3oYXDX19lRqw/nUFBAIWMumL
	 kYJEk3stFIpRITaJNYUd29whZ7zpJjj0ISfRZhJjE7lY/tSIVZ6o+7sKYgROuVj+22
	 yo6CoeVe9R1pXqWuyXtAakvsNiViLS+o+uBQMxzaUtKz2yoF7w58rsqezV8fwP3iXX
	 vLdDDRles65vGP2aERbegVD6gGbz6j7vTpX8SGTy+QgmH0kOodnX1dQQcVvPf3Bkq7
	 D9N+6itNsDhFs3+2iWIx7n+8YN7BqnnP2/ztUUbjv90ukZs5b3cHuMKENovRhlyhaX
	 Uu4njgyr5VoPA==
Date: Tue, 24 Dec 2024 16:04:16 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: corbet@lwn.net, thara.gopinath@gmail.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, kees@kernel.org, dave.jiang@intel.com,
	dmaengine@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, quic_srichara@quicinc.com,
	quic_varada@quicinc.com, quic_utiwari@quicinc.com
Subject: Re: [PATCH v5 02/12] dmaengine: add DMA_PREP_LOCK and
 DMA_PREP_UNLOCK flag
Message-ID: <Z2qOKHsYpy8kcwlv@vaman>
References: <20241212041639.4109039-1-quic_mdalam@quicinc.com>
 <20241212041639.4109039-3-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212041639.4109039-3-quic_mdalam@quicinc.com>

On 12-12-24, 09:46, Md Sadre Alam wrote:
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
> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---
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
> index 3085f8b460fa..5f30c20f94f3 100644
> --- a/Documentation/driver-api/dmaengine/provider.rst
> +++ b/Documentation/driver-api/dmaengine/provider.rst
> @@ -628,6 +628,21 @@ DMA_CTRL_REUSE
>    - This flag is only supported if the channel reports the DMA_LOAD_EOT
>      capability.
>  
> +- DMA_PREP_LOCK
> +
> +  - If set, the BAM will lock all other pipes not related to the current

Why BAM, the generic API _cannot_ be implementation specific, make this
as a generic one please

Anyone can use this new method and not just BAM...


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
> +  - If set, BAM will release all locked pipes
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

