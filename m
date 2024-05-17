Return-Path: <dmaengine+bounces-2050-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FEE8C8314
	for <lists+dmaengine@lfdr.de>; Fri, 17 May 2024 11:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D0051F2326A
	for <lists+dmaengine@lfdr.de>; Fri, 17 May 2024 09:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A012561D;
	Fri, 17 May 2024 09:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qg/Fr2OF"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CB6219E1
	for <dmaengine@vger.kernel.org>; Fri, 17 May 2024 09:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715937097; cv=none; b=lEVzfmNfK+dE69ZURcO0aL1hpO5x3tZeLBXoLwa79AhK6ZbJ7iBiC/aWV67i8kbYI381dxS0Tgt8r5TguWbPU2/PXABIM650YS2A7o5q44LdfCvZ/WI8LYUyG8oGJp9rxj1y6+tyt/haBlgUTsi++vnZsXef2QHjPxhXdc1t/mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715937097; c=relaxed/simple;
	bh=DoLTsawHpeTfuB9cwiMX8gLog+phP2olzr7YENPNrxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lTQMs4TzVCKRsOgRvevp5Pmq0FPQG4elOZlL8UkAUSy8d09kPrord6ZV2630xqVi0jaJFTM8VbMLCU0tf4Rc8AP/0mCrck30sLHDLndERctv3LtQ4UjauezmwGplT7t/jl1l0dSdaRyLOx+S2XEh1+dpXG9h7NGRAbT7QiVHL/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qg/Fr2OF; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a5a89787ea4so414064866b.2
        for <dmaengine@vger.kernel.org>; Fri, 17 May 2024 02:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715937092; x=1716541892; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3wbo50xwb3HFwy2Js34OThKfA1hpUVathWWvMAHMruo=;
        b=qg/Fr2OFlFQTT3Aol9ciNz8tsTHJM2U1dKVMIOqUlhQzbAOSrNKlNhTCX4anwSpxmN
         rkA/jtsf5La4dmXoZfOo2NlVokOQIhd6SrRaI3sNjkWN9DVgaFjC4Q/uh8vDvBnh2ut1
         fvGoKabouycpXWto8NWaYLuvZwv2f7hUfQwebBajG0T3QLPKD7U5nnMzeYZllPDfPUfs
         YQpn8Vo3oPoPQ5/76amJO38E02xiB1Dmzvg44cZWB0qBQCS64DY6gypy7MPof5WhTJA8
         Vzi/zem1SSANoyoqUEY5vOxaGsunwLx86pOXMnG3dMU1jgHWR/Bl7JS6mcO7WK+IYdff
         TJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715937092; x=1716541892;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3wbo50xwb3HFwy2Js34OThKfA1hpUVathWWvMAHMruo=;
        b=UTUTs+EIoX5R/RhR+OtU83ovcP4V2CtMznRTzBJ9UIlHIkflFInzbb7dtjYXe+Hj4U
         1zhyX4vflOT8hgM33dXb/FA4F7q4JraagvKgLDZay3IVKLs31ughw1kdvS5WTKq5oDgv
         TIF5F3lTRossSUem58CeGq1iRUJK1UcyY5/6hXZ9CKrmbXTGEl569KovtB88rBX8fJam
         Bh20/ojUkPZM/4eMobak76jqzVaTIiiQRevtaZI3wluBrjk2ToKCly+JrqvSxHcVoCyR
         hCRTTjlJ9AA6DkkiWg4Hqumux3sKoVdanCWj3d/bf9I7k58QZv0ZZthFYTv3qORmUnGF
         WuHA==
X-Forwarded-Encrypted: i=1; AJvYcCWbi46vR/7Zvdaup5lRAxJzLYZYw7V5D3kmt+phMfoYZq4Dzbr3g7IoOfRTnVGC7TuUuo7tlP+VgA3gTgOgw28B3z90DX7h6q/c
X-Gm-Message-State: AOJu0Yx023WImFEkK4EMdzKJCP1yV3Zs6mA9U6PiY7f+Elopq4pAfK1h
	P1Eun6XSu4mIekrRYvF/3LUXYC+tgUNQd+RqNXIe9kAlGnLs1BmZADcU9sbvV7w=
X-Google-Smtp-Source: AGHT+IFUuE27SOBRiwiM5jzv8pfjnHU4AIrW12/v2KmpB6rpAdGZVts7qvikNVwq4pSeqOpzntfyrg==
X-Received: by 2002:a17:906:32d9:b0:a59:dd9d:6da5 with SMTP id a640c23a62f3a-a5a2d54c07amr1318225066b.3.1715937092597;
        Fri, 17 May 2024 02:11:32 -0700 (PDT)
Received: from [10.91.1.133] ([149.14.240.163])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17892471sm1096886566b.84.2024.05.17.02.11.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 May 2024 02:11:32 -0700 (PDT)
Message-ID: <39b66355-f67e-49e9-a64b-fdd87340f787@linaro.org>
Date: Fri, 17 May 2024 11:11:30 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dmaengine: qcom: gpi: remove unused struct 'reg_info'
Content-Language: en-US
To: linux@treblig.org, Frank.li@nxp.com, vkoul@kernel.org
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240516152537.262354-1-linux@treblig.org>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240516152537.262354-1-linux@treblig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/05/2024 17:25, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> Remove unused struct 'reg_info'
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>   drivers/dma/qcom/gpi.c | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
> index 1c93864e0e4d..639ab304db9b 100644
> --- a/drivers/dma/qcom/gpi.c
> +++ b/drivers/dma/qcom/gpi.c
> @@ -476,12 +476,6 @@ struct gpi_dev {
>   	struct gpii *gpiis;
>   };
>   
> -struct reg_info {
> -	char *name;
> -	u32 offset;
> -	u32 val;
> -};
> -
>   struct gchan {
>   	struct virt_dma_chan vc;
>   	u32 chid;

More detail in the commit log please - is the structure unused ? What is 
the provenance of it being added and becoming dead code.

More detail required here.

---
bod

