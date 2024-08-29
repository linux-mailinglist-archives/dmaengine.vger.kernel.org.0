Return-Path: <dmaengine+bounces-3020-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2DF964186
	for <lists+dmaengine@lfdr.de>; Thu, 29 Aug 2024 12:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD1F2B2512C
	for <lists+dmaengine@lfdr.de>; Thu, 29 Aug 2024 10:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A2B191F77;
	Thu, 29 Aug 2024 10:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BtKSMlW7"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F63A1917F3
	for <dmaengine@vger.kernel.org>; Thu, 29 Aug 2024 10:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724926759; cv=none; b=Wiuj2A88w/8tzf9Sm5o/hfX2uaNewtk4/VHYfANtssr+0arz0s7qkAjfoeb1A1WpgkgwN/hwL+NIkuZf/v/IetMxTH9qlqPHOCqMhblAZmZgqbbTFp+PS/TVHV2a83cyMzF9x3JcFRM51HEF3IgnPRlCTjQ0QyrxIIKEt0ohixE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724926759; c=relaxed/simple;
	bh=NgBGaohZSn2ujQXQ1kODfi5bvv65HVMuTRh6A6bGzVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GawRMgn3ggOSe5eEQQg0PBW/Vsvb7heWms15RgaIaTNQr5K/OfSkfMG4YMvtNsLzvrecWcsHZp6WvjUIMa8jL9P2RXksrZR/nAIcEsbXJIeEWqYlPHXitju0JraXvqn/MDV+zVHxt3e7LZKX0CKfc126PRNz7boZEtA6T0AASdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BtKSMlW7; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a869f6ce2b9so42025866b.2
        for <dmaengine@vger.kernel.org>; Thu, 29 Aug 2024 03:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724926756; x=1725531556; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nopjZOiXiccCurmPDi4lhpMiSpQ7X9/bOex7t+lHZIA=;
        b=BtKSMlW7XZr4Lm1FTEzEuYL3fXKE5eGRH61E/NLz/rpLx/sioXTyJ/Vv+Sld6sa5em
         WtDUuSRBQxVlacSJy3uvHA9QNDUGOuuEyItOE74V4vPIOP1Dlcztc0j0mjfqbp1diBpz
         TqchM1et8b7eomaF4CZy7d+P9Kgy2smIRv2iGUIBPSpXxUvDi4m54TkkovYAeeDO58u+
         uMAZD0c0DTrJ3OkVUqgNgm/2IQmhEl9ruCh+TN1hM1Rw4Ru5DFOkLaOGQni+/5ntlqvy
         0V/o495Llx+KAYfGyfpHhYX/XtRfsqSIiXxaj2O2MW9bWq9MhNMp40EUkUFODN5Ul3Km
         SPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724926756; x=1725531556;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nopjZOiXiccCurmPDi4lhpMiSpQ7X9/bOex7t+lHZIA=;
        b=pCRF67RQXUYz/xNkqPboYR8HaaykX7VlQI5Zt7LKskddunKKrlepeiutpjQ80UYxCo
         ZbD+iQFHkDwPkCOcsXDUF85OdNWn9NVM+r3jT3i/dNBaseVwvrxtbpoJkpfY30Xa1IpY
         c/d2NN0VatpNDM8de8QICs3R8lZosC5zRz2Mp7szAjPID8PtfEYk7ieIwZK2Ccf6w2WA
         dBAI8KrDNJ5QB/3KYi9aqIWDfsDDc2XDT+ifmzJqhPUvedEhtoP/vP31TOE+yf1mwHWU
         sZE+klS/+fXgza4jRWoMXe+S4Is78CWxTrLKCNVpI1bQmtl7/4onIbejkRV3alS4Un8t
         PPzg==
X-Forwarded-Encrypted: i=1; AJvYcCXhRXnisVF2eAOFwJjvUyKgtqUG/4XkLFc0PuBJipj57A1XnHOQE4SKWLDXdoeMNT/Vr8jd528pN/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOiFh+bPewPuOIF3r8cfeIDefPGM1S3HU5fSUj+ZfBhK9gOLtN
	7F3HOu+nweVJJsSWPa+Z1gn59waBVIjCePvAJS/atGKRo9PnqYV7oVTKNS1koRA=
X-Google-Smtp-Source: AGHT+IETKZnM5+V8q/IAwppa+3QG8CZq/4HYaD9qYC2EdM3dOtcZyyhQ65wHS4u5dtwJxEHeX73Mvw==
X-Received: by 2002:a17:907:7216:b0:a86:bb5f:ebbd with SMTP id a640c23a62f3a-a897fad70f8mr137210866b.63.1724926755889;
        Thu, 29 Aug 2024 03:19:15 -0700 (PDT)
Received: from [192.168.0.25] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988fefb60sm60432366b.43.2024.08.29.03.19.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 03:19:15 -0700 (PDT)
Message-ID: <45298600-beaf-438f-979a-3cb9e207a32e@linaro.org>
Date: Thu, 29 Aug 2024 11:19:14 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] soc: qcom: geni-se: Export function
 geni_se_clks_off()
To: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
 konrad.dybcio@linaro.org, andersson@kernel.org, andi.shyti@kernel.org,
 linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: quic_vdadhani@quicinc.com
References: <20240829092418.2863659-1-quic_msavaliy@quicinc.com>
 <20240829092418.2863659-4-quic_msavaliy@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240829092418.2863659-4-quic_msavaliy@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/08/2024 10:24, Mukesh Kumar Savaliya wrote:
> Currently driver provides geni_se_resources_off() function to turn
> off SE resources like clocks, pinctrl. But we don't have function to
> control clock separately, hence export function geni_se_clks_off()
> to turn off clocks separately without disturbing GPIO.
> 
> The client drivers like i2c requires this function for use case where
> i2c SE is shared between two subsystems.
> 
> Signed-off-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>

Suggest:

Currently the driver provides a function called 
geni_serial_resources_off() to turn off resources like clocks and 
pinctrl. We don't have a function to control clocks separately hence, 
export the function geni_se_clks_off() to turn off clocks separately 
without disturbing GPIO.

Client drivers like I2C require this function for use-cases where the 
I2C SE is shared between two subsystems.

> ---
>   drivers/soc/qcom/qcom-geni-se.c  | 4 +++-
>   include/linux/soc/qcom/geni-se.h | 3 +++
>   2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
> index 2e8f24d5da80..20166c8fc919 100644
> --- a/drivers/soc/qcom/qcom-geni-se.c
> +++ b/drivers/soc/qcom/qcom-geni-se.c
> @@ -1,5 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0
>   // Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
> +// Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
>   
>   /* Disable MMIO tracing to prevent excessive logging of unwanted MMIO traces */
>   #define __DISABLE_TRACE_MMIO__
> @@ -482,13 +483,14 @@ void geni_se_config_packing(struct geni_se *se, int bpw, int pack_words,
>   }
>   EXPORT_SYMBOL_GPL(geni_se_config_packing);
>   
> -static void geni_se_clks_off(struct geni_se *se)
> +void geni_se_clks_off(struct geni_se *se)
>   {
>   	struct geni_wrapper *wrapper = se->wrapper;
>   
>   	clk_disable_unprepare(se->clk);
>   	clk_bulk_disable_unprepare(wrapper->num_clks, wrapper->clks);
>   }
> +EXPORT_SYMBOL_GPL(geni_se_clks_off);
>

Does it make sense to have geni_se_clks_off() exported without having 
geni_se_clks_on() similarly exported ?

Two exported functions already appear to wrapper this functionality for you.

geni_se_resources_off -> gensi_se_clks_off
geni_se_resources_on -> gensi_se_clks_on

Seems like a usage violation to have geni_se_resources_on() switch the 
clocks on but then have something else directly call gensi_se_clks_off() 
without going through geni_se_resources_off();

?

---
bod

