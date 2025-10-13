Return-Path: <dmaengine+bounces-6813-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF878BD1994
	for <lists+dmaengine@lfdr.de>; Mon, 13 Oct 2025 08:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FFE63B914B
	for <lists+dmaengine@lfdr.de>; Mon, 13 Oct 2025 06:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B50F2E03F0;
	Mon, 13 Oct 2025 06:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="f5eOkJF5"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC4E2DEA76;
	Mon, 13 Oct 2025 06:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760335889; cv=none; b=ko4VimK4ypeoz/Q/CXY6g4GLQsFYtL+vezi+RxXsOU30vn29LN3yTTm+LW255LP2I67t27i7iyc7DLk0I4hkLzkZUmBVUQK1gUogjoNi8ImgERBZFfg1g3b0x3qCH/akOQVcCpEmNumDo6ljttDmO4ywP/IahkmST5SrAOty4LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760335889; c=relaxed/simple;
	bh=sgpCfe0V5fq7f1A8ON3pnj5XuZbDff/GSr6JpvC7NWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Sp7pvDBRozr14lTYhujIrXNyfvks931cj4ggSvQGkZH+3wjeDvL7Qmdl1QGaWzQsDyT+qE+uDVBttb9ZRzXrFpFgevNuNpbj9LUiyTNCq8M+RR80fq5wgxNFBGBPzJm+kh4zyF38uX+RGFdOw1UOGP9gkodHN6ZUm34ru+OcksM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=f5eOkJF5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D2nEhc021460;
	Mon, 13 Oct 2025 06:11:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/fsR+d5txtgtYkVQqanz+XrplLhlEmNO3J/Hqo80CzU=; b=f5eOkJF5nVVH9SmB
	+Es8Sd2qlvkEW7xth3REbZ0/KaALeuELiicc8O2srU9t+TI3KK/AKfx05Mm9DfN4
	rWKJEcAdJ0MvYri0mTfaoR8MepYgpxxDMmwMlO7REqILDacEvpviQ0+u2hA8SEVw
	rUTe7vQz4BJkTIoise7Osn+Xkwbb2OZ+T59OepDKvJaFL3pGf6txj8oKfwgXq47o
	VB5xKbVLLsZkpe99ZGUmVK9gkBBc5jdiPzTp79sCmIwselHtKI1mKdJHcD1LdcUW
	8BpPUCGpFHJ0LIJKahMsBo28CNbNW9N8B0W23lT3nHPXsV/9veNYvk7eQUO59VkI
	ht1GLw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qgh63buh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Oct 2025 06:11:25 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 59D6BO4B018269
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Oct 2025 06:11:24 GMT
Received: from [10.151.36.184] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.24; Sun, 12 Oct
 2025 23:11:20 -0700
Message-ID: <7f6d43d6-23db-4d45-e415-3ceabc29b153@quicinc.com>
Date: Mon, 13 Oct 2025 11:41:17 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 7/9] arm64: dts: qcom: ipq5332: Enable QPIC SPI NAND
 support
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, <broonie@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <konradybcio@kernel.org>, <vkoul@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
CC: <quic_varada@quicinc.com>
References: <20251008090413.458791-1-quic_mdalam@quicinc.com>
 <20251008090413.458791-8-quic_mdalam@quicinc.com>
 <24544f3e-f9c3-4650-a300-a786ef589be5@oss.qualcomm.com>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <24544f3e-f9c3-4650-a300-a786ef589be5@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=H/zWAuYi c=1 sm=1 tr=0 ts=68ec980d cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=2G22UYAmLJHXtYKdKZUA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyNiBTYWx0ZWRfX0ncjZAvgo/Ql
 O56OEaPOPB03PJdFSp/LVucJMKQxYAWZ1syL4xVrcyHwcxfFF4BLOFa7OxyvJ7T7Rn5ByA/VU+1
 NARxTfhkOzsY1a/LSsTLrXPUrF5SFt6o8iQlALJPTNCzz1LVwC3bslwr1e4KNq0VtdXrOEYvx4w
 UP/OCaH1yIo1gan5PJ79joZFh+0TuBcJkzuMHrvxNltVRMPjmGLDbTVGZNWyCFdAa3+VKE5jfYQ
 V3z8i02ig7s6REG1Qhqh5cbCztkewVTnh+CLE3CxngQApu4Ekfzn2LcceD27xTjJxgVEMWGJK4Y
 3YnHPqiBJbdxOumsBphUnzn0aLHkogRLh5eGa+pvJJwaL6yZn9geAKwCZn12lrjBBXbtKduvwPd
 8P2Ms+RB2Xhc5MXFt0+XLb0gqKohlg==
X-Proofpoint-ORIG-GUID: 0_84JkVSnht8c5R1-wrkvtSzH-dl1Dy1
X-Proofpoint-GUID: 0_84JkVSnht8c5R1-wrkvtSzH-dl1Dy1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110026



On 10/8/2025 6:03 PM, Konrad Dybcio wrote:
> On 10/8/25 11:04 AM, Md Sadre Alam wrote:
>> Enable QPIC SPI NAND flash controller support on the IPQ5332 reference
>> design platform.
>>
>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>> ---
> 
> subject: ipq5332 -> ipq5332-rdp-common:
Ok
> 
> with that:
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Konrad

