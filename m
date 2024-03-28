Return-Path: <dmaengine+bounces-1609-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D94088F9E0
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 09:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26455284335
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 08:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040F72C1BC;
	Thu, 28 Mar 2024 08:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LR7fCMkz"
X-Original-To: dmaengine@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711DD42A8B
	for <dmaengine@vger.kernel.org>; Thu, 28 Mar 2024 08:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711613751; cv=none; b=QXx3gNDhX7Ou7TfrNaid6ctsKPqSZGJ7p4iEagtYV/xEw/F/+uLpBxTJ9kyCURNmVLqCWmnUa6j3AYt+LPl0LGmwVtUNd64d6rU1GsUYEgP1gw3M6rjE8GWw3a0j4pddvz4zPMSTRzvnd41dOAG+NzDeDIuSoUOCI8BxuTbL01I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711613751; c=relaxed/simple;
	bh=AEHEjkDnCHHUxB0G77hRCttazDS5YP2phnhrwEJqMM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aHME5fQ57XlSyNXN5SwV1zVhyftoz0A/KzukuVKwEFYH2XbTU1fK4NguM5dnPnSogNM1iG9GmshWVwXWW0wRZaslnryROhIp+G2mkAh/XZjD1cmdNWISRWnGs+Gr+RH8B7RNWxDlfKJJBnHxxH0fYAyBaBXULoM40WBKhZUg0FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LR7fCMkz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711613749;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zjUADkxK7W8MqHSaaLff78AqyJRHwq7pquaV+zZOTUA=;
	b=LR7fCMkz5IfEk6B9SFWIsRlsTbv21GkbArFiXiQPgeNJlj+zfToxGkkqhvJt/Jyf31Ur5D
	Avf+HCR3fZty530hjeMKEY6x9kxoCk1PCc3hfol2Z03xnf5HaQ+PJB4vtXLJ4oykKGpo5V
	waUYdmBRcAvwdWFQAQ6JHiWDW/2uEao=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-dgPgyxlaMii2XeA0Dxm4Ag-1; Thu, 28 Mar 2024 04:15:47 -0400
X-MC-Unique: dgPgyxlaMii2XeA0Dxm4Ag-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-341678a510bso406202f8f.1
        for <dmaengine@vger.kernel.org>; Thu, 28 Mar 2024 01:15:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711613746; x=1712218546;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zjUADkxK7W8MqHSaaLff78AqyJRHwq7pquaV+zZOTUA=;
        b=Rhgg/q5RMvRYM0simqWbtcOml0Ay6T5hVHIkyiVFDfEqZqhcUJsyVWtRMMDMjy7etQ
         vXlwYxj2lFZaE20V44+zc0DsUiOqsna0Xs3PkbPPTBVx1jij5MSF6KcWgRL/SFevGCdX
         bqoKhLLUXN24nIy+moWmEbhjaWrCEEY448BL7m6redegEdbRi81+oAFc7KDRWwgkxmnE
         fyCmLUrGsYPnvCCYfPkO4U1CaMJNUTojEnaIdqmGpzGGapqyw+8YApxqdA+cDP/v9Fvc
         Luw1UGHsQfg55yuku6Y8Bbpyb67qEO2hzUMv9Wg8Fg/rYvSRwVK+VyHMmG8/p7d4cfQB
         vsGA==
X-Forwarded-Encrypted: i=1; AJvYcCU6HV1Uhowt48IIrB9G1wVopFqX6dwO1Xa1N5TyQBK4bFfa0deVqKG1dA3P9x70hru3QVpqFKkAMP+UH27SRSBcdVhZ0VC59aYA
X-Gm-Message-State: AOJu0Yw49HiOPTPjhGCnDpfhZMfSxnGuNr7UDQigbgZFb4uK7DZyBryi
	zhyfOL7cJjT/pS4KzCvicUaOSbbAoyol+DyqQjXqcqiv+JBjYA0msbRBgWjGUjQUkFUrL2j1EB7
	89sHLjHsXlgqlmcsgXQ4T/enmhE55URsgWxZ+49RjGCbnBMLAyUAvjiuSFQ==
X-Received: by 2002:a05:600c:468a:b0:414:c42:e114 with SMTP id p10-20020a05600c468a00b004140c42e114mr1687530wmo.39.1711613746214;
        Thu, 28 Mar 2024 01:15:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8MDeRM7xS3BA3duuFbIO3KAqdPRdzqESI90M9Ta6qWW4GGp1Je55w6TxUEAK7EYkUeNt2Cw==
X-Received: by 2002:a05:600c:468a:b0:414:c42:e114 with SMTP id p10-20020a05600c468a00b004140c42e114mr1687496wmo.39.1711613745872;
        Thu, 28 Mar 2024 01:15:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id s21-20020a05600c45d500b0041487f70d9fsm4599444wmo.21.2024.03.28.01.15.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 01:15:44 -0700 (PDT)
Message-ID: <66fd044e-37a8-4f03-a19a-fcd754bdcc40@redhat.com>
Date: Thu, 28 Mar 2024 09:15:42 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH 19/19] vfio: amba: drop owner assignment
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Russell King <linux@armlinux.org.uk>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, James Clark <james.clark@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Linus Walleij <linus.walleij@linaro.org>, Andi Shyti
 <andi.shyti@kernel.org>, Olivia Mackall <olivia@selenic.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Vinod Koul <vkoul@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Michal Simek <michal.simek@amd.com>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-i2c@vger.kernel.org,
 linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-input@vger.kernel.org, kvm@vger.kernel.org
References: <20240326-module-owner-amba-v1-0-4517b091385b@linaro.org>
 <20240326-module-owner-amba-v1-19-4517b091385b@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240326-module-owner-amba-v1-19-4517b091385b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3/26/24 21:23, Krzysztof Kozlowski wrote:
> Amba bus core already sets owner, so driver does not need to.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> Depends on first amba patch.
> ---
>  drivers/vfio/platform/vfio_amba.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/vfio/platform/vfio_amba.c b/drivers/vfio/platform/vfio_amba.c
> index 485c6f9161a9..ff8ff8480968 100644
> --- a/drivers/vfio/platform/vfio_amba.c
> +++ b/drivers/vfio/platform/vfio_amba.c
> @@ -134,7 +134,6 @@ static struct amba_driver vfio_amba_driver = {
>  	.id_table = vfio_amba_ids,
>  	.drv = {
>  		.name = "vfio-amba",
> -		.owner = THIS_MODULE,
>  	},
>  	.driver_managed_dma = true,
>  };
>
>

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric


