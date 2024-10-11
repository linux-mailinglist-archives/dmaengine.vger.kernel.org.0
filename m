Return-Path: <dmaengine+bounces-3332-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA73E999FB1
	for <lists+dmaengine@lfdr.de>; Fri, 11 Oct 2024 11:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79890287E6F
	for <lists+dmaengine@lfdr.de>; Fri, 11 Oct 2024 09:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5471820C46D;
	Fri, 11 Oct 2024 09:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="3R75dh2+"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F8B20ADE4;
	Fri, 11 Oct 2024 09:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728637415; cv=none; b=X2BowGoxjACNfPmHbYiRjLnK+dkpQg6LScClY8BR6WZnHyPhiGL0Ku2hYlt6V7fXRdZGW6SLE83aGkZblFCwihnRTRRqbR+/ZNUPyan58gtOREEY+zSsCmotrjzF++p5XhvqmN5hbsbssksqGut1jkxVeb7puwVpXZQp0NqPrp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728637415; c=relaxed/simple;
	bh=Ha/AF5v+viIStrFAcTTJyf/v+jRRHbq4Sk/R278Ki44=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iDVyz5xrYKlHH0+sJ4Lkkd1U2krriH3xBQX30SDY1PPFrp3hf9VGS6UCno3+yn1OqNmK1qrMgqsIcupuAjyL3hxnTVdMLpN5yqxVhrAa4Du7mtp9V8OOnocqY4w5dWqjq4IW3f7xcCgArIpWnU4nDH6EOQBdyWjNY2pzKgwqU7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=3R75dh2+; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49B82WQq014668;
	Fri, 11 Oct 2024 11:03:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	W32014r5y3QWUubB7ejNQ9RucL4lQCYgXfxr9DFI93s=; b=3R75dh2+n959fKbq
	+QQvxFOLciVR6SRNVBS4EZ3HqkbkSd6f5qRqAkI/AE2cAf6VyTPtc/OSY1MWLYXX
	CnLrDrcQQVEAiuAoZkOdkvDZnoVv0maRtUVEVZtqWOfICN0N3hqEL9QuC9RYl4af
	L1xZM67augvNz2FbiPvUSf5xZBMAh22MxQ9LmVF71WosnwRyJo/xoCsxQegEDfWN
	gYkt+9cc4qMRlqvEdmfVRWsZi0SLkY1vziFKBt9a2f42sbNE3MBeA3jeQaGebyod
	Ng+KlZQxLGq3bDQTempsZgwiVnb4KCIs+Fv+k+FNaAGEEU5FsMKkfHBEpmCbGUG+
	Enm9ug==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 425w9xgt74-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Oct 2024 11:03:11 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 93C594004B;
	Fri, 11 Oct 2024 11:02:13 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BD55626D0AD;
	Fri, 11 Oct 2024 11:01:33 +0200 (CEST)
Received: from [10.48.87.35] (10.48.87.35) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 11 Oct
 2024 11:01:33 +0200
Message-ID: <3b7b46ca-426c-44a9-b4f2-ce104e0d3b1c@foss.st.com>
Date: Fri, 11 Oct 2024 11:01:32 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] dt-bindings: dma: stm32-dma3: prevent linked-list
 refactoring
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
 <20241010-dma3-mp25-updates-v1-4-adf0633981ea@foss.st.com>
 <20241010181426.GA2107926-robh@kernel.org>
Content-Language: en-US
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
In-Reply-To: <20241010181426.GA2107926-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

On 10/10/24 20:14, Rob Herring wrote:
> On Thu, Oct 10, 2024 at 04:27:54PM +0200, Amelie Delaunay wrote:
>> stm32-dma3 driver refactors the linked-list in order to address the memory
>> with the highest possible data width.
>> It means that it can introduce up to 2 linked-list items. One with a
>> transfer length multiple of channel maximum burst length and so with the
>> highest possible data width. And an extra one with the latest bytes, with
>> lower data width.
>> Some devices (e.g. FMC ECC) don't support having several transfers instead
>> of only one.
>> So add the possibility to prevent linked-list refactoring, by setting bit
>> 17 of the 'DMA transfer requirements' bit mask.
>>
>> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
>> ---
>>   Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml b/Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml
>> index 5484848735f8ac3d2050104bbab1d986e82ba6a7..38c30271f732e0c8da48199a224a88bb647eeca7 100644
>> --- a/Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml
>> +++ b/Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml
>> @@ -99,6 +99,9 @@ properties:
>>           -bit 16: Prevent packing/unpacking mode
>>             0x0: pack/unpack enabled when source data width/burst != destination data width/burst
>>             0x1: memory data width/burst forced to peripheral data width/burst to prevent pack/unpack
>> +        -bit 17: Prevent linked-list refactoring
>> +          0x0: don't prevent driver to refactor the linked-list for optimal performance
>> +          0x1: prevent driver to refactor the linked-list, despite not optimal performance
> 
> Driver settings don't belong in DT. Perhaps reword it in terms of h/w
> constraints (i.e. single transfer limitation).
> 

Thanks for the review and suggestion. I'll reword it in V2. Indeed, it 
is due to single transfer limitation, e.g. for ECC status registers 
transfer.

-bit 17: Prevent additional transfers due to linked-list refactoring
   0x0: don't prevent additional transfers for optimal performance
   0x1: prevent additional transfers to accommodate user constraints 
such as single transfer


Regards,
Amelie

>>   
>>   required:
>>     - compatible
>>
>> -- 
>> 2.25.1
>>

