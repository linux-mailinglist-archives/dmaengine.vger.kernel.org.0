Return-Path: <dmaengine+bounces-4090-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21534A05973
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jan 2025 12:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6087B3A5B0E
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jan 2025 11:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891291F8EEC;
	Wed,  8 Jan 2025 11:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DTQPvQ+6"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD281F8667;
	Wed,  8 Jan 2025 11:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736334919; cv=none; b=FOPgWYjJ9/6LW8TXObc6YGYxD841eNQOXgjF2WcdAtroQGVOrFj6kxv7aObkJ6gkDoofNGJW9lPuYfQoeSPI746OsTsHPy9XVP4gH+CK+fIuUgz8DIsOYiqtdMjFYNi3DSVGfyh1glSxqWrq9HDJtp1G5YFuNpufxgZZiMFmflc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736334919; c=relaxed/simple;
	bh=NZQwHblK5E2xelOY7Jp0RG9QoaAHmfXPo2tUgLj4eLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cs5ALS7us8aGVANyJuBlWlX9sSQAoMRBVZhGSYEn+HD62UIGP0r3sjevuEIGWNhZRrY28UrFEK5GhSOkdio1BZTLF44x7+jPqoMDoluUQYEswedO1aHoA5gVcwZqpNrKPueZlFu05wu86LxopVopeFF4u0U5hCrpY30M4WfTtU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DTQPvQ+6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508Ad0YB021756;
	Wed, 8 Jan 2025 11:15:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bBS++8LsF7HrpW7CPyJBK6xCa27qQjkIbMEP1WS6vKo=; b=DTQPvQ+60mYZd/vt
	P25fCHTHViSZl8MFefMKKYe/z+nTFVgyf2MNPEowVyTz9e2HUGHjjzxLJ2HUoaCL
	FU7HnywxHQotJLSIUHAyVWt1X5uQ6WcNvCwKbKi/l5iIDfIZCKZXRTkhBjnRonpA
	/EPcrdI0kooj8+b6kO8eEXR7mlWk2LcTIFgm4dsi92GuoqaKHF9RwK4eoeDjlutH
	2w6LSFk62u4al5gR4UyNRfXX1oABFjlLFLrgfjtxIfGVwmtKL6KTPUnujblQyEYU
	7MMDZXxQL4wzQNOZqEzHP0/p7wC4q1jgBdubk4LlFKNUKA4aq4HKLm3M7kml9qKX
	e030hA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 441nm18ghv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 11:15:07 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 508BF6jv013913
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 Jan 2025 11:15:06 GMT
Received: from [10.151.36.43] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 8 Jan 2025
 03:15:02 -0800
Message-ID: <0b93ee40-0d1e-a137-c049-ac5adcc81e54@quicinc.com>
Date: Wed, 8 Jan 2025 16:44:59 +0530
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
To: Vinod Koul <vkoul@kernel.org>, Georgi Djakov <djakov@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <quic_mmanikan@quicinc.com>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.com>, <robin.murphy@arm.com>,
        <u.kleine-koenig@baylibre.com>, <martin.petersen@oracle.com>,
        <fenghua.yu@intel.com>, <av2082000@gmail.com>,
        <linux-kernel@vger.kernel.org>
References: <20241220094203.3510335-1-quic_mdalam@quicinc.com>
 <9ef3daa8-cdb1-49f2-8d19-a72d6210ff3a@kernel.org> <Z35dG7J8BLzeoT3B@vaman>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <Z35dG7J8BLzeoT3B@vaman>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: i63YH69VzkrIjy4EoShz8LmLlt3ERsoi
X-Proofpoint-GUID: i63YH69VzkrIjy4EoShz8LmLlt3ERsoi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1011 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501080091



On 1/8/2025 4:40 PM, Vinod Koul wrote:
> On 07-01-25, 23:30, Georgi Djakov wrote:
>> On 20.12.24 11:42, Md Sadre Alam wrote:
>>> Avoid writing unavailable register in BAM-Lite mode.
>>> BAM_DESC_CNT_TRSHLD register is unavailable in BAM-Lite
>>> mode. Its only available in BAM-NDP mode. So only write
>>> this register for clients who is using BAM-NDP.
>>>
>>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>>> ---
>>
>> My Dragonboard db845c fails to boot on recent linux-next releases and
>> git bisect points to this patch. It boots again when it's reverted.
> 
> Should we revert?
I am checking this will fix and post patch quickly.
> 
>>
>> [..]
>>
>>>    	bchan->reconfigure = 0;
>>> @@ -1192,10 +1199,11 @@ static int bam_init(struct bam_device *bdev)
>>>    	u32 val;
>>>    	/* read revision and configuration information */
>>> -	if (!bdev->num_ees) {
>>> -		val = readl_relaxed(bam_addr(bdev, 0, BAM_REVISION));
>>> +	val = readl_relaxed(bam_addr(bdev, 0, BAM_REVISION));
>>> +	if (!bdev->num_ees)
>>>    		bdev->num_ees = (val >> NUM_EES_SHIFT) & NUM_EES_MASK;
>>> -	}
>>> +
>>> +	bdev->bam_revision = val & REVISION_MASK;
>>
>> The problem seems to occur when we try to read the revision for the
>> slimbus bam instance at 0x17184000 (which has "qcom,num-ees = <2>;").
>>
>> Thanks,
>> Georgi
> 

