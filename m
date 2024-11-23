Return-Path: <dmaengine+bounces-3779-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0238F9D6784
	for <lists+dmaengine@lfdr.de>; Sat, 23 Nov 2024 05:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84197B21FD8
	for <lists+dmaengine@lfdr.de>; Sat, 23 Nov 2024 04:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECD244C76;
	Sat, 23 Nov 2024 04:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jj+6P33+"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E44E555;
	Sat, 23 Nov 2024 04:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732336639; cv=none; b=WRNsnLhA5ROmapTILdUsItb0yofbXssg7Xbg4pXLqRo0eKFL/4/J/dmwngeJZaliCEmCHT2xxwgMjJG/S7WgaV9ejlQeBOOlMsrvaZ2XrQG4FIf9rtKqDSssKmry3rH/ZL57tmHeSmJceHRmFuAqCPXJT9pYF4jLAMxYWpwr2o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732336639; c=relaxed/simple;
	bh=IEfmIuvf4RAZiKcvZ/bEeGLP0YpTuFTW7nzn8ETa25s=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PrAVE6xrFWuCY2jWhj5FGY6wiHBiFGKNdi4axauK5ZxxDf6zluvYODakGND06oWw8edU/Hy+3rpEmWNQxeXuxqvtfPOKDgvvfybdNFQHinANvzSY4bzkgD9JCXFrN7uVWoJKfozFX/IjttdEk6vGlyapEzhXn3v26yXFE93+dqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jj+6P33+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AN4Gw1w005848;
	Sat, 23 Nov 2024 04:37:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=c2xEIpSPn21EhzqyOoYBSY89
	AGIccID/ZJQJM8/dhek=; b=jj+6P33+PlgqHvQFfhcImgUh4cjOFDqQbVNThrhi
	Lx3axgsvp9bEde24hcjT+umDuO9x3zYI5PB2Q1JjEW0Ms+sfsvPaswnaQLoiZGpD
	rRGEsawybkoUt3mDlwpjAOwnTjLh5vAzjIwXxhfRzh9WvTOgQDkRip6iQ0pXVDvz
	V6RBEWXd3za1SueGSx0/4/JM+1jTFtDt9Ub4mIW5VH4ngzEKH1rqjeVVx2apHFGY
	MMYcbY/mv2+56KsbtANCqhAF7LtcOth1p9Hwd/6+sOxRluRCDQbgtDJrz4nH+NeY
	EAuNg6LCU5r44LKnboETVCx9qmxA9EJS1/y1qQAwrM9zQA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43362685fe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 23 Nov 2024 04:37:03 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AN4b24w021123
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 23 Nov 2024 04:37:02 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 22 Nov 2024 20:36:59 -0800
Date: Sat, 23 Nov 2024 10:06:55 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
CC: <vkoul@kernel.org>, <ulf.hansson@linaro.org>, <martin.petersen@oracle.com>,
        <kees@kernel.org>, <dave.jiang@intel.com>, <av2082000@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_srichara@quicinc.com>
Subject: Re: [PATCH] dmaengine: qcom: bam_dma: Avoid writing unavailable
 register
Message-ID: <Z0Fb5xBolEtwyUKb@hu-varada-blr.qualcomm.com>
References: <20241122071649.2618320-1-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241122071649.2618320-1-quic_mdalam@quicinc.com>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NRZFCp9wre6-FjG--Mb6mOSdEovYI7qI
X-Proofpoint-ORIG-GUID: NRZFCp9wre6-FjG--Mb6mOSdEovYI7qI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 clxscore=1011 phishscore=0 spamscore=0 adultscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411230034

On Fri, Nov 22, 2024 at 12:46:49PM +0530, Md Sadre Alam wrote:
> Avoid writing unavailable register in BAM-Lite mode.
> BAM_DESC_CNT_TRSHLD register is unavailable in BAM-Lite
> mode. Its only available in BAM-NDP mode. So avoid writing
> this register for clients who is using BAM-Lite mode.
>
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---
>  drivers/dma/qcom/bam_dma.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index d43a881e43b9..13a08c03746b 100644
> --- a/drivers/dma/qcom/bam_dma.c
> +++ b/drivers/dma/qcom/bam_dma.c
> @@ -59,6 +59,9 @@ struct bam_desc_hw {
>  #define DESC_FLAG_NWD BIT(12)
>  #define DESC_FLAG_CMD BIT(11)
>
> +#define BAM_LITE	0x13
> +#define BAM_NDP		0x20
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
> @@ -441,8 +445,9 @@ static void bam_reset(struct bam_device *bdev)
>  	writel_relaxed(val, bam_addr(bdev, 0, BAM_CTRL));
>
>  	/* set descriptor threshold, start with 4 bytes */
> -	writel_relaxed(DEFAULT_CNT_THRSHLD,
> -			bam_addr(bdev, 0, BAM_DESC_CNT_TRSHLD));
> +	if (bdev->bam_revision >= BAM_LITE && bdev->bam_revision < BAM_NDP)
> +		writel_relaxed(DEFAULT_CNT_THRSHLD,
> +			       bam_addr(bdev, 0, BAM_DESC_CNT_TRSHLD));
>
>  	/* Enable default set of h/w workarounds, ie all except BAM_FULL_PIPE */
>  	writel_relaxed(BAM_CNFG_BITS_DEFAULT, bam_addr(bdev, 0, BAM_CNFG_BITS));
> @@ -1000,9 +1005,9 @@ static void bam_apply_new_config(struct bam_chan *bchan,
>  			maxburst = bchan->slave.src_maxburst;
>  		else
>  			maxburst = bchan->slave.dst_maxburst;
> -
> -		writel_relaxed(maxburst,
> -			       bam_addr(bdev, 0, BAM_DESC_CNT_TRSHLD));
> +		if (bdev->bam_revision >= BAM_LITE && bdev->bam_revision < BAM_NDP)
> +			writel_relaxed(maxburst,
> +				       bam_addr(bdev, 0, BAM_DESC_CNT_TRSHLD));
>  	}
>
>  	bchan->reconfigure = 0;
> @@ -1192,10 +1197,11 @@ static int bam_init(struct bam_device *bdev)
>  	u32 val;
>
>  	/* read revision and configuration information */
> -	if (!bdev->num_ees) {
> -		val = readl_relaxed(bam_addr(bdev, 0, BAM_REVISION));
> +	val = readl_relaxed(bam_addr(bdev, 0, BAM_REVISION));
> +	if (!bdev->num_ees)
>  		bdev->num_ees = (val >> NUM_EES_SHIFT) & NUM_EES_MASK;
> -	}
> +
> +	bdev->bam_revision = val & 0xff;

Use REVISION_MASK instead of 0xff

-Varada

>  	/* check that configured EE is within range */
>  	if (bdev->ee >= bdev->num_ees)
> --
> 2.34.1
>

