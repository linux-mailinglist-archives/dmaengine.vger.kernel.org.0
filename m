Return-Path: <dmaengine+bounces-2299-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A28648FF4B6
	for <lists+dmaengine@lfdr.de>; Thu,  6 Jun 2024 20:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A39291C27D2A
	for <lists+dmaengine@lfdr.de>; Thu,  6 Jun 2024 18:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AC045012;
	Thu,  6 Jun 2024 18:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nTq487WF"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D09FC0A;
	Thu,  6 Jun 2024 18:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717698740; cv=none; b=fqyLNvQ4bFhkJN7JxT6y5zNbKEXfQEtfJGLpk3c/zdJKmWLlS/7hrL6qmOCW5NxwiK+aeHeNdV1LhTFlfSxjKruHATmZjkeSm7FEAgV6fDITjmNCadtkpSZfirIoAgamDnAoSfJ2oIJPRSTw4hCLail1+LzdlAoaxb5SYOj97DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717698740; c=relaxed/simple;
	bh=1hplCqc2HCGivOTspRKS2I/aomnXclGYrlq3Ht2WBWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Wykv3GglXpV6s8ZQ8fiZBRhJ4lBTb3Gt/zdL8JKo/y5SUk7Zurf3Jwicgs7395xFs+Lw8GUZRVUTgxrr7VYNyr8sBjlr3LwbVgVgbZG054fdLZBkcY4Nk/qTjU0zIPjNisDsbpUe553iWYi+91Q6rsYRl2rirfFN6R/IWap1U/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nTq487WF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 456AC0K4026833;
	Thu, 6 Jun 2024 18:32:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uZlvN0d9TsSDPM+H9u2MpVEbt6wEeOuR6l1dJ8P/8IQ=; b=nTq487WFOxIucw5/
	HMNYbaznceX8doEZ5AGA3q08m+kA7oaPuoUCS8SqsCyFPIXny6jImxV7OVx0/izp
	n+f22eIlqmGfwtAjBpOhadEhDC9np8osH7zhgZA3Cr5jc7O9XKJtHN5CnXOvAbdg
	YW/PgNszMsKOgV/Jzf0/IpiTkl4z93o+nQNOSndWALQ+fvsodGXslXIxZ04Xbk2t
	3KMJTajRLQ0qUPCAT6n/H95VpeYDvEvJPH1ia9cmdAkTgLHtlUK24cbak1B528Z3
	+OODJwJfWW5OLRgr1jvOLE++NNgcox2zVrW2swugjhLli0yeCJNtsb0H/IjepcZe
	7dIn4A==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yjq2tkv5r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Jun 2024 18:32:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 456IWD5G006222
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 6 Jun 2024 18:32:13 GMT
Received: from [10.48.241.109] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 6 Jun 2024
 11:32:12 -0700
Message-ID: <b3d8faec-ae66-4dd9-8166-942a7cafa066@quicinc.com>
Date: Thu, 6 Jun 2024 11:32:11 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: add missing MODULE_DESCRIPTION() macros
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
        Fenghua
 Yu <fenghua.yu@intel.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20240605-md-drivers-dma-v1-1-bcbcfd9ce706@quicinc.com>
 <d0b56247-9b6c-4b62-aad0-1ff5925d9f9e@intel.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <d0b56247-9b6c-4b62-aad0-1ff5925d9f9e@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7Z4IQbko-XfocRUqdit9U3T6m6jj_Baq
X-Proofpoint-ORIG-GUID: 7Z4IQbko-XfocRUqdit9U3T6m6jj_Baq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_14,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406060129

On 6/5/2024 1:29 PM, Dave Jiang wrote:
> 
> 
> On 6/5/24 12:28 PM, Jeff Johnson wrote:
>> make allmodconfig && make W=1 C=1 reports:
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/idxd/idxd.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/ti/omap-dma.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/dmatest.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/ioat/ioatdma.o
>>
>> Add the missing invocations of the MODULE_DESCRIPTION() macro.
>>
>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>> ---
>>  drivers/dma/dmatest.c     | 1 +
>>  drivers/dma/idxd/init.c   | 1 +
>>  drivers/dma/ioat/init.c   | 1 +
>>  drivers/dma/ti/omap-dma.c | 1 +
>>  4 files changed, 4 insertions(+)
>>
>> diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
>> index a4f608837849..1f201a542b37 100644
>> --- a/drivers/dma/dmatest.c
>> +++ b/drivers/dma/dmatest.c
>> @@ -1372,4 +1372,5 @@ static void __exit dmatest_exit(void)
>>  module_exit(dmatest_exit);
>>  
>>  MODULE_AUTHOR("Haavard Skinnemoen (Atmel)");
>> +MODULE_DESCRIPTION("DMA Engine test module");
>>  MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
>> index a7295943fa22..cb5f9748f54a 100644
>> --- a/drivers/dma/idxd/init.c
>> +++ b/drivers/dma/idxd/init.c
>> @@ -22,6 +22,7 @@
>>  #include "perfmon.h"
>>  
>>  MODULE_VERSION(IDXD_DRIVER_VERSION);
>> +MODULE_DESCRIPTION("Intel Data Accelerators support");
> 
> "Intel Data Streaming Accelerator and In-Memory Analytics Accelerator common driver"

will update in v2, thanks

>>  MODULE_LICENSE("GPL v2");
>>  MODULE_AUTHOR("Intel Corporation");
>>  MODULE_IMPORT_NS(IDXD);
>> diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
>> index 9c364e92cb82..d84d95321f43 100644
>> --- a/drivers/dma/ioat/init.c
>> +++ b/drivers/dma/ioat/init.c
>> @@ -23,6 +23,7 @@
>>  #include "../dmaengine.h"
>>  
>>  MODULE_VERSION(IOAT_DMA_VERSION);
>> +MODULE_DESCRIPTION("Intel I/OAT DMA Linux driver");
> 
> Acked-by: Dave Jiang <dave.jiang@intel.com>
> 
>>  MODULE_LICENSE("Dual BSD/GPL");
>>  MODULE_AUTHOR("Intel Corporation");
>>  
>> diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
>> index b9e0e22383b7..5b994c325b41 100644
>> --- a/drivers/dma/ti/omap-dma.c
>> +++ b/drivers/dma/ti/omap-dma.c
>> @@ -1950,4 +1950,5 @@ static void __exit omap_dma_exit(void)
>>  module_exit(omap_dma_exit);
>>  
>>  MODULE_AUTHOR("Russell King");
>> +MODULE_DESCRIPTION("OMAP DMAengine support");
>>  MODULE_LICENSE("GPL");
>>
>> ---
>> base-commit: a693b9c95abd4947c2d06e05733de5d470ab6586
>> change-id: 20240605-md-drivers-dma-2105b7b6f243
>>


