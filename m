Return-Path: <dmaengine+bounces-6934-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7F1BFF409
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 07:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25A583A9490
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 05:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71417266565;
	Thu, 23 Oct 2025 05:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ivdyKwQw"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA64A2BB13;
	Thu, 23 Oct 2025 05:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761197475; cv=none; b=Hnu5PKBM/3HXUBO7Tb78eO/GQ2yXsQahC5VBQOyVRZERHyyTu566XwthHcJHN9AdkdbAKpvCzC3KGdC8y4qVQ/gJbng8Tbm+dawfey3LB/JluvuLH+MOqOh9FV0zZbLcITmD20E0bs7gulLYnw9VRPQHRO9rEdWlwUyYN89crA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761197475; c=relaxed/simple;
	bh=7WDMtkx0sOOKHkJ+Y2LONWCnPU3vi3Qh5nVGWLWViU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=M9pIaApPwl98823grED1/uNJcUtQoHew0A+Xx5pflynvIUDNsGHPDri/aHDn++XOH3mqLakBv8vC7xTnRbKeyGuAOlJ/sjJeDdJSQnzKQZ3ElmPHAdX05ARj/w4DuqmFWFy4U08A4PX2ogGAgP9e93GUaJ46P34EjfXwZNfEvJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ivdyKwQw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MIenua022437;
	Thu, 23 Oct 2025 05:31:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ilmR85lRGyo8xRnJVHKeqFO1YA0neJLGXLxpgoeYqKI=; b=ivdyKwQwOawDHXh7
	AqQ1UiYfieFoPsa1QIYF0aEjVmyDfYRuAYZgmDGXmDWfXXYL6Lx9xZb7+shDDbuT
	BTYppeRg4hE7PJ5ggJ84yHcn4tgonF61xJ0L+En/HiawVeIWfXWRPM85z+MNuZcA
	e4cQiYD3Qx4KMJfHF2X316YcRWM4sn9aePNIbVgxvyUa2rT1EbssC8fvbb1jCdtz
	ibvpk5//R+xeGOaWb59Vf5J6+RXvDdIW6tCZ0ZEWLJKL8Iu4R705dReD0vgRD92g
	Hgs4A9DzAmnRMdqyV6PiK2OltvdZANX7hLGgKMu63N1AyiCUU9FfPm1TcTD3CV/7
	eGo0Zw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v1w874jv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 05:31:10 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 59N5V9vt030242
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 05:31:09 GMT
Received: from [10.151.36.184] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.24; Wed, 22 Oct
 2025 22:30:24 -0700
Message-ID: <e7a8d7a7-b14e-12e7-76ea-64c4c20b3ddf@quicinc.com>
Date: Thu, 23 Oct 2025 11:00:09 +0530
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
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Mark Brown
	<broonie@kernel.org>
CC: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <konradybcio@kernel.org>, <vkoul@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <quic_varada@quicinc.com>
References: <20251014110534.480518-1-quic_mdalam@quicinc.com>
 <20251014110534.480518-2-quic_mdalam@quicinc.com>
 <dd1e4289-5e36-4b24-9afd-f09569459a96@sirena.org.uk>
 <96ae7d38-4ce0-fa34-e6f0-6bb6e4ceaa28@quicinc.com>
 <0a743099-face-4cc1-91ef-098a748604b7@sirena.org.uk>
 <49eb9f15-fad9-4f8d-1463-04cd692bbe51@quicinc.com>
 <41481de2-12fd-49b5-b3bd-f3e44e78dcb3@oss.qualcomm.com>
Content-Language: en-US
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <41481de2-12fd-49b5-b3bd-f3e44e78dcb3@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxNSBTYWx0ZWRfX4SsOwLxmFEo/
 ogK+YHR53u3ABkx7Pb3b9ewaoN/CTtH3AY6Gwc/EfTvHOsp/5mh8gZGsNU72GqgI0jaPBxU7Clp
 i0E1iLuu28zJMkJHw7NylclWnrAoqWrI3ocNObAE9DHFc4uC4b070LLJs5UTb3MvF6Hdj6GNxg7
 5Jq4LBPnUVgPH3Nn0ducHt/GwjOCX/gag2B9nW3aPUq8rOVr7TF1hu6+hsSv2Cz3NJuT23rA57L
 yt4nsfg4HL+jMvJb+EO2ivUO4PIq8MXXTJjwBYHs5XmC9XhBPPvKOlEJq7lT5JDkMr9PSPpUxfJ
 2WqmV2w/CuIDYSkCreRTbHFKJT6aIuhBZ2KSJpqJmwNjwkQYZFb7UopZL0Iqdv6jd9vm4Erq+6p
 nT4LHdwXedANqtE0yHsVU2taXnjgZg==
X-Authority-Analysis: v=2.4 cv=bNUb4f+Z c=1 sm=1 tr=0 ts=68f9bd9e cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=K17UtqApAXQEPGeoAsEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
 a=HhbK4dLum7pmb74im6QT:22 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-GUID: DHNAD2d0NJZM2whWa0Zm9NoMa6gyITZ3
X-Proofpoint-ORIG-GUID: DHNAD2d0NJZM2whWa0Zm9NoMa6gyITZ3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180015



On 10/22/2025 8:58 PM, Konrad Dybcio wrote:
> On 10/22/25 5:20 PM, Md Sadre Alam wrote:
>> Hi,
>>
>> On 10/22/2025 4:12 PM, Mark Brown wrote:
>>> On Wed, Oct 22, 2025 at 12:29:01PM +0530, Md Sadre Alam wrote:
>>>> On 10/22/2025 12:39 AM, Mark Brown wrote:
>>>>> On Tue, Oct 14, 2025 at 04:35:26PM +0530, Md Sadre Alam wrote:
>>>>>> IPQ5424 contains the QPIC-SPI-NAND flash controller which is the same as
>>>>>> the one found in IPQ9574. So let's document the IPQ5424 compatible and
>>>>>> use IPQ9574 as the fallback.
>>>
>>>>> This doesn't apply against current code, please check and resend.
>>>
>>>> Thank you for the feedback. I’d appreciate a bit more clarity on what
>>>> “doesn't apply against current code” refers to in this context. I’ve
>>>> manually applied the patch against the latest mainline (torvalds/linux) and
>>>> it applied cleanly without any conflicts. Please let me know if there’s a
>>>> specific tree or integration point I should be checking against.
>>>
>>> I tried to apply it to the spi tree
>>>
>>>     https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-6.19
>> Thanks for letting me know — I’ll rebase the patch on the SPI tree (for-6.19) and resend it.
> 
> JFYI you can generally count on linux-next/master as a good base
Thanks Konrad — noted! I’ll use linux-next/master as my base going forward.

Thanks,
Alam.

