Return-Path: <dmaengine+bounces-4691-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9515A5B840
	for <lists+dmaengine@lfdr.de>; Tue, 11 Mar 2025 06:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B736170470
	for <lists+dmaengine@lfdr.de>; Tue, 11 Mar 2025 05:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF3D1E5B83;
	Tue, 11 Mar 2025 05:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jg0strsL"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC451CA9C;
	Tue, 11 Mar 2025 05:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741669895; cv=none; b=EBIL/eIznjQb9JG4RLHT96ie3h5GJtLo1EdqQjAg7UEmpXNw0KcR7VnakE82QY7Pm16C95HFOm88PBoSm8QZpLQDpx8AzOTS4BZNYEtYNWVBas3j2mS7BDibxZb5cYvG7oUU/825d/DIKnGuzfXVPN+pN4DsiT3/EneL7kdyCdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741669895; c=relaxed/simple;
	bh=Kxl8j5wpLxgE2DdLVXqlCpYNXctpkEDglr9Hc6XOEHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=t5OMOe4rsdebegVg0/KexrT2mtV4hJzw+AU9+fZkXQ+n4eWJTaq4YVrpPHawPdhE9xAkHrISDenYhJ210kVBs9QXUJItz5iW/816zpQsEpcrOsOvJ/UXICMjcCrx3hIq14mgk+C+vSaR2Ky/NZMNA7qASTBzp1v6DLfpPNO/7pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jg0strsL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52B19sJD007470;
	Tue, 11 Mar 2025 05:11:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	d7xlSAngvWWJyjikNyPYTPL4YbXF3/24fPIj0EaQQ5g=; b=jg0strsLUkyQxlTk
	ZjXG4yDiCKBv2wPpEdhFW65tdvxlyEeUI/IVl5CJpW2lHm6UWlyyvQEqdnUfhgy8
	+ejLo4XmWt/IdFOcGneeHXcu2A9jF8xj9ZzuUN0IeK7SM5KRDw9tISDQCvw3uGxb
	s3TL3twDy9CwwLEtVwYK0uaHhMTlSWWXCbPTjBRi9fWvUPQoGNOZEngZOrb9IP3i
	WTvsNYawCwt2fMqvY2b5AIq/obzWujzKyHYLfhnkrDVJP4tOGCdJ2rwB0sLhU/B9
	HbsPqgZii9asKtNfE43k3I8LYgyhpf6XnjXpxb6ASiWrMA38D/qlm4JjzgF+nJJJ
	Fp9YhA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ab95ggs1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 05:11:21 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52B5BLuK025078
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 05:11:21 GMT
Received: from [10.151.36.43] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 10 Mar
 2025 22:11:16 -0700
Message-ID: <775e7801-c84b-e8a4-032d-1c3b6cb6bf25@quicinc.com>
Date: Tue, 11 Mar 2025 10:41:04 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 02/12] dmaengine: add DMA_PREP_LOCK and DMA_PREP_UNLOCK
 flag
To: Vinod Koul <vkoul@kernel.org>
CC: <corbet@lwn.net>, <thara.gopinath@gmail.com>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <martin.petersen@oracle.com>, <enghua.yu@intel.com>,
        <u.kleine-koenig@baylibre.com>, <dmaengine@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <quic_utiwari@quicinc.com>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.com>
References: <20250115103004.3350561-1-quic_mdalam@quicinc.com>
 <20250115103004.3350561-3-quic_mdalam@quicinc.com> <Z89NMPF9TGmz9Js/@vaman>
Content-Language: en-US
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <Z89NMPF9TGmz9Js/@vaman>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LxT-zZ1a_60qL6PEp8hQtGoVs5zRprSX
X-Authority-Analysis: v=2.4 cv=fvgmZE4f c=1 sm=1 tr=0 ts=67cfc5f9 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=zkCprTptnbEQjy2woTsA:9
 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: LxT-zZ1a_60qL6PEp8hQtGoVs5zRprSX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_01,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503110033



On 3/11/2025 2:06 AM, Vinod Koul wrote:
> On 15-01-25, 15:59, Md Sadre Alam wrote:
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
> 
> Have you aligned internally b/w team at Qualcomm to have this as single
> approach for LOCK implementation. I would like to see ack from
> Mukesh/Bjorn before proceeding ahead with this
I have already discuss this internally with Mukesh and he has posted his 
response here [1]
[1] 
https://lore.kernel.org/all/1566eafb-7286-4f27-922d-0bbaaab8120b@quicinc.com/
> 
>>
>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>> ---
>>
>> Change in [v6]
>>
>> * Change "BAM" to "DAM"
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
>> index 3085f8b460fa..a032e55d0a4f 100644
>> --- a/Documentation/driver-api/dmaengine/provider.rst
>> +++ b/Documentation/driver-api/dmaengine/provider.rst
>> @@ -628,6 +628,21 @@ DMA_CTRL_REUSE
>>     - This flag is only supported if the channel reports the DMA_LOAD_EOT
>>       capability.
>>   
>> +- DMA_PREP_LOCK
>> +
>> +  - If set, the DMA will lock all other pipes not related to the current
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
>> +  - If set, DMA will release all locked pipes
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

