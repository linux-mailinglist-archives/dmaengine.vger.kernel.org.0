Return-Path: <dmaengine+bounces-2925-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 747F49593EC
	for <lists+dmaengine@lfdr.de>; Wed, 21 Aug 2024 07:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5D72B225B8
	for <lists+dmaengine@lfdr.de>; Wed, 21 Aug 2024 05:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87D9165EF0;
	Wed, 21 Aug 2024 05:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZbTF4V7o"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2021A1607A0;
	Wed, 21 Aug 2024 05:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724217264; cv=none; b=ooXsZonXUgHHfxSPqQiBeza/arhxo3kUzujUWJ/3Lp8rzZpyVu1UMlSftmj7pSta1Cb67d2fVAM/HZPu3VzlpgA+aXeWyq1Hcx04h+C+OxwcOOsw7EbcRGFRGNtu6cchiPO8DQYidyQROS24AKIPX9O7xZVxELZjWwPYfRQV5OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724217264; c=relaxed/simple;
	bh=uWcBu2cP4fEBP+7/wX2l8aPoJbJZm4OVBRLLMRvp7q0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OYz6507tNJEOnqh+L2gLWpriN8Ds0J2qJ5lZ3A7AZAKGFxRGZpREUP56TAuCFTSD2QTKav3NP+vRwrOUg9WaBRB1BeovgP47MiRx61WI3QA6OtLdhiWNmomYHIRecRI1wdauTfpBiJ0sSwvpcG8fLConm6FI/s1Oyz22STAZzlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZbTF4V7o; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47KElsE3019527;
	Wed, 21 Aug 2024 05:14:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	92WtQ/8ikNRavgYPHOIrSZVPAxTW/OryDHZASa8WH10=; b=ZbTF4V7oHhMs3pDn
	Rnbj36VwJXV2dAJ+o6GUsOdI6aoa8ekFB38J3bz8Hs6psWNgw7+CAXrO9RUQ9Nyq
	sh6QBeUKVivGk2GDW7kxD8wjr/2ZG251CbDCDC0eCYOQbVX8pZHkyKakoYXQob9q
	x7G/WSqrRIVwdGGDJZ9RFv3eaTEoE+gqDlDYZyavU5W24Z8UQ9wnSaRn8pX54Qmj
	ZUwOfkMDdVKLe4neXMk284zXfyxfDNFeZe86iVJ9HCaMeLTK7eCdZ6Nex/y3WFDX
	+2vdwZbXv9EfKdCnDTs+ay5sylM4oP+bjHm8/2RqsJXPJmyPoGhgKmHbj/YaXz+K
	UlUKuQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 414phvb1pm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 05:14:12 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47L5EBwT010419
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 05:14:11 GMT
Received: from [10.151.37.94] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 20 Aug
 2024 22:14:05 -0700
Message-ID: <9a40cce6-03cb-eea3-7621-7a89d0478a07@quicinc.com>
Date: Wed, 21 Aug 2024 10:44:02 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 10/16] crypto: qce - Add support for lock aquire,lock
 release api.
Content-Language: en-US
To: Bjorn Andersson <andersson@kernel.org>
CC: <vkoul@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <konradybcio@kernel.org>,
        <thara.gopinath@gmail.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <gustavoars@kernel.org>,
        <u.kleine-koenig@pengutronix.de>, <kees@kernel.org>,
        <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>,
        <quic_utiwari@quicinc.com>
References: <20240815085725.2740390-1-quic_mdalam@quicinc.com>
 <20240815085725.2740390-11-quic_mdalam@quicinc.com>
 <n625hyjcbiidnlskzlubrmrflguwyurq5rp4l2hsnqf2g2wzik@ftz4wvvifft5>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <n625hyjcbiidnlskzlubrmrflguwyurq5rp4l2hsnqf2g2wzik@ftz4wvvifft5>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: TjIWyXe1PR617NdOa37k6HptcXx6-eUO
X-Proofpoint-GUID: TjIWyXe1PR617NdOa37k6HptcXx6-eUO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_05,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408210035



On 8/16/2024 10:08 PM, Bjorn Andersson wrote:
> On Thu, Aug 15, 2024 at 02:27:19PM GMT, Md Sadre Alam wrote:
>> Add support for lock acquire and lock release api.
>> When multiple EE's(Execution Environment) want to access
>> CE5 then there will be race condition b/w multiple EE's.
>>
>> Since each EE's having their dedicated BAM pipe, BAM allows
>> Locking and Unlocking on BAM pipe. So if one EE's requesting
>> for CE5 access then that EE's first has to LOCK the BAM pipe
>> while setting LOCK bit on command descriptor and then access
>> it. After finishing the request EE's has to UNLOCK the BAM pipe
>> so in this way we race condition will not happen.
> 
> Does the lock/unlock need to happen on a dummy access before and after
> the actual sequence? Is it not sufficient to lock/unlock on the first
> and last operation?
   The locking/unlocking has to happen on command descriptor only, If we
   need locking/unlocking on data descriptor then we have to use dummy
   command descriptor only as per Hardware Programming Guide.

   Hardware Programming Guide state as below:
   Pipe Locking and Unlocking should appear ONLY in Command-Descriptor.
   In case a Lock is required on a Data Descriptor this can be implemented
   by a dummy Command-Descriptor with Lock/Unlock bit asserted preceding/
   following the Data Descriptor.
> 
> Please squash this with the previous commit, if kept as explicit
> operations, please squash it with the previous patch that introduces the
> flags.
   Ok
> 
>>
>> Added these two API qce_bam_acquire_lock() and qce_bam_release_lock()
>> for the same.
>>
>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>> ---
>>
>> Change in [v2]
>>
>> * No chnage
>>
>> Change in [v1]
>>
>> * Added initial support for lock_acquire and lock_release
>>    api.
>>
>>   drivers/crypto/qce/common.c | 36 ++++++++++++++++++++++++++++++++++++
>>   drivers/crypto/qce/core.h   |  2 ++
>>   2 files changed, 38 insertions(+)
>>
>> diff --git a/drivers/crypto/qce/common.c b/drivers/crypto/qce/common.c
>> index ff96f6ba1fc5..a8eaffe41101 100644
>> --- a/drivers/crypto/qce/common.c
>> +++ b/drivers/crypto/qce/common.c
>> @@ -617,3 +617,39 @@ void qce_get_version(struct qce_device *qce, u32 *major, u32 *minor, u32 *step)
>>   	*minor = (val & CORE_MINOR_REV_MASK) >> CORE_MINOR_REV_SHIFT;
>>   	*step = (val & CORE_STEP_REV_MASK) >> CORE_STEP_REV_SHIFT;
>>   }
>> +
>> +int qce_bam_acquire_lock(struct qce_device *qce)
>> +{
>> +	int ret;
>> +
>> +	qce_clear_bam_transaction(qce);
> 
> It's not entirely obvious that a "lock" operation will invalidate any
> pending operations.
   qce_clear_bam_transaction() api is not going to invalidate any pending
   thransaction. This is just an internal api which will set bam_transaction
   structure to 0 before starting new bam transaction.
> 
>> +
>> +	/* This is just a dummy write to acquire lock on bam pipe */
>> +	qce_write_reg_dma(qce, REG_AUTH_SEG_CFG, 0, 1);
>> +
>> +	ret = qce_submit_cmd_desc(qce, QCE_DMA_DESC_FLAG_LOCK);
>> +	if (ret) {
>> +		dev_err(qce->dev, "Error in Locking cmd descriptor\n");
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +int qce_bam_release_lock(struct qce_device *qce)
> 
> What would be a reasonable response from the caller if this release
> operation returns a failure? How do you expect it to recover?
   If unlocking bam pipe failed means its a bam failure and we can abort
   the current transaction.
> 
>> +{
>> +	int ret;
>> +
>> +	qce_clear_bam_transaction(qce);
>> +
> 
> In particularly not on "unlock".
   qce_clear_bam_transaction() this is just to initialize with 0
   for bam transaction structure before any new transaction start.
> 
> Regards,
> Bjorn
> 
>> +	/* This just dummy write to release lock on bam pipe*/
>> +	qce_write_reg_dma(qce, REG_AUTH_SEG_CFG, 0, 1);
>> +
>> +	ret = qce_submit_cmd_desc(qce, QCE_DMA_DESC_FLAG_UNLOCK);
>> +	if (ret) {
>> +		dev_err(qce->dev, "Error in Un-Locking cmd descriptor\n");
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> diff --git a/drivers/crypto/qce/core.h b/drivers/crypto/qce/core.h
>> index bf28dedd1509..d01d810b60ad 100644
>> --- a/drivers/crypto/qce/core.h
>> +++ b/drivers/crypto/qce/core.h
>> @@ -68,4 +68,6 @@ int qce_read_reg_dma(struct qce_device *qce, unsigned int offset, void *buff,
>>   void qce_clear_bam_transaction(struct qce_device *qce);
>>   int qce_submit_cmd_desc(struct qce_device *qce, unsigned long flags);
>>   struct qce_bam_transaction *qce_alloc_bam_txn(struct qce_dma_data *dma);
>> +int qce_bam_acquire_lock(struct qce_device *qce);
>> +int qce_bam_release_lock(struct qce_device *qce);
>>   #endif /* _CORE_H_ */
>> -- 
>> 2.34.1
>>

