Return-Path: <dmaengine+bounces-3916-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2139E5DFF
	for <lists+dmaengine@lfdr.de>; Thu,  5 Dec 2024 19:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD1F016BB6E
	for <lists+dmaengine@lfdr.de>; Thu,  5 Dec 2024 18:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F31225796;
	Thu,  5 Dec 2024 18:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="G5nZotVw"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DE91922FB;
	Thu,  5 Dec 2024 18:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733422024; cv=none; b=dvdf+2ftzcbhNFk88nmmqAymdAAO/WpA48vHrvqqDfCaW4UHTovCIh8WycXXvDeORAnv6e6lbfVYPd72attd7PDAs0blvYGKuTsgdS5i5Cfl28QRcfB7WYx/nfrhtZTN/RCSUs+WBqMGUWWVJO6ZP+yaiyTIJBOgFObqhcArRGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733422024; c=relaxed/simple;
	bh=NIJKefEChAZWjCm+T+gtGvYLqfucYwGsgdb2WaVMkn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RzkQPQfnGrakir+YtCnn4KrBd1OCHycEmVied3QFHOO51RMJ4UfBzd26N+mns0VHqb9IELXBpDRPur+3KaSGYUN4uBmpsFeAVOapDf4sOjO2bqMqRoKUMjdBPa91uPSi8MBOeZvU0lIsD+/TydPi1cCDJs7HB+2ZtjeWwMEFSUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=G5nZotVw; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5G4HBk019839;
	Thu, 5 Dec 2024 19:06:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	0JnhlkT+86La11TTNlcsIBnITx15puWkRfuAEfVFs/I=; b=G5nZotVwCco3qDt6
	3Cfl9zzcdOOU/Uml9SI6+Fw7T1PoD+tUBhguTxQqOSCFrZl4j6YaIKRFFUSUsiU6
	Z6iGESJ+JSmq9RTT1t3VA0DFwQJ/Tm6hJnSkA69uFFtZMyJqrtuK7FELR3ZTBTrK
	S3s21nK0xDo+JIR2VMGa8d3iOmV8DY445J5iDbsysAGTRpdMXryOLz5RnGT76Ar8
	6seG7FYjzqNSVuXp9r0ifTCCPcdi+nC9M07N/9QOT0Rzif4ecraID5m2AoIhGBS1
	14KhdkgN7fTr44dxms2+AewXh3kKtod4nNUch5Ho3mf5FBvTX1vRFu9/CPIl0cGW
	ZAkXGQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 437rq9gssg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 19:06:40 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 69D6840049;
	Thu,  5 Dec 2024 19:05:36 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 52D9D267F27;
	Thu,  5 Dec 2024 19:04:41 +0100 (CET)
Received: from [10.252.15.31] (10.252.15.31) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 5 Dec
 2024 19:04:40 +0100
Message-ID: <bdfeceb6-962a-4f20-b76c-4fe5e5ff80c3@foss.st.com>
Date: Thu, 5 Dec 2024 19:04:39 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] dt-bindings: dma: st-stm32-dmamux: Add description for
 dma-cell values
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Ken Sloat
	<ksloat@cornersoftsolutions.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <dmaengine@vger.kernel.org>, <alexandre.torgue@foss.st.com>,
        <mcoquelin.stm32@gmail.com>, <conor+dt@kernel.org>,
        <krzk+dt@kernel.org>, <robh@kernel.org>, <vkoul@kernel.org>
References: <CADRqkYAaCYvo3ybGdKO1F_y9jFEcwTBxZzRN-Av-adq_4fVu6g@mail.gmail.com>
 <d53538ea-f846-4a6a-bc14-22ec7ee57e53@kernel.org>
 <CADRqkYDnDNL_H2CzxjsPOdM++iYp-9Ak3PVFBw2qcjR_M=GeBA@mail.gmail.com>
 <28d1bb46-ab18-42da-9ca2-ff498c888d66@kernel.org>
Content-Language: en-US
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
In-Reply-To: <28d1bb46-ab18-42da-9ca2-ff498c888d66@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01


On 12/5/24 17:09, Krzysztof Kozlowski wrote:
> On 05/12/2024 17:07, Ken Sloat wrote:
>>>> + 1. The mux input number/line for the request
>>>> + 2. Bitfield representing DMA channel configuration that is passed
>>>> + to the real DMA controller
>>>> + 3. Bitfield representing device dependent DMA features passed to
>>>> + the real DMA controller
>>>> +
>>>> + For bitfield definitions of cells 2 and 3, see the associated
>>>> + bindings doc for the actual DMA controller the mux is connected
>>>
>>> This does not sound right. This is the binding for DMA controller, so
>>> you are saying "please look at itself". I suggest to drop this as well.
>>>
>>
>> While logically it is the DMA controller, this doc is specifically for
>> the mux - the DMA controller has its own driver and binding docs in
>> Documentation/devicetree/bindings/dma/stm32/st,stm32-dma.yaml
>>
>> I can reference st,stm32-dma.yaml directly, but I was unsure if this
>> mux IP was used with another DMA controller from ST on a different
>> SoC.
>>
>> What do you suggest here?
> 
> Thanks for explanation, I think it is fine.
> 
> Best regards,
> Krzysztof

This description was lost when STM32 DMAMUX binding txt file was 
converted to yaml:
0b7c446fa9f7 ("dt-bindings: dma: Convert stm32 DMAMUX bindings to 
json-schema")

-- #dma-cells:	Should be set to <3>.
-		First parameter is request line number.
-		Second is DMA channel configuration
-		Third is Fifo threshold
-		For more details about the three cells, please see
-		stm32-dma.txt documentation binding file


stm32-dmamux exclusively muxes stm32-dma channels. It is not used with 
other ST DMA controllers (STM32 MDMA, STM32 DMA3).

So it is fine to refer to st,stm32-dma.yaml.

Regards,
Amelie

