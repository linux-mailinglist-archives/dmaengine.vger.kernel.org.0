Return-Path: <dmaengine+bounces-7464-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A50F6C9B08A
	for <lists+dmaengine@lfdr.de>; Tue, 02 Dec 2025 11:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B96C3A351E
	for <lists+dmaengine@lfdr.de>; Tue,  2 Dec 2025 10:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF61309F02;
	Tue,  2 Dec 2025 10:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V4Bm+qah"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431772F617C
	for <dmaengine@vger.kernel.org>; Tue,  2 Dec 2025 10:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764670330; cv=none; b=Y17cM+xc6+KlAjOAPOTojn2p74kiAgXzIMMEOOXY9CdGH/nonfRBVbxJQtohvpPBqUqDkU0AYPDd0QZ98ktzCM7G/hdRcJPWrm7lKjQhIo/zBQflFcn6Nt0aHRwBp9A5FO0Au2rORRz54WolZqZTpRZHk6tg/KmmMQmZsULbRmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764670330; c=relaxed/simple;
	bh=Ey5eI3s0EZIjd/ihRfI3/2W1ncKTIRrlw1t8+SMQf1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DSLQO6RoJVpCf69N4SuFABLOFxv3QoPOufxFWPLdyWSw8B/UKV6f+vOqTQK4fpCjvzcuO0S4Q9jF3Lwmi2JvcDOxRZba+Dg4xGfjHWp6NCjtvAHKgGx6ngBRGjsMFUGLBSBeBlX2FRe8Y3ytu/FBrURaRedlXq30leDTpKeTrZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V4Bm+qah; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4775ae5684fso24589985e9.1
        for <dmaengine@vger.kernel.org>; Tue, 02 Dec 2025 02:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764670326; x=1765275126; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CxYOXKUAxv2oo2iThAzf0N7pfohHkz79DOwp2lJTIMk=;
        b=V4Bm+qahK1SQl5czdtxfJPW1Uw5t+3ZEkf6qHnk6VuXKTMiFbb+J3/tO+eXIQ3o6LI
         C0sT+xGuyi3dco11CWiowy7k61jj/WlOsJjIF0B5SZJv2+WvdLVsKJvGMtpwWjBiMSz/
         WZD6IJM8LWmbS69frz6wIi6Ft58ENsBxXQqW1eZDBQr9s3k+a+j0BkMPskv/7blPd/9h
         NhKHbcKo3psx4V5NSBlE8p4tPylrKyofyro8WNXwQ6FJIQo9+V7HsfUsZk7tSx1Wpsi2
         T1cdwcfwQmcpLkdeFbTWXAHVOLSaxHV9zxtYTikzquy4bHv8r0vZecOYBAfqkxIiYcer
         /uiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764670326; x=1765275126;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CxYOXKUAxv2oo2iThAzf0N7pfohHkz79DOwp2lJTIMk=;
        b=B/yqbQxxStEvHNikQdEhgPtZJzcw9BG4jI7qasrAZayjjjOZnnMPKqBscUGq1c4GpB
         WN5t3/A6Qih9tEFSJiqAxBQS1KSxArxfbaf9xvQSVvj2J0b8Dh51FI9vmTtyHc2qj6XD
         7YFXXiC6TkI10EQTuUd3GScC6vMjHjVMdrO7t4GS0HSDpvhsTRafA0LG2lR+3hJT4nmy
         qRXyZ9dNCxmZwC7B/MbduRAxIHkSD1EDGdWaKFgCJk0JX0z8gB9TAgx2Iuow4/UQVt47
         GedpooNMrSFedxZmA2wH4igLN/dGEjnKXhg8pOVuxMKs2bQNBQZBlrJ5gZuYaN9zemWc
         c4JQ==
X-Gm-Message-State: AOJu0YxDLa1Gr6plbMG/ckQontDCVzaaTIszh50SjD8LCpnRDLHwxb3p
	qpoT+Zru/C2J63jCfM61pEDktTrro43ypACmoXM8YCVEklfFD3r5eMEhGPzVbMveMF8=
X-Gm-Gg: ASbGncvcbuSrWPlOXJqbfFY6TF6+RU9RPjeCvrbWTbsWUJCcaYYP21v50Hxxmo8GzlX
	NJ70LsfCR9Tu+jOvT5zcb/ONJ35SQ+t3d0O8p3aE6OYr4ed9wBu+tEIFBbtD45rq2r7gamxGHHu
	ap58X5lrKyP+pMdB/uBZJzOqgrA7xwrTakV0VfY2FzF08Gu7hQRtNGINbWgsc814hOggZ9oNVti
	g6IG6cMfO5tAsdu0c2RLiZKXsnSNgmqG2t0kRRRq+GH1f7ORQ754KIsZQR1NWJSSw8pdmyXW1bM
	wfmRKOg+zQGUCILCQhE+1PLsaZkXcUAYataiJz6dcZ8O+5E5o8HknbG1q49Nz5qI4rws2nt0K97
	GZ8JgWunLcdRVTZ3Z9bQWFkQgMZH52yKdKu4jR4BFIJMTIPnt3uVw/yR6qelbcP6PJuB0Gp/8TT
	++iOqnLHYpxYyQu1aNAgZQ5Jv9fj4=
X-Google-Smtp-Source: AGHT+IEys/A3nKiC2zwVQpwKCOow8VuHIYtsNZJK9C+bNsjFGQrcIjqbb4SZ55KQBpO3EYjRTFFIIA==
X-Received: by 2002:a05:600c:4ece:b0:477:7af8:c8ad with SMTP id 5b1f17b1804b1-477c115db0cmr447432975e9.31.1764670326603;
        Tue, 02 Dec 2025 02:12:06 -0800 (PST)
Received: from [192.168.1.221] ([5.31.29.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47927a06a09sm10833185e9.16.2025.12.02.02.12.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 02:12:06 -0800 (PST)
Message-ID: <c1983852-b6ae-484b-989b-56fe0d00a679@linaro.org>
Date: Tue, 2 Dec 2025 12:12:03 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] shdmac: Remove misleading TODO comment in dmae_set_chcr
To: Amin GATTOUT <amin.gattout@gmail.com>, vkoul@kernel.org,
 thomasandreatta2000@gmail.com
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251128152947.304976-2-amin.gattout@gmail.com>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <20251128152947.304976-2-amin.gattout@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/28/25 17:29, Amin GATTOUT wrote:
> The comment suggested that the dmae_is_busy() check in dmae_set_chcr()
> is superfluous and could be removed. However, this check serves as an
> important safety net to prevent configuration of a DMA channel while

I find this a bit odd overall, because apparently nobody checks the
result of dmae_set_chcr() .
So if it is such an important safety check, why is the result never
checked ?
As it looks, the caller doesn't care and continue as usual. The
difference would be that chcr is never actually written if the channel
is busy. Which looks strange. And "unexpected hardware behavior in edge
cases" is quite vague. Do you have a scenario when an issue would happen ?
dmae_set_chcr() gets called on resume() and setup_xfer(). Is it possible
that in fact dmae_set_chcr() is not called correctly then ? Maybe this
chcr should be written at a different time when we are sure the dma is
not busy ?
Or why is it even possible to have the dma busy when calling it ?

Eugen

> it is active. Keeping it helps ensure transfer integrity and avoids
> unexpected hardware behavior in edge cases.
> 
> Signed-off-by: Amin GATTOUT <amin.gattout@gmail.com>
> ---
>  drivers/dma/sh/shdmac.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/dma/sh/shdmac.c b/drivers/dma/sh/shdmac.c
> index 603e15102e45..d0e0437ad916 100644
> --- a/drivers/dma/sh/shdmac.c
> +++ b/drivers/dma/sh/shdmac.c
> @@ -243,7 +243,6 @@ static void dmae_init(struct sh_dmae_chan *sh_chan)
>  
>  static int dmae_set_chcr(struct sh_dmae_chan *sh_chan, u32 val)
>  {
> -	/* If DMA is active, cannot set CHCR. TODO: remove this superfluous check */
>  	if (dmae_is_busy(sh_chan))
>  		return -EBUSY;
>  


