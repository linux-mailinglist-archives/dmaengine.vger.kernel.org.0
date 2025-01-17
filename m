Return-Path: <dmaengine+bounces-4143-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D7DA148DC
	for <lists+dmaengine@lfdr.de>; Fri, 17 Jan 2025 05:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB6393A6779
	for <lists+dmaengine@lfdr.de>; Fri, 17 Jan 2025 04:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A798F273FD;
	Fri, 17 Jan 2025 04:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Q2K0LB/F"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD4125A625;
	Fri, 17 Jan 2025 04:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737088380; cv=none; b=uNe2zbKbge0DgLIMk+DEhkhug9vQMCC1eJ9ExkMgj0XK61qWyP/o1h9z4u8LptIw1G99oFsog2CIScoXXhRCZ7BZ+YTxmiHZcLw3RhSr2fWNfxjjQz9nU9LqOU9RBhmOn+9fC5frZXDhVuE3pLPH2Xia/k1EfpFNF+h8rXjaJHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737088380; c=relaxed/simple;
	bh=t2s+b306xBuPXhhO060s6Y1zY0B3W/TLAKbVcsgTtN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LpCz+nXBuPVPuGeALOg59hgrXawP0BdAe2DXUoAKTzvKieo2pygu1knwTze32FCQkcAMUuammAUjFTzPuS7RHWuTtPOWc6ivEkiXlY2v5L9w2sWYGzKocvutrLSyplNf6crWV8J8vQdBwp5kQ6LNWKBlsyYJUnfvipf2BqKwfRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Q2K0LB/F; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GNrclX022936;
	Fri, 17 Jan 2025 04:32:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4X9oiOlfPcHcM/j4pCvyOH4pDrGLCn+uoioBjZvHMF8=; b=Q2K0LB/FPovfEn0B
	TTrwap76VS66qvnBLmG04cUq6nezqFEBR+Gpioh/M1Jpg+chWAVxDMZsFpi77obU
	d+noaljV4YPsnKPwFHil0jdHJvvW6K50wx5LaRdCH+I7MtB2xsSQK0GkBdRWsvXo
	qwRuRFoupHKDpJzzwxkhdYoPIbGN0R2L+ymGxxLtqzrmQa7hRXwbdTjaxDcdBLl2
	HrfwcghmrNEnFSKnKvZ8UCtcWfLzFuRWi/H+sbpJm8b4DuTOJg5IxJ8bloVtA0zg
	wDH1jKB4zuGQsDph9RdVacBG5FuK5MAvOD1Pln28RoJN0TAq96iNLaF6U6zKDZy5
	V4Bvxw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 447c6fgfu8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 04:32:46 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50H4Wkhu024051
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 04:32:46 GMT
Received: from [10.151.36.43] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 16 Jan
 2025 20:32:40 -0800
Message-ID: <3d0ef611-2b21-d22e-8dbc-f092c36ceb1d@quicinc.com>
Date: Fri, 17 Jan 2025 10:02:37 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 01/12] dmaengine: qcom: bam_dma: Add bam_sw_version
 register read
Content-Language: en-US
To: Stephan Gerhold <stephan.gerhold@linaro.org>
CC: <vkoul@kernel.org>, <corbet@lwn.net>, <thara.gopinath@gmail.com>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <martin.petersen@oracle.com>, <enghua.yu@intel.com>,
        <u.kleine-koenig@baylibre.com>, <dmaengine@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <quic_utiwari@quicinc.com>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.com>
References: <20250115103004.3350561-1-quic_mdalam@quicinc.com>
 <20250115103004.3350561-2-quic_mdalam@quicinc.com>
 <Z4k8qBEEfoyl0Qj1@linaro.org>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <Z4k8qBEEfoyl0Qj1@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5kLSQpzao_W0Ag7DMtXkqQcxXneuGaLP
X-Proofpoint-ORIG-GUID: 5kLSQpzao_W0Ag7DMtXkqQcxXneuGaLP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_01,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 impostorscore=0 mlxlogscore=999 spamscore=0 suspectscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501170032



On 1/16/2025 10:36 PM, Stephan Gerhold wrote:
> On Wed, Jan 15, 2025 at 03:59:53PM +0530, Md Sadre Alam wrote:
>> Add bam_sw_version register read. This will help to
>> differentiate b/w some new BAM features across multiple
>> BAM IP, feature like LOCK/UNLOCK of BAM pipe.
>>
>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>> ---
>>
>> change in [v6]
>>
>> * No change
>>
>> change in [v5]
>>
>> * No change
>>
>> change in [v4]
>>
>> * Added BAM_SW_VERSION register read
>>
>> change in [v3]
>>
>> * This patch was not included in [v3]
>>
>> change in [v2]
>>
>> * This patch was not included in [v2]
>>
>> change in [v1]
>>
>> * This patch was not included in [v1]
>>
>>   drivers/dma/qcom/bam_dma.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
>> index c14557efd577..daeacd5cb8e9 100644
>> --- a/drivers/dma/qcom/bam_dma.c
>> +++ b/drivers/dma/qcom/bam_dma.c
>> @@ -83,6 +83,7 @@ struct bam_async_desc {
>>   enum bam_reg {
>>   	BAM_CTRL,
>>   	BAM_REVISION,
>> +	BAM_SW_VERSION,
>>   	BAM_NUM_PIPES,
>>   	BAM_DESC_CNT_TRSHLD,
>>   	BAM_IRQ_SRCS,
>> @@ -117,6 +118,7 @@ struct reg_offset_data {
>>   static const struct reg_offset_data bam_v1_3_reg_info[] = {
>>   	[BAM_CTRL]		= { 0x0F80, 0x00, 0x00, 0x00 },
>>   	[BAM_REVISION]		= { 0x0F84, 0x00, 0x00, 0x00 },
>> +	[BAM_SW_VERSION]	= { 0x0F88, 0x00, 0x00, 0x00 },
>>   	[BAM_NUM_PIPES]		= { 0x0FBC, 0x00, 0x00, 0x00 },
>>   	[BAM_DESC_CNT_TRSHLD]	= { 0x0F88, 0x00, 0x00, 0x00 },
>>   	[BAM_IRQ_SRCS]		= { 0x0F8C, 0x00, 0x00, 0x00 },
>> @@ -146,6 +148,7 @@ static const struct reg_offset_data bam_v1_3_reg_info[] = {
>>   static const struct reg_offset_data bam_v1_4_reg_info[] = {
>>   	[BAM_CTRL]		= { 0x0000, 0x00, 0x00, 0x00 },
>>   	[BAM_REVISION]		= { 0x0004, 0x00, 0x00, 0x00 },
>> +	[BAM_SW_VERSION]	= { 0x0008, 0x00, 0x00, 0x00 },
>>   	[BAM_NUM_PIPES]		= { 0x003C, 0x00, 0x00, 0x00 },
>>   	[BAM_DESC_CNT_TRSHLD]	= { 0x0008, 0x00, 0x00, 0x00 },
>>   	[BAM_IRQ_SRCS]		= { 0x000C, 0x00, 0x00, 0x00 },
>> @@ -175,6 +178,7 @@ static const struct reg_offset_data bam_v1_4_reg_info[] = {
>>   static const struct reg_offset_data bam_v1_7_reg_info[] = {
>>   	[BAM_CTRL]		= { 0x00000, 0x00, 0x00, 0x00 },
>>   	[BAM_REVISION]		= { 0x01000, 0x00, 0x00, 0x00 },
>> +	[BAM_SW_VERSION]	= { 0x01004, 0x00, 0x00, 0x00 },
>>   	[BAM_NUM_PIPES]		= { 0x01008, 0x00, 0x00, 0x00 },
>>   	[BAM_DESC_CNT_TRSHLD]	= { 0x00008, 0x00, 0x00, 0x00 },
>>   	[BAM_IRQ_SRCS]		= { 0x03010, 0x00, 0x00, 0x00 },
>> @@ -393,6 +397,7 @@ struct bam_device {
>>   	bool controlled_remotely;
>>   	bool powered_remotely;
>>   	u32 active_channels;
>> +	u32 bam_sw_version;
>>   
>>   	const struct reg_offset_data *layout;
>>   
>> @@ -1306,6 +1311,9 @@ static int bam_dma_probe(struct platform_device *pdev)
>>   		return ret;
>>   	}
>>   
>> +	bdev->bam_sw_version = readl_relaxed(bam_addr(bdev, 0, BAM_SW_VERSION));
>> +	dev_info(bdev->dev, "BAM software version:0x%08x\n", bdev->bam_sw_version);
> 
> This will cause crashes for the same reason as your other patch. During
> probe(), we can't read from BAM registers if we don't have a clock
> assigned. There is no guarantee that the BAM is powered up.
> 
> To make this work properly on all platforms, you would need to defer
> reading this register until the first channel is requested by the
> consumer driver. Or limit this functionality to the if (bdev->bamclk)
> case for now.
Sure thanks for suggestion. Will fix in next revision.
> 
> We should also prioritize fixing the existing regression before adding
> new functionality.
Sure, I am working on it will post quickly.

Thanks,
Alam.

