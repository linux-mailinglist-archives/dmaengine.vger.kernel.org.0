Return-Path: <dmaengine+bounces-4076-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 859039FCAD4
	for <lists+dmaengine@lfdr.de>; Thu, 26 Dec 2024 13:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E192A1620A1
	for <lists+dmaengine@lfdr.de>; Thu, 26 Dec 2024 12:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106361D1F6B;
	Thu, 26 Dec 2024 12:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NUqZRKcW"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7730F14D6E1;
	Thu, 26 Dec 2024 12:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735214956; cv=none; b=BKEYzA0+b7WoMqJz3e3zDT7PSdRipL6Qbb79qpbY0fmzaIG5YoBL1HWQFx1RRCR5JZc/aEoxjh7CYucS0arf3du/T6OT86wM1E3BX5OwNfDK9Lnx31u3Gyt5Nrc1Y1bJG4/jr1G52bl8sb0fKArq6Rr0KGbiSdW+Nhvch/zqOvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735214956; c=relaxed/simple;
	bh=VP+LKszyHuqeOFVhE+sNqmJHnc/bVqk8JrwHcKe2mKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LWLhspljTSk4JpUsgmSy/e9VWJ/3N/RlefrxzSh5fpWKj1F7V8ElatOxGvySkVUGBVc96vGNFSUqemc0mbqPGQDUpRiQczlB0RmXqpIJu7dzbe8Fqg9EL2Mh8epkxC3tenJ5hR+0QEnr54DKMf95COV1sPFrxder8S7OqyStpmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NUqZRKcW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BQ88e3i010707;
	Thu, 26 Dec 2024 12:09:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ecXAdKEmWV4vHjQwBIoWND+NxaUKVlnNIUvCnpHIA+E=; b=NUqZRKcWnCTWdEoq
	EeZampBD3UOlMeJXJsUvZC914IW18tu0UO6NYzcnXhXysXRZEGdlCker0sVFn+uU
	zI8NMIR0IrzXIBPI40FJUgkV348jqcCwadLyHvEG0r+CgPxFYuigmtOnuySmLsxr
	RqMBCVgKF2M1bcNdiW5O7NmpsUqYF1LlJAldHcMatfudN8RLUl/1j/hBd9vx5+5D
	/F9ttoVnrRsPE61zKWyD3AqRcvXoS9S+oZi/3rDASOFkczdUM2gESoHl1Qv7WN5g
	viNmsLvZaj8Cpmo4ydUsL9u438dWwvhxNUAcyKsXCewrwdI3gpeqo4ChBPFOMWJn
	Z6aJJg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43s3cf9g8t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Dec 2024 12:09:07 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BQC96OB029057
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Dec 2024 12:09:06 GMT
Received: from [10.216.14.233] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 26 Dec
 2024 04:09:00 -0800
Message-ID: <64dca613-5053-46d4-9910-7ac551fdde81@quicinc.com>
Date: Thu, 26 Dec 2024 17:38:54 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/12] dmaengine: add DMA_PREP_LOCK and DMA_PREP_UNLOCK
 flag
To: Vinod Koul <vkoul@kernel.org>, Md Sadre Alam <quic_mdalam@quicinc.com>
CC: <corbet@lwn.net>, <thara.gopinath@gmail.com>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <kees@kernel.org>, <dave.jiang@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>,
        <quic_utiwari@quicinc.com>
References: <20241212041639.4109039-1-quic_mdalam@quicinc.com>
 <20241212041639.4109039-3-quic_mdalam@quicinc.com> <Z2qOKHsYpy8kcwlv@vaman>
Content-Language: en-US
From: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
In-Reply-To: <Z2qOKHsYpy8kcwlv@vaman>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fHDeyTMIbZvrE8sxHSBCb2kBjVrGhPE_
X-Proofpoint-ORIG-GUID: fHDeyTMIbZvrE8sxHSBCb2kBjVrGhPE_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 clxscore=1011 bulkscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412260108



On 12/24/2024 4:04 PM, Vinod Koul wrote:
> On 12-12-24, 09:46, Md Sadre Alam wrote:
>> Add lock and unlock flag support on command descriptor.
>> Once lock set in requester pipe, then the bam controller
>> will lock all others pipe and process the request only
>> from requester pipe. Unlocking only can be performed from
>> the same pipe.
>>
>> If DMA_PREP_LOCK flag passed in command descriptor then requester
>> of this transaction wanted to lock the BAM controller for this
>> transaction so BAM driver should set LOCK bit for the HW descriptor.
>>
>> If DMA_PREP_UNLOCK flag passed in command descriptor then requester
>> of this transaction wanted to unlock the BAM controller.so BAM driver
>> should set UNLOCK bit for the HW descriptor.
>>
>> BAM IP version 1.4.0 and above only supports this LOCK/UNLOCK
>> feature.
>>
>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>> ---
>>
>> Change in [v5]
>>
>> * Added DMA_PREP_LOCK and DMA_PREP_UNLOCK flag support
>>
>> Change in [v4]
>>
>> * This patch was not included in v4
>>
>> Change in [v3]
>>
>> * This patch was not included in v3
>>
>> Change in [v2]
>>
>> * This patch was not included in v2
>>   
>> Change in [v1]
>>
>> * This patch was not included in v1
>>
>>   Documentation/driver-api/dmaengine/provider.rst | 15 +++++++++++++++
>>   include/linux/dmaengine.h                       |  6 ++++++
>>   2 files changed, 21 insertions(+)
>>
>> diff --git a/Documentation/driver-api/dmaengine/provider.rst b/Documentation/driver-api/dmaengine/provider.rst
>> index 3085f8b460fa..5f30c20f94f3 100644
>> --- a/Documentation/driver-api/dmaengine/provider.rst
>> +++ b/Documentation/driver-api/dmaengine/provider.rst
>> @@ -628,6 +628,21 @@ DMA_CTRL_REUSE
>>     - This flag is only supported if the channel reports the DMA_LOAD_EOT
>>       capability.
>>   
>> +- DMA_PREP_LOCK
>> +
>> +  - If set, the BAM will lock all other pipes not related to the current
> 
> Why BAM, the generic API _cannot_ be implementation specific, make this
> as a generic one please
> 
Yes, should be DAM to be generic.
> Anyone can use this new method and not just BAM...
> 
> 
>> +    pipe group, and keep handling the current pipe only.
>> +
>> +  - All pipes not within this group will be locked by this pipe upon lock
>> +    event.
>> +
>> +  - only pipes which are in the same group and relate to the same Environment
>> +    Execution(EE) will not be locked by a certain pipe.
>> +
>> +- DMA_PREP_UNLOCK
>> +
>> +  - If set, BAM will release all locked pipes
>> +
>>   General Design Notes
>>   ====================
>>   
>> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
>> index 346251bf1026..8ebd43a998a7 100644
>> --- a/include/linux/dmaengine.h
>> +++ b/include/linux/dmaengine.h
>> @@ -200,6 +200,10 @@ struct dma_vec {
>>    *  transaction is marked with DMA_PREP_REPEAT will cause the new transaction
>>    *  to never be processed and stay in the issued queue forever. The flag is
>>    *  ignored if the previous transaction is not a repeated transaction.
>> + *  @DMA_PREP_LOCK: tell the driver that there is a lock bit set on command
>> + *  descriptor.
>> + *  @DMA_PREP_UNLOCK: tell the driver that there is a un-lock bit set on command
>> + *  descriptor.
>>    */
>>   enum dma_ctrl_flags {
>>   	DMA_PREP_INTERRUPT = (1 << 0),
>> @@ -212,6 +216,8 @@ enum dma_ctrl_flags {
>>   	DMA_PREP_CMD = (1 << 7),
>>   	DMA_PREP_REPEAT = (1 << 8),
>>   	DMA_PREP_LOAD_EOT = (1 << 9),
>> +	DMA_PREP_LOCK = (1 << 10),
>> +	DMA_PREP_UNLOCK = (1 << 11),
>>   };
>>   
>>   /**
>> -- 
>> 2.34.1
> 


