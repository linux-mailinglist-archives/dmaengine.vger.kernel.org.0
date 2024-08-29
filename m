Return-Path: <dmaengine+bounces-3016-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 237909640BE
	for <lists+dmaengine@lfdr.de>; Thu, 29 Aug 2024 11:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEBFF1F21134
	for <lists+dmaengine@lfdr.de>; Thu, 29 Aug 2024 09:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5AD18CBE9;
	Thu, 29 Aug 2024 09:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aaP2wj9l"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5618F156875
	for <dmaengine@vger.kernel.org>; Thu, 29 Aug 2024 09:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724925521; cv=none; b=hSIQlhV4tJ4Sk2u39bvUMn9Ra7RxKDJA+2RZH8x0yU5GDvw7ON7g+KuFoKK57wgHNyJ0Fx5bQMs/FwHFG4jpwkGMcvJ5zFqz/+TTuJd+cX6O4CMmuKpgMsDsTJgT8tcR3t6SZJRBfV9Ds4OGgi9FPxJyFWT+A2PBzHNcvYe89dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724925521; c=relaxed/simple;
	bh=OAo099RXJcbttM63ckMAjAENwVqbF71mee7qDlAjrQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kuaAO2HnXy2pFv6Nmae6Zcv48bwIX7kxL/WWQ2SmJnyCMuKoeQ3yEZKp2QckfKYFSXfYWsezSzv6eY1cyy9/UNThAP7E11CyWWS0O5IcL+j3UYfgfqqDwBbQKakReFB/DrTXWzgELhEZMnvn6yDIyT3FaD9W5Ru7oRx0eNmi4vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aaP2wj9l; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5bef295a429so482424a12.2
        for <dmaengine@vger.kernel.org>; Thu, 29 Aug 2024 02:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724925519; x=1725530319; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hB5SEnRl60z0NnuG/LobG+Z93CxcGtVR0FdulFJjCQw=;
        b=aaP2wj9lkg4xDmDFz8jolfArVo1iqXPo9o3bDaQPT4w6ek2c4N7jRkhN32JNchj+kD
         p/fObeyRtQlYBW7lxhGFOw/broBqq4HjzSSvW/edJHd4Nt0GpLelxw7ICqH/9ggx4ykP
         S6lnwFilQGllP/ETukNfng2JqEdzpctYyETlW6jgCJIykfxi+hFqAjpTA+Q9kh9BMi9R
         WmZEPbjbnu3WJVH4j6d9YP3382OPHM9iqT5Y0a5VxdsGg6+y7N5ATMcwTC+KR+AqBRDF
         u4ivj8/09BMe8MZLrVGsLBSYfixXRqVJ4MpnmmLddlGsMSIqjFz4zRy6wBh3g+m4Q9gI
         DPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724925519; x=1725530319;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hB5SEnRl60z0NnuG/LobG+Z93CxcGtVR0FdulFJjCQw=;
        b=d/G+dcDjAJjJM0AIQmfaaIiYAVXbtEWRoguCOEEFn3bATIc4x/PztuaXerT6wF2GNu
         n6OVy8o5SBQwJPhMtNB8zWggwlL0v7nim9xwdCtn9Wqs65d0MCwefRjobFrkAF7xGty+
         4zv8uKZVrEA/nE3qGeMFtj2lRGda4GcugyPFkAh1jqRSdAF/+ywxRFxb8WNUgv1wtkEL
         MUFXMpttx/Hc1pdXtyuq7Mzwx3+XGMAcM/Vapm/MaA+HCS7+pMJBcm68fwfdhJWJgwjS
         Zh2mzT+BO0CTYGfoIJSZm4F0Zr8jdfos04mXZtA7HbJedH5oa9TE7qi14a7xhZ545dOa
         KWdg==
X-Forwarded-Encrypted: i=1; AJvYcCXMJ/mbsVO6R27Vj3Jhu3MHwWYceg/eIorLUX/m3/WSRFXGobSQZQRkmTZ9xtG65pqWOLswo1S/40A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY2WgFFgrjywHEKKPzjANCDQ5LdeSUyrwNK0f/khAUuXp6azQz
	dgRsiu7s/bKSe+zPbsu9chtf+BG4KsmR2knfdPVtGbYAPWxlTrJp7nLjPqkKRPc=
X-Google-Smtp-Source: AGHT+IF8NZNIsc9zduAvAlpgIqdyDtgyPeNBb1qX/zoQcMvklLE73xusgkCTnL7uJfNn/WMcnnvozQ==
X-Received: by 2002:a17:907:3daa:b0:a7a:9144:e256 with SMTP id a640c23a62f3a-a897f778b9amr189015766b.6.1724925518633;
        Thu, 29 Aug 2024 02:58:38 -0700 (PDT)
Received: from [192.168.0.25] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988feacd7sm57849466b.34.2024.08.29.02.58.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 02:58:38 -0700 (PDT)
Message-ID: <9af7518c-45e5-44a2-bbb7-19ce7ed899c3@linaro.org>
Date: Thu, 29 Aug 2024 10:58:37 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] dt-bindindgs: i2c: qcom,i2c-geni: Document shared
 flag
To: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
 konrad.dybcio@linaro.org, andersson@kernel.org, andi.shyti@kernel.org,
 linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: quic_vdadhani@quicinc.com
References: <20240829092418.2863659-1-quic_msavaliy@quicinc.com>
 <20240829092418.2863659-2-quic_msavaliy@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240829092418.2863659-2-quic_msavaliy@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/08/2024 10:24, Mukesh Kumar Savaliya wrote:
> Adds qcom,shared-se flag usage. Use this when particular I2C serial
> controller needs to be shared between two subsystems.
> 
> Signed-off-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
> ---
>   Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml b/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
> index 9f66a3bb1f80..ae423127f736 100644
> --- a/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
> +++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
> @@ -60,6 +60,10 @@ properties:
>     power-domains:
>       maxItems: 1
>   
> +  qcom,shared-se:
> +    description: True if I2C needs to be shared between two or more subsystems.
> +    type: boolean
> +
>     reg:
>       maxItems: 1
>   

SE = shared execution ?

---
bod

