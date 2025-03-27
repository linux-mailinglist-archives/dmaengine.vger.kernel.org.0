Return-Path: <dmaengine+bounces-4787-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C42A72E1A
	for <lists+dmaengine@lfdr.de>; Thu, 27 Mar 2025 11:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F2C1189928F
	for <lists+dmaengine@lfdr.de>; Thu, 27 Mar 2025 10:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4641CD214;
	Thu, 27 Mar 2025 10:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="O3DcmHMQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F277E12CDA5;
	Thu, 27 Mar 2025 10:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743072464; cv=none; b=qs8kqSjBb/7oHcdpMtejE6VligNkO3CN1kAugvt5plPYm7jCtFDPKGyY88wng8WB4sUzoiqKNk2Z3g5zNngikz1fux3HPDr7BzQMcaJzVFAcqXAC05aIX0iFhF671sJ5TpCvbZKrqdfNOKZa0VgIPhuj6yaMz3ElCk8Shn3CCwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743072464; c=relaxed/simple;
	bh=DSe/WArHUVbBItJ5HhlDHEYIkWk6EPL3shPB6BEef+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PJUj6ffs0wNehJxJ8Cko0/zfIZqJtV4A6GqBm/h6eMo2XbRA02ajJ9ooh6DQVIMwfiDX23/GNEL3PreAzOjZrKelytUUkUVivdqxjDNG2ubGgqPTRf0NWBOepoNINHyr8ANm7bOuoJDium3IxeH0ggQwf50BdtesruXwGUHgjoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=O3DcmHMQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52R5jG9m022968;
	Thu, 27 Mar 2025 10:47:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Sxvlf+5nKrGkwwwlg1gs9f8lcwxGMIqqFiOQ1d3saZw=; b=O3DcmHMQ6ERR5FyI
	oTgzGSOPdKem9rm5j7d3oHBx2EfFPYHE+ekueTcIPM7AOC8ybHaGyVWZe6pSJUtm
	rtmomoglKBQYLMWM20khMhQHaxE0WI2Im0ENJxLC4WZJyqqK43sD1FO2aF/pCLsf
	EFfStbg3bRmKsPgfipEplhsyJHDV5ZeeA7c/jLs5jfkEXF46UGghxOVdpM+gzHGF
	g2sB5y9r4tiVBwA6+rIPMfuzJtiyyUYhiCP7tsVZpVI9N+9HOOoki11L8sxOTWxD
	x2O+8WqKj1mLiEAuh6YBrKd9EM+f6EL3iwLWsM80Y5WfH9acoOwmC3xyqUmQTMCZ
	fwZwKg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45mb9mvfjq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 10:47:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52RAlV8s030993
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 10:47:31 GMT
Received: from [10.216.8.158] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 27 Mar
 2025 03:47:25 -0700
Message-ID: <3a5d75c1-abb5-fbd4-aa22-cf8f9a8d7349@quicinc.com>
Date: Thu, 27 Mar 2025 16:17:22 +0530
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
To: Krzysztof Kozlowski <krzk@kernel.org>, <vkoul@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <manivannan.sadhasivam@linaro.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <agross@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>
References: <20250313130918.4238-1-quic_kaushalk@quicinc.com>
 <20250313130918.4238-5-quic_kaushalk@quicinc.com>
 <171197fc-05a9-41a2-bd3b-d117a5cb8f63@kernel.org>
From: Kaushal Kumar <quic_kaushalk@quicinc.com>
In-Reply-To: <171197fc-05a9-41a2-bd3b-d117a5cb8f63@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=cs+bk04i c=1 sm=1 tr=0 ts=67e52cc4 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=ZpSJlDRZEPRX5KPLjvEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Uomv3_xzBXZ5jjtk3fi0RuULHmQX01z_
X-Proofpoint-ORIG-GUID: Uomv3_xzBXZ5jjtk3fi0RuULHmQX01z_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_01,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 bulkscore=0 mlxlogscore=846 malwarescore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503270073

On 3/13/2025 8:20 PM, Krzysztof Kozlowski wrote:
> On 13/03/2025 14:09, Kaushal Kumar wrote:
>> Add devicetree node to enable support for QPIC
>> NAND controller on Qualcomm SDX75 platform.
>> Since there is no "aon" clock in SDX75, a dummy
>> clock is provided.
> Add the clock first.
>
> Please wrap code according to the preferred limit expressed in Kernel
> coding style (checkpatch is not a coding style description, but only a
> tool).  However don't wrap blindly (see Kernel coding style).
Sure, will update in v2.
> Best regards,
> Krzysztof


