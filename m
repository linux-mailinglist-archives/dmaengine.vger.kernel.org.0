Return-Path: <dmaengine+bounces-2300-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 227AD8FF4C3
	for <lists+dmaengine@lfdr.de>; Thu,  6 Jun 2024 20:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B2EB28F5C5
	for <lists+dmaengine@lfdr.de>; Thu,  6 Jun 2024 18:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB2B45025;
	Thu,  6 Jun 2024 18:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mA5ItCMZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407E145020;
	Thu,  6 Jun 2024 18:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717698831; cv=none; b=YH/7/TDogMvSgaCz9H33GciQtlBIEf5x8gA8dVuJN6wGoWY8HVBKpYdijk3yYH6yYTIAbWOLDMneOtr/hg3KIYPRvbw6z7HB93CBV+eFsZ3ueA1yEuhWhRBb9ipz9iGo0UPn6kzWYy+62Ag1VT7/IMu1eh/cob60UjQ+G+dimUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717698831; c=relaxed/simple;
	bh=q/jURLcImklc5MFONhxMvWLpyEYMZ8Rx18b1QFVRIHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KJNHINNr9GQxZdOGIbtWz5oM2RtsNe/qk3d+6mMfQkazCbKU7QJaKQy0kzFDQTCulEpMc/gMjhf5vbsdVv7Yu0SuvReUN7K73Fc0o6ktrmtEZMyd/ZJ5hkIF0neVB4ewCzWX9oV0BJs/vabu4csYkU80Ry2JGrhXLu/SfwB5mtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mA5ItCMZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 456AQHk4031030;
	Thu, 6 Jun 2024 18:33:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	++YagTa9vlmdkj4m93VPW5sKHtsNCbaLRScfkJXXvtI=; b=mA5ItCMZVZAnQ9Ai
	JJVuESwMa3TdrWAOEP0tDCI6F1QZmdsZiQSBIr7IFAk3X7ugZRfRvgOv4HEfnQR4
	ANJe0NEsUAzTcC2nIMUi0BoQG6T+Y6Wf4SBiGnQL8mQ5p8LnYnS9Xef0xz2+kLEk
	AjJMpObb60QxO0CFFXUCxH9fSAADsLMY9liCJC7NEpdlp9eddD4rh+VY0C/iwBS6
	y4WmQ20k9c6WLY0miPhwkD1Wmkia/gM/+M7YgUtAAlSq0O7EwA80MBoDBx5Q6WUX
	2CNM+4AhZiOArwaJMxyYl8gvkrDavrDuFsYZn2RVUVMG8qF2pJeMogF6QcRc3AiP
	6dTM6g==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yj87rnnwj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Jun 2024 18:33:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 456IXhuj009963
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 6 Jun 2024 18:33:43 GMT
Received: from [10.48.241.109] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 6 Jun 2024
 11:33:42 -0700
Message-ID: <fc5fafa6-cd82-4509-bbfb-dacb16070dcb@quicinc.com>
Date: Thu, 6 Jun 2024 11:33:42 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: add missing MODULE_DESCRIPTION() macros
Content-Language: en-US
To: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>,
        Vinod Koul
	<vkoul@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>,
        Dave Jiang
	<dave.jiang@intel.com>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20240605-md-drivers-dma-v1-1-bcbcfd9ce706@quicinc.com>
 <b57827de-8e72-442d-99fa-307a719ea33b@gmail.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <b57827de-8e72-442d-99fa-307a719ea33b@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FL0A04stFooLd6lZ5DXYkPLJpCikZef2
X-Proofpoint-ORIG-GUID: FL0A04stFooLd6lZ5DXYkPLJpCikZef2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_14,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 spamscore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406060129

On 6/6/2024 10:44 AM, Péter Ujfalusi wrote:
> Hi,
> 
> On 6/5/24 10:28 PM, Jeff Johnson wrote:
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
> 
> It would be better to "Texas Instruments sDMA DMAengine support"

will update in v2, thanks

> 
>>  MODULE_LICENSE("GPL");
>>
>> ---
>> base-commit: a693b9c95abd4947c2d06e05733de5d470ab6586
>> change-id: 20240605-md-drivers-dma-2105b7b6f243
>>
> 


