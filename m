Return-Path: <dmaengine+bounces-4934-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE25CA96223
	for <lists+dmaengine@lfdr.de>; Tue, 22 Apr 2025 10:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E832F7A3C32
	for <lists+dmaengine@lfdr.de>; Tue, 22 Apr 2025 08:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9B0257437;
	Tue, 22 Apr 2025 08:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OJBmLnMz"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786F0256C62;
	Tue, 22 Apr 2025 08:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745310773; cv=none; b=BMNryjnVB4bKGWzixVERFm5JqikIAAITxM/1EFtTSh1mjhCzrg1vilSnN5uQlXrwYGol2E3WmE0jcZZuJlM/ZvJ/rJZxhvymbDFNSAL1BT8pPJzcqN5bw8uvwLZcsP8BcM4McYV1OnfhAl8MwA1d6VI4fSmjQEtMEl00VNRq3EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745310773; c=relaxed/simple;
	bh=Dq5wQrlUTf47COvIKJ6NECUkx4HGTP50OXZKgvmXnIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bMZ0WBI7DOsx0AfYAW7+5XuZnlaBg6WuTI+5HRuX228tlEYyiev20WxvfvbZw5zBLOVWzle7gu+G2dqYAJuxrcetI478BsZjIiq2X+YnacfNEP2BtxTKQg+RX29+3oazGuhEYeXYrK0bOSTNJa+OBZsKg0KHtCOBW7W/jt0tueQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OJBmLnMz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53M4OjGc006443;
	Tue, 22 Apr 2025 08:32:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YYbsaB//72owVvHfmFOaZEketf2iik/PzXc+Wi3iH14=; b=OJBmLnMzEdMhEPeI
	2I3pXD5cUU97Uo34qsuOAB0bCyITrMMUlUh+i4VOrQyijEEjC3oYgClfs0AOriU5
	rVPRCXnE8dOQOTIDdb16UkOyG98VuGpBQxsfGAblwdx1Z/SgfENPchDVtQsHojz+
	oo4vTpPkWAG+5htsapGf+Q3CuaiAJnRvn2g5aMF/swS1bAj7/9texQBtQjpdX6lv
	rsA87QOplUbc9FXW5zQirlwpuOe4ulmVGaNokDM7RXtvnY86jyn2MkGqz6GLuwO6
	k3huLA0vnoj4rCp+Nkncvhv9ckpxIXJCVeMp2a98pKgl0lCl3S92WQiArRrvE0rh
	BPEiYA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 464426pmtx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 08:32:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53M8WVDJ006787
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 08:32:31 GMT
Received: from [10.218.18.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 22 Apr
 2025 01:32:26 -0700
Message-ID: <9ad0d6ec-1391-5c41-24cd-7add0d3b1e08@quicinc.com>
Date: Tue, 22 Apr 2025 14:02:23 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 3/5] arm64: dts: qcom: sdx75: Add QPIC BAM support
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, <vkoul@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <manivannan.sadhasivam@linaro.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <agross@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>
References: <20250415072756.20046-1-quic_kaushalk@quicinc.com>
 <20250415072756.20046-4-quic_kaushalk@quicinc.com>
 <68a48388-f42b-4136-a97f-9d575fb84d42@oss.qualcomm.com>
Content-Language: en-US
From: Kaushal Kumar <quic_kaushalk@quicinc.com>
In-Reply-To: <68a48388-f42b-4136-a97f-9d575fb84d42@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rHOX6qJnXPjGnITH3nhT2nOPxGeo3gMW
X-Proofpoint-GUID: rHOX6qJnXPjGnITH3nhT2nOPxGeo3gMW
X-Authority-Analysis: v=2.4 cv=IP8CChvG c=1 sm=1 tr=0 ts=68075420 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=mRvqLfeVl_ZLl3yoDasA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_04,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=919 spamscore=0
 mlxscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504220064

On 4/15/2025 3:20 PM, Konrad Dybcio wrote:
> On 4/15/25 9:27 AM, Kaushal Kumar wrote:
>> Add devicetree node to enable support for QPIC BAM DMA controller on
>> Qualcomm SDX75 platform.
>>
>> Signed-off-by: Kaushal Kumar <quic_kaushalk@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sdx75.dtsi | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdx75.dtsi b/arch/arm64/boot/dts/qcom/sdx75.dtsi
>> index b0a8a0fe5f39..e3a0ee661c4a 100644
>> --- a/arch/arm64/boot/dts/qcom/sdx75.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdx75.dtsi
>> @@ -880,6 +880,20 @@
>>   			qcom,bcm-voters = <&apps_bcm_voter>;
>>   		};
>>   
>> +		qpic_bam: dma-controller@1c9c000 {
>> +			compatible = "qcom,bam-v1.7.0";
> v1.7.4, looks good otherwise
Ack. v1.7.4 is backward compatible with v1.7.0 supported by the driver. 
I will update this in next patch version.
> Konrad
- Kaushal

