Return-Path: <dmaengine+bounces-2934-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9D795B446
	for <lists+dmaengine@lfdr.de>; Thu, 22 Aug 2024 13:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6CDF284EDC
	for <lists+dmaengine@lfdr.de>; Thu, 22 Aug 2024 11:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8591C93CE;
	Thu, 22 Aug 2024 11:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QCcrmN/l"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7F81AB514;
	Thu, 22 Aug 2024 11:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724327494; cv=none; b=G3aXIJaG/kQvIT7u0PvWPElPfqdLy6zy7j87i1ZChL31fSzlp9xEm3GadLu0w5RYz+KsRytgH31RkSgQoZP7DGnfo5cAzqKbNHbNNV5aWDRqOrW3aIH7TCsZ+c0niCmWFCC8v1SbEILJ5kcAQXvQd5JN1RsI4YMyANDFqDECsIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724327494; c=relaxed/simple;
	bh=OC/2onS7BuHn8+8AOM+P2syLpYkAd2f1CT1DErhWLHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PL1WdEhlY2mDvSa4pOZzqXLe7EZnP2CiWdKm80cfxRdLO9Dm2g4c18Q18cmerkpy6cAr258tUXYOiZZx/4fem39nPRJGM4if5hgjSohFoGCLOksQlFRfToWq1QxKVvi13RgnFX01VTrQHypr2p8z4RA7i4SRTF4P4OnmwOneghM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QCcrmN/l; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47MAOJaX001725;
	Thu, 22 Aug 2024 11:46:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6UbGdF+C67OhIMspQo6RFBnUxUYJFpjLS5akkaxqhYU=; b=QCcrmN/lU/5sZGVO
	EkV2JJfyUXSncUNlRTAMwtZmGrmBlx9iTR5PGV52YR87Goot1xERDWWmXVuBOgu1
	esbSonQIbqJL/rh+c3wrgoAZuYZBqlVBPBkKLABMJR/VZRLJJ9xPsMxupTOi/KJo
	2uvoyvkiMcAeMy2yIZBppR8pLEF74GvJjIFbGZvVcpp+Ocjsexd3hvnatk3hgpfU
	FNxe/Y9TqHdthNOchTuuaKdwjtSTzhmdjYN7tyctAYI4yMx/Q2WQGgV6c1CpjE9G
	4+cOgFH4TTRiU77bNkwUBKfRWLzSbqG84vvoem5xnGGJb7356sL/5PibI3MDEtvl
	L9IdBw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 414pdmyy3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Aug 2024 11:46:18 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47MBkH7G024122
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Aug 2024 11:46:17 GMT
Received: from [10.216.59.247] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 22 Aug
 2024 04:46:09 -0700
Message-ID: <6365b444-f552-4b13-c73b-00ba04ec1e62@quicinc.com>
Date: Thu, 22 Aug 2024 17:15:53 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 01/16] dt-bindings: dma: qcom,bam: Add bam pipe lock
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>, <vkoul@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <konradybcio@kernel.org>,
        <thara.gopinath@gmail.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <gustavoars@kernel.org>,
        <u.kleine-koenig@pengutronix.de>, <kees@kernel.org>,
        <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>,
        <quic_utiwari@quicinc.com>
References: <20240815085725.2740390-1-quic_mdalam@quicinc.com>
 <20240815085725.2740390-2-quic_mdalam@quicinc.com>
 <0a2b884b-bd28-428e-be12-8fef4fdfd278@kernel.org>
 <c8b7c2f0-9de1-1787-2f1b-2aa0102f347c@quicinc.com>
 <c2292ef2-e93e-4ca3-bcd3-542bd27526ad@kernel.org>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <c2292ef2-e93e-4ca3-bcd3-542bd27526ad@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: uRzuvOQX7Pb4PoW0Sp1lJHLY9ec_o9XB
X-Proofpoint-GUID: uRzuvOQX7Pb4PoW0Sp1lJHLY9ec_o9XB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-22_03,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408220088



On 8/22/2024 11:57 AM, Krzysztof Kozlowski wrote:
> On 21/08/2024 18:34, Md Sadre Alam wrote:
>>
>>
>> On 8/17/2024 2:38 PM, Krzysztof Kozlowski wrote:
>>> On 15/08/2024 10:57, Md Sadre Alam wrote:
>>>> BAM having pipe locking mechanism. The Lock and Un-Lock bit
>>>> should be set on CMD descriptor only. Upon encountering a
>>>> descriptor with Lock bit set, the BAM will lock all other
>>>> pipes not related to the current pipe group, and keep
>>>> handling the current pipe only until it sees the Un-Lock
>>>> set.
>>>
>>> Please wrap commit message according to Linux coding style / submission
>>> process (neither too early nor over the limit):
>>> https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597
>>     Ok , will update in next patch.
>>>
>>>>
>>>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>>>> ---
>>>>
>>>> Change in [v2]
>>>>
>>>> * Added initial support for dt-binding
>>>>
>>>> Change in [v1]
>>>>
>>>> * This patch was not included in [v1]
>>>>
>>>>    Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml | 8 ++++++++
>>>>    1 file changed, 8 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
>>>> index 3ad0d9b1fbc5..91cc2942aa62 100644
>>>> --- a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
>>>> +++ b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
>>>> @@ -77,6 +77,12 @@ properties:
>>>>          Indicates that the bam is powered up by a remote processor but must be
>>>>          initialized by the local processor.
>>>>    
>>>> +  qcom,bam_pipe_lock:
>>>
>>> Please follow DTS coding style.
>>     Ok
>>>
>>>> +    type: boolean
>>>> +    description:
>>>> +      Indicates that the bam pipe needs locking or not based on client driver
>>>> +      sending the LOCK or UNLOK bit set on command descriptor.
>>>
>>> You described the desired Linux feature or behavior, not the actual
>>> hardware. The bindings are about the latter, so instead you need to
>>> rephrase the property and its description to match actual hardware
>>> capabilities/features/configuration etc.
>>     Ok, will update in next patch.
>>>
>>>> +
>>>>      reg:
>>>>        maxItems: 1
>>>>    
>>>> @@ -92,6 +98,8 @@ anyOf:
>>>>          - qcom,powered-remotely
>>>>      - required:
>>>>          - qcom,controlled-remotely
>>>> +  - required:
>>>> +      - qcom,bam_pipe_lock
>>>
>>> Why is it here? What do you want to achieve?
>>     This property added to achieve locking/unlocking
>>     of BAM pipe groups for mutual exclusion of resources
>>     that can be used across multiple EE's
> 
> This explains me nothing. I am questioning the anyOf block. Why this is
> the fourth method of controlling BAM? Anyway, if it is, then explain
> this in commit msg.
   This is the BAM property for locking/unlocking the BAM pipes.That's
   why I kept in anyOf block.
   Will explain in commit message in next patch.
> 
> Best regards,
> Krzysztof
> 

