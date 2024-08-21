Return-Path: <dmaengine+bounces-2928-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1094595A2D5
	for <lists+dmaengine@lfdr.de>; Wed, 21 Aug 2024 18:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBDC5282D24
	for <lists+dmaengine@lfdr.de>; Wed, 21 Aug 2024 16:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F3314EC5C;
	Wed, 21 Aug 2024 16:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SM6nODZP"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E9F5D8F0;
	Wed, 21 Aug 2024 16:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724257936; cv=none; b=mluTmibCt3G8BlsKpgUBPRMzgk4d/J30V2eIwpGrHT+M2WBWS0CnhVS3yH60iFHM0SPdsPGn/77GVo/xYga9NcCqsrKLvXghQ2erIIDvKnoBoONTniwd+DM0F/c8o7JJKTJkEvh+nBQ4+8JNxAFhZjT07od9tDkAvqFYALVbzm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724257936; c=relaxed/simple;
	bh=ydiATV2XuDjT4P4uEWGX77NmnCuMdVJf/U8IfiMU7MQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=A+zZbejwSyIpDdyvjw7g9C9Ahfq5rynO1jjm6DKVLgT6c7sWBgeCTBtLhiObofLGQVpukMA7ztjjVxCyirORrAfMMC3Iuh7G9UuTvCfSQOeq4ml7m8HdNiZ0FlI/Hi35Tt/8dvZ/uiUGnsz6rlsWfFPAsDju47MolaoQuxszcL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SM6nODZP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47LCIJ13022390;
	Wed, 21 Aug 2024 16:32:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C3Kgh+kP9eI1LhPm7yyGDpHjNiyatM6aYOhcljr30h8=; b=SM6nODZP7/zcbk6j
	yFZ/+jzMikfhtjXrW1NmTNE27frmV9KJS50iyCo62pCHfH0LA9IVrcEZxsGZOs+N
	b/Q7pc58YVPya+1yEsXbafQOvuGnmXnFqy0eb1Zex4MeWRGXWgTbE0fAh/RKrdK4
	+ZMMtc5yx5gAeCaG4TBgfC3qWg8PfZCPzzuMVGyaYTvPRD3Hs3snbyhqb0+8kazO
	STEO26TpCkPYGXAfsue4o7fJ0gAOZdjuHDIArWDdv7dntsrl1dOPgI+RKLhlf1h9
	v2CVPca8w6EI5cXvspRX8nkODev+mAzkb3L5Oa5xRwDEDhLPON9GK4IiA1td7XSw
	70Nk4Q==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 414pdmdda1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 16:32:02 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47LGW1a9025563
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 16:32:01 GMT
Received: from [10.216.59.247] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 21 Aug
 2024 09:31:54 -0700
Message-ID: <24909c0b-ad83-e33b-e11f-22d0fb2ec979@quicinc.com>
Date: Wed, 21 Aug 2024 22:01:51 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 03/16] dmaengine: qcom: bam_dma: add LOCK & UNLOCK flag
 support
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
 <20240815085725.2740390-4-quic_mdalam@quicinc.com>
 <knhqbj2pyluwrvr2f4h6zgpfosa6o2qgnhtl4qltadpuyfexgu@kk5knurc4v7h>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <knhqbj2pyluwrvr2f4h6zgpfosa6o2qgnhtl4qltadpuyfexgu@kk5knurc4v7h>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tW-EWFCvrONGIKhLXnMMyZtjIn5U73n4
X-Proofpoint-ORIG-GUID: tW-EWFCvrONGIKhLXnMMyZtjIn5U73n4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_11,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=859 spamscore=0
 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501 mlxscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408210121



On 8/16/2024 9:52 PM, Bjorn Andersson wrote:
> On Thu, Aug 15, 2024 at 02:27:12PM GMT, Md Sadre Alam wrote:
>> Add lock and unlock flag support on command descriptor.
>> Once lock set in requester pipe, then the bam controller
>> will lock all others pipe and process the request only
>> from requester pipe. Unlocking only can be performed from
>> the same pipe.
>>
> 
> Is the lock per channel, or for the whole BAM instance?
   This lock is for whole BAM instance. Once LOCK bit will
   set on initiator CMD descriptor BAM will lock all pipes
   which belongs to other EE's and Pipes not in the current
   group.
> 
>> If DMA_PREP_LOCK flag passed in command descriptor then requester
>> of this transaction wanted to lock the BAM controller for this
>> transaction so BAM driver should set LOCK bit for the HW descriptor.
> 
> You use the expression "this transaction" here, but if I understand the
> calling code the lock is going to be held over multiple DMA operations
> and even across asynchronous operations in the crypto driver.
   Yes its correct.
> 
> DMA_PREP_LOCK indicates that this is the beginning of a transaction,
> consisting of multiple operations that needs to happen while other EEs
> are being locked out, and DMA_PREP_UNLOCK marks the end of the
> transaction.
   Yes its correct.
> 
> That said, I'm not entirely fond of the fact that these flags are not
> just used on first and last operation in one sequence, but spread out.
   Yes its correct.
> 
> Locking is hard, when you spread the responsibility of locking and
> unlocking across different entities it's made harder...
   The locking/unlocking always synchronous because unlocking happening
   in the dma callback.
> 
>>
>> If DMA_PREP_UNLOCK flag passed in command descriptor then requester
>> of this transaction wanted to unlock the BAM controller.so BAM driver
>> should set UNLOCK bit for the HW descriptor.
>>
>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>> ---
>>
>> Change in [v2]
>>
>> * Added LOCK and UNLOCK flag in bam driver
>>
>> Change in [v1]
>>
>> * This patch was not included in [v1]
> 
> v1 can be found here:
> https://lore.kernel.org/all/20231214114239.2635325-7-quic_mdalam@quicinc.com/
> 
> And it was also posted once before that:
> https://lore.kernel.org/all/1608215842-15381-1-git-send-email-mdalam@codeaurora.org/
> 
> In particular during the latter (i.e. first post) we had a rather long
> discussion about this feature, so that's certainly worth linking to.
> 
> Looks like this series provides some answers to the questions we had
> back then.
   Will add the link in next post
> 
> Regards,
> Bjorn
> 
>>
>>   drivers/dma/qcom/bam_dma.c | 10 +++++++++-
>>   include/linux/dmaengine.h  |  6 ++++++
>>   2 files changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
>> index 1ac7e250bdaa..ab3b5319aa68 100644
>> --- a/drivers/dma/qcom/bam_dma.c
>> +++ b/drivers/dma/qcom/bam_dma.c
>> @@ -58,6 +58,8 @@ struct bam_desc_hw {
>>   #define DESC_FLAG_EOB BIT(13)
>>   #define DESC_FLAG_NWD BIT(12)
>>   #define DESC_FLAG_CMD BIT(11)
>> +#define DESC_FLAG_LOCK BIT(10)
>> +#define DESC_FLAG_UNLOCK BIT(9)
>>   
>>   struct bam_async_desc {
>>   	struct virt_dma_desc vd;
>> @@ -692,9 +694,15 @@ static struct dma_async_tx_descriptor *bam_prep_slave_sg(struct dma_chan *chan,
>>   		unsigned int curr_offset = 0;
>>   
>>   		do {
>> -			if (flags & DMA_PREP_CMD)
>> +			if (flags & DMA_PREP_CMD) {
>>   				desc->flags |= cpu_to_le16(DESC_FLAG_CMD);
>>   
>> +				if (bdev->bam_pipe_lock && flags & DMA_PREP_LOCK)
>> +					desc->flags |= cpu_to_le16(DESC_FLAG_LOCK);
>> +				else if (bdev->bam_pipe_lock && flags & DMA_PREP_UNLOCK)
>> +					desc->flags |= cpu_to_le16(DESC_FLAG_UNLOCK);
>> +			}
>> +
>>   			desc->addr = cpu_to_le32(sg_dma_address(sg) +
>>   						 curr_offset);
>>   
>> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
>> index b137fdb56093..70f23068bfdc 100644
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
>>

