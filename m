Return-Path: <dmaengine+bounces-6921-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E79F2BFA686
	for <lists+dmaengine@lfdr.de>; Wed, 22 Oct 2025 09:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 46900503ECF
	for <lists+dmaengine@lfdr.de>; Wed, 22 Oct 2025 06:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B758F2F290E;
	Wed, 22 Oct 2025 06:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MlHKaN0z"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AA52F3609;
	Wed, 22 Oct 2025 06:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761116354; cv=none; b=W1k6p+eiCtzyO6xrKa4BiNpzMOepoEYFSMAUgpao5w9QWxh5Zet8Dso1eg/puIE0BsaYYzScAIN60cKby0iwkS7lM0+AQUzwVv8KgG68blTcSSbwu46HKEhzCJG2cDyjwgIWm2XTRqPMD89q1ORCwKss+ELJ1aWGtFvhoy9XHqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761116354; c=relaxed/simple;
	bh=fLm80y5DeCd7BjYiy8AWXL4fxOKpiG5SPopQ/f7y0Is=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HiuT1W9mF1fILpp0rd9gE+i0MEQLsYQVMqXVZSS02LCeGn2/68mliwvVPGDvY8+Wf2uRvpLuAhRbzPgqYo47IoFOnajtyv1PHrUY5sT4SqMVcEJlk5NtLvoTkk1+Gu63FNItx+ZL/sPomVISem54zrXLd44RaH2kg4d1fzCWEt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MlHKaN0z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M3wIwc024209;
	Wed, 22 Oct 2025 06:59:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3i07+l+uWJPPHEU6fHn5Iyu6aez5sgkNVeYntCduk94=; b=MlHKaN0zeNzzmCbR
	7x+V5qbFHvxVJAAIFu998asumKyIwVSB7oKZlsVU/OiGOZsO39anUkewRXsRLLIE
	Dnx6wiRu8sS3ylIwO42G7VxtEGE9ZfnR46I/jqXsIA3lhANAwF4PyuepNm43cOrr
	WVQhiUv7tb5LEjxzM4XQ4KMZ89axC8YbbXMIMjhzqL+B2cy89vAY/963SuzwtrLL
	t26IdZx+a68U/v3tJjbBiEEwg30VEWsHVZVLwxrzdp7+jXs+cJNkIZHOe5Xsw0M6
	Za9ZvJoFEhXIIy4EgqbMJRi0Az/SbEm19ICAFMV0Shsnuo706sOhGHMSeTKRcvEd
	GB+lcw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v1w83n68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 06:59:09 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 59M6x8um032737
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 06:59:08 GMT
Received: from [10.151.36.184] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.24; Tue, 21 Oct
 2025 23:59:04 -0700
Message-ID: <96ae7d38-4ce0-fa34-e6f0-6bb6e4ceaa28@quicinc.com>
Date: Wed, 22 Oct 2025 12:29:01 +0530
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
To: Mark Brown <broonie@kernel.org>
CC: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <konradybcio@kernel.org>, <vkoul@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <quic_varada@quicinc.com>
References: <20251014110534.480518-1-quic_mdalam@quicinc.com>
 <20251014110534.480518-2-quic_mdalam@quicinc.com>
 <dd1e4289-5e36-4b24-9afd-f09569459a96@sirena.org.uk>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <dd1e4289-5e36-4b24-9afd-f09569459a96@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxNSBTYWx0ZWRfX0IPdfp5J8ZQN
 4vea2Rd6y7a9Li+/jf5ZnuTKe2LCBc/BFHLL2hwQ+w45Ux4hfDMQusX48Q+/OIJFgIqLALzo++x
 +EbWMNQRvDTNwgMs7MMkuGjREUodxA6Fc/VkyUaeqndML5Nr5MYClf7tO7+WjE/Uilh1JTvBGDE
 lnDyxffENpj8kR7nFZUCXROymEFNn9FtNhvFyv3fDGvnvLVX7iWdHM/7bdPyzlb38k7TSfAxPWQ
 3PKK7NeTdhnNyaZCqa4stfMp0NOnZO2tQ8p5Sykf7kYKEWM+DFkOmlgjLsGNzT1XIlU/nhMf+oq
 zbb6R7AuNsWnPxO262owqtaDhoZfVKAQKGfCVffFitYl/X9Akm8Z7O5bbpA953fVr+NoD0XBgEm
 EEtcTBEP6Hja5iFCIsdz8Flpipunkg==
X-Authority-Analysis: v=2.4 cv=bNUb4f+Z c=1 sm=1 tr=0 ts=68f880bd cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=_0GQtCzl9aOVDYM4pBEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10 a=HhbK4dLum7pmb74im6QT:22
 a=cPQSjfK2_nFv0Q5t_7PE:22 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-GUID: t-5wmJQ0Ch1TLo2XtHsg-DecuLU4MTvU
X-Proofpoint-ORIG-GUID: t-5wmJQ0Ch1TLo2XtHsg-DecuLU4MTvU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180015

Hi,

On 10/22/2025 12:39 AM, Mark Brown wrote:
> On Tue, Oct 14, 2025 at 04:35:26PM +0530, Md Sadre Alam wrote:
>> IPQ5424 contains the QPIC-SPI-NAND flash controller which is the same as
>> the one found in IPQ9574. So let's document the IPQ5424 compatible and
>> use IPQ9574 as the fallback.
> 
> This doesn't apply against current code, please check and resend.
Thank you for the feedback. I’d appreciate a bit more clarity on what 
“doesn't apply against current code” refers to in this context. I’ve 
manually applied the patch against the latest mainline (torvalds/linux) 
and it applied cleanly without any conflicts. Please let me know if 
there’s a specific tree or integration point I should be checking against.

Thanks,
Alam.

