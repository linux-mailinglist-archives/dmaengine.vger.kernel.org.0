Return-Path: <dmaengine+bounces-3835-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F4C9DFA33
	for <lists+dmaengine@lfdr.de>; Mon,  2 Dec 2024 06:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 727112817D4
	for <lists+dmaengine@lfdr.de>; Mon,  2 Dec 2024 05:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93691D63E0;
	Mon,  2 Dec 2024 05:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="B2tmiWGz"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24BBF9E4;
	Mon,  2 Dec 2024 05:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733117499; cv=none; b=CT8AlPI/dHiZhdefUqlyV1T2sAs8LKH596wSqZYiZWcYYfgQ2sJXxW7KQ3mwj7kilWs/1wpbjvQ3PnKixVLHxuBAZF0qd0TzDBqsRQrvIPzPM6w9nvvcKkeOfE0Ap+PmDT0nC0TEZtgWk2qPzUlyjivZZBsJw0UGkj0ETagXJZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733117499; c=relaxed/simple;
	bh=R5KY/VIlUNB+iUNIkIB9U4SLzJmN/Q0t2sHVnuILFQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iSyfyh9XnMt0YcQK8TWRrLEGXkYHAFRx9YVcvEbZR4QcbA5vqRjtS0X31z3qHE82vV/rTbactuuP+ZKs3N/wNmDuWMgPb3m3TPofqsEfei0NN+lJmqJAUjfnnNq8TfM2FWohNgZsJa2eP2FCcgVXBM1Iz9KNQG/AsoudmwowPAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=B2tmiWGz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B1NMueR002804;
	Mon, 2 Dec 2024 05:31:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n0AOzN6heIttX0rfAMYApCYx+LN1oHWWYAzh6AqoBUw=; b=B2tmiWGzOSKzurQZ
	py2BXJcrCwNbHSDRkxMWxwv7SVqDdWEHORLvdK0BkPSqzCzTvJOSC8Vi1OCpepqR
	LxK9l5rrqRt+0qESEERMrqu4S31IBUtIun4bWKYoH95k+DqanmO/jx5dNUEHj+iT
	bX+5Fx4BVhMtWJ8ue9X5rQ4wJQhWOF2cy5a4dd/F7C6dJ2HXytnmsGOKyZNLbEFJ
	MgcI8jCZnsnCRWZKvVMxo6mSYovtD7+N8PjuUK4ZNDhnD/FbDcyL0gLLm4ioo+V5
	kFYz6c6p/UFwLyvUUcWS/zUskmtxZh7XrlUv/0z8NnMI1dqBprOgFYaYQwi8VEj5
	Hh9Kbw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 437uvjubfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Dec 2024 05:31:34 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B25VXhn010224
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 2 Dec 2024 05:31:33 GMT
Received: from [10.217.219.62] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 1 Dec 2024
 21:31:31 -0800
Message-ID: <d1e3e1ad-2f00-4697-a3fc-4da671d6b4cb@quicinc.com>
Date: Mon, 2 Dec 2024 11:01:28 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dmaengine: qcom: gpi: Add GPI immediate DMA
 support
To: Bjorn Andersson <andersson@kernel.org>
CC: Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <quic_msavaliy@quicinc.com>, <quic_vtanuku@quicinc.com>
References: <20241128133351.24593-1-quic_jseerapu@quicinc.com>
 <20241128133351.24593-2-quic_jseerapu@quicinc.com>
 <obv72hhaqvremd7b4c4efpqv6vy7blz54upwc7jqx3pvrzg24t@zebke7igb3nl>
 <1666035c-d674-43dd-bc33-83231d64e5f7@quicinc.com>
 <fbpdzrwmlmqhyblchgaq6etmnc5wjd3ierwmtrer5hnwjf7qb3@axgwdegmbs6z>
Content-Language: en-US
From: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
In-Reply-To: <fbpdzrwmlmqhyblchgaq6etmnc5wjd3ierwmtrer5hnwjf7qb3@axgwdegmbs6z>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hXGaRC-Q06tnn-UXAo9KOEDRbK5hYeBk
X-Proofpoint-ORIG-GUID: hXGaRC-Q06tnn-UXAo9KOEDRbK5hYeBk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 impostorscore=0 adultscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412020047



On 11/30/2024 9:35 AM, Bjorn Andersson wrote:
> On Fri, Nov 29, 2024 at 05:02:22PM +0530, Jyothi Kumar Seerapu wrote:
>> On 11/28/2024 8:53 PM, Bjorn Andersson wrote:
>>> On Thu, Nov 28, 2024 at 07:03:50PM +0530, Jyothi Kumar Seerapu wrote:
>>>> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
> [..]
>>>
>>>>    	/* first create config tre if applicable */
>>>>    	if (direction == DMA_MEM_TO_DEV && spi->set_config) {
>>>> @@ -1763,14 +1767,32 @@ static int gpi_create_spi_tre(struct gchan *chan, struct gpi_desc *desc,
>>>>    	tre_idx++;
>>>>    	address = sg_dma_address(sgl);
>>>> -	tre->dword[0] = lower_32_bits(address);
>>>> -	tre->dword[1] = upper_32_bits(address);
>>>> +	len = sg_dma_len(sgl);
>>>> -	tre->dword[2] = u32_encode_bits(sg_dma_len(sgl), TRE_DMA_LEN);
>>>> +	/* Support Immediate dma for write transfers for data length up to 8 bytes */
>>>
>>> And what happens if the developer writing the SPI driver forgets to read
>>> this comment and sets QCOM_GPI_IMMEDIATE_DMA for a 9 byte transfer?
>> In V2 patch, QCOM_GPI_IMMEDIATE_DMA is set based on
>> QCOM_GPI_IMMEDIATE_DMA_LEN only.
>>
> 
> I assume you mean "patch 2/2". So, what happens if someone refactors the
> SPI driver in the future, will they read this comment?
> 
>> As per Hardware programming guide, immediate dma support is for up to 8
>> bytes only.
>> Need to check what is the behavior if we want to handle 9 bytes using
>> immediate dma feature support.
>>
> 
> I'm saying that you have a comment here which says that the caller must
> not pass len > 8. Write that comment in code to avoid mistakes - either
> now or in the future.

Sure, i will update the comment in V3.
> 
>>>
>>>> +	if ((spi->flags & QCOM_GPI_IMMEDIATE_DMA) && direction == DMA_MEM_TO_DEV) {
>>>
>>> Why is this flag introduced?
>>>
>>> If I understand the next patch, all DMA_MEM_TO_DEV transfers of <=
>>> QCOM_GPI_IMMEDIATE_DMA_LEN can use the immediate mode, so why not move
>>> the condition here?
>>>
>>> Also ordering[1].
>>>
>>> 	if (direction == DMA_MEM_TO_DEV && len <= 2 * sizeof(tre->dword[0]))
>>>
>>>
>> Sure, thanks for the suggestion.
>> so, instead using "QCOM_GPI_IMMEDIATE_DMA_LEN" need to use " 2 *
>> sizeof(tre->dword[0])" for 8 bytes length check.
>>
> 
> Either one works, but I'm guessing that while 8 is the right number the
> reason for 8 is that the data is passed in 2 * dword.
Okay, i will use "2 * sizeof(tre->dword[0]" which gives 8 only.
> 
> 
> The important thing is that you're encoding the length check here, so
> that the client can't by mistake trigger immediate mode with > 8 bytes.
> As a side effect, you no longer need the QCOM_GPI_IMMEDIATE_DMA flag and
> should be able to drop patch 2.

Sure thanks, will update the changes in V3.
> 
>>> [1] Compare "all transfers of length 8 or less, which are mem to device"
>>> vs "all transfers which are mem to device, with a length of 8 or less".
>>> The bigger "selection criteria" is the direction, then that's fine tuned
>>> by the length query.
>>>
>>>> +		buf = sg_virt(sgl);
>>>
>>> It's a question of style, but I think you could just put the sg_virt()
>>> directly in the memcpy() call and avoid the extra variable.
>>
>> Okay, i will directly put sg_virt() in memcpy().
> 
> Try it out, pick the option that look the best.
Yes, will do it in V3.

> 
> Regards,
> Bjorn
> 

