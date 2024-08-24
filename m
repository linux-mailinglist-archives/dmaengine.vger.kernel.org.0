Return-Path: <dmaengine+bounces-2961-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7112295DC5F
	for <lists+dmaengine@lfdr.de>; Sat, 24 Aug 2024 09:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E27D283A36
	for <lists+dmaengine@lfdr.de>; Sat, 24 Aug 2024 07:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B2E153BD7;
	Sat, 24 Aug 2024 07:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IYxl7xYi"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DE1153824;
	Sat, 24 Aug 2024 07:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724483430; cv=none; b=Ip+AYvCRjoKPLnokCZqra8yzmtujNQRWQiO55QMPienO+NKSIxZB8r6lTS9lveG1stayn5qY29QQo0JUGaIMEoIB57d64co7V5GU4tRItA3AGkrd9lqRejd4hrqF5n98vhQXXH5Qp6EAcZCAhICuVzdCEXfL7cXU3EW0c9j4FHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724483430; c=relaxed/simple;
	bh=UMSSgFtE9sSYCRl7FqDQxvs8kkccAFFNVpy/6zc6pq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qvLUYjaeKGHZbynOgSrVo47QD1DxOAQffaZGd/1GeYEpf+tg/1ryWwrnFWbEBWMZeJ33SBzK75SclsHx/oXD7baOOrVk+yOXqF2IztqcN+8/lcVS9xoRsFMdcB6T86rFynKKkQULzEF8kCVWeOFWLkSLugYlvn4nGGrasR0yrXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IYxl7xYi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47O5S3sA023727;
	Sat, 24 Aug 2024 07:05:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ak1bjo5v/J0lhnYtiB4yxlYX1xBnGK1uJl/2njt9Dn4=; b=IYxl7xYiJCXgkflT
	R2d2uDaG/EIKr4hQCBiCsdb8pOxHz81A7ktgxSvY3jeotypDcpgPvs0wRgJh8KPj
	leC13oK/4iC1zeovvBwfmFut1yI01apa1qVqaS3uvMRrgigosUFhPLshc4nsqFRm
	2shBJory1gY5/PA1EKyFT0WuuCEtPDkma9suMKFM2j1bUOs0qVnghTnDCH7d+tmj
	srPA/rezRTRGlrbDQQC+TgYPg47OtRFFEz5EoJT260+jHAgGgBIw8q394vS7QGbq
	xu9P7BccrFM0TPncSSpi89sxWXMgiIqxJ7uN4eRUD4q+f4x/Xmgag5mJuufPqUUM
	dnAaWw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 417980r36h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 24 Aug 2024 07:05:14 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47O75Dfp025819
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 24 Aug 2024 07:05:13 GMT
Received: from [10.216.42.154] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 24 Aug
 2024 00:05:06 -0700
Message-ID: <51653ef6-07f3-5419-e85b-b3e26958173f@quicinc.com>
Date: Sat, 24 Aug 2024 12:34:53 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 01/16] dt-bindings: dma: qcom,bam: Add bam pipe lock
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: <vkoul@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <thara.gopinath@gmail.com>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <gustavoars@kernel.org>, <u.kleine-koenig@pengutronix.de>,
        <kees@kernel.org>, <agross@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.com>, <quic_utiwari@quicinc.com>
References: <20240815085725.2740390-1-quic_mdalam@quicinc.com>
 <20240815085725.2740390-2-quic_mdalam@quicinc.com>
 <20240823153958.vk4naz34vgkqzhrb@thinkpad>
Content-Language: en-US
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <20240823153958.vk4naz34vgkqzhrb@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fgyA9iH7KNSk9YsPjZ7AZdROO68WMbCg
X-Proofpoint-ORIG-GUID: fgyA9iH7KNSk9YsPjZ7AZdROO68WMbCg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-24_05,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 phishscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408240039



On 8/23/2024 9:09 PM, Manivannan Sadhasivam wrote:
> On Thu, Aug 15, 2024 at 02:27:10PM +0530, Md Sadre Alam wrote:
>> BAM having pipe locking mechanism. The Lock and Un-Lock bit
>> should be set on CMD descriptor only. Upon encountering a
>> descriptor with Lock bit set, the BAM will lock all other
>> pipes not related to the current pipe group, and keep
>> handling the current pipe only until it sees the Un-Lock
>> set.
>>
>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>> ---
>>
>> Change in [v2]
>>
>> * Added initial support for dt-binding
>>
>> Change in [v1]
>>
>> * This patch was not included in [v1]
>>
>>   Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
>> index 3ad0d9b1fbc5..91cc2942aa62 100644
>> --- a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
>> +++ b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
>> @@ -77,6 +77,12 @@ properties:
>>         Indicates that the bam is powered up by a remote processor but must be
>>         initialized by the local processor.
>>   
>> +  qcom,bam_pipe_lock:
>> +    type: boolean
>> +    description:
>> +      Indicates that the bam pipe needs locking or not based on client driver
>> +      sending the LOCK or UNLOK bit set on command descriptor.
>> +
> 
> This looks like a pure driver implementation and doesn't belong to the DT at
> all. Why can't you add a logic in the driver to use the lock based on some
> detection mechanism?
   Sure , will use BAM_SW_VERSION register for detection mechanism, since this
   support only for bam version above 1.4.0.
> 
> - Mani
> 
>>     reg:
>>       maxItems: 1
>>   
>> @@ -92,6 +98,8 @@ anyOf:
>>         - qcom,powered-remotely
>>     - required:
>>         - qcom,controlled-remotely
>> +  - required:
>> +      - qcom,bam_pipe_lock
>>     - required:
>>         - clocks
>>         - clock-names
>> -- 
>> 2.34.1
>>
>>
> 

