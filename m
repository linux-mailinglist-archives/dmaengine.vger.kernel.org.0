Return-Path: <dmaengine+bounces-2930-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6683995A307
	for <lists+dmaengine@lfdr.de>; Wed, 21 Aug 2024 18:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF6221F22CCE
	for <lists+dmaengine@lfdr.de>; Wed, 21 Aug 2024 16:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4387615B0E2;
	Wed, 21 Aug 2024 16:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lKQinKob"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB93152199;
	Wed, 21 Aug 2024 16:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724258463; cv=none; b=PJir2uYCsQJ6D6+7C57lwV44jP1CCEJTzfBWiwRV4H/AJbnmxrrQ3THXGUa1IkMLGO9+eS4Nd6q+beImIj8pUfeA7lNP+wM93PIqbE1kEZfvYJUtiS/RBzaE80gdruAOy46kbE3xywzIznReXq19ZlTQVIN3NQLC23TD4DgojdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724258463; c=relaxed/simple;
	bh=gKoteVLKI8ai33j8oxVFeL6d5ggtKS/ReU8r+qC1D4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nrOBhmMhZnvOBg5thtdKu0mxraDyUICihNjK1OIAfNFnBhTErIcHt/MQyWoQBr8gggrjGsGIHZmHFetmPtdZCTSykp1fJcEIIVcZw9hxmSHLgdSI0lpv2RasX0SGkV9Rn46FfFoE+6DjzjRK/t9VUTmPu/tmLcEItCH0s1D5AFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lKQinKob; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47L80RVJ001800;
	Wed, 21 Aug 2024 16:40:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t7yuid+f1cRo2jgQ7k++sxtPewWLQLpXVG8YsnFjlFE=; b=lKQinKob7XQHut4F
	nLaCGClupoG3OuzxpNwr/7qb0oDQyweqJoDfIOjwUiS2AQQGayA1lpnxfK2LPwA+
	WWd0SJOfyRxSU0vr3FTpHmMlTOudFzoBoSUOoWvGi2nLrx8KlniWmJUvJHhy9w4B
	B95nV6Bd6zp+aaRR3Y+Q2LUxk/UiMW0y+K30qCuS8SKaj0d5yDPeXzM5WN9rz05V
	ZzVNMo4AZvSVALR+Wj3jWPEQrOmpvFfWQIaHxq1HKdj07Fvj7AOsAAWyGwM481GM
	GakK8NqsVY2dvKB0homNsKJ9okH3Vu+pcXdzSOXAm4gMkkbjMxraMlu8eNA+ZgnA
	4EqGMA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 414uh8v7qw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 16:40:52 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47LGeqX8027390
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 16:40:52 GMT
Received: from [10.216.59.247] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 21 Aug
 2024 09:40:42 -0700
Message-ID: <e4b2f28e-bc5c-ea93-c264-2b8608c4eab4@quicinc.com>
Date: Wed, 21 Aug 2024 22:10:39 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 04/16] crypto: qce - Add support for crypto address
 read
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
 <20240815085725.2740390-5-quic_mdalam@quicinc.com>
 <72cef34a-acb0-4278-984c-dadd53817b5d@kernel.org>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <72cef34a-acb0-4278-984c-dadd53817b5d@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8tTv8B-W85oluN-RjR-db7q61EWWNiIN
X-Proofpoint-ORIG-GUID: 8tTv8B-W85oluN-RjR-db7q61EWWNiIN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_11,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408210122



On 8/17/2024 2:40 PM, Krzysztof Kozlowski wrote:
> On 15/08/2024 10:57, Md Sadre Alam wrote:
>> Get crypto base address from DT. This will use for
>> command descriptor support for crypto register r/w
>> via BAM/DMA
> 
> All your commit messages are oddly wrapped. This does not make reading
> it easy...
> 
>>
>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>> ---
>> Change in [v2]
>>
>> * Addressed all comments from v1
>>
>> Change in [v1]
>>
>> * Added support to read crypto base address from dt
>>
>>   drivers/crypto/qce/core.c | 13 ++++++++++++-
>>   drivers/crypto/qce/core.h |  1 +
>>   2 files changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
>> index 28b5fd823827..9b23a948078a 100644
>> --- a/drivers/crypto/qce/core.c
>> +++ b/drivers/crypto/qce/core.c
>> @@ -192,6 +192,7 @@ static int qce_crypto_probe(struct platform_device *pdev)
>>   {
>>   	struct device *dev = &pdev->dev;
>>   	struct qce_device *qce;
>> +	struct resource *res;
>>   	int ret;
>>   
>>   	qce = devm_kzalloc(dev, sizeof(*qce), GFP_KERNEL);
>> @@ -201,10 +202,16 @@ static int qce_crypto_probe(struct platform_device *pdev)
>>   	qce->dev = dev;
>>   	platform_set_drvdata(pdev, qce);
>>   
>> -	qce->base = devm_platform_ioremap_resource(pdev, 0);
>> +	qce->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>>   	if (IS_ERR(qce->base))
>>   		return PTR_ERR(qce->base);
>>   
>> +	qce->base_dma = dma_map_resource(dev, res->start,
>> +					 resource_size(res),
>> +					 DMA_BIDIRECTIONAL, 0);
>> +	if (dma_mapping_error(dev, qce->base_dma))
>> +		return -ENXIO;
>> +
>>   	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
>>   	if (ret < 0)
>>   		return ret;
> 
> And how do you handle error paths?
   Ok , will fix the error path to cleanup the resources.
> 
> 
>> @@ -280,6 +287,7 @@ static int qce_crypto_probe(struct platform_device *pdev)
>>   static void qce_crypto_remove(struct platform_device *pdev)
>>   {
>>   	struct qce_device *qce = platform_get_drvdata(pdev);
>> +	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>   
>>   	tasklet_kill(&qce->done_tasklet);
>>   	qce_unregister_algs(qce);
>> @@ -287,6 +295,9 @@ static void qce_crypto_remove(struct platform_device *pdev)
>>   	clk_disable_unprepare(qce->bus);
>>   	clk_disable_unprepare(qce->iface);
>>   	clk_disable_unprepare(qce->core);
>> +
>> +	dma_unmap_resource(&pdev->dev, qce->base_dma, resource_size(res),
>> +			   DMA_BIDIRECTIONAL, 0);
> 
> If you add code to the remove callback, not adding it to error paths is
> suspicious by itself...
   Ok , will fix the error path to cleanup the resources.
> 
> Best regards,
> Krzysztof
> 
> 

