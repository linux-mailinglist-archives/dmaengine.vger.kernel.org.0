Return-Path: <dmaengine+bounces-2873-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 258A4954882
	for <lists+dmaengine@lfdr.de>; Fri, 16 Aug 2024 14:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A83161F223A6
	for <lists+dmaengine@lfdr.de>; Fri, 16 Aug 2024 12:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A74E19FA91;
	Fri, 16 Aug 2024 12:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DoBwLVp8"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4448B13AA2B;
	Fri, 16 Aug 2024 12:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723810171; cv=none; b=O8zZXsiRkXGWQQV3c26STvQgIzdPA1adLRbmJa25noA0h0MjQkyPbxw5Jlrr5raNYtP6Gd9ZiygCD7rpeobr47wTV1QIY4T8mpbueFPZBL9g7J4tBgAuIMAS2zEob96ogqBNosELNII0E8wpYbOEUCKtckfKF2V5KCsG+3VmxGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723810171; c=relaxed/simple;
	bh=ssDzuyZYKj2TsincB2yA+zCltvCHnFaG6dUqlEY8INw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=p7mmoaW8vJMjGpYiV5c50oILY58AnLmB/l4f2m5ctQeIe1SQaQk775rWrXg4YCx+lPz71A3WhzSfNfrlA4YxXnWyMAv9kQ63fpnukTTB/TXBmnujscdazTtTSbQPZz/myo48a/gsJt7XB9hTMAn64XfjCQ6+/PwMRmbJklTZ6kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DoBwLVp8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47G71hI3032570;
	Fri, 16 Aug 2024 12:04:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7+gfS5ltFtO1Jxub9Fy/GIcO9Ez0LcxryZ2AZ4lP5oA=; b=DoBwLVp8A/HVFgbg
	f3c9qxQv329gLrejA+N/5q/HlbmxfZxcOEb7ZjS2p/IctLiBblg7e7NJe0XkvMnN
	vIL+A6+seUlcfN4tsbOi1PBteodOc2BEuSf0jLZICy5rwnbYdOSXpa8zYJbPiNR/
	sxvo84QdrLV3XpgV18cQXCumkqXwz1Pp3nOZevB7i8fdKk/5rvi6fenIMAlDKjs2
	gqGYffJtulig9l2SzhQXyme7fkCg8qckugYKiMC3ey8R5XlMVztU4cJFGxg+58PN
	s2IShPQdXrHtIqC7t2mzY7xqp3v+bEXRXUhyy0RxUXTUDj95nFBoK+oHs1FU+KIm
	OPLgoA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4104382992-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Aug 2024 12:04:02 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47GC41OF017819
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Aug 2024 12:04:01 GMT
Received: from [10.216.27.9] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 16 Aug
 2024 05:03:55 -0700
Message-ID: <21fa1207-be83-ffdc-deab-81c070bb94c7@quicinc.com>
Date: Fri, 16 Aug 2024 17:33:43 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 00/16] Add cmd descriptor support
To: Caleb Connolly <caleb.connolly@linaro.org>, <vkoul@kernel.org>,
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
 <f341e9e9-3da6-4029-9892-90e6ec856544@linaro.org>
Content-Language: en-US
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <f341e9e9-3da6-4029-9892-90e6ec856544@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rr_TjtZmS9cGzTqFnZeuP3hLllP6xUtC
X-Proofpoint-GUID: rr_TjtZmS9cGzTqFnZeuP3hLllP6xUtC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-16_03,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408160088



On 8/15/2024 6:38 PM, Caleb Connolly wrote:
> Hi,
> 
> A note for future patches, please scope your cover letter subject:
> 
> "dmaengine: qcom: bam_dma: add cmd descriptor support"

   Sure will add this in next patch.
> 
> On 15/08/2024 10:57, Md Sadre Alam wrote:
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
> 
> DT changes here are only for a few IPQ platforms, please explain in the cover letter if this is some IPQ specific feature which doesn't exist on other platforms, or if you're only enabling it on IPQ.

    This feature is BAM hardware feature so its applicable for all the QCOM Soc where bam is there. Its not IPQ specific. Will add all the explanation in cover letter in next patch
> 
> Some broad strokes testing instructions (at the very least) and requirements (testing on what hardware?) aren't made obvious at all here.

    Sure will update in cover letter in next patch.
> 
> Kind regards,
>>
>> v2:
>>   * Addressed all the comments from v1
>>   * Added the dt-binding
>>   * Added locking/unlocking mechanism in bam driver
>>
>> v1:
>>   * https://lore.kernel.org/lkml/20231214114239.2635325-1-quic_mdalam@quicinc.com/
>>   * Initial set of patches for cmd descriptor support
>>
>> Md Sadre Alam (16):
>>    dt-bindings: dma: qcom,bam: Add bam pipe lock
>>    dmaengine: qcom: bam_dma: add bam_pipe_lock dt property
>>    dmaengine: qcom: bam_dma: add LOCK & UNLOCK flag support
>>    crypto: qce - Add support for crypto address read
>>    crypto: qce - Add bam dma support for crypto register r/w
>>    crypto: qce - Convert register r/w for skcipher via BAM/DMA
>>    crypto: qce - Convert register r/w for sha via BAM/DMA
>>    crypto: qce - Convert register r/w for aead via BAM/DMA
>>    crypto: qce - Add LOCK and UNLOCK flag support
>>    crypto: qce - Add support for lock aquire,lock release api.
>>    crypto: qce - Add support for lock/unlock in skcipher
>>    crypto: qce - Add support for lock/unlock in sha
>>    crypto: qce - Add support for lock/unlock in aead
>>    arm64: dts: qcom: ipq9574: enable bam pipe locking/unlocking
>>    arm64: dts: qcom: ipq8074: enable bam pipe locking/unlocking
>>    arm64: dts: qcom: ipq6018: enable bam pipe locking/unlocking
>>
>>   .../devicetree/bindings/dma/qcom,bam-dma.yaml |   8 +
>>   arch/arm64/boot/dts/qcom/ipq6018.dtsi         |   1 +
>>   arch/arm64/boot/dts/qcom/ipq8074.dtsi         |   1 +
>>   arch/arm64/boot/dts/qcom/ipq9574.dtsi         |   1 +
>>   drivers/crypto/qce/aead.c                     |   4 +
>>   drivers/crypto/qce/common.c                   | 142 +++++++----
>>   drivers/crypto/qce/core.c                     |  13 +-
>>   drivers/crypto/qce/core.h                     |  12 +
>>   drivers/crypto/qce/dma.c                      | 232 ++++++++++++++++++
>>   drivers/crypto/qce/dma.h                      |  26 +-
>>   drivers/crypto/qce/sha.c                      |   4 +
>>   drivers/crypto/qce/skcipher.c                 |   4 +
>>   drivers/dma/qcom/bam_dma.c                    |  14 +-
>>   include/linux/dmaengine.h                     |   6 +
>>   14 files changed, 424 insertions(+), 44 deletions(-)
>>
> 

