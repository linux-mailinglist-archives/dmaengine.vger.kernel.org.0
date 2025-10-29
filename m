Return-Path: <dmaengine+bounces-7036-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F62DC1BCB2
	for <lists+dmaengine@lfdr.de>; Wed, 29 Oct 2025 16:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44EA5189C17A
	for <lists+dmaengine@lfdr.de>; Wed, 29 Oct 2025 15:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8D8346E5B;
	Wed, 29 Oct 2025 15:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGrpTx9Z"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF773329C52;
	Wed, 29 Oct 2025 15:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761752833; cv=none; b=fUOzU0tpST7a+//SBnkH3vgsaJ2mZ2SVb1sh9nMTGWpmP8Ix1zQwU352yUet1m0IECEA7TFExBxR9ndUiFypEQ8zODd8XJs5HMwXY+T4oPpcYw/UTM+hVjqitQr3o+CQuvNgtJobt9KoD9DrA0oT9ryYBlCARaVZQWfxLuninhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761752833; c=relaxed/simple;
	bh=TllcN7wxrh98n0OZudlhQlxrmiyX3ew9/kx3+6+TzwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KbmWM5ZXkFJdcBxzZVtmVmYSp10AI9sSlGq1Rb6qlG94e/C/QydN7Y/fnOIODUjo+1T0LNZ/8Y/NzwM94yrTSswaQfHo1rK6NebogECXuUHTKPBq//Fbv60PD96g6TcL07KoTXL7o/pODlUJOyy600d1svM0ER3e5qwkyt2xF6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGrpTx9Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF5BC4CEF7;
	Wed, 29 Oct 2025 15:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761752833;
	bh=TllcN7wxrh98n0OZudlhQlxrmiyX3ew9/kx3+6+TzwQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bGrpTx9ZmQ9JIRaFMwHHzJYCsxNpLLwUhI9J1WyR8sbgbcG76HphNOyOOBhEE6E6c
	 rHXlYo2wNXjSc7kcECkKHG2OquabnQJ70d/FI4RQ+eRQSHHSJOS54BF+t+9XxHCG/K
	 OsPJJRYDRV9RqQNl+aXY2J9buiv+E6Vyw0OobIVGN2aj45XE6MfzxvhfRI+XS9DuTI
	 k98Kjo+FK8KvBUB2U4fT7CafMlBEPFGeep6adCnHAv/YRI/sA6iPWC0P5ZtARV9/17
	 owgjolGR/Kf4xDZ6vmpQ5dyCUgfbGc58AgDfyAEOEf+//dueVxWBNOk+Nop/EIrUgD
	 2TsMiXvArKPkg==
Date: Wed, 29 Oct 2025 10:50:16 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Miaoqian Lin <linmq006@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Dmitry Baryshkov <lumag@kernel.org>, 
	linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] dma: qcom: gpi: Fix memory leak in
 gpi_peripheral_config()
Message-ID: <etlnr6lmba5hbgauez5k4a6h7zccasksu5eevik423tny33lt6@cvce5dwxaowq>
References: <20251029123421.91973-1-linmq006@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029123421.91973-1-linmq006@gmail.com>

On Wed, Oct 29, 2025 at 08:34:19PM +0800, Miaoqian Lin wrote:
> Fix a memory leak in gpi_peripheral_config() where the original memory
> pointed to by gchan->config could be lost if krealloc() fails.
> 
> The issue occurs when:
> 1. gchan->config points to previously allocated memory
> 2. krealloc() fails and returns NULL
> 3. The function directly assigns NULL to gchan->config, losing the
>    reference to the original memory
> 4. The original memory becomes unreachable and cannot be freed
> 
> Fix this by using a temporary variable to hold the krealloc() result
> and only updating gchan->config when the allocation succeeds.
> 
> Found via static analysis and code review.
> 
> Fixes: 5d0c3533a19f ("dmaengine: qcom: Add GPI dma driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> ---
>  drivers/dma/qcom/gpi.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
> index 8e87738086b2..8908b7c71900 100644
> --- a/drivers/dma/qcom/gpi.c
> +++ b/drivers/dma/qcom/gpi.c
> @@ -1605,14 +1605,16 @@ static int
>  gpi_peripheral_config(struct dma_chan *chan, struct dma_slave_config *config)
>  {
>  	struct gchan *gchan = to_gchan(chan);
> +	void *new_config;
>  
>  	if (!config->peripheral_config)
>  		return -EINVAL;
>  
> -	gchan->config = krealloc(gchan->config, config->peripheral_size, GFP_NOWAIT);
> -	if (!gchan->config)
> +	new_config = krealloc(gchan->config, config->peripheral_size, GFP_NOWAIT);
> +	if (!new_config)
>  		return -ENOMEM;
>  
> +	gchan->config = new_config;
>  	memcpy(gchan->config, config->peripheral_config, config->peripheral_size);
>  
>  	return 0;
> -- 
> 2.39.5 (Apple Git-154)
> 
> 

