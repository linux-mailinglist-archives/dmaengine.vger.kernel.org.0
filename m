Return-Path: <dmaengine+bounces-4785-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 607D3A72DF2
	for <lists+dmaengine@lfdr.de>; Thu, 27 Mar 2025 11:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6973177588
	for <lists+dmaengine@lfdr.de>; Thu, 27 Mar 2025 10:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8BB20E6FD;
	Thu, 27 Mar 2025 10:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="A+OARJ6k"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6EA1CEAD3;
	Thu, 27 Mar 2025 10:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743072154; cv=none; b=bvAgAj4EPTNaCC3WAXBGI1yjIFM/LXMpUxsxauVWCe/qruXVOXLIbvyPSOgOk0gseFDxs5nGKDrttyVTDO4JM2mzuOPNsMFQlkQWGC6ILnsxdCoeqtvIXCVJsk6T6jmsOSA8fsyHJvLsoZGXLbdoYITNsv1YrnWs/4ZWyHa7uMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743072154; c=relaxed/simple;
	bh=hrmTr9n86dbxUNsGWxI3celH/c0LE3wIe9sy4nkcpY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VyL+mM2bjYUxLEy17PUclgJsZcMiIRzQSfYL8hn1CdVYFc9A8dS5gKxsBMCqQpv1CcUjCF5oA83pvh/E92l3ibi/F20MAfXVgKMMf6FjhUAC8tnK8eEpVGW1HDHaP3mAYPvZgIgPUUsR14ecY0OkxsJg7+QZTUn8mMXSiqBNfr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=A+OARJ6k; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52R5jE6Q025664;
	Thu, 27 Mar 2025 10:42:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2bTP77VIBbopHVJGLqe8efeqQT69MD8suXLetTu2DhE=; b=A+OARJ6ksdDpk6Sx
	vpdteBGHejzcgR2thqLQcBzy1BKMiB4pJu2BYCKlmz+LYh3eI4nDi+Fwn1SChEZi
	7COAd3yFz2/gHcsgMwv78ROXynIWE2ba2zmKLWX/8NLTdG5hjUpt54R7FuK0wD99
	shX693HUjGW1xrEacQBwTTp9x4FtpwYgJ4SY7DfjKSTAPKA7lnK9G0AB6oDd7DiJ
	gEhbaxiTB6QyTPY8lad6eNBVP7f34Nhg9Avjv7oKNfOqf+F8zEXyUpIhP7LGj4cy
	XwN+5WwDVrxfuw3EqivoHvK3BZFuekNv0xbj7b80n7JHsBZTeddX34LViNk039NV
	9/+2uA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45n0nurtdf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 10:42:15 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52RAgEBf002499
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 10:42:14 GMT
Received: from [10.216.8.158] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 27 Mar
 2025 03:42:09 -0700
Message-ID: <39c6cbef-d84e-8192-ca60-aec26dfbb5e6@quicinc.com>
Date: Thu, 27 Mar 2025 16:12:05 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/6] dt-bindings: mtd: qcom,nandc: Document the SDX75 NAND
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>, <vkoul@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <manivannan.sadhasivam@linaro.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <agross@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>
References: <20250313130918.4238-1-quic_kaushalk@quicinc.com>
 <20250313130918.4238-2-quic_kaushalk@quicinc.com>
 <779c824b-d44c-4613-aebf-05c3327df1ea@kernel.org>
From: Kaushal Kumar <quic_kaushalk@quicinc.com>
In-Reply-To: <779c824b-d44c-4613-aebf-05c3327df1ea@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KOslxf3t1a3aoigFLEmfgAZV5Z_xCHoD
X-Authority-Analysis: v=2.4 cv=AcaxH2XG c=1 sm=1 tr=0 ts=67e52b87 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=P-IC7800AAAA:8 a=COk6AnOGAAAA:8 a=Ffv4d3AQL7PL7ZCmIVIA:9
 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: KOslxf3t1a3aoigFLEmfgAZV5Z_xCHoD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_01,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxlogscore=999
 impostorscore=0 malwarescore=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503270073

On 3/13/2025 8:18 PM, Krzysztof Kozlowski wrote:
> On 13/03/2025 14:09, Kaushal Kumar wrote:
>> Document the QPIC NAND controller v2.1.1 being used in
>> SDX75 SoC and it uses BAM DMA.
> Please wrap commit message according to Linux coding style / submission
> process (neither too early nor over the limit):
> https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597
Sure, will update in v2.
>> SDX75 NAND controller has DMA-coherent and iommu support
>> so define them in the properties section, without which
>> 'dtbs_check' reports the following error:
>>
>>    nand-controller@1cc8000: Unevaluated properties are not
>>    allowed ('dma-coherent', 'iommus' were unexpected)
> That's a new compatible, so how can you have existing errors? Looks not
> related.
It is not an existing error. It is the error that would come unless the 
new properties are updated. Anyhow sorry for the confusion, will remove 
this in v2.
>> Signed-off-by: Kaushal Kumar <quic_kaushalk@quicinc.com>
>> ---
>>   .../devicetree/bindings/mtd/qcom,nandc.yaml   | 23 ++++++++++++++-----
>>   1 file changed, 17 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml b/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
>> index 35b4206ea918..8b77e8837205 100644
>> --- a/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
>> +++ b/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
>> @@ -11,12 +11,17 @@ maintainers:
>>   
>>   properties:
>>     compatible:
>> -    enum:
>> -      - qcom,ipq806x-nand
>> -      - qcom,ipq4019-nand
>> -      - qcom,ipq6018-nand
>> -      - qcom,ipq8074-nand
>> -      - qcom,sdx55-nand
>> +    OneOf:
> Testing patches before sending is still on todo list for Qualcomm :/.
I had run the "make dt_binding_check". Possibly due to my older version 
of dtschema , it did not get caught. After the schema update, now it is 
getting caught. Will update in v2.
>> +      - items:
>> +          - enum:
>> +              - qcom,sdx75-nand
>> +          - const: qcom,sdx55-nand
>> +      - items:
>> +          - const: qcom,ipq806x-nand
>> +          - const: qcom,ipq4019-nand
>> +          - const: qcom,ipq6018-nand
>> +          - const: qcom,ipq8074-nand
>> +          - const: qcom,sdx55-nand
>>   
>>     reg:
>>       maxItems: 1
>> @@ -31,6 +36,12 @@ properties:
>>         - const: core
>>         - const: aon
>>   
>> +  dma-coherent: true
> Which controllers are DMA coherent?
I will add it under a sdx75 check since it is applicable to sdx75 only.
>
>> +
>> +  iommus:
>> +    minItems: 1
>> +    maxItems: 3
> You need to list the items. Why is this flexible?
Agree, this need not be flexible. Will update in v2.
>
>> +
>>     qcom,cmd-crci:
>>       $ref: /schemas/types.yaml#/definitions/uint32
>>       description:
>
> Best regards,
> Krzysztof


