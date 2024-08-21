Return-Path: <dmaengine+bounces-2931-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0674F95A30A
	for <lists+dmaengine@lfdr.de>; Wed, 21 Aug 2024 18:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7C91282B74
	for <lists+dmaengine@lfdr.de>; Wed, 21 Aug 2024 16:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4D51547C1;
	Wed, 21 Aug 2024 16:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kGw11Kyp"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28D613BAFA;
	Wed, 21 Aug 2024 16:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724258493; cv=none; b=u5mOX0Yr2qcSSSF07pVQitBW0vPKoK9Dihx7Qy3ewv5uxELIwPU942hWh/H3hAW9mrM9qAka1a+ExWsFbPZxxUVrOmFLIok9d3znNlXwdmL400hbVEcdtsQEvfoYn6PKD7cibD3WkB9fwCA9w4HwMZGhRjWDT5kRCMKLXy3fNQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724258493; c=relaxed/simple;
	bh=0hHky8qMTWuJRLcCktllpZMluDCZkZs5zXeSumskFgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JG2+EeYv2KM0knVYli84zJQ4foRWcqVSNmLh/Tc4Suht+S1jRrd+XjnGytghuv6YIPf9xz/w472eWSI87F58eShkh3grW+QXMTPIVIqARpva0nCBzaXufjtBTN82aipmMU15I5bleDdiM/k9tm+V9EGU1Z36Us1RqObrkn2b6VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kGw11Kyp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47LBTZ6J004791;
	Wed, 21 Aug 2024 16:36:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CAiWvhIjbUhEiP+KqUGopxxaGyl12jnPyqp6OSZsJdQ=; b=kGw11KypV+Fe2uOs
	1JCrmGXo3BzUSX4pRdrgo7/T02IR9Inzj4K2+NdLy3cBknaLXecGgKBxswPhTnzt
	i0SdtF2CbQ3ZZxzfLlX2v4rt0Wk9O8TDyfdixanUEzqPIIhJPriMBA1u68sWQoxR
	ODSiLwVH0u8SzvglyhsbG9N1eEiNEM1VBBIEHX070scRLDwNWpOrYjIZGu8gvbyH
	xQF9gkCdweDs0jhxjR3bmxt4eereTLusrmzxp8BYQJHDoYT2bP0mlL8/JGYdVnEW
	UwrlKerK7x++3I8Dc0LXietotuDZ9lcqf2SMQOxbj5y/TcSGiFVsJByCPbGuo6iB
	N9vZEQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 414v5cc6b1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 16:36:22 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47LGaLTM030954
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 16:36:21 GMT
Received: from [10.216.59.247] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 21 Aug
 2024 09:36:15 -0700
Message-ID: <a37644d8-e97f-0c78-ea09-e1b258a0b614@quicinc.com>
Date: Wed, 21 Aug 2024 22:06:12 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 02/16] dmaengine: qcom: bam_dma: add bam_pipe_lock dt
 property
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>, <vkoul@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <konradybcio@kernel.org>,
        <thara.gopinath@gmail.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <gustavoars@kernel.org>,
        <u.kleine-koenig@pengutronix.de>, <kees@kernel.org>,
        <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>,
        <quic_utiwari@quicinc.com>
References: <20240815085725.2740390-1-quic_mdalam@quicinc.com>
 <20240815085725.2740390-3-quic_mdalam@quicinc.com>
 <9271efb2-db9a-4f45-bdb1-724ce6dbcbf1@kernel.org>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <9271efb2-db9a-4f45-bdb1-724ce6dbcbf1@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yK7e_FfELiMS9oWhVEeaWDaoEk9m_KEh
X-Proofpoint-ORIG-GUID: yK7e_FfELiMS9oWhVEeaWDaoEk9m_KEh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_11,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408210122



On 8/17/2024 2:38 PM, Krzysztof Kozlowski wrote:
> On 15/08/2024 10:57, Md Sadre Alam wrote:
>> bam having locking and unlocking mechanism of bam pipes.
>> Upon encountering a descriptor with Lock bit set, the
>> BAM will lock all other pipes not related to the current
>> pipe group, and keep handling the current pipe only until
>> it sees the Un-Lock set , then it will release all locked
>> pipes. The actual locking is done on the new descriptor
>> fetching for publishing, i.e. locked pipe will not fetch
>> new descriptors even if it got event/events adding more
>> descriptors for this pipe.
>>
>> Adding the bam_pipe_lock flag in bam driver to handle
>> Lock and Un-Lock bit set on command descriptor.
>>
>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>> ---
>>
>> Change in [v2]
>>
>> * Added bam_pipe_lock dt property
>>
>> Change in [v1]
>>
>> * This patch was not included in [v1]
>>
>>   drivers/dma/qcom/bam_dma.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
>> index 5e7d332731e0..1ac7e250bdaa 100644
>> --- a/drivers/dma/qcom/bam_dma.c
>> +++ b/drivers/dma/qcom/bam_dma.c
>> @@ -389,6 +389,7 @@ struct bam_device {
>>   	u32 ee;
>>   	bool controlled_remotely;
>>   	bool powered_remotely;
>> +	bool bam_pipe_lock;
> 
> There is no user of this property. It's just no-op. Split your code into
> logical chunks, but logical chunk is not "I add field to structure which
> is not used".
   Ok ,will squash this patch accordingly.
> 
> 
> Best regards,
> Krzysztof
> 

