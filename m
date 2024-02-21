Return-Path: <dmaengine+bounces-1060-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D81CB85E522
	for <lists+dmaengine@lfdr.de>; Wed, 21 Feb 2024 19:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FF6EB24BF1
	for <lists+dmaengine@lfdr.de>; Wed, 21 Feb 2024 18:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1571484FDC;
	Wed, 21 Feb 2024 18:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DhURHu2k"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5885B84A4C;
	Wed, 21 Feb 2024 18:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708538608; cv=none; b=dMeyYzlKPdQ2lTuVv0+ikRm9UliymRb+9FTAGzhEk+sATkQI4ZpLDd8bw8tWVqt4bZKGO2+Vlzb49P10XhoQIqWryMTlwBtt/ng59SGbbU89jw+UUyARkaxq4ZWKHy6UxJPLK3vazZvehWsMitmuuCdgTTjoc/Zf9OqI3Qu4bG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708538608; c=relaxed/simple;
	bh=Vky8g1xlYqX8x+MNnRdTFSxQJHnbFOZbAAvwLGvHWBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=U5wsseHs0V0nMfFKixPUdTgHSVSYMhVY1vkVYH8AZGMD3YyiucHtdduRRJkwP443CyaNU7htdhDLd0fzbGYY2/saFNoD+R1s/nIV+NCZhvVdupyC7jBfYVQiTmglaZF/OpDvdIa+XGMRohoffuT2L2MzPQHSCs7WGQ8qPIsimew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DhURHu2k; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41LDjvmi018517;
	Wed, 21 Feb 2024 18:03:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Z1EM/p+jd2aox3yj3yzzpLjR9dADa2AsHCa27gf+ccc=; b=Dh
	URHu2kgvqjX8cVZsUKF0RaKFmJbtzqHY7mermb1venLpxbS83zKEgC9MTuwoW3pw
	2FlkqMBWvXiDvqaSWrXKeCKkrAEPgEUEonPL7VTQKYsAeuoiycqe1FolKijIN5xX
	07wLnHHwoOBJNKToBEGk6IxXA+iYp85J6sy+f0B2t4BBdTW2lCwQ+/xK6YWLl5u9
	nR017mCcix3kiZ4GCVvC7Zx2RmLDrvoX5c/EVnRV9/8A02lyyDF8MIQmVquTdU2h
	sH/oLJ8iMOSiRFIaXlceAyIeJXvutWZYSJegZbiPaEiibxs91Zx8hRo2Q/0+2tUT
	7NPSOzsKAkt5b5nsQOVg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wd22s2rnk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 18:03:07 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41LI36PJ004638
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 18:03:06 GMT
Received: from [10.50.0.60] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 21 Feb
 2024 10:03:02 -0800
Message-ID: <e4cf41af-5415-f923-25f0-07e837bd7a1a@quicinc.com>
Date: Wed, 21 Feb 2024 23:32:38 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 01/11] crypto: qce - Add support for crypto address read
Content-Language: en-US
To: Md Sadre Alam <quic_mdalam@quicinc.com>, <thara.gopinath@gmail.com>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <linux-crypto@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <quic_varada@quicinc.com>
References: <20231214114239.2635325-1-quic_mdalam@quicinc.com>
 <20231214114239.2635325-2-quic_mdalam@quicinc.com>
From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <20231214114239.2635325-2-quic_mdalam@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gocQSBGbcrsfedRVDFd0zds5ifsNkyqN
X-Proofpoint-GUID: gocQSBGbcrsfedRVDFd0zds5ifsNkyqN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_05,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 mlxlogscore=999 spamscore=0 suspectscore=0 adultscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402210140



On 12/14/2023 5:12 PM, Md Sadre Alam wrote:
> Get crypto base address from DT. This will use for
> command descriptor support for crypto register r/w
> via BAM/DMA
> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---
>   drivers/crypto/qce/core.c | 9 +++++++++
>   drivers/crypto/qce/core.h | 1 +
>   2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
> index 28b5fd823827..5af0dc40738a 100644
> --- a/drivers/crypto/qce/core.c
> +++ b/drivers/crypto/qce/core.c
> @@ -192,6 +192,7 @@ static int qce_crypto_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
>   	struct qce_device *qce;
> +	struct resource *res;
>   	int ret;
>   
>   	qce = devm_kzalloc(dev, sizeof(*qce), GFP_KERNEL);
> @@ -205,6 +206,14 @@ static int qce_crypto_probe(struct platform_device *pdev)
>   	if (IS_ERR(qce->base))
>   		return PTR_ERR(qce->base);
>   
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);

  Can this be combined with devm_platform_get_and_ioremap_resource ?
> +	if (!res)
> +		return -ENOMEM;
> +	qce->base_dma = dma_map_resource(dev, res->start, resource_size(res),
> +					 DMA_BIDIRECTIONAL, 0);

  unmap in remove and error cases ?

Regards,
  Sricharan

