Return-Path: <dmaengine+bounces-3795-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 442D09D9129
	for <lists+dmaengine@lfdr.de>; Tue, 26 Nov 2024 05:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C73028567C
	for <lists+dmaengine@lfdr.de>; Tue, 26 Nov 2024 04:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE15C182BC;
	Tue, 26 Nov 2024 04:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TQqv7hXY"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC493D6D;
	Tue, 26 Nov 2024 04:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732597057; cv=none; b=UKucGbNdzt2v+N+L2RrFuP53nDG6n1/dAmbP+juxoekWIs/kEzm/J8ZspM6gq92MPWnD573ub4gVj1rRFQGmDFjtwd8vQLi9ujxtgZSWHawsK5Yb0cY9M3MiM1Emo+rbX4QcKgdPNOZF+8yeaq45Y2CFOFsi9eck31fhX8JTFaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732597057; c=relaxed/simple;
	bh=tsRzdQafM1jps+fhoc4oXSxGVhKQo6o0E3myeIY8rgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=i89FxIMbNlNny6NUt03Ew86CY6apOzxR4uZYvaz50oiyPXVGVAhtLJKqhlbJotx+T/4KMkkli7srtgC/aOIsGIvPu494WDtJUpIp6/1Ts23y3yzLYHbLA/sybldwGGum4UjF0N0WI2s7ZolcvgNksz7mZvGFa/cn0Yj3tHdPFdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TQqv7hXY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4APJTQcw030525;
	Tue, 26 Nov 2024 04:57:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2kfNfp3sjB/n7H5lX+DdLkxSUAoQqrFWzurnBC0Xtq4=; b=TQqv7hXYA7LVh+BO
	IWH10DgYaJAOdq25B+HmSCqiBhO3iQmNqF25Fnr/lRuTE2gDCikWrg1Sk8r9Uxg4
	vSfZdLcOiodQBiG6Wm5wiCfC3TJDmJHIzXDAZzq2MClJ7bAzufQBTeZFdF7q9ziC
	4Q+eZFpUAC3vQlh9uwGggzIUncGpD9e37xkSZWo4zDcm9ITC2a33sjGrzLEJMIo+
	I1qWT82OuurVxjBCqa8KZIdVtW3rcn4uHUFnJsPL4uzyemrVCWZsr5r/em1c8+ee
	FTuPhaLraUXjSLKIoSWY6CMullupXWgQlElLj4QlQnQkRZDWJSY6ZHmzm4yCUUnE
	Uy6Szw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4334rd75m2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 04:57:28 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AQ4vR0r032199
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 04:57:27 GMT
Received: from [10.151.37.94] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 25 Nov
 2024 20:57:23 -0800
Message-ID: <b874e1fc-2d0d-f18b-3ebc-6ebff2e02e8f@quicinc.com>
Date: Tue, 26 Nov 2024 10:27:13 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] dmaengine: qcom: bam_dma: Avoid writing unavailable
 register
To: Varadarajan Narayanan <quic_varada@quicinc.com>
CC: <vkoul@kernel.org>, <ulf.hansson@linaro.org>, <martin.petersen@oracle.com>,
        <kees@kernel.org>, <dave.jiang@intel.com>, <av2082000@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_srichara@quicinc.com>
References: <20241122071649.2618320-1-quic_mdalam@quicinc.com>
 <Z0Fb5xBolEtwyUKb@hu-varada-blr.qualcomm.com>
Content-Language: en-US
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <Z0Fb5xBolEtwyUKb@hu-varada-blr.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: jMkiCdQVs8jVk6KiTvVppZqNZBJDTSOJ
X-Proofpoint-GUID: jMkiCdQVs8jVk6KiTvVppZqNZBJDTSOJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 adultscore=0 impostorscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411260039



On 11/23/2024 10:06 AM, Varadarajan Narayanan wrote:
> On Fri, Nov 22, 2024 at 12:46:49PM +0530, Md Sadre Alam wrote:
>> Avoid writing unavailable register in BAM-Lite mode.
>> BAM_DESC_CNT_TRSHLD register is unavailable in BAM-Lite
>> mode. Its only available in BAM-NDP mode. So avoid writing
>> this register for clients who is using BAM-Lite mode.
>>
>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>> ---
>>   drivers/dma/qcom/bam_dma.c | 22 ++++++++++++++--------
>>   1 file changed, 14 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
>> index d43a881e43b9..13a08c03746b 100644
>> --- a/drivers/dma/qcom/bam_dma.c
>> +++ b/drivers/dma/qcom/bam_dma.c
>> @@ -59,6 +59,9 @@ struct bam_desc_hw {
>>   #define DESC_FLAG_NWD BIT(12)
>>   #define DESC_FLAG_CMD BIT(11)
>>
>> +#define BAM_LITE	0x13
>> +#define BAM_NDP		0x20
>> +
>>   struct bam_async_desc {
>>   	struct virt_dma_desc vd;
>>
>> @@ -398,6 +401,7 @@ struct bam_device {
>>
>>   	/* dma start transaction tasklet */
>>   	struct tasklet_struct task;
>> +	u32 bam_revision;
>>   };
>>
>>   /**
>> @@ -441,8 +445,9 @@ static void bam_reset(struct bam_device *bdev)
>>   	writel_relaxed(val, bam_addr(bdev, 0, BAM_CTRL));
>>
>>   	/* set descriptor threshold, start with 4 bytes */
>> -	writel_relaxed(DEFAULT_CNT_THRSHLD,
>> -			bam_addr(bdev, 0, BAM_DESC_CNT_TRSHLD));
>> +	if (bdev->bam_revision >= BAM_LITE && bdev->bam_revision < BAM_NDP)
>> +		writel_relaxed(DEFAULT_CNT_THRSHLD,
>> +			       bam_addr(bdev, 0, BAM_DESC_CNT_TRSHLD));
>>
>>   	/* Enable default set of h/w workarounds, ie all except BAM_FULL_PIPE */
>>   	writel_relaxed(BAM_CNFG_BITS_DEFAULT, bam_addr(bdev, 0, BAM_CNFG_BITS));
>> @@ -1000,9 +1005,9 @@ static void bam_apply_new_config(struct bam_chan *bchan,
>>   			maxburst = bchan->slave.src_maxburst;
>>   		else
>>   			maxburst = bchan->slave.dst_maxburst;
>> -
>> -		writel_relaxed(maxburst,
>> -			       bam_addr(bdev, 0, BAM_DESC_CNT_TRSHLD));
>> +		if (bdev->bam_revision >= BAM_LITE && bdev->bam_revision < BAM_NDP)
>> +			writel_relaxed(maxburst,
>> +				       bam_addr(bdev, 0, BAM_DESC_CNT_TRSHLD));
>>   	}
>>
>>   	bchan->reconfigure = 0;
>> @@ -1192,10 +1197,11 @@ static int bam_init(struct bam_device *bdev)
>>   	u32 val;
>>
>>   	/* read revision and configuration information */
>> -	if (!bdev->num_ees) {
>> -		val = readl_relaxed(bam_addr(bdev, 0, BAM_REVISION));
>> +	val = readl_relaxed(bam_addr(bdev, 0, BAM_REVISION));
>> +	if (!bdev->num_ees)
>>   		bdev->num_ees = (val >> NUM_EES_SHIFT) & NUM_EES_MASK;
>> -	}
>> +
>> +	bdev->bam_revision = val & 0xff;
> 
> Use REVISION_MASK instead of 0xff
Ok
> 
> -Varada
> 
>>   	/* check that configured EE is within range */
>>   	if (bdev->ee >= bdev->num_ees)
>> --
>> 2.34.1
>>

