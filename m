Return-Path: <dmaengine+bounces-4383-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFA1A2EBDA
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 12:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E7C13A90FD
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 11:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F59B1F63EA;
	Mon, 10 Feb 2025 11:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GNhTTGYZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B621F3BA8;
	Mon, 10 Feb 2025 11:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739188104; cv=none; b=CnifUVPmZT9K+poJnib97LH3Zx4OyZIuwVZu+9zqov/SEulWjN0Sc399FcTK8bko8eSmmX3G8zNzLhCyFEGJd/0O1KDfrbAbkE6TRMtarbnDsqkZdUJ0qa5GIwOk6MKu9RB+3wEEkqcg5qYFLlVzVAHbaC2QV36HqJjHPGwFqiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739188104; c=relaxed/simple;
	bh=H8zuGLErLeAAhpDEAvecFpXqYtOdttIFW4IPa0zwnA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FdrlaoqjiEzJyEzHhckvmqYqykzf4cfrew5dZkkhVySGfVa8SEIDOxU+hcfAZ/6hpTttVFyUIGwK0ni6vji5FQhF0mlEOKwOCslwKhxBUnBU47J0SpzuxjLefiNSb+NGLMcdgSCl/Zyg7K2BHVtGapvN5EZxzwXUYf5sYe2pXmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GNhTTGYZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51A8wtIs024312;
	Mon, 10 Feb 2025 11:48:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G6RYGd5+0vaN5MIhswtJQEfS1LTYnDS9+Lc/lQmvCk4=; b=GNhTTGYZb2RpBKXi
	jtdRVf2XzA6N9JYIy/h5ZyeSBc8KZjUMZ6438UDE7/CX7zOA8F1REpV1TuyQboe6
	vh9Ht7sDMc7x0c0zQa61+qF6Le1KHJlL9VfPgus1pjyC8dPnHKK58b76tUqIP1na
	TJIQlxuapy7Jpo5Vtz8anfin8DT5RaY3L18qPM8Z6f02A7jkhjyac7Bg52sBuTLL
	p58fRqhIS2Lq7HzWHxZLQ0EAtQ5wZmL/SoSUZWZJGW4NRnyqPLMMMo7RwfLpfzvY
	fZdTMDO4Z3zcO4I2zI054+znsTqFwMS0N+nWtrRd8LDgOfMrApodMB+RBRzGg4Y6
	FYWF/A==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44p0dxm7w5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 11:48:17 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51ABmHUm004454
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 11:48:17 GMT
Received: from [10.152.201.53] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 10 Feb
 2025 03:48:13 -0800
Message-ID: <7995fc50-b13a-85ab-cb3a-782720cb1353@quicinc.com>
Date: Mon, 10 Feb 2025 17:18:01 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] dmaengine: qcom: bam_dma: Avoid accessing BAM_REVISION on
 remote BAM
To: Stephan Gerhold <stephan.gerhold@linaro.org>,
        Bjorn Andersson
	<bjorn.andersson@oss.qualcomm.com>
CC: Vinod Koul <vkoul@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        Georgi Djakov <djakov@kernel.org>
References: <20250207-bam-read-fix-v1-1-027975cf1a04@oss.qualcomm.com>
 <Z6m8btwhJ9q4RjB6@linaro.org>
Content-Language: en-US
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <Z6m8btwhJ9q4RjB6@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HuPL1iLivtZ5sLyWZ4N900-XbCN7Il4j
X-Proofpoint-ORIG-GUID: HuPL1iLivtZ5sLyWZ4N900-XbCN7Il4j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_07,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502100099



On 2/10/2025 2:14 PM, Stephan Gerhold wrote:
> On Fri, Feb 07, 2025 at 12:17:33PM -0800, Bjorn Andersson wrote:
>> Commit '57a7138d0627 ("dmaengine: qcom: bam_dma: Avoid writing
>> unavailable register")' made this read unconditional, in order to
>> identify if the instance is BAM-NDP or BAM-Lite.
>> But the BAM_REVISION register is not accessible on remotely managed BAM
>> instances and attempts to access it causes the system to crash.
>>
>> Move the access back to be conditional and expand the checks that was
>> introduced to restore the old behavior when no revision information is
>> available.
>>
>> Fixes: 57a7138d0627 ("dmaengine: qcom: bam_dma: Avoid writing unavailable register")
>> Reported-by: Georgi Djakov <djakov@kernel.org>
>> Closes: https://lore.kernel.org/lkml/9ef3daa8-cdb1-49f2-8d19-a72d6210ff3a@kernel.org/
>> Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> 
> This patch fixes the most critical regression (the bus hang), but the
> in_range(..., BAM_NDP) checks are also wrong. They do not consider the
> plain "BAM" type where the register is apparently also available. The
> check should be !in_range(..., BAM_LITE) instead to fix this.
> 
> I mentioned this twice to Md Sadre Alam [1, 2], but a fix was
> unfortunately never sent for that part of the regression.

I apologize for the delay. I was attending to a family member's medical 
emergency and couldn't address this sooner. I will test and post a new 
revision as soon as possible.

Thanks
Alam

> 
> I think we should take Caleb's patch and revert the entire patch for the
> 6.14 cycle. There are several incorrect assumptions in the original
> patch, it will be easier to review a fixed version with the full diff,
> rather than looking at incremental fixups.
> 
> On a somewhat related note, I'm working on a patch series for bam_dma to
> clean up the handling of remotely controlled BAMs. It will make it more
> clear when it's safe to access BAM registers and when not, and should
> allow reading the revision also for remotely controlled BAMs. This would
> avoid the need for all these if (!bdev->bam_revision) checks.
> 
> Thanks,
> Stephan
> 
> [1]: https://lore.kernel.org/linux-arm-msm/Z4D2jQNNW94qGIlv@linaro.org/
> [2]: https://lore.kernel.org/linux-arm-msm/Z4_U19_QyH2RJvKW@linaro.org/
> 
>> ---
>>   drivers/dma/qcom/bam_dma.c | 15 ++++++++-------
>>   1 file changed, 8 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
>> index c14557efd577..d42d913492a8 100644
>> --- a/drivers/dma/qcom/bam_dma.c
>> +++ b/drivers/dma/qcom/bam_dma.c
>> @@ -445,8 +445,8 @@ static void bam_reset(struct bam_device *bdev)
>>   	writel_relaxed(val, bam_addr(bdev, 0, BAM_CTRL));
>>   
>>   	/* set descriptor threshold, start with 4 bytes */
>> -	if (in_range(bdev->bam_revision, BAM_NDP_REVISION_START,
>> -		     BAM_NDP_REVISION_END))
>> +	if (!bdev->bam_revision ||
>> +	    in_range(bdev->bam_revision, BAM_NDP_REVISION_START, BAM_NDP_REVISION_END))
>>   		writel_relaxed(DEFAULT_CNT_THRSHLD,
>>   			       bam_addr(bdev, 0, BAM_DESC_CNT_TRSHLD));
>>   
>> @@ -1006,8 +1006,8 @@ static void bam_apply_new_config(struct bam_chan *bchan,
>>   			maxburst = bchan->slave.src_maxburst;
>>   		else
>>   			maxburst = bchan->slave.dst_maxburst;
>> -		if (in_range(bdev->bam_revision, BAM_NDP_REVISION_START,
>> -			     BAM_NDP_REVISION_END))
>> +		if (!bdev->bam_revision ||
>> +		    in_range(bdev->bam_revision, BAM_NDP_REVISION_START, BAM_NDP_REVISION_END))
>>   			writel_relaxed(maxburst,
>>   				       bam_addr(bdev, 0, BAM_DESC_CNT_TRSHLD));
>>   	}
>> @@ -1199,11 +1199,12 @@ static int bam_init(struct bam_device *bdev)
>>   	u32 val;
>>   
>>   	/* read revision and configuration information */
>> -	val = readl_relaxed(bam_addr(bdev, 0, BAM_REVISION));
>> -	if (!bdev->num_ees)
>> +	if (!bdev->num_ees) {
>> +		val = readl_relaxed(bam_addr(bdev, 0, BAM_REVISION));
>>   		bdev->num_ees = (val >> NUM_EES_SHIFT) & NUM_EES_MASK;
>>   
>> -	bdev->bam_revision = val & REVISION_MASK;
>> +		bdev->bam_revision = val & REVISION_MASK;
>> +	}
>>   
>>   	/* check that configured EE is within range */
>>   	if (bdev->ee >= bdev->num_ees)
>>
>> ---
>> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
>> change-id: 20250207-bam-read-fix-2b31297d3fa1
>>
>> Best regards,
>> -- 
>> Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
>>

