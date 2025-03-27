Return-Path: <dmaengine+bounces-4786-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C30A72E18
	for <lists+dmaengine@lfdr.de>; Thu, 27 Mar 2025 11:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94B1D1782C8
	for <lists+dmaengine@lfdr.de>; Thu, 27 Mar 2025 10:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EC7204F7D;
	Thu, 27 Mar 2025 10:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TiU74tr/"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F314158553;
	Thu, 27 Mar 2025 10:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743072424; cv=none; b=ZNcFh9bYQHBs/38ubTXybIzAbgDzokt0kUfXO9pkIG31eh9ar8nZ1fifTwkTPKS2k7whdYXm+I+vXSsQ8UMAwMESAsHNse8PPx5bWiSKxYpXUjTHF3f/8Uc7yeyNFQFcabzuF+VhSLqytHKlZqftnV4uo4yyNNZu8WDLsaniP18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743072424; c=relaxed/simple;
	bh=q6eLCM9m9tdf5FHOuWhLS1KtcQTHHwd78ODHnG8D2iM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=l25VggiFzhlHhE5E5uSus69qnWXnQOhJNU7XqW71WRx129Nxs1QthKTez+x4hxc63eja0lzDXHrT649DYnF9JabjWZeopyB1Z4TpUXYgycA6ri1T0+sfmv9eBUKoZMLfEfB2Tzmp9hoWoeKUI4nB8KdNVv9AuCujYNCh/I0grMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TiU74tr/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52R5jD3g021227;
	Thu, 27 Mar 2025 10:46:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zflJaGi8Iu07joFHAVIRGs6+kBty2ftSAYz9D2DjFAw=; b=TiU74tr/l7ODWCPz
	AadR8Vkm6oX356OuJjboL3+s/C+IyKJxh+Ot5bgB3z/kraFrZVQm4wEPTNbiKxFh
	kYt5lOH7OjhT2e22CvTzTF+J7xhH9pZ42zV1dOGslUbq9HQGB/VoCAC/PUsU5w9U
	VsZONTybbz2fLll3JuPGbxqQkTvsX66OmriEGL45XJLRmdON0e+Cve7JUX6q4Yah
	W1IoHIQnKXhxhq/LlVpQZYwHIz1L39AzVKCIvOPjzIQlRH54ZVm1Hod001BfxlWG
	VU8atUKL46oBWHZnvpfMQeJVOO9AxzWXENrUUsF/e0HTob/4juUuuO1QszmtevK7
	utp94g==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45kyr9p1ew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 10:46:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52RAkpYo017409
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 10:46:51 GMT
Received: from [10.216.8.158] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 27 Mar
 2025 03:46:45 -0700
Message-ID: <49186309-72f5-faa5-bcae-739c6b5e7d30@quicinc.com>
Date: Thu, 27 Mar 2025 16:16:42 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/6] dt-bindings: dma: qcom,bam: Document dma-coherent
 property
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>, <vkoul@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <manivannan.sadhasivam@linaro.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <agross@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>
References: <20250313130918.4238-1-quic_kaushalk@quicinc.com>
 <20250313130918.4238-3-quic_kaushalk@quicinc.com>
 <572630ae-50bb-4575-8885-1d97b602ca8f@kernel.org>
From: Kaushal Kumar <quic_kaushalk@quicinc.com>
In-Reply-To: <572630ae-50bb-4575-8885-1d97b602ca8f@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JhHUnpaRcdG96V7po4YruSElUVhKsVzp
X-Authority-Analysis: v=2.4 cv=UblRSLSN c=1 sm=1 tr=0 ts=67e52c9c cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=jO2oUhU3BBFrcGlQPxsA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: JhHUnpaRcdG96V7po4YruSElUVhKsVzp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_01,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 mlxscore=0 impostorscore=0
 adultscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503270073

On 3/13/2025 8:20 PM, Krzysztof Kozlowski wrote:
> On 13/03/2025 14:09, Kaushal Kumar wrote:
>> SDX75 BAM DMA controller has DMA-coherent support so define
>> it in the properties section, without which 'dtbs_check'
>> reports the following error:
>>
>>    controller@1c9c000: 'dma-coherent' does not match any of the
>>    regexes: 'pinctrl-[0-9]+'
> How can I reproduce it?
It is not an existing error. It is the error that would come unless the 
new property is defined. Will remove this part of commit text in v2.
> Fixes tag?
>
>> Signed-off-by: Kaushal Kumar <quic_kaushalk@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
>> index 3ad0d9b1fbc5..c4dd6a503964 100644
>> --- a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
>> +++ b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
>> @@ -39,6 +39,8 @@ properties:
>>     "#dma-cells":
>>       const: 1
>>   
>> +  dma-coherent: true
>> +
> Which devices are DMA coherent?
Will update it under a bam version check in v2.
>
>
> Best regards,
> Krzysztof


