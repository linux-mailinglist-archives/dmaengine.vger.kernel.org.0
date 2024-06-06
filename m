Return-Path: <dmaengine+bounces-2298-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B695F8FF3F1
	for <lists+dmaengine@lfdr.de>; Thu,  6 Jun 2024 19:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56B3A284EDF
	for <lists+dmaengine@lfdr.de>; Thu,  6 Jun 2024 17:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E64199241;
	Thu,  6 Jun 2024 17:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzkVz2Rp"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B707E199234;
	Thu,  6 Jun 2024 17:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717695663; cv=none; b=ko2Vm5HiVFYnSlIWlf9xcPCM+u1FukOJFkRXGpf5Kg0SQYSpCq7LHfDWQlrrs+gAI9KHOT4vnqV9TJ8zOtx9Qijem53jSJVZ37vCVKUlZbJZhnh/VhF+Iq14WdA85oSnK6ABRtAx5IJCZkjzxv43+QANbLIKa7Lzk+D54BgQbvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717695663; c=relaxed/simple;
	bh=yDUl6DKSl9pKbiUv316LKJC/x2wJuLMw7ScYSeQPJzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DcZp1RpFAMQ8cpPwG2c0Ud5YDwdng6XD+9u1QQvNtyBJ09MHlmWV3gFOOWPookWTG1SOVt5X5nHzgD+l15COOUgaxp2n7WnmpmODXaMxf4SQx+CGSJgh+9ktsq0Jgfxvm+pP+livn1ojQZliwy4r9/kpV9aTMf56LrKccUB/O20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PzkVz2Rp; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e73359b979so15196241fa.1;
        Thu, 06 Jun 2024 10:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717695659; x=1718300459; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xxRkvTIPkScGp1ZyUGP+q6S56T8mZvmbd28YjaNuyas=;
        b=PzkVz2RpKtL0vVCcA3TTmLQ4LND23PakwSf5r9xRGCKUtHcjEocRo5pkNV85X5vsSy
         CcD7ngypCNl/hVJBzIuUXKJbbVsxc/+VxLIeBYd6rWA34a1PDIS9n29ItoK2i/YDf5RN
         Fhlu8KnMGrwk3JSwjj+jD48Z1XrBEDrGcNQG7MBQAT0gzmHcNZRUY4vrw3Mvl0ERHPNV
         cM2fCxAJgi8/HeMtgWhS7G+oG4EzGz47YUrpscPSlHCxS/OIgvjb/9EZTqIA5sbccix0
         Ukeun8ZJAY3aZOgKIJiG3d4Je43xX7cAZXGWJ74uVJ1lPljOG/Jto+JQ1TNwjKwhJ4z/
         gq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717695659; x=1718300459;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xxRkvTIPkScGp1ZyUGP+q6S56T8mZvmbd28YjaNuyas=;
        b=rC3xTFRTJDehwbpNaRvhlTU7JcTVOkrqcprV56Hgo09dk0lHZTUG14dNLrHfowZ5PQ
         TsQm4O6r5Jg3iwpVFcV1HBbC0h+6HE3WZXA00F7NJTFSpC3kfeTAyYblCyaJ/1VsvMk6
         0DrGQQH8eGQYucNS2/b8FzYvSpH6ASSB2RPUzj+IdzIWtEKNbzMdI/erm9KkSvGTu0dd
         nzneX6fn6Nw2eNQmvMHEcIsnPJB7bRQAXhEucHqni2y43RlP3tHlVj8yODWuc9N1Wl2F
         hpvZoanyQAR8qZoCyNDXSu4/rkhLged0BJMvN+So6ZVCPE9qDm/I/YUJD+GSR8erKlAj
         nPCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxk/ccU/JKZyVCa/PXJQp99uE+a96U/FOVnF5w6g0XVFEFNlspla2veq/3+YP75/O/0jIFVfw5Az/lidcKmWpXq5IcUi3qLBT3t5IB8sGCLhELfV99Dh1bWfF48CEbelw/jqEFVBiFqOvmGoDV
X-Gm-Message-State: AOJu0YwjlSvJ1AaVPAP6pgZ2W8/2dRukJNNaM0jqtHQbBO+bUvBYUVn/
	di+TjpKXyYKkOwzgyi5A02vDdwlLUw7plOGbpz7kQF/l66lvcxHU
X-Google-Smtp-Source: AGHT+IEc4dm0uh5aarO64zIpyotGYs9UV+iunav+qqO0HqIqTJeg4E9+AGBRQzENYh6eqU5xAzwJCg==
X-Received: by 2002:a2e:bc14:0:b0:2da:a3ff:524e with SMTP id 38308e7fff4ca-2eadce208c4mr2745941fa.9.1717695658663;
        Thu, 06 Jun 2024 10:40:58 -0700 (PDT)
Received: from [10.0.0.42] (host-85-29-124-88.kaisa-laajakaista.fi. [85.29.124.88])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ead41bef2dsm2583541fa.109.2024.06.06.10.40.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 10:40:58 -0700 (PDT)
Message-ID: <b57827de-8e72-442d-99fa-307a719ea33b@gmail.com>
Date: Thu, 6 Jun 2024 20:44:31 +0300
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: add missing MODULE_DESCRIPTION() macros
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Vinod Koul <vkoul@kernel.org>,
 Fenghua Yu <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <20240605-md-drivers-dma-v1-1-bcbcfd9ce706@quicinc.com>
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20240605-md-drivers-dma-v1-1-bcbcfd9ce706@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 6/5/24 10:28 PM, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/idxd/idxd.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/ti/omap-dma.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/dmatest.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/ioat/ioatdma.o
> 
> Add the missing invocations of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  drivers/dma/dmatest.c     | 1 +
>  drivers/dma/idxd/init.c   | 1 +
>  drivers/dma/ioat/init.c   | 1 +
>  drivers/dma/ti/omap-dma.c | 1 +
>  4 files changed, 4 insertions(+)
> 
> diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
> index a4f608837849..1f201a542b37 100644
> --- a/drivers/dma/dmatest.c
> +++ b/drivers/dma/dmatest.c
> @@ -1372,4 +1372,5 @@ static void __exit dmatest_exit(void)
>  module_exit(dmatest_exit);
>  
>  MODULE_AUTHOR("Haavard Skinnemoen (Atmel)");
> +MODULE_DESCRIPTION("DMA Engine test module");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index a7295943fa22..cb5f9748f54a 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -22,6 +22,7 @@
>  #include "perfmon.h"
>  
>  MODULE_VERSION(IDXD_DRIVER_VERSION);
> +MODULE_DESCRIPTION("Intel Data Accelerators support");
>  MODULE_LICENSE("GPL v2");
>  MODULE_AUTHOR("Intel Corporation");
>  MODULE_IMPORT_NS(IDXD);
> diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
> index 9c364e92cb82..d84d95321f43 100644
> --- a/drivers/dma/ioat/init.c
> +++ b/drivers/dma/ioat/init.c
> @@ -23,6 +23,7 @@
>  #include "../dmaengine.h"
>  
>  MODULE_VERSION(IOAT_DMA_VERSION);
> +MODULE_DESCRIPTION("Intel I/OAT DMA Linux driver");
>  MODULE_LICENSE("Dual BSD/GPL");
>  MODULE_AUTHOR("Intel Corporation");
>  
> diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
> index b9e0e22383b7..5b994c325b41 100644
> --- a/drivers/dma/ti/omap-dma.c
> +++ b/drivers/dma/ti/omap-dma.c
> @@ -1950,4 +1950,5 @@ static void __exit omap_dma_exit(void)
>  module_exit(omap_dma_exit);
>  
>  MODULE_AUTHOR("Russell King");
> +MODULE_DESCRIPTION("OMAP DMAengine support");

It would be better to "Texas Instruments sDMA DMAengine support"

>  MODULE_LICENSE("GPL");
> 
> ---
> base-commit: a693b9c95abd4947c2d06e05733de5d470ab6586
> change-id: 20240605-md-drivers-dma-2105b7b6f243
> 

-- 
Péter

