Return-Path: <dmaengine+bounces-7094-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DCEC3E9BC
	for <lists+dmaengine@lfdr.de>; Fri, 07 Nov 2025 07:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 321CA4EA0EB
	for <lists+dmaengine@lfdr.de>; Fri,  7 Nov 2025 06:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A91721D3DC;
	Fri,  7 Nov 2025 06:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T+y+/CwW"
X-Original-To: dmaengine@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93082AD25;
	Fri,  7 Nov 2025 06:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762496404; cv=none; b=k+RHi6t8OvjsIjFYQFSBJZrQPaw/hr9CeAgoMDocOvGRXdCGD9HY3okVvAufrd5QWe4cl4uMrNsUWNQbSISul4WzIZTjIduoxW7bqgvkLHNe2o0/XPUpLPjx64p2dZBqxnAauoCYFzUs5UTFUggxlUC7YHwAXO4A8sGsdXz5qnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762496404; c=relaxed/simple;
	bh=QK4tnVEnx0dnUu1VZrRPH5XHyZSuEa5wnts9WKB07xc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=trYwP7i5cXkFhc5QyLFKXnp3n/af0KkefdUrStdWNd0JrzS5yzcn5EC/NCs3wY4MBzNP+PxW4+Ous9lvpVEOd8JTelPGLUrXSoRCSm70jS7B3UctP+gLlzCPpclmEwwJgt4zt6x8wL/6BmJzgV0Ha/EZN00WzBd8rwff19v6DX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T+y+/CwW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=cx/OeR/TpXmHZozLgJx6VvSjc4tPJLhnHkHJTi2lSbo=; b=T+y+/CwWjmHf+F0zKFUbi4yg0S
	pOqOmPKpfXbvaGTKYWi0KY47yOEBYUKywOJpBvGz7l94PhtsE4inro+ZXGbNDIS/ObLv4iGARtDZT
	PA3XwsvZ3HbMBk55wj8LvauK3bCqjydtgy/En9ZhIs7hU+E0YLPGJ9PCWgKQPJed3/m943DDcYbDR
	cUHUL9H2RmlJ7XruSVjh1iD2dagE8FIf777IVhmZVfiDrQlQnhaItGshJJ3wN/RYxAYKhqXj1ySx1
	ZTT/aQYmqdgQW9aj9R+Cgzp6Kwb46grGj2GYC+mQkH+1cVQYJQmiAWGEIzIY+jl3uOcfw3SWU2UbY
	o1logx0g==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHFpH-0000000GjAS-2VnY;
	Fri, 07 Nov 2025 06:19:59 +0000
Message-ID: <1f9aa097-27c2-49c0-b01c-cd0377143bb4@infradead.org>
Date: Thu, 6 Nov 2025 22:19:58 -0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/11] dmaengine: Add DMA_PREP_LOCK/DMA_PREP_UNLOCK
 flags
To: Bartosz Golaszewski <brgl@bgdev.pl>, Vinod Koul <vkoul@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Thara Gopinath <thara.gopinath@gmail.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 Udit Tiwari <quic_utiwari@quicinc.com>,
 Daniel Perez-Zoghbi <dperezzo@quicinc.com>,
 Md Sadre Alam <mdalam@qti.qualcomm.com>
Cc: dmaengine@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-crypto@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20251106-qcom-qce-cmd-descr-v8-0-ecddca23ca26@linaro.org>
 <20251106-qcom-qce-cmd-descr-v8-1-ecddca23ca26@linaro.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251106-qcom-qce-cmd-descr-v8-1-ecddca23ca26@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/6/25 3:33 AM, Bartosz Golaszewski wrote:
>  Documentation/driver-api/dmaengine/provider.rst | 9 +++++++++
>  include/linux/dmaengine.h                       | 6 ++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/Documentation/driver-api/dmaengine/provider.rst b/Documentation/driver-api/dmaengine/provider.rst
> index 1594598b331782e4dddcf992159c724111db9cf3..6428211405472dd1147e363f5786acc91d95ed43 100644
> --- a/Documentation/driver-api/dmaengine/provider.rst
> +++ b/Documentation/driver-api/dmaengine/provider.rst
> @@ -630,6 +630,15 @@ DMA_CTRL_REUSE
>    - This flag is only supported if the channel reports the DMA_LOAD_EOT
>      capability.
>  
> +- DMA_PREP_LOCK
> +
> +  - If set, the DMA controller will be locked for the duration of the current
> +    transaction.
> +
> +- DMA_PREP_UNLOCK
> +
> +  - If set, DMA will release he controller lock.

                                the

> +
>  General Design Notes

-- 
~Randy


