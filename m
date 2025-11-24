Return-Path: <dmaengine+bounces-7336-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDD7C81BC1
	for <lists+dmaengine@lfdr.de>; Mon, 24 Nov 2025 17:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E9E9C4E8B7F
	for <lists+dmaengine@lfdr.de>; Mon, 24 Nov 2025 16:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42841313E24;
	Mon, 24 Nov 2025 16:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mwx11OBq"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A381531619D
	for <dmaengine@vger.kernel.org>; Mon, 24 Nov 2025 16:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764003334; cv=none; b=sqhwe/HVHuxlkjb19HFtC31Vtdv0kVfbHpqu0sLQzVKQIm/U1Y3g/GSAEigEmfa7nX+qkcqpqQFEIgv/grkaSCilY0FUQUIzloG47cAiAlYRPaSAfHjrj0l2mI+W7s0Tjobe+JwKivnbuXqVw1nNXIXcmnH5QGUnQp6sAk2ccE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764003334; c=relaxed/simple;
	bh=U0M/EmSJN19l9+/ebzMn3Zl/F3Tgh6cVySTFgrA/WJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cf92S/5c8heA2hmPZGNvxLGUvbQHa2XaSXcTjengHTucGXhZdK8ZpScXBiIEMblDvmmMO7cZuDYIc5cRn+qjhaju4WHhoA9O9ZbkEA6q91cSwVXq31ytBemFWzEpYCBHjEf8E21jmjizZDMwlFXMqbpYREoPSmNWLCm9EBAnid4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mwx11OBq; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-ba599137cf8so1737357a12.0
        for <dmaengine@vger.kernel.org>; Mon, 24 Nov 2025 08:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764003332; x=1764608132; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4PkTSzPqE//CxFZT2DpLFmyaJNBSmVJlFczuQFCha10=;
        b=Mwx11OBqY2Xmt8Wv0J4LV99fsyV9BO/I2wj2ECACnD4ozFfoepDVHMbuT3Di59MqBr
         G0RXjot0nuSzioBIssiTZSQSJ6BAcgX9h4BVfpC72McoJn1ItJAc8TcWBzoUW2FZ+QMQ
         aiLeMHvLsP8V/Azrqyb2clUw19dl5zMLe4bpRqEDu8hnRdYNEsSOIk8q+qgFGaI7UV9Y
         uc/JledGYEko9DFitQZEQ2aHawQVXhEOg9ktjRQhkBaMEnL653K5CNXRoFnLMChCR3LM
         Bjlt+lMvd2a9b7zWHU3bagVKvskDUEcdpDL8Lc8nRytDvklJ9J2Ju+YjFPm1MO1GGyTx
         SZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764003332; x=1764608132;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4PkTSzPqE//CxFZT2DpLFmyaJNBSmVJlFczuQFCha10=;
        b=cX/Wyx7LqMSDr5D5/n8IyXONb5OVpvE2JCWbuD2qUP2IPq+8a9UIrFEd3A2of44lts
         CpeibN9+RX/wrikfJHV3ggMQYksxxW4TqfSf6RR0FN0eTD0yUSTUCckwSz6Ol/Wrdraj
         NuIZo7NZ28PH8dCTwtV5HebPwriLImxH4yzuetc1F7dzkxhuEDdhjk40G9Edu7geTrsy
         SPS8tGjMkfdy8b0y0/Zrtmtx96vuvJTBE/oGNP8HETQs3sp2llEVxmllVdX9LyQASu5B
         iPdDiMxIDvX4snfcUL6xQnoSYdjJVe2Gsuo/BUsUbc1QsdKAemvxZPVcNZp/+/v69Ymz
         SnoA==
X-Gm-Message-State: AOJu0YydoBu+y+XtMttj/fi8YumLRqfRsMSDfy4nme5aE+2OEj7BoCYZ
	DwJQgXOJ83J9YbpgVAVuV3d/GFLsYfUu95o2FdyWEOH3wExGnpPxXW/i
X-Gm-Gg: ASbGncuOswUkGSvWAoOXmCOiBq4ASNnppYjDxq2jkpIzwmrEUSvVT6zwzWmV78S0Cls
	mmCU/yRHYnKh/FrITGVNIWtjE0USCbs3G7TqOxW+VMt6j63W6KPqkG0FhUeCmaCYPQQcHgRK0PR
	e5iAZw34o6XuO7vuKn5VD+tErqJkshdPBox23RUQtinUIwxgkbf6k7CsYQ9ncBs6t1/A5L7HcDT
	M3SO6nwPnVl8U3HKmUNGBoDHnB6NdRl5HM6tC1qW8TApm0oreXV3Smgw7yFN+Wy6JV1XU7JUI9x
	/hfpzUTpeR9jEmkkGpjiZL9g9artyCzrqha/YdsH0bwWWGY21WTJjML3FQskKBrtS12fSpTrGm8
	tTeS5x0ApInZEydPJj3YzESFk2ay1DaRWKRVyhFTpFWmsicNA35yNhuosUb63TTaycflg9xg1eQ
	+D5OTPbrNuhM9hTLD3TuMOMkUjxxVBpeEmk/4=
X-Google-Smtp-Source: AGHT+IE9A0t3u+DlBF5w0TChVNS8IAJiNWyhPSKPb8XU7WkuxpEILcbBsNrK17+S0nkmNY7Re9mHKg==
X-Received: by 2002:a17:90b:3841:b0:32e:4716:d551 with SMTP id 98e67ed59e1d1-347331bf3a7mr11163515a91.6.1764003331638;
        Mon, 24 Nov 2025 08:55:31 -0800 (PST)
Received: from [10.0.2.15] ([152.57.124.34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34727c4b663sm14053551a91.9.2025.11.24.08.55.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 08:55:30 -0800 (PST)
Message-ID: <4aef483f-df7f-420a-abba-b2fc27db0105@gmail.com>
Date: Mon, 24 Nov 2025 22:25:23 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: dmaengine: add explanation for phys field in
 dma_async_tx_descriptor structure
To: Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: dmaengine@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, khalid@kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com
References: <20251113064937.8735-1-bhanuseshukumar@gmail.com>
Content-Language: en-US
From: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
In-Reply-To: <20251113064937.8735-1-bhanuseshukumar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/11/25 12:19, Bhanu Seshu Kumar Valluri wrote:
> Describe the need to initialize the phys field in the dma_async_tx_descriptor
> structure during its initialization.
> 
> Signed-off-by: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
> ---
>  Documentation/driver-api/dmaengine/provider.rst | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/driver-api/dmaengine/provider.rst b/Documentation/driver-api/dmaengine/provider.rst
> index 1594598b3..f4ed98f70 100644
> --- a/Documentation/driver-api/dmaengine/provider.rst
> +++ b/Documentation/driver-api/dmaengine/provider.rst
> @@ -411,7 +411,7 @@ supported.
>    - This structure can be initialized using the function
>      ``dma_async_tx_descriptor_init``.
>  
> -  - You'll also need to set two fields in this structure:
> +  - You'll also need to set following fields in this structure:
>  
>      - flags:
>        TODO: Can it be modified by the driver itself, or
> @@ -421,6 +421,9 @@ supported.
>        that is supposed to push the current transaction descriptor to a
>        pending queue, waiting for issue_pending to be called.
>  
> +    - phys: Physical address of the descriptor which is used later by
> +      the dma engine to read the descriptor and initiate transfer.
> +
>    - In this structure the function pointer callback_result can be
>      initialized in order for the submitter to be notified that a
>      transaction has completed. In the earlier code the function pointer

Hi,

I just wanted to check if you had a chance to review it or if any changes are needed from my side.

Regards,
Bhanu Seshu Kumar Valluri

