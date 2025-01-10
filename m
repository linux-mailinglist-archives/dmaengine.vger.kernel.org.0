Return-Path: <dmaengine+bounces-4092-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7297BA08679
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jan 2025 06:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42F60188A1A8
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jan 2025 05:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300182054F9;
	Fri, 10 Jan 2025 05:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cx2B5eKT"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5463204F8B;
	Fri, 10 Jan 2025 05:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736486528; cv=none; b=QH28A5Q9nBo3m4/OXbst8HdldRLiIb9eb5u+NuczTojcfQB7HLEESad1kdTdpDAeooaSbtkcYI7LvrU2TtQdj2G0Tn+o8k7uBgy8rwKZPAQwZ3V4LnyGPQNl+ugwjyR68fyqBWplUz7KaL3HUjlO/t/ckic925FVDGqpqy5vh4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736486528; c=relaxed/simple;
	bh=7ZVnt1cP9p1Q0SKgbJkC80W3+Pw5+AMEG/uwziRCRCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VyuT0Xe6JkJpnrDf+fgWZwjAOU7HMkW0p27xYjCbWlcPOVA/iW6kFTDWrE2Q66YB6v8YIqFZlFmJOfPhE8EGOih/LMqFRXcsuXLEdp3DeiJFRY8/72PRzYY7a9+axclvL4asF3XqvDv8msx/vUVRMZKACSGEpwk/RyK3Kpw6VDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cx2B5eKT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50A1G08M014435;
	Fri, 10 Jan 2025 05:21:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YFXnRoTh2b7fA21RcyknzULo3yCp0kukV1uuwilji2w=; b=cx2B5eKT4C4aS/jo
	1AgM3hLRbQ4Zn9RMnotCTnra8tT5K82s6pAxEr3YehhaIcYtB5Zg8Bw/BsT9ntBL
	KBKxBteb/ObPm8OboDayCNdNt29DPr7eOwZDaOT1b2p5uhZeVOP3yoZMFtaNkryN
	upPmwQIiq5yN7PBEDLG2jjPIjwMzc7EJKiaaFMx0vhNORB5WzD0DaSG6lQKFQ81O
	WBHOijxruHJW/Qm2wbgVLLN3w5IoZUtfEq4L+UM6T0LTB5+NGrYnFOoyLQgE8wNH
	KlDZKSXIUoq4aHqsbUDY6v9lXZROsA3PBGDY4sGPrApws0wRFQL3YRr8LW58iPjb
	a9pzyg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 442sqvgf2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 05:21:56 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50A5LuFZ028500
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 05:21:56 GMT
Received: from [10.151.36.43] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 9 Jan 2025
 21:21:51 -0800
Message-ID: <43d86040-ff8e-4c48-9163-e9a2648e1f91@quicinc.com>
Date: Fri, 10 Jan 2025 10:51:48 +0530
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
To: Georgi Djakov <djakov@kernel.org>, <vkoul@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <dmaengine@vger.kernel.org>
CC: <quic_mmanikan@quicinc.com>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.com>, <robin.murphy@arm.com>,
        <u.kleine-koenig@baylibre.com>, <martin.petersen@oracle.com>,
        <fenghua.yu@intel.com>, <av2082000@gmail.com>,
        <linux-kernel@vger.kernel.org>
References: <20241220094203.3510335-1-quic_mdalam@quicinc.com>
 <9ef3daa8-cdb1-49f2-8d19-a72d6210ff3a@kernel.org>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <9ef3daa8-cdb1-49f2-8d19-a72d6210ff3a@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ouKHyT4lwQpiMZwmjdf7ghbYCy7IiD3g
X-Proofpoint-ORIG-GUID: ouKHyT4lwQpiMZwmjdf7ghbYCy7IiD3g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 malwarescore=0 clxscore=1015 suspectscore=0 bulkscore=0
 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501100042



On 1/8/2025 3:00 AM, Georgi Djakov wrote:
> On 20.12.24 11:42, Md Sadre Alam wrote:
>> Avoid writing unavailable register in BAM-Lite mode.
>> BAM_DESC_CNT_TRSHLD register is unavailable in BAM-Lite
>> mode. Its only available in BAM-NDP mode. So only write
>> this register for clients who is using BAM-NDP.
>>
>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>> ---
> 
> My Dragonboard db845c fails to boot on recent linux-next releases and
> git bisect points to this patch. It boots again when it's reverted.
> 
> [..]
> 
>>       bchan->reconfigure = 0;
>> @@ -1192,10 +1199,11 @@ static int bam_init(struct bam_device *bdev)
>>       u32 val;
>>       /* read revision and configuration information */
>> -    if (!bdev->num_ees) {
>> -        val = readl_relaxed(bam_addr(bdev, 0, BAM_REVISION));
>> +    val = readl_relaxed(bam_addr(bdev, 0, BAM_REVISION));
>> +    if (!bdev->num_ees)
>>           bdev->num_ees = (val >> NUM_EES_SHIFT) & NUM_EES_MASK;
>> -    }
>> +
>> +    bdev->bam_revision = val & REVISION_MASK;
> 
> The problem seems to occur when we try to read the revision for the
> slimbus bam instance at 0x17184000 (which has "qcom,num-ees = <2>;").
I have posted the fix. Patch available at [1]
[1] 
https://patchwork.kernel.org/project/linux-arm-msm/patch/20250110051409.4099727-1-quic_mdalam@quicinc.com/

Please check once.

Thanks,
Alam.

