Return-Path: <dmaengine+bounces-4784-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1815BA72DB4
	for <lists+dmaengine@lfdr.de>; Thu, 27 Mar 2025 11:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0917D1891EB7
	for <lists+dmaengine@lfdr.de>; Thu, 27 Mar 2025 10:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E4F20E326;
	Thu, 27 Mar 2025 10:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="p60j44pP"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9DD20C032;
	Thu, 27 Mar 2025 10:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743071164; cv=none; b=Vl1xi85QWxqSfkkb9ixIOOBZnXsFrL8PLe45QuTlRunYNLKIcqU6QJ3WIh9s4XsBWfrwOHSD/Y+4t34fp6aYLPR3iuJ9VoI3BrINtwufCJ7wEI8sHLKMcr8Xyl78iQuqvIjFBplND3vdkJbpQzF1ISh7M+GpGbF8ThvFvkJseJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743071164; c=relaxed/simple;
	bh=0tsbp848yXM+K/838IvLLfnAYwT3qLnRDwYA8IihXJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TBxQlOhvdh6uDvZnrZDsAWqgKKUo264sk6swEb4/CvIuDW+lnDczHJO5eLa5YnARW/SWbhV4Kk3pdPrIe2PMQT+YYxQuMkY1vlcJvL9tkezKHoP392kOTQI9OEQhTdkxggGArE7E25cz3GGt7ZtcZixlFJQVUPdOvr4BHk1KydY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=p60j44pP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52R5jFD7024945;
	Thu, 27 Mar 2025 10:25:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0tsbp848yXM+K/838IvLLfnAYwT3qLnRDwYA8IihXJM=; b=p60j44pPfqOa6jw2
	kcSDzZCs14TNVTJx3PYUEvkHI97mrZyhivOuzOPAMcSEK3EmzVbiDuulHIl61gZZ
	nqrgcJqSJ3we7ZSAtuZ4HSkgEsISPi8CQKJDv4wjys6akRMJNmLgtEJ7J793JSx9
	/fEwG0LLblvAnL1QejhVfaqgwyvYKvyZsJ603FZVydVuDdNR9paWrxyBMshCLKBU
	r3a6Ex7u+039vF2kUpg+YvnWCrfPzi4N+ElBuPLnZSyeLGQWN5hbaJayag3IrBnB
	s+fVBC9QBmXpSJXiHRkigaBzCXCBRDAEfgsxmrZAUnHxaUKJhugBjoIBNXDXWPu2
	G5kRpw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45kmd4r6wd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 10:25:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52RAPhnB006720
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 10:25:43 GMT
Received: from [10.216.8.158] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 27 Mar
 2025 03:25:37 -0700
Message-ID: <8abf9cff-4931-bc8e-734d-86a2e2ad6763@quicinc.com>
Date: Thu, 27 Mar 2025 15:55:34 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 5/6] ARM: dts: qcom: sdx75-idp: Enable QPIC BAM support
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
 <20250313130918.4238-6-quic_kaushalk@quicinc.com>
 <d964117a-6e74-42a9-a7fb-c08e3ab84217@oss.qualcomm.com>
From: Kaushal Kumar <quic_kaushalk@quicinc.com>
In-Reply-To: <d964117a-6e74-42a9-a7fb-c08e3ab84217@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: enttYmezz8AKXM2p1X5KcCidk_NYKs9Q
X-Proofpoint-GUID: enttYmezz8AKXM2p1X5KcCidk_NYKs9Q
X-Authority-Analysis: v=2.4 cv=QLZoRhLL c=1 sm=1 tr=0 ts=67e527a8 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=LYm1BIvnotKkRNd3cYoA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_09,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 mlxlogscore=654 mlxscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503270071

On 3/13/2025 8:07 PM, Konrad Dybcio wrote:
> On 3/13/25 2:09 PM, Kaushal Kumar wrote:
>> Enable QPIC BAM devicetree node for Qualcomm SDX75-IDP board.
>>
>> Signed-off-by: Kaushal Kumar <quic_kaushalk@quicinc.com>
>> ---
> There's not reason for this to be a separate commit
Okay, will combine it along with nand enablement in v2.
>
> Konrad


