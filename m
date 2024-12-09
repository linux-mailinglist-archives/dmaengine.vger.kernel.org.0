Return-Path: <dmaengine+bounces-3927-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1808E9E8B1D
	for <lists+dmaengine@lfdr.de>; Mon,  9 Dec 2024 06:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED0511635FF
	for <lists+dmaengine@lfdr.de>; Mon,  9 Dec 2024 05:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50671C1F31;
	Mon,  9 Dec 2024 05:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pE4WXhQJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370091C0DED;
	Mon,  9 Dec 2024 05:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733723010; cv=none; b=FRwqRKi0PKmKjCt00OFQIh9guJJfbBeULqxiPZubMkEp5IkpSaVmls3OvfX0esT3vWf36AArm7L/Hu+1acwNQrseuRf9SJgTM/m+FIfNTSfU5Nn4pOPdU+TA1IkC+F7HpqpM/BKXvbhAGpN6Q3FQISOFLThzV1MPbH2OQnRW0zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733723010; c=relaxed/simple;
	bh=Ir9prde6LY8wW8Fk5RQVVEZOuZ/k1ClcQ+k+I/UdFR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UK1ObwT9ihM0N3OR8/trNzBLBnsGwBmhan/3ScKxWusPO55C0pEu8f4Ag0rHEjhxECAeJ19K44J6+hvKP7fiOsA1ZLdXKuLqnlbiMSwweFFvZYe1G5KnwkMDBOB2//6CX/qdomN0B3pjZ73b6cYu2udaowl5IMyjULK+Kpb764w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pE4WXhQJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B8MxbpF013144;
	Mon, 9 Dec 2024 05:38:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Pnf+T1RnkkmfBCdSVZ7C6z8xcOB3sb13wG/xstLhHOI=; b=pE4WXhQJdOxo1kro
	nNKK9g5gp5VFmoXxqfceFOzSVm8NENfHzWVInO9gStbLSrUXsYa+kD+CZsjKBDne
	Yfjkwy1uB0w3Uaq7KQWN05fsBKLayjTt5J+6PdO4ZqJMHk463WCtG3+w3VXC0VZh
	sLrp+CJ/vxK0GLBL9GTXrfKnd2r9FRlB5Xy5Q+be/TO3pN2uPFpcJMAn4TXkSfJL
	vUGncl+romk0SFWDzbZr3rr82TR1RpSTTZReVT3XdFi3etr+xP6M7os9JjLzN73I
	b+kri3z7DtQAcbfUPIJ20Db83Z8CUXFRpOf7u/OuexOM6Nk8ncIjusjjcGsp5Us9
	kPZLCw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43cdaqbj1e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 05:38:16 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B95cF5x017084
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Dec 2024 05:38:15 GMT
Received: from [10.151.36.43] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 8 Dec 2024
 21:38:10 -0800
Message-ID: <63cbf052-86cb-74d2-f189-2eedc05343ba@quicinc.com>
Date: Mon, 9 Dec 2024 11:08:07 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v4 02/11] dmaengine: qcom: bam_dma: add LOCK & UNLOCK flag
 support
Content-Language: en-US
To: Vinod Koul <vkoul@kernel.org>
CC: <thara.gopinath@gmail.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <kees@kernel.org>, <robin.murphy@arm.com>,
        <fenghua.yu@intel.com>, <av2082000@gmail.com>,
        <u.kleine-koenig@pengutronix.d>, <linux-crypto@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <quic_varada@quicinc.com>,
        <quic_srichara@quicinc.com>
References: <20240909092632.2776160-1-quic_mdalam@quicinc.com>
 <20240909092632.2776160-3-quic_mdalam@quicinc.com> <Z1BPApOvYoDaTR57@vaman>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <Z1BPApOvYoDaTR57@vaman>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eiGLV3aLTvKWrtlsMvFAKf85sxq5pXvv
X-Proofpoint-ORIG-GUID: eiGLV3aLTvKWrtlsMvFAKf85sxq5pXvv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090044



On 12/4/2024 6:15 PM, Vinod Koul wrote:
> On 09-09-24, 14:56, Md Sadre Alam wrote:
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
>> feature. So adding check for the same and setting bam_pipe_lock
>> based on BAM SW Version.
>>
>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>> ---
>>
>> Change in [v4]
>>
>> * Added BAM_SW_VERSION read for major & minor
>>    version
>>
>> * Added bam_pipe_lock flag
>>
>> Change in [v3]
>>
>> * Moved lock/unlock bit set inside loop
>>
>> Change in [v2]
>>
>> * No change
>>   
>> Change in [v1]
>>
>> * Added initial support for BAM pipe lock/unlock
>>
>>   drivers/dma/qcom/bam_dma.c | 25 ++++++++++++++++++++++++-
>>   include/linux/dmaengine.h  |  6 ++++++
>>   2 files changed, 30 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
>> index 3a2965939531..d30416a26d8e 100644
>> --- a/drivers/dma/qcom/bam_dma.c
>> +++ b/drivers/dma/qcom/bam_dma.c
>> @@ -53,11 +53,20 @@ struct bam_desc_hw {
>>   
>>   #define BAM_DMA_AUTOSUSPEND_DELAY 100
>>   
>> +#define SW_VERSION_MAJOR_SHIFT	28
>> +#define SW_VERSION_MINOR_SHIFT	16
>> +#define SW_VERSION_MAJOR_MASK	(0xf << SW_VERSION_MAJOR_SHIFT)
> 
> Use GENMASK for this
Ok
> 
>> +#define SW_VERSION_MINOR_MASK	0xf
> 
> Can you define only masks and use FIELD_PREP etc to handle this
Ok
> 
>> +#define SW_MAJOR_1	0x1
>> +#define SW_VERSION_4	0x4
>> +
>>   #define DESC_FLAG_INT BIT(15)
>>   #define DESC_FLAG_EOT BIT(14)
>>   #define DESC_FLAG_EOB BIT(13)
>>   #define DESC_FLAG_NWD BIT(12)
>>   #define DESC_FLAG_CMD BIT(11)
>> +#define DESC_FLAG_LOCK BIT(10)
>> +#define DESC_FLAG_UNLOCK BIT(9)
>>   
>>   struct bam_async_desc {
>>   	struct virt_dma_desc vd;
>> @@ -393,6 +402,7 @@ struct bam_device {
>>   	u32 ee;
>>   	bool controlled_remotely;
>>   	bool powered_remotely;
>> +	bool bam_pipe_lock;
>>   	u32 active_channels;
>>   	u32 bam_sw_version;
>>   
>> @@ -696,9 +706,15 @@ static struct dma_async_tx_descriptor *bam_prep_slave_sg(struct dma_chan *chan,
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
>> @@ -1242,6 +1258,7 @@ static int bam_dma_probe(struct platform_device *pdev)
>>   {
>>   	struct bam_device *bdev;
>>   	const struct of_device_id *match;
>> +	u32 sw_major, sw_minor;
>>   	int ret, i;
>>   
>>   	bdev = devm_kzalloc(&pdev->dev, sizeof(*bdev), GFP_KERNEL);
>> @@ -1305,6 +1322,12 @@ static int bam_dma_probe(struct platform_device *pdev)
>>   
>>   	bdev->bam_sw_version = readl_relaxed(bam_addr(bdev, 0, BAM_SW_VERSION));
>>   	dev_info(bdev->dev, "BAM software version:0x%08x\n", bdev->bam_sw_version);
>> +	sw_major = (bdev->bam_sw_version & SW_VERSION_MAJOR_MASK) >> SW_VERSION_MAJOR_SHIFT;
>> +	sw_minor = (bdev->bam_sw_version >> SW_VERSION_MINOR_SHIFT) & SW_VERSION_MINOR_MASK;
> 
> FIELD_GET
Ok
> 
>> +
>> +	if (sw_major == SW_MAJOR_1 && sw_minor >= SW_VERSION_4)
>> +		bdev->bam_pipe_lock = true;
>> +
>>   
>>   	ret = bam_init(bdev);
>>   	if (ret)
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
> 
> this should be a separate patch to define how to use these new flags,
> what it means etc...
Ok , will prepare separate patch for these flags in next revision.
> 
> 
>>   };
>>   
>>   /**
>> -- 
>> 2.34.1
> 

