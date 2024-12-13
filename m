Return-Path: <dmaengine+bounces-3964-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BA79F06D4
	for <lists+dmaengine@lfdr.de>; Fri, 13 Dec 2024 09:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E4EF2835B0
	for <lists+dmaengine@lfdr.de>; Fri, 13 Dec 2024 08:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87201AF0C1;
	Fri, 13 Dec 2024 08:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="W0zvRE2m"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C201AF0D7;
	Fri, 13 Dec 2024 08:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734079549; cv=none; b=a1yw3cYXwT63a3o9cPo7XsA3JGKzFY4dry3BCOu4gtSKGed5c6Y13CjQ11Z0ek0VQR21t4xZc3EEuAyJ9Lubia4oxMBw9M9UjqCMaFYDhW93K+gxOJbs054p/o4HaIjnnAYpwdk2Z/h5YJdIfhpCtupFoC6poMnWw90iQ5vJH7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734079549; c=relaxed/simple;
	bh=Zcl6ZI35vPU3dHr9xygz79//EU3FfcFQ0n2t/KYqvQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Yd6lOPifEhRlk3uOXi54CKM7fFHI0lfzQZIunrBXLcQ+JrtYSjUEX8iD5kjh89o+CJrPgff6NXhfl1zzWVVdEoLpU5SgX1+tuDGYh9Ci9Ys20Frc4kSW5+lS84Zg34dsHe4DL8KDMWh8AWc5zXrG7KdI+XzZMThdtq+KW78Ib7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=W0zvRE2m; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCMWDRW031133;
	Fri, 13 Dec 2024 08:45:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tiHq8xibVnYmI/CwejCcpzH+iehcIwwMxTvGfIdkXxw=; b=W0zvRE2mUGLNRpC+
	Wp5lOpAvYu70+Z4Wrxz8Mz/xVAd9TF1HAITtdBOnaBoeXYzN7ueACtCX+mhb6GqA
	FRYcuOoz64eS1ytDNnPl1YBNUbVM7+yUA3ij1/efhOb98Fg6T30VGI34gJE0/ZIS
	71qA5zQajnKVqjCqN3ToYw9oELCzPx8/4IjW85WqrMkaTf6MtpK4QozwKrqeavt5
	mCbUBlMLfQfEpx+CdlNBSGoJyD3ufAAB7EWnOQuGwMPRKMc7Az144H7sj1aW8h2B
	lHQasqeLFU4BUMDw1jaTPZWGkxkJwvr8bFU70ZCYVnmdTvCyt/A9VZaS/mWjHcLe
	RGGpYQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43fwgek5n3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 08:45:41 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BD8jeuG003227
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 08:45:40 GMT
Received: from [10.151.36.43] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 13 Dec
 2024 00:45:36 -0800
Message-ID: <204e45a9-7748-0ab6-f57e-25bfeb5d037b@quicinc.com>
Date: Fri, 13 Dec 2024 14:15:34 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3] dmaengine: qcom: bam_dma: Avoid writing unavailable
 register
Content-Language: en-US
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>, <vkoul@kernel.org>,
        <martin.petersen@oracle.com>, <ulf.hansson@linaro.org>,
        <av2082000@gmail.com>, <linux-arm-msm@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <uic_mdalam@quicinc.com>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.com>
References: <20241209073143.3413552-1-quic_mdalam@quicinc.com>
 <5d27eea0-56cd-4961-9fd5-f2398a24f958@quicinc.com>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <5d27eea0-56cd-4961-9fd5-f2398a24f958@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rdbWHnMCVRLGRe0Hn0QELRIAP65G-gMF
X-Proofpoint-ORIG-GUID: rdbWHnMCVRLGRe0Hn0QELRIAP65G-gMF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130058



On 12/9/2024 4:05 PM, Manikanta Mylavarapu wrote:
> 
> 
> On 12/9/2024 1:01 PM, Md Sadre Alam wrote:
>> Avoid writing unavailable register in BAM-Lite mode.
>> BAM_DESC_CNT_TRSHLD register is unavailable in BAM-Lite
>> mode. Its only available in BAM-NDP mode. So only write
>> this register for clients who is using BAM-NDP.
>>
>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>> ---
>>
>> Change in [v3]
>>
>> * Removed BAM_LITE macro
>>
>> * Updated commit message
>>
>> * Adjusted if condition check
>>
>> * Renamed BAM-NDP macro to BAM_NDP_REVISION_START and
>>    BAM_NDP_REVISION_END
>>
>> Change in [v2]
>>
>> * Replace 0xff with REVISION_MASK in the statement
>>    bdev->bam_revision = val & REVISION_MASK
>>
>> Change in [v1]
>>
>> * Added initial patch
>>
>>   drivers/dma/qcom/bam_dma.c | 24 ++++++++++++++++--------
>>   1 file changed, 16 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
>> index d43a881e43b9..a00dd0331ff5 100644
>> --- a/drivers/dma/qcom/bam_dma.c
>> +++ b/drivers/dma/qcom/bam_dma.c
>> @@ -59,6 +59,9 @@ struct bam_desc_hw {
>>   #define DESC_FLAG_NWD BIT(12)
>>   #define DESC_FLAG_CMD BIT(11)
>>   
>> +#define BAM_NDP_REVISION_START	0x20
>> +#define BAM_NDP_REVISION_END	0x27
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
>> @@ -441,8 +445,10 @@ static void bam_reset(struct bam_device *bdev)
>>   	writel_relaxed(val, bam_addr(bdev, 0, BAM_CTRL));
>>   
>>   	/* set descriptor threshold, start with 4 bytes */
>> -	writel_relaxed(DEFAULT_CNT_THRSHLD,
>> -			bam_addr(bdev, 0, BAM_DESC_CNT_TRSHLD));
>> +	if (bdev->bam_revision >= BAM_NDP_REVISION_START &&
>> +	    bdev->bam_revision <= BAM_NDP_REVISION_END)
> 
> Please use in_range().
Ok
> 
>> +		writel_relaxed(DEFAULT_CNT_THRSHLD,
>> +			       bam_addr(bdev, 0, BAM_DESC_CNT_TRSHLD));
>>   
>>   	/* Enable default set of h/w workarounds, ie all except BAM_FULL_PIPE */
>>   	writel_relaxed(BAM_CNFG_BITS_DEFAULT, bam_addr(bdev, 0, BAM_CNFG_BITS));
>> @@ -1000,9 +1006,10 @@ static void bam_apply_new_config(struct bam_chan *bchan,
>>   			maxburst = bchan->slave.src_maxburst;
>>   		else
>>   			maxburst = bchan->slave.dst_maxburst;
>> -
>> -		writel_relaxed(maxburst,
>> -			       bam_addr(bdev, 0, BAM_DESC_CNT_TRSHLD));
>> +		if (bdev->bam_revision >= BAM_NDP_REVISION_START &&
>> +		    bdev->bam_revision <= BAM_NDP_REVISION_END)
> 
> Please use in_range().
Ok
> 
> Thanks & Regards,
> Manikanta.
> 

