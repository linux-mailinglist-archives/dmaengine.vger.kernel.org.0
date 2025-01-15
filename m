Return-Path: <dmaengine+bounces-4115-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BBCA118F8
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jan 2025 06:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEF443A8068
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jan 2025 05:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3462120CCD9;
	Wed, 15 Jan 2025 05:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="l0Ttouyz"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AB5156F3B;
	Wed, 15 Jan 2025 05:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736919105; cv=none; b=irC+eGaIOCKmIn7mt1pZAThTFV5EoB2/eLRsYikHFhS92b2e8uw9eXqBwSOQ4zE9sXlH0EP/N5H0Y/yVNMcUTunvVp9g1RFv5tEkV0eA2MKivUIAEs6qby6V+qRrWTXVZZZ0AGlSGekdaWBy41atu9youCIls/LyZGcPhsFXOZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736919105; c=relaxed/simple;
	bh=GyEu2oqZvdBqms2Qa/WvMShjm8d4DSC4x/w9WPzFPQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Z32ToLLeSxNxhW+iprXSetUytAtfBnNUiqhLFCDtuLqfHuynC5qdA4okPXgoGfmLS/75LWjoQRbyAIoODXxUPDSj0iq/mH/WISTHJGquGYeKyHn4/bPhXjzD3pMO5Whr9uy4YSbIApbbIVJB8xXtswdkHQmoBEeSHv53Dl6OGUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=l0Ttouyz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50ELbXMk011377;
	Wed, 15 Jan 2025 05:31:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B61jP3loVVZ7utWkkB9F9jw2gzA3+Gstc+30dnoSlXg=; b=l0TtouyzQ1ZrMKc/
	QtYNO6hBWH9NVnyw4G4/KSIcCbDTwIebuWqxe0ZCcNk29zymiWka402fkeNnDoBB
	55bjmkn/nz5E3Ws3N4NYvnyivXbDha5Yuk5nqIX8EIgXw6pGh/Q9t9DsY1bBoG/z
	DP/QGWMAgK1qznFqQG6ua1NKF+zWbmdv83vr9wvNdD/V/4Ug4FMARpKnMK+qLTZY
	MKNK+ErGxl/SNcMwa7tzTvagYiMwBlKeu4egA+5MFlFDvzIjunaRRrwyrZ4ONlgH
	FiPADXWi9FkubPPiBm/toH/IdFoDTdGqDIvumCbcWBKay22r6TyrvL9LSJ78tF6R
	gzvzxQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44600p0vps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 05:31:35 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50F5VYvm019530
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 05:31:34 GMT
Received: from [10.151.36.43] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 14 Jan
 2025 21:31:29 -0800
Message-ID: <872a4b2e-26e8-1c53-72aa-9fdd02069280@quicinc.com>
Date: Wed, 15 Jan 2025 11:01:26 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 02/12] dmaengine: add DMA_PREP_LOCK and DMA_PREP_UNLOCK
 flag
To: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
        Vinod Koul
	<vkoul@kernel.org>
CC: <corbet@lwn.net>, <thara.gopinath@gmail.com>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <kees@kernel.org>, <dave.jiang@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>,
        <quic_utiwari@quicinc.com>
References: <20241212041639.4109039-1-quic_mdalam@quicinc.com>
 <20241212041639.4109039-3-quic_mdalam@quicinc.com> <Z2qOKHsYpy8kcwlv@vaman>
 <64dca613-5053-46d4-9910-7ac551fdde81@quicinc.com>
Content-Language: en-US
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <64dca613-5053-46d4-9910-7ac551fdde81@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: G4AutCyT6UtTL1ue9XdR8rTcqNbMtxmi
X-Proofpoint-GUID: G4AutCyT6UtTL1ue9XdR8rTcqNbMtxmi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_02,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 phishscore=0 spamscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501150038



On 12/26/2024 5:38 PM, Mukesh Kumar Savaliya wrote:
> 
> 
> On 12/24/2024 4:04 PM, Vinod Koul wrote:
>> On 12-12-24, 09:46, Md Sadre Alam wrote:
>>> Add lock and unlock flag support on command descriptor.
>>> Once lock set in requester pipe, then the bam controller
>>> will lock all others pipe and process the request only
>>> from requester pipe. Unlocking only can be performed from
>>> the same pipe.
>>>
>>> If DMA_PREP_LOCK flag passed in command descriptor then requester
>>> of this transaction wanted to lock the BAM controller for this
>>> transaction so BAM driver should set LOCK bit for the HW descriptor.
>>>
>>> If DMA_PREP_UNLOCK flag passed in command descriptor then requester
>>> of this transaction wanted to unlock the BAM controller.so BAM driver
>>> should set UNLOCK bit for the HW descriptor.
>>>
>>> BAM IP version 1.4.0 and above only supports this LOCK/UNLOCK
>>> feature.
>>>
>>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>>> ---
>>>
>>> Change in [v5]
>>>
>>> * Added DMA_PREP_LOCK and DMA_PREP_UNLOCK flag support
>>>
>>> Change in [v4]
>>>
>>> * This patch was not included in v4
>>>
>>> Change in [v3]
>>>
>>> * This patch was not included in v3
>>>
>>> Change in [v2]
>>>
>>> * This patch was not included in v2
>>> Change in [v1]
>>>
>>> * This patch was not included in v1
>>>
>>>   Documentation/driver-api/dmaengine/provider.rst | 15 +++++++++++++++
>>>   include/linux/dmaengine.h                       |  6 ++++++
>>>   2 files changed, 21 insertions(+)
>>>
>>> diff --git a/Documentation/driver-api/dmaengine/provider.rst 
>>> b/Documentation/driver-api/dmaengine/provider.rst
>>> index 3085f8b460fa..5f30c20f94f3 100644
>>> --- a/Documentation/driver-api/dmaengine/provider.rst
>>> +++ b/Documentation/driver-api/dmaengine/provider.rst
>>> @@ -628,6 +628,21 @@ DMA_CTRL_REUSE
>>>     - This flag is only supported if the channel reports the 
>>> DMA_LOAD_EOT
>>>       capability.
>>> +- DMA_PREP_LOCK
>>> +
>>> +  - If set, the BAM will lock all other pipes not related to the 
>>> current
>>
>> Why BAM, the generic API _cannot_ be implementation specific, make this
>> as a generic one please
>>
> Yes, should be DAM to be generic.
>> Anyone can use this new method and not just BAM...
Will change this in next revision.
>>
>>
>>> +    pipe group, and keep handling the current pipe only.
>>> +
>>> +  - All pipes not within this group will be locked by this pipe upon 
>>> lock
>>> +    event.
>>> +
>>> +  - only pipes which are in the same group and relate to the same 
>>> Environment
>>> +    Execution(EE) will not be locked by a certain pipe.
>>> +
>>> +- DMA_PREP_UNLOCK
>>> +
>>> +  - If set, BAM will release all locked pipes
>>> +
>>>   General Design Notes
>>>   ====================
>>> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
>>> index 346251bf1026..8ebd43a998a7 100644
>>> --- a/include/linux/dmaengine.h
>>> +++ b/include/linux/dmaengine.h
>>> @@ -200,6 +200,10 @@ struct dma_vec {
>>>    *  transaction is marked with DMA_PREP_REPEAT will cause the new 
>>> transaction
>>>    *  to never be processed and stay in the issued queue forever. The 
>>> flag is
>>>    *  ignored if the previous transaction is not a repeated transaction.
>>> + *  @DMA_PREP_LOCK: tell the driver that there is a lock bit set on 
>>> command
>>> + *  descriptor.
>>> + *  @DMA_PREP_UNLOCK: tell the driver that there is a un-lock bit 
>>> set on command
>>> + *  descriptor.
>>>    */
>>>   enum dma_ctrl_flags {
>>>       DMA_PREP_INTERRUPT = (1 << 0),
>>> @@ -212,6 +216,8 @@ enum dma_ctrl_flags {
>>>       DMA_PREP_CMD = (1 << 7),
>>>       DMA_PREP_REPEAT = (1 << 8),
>>>       DMA_PREP_LOAD_EOT = (1 << 9),
>>> +    DMA_PREP_LOCK = (1 << 10),
>>> +    DMA_PREP_UNLOCK = (1 << 11),
>>>   };
>>>   /**
>>> -- 
>>> 2.34.1
>>
> 

