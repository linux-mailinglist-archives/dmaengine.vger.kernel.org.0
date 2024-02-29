Return-Path: <dmaengine+bounces-1186-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC84786C602
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 10:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C5BF289A7D
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 09:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBFD627F8;
	Thu, 29 Feb 2024 09:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SRvQcjLs"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C39D627F9
	for <dmaengine@vger.kernel.org>; Thu, 29 Feb 2024 09:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709200198; cv=none; b=X4tVHkjjFhp/oeVSSV6XQreO0Z+fUeGxDfVmFmWSLfnaai0qzFVzcgeJSaEnve2Xp0RDL45XaT6PlDZwny0wV0Rq4mCjIGIRdEbG2dPYxheSkGXXYHv2f64yOg3u9IIF5gEhFbb/MaAkHzHMK6Tb2gEINUzYvPye6T3n5gUKD+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709200198; c=relaxed/simple;
	bh=YQc04LTlvo4O236/tf50vYFPrMePz6Wmbdw/Sbqdtfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hCXVYlfTYbJ8lsXKkijfejVRpOxNmCRLLXMIncid0F4Ya6lD0ck5TIArnMe6Pp2yepgbw4keG4mh5oim2wP5kvPM8itMtTfiz/GnYrAYky5qkt+J61vyc6azHgR9lYi4kDkN63aTXbo69gN/WQaH3cMWUwyU2GxZkQcVlQ32n9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SRvQcjLs; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d269dc3575so6511521fa.1
        for <dmaengine@vger.kernel.org>; Thu, 29 Feb 2024 01:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709200195; x=1709804995; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pi5jl9cezcdpxbE9WQjb4AV/3qiJLkvEpnKJOdWQrpk=;
        b=SRvQcjLsaBePcJZAp3dhPPKXPeJiXiKskRHE5GbvR5J6KK6IAXLqkTwQtg/bduRoT1
         zogFT8cuHL3BIlXjZpiycLerDPqmN7afDTRZBPNPtDN6uYkEFFFgrb6NLLJ1vbCS6DjX
         /uYesNLeWSJhQaqVetf1zL+88jO8RL/MQOv7Ar+z4lnIkkjWhnVml5hepBMs1Wrwbmva
         +qlcboeq92veaAEgbjwQocYUKwPDsurKei8o8QuF8cSs6IeiJeauh05mfj/xR0QxuTX2
         9kzqoP3EZzu1qbLVtCo/r+/oCXRixZ05gSoB8SFeEdwJnrUKAbQzqJ5Y2LnLI5nFi/ds
         qJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709200195; x=1709804995;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pi5jl9cezcdpxbE9WQjb4AV/3qiJLkvEpnKJOdWQrpk=;
        b=tvpOSGGn63HsQlpe5pW2NX4aEodnp8VSzCF7rRv++CxuK/gXTids9rPJWJyPMGl6Ci
         4KQ21ZxMCCU/rfUrLVzas95Q2aQi8J7SZVe3Tob6ySzjjpkknSgR62Y6SDukc2C0OyId
         O90cQxu5qkI8DRHtjNUM3BE/2U+hcZ1g5oUg68I09pO+6t4VPIVMP9Xf/WErvNU/ymMH
         TN8i9AiiMXelfv0hQDJsZKef51qrHnu/a6vIlEmi6q/IFSE0qXs/4AGD3l0U3jBtYNOO
         EhTHXJ0dGo8DAbKPMCDhKQmWgZOZjUe1hu7B89ytvlbEPb/NJnPGVdzOiN0or3XcT0Gd
         h8Ew==
X-Forwarded-Encrypted: i=1; AJvYcCUxVf5Gj86Jvv8Dkj0PMCjd+W8TEcNdAdtqSEmMesgYiPVZBH4zkTu+YOjU/dzHlQm4xxdgCAdiO8ZyepbWnms//TYln8ltSJ7A
X-Gm-Message-State: AOJu0YyU4f9DoGrqs9rnSikyuTimiPIRC1j2hgKtq+KJUS7UezbMR/Up
	AeQbR62Frh2hDLHTVc27YNXG6tlwbkDcCUCMu9J5qsqGfbPq1EPwE5rQ6AZitDQ=
X-Google-Smtp-Source: AGHT+IFH7O/J1Sqs6CDrHXaVDDFk3dxqW3VNmYolyu+a04hSURH26GxNtx6lpxRy+855Y1fMve8jPg==
X-Received: by 2002:a05:651c:8a:b0:2d2:47c7:65a with SMTP id 10-20020a05651c008a00b002d247c7065amr521491ljq.20.1709200195564;
        Thu, 29 Feb 2024 01:49:55 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id x18-20020a2e9dd2000000b002d11d0e37b5sm159862ljj.130.2024.02.29.01.49.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 01:49:55 -0800 (PST)
Message-ID: <bb3b61b6-4f39-4123-be50-0e2c8f07eb99@linaro.org>
Date: Thu, 29 Feb 2024 10:49:43 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] dt-bindings: fsl-dma: fsl-edma: add fsl,imx8ulp-edma
 compatible string
Content-Language: en-US
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>
Cc: imx@lists.linux.dev, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Joy Zou <joy.zou@nxp.com>
References: <20240227-8ulp_edma-v1-0-7fcfe1e265c2@nxp.com>
 <20240227-8ulp_edma-v1-4-7fcfe1e265c2@nxp.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240227-8ulp_edma-v1-4-7fcfe1e265c2@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/02/2024 18:21, Frank Li wrote:
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: fsl,imx8ulp-edma
> +    then:
> +      properties:
> +        clock:
> +          maxItems: 33
> +        clock-names:
> +          items:
> +            - const: dma
> +            - pattern: "^CH[0-31]-clk$"
> +        interrupt-names: false
> +        interrupts:
> +          maxItems: 32
> +        "#dma-cells":
> +          const: 3

Why suddenly fsl,vf610-edma can have from 2 to 33 clocks? Constrain
properly the variants.

Best regards,
Krzysztof


