Return-Path: <dmaengine+bounces-6931-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 279DCBFCE0B
	for <lists+dmaengine@lfdr.de>; Wed, 22 Oct 2025 17:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D4D105022FB
	for <lists+dmaengine@lfdr.de>; Wed, 22 Oct 2025 15:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EA234FF68;
	Wed, 22 Oct 2025 15:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HevB38EV"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DA434DB7B;
	Wed, 22 Oct 2025 15:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761146822; cv=none; b=k14PeJnC2mlirWIqxrDPlpN+XbQW3R7fDImLbgKCbl6k21JmuY+9hNw9XkcC2YNNdBC49Q8TtMzU0ig/IYnhqnWS/YxPs+JAdWGQOw3xRpAZCQhvISpQyQBMj94BnnzHe6YXwVdQHsuqSsNqxzLzjnPxTdBPrV9ji3p6v3RbbtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761146822; c=relaxed/simple;
	bh=bUoTM94QLd9d0HTYl5mwzw/8e+747g5nj7s+u5lmBJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cFuNowBimOf6CH1FTg/PvC9D055nXgRlSolY4sup+uNnKaVAiYzlVFQGZXQP7sun6Q1ysP/htjz+GPTpBhpK1bw4gyoknYc95Ze2iqhTBI708VDYlbo2MHvwnm9R5NWVZWK6LWN3oHgcIn+EcnHjwOyZ7IwvPUSTjlSXoZhEQ0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HevB38EV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MA8v0w026228;
	Wed, 22 Oct 2025 15:26:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	atGzeSNsSmCje4O3zL4YfsN2MYoBMAJOySsMeFbHhOk=; b=HevB38EVnno9BExi
	+txJ/CSAl1QPymmGdlNgWyo4y73zs0PkGvRadWicX7KSWylarS0Do/hernFXSptb
	D12Qjjr+gFrctrlcQKVhlu6B6a4968RcMvmNqccXRW9EaW37TIlN1YjDBX1kttrz
	cmilTvBBwCscOrl4Cv0rxDLzikExioWWc6BnaHhjjE7SEqpx5ueMU9Pujotnqu5F
	o3Bpss9aAQebcTXPDqC/kwg9Rtsw981O+08p8qdKST+d/QSKm1esE5WHYxGXVeSU
	ecKxqx4C9Nq7wmpF/r7FjErvMNQmTymXRfFttbBle7Mfca+E0kjTxToEaXvWFYK5
	DoJzew==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49wsws7hky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 15:26:52 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 59MFQptB025783
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 15:26:51 GMT
Received: from [10.50.62.229] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.24; Wed, 22 Oct
 2025 08:26:46 -0700
Message-ID: <ab658b67-6f3b-e1ae-84fd-46f431c5bc0d@quicinc.com>
Date: Wed, 22 Oct 2025 20:56:43 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 1/9] spi: dt-bindings: spi-qpic-snand: Add IPQ5424
 compatible
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>, Mark Brown <broonie@kernel.org>
CC: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <konradybcio@kernel.org>, <vkoul@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <quic_varada@quicinc.com>
References: <20251014110534.480518-1-quic_mdalam@quicinc.com>
 <20251014110534.480518-2-quic_mdalam@quicinc.com>
 <dd1e4289-5e36-4b24-9afd-f09569459a96@sirena.org.uk>
 <96ae7d38-4ce0-fa34-e6f0-6bb6e4ceaa28@quicinc.com>
 <51c6871d-a125-4d76-adaf-d69d6628aa87@kernel.org>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <51c6871d-a125-4d76-adaf-d69d6628aa87@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIwMDE0OCBTYWx0ZWRfXx9R2lUypMDso
 Mjx1dfw57aKlIYETa6CdJt6MDK7eRBB+TQKTRQ/jxZF1aelijEB0AsgkV90wN3gkTJfNvA4AzrL
 rSXpbG7qctGPRKYP9QHsRztmwvm1mQWUMR/Zwa0ua6CfBEHYsO040hg7YKsCTg2mDIHRTle4uwu
 VkzTzISFMXB20qU361JEYObuG6E2kEsLM4PQcPx6WHPwLlS3Q7gdo8uEcrWnTEvdCgYehwlDo+Z
 PtI63BqIEwjBeSUsEXMntVTkpTm0fQQJaCGYWoMaMx1NTEF72wdUQJEbcpu70G2o5GO/wvVs63h
 AHXce1ip8PPKlHbdrP3/hrASQIbwckBsiDP7rlgw/UNuleDZsIAGPQnGxcvRVXT4DPreh74qeBa
 +vVzomeTKn3gE+efdexjbpXwbaIfkQ==
X-Proofpoint-GUID: jmbJSYuuhAKyrgNwCyI7TJUUqoZ1iAag
X-Proofpoint-ORIG-GUID: jmbJSYuuhAKyrgNwCyI7TJUUqoZ1iAag
X-Authority-Analysis: v=2.4 cv=a+E9NESF c=1 sm=1 tr=0 ts=68f8f7bc cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=JgJbQ4Zy_J6bZbfwEwAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22 a=HhbK4dLum7pmb74im6QT:22
 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510200148

Hi,

On 10/22/2025 4:31 PM, Krzysztof Kozlowski wrote:
> On 22/10/2025 08:59, Md Sadre Alam wrote:
>> Hi,
>>
>> On 10/22/2025 12:39 AM, Mark Brown wrote:
>>> On Tue, Oct 14, 2025 at 04:35:26PM +0530, Md Sadre Alam wrote:
>>>> IPQ5424 contains the QPIC-SPI-NAND flash controller which is the same as
>>>> the one found in IPQ9574. So let's document the IPQ5424 compatible and
>>>> use IPQ9574 as the fallback.
>>>
>>> This doesn't apply against current code, please check and resend.
>> Thank you for the feedback. I’d appreciate a bit more clarity on what
>> “doesn't apply against current code” refers to in this context. I’ve
>> manually applied the patch against the latest mainline (torvalds/linux)
> 
> 
> You can easily answer this by yourself. Did you send it to Torvalds? No.
> You sent it to someone else, so why do you assume someone else manages
> Torvalds' tree?
Sorry about that — I’ll make sure to verify and align with the correct 
subsystem tree going forward.
> 
>> and it applied cleanly without any conflicts. Please let me know if
>> there’s a specific tree or integration point I should be checking against.
> 
> 
> Please read submitting patches - it explains that. It also explains
> where to find the tree.
Thanks, I’ll go through Submitting Patches again and make sure I follow 
the right tree and workflow.

Thanks,
Alam.

