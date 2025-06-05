Return-Path: <dmaengine+bounces-5310-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F01ACEFEB
	for <lists+dmaengine@lfdr.de>; Thu,  5 Jun 2025 15:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C25418821AE
	for <lists+dmaengine@lfdr.de>; Thu,  5 Jun 2025 13:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B8622F38B;
	Thu,  5 Jun 2025 13:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mulHPlET"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2B522D9EB
	for <dmaengine@vger.kernel.org>; Thu,  5 Jun 2025 13:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749128654; cv=none; b=e0Ccd5kbqIbHF2H61DLZLP8qXPuP1FEj1HpRA3KsUyiPns6+GjT1yFHjUnLnla8tS31U8DGNlt21BAJ8pGCyT6i4JniI/9BYJ82aCZmzE5+F/dcUv9YXLGmy8d2H3f12kfiZK8JtbRD+rcJtfaZxZ7lUkxk4mYYOgstWOYuqgs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749128654; c=relaxed/simple;
	bh=t4faCEII9JXsy8bQ1teoJQwe81rcZnPfPN7AzMQqsho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=atxC1sR5qRVNL2WV3m0Zz/1IqqlerV287xivK1lg2fz9s+tpH3LKR26FaV/nQILQO3j8hTSQRNbY/kVsUa92yMrPz78Hp8nJKadZT5PGuxX+e0PJcNUJjE3PHRCz0p1T2bzxeHlDa0EiyiYUV92rk9AQVbTyUBPbhENj7X/ReXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mulHPlET; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a50fc7ac4dso606481f8f.0
        for <dmaengine@vger.kernel.org>; Thu, 05 Jun 2025 06:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749128648; x=1749733448; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q9thax7IB2ssxJhFBCOKiLh16kICG5rEU7Rz9YHU3JE=;
        b=mulHPlETvc4CWLowZXAx5uUDZhvngCJrGFk/p/Cet1lOuVmoi+EAvSmzw2gNd4yvu+
         6mhcwzKBqWNKF3r6jtQVlGUWKI+wCEFNPFQfI3BL+5DjPTHsDun50c5K99Xtni1G+/Al
         GT+/L3vzl9BwYO9jI70XqAu22Pa+2VQR3C6oiS0d+/EvS0Bj1roCL2mjcSHOAFDdtoAK
         SyqkpcD8wHWuRcA/HoyM12OMUKbm2PmdhZYIMB6sQrCJ3Ue0GU/RqsFMrrrZkgZxbjs6
         CrIafZBZLKUt/+93GgV43C8p2S8A/HJKaTY39iSCtcLldaitux4nxKD4ij4hG6+SPibT
         6YTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749128648; x=1749733448;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9thax7IB2ssxJhFBCOKiLh16kICG5rEU7Rz9YHU3JE=;
        b=b5o1hqs7ZRQOhAMjlXNEhpc9n0k3T/m4l4BYP1g228m8+pfpTuWWAqyvtDXgLUXMAu
         qiSCdhgqU8bS48VyRKmeD3ThaHwH5ACGLQiBx1CExlTHa2X1hRadusHurDoAorgW12oU
         h28p4u+6swgzc3ksWIQVm5ZgUhsMy4GesWrl5aP+vzZE9cjzZfVZXkyLPquv3EC/I78E
         AkVgjhAZMOensOFw8uImEF8EMb8pM7bSiTNloDhiiwJ9c1dM+WhF3P+z5IsmVHTTAFKb
         mSyFCqGQhmMozHgAu08Q+rGwbs5P2VUYh5FzWo9ktuTWsV2kC9hNLlx2FS9Z5NsuJHWc
         kTew==
X-Forwarded-Encrypted: i=1; AJvYcCWLnTy+T5yV5DvFFEG88Cf0nIAtooGEVv8me3w6oW2lrAeNNyLIWhgjFruKHlflOoilN5SYTdy5nfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOXc+Ydsfl0tfm/7r1WITHw8B6UPyBrlVrZop5FIKUJvWVpBJX
	Ibd0SqDZxvONMW1r6VUFsdZoxJ0oS9STGNcpaJ0PNs0CH6/kJaFMb75dr+QCRTja19k=
X-Gm-Gg: ASbGncuXCczt8TpdSpJY5qscUkjz6gXzSViUHxMTfJGG2/fxuBUSQyjfRgGIRwLorpG
	TsAxJA4IJodxROtbH0f+iYU2P+JbU0s7iXTJWegWI00gEtEjmLq0ZUO7ZYF0HYtj34WWTIXB6wu
	ZBnWeWL6Dw5BYaqr7U0p2Z6uC8gMCnTcbhfzFO9zJM/fUxUMF+CzdtIgIkwEnMme8BA0zylp0NE
	nbSlWUu6t3Gb2Al7NFMa2oJNpGrDpymoHplClEGQzoNt6CLoIbd8khKfAOfBw0erblt1Rdd5RMC
	DY3qos4PvT0eboeGUsTKtgPWz1VIUaBqIXGo4Gjq8Yppt1xk6OlziyhTtPI=
X-Google-Smtp-Source: AGHT+IE/BmSVdL4tbFWwRI8QdSGrFvhSPvFKD3SoCTJ/6Nr+n1FoiYUpOSD1J4F7Wnuta6OWoz81dA==
X-Received: by 2002:a05:6000:40e0:b0:3a4:ea40:4d3f with SMTP id ffacd0b85a97d-3a51d973c93mr6275072f8f.53.1749128648387;
        Thu, 05 Jun 2025 06:04:08 -0700 (PDT)
Received: from [192.168.1.221] ([5.30.189.74])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a525da8e66sm2814969f8f.38.2025.06.05.06.04.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 06:04:07 -0700 (PDT)
Message-ID: <3c6513fe-83b3-4117-8df6-6f8c7eb07303@linaro.org>
Date: Thu, 5 Jun 2025 16:04:04 +0300
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dmaengine: qcom_hidma: fix handoff FIFO memory leak
 on driver removal
To: Qasim Ijaz <qasdev00@gmail.com>, Sinan Kaya <okaya@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20250601224231.24317-1-qasdev00@gmail.com>
 <20250601224231.24317-3-qasdev00@gmail.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20250601224231.24317-3-qasdev00@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/2/25 01:42, Qasim Ijaz wrote:
> hidma_ll_init() allocates a handoff FIFO, but the matching 
> hidma_ll_uninit() function (which is invoked in remove()) 
> never releases it, leaking memory.
> 
> To fix this call kfifo_free in hidma_ll_uninit().
> 
> Fixes: d1615ca2e085 ("dmaengine: qcom_hidma: implement lower level hardware interface")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
> 
> ---
>  drivers/dma/qcom/hidma_ll.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/dma/qcom/hidma_ll.c b/drivers/dma/qcom/hidma_ll.c
> index fee448499777..0c2bae46746c 100644
> --- a/drivers/dma/qcom/hidma_ll.c
> +++ b/drivers/dma/qcom/hidma_ll.c
> @@ -816,6 +816,7 @@ int hidma_ll_uninit(struct hidma_lldev *lldev)
>  
>  	required_bytes = sizeof(struct hidma_tre) * lldev->nr_tres;
>  	tasklet_kill(&lldev->task);
> +	kfifo_free(&lldev->handoff_fifo);
>  	memset(lldev->trepool, 0, required_bytes);
>  	lldev->trepool = NULL;
>  	atomic_set(&lldev->pending_tre_count, 0);

Is it possible that the handoff_fifo is freed, then we could observe
reset complete interrupts before they are being cleared in
hidma_ll_uninit later on, which would lead to the following call chain

 hidma_ll_inthandler - hidma_ll_int_handler_internal -
hidma_handle_tre_completion - hidma_post_completed -
tasklet_schedule(&lldev->task); - hidma_ll_tre_complete - kfifo_out

?

