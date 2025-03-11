Return-Path: <dmaengine+bounces-4702-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F35E3A5CA15
	for <lists+dmaengine@lfdr.de>; Tue, 11 Mar 2025 17:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 850D4188A8A3
	for <lists+dmaengine@lfdr.de>; Tue, 11 Mar 2025 16:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD15825FA3D;
	Tue, 11 Mar 2025 16:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uUpknmff"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8194C25F79C;
	Tue, 11 Mar 2025 16:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741708801; cv=none; b=l6+K8XX5ztqu+JPa+5HqM+3DiexqTFaJGo6syj+L/N40qzZqvTAZ97APA3zPZ1bxRfjSxewurlNPq/41Y7epd3Ln9in4aoi8oqD2zpggAv0krS8xhrDwT4gOx3A2MkVtiFymWfUgZ3Qw+yEWgdcyT5ybD0Ac0EFVDGsmyVjbLgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741708801; c=relaxed/simple;
	bh=frAwT789BAh4F89Qv4uDoVqmywdm58BDlCsir8WtQmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZc5yb4qck7NIF/QPI+f1TP4TYzmactsYD+lWJVUxHOXdxSNpaXCWlOTHCGj7XjxcKUkj+G3PDKXlbjlYZ6AQBe7JBzF++SsJbUi1zIYh9rKbpml4oADqt+5qImP6jImwoaBrbIluWzHl3HSffJMQOmFgQKTdd99BoojVzNO8Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uUpknmff; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D39B7C4CEE9;
	Tue, 11 Mar 2025 15:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741708800;
	bh=frAwT789BAh4F89Qv4uDoVqmywdm58BDlCsir8WtQmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uUpknmffSTA6HHE+IafTOGZOOGVoB+jEDYMG0FuJYdMnNsfHRJu26BrQYwbY1k4zd
	 VKL35+v1HICOjsfNov8pO2+cYat9912p8htjSX+3GMLdxnPdiWZvK3Alnapfyn4T9v
	 3nP6aqWJvyplYWgTgw/9jqXL52VGrEIfxp5RsV3TzwvlM4ypshmqr9QBQv0l5sZk4X
	 xhvSKndUayuYpc1EVBxlldxmAFq8YfLiSRYQ6WasQYbBtWt6/t6bhFJG4j9KqRsd7+
	 ZQISQ/gxL7BFzAnnNdHfayVrshDGBctsKyclFm0jy2iwRpvcYmERzrVU5k8cre6UwP
	 K1ZQCjo/9dTMQ==
Date: Tue, 11 Mar 2025 17:59:55 +0200
From: Dmitry Baryshkov <lumag@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Thara Gopinath <thara.gopinath@gmail.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Md Sadre Alam <quic_mdalam@quicinc.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-doc@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v7 1/8] dmaengine: add DMA_PREP_LOCK and DMA_PREP_UNLOCK
 flag
Message-ID: <ozcg3m3iwdprt4hnti473e4j6ixnwgggbdvsnxold32bigcv7i@koo3ww3wfw22>
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

On Tue, Mar 11, 2025 at 10:25:32AM +0100, Bartosz Golaszewski wrote:
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

You are describing behaviour (and even versions) of a particular DMA
hardware (BAM) in the commit message for a generic flag. Please drop all
of that. Generic code should be described in generic terms.

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
> 
> -- 
> 2.45.2
> 

-- 
With best wishes
Dmitry

