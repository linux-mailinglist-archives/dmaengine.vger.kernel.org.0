Return-Path: <dmaengine+bounces-4177-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D7FA1A3E4
	for <lists+dmaengine@lfdr.de>; Thu, 23 Jan 2025 13:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B2363A2264
	for <lists+dmaengine@lfdr.de>; Thu, 23 Jan 2025 12:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C25920F073;
	Thu, 23 Jan 2025 12:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OVZdUDWz"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35FC20E6F2;
	Thu, 23 Jan 2025 12:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737634128; cv=none; b=gJtqgusmYGWjj6SHv4KoqDO3QZtRc8wumyCCB8TNYtnL+Ed3va51pPYoPRIjASODtMg9eLdiIQKoO3sLfPQmIxm3FyoE2K4YNfN/Ngl+hOWZaD4feY4j+ILSm2VhMN1B1blzeOViehAMRUAN5JcSIbGjzacfWOmKdkaMfJTx8TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737634128; c=relaxed/simple;
	bh=CY2KL99ADxXmaFRciBVjl34ri6Fw15TM5vcpYpXJA6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Wct8qJ7MiFv5mBwF0potXyxsmg/I9sfavcFG0Hy5tzu5Bh7uXvdHsugg9feUJx/4rtwZHtdEIOnHp3ZWWvsz3bRd24D27suW+xGZO2wEgmWcMVNMw7T6ZyPf9RObCSj244touRuB8PEKuGhAD3OF/pvUx6Uvl5hM701GLJzhS20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OVZdUDWz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50NA7ZXi010850;
	Thu, 23 Jan 2025 12:08:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eRs8cdWRm/E5Emzy8YnMeOsqRgeegOs+VzcCtT7pbFg=; b=OVZdUDWz+JnQzuC9
	ZPD9DOp6+3Sdz+JCCRJSn1/qiKRYZ0thMvn/HDbJKLMIcrDRE/XpAZ3TtJFfiuKp
	MkpU5oOEyQI8zFSO1+L+2000yjEMdULXCoQK8KmJu16RWrsf4Fr9qyQVpg8GtjfM
	Dr0YEVUyLO+XQbswxuWiWDC7e8/A82+80gzmVAKmVpNGms43cxMIYhvEZLkoZPyB
	HRWc0B1vnQc5JIO5U6hPXLOdPdCmslmffW6sGldVlCq1R5vIit0d0zPncp0HD1Vo
	i6xDer1+3Xne3brVDRfrbiR2JlxKgS5b0G3eELwRuaKOV6/Tm4PmmqMJmkH7JEuL
	IgAvdQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44bkr8g98u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 12:08:41 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50NC8f4S003219
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 12:08:41 GMT
Received: from [10.151.36.43] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 23 Jan
 2025 04:08:37 -0800
Message-ID: <63609692-ebfc-b0d2-cf7e-b6f591a34e7e@quicinc.com>
Date: Thu, 23 Jan 2025 17:38:15 +0530
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
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <vkoul@kernel.org>, <kees@kernel.org>, <fenghua.yu@intel.com>,
        <linux-arm-msm@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <djakov@kernel.org>,
        <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
References: <20250121091241.2646532-1-quic_mdalam@quicinc.com>
 <okiy7n5nvjadbfczmnn2eoxwe36ilug5xutben3rg2nkvpehb5@kr2t4hvidaht>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <okiy7n5nvjadbfczmnn2eoxwe36ilug5xutben3rg2nkvpehb5@kr2t4hvidaht>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: aPBRPPJbwaTEn6IdcdnIKMawolT-f7Xu
X-Proofpoint-GUID: aPBRPPJbwaTEn6IdcdnIKMawolT-f7Xu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_05,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501230092



On 1/21/2025 4:24 PM, Dmitry Baryshkov wrote:
> On Tue, Jan 21, 2025 at 02:42:41PM +0530, Md Sadre Alam wrote:
>> This patch resolves a bug from the previous commit where the
> 
> Please check Documentation/process/submitting-patches.rst, 'This
> patch...'
Ok
> 
>> BAM_DESC_CNT_TRSHLD register was conditionally written based on BAM-NDP
>> mode. The issue was reading the BAM_REVISION register hanging if num-ees
> 
> First start with the issue description, then proceed to the changes
> description.
Ok
> 
>> was not zero, which occurs when the SoCs power on BAM remotely. So the
>> BAM_REVISION register read has been moved to inside if condition.
> 
> Imperative language, please. While we are at it, please also fix commit
> subject.
Sure , will fix this in next revision.
> 
>>
>> Fixes: 57a7138d0627 ("dmaengine: qcom: bam_dma: Avoid writing unavailable register")
>> Reported-by: Georgi Djakov <djakov@kernel.org>
>> Link: https://lore.kernel.org/lkml/9ef3daa8-cdb1-49f2-8d19-a72d6210ff3a@kernel.org/
>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
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
> 
> Please extend the comment, mentioning why the register is read only in
> !num_ees case. BTW: how do we get revision if num_ees != 0?
This revision register we need only to differentiate b/w BAM-Lite and
BAM-NDP. if num_ees != 0 then no need read this revision register.
The SOCs which is having BAM-NDP and BAM-Lite having num_ees = 0.
> 
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
> 

