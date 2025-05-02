Return-Path: <dmaengine+bounces-5047-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D41D9AA6F8C
	for <lists+dmaengine@lfdr.de>; Fri,  2 May 2025 12:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39A37465D01
	for <lists+dmaengine@lfdr.de>; Fri,  2 May 2025 10:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D3D23C4E4;
	Fri,  2 May 2025 10:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4pfQHOf"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240C9205AB9;
	Fri,  2 May 2025 10:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746181654; cv=none; b=bDu8GucgP2xTiJlJHnfCHQgNOu/zNJM5ThcxQLP62aigz4ATaWESImUjuGW435PPL2hUy4ukrehY6p92oFNN5I6FvLFHi4UGm1ChyH612ZwSgm5F/GvT81QmDJZP99HJwIehV4QXTWUIlfMYdSzgL0MmlzsAxmepAl8zNTHwzaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746181654; c=relaxed/simple;
	bh=xuh/WQteY3swVTua4deDZ/uDNCLp8v2XD3HQD6/BtE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=THW+2BP8fd76jipsx+N78r8sSSBeUF6uo4yCbGXLG2m6oJA+zm8kerBMgRUQ/MXYz0bsR4A6AZeTdY75Gd8CjIvOzswFf2scteA7lCQT5F825ZnV6GtV2fzpCemOOafNQa4m3rxlP9QeR6TQ9mMOLz+A1lOQOdZmbM2YCJYI+90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4pfQHOf; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-736bfa487c3so1772039b3a.1;
        Fri, 02 May 2025 03:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746181652; x=1746786452; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CNSvtlzeetqRmQ7Ywh5GEVTUEx1QnVbPGZ+bGVXhHy8=;
        b=d4pfQHOfzek0y1P46WXU0CTtHx3Xsga3aK4eeVn9vtsOqXgWzjeF/miY3nvpT5ungq
         ObpdgaGXJvGTHG92rUQfBijhI1V//PAEA8ydxk6Mg0n1ZxqIchy3U9VDnNy8SZW21Reg
         rI1QdXYQLtPaIltJiEcjCd1mgJ2yieUV1ucq1qO9sNdFoBDAKkQoGru22rW3n66iqiMC
         8KBnkPlF2z79y9E9oB+BxAT9Fu95XFWO0uFXdgU0OxC6qrZ+yDP25Z+NVT2xe4w29UlX
         a0/7arP1GYsqwsGkq24YIUFGcrN6lIXSByTDKYXuuD97Il1TvxNUkl7CRrDGNXyonzt2
         EpXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746181652; x=1746786452;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CNSvtlzeetqRmQ7Ywh5GEVTUEx1QnVbPGZ+bGVXhHy8=;
        b=kOFMBRut5wJR/7tb7v0x6rgyei6SyWqJrsCFpTxLSQfjQTldssJHCBSmYQYAvs06PS
         amZgZrxP+WetfD8+5Lnc+hkJ4ihC30xFViPdQP3ReqVTuJsJeoZ7sDR/yKxdrJVfphjD
         pMhwxrjCRdmUhUi+gR+AB/TdsWO2maEdq4VdlCHPGDeZCRQZwT+jJI6Qc00p0Ly+kgTy
         Cs0K7NuYupyweYTrY86y5lxooRFHXTTpbFhhsQ8lWVu14TE0qox2gzv8YzmGugQN4Upq
         njUW1xvBjrF8Kf5qw5j44RuZZgmGQavBDtEzOXy3Fl8TLY+FLnxtAxFNjyenu8Axsuyi
         NZWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCvNzWNaKcU5v7+WoTvPMk8U3Q4s2HUIbY3+Z5vwNrRhXIbhJ3vI0VF5y8I333y1mCJPkiLz6apEpK@vger.kernel.org, AJvYcCVP2nxUsl+ZuQ9E818Zs9kOL6gw3EFLRZd5QkipPDfcbTSUuosEe1oF7sVoQ9BEXUABzlOe/qvWsrBYQtKv@vger.kernel.org, AJvYcCWXHiocfWFzHd18ElXH9Z1hfTSBvA9qTKE1zbQnSyqi0QRiqDau+8kKdhI6EFx9soTqRvTENFmLPVNwY5w=@vger.kernel.org, AJvYcCWbuna1HGBbZyh1s0fqYOSZtiwx9iV0CI7VK1emZz0KYIiHmu522Z4JUBRzMXTmCsUB5g8xmSRvo0S3@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6FHhMdMmum64d2QwwM8KOQagR0Oudd2F8nuKxoIMLAMScZ4+2
	awA6QGgsCcLZeo3W8DLmIu4tBT1llVHQKK/ud4/aYcUBcFFhq2d4
X-Gm-Gg: ASbGncuOOoQ3BTOGCkPs2RtcoU3/R+7qaqo5mku1ewG288OpByiHp5EIrYvCNV0iaU4
	CF9wA1IFtdk8lt1yFuU5hBTATWOru7gWa5Nthqt3JZU3w85NLFtJdL4zDoNlQ0djaD3Vq6PdTBd
	DqqQRaYTU34OcJIF2mxgXq9BTbfC0OUZGF03VGIjYKGY8aCkcXUiz0vDmzMEyVb1CK//iEqt5Qx
	jFcpp/0IzqjzPTLNRWFwrKJ7uzi5EDPY1kgdJUV6j9idCduaJN5NnhqPU1OYKxZkdjtUS8OtjSS
	lK9soMMo/fzQ7Dt8PARtVVbIFW19drRtkbn0UcMeevmTZJo0aK5DbILfEtH+gOJ5
X-Google-Smtp-Source: AGHT+IH5mCb+cEBdztEih9506vzOUTqRr88cZ2G3trTZ0ka/+m7/OCK70IqiZJqOrbDvGQvjY/2Wqg==
X-Received: by 2002:a17:90b:2dd2:b0:301:c5cb:7b13 with SMTP id 98e67ed59e1d1-30a4e55f5c3mr3438353a91.3.1746181652132;
        Fri, 02 May 2025 03:27:32 -0700 (PDT)
Received: from [192.168.1.5] ([182.69.11.114])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a347723basm5283950a91.24.2025.05.02.03.27.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 03:27:31 -0700 (PDT)
Message-ID: <a701201e-c888-40e5-a57b-45ea0416af31@gmail.com>
Date: Fri, 2 May 2025 15:57:24 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: dma: convert text based binding to json
 schema
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, dmaengine@vger.kernel.org,
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250501-nvidea-dma-v1-1-a29187f574ba@gmail.com>
 <20250502-lush-resolute-cheetah-a8ceee@kuoka>
Content-Language: en-US
From: Charan Pedumuru <charan.pedumuru@gmail.com>
In-Reply-To: <20250502-lush-resolute-cheetah-a8ceee@kuoka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 02-05-2025 13:28, Krzysztof Kozlowski wrote:
> On Thu, May 01, 2025 at 01:12:36PM GMT, Charan Pedumuru wrote:
>> Update text binding to YAML.
>> Changes during conversion:
>> - Add a fallback for "nvidia,tegra30-apbdma" as it is
>>    compatible with the IP core on "nvidia,tegra20-apbdma".
>> - Update examples and include appropriate file directives to resolve
>>    errors identified by `dt_binding_check` and `dtbs_check`.
>>
> Please use subject prefixes matching the subsystem. You can get them for
> example with 'git log --oneline -- DIRECTORY_OR_FILE' on the directory
> your patch is touching. For bindings, the preferred subjects are
> explained here:
> https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters
>
> Missing final nvidia,tegra20-apbdma prefix.


Sure, will update that accordingly.


>
>
>> Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
>> ---
>>   .../bindings/dma/nvidia,tegra20-apbdma.txt         | 44 -----------
>>   .../bindings/dma/nvidia,tegra20-apbdma.yaml        | 90 ++++++++++++++++++++++
>>   2 files changed, 90 insertions(+), 44 deletions(-)
>>
> ...
>
>> +$id: http://devicetree.org/schemas/dma/nvidia,tegra20-apbdma.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: NVIDIA Tegra APB DMA Controller
>> +
>> +description: |
> Do not need '|' unless you need to preserve formatting.
>
>> +  The NVIDIA Tegra APB DMA controller is a hardware component that
>> +  enables direct memory access (DMA) on Tegra systems. It facilitates
>> +  data transfer between I/O devices and main memory without constant
>> +  CPU intervention.
>> +
>> +maintainers:
>> +  - Jonathan Hunter <jonathanh@nvidia.com>
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - const: nvidia,tegra20-apbdma
>> +      - items:
>> +          - const: nvidia,tegra30-apbdma
>> +          - const: nvidia,tegra20-apbdma
>> +
>> +  "#dma-cells":
>> +    description:
>> +      Must be <1>. This dictates the length of DMA specifiers
>> +      in client node's dmas properties.
> Drop description, you are not telling here anything new except
> explaining basically DT syntax.
>
>> +    const: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  reg:
>> +    maxItems: 1
> reg is the second property. Old binding even had it correct.
>
>> +
>> +  interrupts:
>> +    description:
>> +      Should contain all of the per-channel DMA interrupts in
>> +      ascending order with respect to the DMA channel index.
>> +    minItems: 1
>> +    maxItems: 32
>> +
>> +  resets:
>> +    maxItems: 1
>> +
>> +  reset-names:
>> +    const: dma
>> +
>> +required:
>> +  - compatible
>> +  - reg
> And here the order is correct...
>
>> +  - interrupts
>> +  - clocks
> But here different. Keep the same order as in properties.
>
>> +  - resets
>> +  - reset-names
>> +  - "#dma-cells"
>> +
> missing allOf: to dma-controller


The reason, I didn't include dma-controller is the pattern under 
$nodename in dma-controller is not matching with the pattern present in 
dts files.

So, I excluded it.


>
>> +additionalProperties: false
> unevaluatedProperties instead. Just open any other DMA binding.


sure.


>
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> You included this...


I checked the other DMA binding from nvidia, they included the same 
header file. I can change it to irq.h, if required


>
>> +    #include <dt-bindings/reset/tegra186-reset.h>
>> +    dma@6000a000 {
> Doesn't look like correct name. Schema requires specific name.


The dt_binding_check is successful when I included allOf to 
dma-controller and used dma-controller@600 as node name, but when I was 
checking for dtb, the pattern is not matching with the one

inside dma-controller, so I removed allOf and changed the node name in 
examples according to the node present inside the dts file.


>
>> +        compatible = "nvidia,tegra30-apbdma", "nvidia,tegra20-apbdma";
>> +        reg = <0x6000a000 0x1200>;
>> +        interrupts = <0 136 0x04>,
> ... so use it.
>
> Best regards,
> Krzysztof
>
-- 
Best Regards,
Charan.


