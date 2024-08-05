Return-Path: <dmaengine+bounces-2793-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F4C947C5C
	for <lists+dmaengine@lfdr.de>; Mon,  5 Aug 2024 16:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A977A1F234B5
	for <lists+dmaengine@lfdr.de>; Mon,  5 Aug 2024 14:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2E650269;
	Mon,  5 Aug 2024 14:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Cj15Aucu"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288D533080;
	Mon,  5 Aug 2024 14:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722866506; cv=none; b=U63XTn0zDCBxQ33diZKTU/gBry5qsDKLdKtGYOJza8KB/OjucZK78bs2xdKRnaX5Da5T+jrBq0JzV+QZxgjsfcplCMyMS6JuzdNPobkwbL/Yhb7DWSRojveMGM3z0RMCl/twVVoH3NRcNhiJBB039fawFZLEuYb+/zaYSrHgKaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722866506; c=relaxed/simple;
	bh=7sUgatBDskJqUnx8+ur3ga8RFhAtS/mr25ctjJF+9fk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aThcW4qVI6R7Ugp59VQZyBcruvVz7Tgvsuq9825ZcfuQVyRt8WnScVLhZ6ROS4ykBEv8Xrn66UnR2JxJyihtUC+6O/UB5gG2cApF1wVrC+49gwut96yRzKVjeGu133X8V3XydKq5+nLNjdCIF5Axs9XlSOLcktVpJxy5R5V1gGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Cj15Aucu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 475CNFmc019897;
	Mon, 5 Aug 2024 14:01:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K4Tiis6dmOiCm866RJSL9aIC0QOcW+tOWM8V2CSXDrY=; b=Cj15AucuhSvhdyg2
	QW8Fo2ccnLtecFzgE/blvI6u5D8V6KVvdxl2fRLPYne9Q3dqDfeJWOSm1iUnCauY
	NXsj9FAzqAAR4P2qxs5TAHUskyZmuO7Zkx8fZnUFVVvyjRWFuq7YtJGWYDBt99Rq
	GhUIr5tMFmnJQtpNyM2tK43A9IyCEXpRG9BN1+lHIztM8IWAeAtfQlC5ZMKywEb9
	CdV0I5iDFmZnOy4S7au00onWOg6b/eM853qyA6T7kkdLGWiIYKb2en0lxEItPinf
	4XLYPyz9npTsWTFprZ52WAwotiNymFtY7JmCrWm5iqzGeH5OUlos54doncKGCqcG
	FTnEOQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40scs2v4r8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Aug 2024 14:01:31 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 475E1Voq012941
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 Aug 2024 14:01:31 GMT
Received: from [10.217.219.66] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 5 Aug 2024
 07:01:27 -0700
Message-ID: <6faa27be-54eb-ca00-f2a8-de3eb6fa7547@quicinc.com>
Date: Mon, 5 Aug 2024 19:30:14 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/2] dmaengine: dw-edma: Fix unmasking STOP and ABORT
 interrupts for HDMA
Content-Language: en-US
To: Serge Semin <fancer.lancer@gmail.com>
CC: <manivannan.sadhasivam@linaro.org>, <vkoul@kernel.org>,
        <quic_shazhuss@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_nayiluri@quicinc.com>,
        <quic_krichai@quicinc.com>, <quic_vbadigan@quicinc.com>,
        <stable@vger.kernel.org>, Cai Huoqing <cai.huoqing@linux.dev>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1721740773-23181-1-git-send-email-quic_msarkar@quicinc.com>
 <1721740773-23181-2-git-send-email-quic_msarkar@quicinc.com>
 <dnvoktjxx2m5oy2m5ocrgyd4veypnjbjnth364hl32ou4gm3t2@tjxrsowsabgr>
From: Mrinmay Sarkar <quic_msarkar@quicinc.com>
In-Reply-To: <dnvoktjxx2m5oy2m5ocrgyd4veypnjbjnth364hl32ou4gm3t2@tjxrsowsabgr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Cbmd1yMSee1QOYIsrlaTexI_98MEIkG-
X-Proofpoint-GUID: Cbmd1yMSee1QOYIsrlaTexI_98MEIkG-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-05_02,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 suspectscore=0 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxlogscore=520 phishscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408050100


On 8/2/2024 5:12 AM, Serge Semin wrote:
> On Tue, Jul 23, 2024 at 06:49:31PM +0530, Mrinmay Sarkar wrote:
>> The current logic is enabling both STOP_INT_MASK and ABORT_INT_MASK
>> bit. This is apparently masking those particular interrupts rather than
>> unmasking the same. If the interrupts are masked, they would never get
>> triggered.
>>
>> So fix the issue by unmasking the STOP and ABORT interrupts properly.
>>
>> Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
>> cc: stable@vger.kernel.org
>> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
>> ---
>>   drivers/dma/dw-edma/dw-hdma-v0-core.c | 9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
>> index 10e8f07..fa89b3a 100644
>> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
>> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
>> @@ -247,10 +247,11 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>>   	if (first) {
>>   		/* Enable engine */
>>   		SET_CH_32(dw, chan->dir, chan->id, ch_en, BIT(0));
>> -		/* Interrupt enable&unmask - done, abort */
>> -		tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup) |
>> -		      HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK |
>> -		      HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_ABORT_INT_EN;
> Just curious, if all the interrupts were actually masked, how has this
> been even working?.. In other words if it affected both local and
> remote interrupts, then the HDMA driver has never actually worked,
> right?

Agreed, it should not work as interrupts were masked.

But as we are enabling LIE/RIE bits (LWIE/RWIE) that eventually enabling 
watermark
interrupt in HDMA case and somehow on device I could see interrupt was
generating with watermark and stop bit set and it was working.
Since we were not clearing watermark interrupt, it was also causing 
storm of interrupt.

>> +		/* Interrupt unmask - STOP, ABORT */
>> +		tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup) &
>> +		      ~HDMA_V0_STOP_INT_MASK & ~HDMA_V0_ABORT_INT_MASK;
> Please convert this to:
> +		/* Interrupt unmask - stop, abort */
> +		tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup);
> +		tmp &= ~(HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
>
> -Serge(y)

Sure. Will do

Thanks,
Mrinmay

>> +		/* Interrupt enable - STOP, ABORT */
>> +		tmp |= HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_ABORT_INT_EN;
>>   		if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL))
>>   			tmp |= HDMA_V0_REMOTE_STOP_INT_EN | HDMA_V0_REMOTE_ABORT_INT_EN;
>>   		SET_CH_32(dw, chan->dir, chan->id, int_setup, tmp);
>> -- 
>> 2.7.4
>>

