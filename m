Return-Path: <dmaengine+bounces-1490-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E9A88BABF
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 07:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 908AFB224AF
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 06:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECED112880F;
	Tue, 26 Mar 2024 06:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JiFZVdOc"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFB7823DA
	for <dmaengine@vger.kernel.org>; Tue, 26 Mar 2024 06:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711435851; cv=none; b=tI0U0WfL1qmHpMVUc8qsHo/OGZbbmEeQHFdynSDxb2P7XRbZwON1n1zvL4d0xfCFVaf/vbPM+aAIwBL0VrjA6NAUVORtO/8YCsWduiOEFECBL0x57jVIRVn+3mmsoqypat25uut55AqeJyETlVRwnn5/zVSUtgWk4Hza85WsUcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711435851; c=relaxed/simple;
	bh=+UeqcSIa8j3tiyfU3G25KJScLdmp2Wmms8GGl1R6LGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ofz1Kz1Q++Uc1PHBsjy0V9I6ZC2vTP7q1Iue59yxK1L/Y3bDCfP2B4/J46owmczW6qdLmBOrJJJUqk1rcevBJY06zJSHbw22tt1f+JKYo/0e2X3YkmL6F+YRY7RInHVjc6S7wWirOSF4sYNvEVA42J7Sp08IPDJVj5e27ity96c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JiFZVdOc; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a4751063318so262535166b.0
        for <dmaengine@vger.kernel.org>; Mon, 25 Mar 2024 23:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711435848; x=1712040648; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CcYszJVzk4g1YlTjCZo19PYSJoJO6aoTmeXZSldpIoM=;
        b=JiFZVdOc6IyE8zmeQEwxmaV12EkHEy1EXpNf5hcZQ7lnHK19Ztc4TmmI53ZcF0XkaF
         EYgtv7vbb/bdUQoRZFpokaX/GYcSKoe45uFC/NdB0HxYm4FUbVzR9lwMbfU6AuBcbg3T
         6Q3eEOSUATQXCRRW8v5uErJ/n3pbXggK4iHfOQo0Pg5bBb93aEsX8A9q/BGL2vyiP2t8
         urkYe+m6HXwPPbYO0pQivl7CyIrkHsk36JVmxhkMN4oDmPJvnc+sc53RlLgsfwOai41q
         BOXl4XlUtM/uLodBwhT3CnXfj78MVmYrUKoJjfiX69gUgE77f+Y+T3nQcY/H1F/+McL7
         cz/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711435848; x=1712040648;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CcYszJVzk4g1YlTjCZo19PYSJoJO6aoTmeXZSldpIoM=;
        b=MNTaBHPLRtFsb5NqD7GgQ0X9SG5GvwxuhzIK5rmmRySxZVV3rxQGgtVJbLGWOC6/tL
         /ZjS/jOafdO2Ix3eHiXKnnIG668kEDMYCeH51SfAQwym+RrSqBE7N+712m0Iy7Es3NBk
         WtNzZWkUj076+QYg1oFzIKMxW+ZlTqyqpFjW5pSb08+mUU3Fkgu0eBcDu2x6IyCKOSsb
         HJSRJnwmIT6jotwqh/yUECRdmu1bkMzVmMrxrszwoousOIfOn8Q2hwbnEBjuxpcBKL+X
         1YXxZPy7tCezX5KWfNI1/ZhD1zh7jwkkVPYetm/tTt+H6HaPxSXVyTL/c2Mo1DMnC0rt
         /Skg==
X-Forwarded-Encrypted: i=1; AJvYcCVfu2u0uYchtvK+V8ZSOj0uL/xPJkYnz+PriheP2011VU3bjFnLCLdBUoD88XVETF0hjDJPQUbuc11CfgcB2t71sxoSLoVituey
X-Gm-Message-State: AOJu0YxTST7enTAHQ5sZk2hpOPDXpN4EErrxn7r0QElUaSLdVEm7Av2q
	IhwAqdi1XP+eP/haKEqey1B+JimyXis/el4/ElP4rGEQx9kRy9bQgIESwRXebcI=
X-Google-Smtp-Source: AGHT+IE4HfWUGwxqmUfayIT22jk+nqjwUsI8ApUyR9/HchWuudDay05zuCJfHGFE1BreKgJVEwWcTg==
X-Received: by 2002:a17:906:b257:b0:a47:39c6:8970 with SMTP id ce23-20020a170906b25700b00a4739c68970mr205641ejb.39.1711435847894;
        Mon, 25 Mar 2024 23:50:47 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id h22-20020a1709060f5600b00a473a1fe089sm3867467ejj.1.2024.03.25.23.50.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 23:50:47 -0700 (PDT)
Message-ID: <4a30ce5d-c308-4983-8c7b-d83ced6a9ef1@linaro.org>
Date: Tue, 26 Mar 2024 07:50:45 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] dt-bindings: dmaengine: Add dmamux for
 CV18XX/SG200X series SoC
To: Frank Li <Frank.li@nxp.com>, Inochi Amaoto <inochiama@outlook.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Jisheng Zhang <jszhang@kernel.org>, Liu Gui <kenneth.liu@sophgo.com>,
 Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org,
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <IA1PR20MB4953B500D7451964EE37DA4CBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953E2937788D9D92C91ABBBBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
 <ZgJDCL+aq3ZTE6/1@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZgJDCL+aq3ZTE6/1@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/03/2024 04:37, Frank Li wrote:
> On Tue, Mar 26, 2024 at 09:47:03AM +0800, Inochi Amaoto wrote:
>> The DMA IP of Sophgo CV18XX/SG200X is based on a DW AXI CORE, with
>> an additional channel remap register located in the top system control
>> area. The DMA channel is exclusive to each core.
>>
>> Add the dmamux binding for CV18XX/SG200X series SoC
>>
>> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
>> ---
>>  .../bindings/dma/sophgo,cv1800-dmamux.yaml    | 48 ++++++++++++++++
>>  include/dt-bindings/dma/cv1800-dma.h          | 55 +++++++++++++++++++
> 
> I remember checkpatch.pl require .h have seperate patch.

Why do you insist on that? Bindings header should be with binding.
That's incorrect advice.

Best regards,
Krzysztof


