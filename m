Return-Path: <dmaengine+bounces-3333-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D1E99A038
	for <lists+dmaengine@lfdr.de>; Fri, 11 Oct 2024 11:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18BF81F21694
	for <lists+dmaengine@lfdr.de>; Fri, 11 Oct 2024 09:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1758520C465;
	Fri, 11 Oct 2024 09:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="KD7Py/Jc"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC8E20ADDF;
	Fri, 11 Oct 2024 09:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728639289; cv=none; b=arklpZ2PLaZAJa/mm1LJpBVzXw7/DSCdpMkmX90xjZ7ohUs/MxD4Rst9tUMJUaPIA31Un+ySWa5beAARRq8Qzl6ZIKG2X8bZK9gXt3r8qt9ehoT/cVnHq8pDCbyfmF8YRsDNNwzwCwWIJ9gyc/kRiu/hZkbTsbyIhD0xHAwHQD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728639289; c=relaxed/simple;
	bh=Gl6dPLjRLbSic9EmZnmscq1zMg/4Htr1XPejk/OM3k8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CJGTMr9KTg27kslW3j4MhkPWxC93eqp3daUhMmKzFwPtct+99LXtcoI7gI4+eosD4sPFUMlZhn3YSBae0+iiT2PNNRWX4JsvONx4rHRGiNcHExesaRJWOpxV0ONZbp/j/nBK0R8wtPPEXZK2+Y+RHI8mG1Er16zqF5/8jurXA3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=KD7Py/Jc; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49B7jxoS016451;
	Fri, 11 Oct 2024 11:34:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	Cx8wCvxmonPkb1ieC6lKwP2pVMjk4uOgdXPQfU8JtJo=; b=KD7Py/Jcqjd1pUHD
	2TCjoUJ0n/G1MuPfk/dhYKv1031rual8A0sF+d4EuwfLW1tqnYRmRAQxl/hNap5+
	XdRvOMQlD8UPeauFIVc3ZyYy1BWj1a52Lekel5NrS73Gv2q5wBUUy6A01nOi9X9+
	8y4l+irexXIUCpKxRnqxQ3CJmthQrk3lHEmnSHft6KIy+De/LBWdVhHl7Yh0FdJ5
	SkUbE0Xm0/1z+Hx8TWnhVTs9PYkP+L6gPglTtJG9x9HLaZ9WK40wxTfkYMIyeaK+
	KYO0MRx2BbTMh59+O2j0OQTAIvgP77/M90Jlhf2LgCYWXDD2p/tuEDn2Wf2VxIM1
	ZICQJg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 425w9xh02c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Oct 2024 11:34:25 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 299014005C;
	Fri, 11 Oct 2024 11:27:58 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B0A5D26D085;
	Fri, 11 Oct 2024 11:12:28 +0200 (CEST)
Received: from [10.48.87.35] (10.48.87.35) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 11 Oct
 2024 11:12:28 +0200
Message-ID: <20394a61-72b8-4d92-ac35-201368035bde@foss.st.com>
Date: Fri, 11 Oct 2024 11:12:27 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] dt-bindings: dma: stm32-dma3: introduce
 st,axi-max-burst-len property
To: Rob Herring <robh@kernel.org>
CC: Vinod Koul <vkoul@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <dmaengine@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20241010-dma3-mp25-updates-v1-0-adf0633981ea@foss.st.com>
 <20241010-dma3-mp25-updates-v1-6-adf0633981ea@foss.st.com>
 <20241010181645.GA2121939-robh@kernel.org>
Content-Language: en-US
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
In-Reply-To: <20241010181645.GA2121939-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01



On 10/10/24 20:16, Rob Herring wrote:
> On Thu, Oct 10, 2024 at 04:27:56PM +0200, Amelie Delaunay wrote:
>> DMA3 maximum burst length (in unit of beat) may be restricted depending
>> on bus interconnect.
>>
>> As mentionned in STM32MP2 reference manual [1], "the maximum allowed AXI
>> burst length is 16. The user must set [S|D]BL_1 lower or equal to 15
>> if the Source/Destination allocated port is AXI (if [S|D]AP=0)".
> 
> This should be implied by the SoC specific compatible.
> 

I took an example from snps,dw-axi-dmac.yaml (snps,axi-max-burst-len). 
But I agree, it will be implied by st,stm32mp25-dma3 compatible in V2.
Patch 8/11 will then be dropped.

Regards,
Amelie

>>
>> Introduce st,axi-max-burst-len. If used, it will clamp the burst length
>> to that value if AXI port is used, if not, the maximum burst length value
>> supported by DMA3 is used.
>>
>> [1] https://www.st.com/resource/en/reference_manual/rm0457-stm32mp2325xx-advanced-armbased-3264bit-mpus-stmicroelectronics.pdf
>>
>> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
>> ---
>>   .../devicetree/bindings/dma/stm32/st,stm32-dma3.yaml          | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml b/Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml
>> index 38c30271f732e0c8da48199a224a88bb647eeca7..90ad70bb24eb790afe72bf2085478fa4cec60b94 100644
>> --- a/Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml
>> +++ b/Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml
>> @@ -51,6 +51,16 @@ properties:
>>     power-domains:
>>       maxItems: 1
>>   
>> +  st,axi-max-burst-len:
>> +    description: |
>> +      Restrict AXI burst length in unit of beat by value specified in this property.
>> +      The value specified in this property is clamped to the maximum burst length supported by DMA3.
>> +      If this property is missing, the maximum burst length supported by DMA3 is used.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    minimum: 1
>> +    maximum: 256
>> +    default: 64
>> +
>>     "#dma-cells":
>>       const: 3
>>       description: |
>> @@ -137,5 +147,6 @@ examples:
>>                      <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
>>         clocks = <&rcc CK_BUS_HPDMA1>;
>>         #dma-cells = <3>;
>> +      st,axi-max-burst-len = <16>;
>>       };
>>   ...
>>
>> -- 
>> 2.25.1
>>

