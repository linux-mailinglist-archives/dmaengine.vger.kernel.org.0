Return-Path: <dmaengine+bounces-3932-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD219E9072
	for <lists+dmaengine@lfdr.de>; Mon,  9 Dec 2024 11:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 237D31636F2
	for <lists+dmaengine@lfdr.de>; Mon,  9 Dec 2024 10:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D9221A957;
	Mon,  9 Dec 2024 10:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="I8w/ARr+"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFB5217F4A;
	Mon,  9 Dec 2024 10:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733740537; cv=none; b=qo2wd6iqsbCzCyrvHztodDzU4sB+sEeOnb+cX0eFrI2NBm0iZUt+DXCrntj5hQevfR11MnxJ3Pze6W4CPRW2GB3ZV9MOoIjeSdsP4qHT58votN7Fck+cWUkSHm7iPk6O52OelDeevIOaqmT28eGFEfP65b4UPWHhq3qSYCvZepY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733740537; c=relaxed/simple;
	bh=uQapUTNKsj3g4HvFjLDkgG6llYvezmODEOj0eRGH3Bk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pWbsVZgz30GWz/6IGdroRVE9HXiJ1m4ddnT/dhz9Cmjugz86mfeiY4v/bekMiqi+hk8rSCMzAH7Xr0njV+bg1b1lmW4nVo3rzfcO9yppqBavsvCPBbYrgqhaqFO8+/muXlCv+fo5/jq7UPasuelk496+O3D/0p+L7c6lC9rm8PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=I8w/ARr+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B99xZTJ013144;
	Mon, 9 Dec 2024 10:35:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	m+HGdPUOn/chqD8uYevW/GaKndnbDp32KIXaQCZEW1I=; b=I8w/ARr+t0WtGD/y
	R3OgwNBhg3YdWz2A0fNGdxEyWIS6fsSOIz7hpomIp37zZ2GIgLF0CVUWx6MsPJV8
	U5UqGfgxikZb7N9hnDAaAuGem3kFo02wnG2NIJJSChWVInMjt69JzvuQ8qgGGt7j
	WFOJ9sCTuJtZI+apVO6c6RsZU9/IKmW/df19Mnri1JMFnIRcnoG1ldOF23LV661A
	9cuW5pdG7MxO7V1BoefkHHlcjo6LNZxhGw6hE4ctAoEvepuHsKiTCJtu+LUjc5ai
	XH7zhx6WRd0nR+sbq3D5dlAHspuy3hO2nfZw1cKWsOHr+6QkByxhx2f7wozAlmj3
	0esr7Q==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43cdaqcc7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 10:35:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B9AZT1A008182
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Dec 2024 10:35:29 GMT
Received: from [10.152.195.140] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 9 Dec 2024
 02:35:25 -0800
Message-ID: <5d27eea0-56cd-4961-9fd5-f2398a24f958@quicinc.com>
Date: Mon, 9 Dec 2024 16:05:22 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dmaengine: qcom: bam_dma: Avoid writing unavailable
 register
To: Md Sadre Alam <quic_mdalam@quicinc.com>, <vkoul@kernel.org>,
        <martin.petersen@oracle.com>, <ulf.hansson@linaro.org>,
        <av2082000@gmail.com>, <linux-arm-msm@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <uic_mdalam@quicinc.com>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.com>
References: <20241209073143.3413552-1-quic_mdalam@quicinc.com>
Content-Language: en-US
From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
In-Reply-To: <20241209073143.3413552-1-quic_mdalam@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5MPJdGy-FFAGUxCrdHM-8Z4GGl-_EL2J
X-Proofpoint-ORIG-GUID: 5MPJdGy-FFAGUxCrdHM-8Z4GGl-_EL2J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 clxscore=1011 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090082



On 12/9/2024 1:01 PM, Md Sadre Alam wrote:
> Avoid writing unavailable register in BAM-Lite mode.
> BAM_DESC_CNT_TRSHLD register is unavailable in BAM-Lite
> mode. Its only available in BAM-NDP mode. So only write
> this register for clients who is using BAM-NDP.
> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---
> 
> Change in [v3]
> 
> * Removed BAM_LITE macro
> 
> * Updated commit message
> 
> * Adjusted if condition check
> 
> * Renamed BAM-NDP macro to BAM_NDP_REVISION_START and 
>   BAM_NDP_REVISION_END
> 
> Change in [v2]
> 
> * Replace 0xff with REVISION_MASK in the statement
>   bdev->bam_revision = val & REVISION_MASK
> 
> Change in [v1]
> 
> * Added initial patch
> 
>  drivers/dma/qcom/bam_dma.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index d43a881e43b9..a00dd0331ff5 100644
> --- a/drivers/dma/qcom/bam_dma.c
> +++ b/drivers/dma/qcom/bam_dma.c
> @@ -59,6 +59,9 @@ struct bam_desc_hw {
>  #define DESC_FLAG_NWD BIT(12)
>  #define DESC_FLAG_CMD BIT(11)
>  
> +#define BAM_NDP_REVISION_START	0x20
> +#define BAM_NDP_REVISION_END	0x27
> +
>  struct bam_async_desc {
>  	struct virt_dma_desc vd;
>  
> @@ -398,6 +401,7 @@ struct bam_device {
>  
>  	/* dma start transaction tasklet */
>  	struct tasklet_struct task;
> +	u32 bam_revision;
>  };
>  
>  /**
> @@ -441,8 +445,10 @@ static void bam_reset(struct bam_device *bdev)
>  	writel_relaxed(val, bam_addr(bdev, 0, BAM_CTRL));
>  
>  	/* set descriptor threshold, start with 4 bytes */
> -	writel_relaxed(DEFAULT_CNT_THRSHLD,
> -			bam_addr(bdev, 0, BAM_DESC_CNT_TRSHLD));
> +	if (bdev->bam_revision >= BAM_NDP_REVISION_START &&
> +	    bdev->bam_revision <= BAM_NDP_REVISION_END)

Please use in_range().

> +		writel_relaxed(DEFAULT_CNT_THRSHLD,
> +			       bam_addr(bdev, 0, BAM_DESC_CNT_TRSHLD));
>  
>  	/* Enable default set of h/w workarounds, ie all except BAM_FULL_PIPE */
>  	writel_relaxed(BAM_CNFG_BITS_DEFAULT, bam_addr(bdev, 0, BAM_CNFG_BITS));
> @@ -1000,9 +1006,10 @@ static void bam_apply_new_config(struct bam_chan *bchan,
>  			maxburst = bchan->slave.src_maxburst;
>  		else
>  			maxburst = bchan->slave.dst_maxburst;
> -
> -		writel_relaxed(maxburst,
> -			       bam_addr(bdev, 0, BAM_DESC_CNT_TRSHLD));
> +		if (bdev->bam_revision >= BAM_NDP_REVISION_START &&
> +		    bdev->bam_revision <= BAM_NDP_REVISION_END)

Please use in_range().

Thanks & Regards,
Manikanta.


