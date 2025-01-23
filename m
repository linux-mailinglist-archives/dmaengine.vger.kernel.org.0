Return-Path: <dmaengine+bounces-4178-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B714A1A3F6
	for <lists+dmaengine@lfdr.de>; Thu, 23 Jan 2025 13:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F35A83A5677
	for <lists+dmaengine@lfdr.de>; Thu, 23 Jan 2025 12:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0CB20E307;
	Thu, 23 Jan 2025 12:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mtCvCrJh"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D3F20CCCF;
	Thu, 23 Jan 2025 12:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737634294; cv=none; b=gBVs5lwoGv5g/J+OUr9fDY3z4hUq1+vPAzAnaGVABD/x+0QZttAOlwWFa2H6jKJcxyHEQ6qA4wnFtrxAWok6VlA56z/Gkoa9/jErRhNW2q92CsQKbRTRasjlIOW8uNtZK8iuBLbkt1OOA43WluL/mNi3CWOgJgK7QjfxW7tVeOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737634294; c=relaxed/simple;
	bh=rHdyBbCxXMpASkwHOzjfg5ZIglFrL8uyztqI3fdFGQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=J/6f9cG6HCqssNaQN+I6HfZ31EwIQBevYuyITX8nh3NxmejDSaoo06AeV3R/pSGVw9EZLIk8Qv9ttsxgbOEPPnt2efXQJvAAQCTyVxXzjPf3KuvGa2EQDA+QY5IbGvYK15NlApNKXHap4T+iUOqDeNQRgIhrryLTNsNAIjVvYO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mtCvCrJh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50N5DPha022453;
	Thu, 23 Jan 2025 12:11:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Fr92bgm7TXXnvLEBbsJKfrTbUOUplRfTdWDgfr39tOY=; b=mtCvCrJhpMUs3uht
	Ai87YAMT9GzYNx7e8TJHE7a0ZO3KInSowwU30ymhbi1tT/tIr73TSKzr06wE3xlj
	O5m59INy3JeuXULpcwZDA/t/D0tahrAru0593ZmXwIU90y/bFt9k4TPcQtnYw47z
	vOtByzxBhLSVLca8ihMMafRhBjo2tNfT7AuMFpEF5MXcwYcD43FsCHOHo72sN0I2
	if0Tb3d3scURTAqUqvGWR8alzB0m02qtappqasoYW6tQsMbFTn0uTJrGMyRm3rZ+
	MEjoxa141eZGbs/FP5/+9i96FPsC+iPxBvoZq8gZLH2DeGimePvMWXrmF6WNOioE
	Ee4rAQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44bfe4rycy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 12:11:26 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50NCBPfQ020296
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 12:11:25 GMT
Received: from [10.151.36.43] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 23 Jan
 2025 04:11:22 -0800
Message-ID: <643b01a6-030a-769a-19d5-9be60fe5ec47@quicinc.com>
Date: Thu, 23 Jan 2025 17:41:19 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3] dmaengine: qcom: bam_dma: Fix BAM_RIVISON register
 handling
Content-Language: en-US
To: Stephan Gerhold <stephan.gerhold@linaro.org>
CC: <vkoul@kernel.org>, <kees@kernel.org>, <fenghua.yu@intel.com>,
        <linux-arm-msm@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <djakov@kernel.org>,
        <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
References: <20250121091241.2646532-1-quic_mdalam@quicinc.com>
 <Z4_U19_QyH2RJvKW@linaro.org>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <Z4_U19_QyH2RJvKW@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cjqVOVM8SIBCMAe6xo0yEihGoG9sz0mE
X-Proofpoint-ORIG-GUID: cjqVOVM8SIBCMAe6xo0yEihGoG9sz0mE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_05,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 suspectscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501230093



On 1/21/2025 10:39 PM, Stephan Gerhold wrote:
> On Tue, Jan 21, 2025 at 02:42:41PM +0530, Md Sadre Alam wrote:
>> This patch resolves a bug from the previous commit where the
>> BAM_DESC_CNT_TRSHLD register was conditionally written based on BAM-NDP
>> mode. The issue was reading the BAM_REVISION register hanging if num-ees
>> was not zero, which occurs when the SoCs power on BAM remotely. So the
>> BAM_REVISION register read has been moved to inside if condition.
>>
>> Fixes: 57a7138d0627 ("dmaengine: qcom: bam_dma: Avoid writing unavailable register")
>> Reported-by: Georgi Djakov <djakov@kernel.org>
>> Link: https://lore.kernel.org/lkml/9ef3daa8-cdb1-49f2-8d19-a72d6210ff3a@kernel.org/
>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> 
> I'm afraid there are still two open problems here:
> 
>   1. In your original commit, you added the if (in_range(...)) checks to
>      make the BAM_DESC_CNT_TRSHLD register write conditional. With this
>      patch we only read the bam_revision for the !bdev->num_ees case.
>      This means that even if we have e.g. a remotely powered BAM-NDP,
>      we don't initialize BAM_DESC_CNT_TRSHLD anymore.
> 
>   2. Aside from BAM-NDP and BAM-Lite there is also plain "BAM". You
>      mentioned we should only skip the register write for BAM-Lite, but
>      the plain "BAM" isn't handled anywhere yet.
> 
> I would recommend inverting the in_range(...) checks to check for if
> (!in_range(BAM-LITE) rather than if (in_range(BAM-NDP)). This should
> also work for the plain "BAM" type. It will also avoid regressions if we
> don't read the bam_revision in the !bdev->num_ees case. (Although
> ideally you would lazily initialize the bam_revision to cover all the
> configurations.)
Thanks for explanation and suggestion. Will address all the above points
in next revision.
> 
> Thanks,
> Stephan
> 
>> ---
>>
>> Change in [v3]
>>
>> * Revised commit details
>>
>> Change in [v2]
>>
>> * Removed unnecessary if checks.
>> * Relocated the BAM_REVISION register read within the if condition.
>>
>> Change in [v1]
>>
>> * https://lore.kernel.org/lkml/1a5fc7e9-39fe-e527-efc3-1ea990bbb53b@quicinc.com/
>> * Posted initial fixup for BAM revision register read handling
>>   drivers/dma/qcom/bam_dma.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
>> index c14557efd577..d227b4f5b6b9 100644
>> --- a/drivers/dma/qcom/bam_dma.c
>> +++ b/drivers/dma/qcom/bam_dma.c
>> @@ -1199,11 +1199,11 @@ static int bam_init(struct bam_device *bdev)
>>   	u32 val;
>>   
>>   	/* read revision and configuration information */
>> -	val = readl_relaxed(bam_addr(bdev, 0, BAM_REVISION));
>> -	if (!bdev->num_ees)
>> +	if (!bdev->num_ees) {
>> +		val = readl_relaxed(bam_addr(bdev, 0, BAM_REVISION));
>>   		bdev->num_ees = (val >> NUM_EES_SHIFT) & NUM_EES_MASK;
>> -
>> -	bdev->bam_revision = val & REVISION_MASK;
>> +		bdev->bam_revision = val & REVISION_MASK;
>> +	}
>>   
>>   	/* check that configured EE is within range */
>>   	if (bdev->ee >= bdev->num_ees)
>> -- 
>> 2.34.1
>>

