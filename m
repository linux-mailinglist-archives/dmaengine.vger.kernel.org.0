Return-Path: <dmaengine+bounces-4103-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE837A08FDF
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jan 2025 13:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02F013A869F
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jan 2025 11:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA15520B806;
	Fri, 10 Jan 2025 11:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Q4jOWKdK"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A76520766F;
	Fri, 10 Jan 2025 11:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736510396; cv=none; b=r3tAjutmFeZdinS+O1XILC7KKjTCxAkdC5RCdMX/ydI63nrZrqW6HpBsxN/USulYVyvE2MIPwH5gS1vDW1U96KTykcwyI0Lun9n9TPJH+F9Y4HgR093TcFe94swTHKCh5qUpMPtTy1ntytifwqAuOshPGTul8E2mua3MxOgpEv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736510396; c=relaxed/simple;
	bh=FQLWjyocoL9BcrkbiRPJbRqQR4ZhLPKxxLq/sFaD+fE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cKhNLfHhHQObtt0qC4wYFTqwxeyBeDvvaz+7n5OTdGt20HgJOBhzwLe47LSj2GSFEJDASlKbB0K0epfUDbefEhbBxfvVR48jOk6OA65pYG1+ugDncnffQQznZn1GnSh0x13yD+b9XTjwDupxZ3YbSxbUlfaqVFzeIBb21920X5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Q4jOWKdK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50A8fdYg014132;
	Fri, 10 Jan 2025 11:59:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SZgP6uYmHwtbZmnuC8Ro/YIEPHxfn46wYSPKlRUmG4s=; b=Q4jOWKdKsZPnb1tJ
	LXYdeB/qQSrA7xS3pFY8UWy7PLceaskC2jrNUYEdOgCsFSHLVEWU0N60hZnDfiyy
	QCeSDrriUmwP+6a6I4y+d4rttI0zhBohwMV8eaxQfwRHla5Rge8mAhmbYGsoAM+U
	4u16c/fg/w9IMPR5WxohB3uwu8L/NZxEFUfrMHnjbcD2KDP2nTDqMPDUrTj+lzrR
	qL+25G1bZ0b3xIUFXwriw6NfsUlGSI3kdifOIy3ezWqrXGMMlmmckfq1LNGjM+ZY
	ypRmrnn0etkv8Q1myMYbcB0P3RKYAjz2qRfubXdMEeaaiMtwTyA22LG4fUMOLjPU
	hgdYiA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4430900h4r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 11:59:37 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50ABxaA5017770
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 11:59:36 GMT
Received: from [10.151.36.43] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 10 Jan
 2025 03:59:32 -0800
Message-ID: <fb253fa0-7877-e1b8-138a-b9d9a80c81f1@quicinc.com>
Date: Fri, 10 Jan 2025 17:29:29 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4] dmaengine: qcom: bam_dma: Avoid writing unavailable
 register
Content-Language: en-US
To: Stephan Gerhold <stephan.gerhold@linaro.org>
CC: <vkoul@kernel.org>, <robin.murphy@arm.com>, <u.kleine-koenig@baylibre.com>,
        <martin.petersen@oracle.com>, <fenghua.yu@intel.com>,
        <av2082000@gmail.com>, <linux-arm-msm@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_mmanikan@quicinc.com>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.com>
References: <20241220094203.3510335-1-quic_mdalam@quicinc.com>
 <Z4D2jQNNW94qGIlv@linaro.org>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <Z4D2jQNNW94qGIlv@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9BdRzZU5dREC_bFaK7UnLnYhXG0tj8us
X-Proofpoint-ORIG-GUID: 9BdRzZU5dREC_bFaK7UnLnYhXG0tj8us
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999 mlxscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501100093



On 1/10/2025 3:59 PM, Stephan Gerhold wrote:
> On Fri, Dec 20, 2024 at 03:12:03PM +0530, Md Sadre Alam wrote:
>> Avoid writing unavailable register in BAM-Lite mode.
>> BAM_DESC_CNT_TRSHLD register is unavailable in BAM-Lite
>> mode. Its only available in BAM-NDP mode. So only write
>> this register for clients who is using BAM-NDP.
>>
>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> 
> What are we actually fixing here? Which platform is affected? Is there a
> crash, reset, or incorrect behavior?
On SDX75, QPIC use BAM-Lite and as per HW description this
BAM_DESC_CNT_TRSHLD register is not available, and writing to this
SDX75 was hanging.
> 
> We have had this code for years without reported issues, with both
> BAM-NDP and BAM-Lite instances. The register documentation on APQ8016E
> documents the BAM_DESC_CNT_TRSHLD register even for the BAM-Lite
> instance. There is a comment that it doesn't apply to BAM-Lite, but I
> would expect the written value just ends up being ignored in that case.
With older xPU it was being ignored but with new xPU its hanging. HW
team suggested don't write this register for BAM-Lite mode since its not
available.
> 
> Also, there is not just BAM-NDP and BAM-Lite, but also plain "BAM". What
> about that one? Should we write to BAM_DESC_CNT_TRSHLD?
Apart from BAM-Lite this register available in all the BAM
> 
>> ---
>> Change in [v4]
>>
>> * Added in_range() macro
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
>>     BAM_NDP_REVISION_END
>>
>> Change in [v2]
>>
>> * Replace 0xff with REVISION_MASK in the statement
>>     bdev->bam_revision = val & REVISION_MASK
>>
>> Change in [v1]
>>
>> * Added initial patch
>>
>>   drivers/dma/qcom/bam_dma.c | 24 ++++++++++++++++--------
>>   1 file changed, 16 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
>> index bbc3276992bb..c14557efd577 100644
>> --- a/drivers/dma/qcom/bam_dma.c
>> +++ b/drivers/dma/qcom/bam_dma.c
>> @@ -59,6 +59,9 @@ struct bam_desc_hw {
>>   #define DESC_FLAG_NWD BIT(12)
>>   #define DESC_FLAG_CMD BIT(11)
>>   
>> +#define BAM_NDP_REVISION_START	0x20
>> +#define BAM_NDP_REVISION_END	0x27
>> +
> 
> Are you sure this covers all SoCs we support upstream? If one of the
> older or newer supported SoCs uses a value outside of this range, it
> will now be missing the register write.
I got this data from HW team. Will confirm once again if any SOCs we are 
missing.

Thanks,
Alam.

