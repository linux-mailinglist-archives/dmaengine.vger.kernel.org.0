Return-Path: <dmaengine+bounces-2731-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C445F93A69C
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jul 2024 20:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B7A02828F3
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jul 2024 18:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5011586F5;
	Tue, 23 Jul 2024 18:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="owCTbr56"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D101581F4;
	Tue, 23 Jul 2024 18:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721759812; cv=none; b=ba4hOJb0vbSVL0XTOQalrSyy1aBhvCTs+07kTfqXbWXZiwT3e7sUsQV5HzFnw8rX+8gBrEowo3rlTkMn8gtjQFfR1dkZy2WOgMeuMD/35SJBcyh8t03zwiA86OFo34Wo1i2HA43FXYCmMSYL8+kmg/cYvXtLyO2aM5z4rUah0DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721759812; c=relaxed/simple;
	bh=SIVxWkbO0wjcTXPfnYIaCufvJb8pb/IqZz+RT3aymWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sS1rHjv+wFCV4GEUCmsHXmtTQJ7TEM3LtrhwGgKZU2i7RziBu6wE2w06FU2hxQfUznwEJgIcHAP5+WTWE3k+KihaZpZCJXUKDQRTRDNABHcu77vlYiN6Aw9aPo6MPPRtDyZ8rjx6CuCMkD2r4wsB5u3J6QuBHp2zDyqiErIwPVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=owCTbr56; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46NHsPgS029348;
	Tue, 23 Jul 2024 18:36:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h5/bKrWgRM/Cf0eDMr8MDPwf4MYHoJumhmnawiiqn8g=; b=owCTbr56yd9Ombup
	zDr7KC9beSgcZwX0IQidyFiy090W1hpdLCNNSpcLm4CJR5tz/9DOgbgSK+BvVGua
	bEG0wrWkCZtW/SsUDqVfS6FhfXa1nARnvYFN+SUVF/bIXA275V/lanufwBTobK0o
	TWwSI2q+vU6lfeFfehNXI6zaipC6I1G+2TKqvHMra2xxz3ibCrSMJM9TXfnhOzOV
	n/eGjGu5siHO808kXPXh1tdRmbuBJSRU54PAVM/vOllhXFr3oUB13d/C0kYuA3qT
	AMTO+7QjCmEDZ3KKJWhsecDd8v/vNM63zE6nkM1MIWal7fuQPvkWbFQfWSJ4xKJX
	0e3wpQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g6h8ythx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 18:36:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46NIajxk029009
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 18:36:45 GMT
Received: from [10.111.176.36] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 23 Jul
 2024 11:36:42 -0700
Message-ID: <36f5502c-a07f-4809-aa24-7f996afc0a88@quicinc.com>
Date: Tue, 23 Jul 2024 11:36:41 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: qcom: add missing MODULE_DESCRIPTION() macros
Content-Language: en-US
To: Vinod Koul <vkoul@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        <kernel@quicinc.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-arm-msm@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
References: <20240603-md-drivers-dma-qcom-v1-1-d1bd919352bf@quicinc.com>
 <171778244108.276050.8818140072679051239.b4-ty@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <171778244108.276050.8818140072679051239.b4-ty@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: tAW35PHAZfQW0w9h6R3-WQGWr2UCYKQ_
X-Proofpoint-GUID: tAW35PHAZfQW0w9h6R3-WQGWr2UCYKQ_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-23_09,2024-07-23_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxscore=0 malwarescore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 lowpriorityscore=0 clxscore=1011
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2407230129

On 6/7/2024 10:47 AM, Vinod Koul wrote:
> 
> On Mon, 03 Jun 2024 10:06:42 -0700, Jeff Johnson wrote:
>> make allmodconfig && make W=1 C=1 reports:
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/qcom/hdma_mgmt.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/qcom/hdma.o
>>
>> Add the missing invocations of the MODULE_DESCRIPTION() macro, using
>> the descriptions from the associated Kconfig items.
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/1] dmaengine: qcom: add missing MODULE_DESCRIPTION() macros
>       commit: 8e9d83d7228f663ef340ebb339eaffc677277bd4
> 

Hi Vinod,
I see this landed in linux-next, but is not currently in Linus' tree for 6.11.
Will you be able to have this pulled during the merge window?
I'm trying to eradicate all of these warnings before 6.11 rc-final.

Thanks!
/jeff


