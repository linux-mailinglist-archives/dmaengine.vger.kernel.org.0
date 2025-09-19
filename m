Return-Path: <dmaengine+bounces-6659-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EA7B87F70
	for <lists+dmaengine@lfdr.de>; Fri, 19 Sep 2025 08:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59CAA1C84090
	for <lists+dmaengine@lfdr.de>; Fri, 19 Sep 2025 06:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFA42638B2;
	Fri, 19 Sep 2025 06:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mWSFuNvr"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E31248F75;
	Fri, 19 Sep 2025 06:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758261667; cv=none; b=guFmDnggjhbqVYWHZ7Hxl01tD1vF3Uby9n2wdVDF76EjQyHojylbGGaCHWCpsHqZ+sN6Sf7LwzwQBMtNsiYdd1xcyCdS1srldyOm8AHd4Uue4j60IWu67S/OYu7cMOD6cuP5ppw2/Opo2PamTH2ctBx81PxkaNKOr7B6GTQnJ5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758261667; c=relaxed/simple;
	bh=z3/+iFx9GpU9aoBEeZGr+FCKfR5rMUyzkJHVVDiIuOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=J14RlILQre/8et+iplQU1AfMDkG0chyrgEnnnVhJAfiANK1Eq14Iv+/4IZAreOjVRHscYQoAwgzji8Qq6SG7iAXABfvHKT/O3aZTh/L4uNadYDLyxkTfgNtHoGVHVwxwRy3ndyg0Iv7qzCT10/+rj6NShyGpRurfVd4VFQnyATc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mWSFuNvr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IILElQ032429;
	Fri, 19 Sep 2025 06:01:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Q8AlDLjx1kkOTA7wt5nWeCVcMaPoYkyInxhn5l+39Ko=; b=mWSFuNvrHjApujYc
	hXCoH+nGY057kenomTs3tXK7tQk6/NabwPu+jltlSGCrSx+6BSgQanne3hjb2NdR
	44MY4OPV0jkWW3/kU4ZyUoMA83GBC20z5WTYmlJsixXhULTkwETtePhveRUY1Hn9
	Vuz1kZoRmmAzDwVCashfRj9xCqIzUl8+xx6COvbSlPEfKgqOUBOmYdYXz7fw7ee+
	jIX4W9/BUpdM/sXcMWwfVeBcTWA6RfoQTSfl7ismJC7TskSIX0EBVSW7Bedi0PjJ
	EHGdJt9ZIIbJcasN7ezJPDI9pKFTc2p1cdZwHGgc3H+Pug0Tf67VHmd5I1msnQh8
	6MV6Vg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxys71k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 06:01:03 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58J612t4026351
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 06:01:03 GMT
Received: from [10.50.44.58] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.24; Thu, 18 Sep
 2025 23:00:36 -0700
Message-ID: <6e113a14-9321-ecf8-8502-623d2e6e8899@quicinc.com>
Date: Fri, 19 Sep 2025 11:30:33 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 6/9] arm64: dts: qcom: ipq5424: Enable QPIC SPI NAND
 support
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, <broonie@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <konradybcio@kernel.org>, <vkoul@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
CC: <quic_varada@quicinc.com>
References: <20250918094017.3844338-1-quic_mdalam@quicinc.com>
 <20250918094017.3844338-7-quic_mdalam@quicinc.com>
 <905d90fc-eac3-485b-bd8e-98c1e4aff29e@oss.qualcomm.com>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <905d90fc-eac3-485b-bd8e-98c1e4aff29e@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=e50GSbp/ c=1 sm=1 tr=0 ts=68ccf19f cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=fLZ40zuDvd0M7feFtTMA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: roIUYdX7N4CvjWbN26L4pN3roGUNjE2k
X-Proofpoint-ORIG-GUID: roIUYdX7N4CvjWbN26L4pN3roGUNjE2k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXyfshGWQ6E5q+
 HTi3N55kfjTpYT0cEV8CNxpd31hsFsj0eDkujygZz5cX/A1rZnCIDM+uh3+WKmZZI5h5IshIecf
 2KPJeTNnc4BHhfVRbwcyfDVTJCg+8CfnSMKjupBr3SesEFM2vwpg1LBAPh2Sz/lJcOVaCpfx6tm
 p+c9py5MGhyc6mAvGnn6g//WUxRq8NWfQPFiVMy6Eh6dIhjO+uYQk13N4amS85XURaLZ84Ynlae
 hnKahApnz0Cep/7nP288Ql9aYTVdYcB6UhlSxV+YoIkFNsqG3/EJY6ha5i27TuEfBU5RNeQkgNd
 Crr12vp6t3xN0dU10fJG6olAmAWWkRRgA09eXAsxeK3gHuZK4eQxOPPzzmevRik5q2KTiOS00jl
 6LtBXpZ6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_03,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202



On 9/18/2025 6:18 PM, Konrad Dybcio wrote:
> On 9/18/25 11:40 AM, Md Sadre Alam wrote:
>> Enable QPIC SPI NAND flash controller support on the IPQ5424 RDP466
>> reference design platform.
>>
>> The RDP466 board features a SPI NAND flash device connected to the QPIC
>> controller for primary storage. This patch enables the QPIC BAM DMA
>> controller and SPI NAND interface of QPIC, and configures the necessary
>> pin control settings for proper operation.
>>
>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>> ---
> 
> [...]
> 
>> +&qpic_nand {
>> +	pinctrl-0 = <&qpic_snand_default_state>;
>> +	pinctrl-names = "default";
>> +	status = "okay";
> 
> \n before 'status' is customary
Ok
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Konrad

