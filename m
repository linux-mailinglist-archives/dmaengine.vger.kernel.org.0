Return-Path: <dmaengine+bounces-3926-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3B29E8AFC
	for <lists+dmaengine@lfdr.de>; Mon,  9 Dec 2024 06:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E316A280E6D
	for <lists+dmaengine@lfdr.de>; Mon,  9 Dec 2024 05:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2D914AD0E;
	Mon,  9 Dec 2024 05:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pqlcVzK8"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1221B54918;
	Mon,  9 Dec 2024 05:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733722183; cv=none; b=e7ftmrMwyL1EbeL3qvX22ZhDyXx1uMAc0qC+u9gbEMVJ2TStebVqdPzFFkHIHt+5wU3sIl8229qZNBZyQ+MZLUd2uXpus8PqtrV8nT8scApx+l/6tGERm4Z1zWrocAa1OcZqdv8Kk3UlJA9HY/ytHroRuI+AoTTGiY2IvYsSQFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733722183; c=relaxed/simple;
	bh=XWuXN25o8/tV4/i4QfIb6Dsb5ZZ/K2g2SFzaRTZgaUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lttUf5HBHtUxP7YLqjK9A3q5ehUNJaPmpAT1Hk01fBUgbsDfKN1ehlesiSwQ1ZmzJ6wjJHpK2Y/t6w7Gu317gygd04DBajwVZbpEYUECYyfWLAu58ac/nAN5ZJaDXAITjyI/Wa5vgYIx9939LRXYf7pYD6e1B92/DxMkoP/AQV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pqlcVzK8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B8NRk06007232;
	Mon, 9 Dec 2024 05:29:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1oCWU0Vm9zp3f+UCJJ7u3Pibn8vpF8aDZSqYFlUyQyE=; b=pqlcVzK8PRlttv3C
	MRWr2pHPv5KnBqrdo9VgwpEclXaZBcOwSDGHm0nVXZmJcAg2HG+Y5zlZPUpS9S8V
	ArLse2zihHkWB5Lj0Vpo/uJ2LmzcHWPTQoe766vt3N/K9pSkXv9woR43ggoO+5Aw
	rIohA5zL6YB6WvRGECpNU+B8BafvoTNCPKbAPSlhKxwhhAt4Fm/QmXEzKUx5Wki6
	msT1bLINec/KC57EAKyLBGKTpljeZFpO8rSrp0tEcTWKB1hw4PE+3lxce8x/fgik
	4Li0n7KWRSJ33R9NBUIhMZ2cGjnqHEvX6J0qsMPKXjYEm0+xhZ6Ss1quB+OAn2JN
	XOLjCA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43cek1udrm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 05:29:35 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B95TY0m018334
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Dec 2024 05:29:34 GMT
Received: from [10.151.36.43] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 8 Dec 2024
 21:29:31 -0800
Message-ID: <64be3126-5d07-7490-28fc-20afd2635b8c@quicinc.com>
Date: Mon, 9 Dec 2024 10:59:28 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2] dmaengine: qcom: bam_dma: Avoid writing unavailable
 register
Content-Language: en-US
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, <vkoul@kernel.org>,
        <martin.petersen@oracle.com>, <kees@kernel.org>, <av2082000@gmail.com>,
        <fenghua.yu@intel.com>, <linux-arm-msm@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <quic_varada@quicinc.com>, <quic_srichara@quicinc.com>
References: <20241205120016.948960-1-quic_mdalam@quicinc.com>
 <2afca6ca-10eb-43b3-8730-386d6ca84b60@linaro.org>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <2afca6ca-10eb-43b3-8730-386d6ca84b60@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6WiF1a7MLFvejCZDk3prUcCz8tLospqK
X-Proofpoint-ORIG-GUID: 6WiF1a7MLFvejCZDk3prUcCz8tLospqK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxscore=0 adultscore=0 clxscore=1011 malwarescore=0 phishscore=0
 spamscore=0 mlxlogscore=938 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090042



On 12/5/2024 5:58 PM, Bryan O'Donoghue wrote:
> On 05/12/2024 12:00, Md Sadre Alam wrote:
> 
> The commit log:
> 
>> Avoid writing unavailable register in BAM-Lite mode.
>> BAM_DESC_CNT_TRSHLD register is unavailable in BAM-Lite
>> mode. Its only available in BAM-NDP mode. So avoid writing
> 
> and the action taken in the code:
> 
>> +    if (bdev->bam_revision >= BAM_LITE && bdev->bam_revision < BAM_NDP)
>> +        writel_relaxed(DEFAULT_CNT_THRSHLD,
> 
> Really don't match up. You've said in your commit log 
> BAM_DESC_CNT_TRSHLD is unavailable to the LITE module but, then you say 
> if (bam_revision >= BAM_LITE...)
> 
> How can checking if the revision == BAM_LITE match up with the stated 
> objective in your commit log => _not_ writing to DEFAULT_CNT_THRSHLD in 
> lite mode ... ?
Thank you for pointing that out. I'll address this in the next revision.
> 
> ---
> bod

