Return-Path: <dmaengine+bounces-4792-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E70A75ADF
	for <lists+dmaengine@lfdr.de>; Sun, 30 Mar 2025 18:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A157E3A9672
	for <lists+dmaengine@lfdr.de>; Sun, 30 Mar 2025 16:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3542E1D5174;
	Sun, 30 Mar 2025 16:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKoBOjTS"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29421AF0B4;
	Sun, 30 Mar 2025 16:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743351656; cv=none; b=KqxfdARv7L/Q9vFsOlAzN/cdMBb+sJnSDBCzTuSJkt3PP6u9ca258PI9hUbtOhPYJacIvOuCwD5r8Qj8BWRureNu8hSsPFq1vHqrDJnD1BhHvpLtDkKZlSvJYisR64kKHG2ENpBYRgCI3NWNkX050IxypabpYY3sTMavTXiqDSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743351656; c=relaxed/simple;
	bh=nJ4BsCB5loZ/jaKzK1GG9ETMqwHE6FkYOJGC0QZJWTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5lkJhWjbkXGRxjaNndSTB/nXiflBjvj7Rjnuf9cdpqOmGTQzzTfx+nHEC0cNXmSlZVKJAgiNE/nKAOOtrBGMXyCpNLiNBF4qyt8mkcnxFYXYSiGsufwXKzDJL2eE5fXQ9kwdvFKLbZKKh9NBLwVz70sgGOuOgBEw9AeNDQkuSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKoBOjTS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82EA9C4CEDD;
	Sun, 30 Mar 2025 16:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743351655;
	bh=nJ4BsCB5loZ/jaKzK1GG9ETMqwHE6FkYOJGC0QZJWTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZKoBOjTS/SdkIlRXx+NsTBg9T3T3qP2qktPlamnRKqA1WHeACxR7iGCfEGIT+ujeN
	 msVHaAmXaZd5254jazcOeaeNY0y8zVLY3M2tc5xd6G27Cp5ijB7Mfq9O2moHYIdGpA
	 6i4sVZPdJNkh+WoT+sgNAFGd14+OuiMwpDLXdW0ghx6ZtUdQU+9Lby+eWJnXZ7yXnh
	 22YW9475ysIUqawV2tPAGnl0Gr5LTws9IWNd0E1dfVDKXt3Rz5hgsHc+RNJsbKALP/
	 AFAlDTT3hfgCVsmguSR3nIDYs9mhpTvjMuzpeeaPB0wWG9SdtHQZetBlIVMdx5ZMjA
	 Oz0jLOIvM93UA==
Date: Sun, 30 Mar 2025 21:50:49 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Thara Gopinath <thara.gopinath@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Md Sadre Alam <quic_mdalam@quicinc.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v7 1/8] dmaengine: add DMA_PREP_LOCK and DMA_PREP_UNLOCK
 flag
Message-ID: <Z+lvYUeAElcW5uNl@vaman>
References: <20250311-qce-cmd-descr-v7-0-db613f5d9c9f@linaro.org>
 <20250311-qce-cmd-descr-v7-1-db613f5d9c9f@linaro.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311-qce-cmd-descr-v7-1-db613f5d9c9f@linaro.org>

On 11-03-25, 10:25, Bartosz Golaszewski wrote:
> From: Md Sadre Alam <quic_mdalam@quicinc.com>
> 
> Add lock and unlock flags for the command descriptor. With the former set
> in the requester pipe, the bam controller will lock all other pipes and
> process the request only from requester pipe. Unlocking can only be
> performed from the same pipe.
> 
> Setting the DMA_PREP_LOCK/DMA_PREP_UNLOCK flags in the command
> descriptor means, the caller requests the BAM controller to be locked
> for the duration of the transaction. In this case the BAM driver must
> set the LOCK/UNLOCK bits in the HW descriptor respectively.
> 
> Only BAM IPs version 1.4.0 and above support the LOCK/UNLOCK feature.
> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> [Bartosz: reworked the commit message]
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
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

This does not make sense for me in generic context... Pipes and EEs are
implementation details... Please generalise the description for a
dma controller...

-- 
~Vinod

