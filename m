Return-Path: <dmaengine+bounces-3801-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A03C49DA19A
	for <lists+dmaengine@lfdr.de>; Wed, 27 Nov 2024 06:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6EE7B21574
	for <lists+dmaengine@lfdr.de>; Wed, 27 Nov 2024 05:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C3D13AD0;
	Wed, 27 Nov 2024 05:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="G19/0yrH"
X-Original-To: dmaengine@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5FF8BE5;
	Wed, 27 Nov 2024 05:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732683761; cv=none; b=ZfISmwUIZbhtd1XfdAVDISAWBUGFZQwBz/E0uRvN/2OgshW0ID4HD4SH8gVkttOp/P9JUo0JSm6lPOE2SHfhhUldoReCVYpuQvdRudPdDd6J+YoAfUO7mOI8XmqKiDbaGMzEvPxhgzmlgllU+8X2S2QoC2dS2bQaojMUqfuxvuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732683761; c=relaxed/simple;
	bh=PCUba8hrz2AA9NubEQaRdf0jbCD7NotGaPijgKo1XJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=K3pihCDg5dco4oSDcmT3bpHxGkse50sYuucOcfN0GPXqS4wJg2+MXkxUe57KCTDzZeK+FJtlUnNip+UQuqCQ7yRMYXWtvs6SsfWZdXBp52tIrcIE3aWdmtTOeWMSzT7SQz0MipXes+1MKMsoxl8ircsaammlpGrfXS8Y/J3uT8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=G19/0yrH; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4AR52Zlo936917
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Nov 2024 23:02:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1732683755;
	bh=Xj+yoYpiOew6cJrj/nwWhzTN0RRt9UoC9Hj9cY5VMZY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=G19/0yrHzgdXzjLKbsaZl42RkxhuNsuHr+QaHGTyTQIhiohwtjER7Sz1JJEacla8Y
	 3DcELM65PGL8HrzfsZXKe2D2Fv0EZjzwkt3MQ1tmIbCN9IFTFzt8ocTpNhnzi84S1u
	 WUv2O8f9a80rPBRd+O6cfSwur6680jX33Runr6LE=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AR52Zbr115521
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 26 Nov 2024 23:02:35 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Nov 2024 23:02:34 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Nov 2024 23:02:34 -0600
Received: from [10.24.69.142] ([10.24.69.142])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AR52UYk050049;
	Tue, 26 Nov 2024 23:02:31 -0600
Message-ID: <3df3d649-b921-49db-a050-ef935b7e9748@ti.com>
Date: Wed, 27 Nov 2024 10:32:30 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: dma: ti: k3-bcdma: Add J722S CSI
 BCDMA
To: Krzysztof Kozlowski <krzk@kernel.org>, <peter.ujfalusi@gmail.com>,
        <vkoul@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>, <j-choudhary@ti.com>,
        <vigneshr@ti.com>
References: <20241126125158.37744-1-vaishnav.a@ti.com>
 <8399720e-2a91-4374-b049-ff1d7e66d83e@kernel.org>
Content-Language: en-US
From: Vaishnav Achath <vaishnav.a@ti.com>
In-Reply-To: <8399720e-2a91-4374-b049-ff1d7e66d83e@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Krzysztof,

On 26/11/24 19:49, Krzysztof Kozlowski wrote:
> On 26/11/2024 13:51, Vaishnav Achath wrote:
>> J722S CSI BCDMA is similar to J721S2 CSI BCDMA and
>> supports both RX and TX channels. Add an entry for
>> J722S CSIRX BCDMA.
> 
> Please wrap commit message according to Linux coding style / submission
> process (neither too early nor over the limit):
> https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597
> 

I will fix this in next revision.

>>
>> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
>> ---
>>
>> V1->V2:
>>    * Address review from Conor to add new J722S compatible
>>    * J722S BCDMA is more similar to J721S2 in terms of RX/TX support,
>>    add an entry alongside J721S2 instead of modifying AM62A.
>>
>> V1: https://lore.kernel.org/all/20241125083914.2934815-1-vaishnav.a@ti.com/
>>
>>   Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
>> index 27b8e1636560..37832c71bd8e 100644
>> --- a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
>> +++ b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
>> @@ -196,7 +196,9 @@ allOf:
>>         properties:
>>           compatible:
>>             contains:
>> -            const: ti,j721s2-dmss-bcdma-csi
>> +            enum:
>> +              - ti,j721s2-dmss-bcdma-csi
>> +              - ti,j722s-dmss-bcdma-csi
> 
> This compatible was never documented. There is no dependency here, no
> cover letter explaining where is this compatible introduced.
> 
> 

This was a mistake from my end, sorry about that, it was supposed to be 
introduced in this patch itself, will fix it in the next revision. Thank 
you for the review.

Thanks and Regards,
Vaishnav

> 
> 
> Best regards,
> Krzysztof

