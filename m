Return-Path: <dmaengine+bounces-2924-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F119593CB
	for <lists+dmaengine@lfdr.de>; Wed, 21 Aug 2024 06:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B2A2285192
	for <lists+dmaengine@lfdr.de>; Wed, 21 Aug 2024 04:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9EC1607BB;
	Wed, 21 Aug 2024 04:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mLwTrOXP"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87BA1803E;
	Wed, 21 Aug 2024 04:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724216390; cv=none; b=F7bGwF0NnAksXRjCJXETL2d8Rd7qf1G9FAX6v5byNCj2zZp6iKHcUbP/OZUfWf5WIAhww1v1XIdrfxOm1zabPPf6FQgFyMD2hcl0D8HpZSX3LQGJXlcdUI7m5XX1Bulhykrv4RiisOQboeuEhpty7rxGVIjSYzrjmoHO4Cu7esI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724216390; c=relaxed/simple;
	bh=ZuO+q2nvd3d+RSRFEQoLncy7eNLTGrrCActBdttuONs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cfE665sR4JAL3Q1jfefG0FElygUM9JXJAqNjgx2473k9ssrIhiG+C2GgZuAq8KkrQqZGIYBzI78Hc2/v/1yUTGhNonvweLwy7F8nM0uzvJV6SdM3oLpEYltei/iqGQ+elFgC0RYWF/CKf+7WUb05yGnDA0LwjJQH/S0OIHh5mME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mLwTrOXP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47KJDE29010532;
	Wed, 21 Aug 2024 04:54:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jcWwbiUMYrpobdmpXgzPaz+YTQa+WRne25FqgulMjWQ=; b=mLwTrOXPXK0gOHr1
	0PAVsxlyvuSuK3TbOKJA1dMh2ynjycU16rLdTLm/vxJfqQy4ptcDZpq3JZ7QA1Ch
	j2QFF7U5n0LCyeeNd8Q/0QkQE2HyuNuhUBfAwu0+8JejXZooeiFb8JwLB47ip6Ag
	s1gHPqEAGpXT8p1yIuUqATBLKBwQVi68Z19xCXiaZFfflOsqqGWQhWlvIhDJ7Ni7
	OP8GAsGVEhYKR5AFDlcHDsp4WiDwLvDsEnJCke7cF8Md0l1Ig+NFJ3i2rSaiN0TL
	0GlqVBhSwdF3wviynGEKpDXQq50FT2UUOJRBRaIYcq+3PxO3y6wrXerTthrSmmyh
	vaNM4g==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 413qxg7f7c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 04:54:35 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47L4sY1q010823
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 04:54:34 GMT
Received: from [10.151.37.94] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 20 Aug
 2024 21:54:28 -0700
Message-ID: <2b98460e-d258-e785-fb8e-3dd03746352e@quicinc.com>
Date: Wed, 21 Aug 2024 10:24:15 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 01/16] dt-bindings: dma: qcom,bam: Add bam pipe lock
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
 <20240815085725.2740390-2-quic_mdalam@quicinc.com>
 <7kgah2aajgyybdmpwfzgd25mi2lc4v6xv2k3mif576wo7bw2wn@i43mt2c34chg>
Content-Language: en-US
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <7kgah2aajgyybdmpwfzgd25mi2lc4v6xv2k3mif576wo7bw2wn@i43mt2c34chg>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Myqpk0GJqFvjRIyym-MkZi3QXsqdFqtl
X-Proofpoint-GUID: Myqpk0GJqFvjRIyym-MkZi3QXsqdFqtl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_05,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408210033



On 8/16/2024 9:23 PM, Bjorn Andersson wrote:
> On Thu, Aug 15, 2024 at 02:27:10PM GMT, Md Sadre Alam wrote:
>> BAM having pipe locking mechanism. The Lock and Un-Lock bit
>> should be set on CMD descriptor only. Upon encountering a
>> descriptor with Lock bit set, the BAM will lock all other
>> pipes not related to the current pipe group, and keep
>> handling the current pipe only until it sees the Un-Lock
>> set.
> 
> This describes the mechanism for mutual exclusion, but not really what
> the patch does.
   Ok, will update in next patch.
> 
> https://docs.kernel.org/process/submitting-patches.html#the-canonical-patch-format
> states that you have 75 characters for your commit message, use them.
   ok, will update in next patch.
> 
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
> 
> '_' is not a valid character in node names or properties.
    Ok, will update in next patch.
> 
>> +    type: boolean
>> +    description:
>> +      Indicates that the bam pipe needs locking or not based on client driver
>> +      sending the LOCK or UNLOK bit set on command descriptor.
> 
> Missing 'C'?
   Ok, will fix in next patch.
> 
> Regards,
> Bjorn
> 
>> +
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

