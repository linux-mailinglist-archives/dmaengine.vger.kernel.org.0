Return-Path: <dmaengine+bounces-2923-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9280E9593C4
	for <lists+dmaengine@lfdr.de>; Wed, 21 Aug 2024 06:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47DDA1F23293
	for <lists+dmaengine@lfdr.de>; Wed, 21 Aug 2024 04:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8316A1607B8;
	Wed, 21 Aug 2024 04:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OWWviUqP"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6318175A6;
	Wed, 21 Aug 2024 04:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724216290; cv=none; b=dc9UWfUqpDS3n32eMrmIGfOgpVa3ttZpI5iu+hJdeJNHtZnDQK1yYUPWycLSBVeiF/tsjmIL7cpwHtjvh3fp0XvjoGmjcamLrP6+NrYP0d7Dhs6T1cadI905B0JPNSxNXqkGjxXSAO5AVKJUSfiXh/2bo/gJyTsbLfkE3NXMacc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724216290; c=relaxed/simple;
	bh=QOSx7fzMAFJxsGhKJlneRo5ceyJtesGSUYDO2VYaPKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bfFJMQib4pFDE4MF2wyKopIkbyVzlmY5Pd75DvU7F8cvCsZAT4oOc6CLPuwQ21Bqi2JPpeRUe13nKy+MzNP+QKz5ra0B8LeMVv5qodk60tYQOF+akObfOfxuzohywkeJw/D4t7BS3j3A/xBi6+wOTuO0A2631GBLovpOCC927S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OWWviUqP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47KJ0lgv013804;
	Wed, 21 Aug 2024 04:57:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	I9McFpZaIgeSy/Ye7hu1bUSfrysCm35rQyEmbFsAmUc=; b=OWWviUqPCjPep+tb
	EXn4V6F/v29yKRDDKOmJi4z9DaJBF0XZlFXVzzDpDNEccuWkUmo8ciV6V0r1Xwvd
	kjQ66kNCLwBn1DJ7snYXGYBj5yrMk99oQOs1hEN/oP5Z8XbQapXTm+IT7jsPW42d
	aLPEOF6YaP7hSsXK62DljVuWCe78LvI73/n9u5vgXlC61mxa3Vn2i+kXFSs+Rypw
	X3YqWBfjjpzS+yt4az/2nmAwhxIhAghUEY3MMAuTPUGR6en4zPja/kWfgQDZ4KzR
	s2HqLiSNHI6Iy/2cevIjhPdv8Lmytm1JDaRRw5K+QPPdjWDrt4sN5TcnTrZh+jet
	cWnZTw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 413qxg7fcy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 04:57:57 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47L4vuKb001961
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 04:57:56 GMT
Received: from [10.151.37.94] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 20 Aug
 2024 21:57:49 -0700
Message-ID: <183d4f5e-e00a-8ef6-a589-f5704bc83d4a@quicinc.com>
Date: Wed, 21 Aug 2024 10:27:46 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 00/16] Add cmd descriptor support
Content-Language: en-US
To: Bjorn Andersson <andersson@kernel.org>
CC: <vkoul@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <konradybcio@kernel.org>,
        <thara.gopinath@gmail.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <gustavoars@kernel.org>,
        <u.kleine-koenig@pengutronix.de>, <kees@kernel.org>,
        <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>,
        <quic_utiwari@quicinc.com>
References: <20240815085725.2740390-1-quic_mdalam@quicinc.com>
 <3p43hay67bofcddnar7wm2bsods5zqbylnjhnd22gcbniztymn@2zziltxxbaiv>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <3p43hay67bofcddnar7wm2bsods5zqbylnjhnd22gcbniztymn@2zziltxxbaiv>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: T91SLxe_KVoBv10Mh3y9vibqgqy0K1Sj
X-Proofpoint-GUID: T91SLxe_KVoBv10Mh3y9vibqgqy0K1Sj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_05,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxlogscore=992 malwarescore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408210033



On 8/16/2024 9:31 PM, Bjorn Andersson wrote:
> On Thu, Aug 15, 2024 at 02:27:09PM GMT, Md Sadre Alam wrote:
>> This series of patches will add command descriptor
>> support to read/write crypto engine register via
>> BAM/DMA
>>
>> We need this support because if there is multiple EE's
>> (Execution Environment) accessing the same CE then there
>> will be race condition. To avoid this race condition
>> BAM HW hsving LOC/UNLOCK feature on BAM pipes and this
>> LOCK/UNLOCK will be set via command descriptor only.
>>
>> Since each EE's having their dedicated BAM pipe, BAM allows
>> Locking and Unlocking on BAM pipe. So if one EE's requesting
>> for CE5 access then that EE's first has to LOCK the BAM pipe
>> while setting LOCK bit on command descriptor and then access
>> it. After finishing the request EE's has to UNLOCK the BAM pipe
>> so in this way we race condition will not happen.
>>
>> tested with "tcrypt.ko" and "kcapi" tool.
>>
>> Need help to test these all the patches on msm platform
>>
>> v2:
>>   * Addressed all the comments from v1
> 
> Please describe the actual changes you're making between your versions.
   Sure , will update in next patch.
> 
>>   * Added the dt-binding
>>   * Added locking/unlocking mechanism in bam driver
> 
> Seems to me that this was already part of v1, as patch 6/11?
   Sorry, by mistake I have added this line in v2.
> 
> Regards,
> Bjorn
> 
>>
>> v1:
>>   * https://lore.kernel.org/lkml/20231214114239.2635325-1-quic_mdalam@quicinc.com/
>>   * Initial set of patches for cmd descriptor support
>>
>> Md Sadre Alam (16):
>>    dt-bindings: dma: qcom,bam: Add bam pipe lock
>>    dmaengine: qcom: bam_dma: add bam_pipe_lock dt property
>>    dmaengine: qcom: bam_dma: add LOCK & UNLOCK flag support
>>    crypto: qce - Add support for crypto address read
>>    crypto: qce - Add bam dma support for crypto register r/w
>>    crypto: qce - Convert register r/w for skcipher via BAM/DMA
>>    crypto: qce - Convert register r/w for sha via BAM/DMA
>>    crypto: qce - Convert register r/w for aead via BAM/DMA
>>    crypto: qce - Add LOCK and UNLOCK flag support
>>    crypto: qce - Add support for lock aquire,lock release api.
>>    crypto: qce - Add support for lock/unlock in skcipher
>>    crypto: qce - Add support for lock/unlock in sha
>>    crypto: qce - Add support for lock/unlock in aead
>>    arm64: dts: qcom: ipq9574: enable bam pipe locking/unlocking
>>    arm64: dts: qcom: ipq8074: enable bam pipe locking/unlocking
>>    arm64: dts: qcom: ipq6018: enable bam pipe locking/unlocking
>>
>>   .../devicetree/bindings/dma/qcom,bam-dma.yaml |   8 +
>>   arch/arm64/boot/dts/qcom/ipq6018.dtsi         |   1 +
>>   arch/arm64/boot/dts/qcom/ipq8074.dtsi         |   1 +
>>   arch/arm64/boot/dts/qcom/ipq9574.dtsi         |   1 +
>>   drivers/crypto/qce/aead.c                     |   4 +
>>   drivers/crypto/qce/common.c                   | 142 +++++++----
>>   drivers/crypto/qce/core.c                     |  13 +-
>>   drivers/crypto/qce/core.h                     |  12 +
>>   drivers/crypto/qce/dma.c                      | 232 ++++++++++++++++++
>>   drivers/crypto/qce/dma.h                      |  26 +-
>>   drivers/crypto/qce/sha.c                      |   4 +
>>   drivers/crypto/qce/skcipher.c                 |   4 +
>>   drivers/dma/qcom/bam_dma.c                    |  14 +-
>>   include/linux/dmaengine.h                     |   6 +
>>   14 files changed, 424 insertions(+), 44 deletions(-)
>>
>> -- 
>> 2.34.1
>>

