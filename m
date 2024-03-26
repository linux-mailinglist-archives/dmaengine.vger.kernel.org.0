Return-Path: <dmaengine+bounces-1492-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB2088BAD3
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 07:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC8C41F3A48E
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 06:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD3F129A65;
	Tue, 26 Mar 2024 06:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wKAHJLFk"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA841272BB
	for <dmaengine@vger.kernel.org>; Tue, 26 Mar 2024 06:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711436270; cv=none; b=Dc8rQD25ik4MTNnZueG5qcqqSYJNVyJxNjmgHiOtmvvPDPBWFMYycM4Sw9zr0RsUWx33VYRQBx7BrsyHU+zducWA2b4LZMZlV8xgcT9X/wARg8HCQ5YDW+jkX6zn+2zMboL3LDqTm8Hhk74QdHDtZn9Lihdr14jM25/nBmnHsy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711436270; c=relaxed/simple;
	bh=55SdADad3OWx3kkVp1dRRhODKeeVTToOTYqoi+1XBlQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hioMxFbU1wcdzIH15FQ2aM3juBSlFh3Dmj3m6zLapodPfPhDs35GkvFqKEeDLhScwzQzgd2zDboq0ub3lzBOSazLbfbXwGm3MCH5BHC9yhXkdebs921UErQVI2lV+wR+niY/I5zUDamtT1I5OglUasriLY9C4kae2YczQZFF/zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wKAHJLFk; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a46de423039so294820066b.0
        for <dmaengine@vger.kernel.org>; Mon, 25 Mar 2024 23:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711436267; x=1712041067; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=b92irMn46EzcW/AtEokxK5lcxIlhufDIe6kzdSmDcBA=;
        b=wKAHJLFkMT5VwVK36wL6jdpr6IUx2ionustJ6jtq4JDNyHwSM86WfXtgY34peUChzV
         qqJnI3DdccvGwXE56f2TxXEOBbErCJvDGu1ZjFOeJUb1/SUJf78TmxOjNjF9MxAtiRLp
         NGhaMDEwoovbn8ww6aXJoOt0qMXYiIaCiP3aNrbQKY0hnIcRyJntkP18AUINcXsEc+Ig
         mMTiO2t1KnJW31GqRM7pVx93/U4lQylCabWPX6G3+kLUHC068VUBkC7I81FW+xbUcodZ
         xV8ctLCFQBcDPGSpexNexISO6nNJywOcFPFgl+zMhRSMHZjWcA/4cYddLeiOpiCqrSzO
         NRYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711436267; x=1712041067;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b92irMn46EzcW/AtEokxK5lcxIlhufDIe6kzdSmDcBA=;
        b=j9szFmCAJpdRSTz1UYxdsLIDDUK//8h4sl2uyXNhnooqV48ft1CJOOIpeXCetvr/I2
         839FD4gYRFNeACWOvRH06pDcD7suQgDdgfSCQK3FDlAgJLTIQdWubcecvT+E+E7176h4
         Q55Z62gyMDNlHhXorby/KM2mXMLLArsIwnYGIovjhdKg6zk53PrUWgU4TVqQsyHwz1JU
         lIHFy/ZGbyOnFHA6DDCd4awixLLIRH8pcTV9Uj533LfjxFjRzHeJhrZ9EKqIBPPMpo+M
         2b3bvFJqCiYgKvSml+Vg5bkJHmiqY/vLGXUixJfC9Z2+NjfxXnd9zpCoFs/XBtcb6ell
         DR4g==
X-Forwarded-Encrypted: i=1; AJvYcCWSxlBslkMw20De3WXmoSSdqHGTJA44RhPFMNOM36w6D/WmayOJLynhmr7nGBOxdcU193nZy+Exq0+9OlhO5vTODm6Wa4ertVF8
X-Gm-Message-State: AOJu0Yzu4lZ1gke2ofBSVshYmro9onAxgrc6K3Gjlc63zwD2XDLpCvjA
	q/GmSa4At21vWrhL8a/8z9x1otfYRaLDx+GnThflNOqoxWvsJ59hQueHXUfGLwI=
X-Google-Smtp-Source: AGHT+IF4QhB5PfHfKYdbDK8FmMLQwH5Qj67bD++YkAq6ilfHmf4Dq0FShfdvxJP+bF5RZCDfdLglEA==
X-Received: by 2002:a05:6402:34c6:b0:56b:f54a:8485 with SMTP id w6-20020a05640234c600b0056bf54a8485mr9051599edc.0.1711436267278;
        Mon, 25 Mar 2024 23:57:47 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id r1-20020aa7cb81000000b0056c052f9fafsm2939234edt.53.2024.03.25.23.57.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 23:57:46 -0700 (PDT)
Message-ID: <57398ee0-212c-4c82-bfed-bf38f4faa111@linaro.org>
Date: Tue, 26 Mar 2024 07:57:44 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] dt-bindings: dmaengine: Add dmamux for
 CV18XX/SG200X series SoC
To: Inochi Amaoto <inochiama@outlook.com>, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: Jisheng Zhang <jszhang@kernel.org>, Liu Gui <kenneth.liu@sophgo.com>,
 Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org,
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <IA1PR20MB4953B500D7451964EE37DA4CBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953E2937788D9D92C91ABBBBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <IA1PR20MB4953E2937788D9D92C91ABBBBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/03/2024 02:47, Inochi Amaoto wrote:
> The DMA IP of Sophgo CV18XX/SG200X is based on a DW AXI CORE, with
> an additional channel remap register located in the top system control
> area. The DMA channel is exclusive to each core.
> 
> Add the dmamux binding for CV18XX/SG200X series SoC
> 


> +
> +allOf:
> +  - $ref: dma-router.yaml#
> +
> +properties:
> +  compatible:
> +    const: sophgo,cv1800-dmamux
> +
> +  reg:
> +    items:
> +      - description: DMA channal remapping register
> +      - description: DMA channel interrupt mapping register
> +
> +  '#dma-cells':
> +    const: 2
> +    description:
> +      The first cells is device id. The second one is the cpu id.
> +
> +  dma-masters:
> +    maxItems: 1
> +
> +  dma-requests:
> +    const: 8

If this is const, why do you need it in the DTS in the first place?
compatible defines it.

> +
> +required:
> +  - '#dma-cells'
> +  - dma-masters
> +


I don't understand what happened here. Previously you had a child and I
proposed to properly describe it with $ref.

Now, all children are gone. Binding is supposed to be complete. Based on
your cover letter, this is not complete, but why? What is missing and
why it cannot be added?


> +additionalProperties: false
> +
> +examples:
> +  - |
> +    dma-router {
> +      compatible = "sophgo,cv1800-dmamux";
> +      #dma-cells = <2>;
> +      dma-masters = <&dmac>;
> +      dma-requests = <8>;
> +    };
> diff --git a/include/dt-bindings/dma/cv1800-dma.h b/include/dt-bindings/dma/cv1800-dma.h
> new file mode 100644
> index 000000000000..3ce9dac25259
> --- /dev/null
> +++ b/include/dt-bindings/dma/cv1800-dma.h

Filename should match bindings filename.


Anyway, the problem is that it is a dead header. I don't see it being
used, so it is not a binding.



Best regards,
Krzysztof


