Return-Path: <dmaengine+bounces-2818-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C0394AEC8
	for <lists+dmaengine@lfdr.de>; Wed,  7 Aug 2024 19:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22F18B21392
	for <lists+dmaengine@lfdr.de>; Wed,  7 Aug 2024 17:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537F613A276;
	Wed,  7 Aug 2024 17:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Lrl96Sr6"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6B66BB4B;
	Wed,  7 Aug 2024 17:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723051201; cv=none; b=fNUl4IgrR9GlgFuxxdGLnJoTJjuUbZ6iP9iUeDqWvqtKPIYhykk7imsBN+vhAqaXqm/PTre8s0lTfoiWb+WqbQHLyIn3sJX9f5VKDqVomDnv0WOv8LpmiprPErKL7Pa6N935StneFsrcIGKIKFzYOu2+ojoS1DbgwFHL2RPSg1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723051201; c=relaxed/simple;
	bh=o/BGnLtpTKjPL5WS/ZzCIYzntgi9WJKyiTLSnHISQOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZPNIA3+dVAwoWndNhAOPC3wLKv6a4t980syxL4zZ3YTGrH9/lNip6yTsl0mStCx9tWZcP1tsGih+zgoGQxksKdHilA7GC6msKvealNW2BqkMQrp3lI1Udvom8xyOE8PApmc6ajzcUNZM24Ucir3VEGvQp2t2BazftQJ24ov/vCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Lrl96Sr6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47783A5O015915;
	Wed, 7 Aug 2024 17:19:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xg18hhOiid4XVBz8qbRkIMBM8P++Q4+59FV7Xg8OAno=; b=Lrl96Sr6eyaVbyuB
	m8dKVm7N3QQwEN4HlF5TeIHqldZhWePNc9DkUzYWebrDM83BPeQBxI2HsgVzNfDN
	0gJQ6Wr5qgJMRYmFenHoL7uvEnGK/kguG2PHvW+qxk86v9PSxWy2xetwoLUE4A7V
	8CH2fiQVn/J74xlshCM/Vb47Pj0rqxgcuGzCzoHFMe7hDe/pjbF5lrcvxF6sIOyZ
	Xj/rr1qDjfrqRIBLXP89sAcSm9suu81OAwZmLuR3o6ctTu7Gyd9JEjkGRFEysVhr
	RPckrCddV+8zc7wSJYZEDONWi4C2rkE8ZA6q6uNDBh89McpUoTi5CYpH2rAUATEX
	RxtL0Q==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40sc4ybdbx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Aug 2024 17:19:52 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 477HJpVX019316
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 7 Aug 2024 17:19:51 GMT
Received: from [10.216.8.236] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 7 Aug 2024
 10:19:46 -0700
Message-ID: <b7fd3fac-77e4-7aad-e97a-c210aeb53773@quicinc.com>
Date: Wed, 7 Aug 2024 22:49:42 +0530
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
 <6faa27be-54eb-ca00-f2a8-de3eb6fa7547@quicinc.com>
 <by7uqtmnx4jjxigbm3lrpp2b3eqcrq3byqrrmexmkkigtjxdir@o7ahdlhpgzjl>
From: Mrinmay Sarkar <quic_msarkar@quicinc.com>
In-Reply-To: <by7uqtmnx4jjxigbm3lrpp2b3eqcrq3byqrrmexmkkigtjxdir@o7ahdlhpgzjl>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SAZr4PwLc_b0JFSxYUc4Cz5ldxAYUT-S
X-Proofpoint-GUID: SAZr4PwLc_b0JFSxYUc4Cz5ldxAYUT-S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-07_11,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 mlxlogscore=756 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408070119


On 8/7/2024 4:26 AM, Serge Semin wrote:
> On Mon, Aug 05, 2024 at 07:30:14PM +0530, Mrinmay Sarkar wrote:
>> On 8/2/2024 5:12 AM, Serge Semin wrote:
>>> On Tue, Jul 23, 2024 at 06:49:31PM +0530, Mrinmay Sarkar wrote:
>>>> The current logic is enabling both STOP_INT_MASK and ABORT_INT_MASK
>>>> bit. This is apparently masking those particular interrupts rather than
>>>> unmasking the same. If the interrupts are masked, they would never get
>>>> triggered.
>>>>
>>>> So fix the issue by unmasking the STOP and ABORT interrupts properly.
>>>>
>>>> Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
>>>> cc: stable@vger.kernel.org
>>>> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
>>>> ---
>>>>    drivers/dma/dw-edma/dw-hdma-v0-core.c | 9 +++++----
>>>>    1 file changed, 5 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
>>>> index 10e8f07..fa89b3a 100644
>>>> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
>>>> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
>>>> @@ -247,10 +247,11 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>>>>    	if (first) {
>>>>    		/* Enable engine */
>>>>    		SET_CH_32(dw, chan->dir, chan->id, ch_en, BIT(0));
>>>> -		/* Interrupt enable&unmask - done, abort */
>>>> -		tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup) |
>>>> -		      HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK |
>>>> -		      HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_ABORT_INT_EN;
>>> Just curious, if all the interrupts were actually masked, how has this
>>> been even working?.. In other words if it affected both local and
>>> remote interrupts, then the HDMA driver has never actually worked,
>>> right?
>> Agreed, it should not work as interrupts were masked.
>>
>> But as we are enabling LIE/RIE bits (LWIE/RWIE) that eventually enabling
>> watermark
>> interrupt in HDMA case and somehow on device I could see interrupt was
>> generating with watermark and stop bit set and it was working.
>> Since we were not clearing watermark interrupt, it was also causing storm of
>> interrupt.
> Is it possible that the HDMA_V0_STOP_INT_MASK and
> HDMA_V0_ABORT_INT_MASK masks affect the local IRQs only? If so than
> that shall explain why for instance Kory hasn't met the problem.
>
> Based on the "Interrupts and Error Handling" figures of the DW EDMA
> databook the DMA_READ_INT_MASK_OFF/DMA_WRITE_INT_MASK_OFF CSRs mask of
> the IRQ delivered via the edma_int[] wire. Meanwhile the IMWr TLPs
> generation depend on the RIE/LLRAIE flags state only.
Ideally HDMA_V0_STOP_INT_MASK and HDMA_V0_ABORT_INT_MASK masks affect
both local and remote IRQs.

As per DW HDMA "Interrupts and Error Handling" figure 
HDMA_INT_SETUP_OFF_[WR|
RD] mask of the IRQ delivered via the edma_int[] wire.
And IMWr TLPs generation depend on 3 flags i.e HDMA_INT_SETUP_OFF_[WR|
RD].RSIE flag for stop IMWr, RWIE flag for watermark IMWr and 
HDMA_INT_SETUP_OFF_[WR|R
D].RAIE flag for abort IMWr generation.

Thanks,
Mrinmay
>>>> +		/* Interrupt unmask - STOP, ABORT */
>>>> +		tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup) &
>>>> +		      ~HDMA_V0_STOP_INT_MASK & ~HDMA_V0_ABORT_INT_MASK;
>>> Please convert this to:
>>> +		/* Interrupt unmask - stop, abort */
>>> +		tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup);
>>> +		tmp &= ~(HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
>>>
>>> -Serge(y)
>> Sure. Will do
> Thanks.
>
> -Serge(y)
>
>> Thanks,
>> Mrinmay
>>
>>>> +		/* Interrupt enable - STOP, ABORT */
>>>> +		tmp |= HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_ABORT_INT_EN;
>>>>    		if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL))
>>>>    			tmp |= HDMA_V0_REMOTE_STOP_INT_EN | HDMA_V0_REMOTE_ABORT_INT_EN;
>>>>    		SET_CH_32(dw, chan->dir, chan->id, int_setup, tmp);
>>>> -- 
>>>> 2.7.4
>>>>

