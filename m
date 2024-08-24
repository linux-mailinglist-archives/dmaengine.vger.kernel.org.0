Return-Path: <dmaengine+bounces-2960-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED5F95DC59
	for <lists+dmaengine@lfdr.de>; Sat, 24 Aug 2024 09:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A7BD1F22E24
	for <lists+dmaengine@lfdr.de>; Sat, 24 Aug 2024 07:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5982E15382C;
	Sat, 24 Aug 2024 07:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="k9Rlwo7l"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149A88494;
	Sat, 24 Aug 2024 07:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724483292; cv=none; b=b1bL9DtAlo+T2rtFUps38ZxeYzHMWbtyqzvhCFzPIDOah25LgHyWu2nBTDBl+AjYc2WtB56TdeG/lJLJBlz8KcLVrD0KM4Csx/M2ixsc2ZvgNYpRQJ7o7dZH+3V9Rnwu/Wxoj7FRsxbCUwKTIgQ71KyZPjuHDx2FmBnXNp7SzO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724483292; c=relaxed/simple;
	bh=DkoCS6yzaMAif70tnwMbbb5l+NK99ZHVQqPoEi1OgQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XfxgPA3H80QmLytMhcG7QI8wdMlim/1f0n+Et+X6VpPSTBCDflKgEf4iGiW5LfQRYtgS93/dBiDjjQyoLkbEfNrf/KMkYUdziw51l3490QWmB9l6KLbf9RM4x6J6mg82WzYXywiGt34nW7Sq33r4I2j90ivxIPYRgI/Z0WVdNqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=k9Rlwo7l; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47O5FmQc001748;
	Sat, 24 Aug 2024 07:07:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2rd+L72/2CFrt8wYuXBoN8XYWopoHzR/WLqI5qrlNsk=; b=k9Rlwo7lGl8jE2en
	TAhANfkR4jcWwEMzCuTPgzDAqukVXy9HA1W8B+AnAwwCBNlvzzhA733/DgJMVak8
	TN6CXqdUWP4rMbH5PSKXwCMZZdnIiovB21rB03aJHjhUIz8z16e2P26CcsE2R8wl
	SHqNIebZpl/xSAfHduKB0tylaSPKd/B569c81+e6BdwyTrXKy1BGougogqgglxBS
	FvVvdkdyNAa3tYJsuXmiMopzWeNNphPYQsdPYxHjL+o+Z/oxGzInIwuvvoYfdTLb
	8c2P6QxfPAfpT7FbllzcFANXSMcUvjc6l29p72t6N+jsHJ1qiIHuRmSwVTj2e3IN
	QYrjsw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 417973g3da-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 24 Aug 2024 07:07:51 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47O77nxS029417
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 24 Aug 2024 07:07:49 GMT
Received: from [10.216.42.154] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 24 Aug
 2024 00:07:42 -0700
Message-ID: <5ca16fae-0c28-808b-6b19-c4627c404b96@quicinc.com>
Date: Sat, 24 Aug 2024 12:37:39 +0530
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
 <6365b444-f552-4b13-c73b-00ba04ec1e62@quicinc.com>
 <bf49738a-6979-41f2-a8d3-e36ac634102f@kernel.org>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <bf49738a-6979-41f2-a8d3-e36ac634102f@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pX9xES634WyhaSI0WWqNGLokt-n0FxfM
X-Proofpoint-GUID: pX9xES634WyhaSI0WWqNGLokt-n0FxfM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-24_05,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 impostorscore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 malwarescore=0 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408240039



On 8/23/2024 2:37 PM, Krzysztof Kozlowski wrote:
> On 22/08/2024 13:45, Md Sadre Alam wrote:
>>
>>
>> On 8/22/2024 11:57 AM, Krzysztof Kozlowski wrote:
>>> On 21/08/2024 18:34, Md Sadre Alam wrote:
>>>>
>>>>
>>>> On 8/17/2024 2:38 PM, Krzysztof Kozlowski wrote:
>>>>> On 15/08/2024 10:57, Md Sadre Alam wrote:
>>>>>> BAM having pipe locking mechanism. The Lock and Un-Lock bit
>>>>>> should be set on CMD descriptor only. Upon encountering a
>>>>>> descriptor with Lock bit set, the BAM will lock all other
>>>>>> pipes not related to the current pipe group, and keep
>>>>>> handling the current pipe only until it sees the Un-Lock
>>>>>> set.
>>>>>
>>>>> Please wrap commit message according to Linux coding style / submission
>>>>> process (neither too early nor over the limit):
>>>>> https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597
>>>>      Ok , will update in next patch.
>>>>>
>>>>>>
>>>>>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>>>>>> ---
>>>>>>
>>>>>> Change in [v2]
>>>>>>
>>>>>> * Added initial support for dt-binding
>>>>>>
>>>>>> Change in [v1]
>>>>>>
>>>>>> * This patch was not included in [v1]
>>>>>>
>>>>>>     Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml | 8 ++++++++
>>>>>>     1 file changed, 8 insertions(+)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
>>>>>> index 3ad0d9b1fbc5..91cc2942aa62 100644
>>>>>> --- a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
>>>>>> +++ b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
>>>>>> @@ -77,6 +77,12 @@ properties:
>>>>>>           Indicates that the bam is powered up by a remote processor but must be
>>>>>>           initialized by the local processor.
>>>>>>     
>>>>>> +  qcom,bam_pipe_lock:
>>>>>
>>>>> Please follow DTS coding style.
>>>>      Ok
>>>>>
>>>>>> +    type: boolean
>>>>>> +    description:
>>>>>> +      Indicates that the bam pipe needs locking or not based on client driver
>>>>>> +      sending the LOCK or UNLOK bit set on command descriptor.
>>>>>
>>>>> You described the desired Linux feature or behavior, not the actual
>>>>> hardware. The bindings are about the latter, so instead you need to
>>>>> rephrase the property and its description to match actual hardware
>>>>> capabilities/features/configuration etc.
>>>>      Ok, will update in next patch.
>>>>>
>>>>>> +
>>>>>>       reg:
>>>>>>         maxItems: 1
>>>>>>     
>>>>>> @@ -92,6 +98,8 @@ anyOf:
>>>>>>           - qcom,powered-remotely
>>>>>>       - required:
>>>>>>           - qcom,controlled-remotely
>>>>>> +  - required:
>>>>>> +      - qcom,bam_pipe_lock
>>>>>
>>>>> Why is it here? What do you want to achieve?
>>>>      This property added to achieve locking/unlocking
>>>>      of BAM pipe groups for mutual exclusion of resources
>>>>      that can be used across multiple EE's
>>>
>>> This explains me nothing. I am questioning the anyOf block. Why this is
>>> the fourth method of controlling BAM? Anyway, if it is, then explain
>>> this in commit msg.
>>     This is the BAM property for locking/unlocking the BAM pipes.That's
>>     why I kept in anyOf block.
> 
> You keep repeating the same. It's like poking me with the same comment
> till I agree. I am done with this.
> 
> NAK. Provide proper rationale.
   Sorry, I misunderstood your review comment. Now as Mani suggested will
   keep this implementation in driver itself. Will drop the binding patch
   in next revision.
> 
> Best regards,
> Krzysztof
> 
> 

