Return-Path: <dmaengine+bounces-4102-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E97AA08ED3
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jan 2025 12:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E96D188C6D9
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jan 2025 11:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07E6205AA8;
	Fri, 10 Jan 2025 11:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ACjUZS+0"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7FB1AA1F6;
	Fri, 10 Jan 2025 11:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736507317; cv=none; b=Tbu6Pzb3/VmK0mQZQDLP1dpPUZx7wArKveG7ou8TYtUoTedY0gOq4hYqBjHboCkzipP3Mmus1aB5iL3bQQD9e/7VmnVQtRR7gLe/eOCDywV5QIAa1uB5zwyNDa+d5DZ9e2yOBDd3zQnYY171Av36jJ18ZU/QaK+sClDTxBXq17o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736507317; c=relaxed/simple;
	bh=hNKoypBhLRndMEGmScoAdpD+WezNA+2JSUxUIoLq1Dg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qxfD4A2HTOo4VCcy2hyQE/SiPXjTJwg6ClBc5boMzVJAGcyS8KQ8e81azgEQ/TUZoK9Y5F2QsEAff6peZWgYAKRYGazSfqHNVgjSbrijf70V0Udt+hDVHCbIoSuUmJaTIS3ZxMcfmzcGT5bT7f2QOGZPK9AsWsrX7UPBHgiPnwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ACjUZS+0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50A9EhVc011902;
	Fri, 10 Jan 2025 11:08:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+0yzZDdrYg3hbTSZpwZKd9ZttAgN3bR9WgKodODYYuQ=; b=ACjUZS+0J35eP7Sb
	9XRd9iYoy506cNaLu/YbmpWMXB+hJupbnK3Q7I4TyH9hXBCcS4uIvtFpXzorxjNT
	JqgrtjxMgICoCU9mU5VEVfMOVoA3jMPosTkuJ9xLgtlmpKR942nWfbagdpKUErJz
	1m6LsL4iRXOpaX91pcRaDsqx7+pBVXAulxovQqUZj0nEI9J5omzNAkVaT5jptkcp
	Gsq1P/LVHPsc1VBk/n8heqrkmCC+C1E3ZRxWVO4+yLUxlKOR/4iCnARu/GIzC1Nm
	BE6CI+6/y5YhgdG4Xsj+coTFV4SfHi/J145ztK/KarceCf34U8+UVHKWUIdIWi6k
	8AtavA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4430rfga4w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 11:08:26 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50AB8P1f006111
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 11:08:25 GMT
Received: from [10.151.36.43] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 10 Jan
 2025 03:08:21 -0800
Message-ID: <1a5fc7e9-39fe-e527-efc3-1ea990bbb53b@quicinc.com>
Date: Fri, 10 Jan 2025 16:38:18 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] dmaengine: qcom: bam_dma: Fix BAM_RIVISON register
 handling
Content-Language: en-US
To: Stephan Gerhold <stephan.gerhold@linaro.org>
CC: <vkoul@kernel.org>, <ulf.hansson@linaro.org>, <robin.murphy@arm.com>,
        <kees@kernel.org>, <u.kleine-koenig@baylibre.com>,
        <linux-arm-msm@vger.kernel.org>, <av2082000@gmail.com>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <djakov@kernel.org>, <quic_varada@quicinc.com>,
        <quic_srichara@quicinc.com>
References: <20250110051409.4099727-1-quic_mdalam@quicinc.com>
 <Z4DzHs0gtbTPxq2_@linaro.org>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <Z4DzHs0gtbTPxq2_@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ca4nQHDF_vm8ZX5iX4IsmUwFk4OodrLX
X-Proofpoint-GUID: ca4nQHDF_vm8ZX5iX4IsmUwFk4OodrLX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 clxscore=1011 mlxscore=0 mlxlogscore=999 priorityscore=1501 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501100087



On 1/10/2025 3:45 PM, Stephan Gerhold wrote:
> On Fri, Jan 10, 2025 at 10:44:09AM +0530, Md Sadre Alam wrote:
>> This patch fixes a bug introduced in the previous commit where the
>> BAM_DESC_CNT_TRSHLD register was conditionally written based on BAM-NDP
>> mode. Additionally, it addresses an issue where reading the BAM_REVISION
>> register hangs if num-ees is not zero. A check has been added to prevent
>> this.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 57a7138d0627 ("dmaengine: qcom: bam_dma: Avoid writing unavailable register")
>> Reported-by: Georgi Djakov <djakov@kernel.org>
>> Link: https://lore.kernel.org/lkml/9ef3daa8-cdb1-49f2-8d19-a72d6210ff3a@kernel.org/
>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>> ---
>>   drivers/dma/qcom/bam_dma.c | 23 ++++++++++++++++-------
>>   1 file changed, 16 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
>> index c14557efd577..2b88b27f2f91 100644
>> --- a/drivers/dma/qcom/bam_dma.c
>> +++ b/drivers/dma/qcom/bam_dma.c
>> @@ -445,11 +445,15 @@ static void bam_reset(struct bam_device *bdev)
>>   	writel_relaxed(val, bam_addr(bdev, 0, BAM_CTRL));
>>   
>>   	/* set descriptor threshold, start with 4 bytes */
>> -	if (in_range(bdev->bam_revision, BAM_NDP_REVISION_START,
>> -		     BAM_NDP_REVISION_END))
>> +	if (!bdev->num_ees && in_range(bdev->bam_revision, BAM_NDP_REVISION_START,
>> +				       BAM_NDP_REVISION_END))
>>   		writel_relaxed(DEFAULT_CNT_THRSHLD,
>>   			       bam_addr(bdev, 0, BAM_DESC_CNT_TRSHLD));
>>   
>> +	if (bdev->num_ees && !bdev->bam_revision)
>> +		writel_relaxed(DEFAULT_CNT_THRSHLD, bam_addr(bdev, 0,
>> +							     BAM_DESC_CNT_TRSHLD));
>> +
>>   	/* Enable default set of h/w workarounds, ie all except BAM_FULL_PIPE */
>>   	writel_relaxed(BAM_CNFG_BITS_DEFAULT, bam_addr(bdev, 0, BAM_CNFG_BITS));
>>   
>> @@ -1006,10 +1010,14 @@ static void bam_apply_new_config(struct bam_chan *bchan,
>>   			maxburst = bchan->slave.src_maxburst;
>>   		else
>>   			maxburst = bchan->slave.dst_maxburst;
>> -		if (in_range(bdev->bam_revision, BAM_NDP_REVISION_START,
>> -			     BAM_NDP_REVISION_END))
>> +		if (!bdev->num_ees && in_range(bdev->bam_revision, BAM_NDP_REVISION_START,
>> +					       BAM_NDP_REVISION_END))
>>   			writel_relaxed(maxburst,
>>   				       bam_addr(bdev, 0, BAM_DESC_CNT_TRSHLD));
>> +
>> +		if (bdev->num_ees && !bdev->bam_revision)
>> +			writel_relaxed(DEFAULT_CNT_THRSHLD, bam_addr(bdev, 0,
>> +								     BAM_DESC_CNT_TRSHLD));
> 
> I guess you meant writel_relaxed(maxburst, ...) here?
> 
> This patch is quite confusing. We shouldn't duplicate the register
> writes here just to have different handling for if (bdev->num_ees) and
> if (!bdev->num_ees).
> 
> Also, num-ees is unrelated to the question if the BAM is BAM-NDP or
> BAM-Lite. Typically we specify qcom,num-ees in the device tree for a BAM
> if the BAM is either:
> 
>   - Controlled remotely (= powered on and initialized outside of Linux)
>     This is the case for the SLIMbus BAM Georgi mentioned.
> 
>   - Powered remotely (= powered on outside of Linux, but must be
>     initialized inside Linux)
> 
> Reading BAM_REVISION in these cases will hang in bam_init(), because we
> cannot guarantee the BAM is already powered on when the bam_dma driver
> is being loaded in Linux. We need to delay reading the register until
> the BAM is up.
> 
> Given that these writes happen only for the !bdev->controlled_remotely
> case, you could fix this more cleanly by reading the BAM revision inside
> bam_reset().
Thank you for review and suggestion. Will clean up in next revision.

Thanks,
Alam.

