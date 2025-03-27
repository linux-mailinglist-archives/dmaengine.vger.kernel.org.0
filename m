Return-Path: <dmaengine+bounces-4788-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20419A72E2A
	for <lists+dmaengine@lfdr.de>; Thu, 27 Mar 2025 11:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B62E617965F
	for <lists+dmaengine@lfdr.de>; Thu, 27 Mar 2025 10:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835E820FAA9;
	Thu, 27 Mar 2025 10:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FNnzccvK"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BA1210190;
	Thu, 27 Mar 2025 10:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743072531; cv=none; b=SSmZwbEw/ef/bcxlAGJA46APueRn6zw6AVdiv8eT24aFBJtsgPuD+7OD846Q4Z8vHbEKagpVBbhjwZIGd6E/a2qaInYWY8HeCiqL7uE4nSLjsVwsCbHpb4XlDKD0cX8HAtTTVuvvRvsXCJG0lRA5A+niC/TyPR71GPWcLjha7Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743072531; c=relaxed/simple;
	bh=pvwpsFV0jbmZ6Wyw700IK/2I5NnE3pctABB8Xb1TZCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QZAZD19ceO8U534qkgSwpvJKXT6fE8KW+iitCdKwOxo/knAb50zIEsHU5TLCUtFI9iKqIRwDk8BoyydJoihRqUHIT6dp/eXCW0dbZu3lZK6Vd+xTEf/7P2/mSnUk/zPtkEM5Tdu8Hs+M0X8hmqsCblzKtjJbRmAryi1jOJRsNUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FNnzccvK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52R5jDYV021236;
	Thu, 27 Mar 2025 10:48:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7Sa3Jp59j+nUS0BBJ7tDNKCvGHJtrIiMy92xIjdAp58=; b=FNnzccvKsjR/FWHM
	oVNHkzsem5cY0+Bv10R04JCQi+vWBQZS9YwpHG4VtYJ1Y75ItDwe6ovzR4yz5lJH
	1195XP95UVoe5qdKPIPhYn9wESDbkdwyRkShov6vKb2+gtvjNw/N7C1xMKTJ7XZK
	uoZqPO9qXHErVsT9+IT9Q47N5WnoBsNWVXKf5WJcLWQCHqjZzCbSg+WMlNKDhlW8
	oKpOSrQJu/7qGabcTWK13fnEtuNasHdqNzIFraaoU0+R20lkDvBTVGJI3FnNzrh/
	UmVPbN71v4pSW15eZ0V5S1fCGHQyK8pEyBqm5pysPchLNMt7/7l7KUdk7C9GfVxs
	lRZF6g==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45kyr9p1n7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 10:48:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52RAmc3g032487
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 10:48:38 GMT
Received: from [10.216.8.158] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 27 Mar
 2025 03:48:32 -0700
Message-ID: <26463cdf-f041-0dc3-dae2-cf5a91a35373@quicinc.com>
Date: Thu, 27 Mar 2025 16:18:29 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 4/6] ARM: dts: qcom: sdx75: Add QPIC NAND support
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, <vkoul@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <manivannan.sadhasivam@linaro.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <agross@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>
References: <20250313130918.4238-1-quic_kaushalk@quicinc.com>
 <20250313130918.4238-5-quic_kaushalk@quicinc.com>
 <2fb1ddf6-0fca-4bf6-9970-728448f893d2@oss.qualcomm.com>
From: Kaushal Kumar <quic_kaushalk@quicinc.com>
In-Reply-To: <2fb1ddf6-0fca-4bf6-9970-728448f893d2@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jTS8CBuhR1iTeoq5vhCh9qTtN6uYx0NY
X-Authority-Analysis: v=2.4 cv=UblRSLSN c=1 sm=1 tr=0 ts=67e52d07 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=ZpSJlDRZEPRX5KPLjvEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: jTS8CBuhR1iTeoq5vhCh9qTtN6uYx0NY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_01,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 mlxscore=0 impostorscore=0
 adultscore=0 clxscore=1015 mlxlogscore=726 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503270073



On 3/13/2025 8:06 PM, Konrad Dybcio wrote:
> On 3/13/25 2:09 PM, Kaushal Kumar wrote:
>> Add devicetree node to enable support for QPIC
>> NAND controller on Qualcomm SDX75 platform.
>> Since there is no "aon" clock in SDX75, a dummy
>> clock is provided.
> Alter the bindings not to require it then, instead
>
> [...]
Will update in v2.
>
>>   
>> +		qpic_nand: nand-controller@1cc8000 {
>> +			compatible = "qcom,sdx75-nand", "qcom,sdx55-nand";
>> +			reg = <0x0 0x01cc8000 0x0 0x10000>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			clocks = <&rpmhcc RPMH_QPIC_CLK>,
>> +				 <&nand_clk_dummy>;
>> +			clock-names = "core", "aon";
>> +
>> +			dmas = <&qpic_bam 0>,
>> +			       <&qpic_bam 1>,
>> +			       <&qpic_bam 2>;
>> +			dma-names = "tx", "rx", "cmd";
> Please make dma-names a vertical list, just like dmas
Sure, will update in v2.
>
> Konrad


