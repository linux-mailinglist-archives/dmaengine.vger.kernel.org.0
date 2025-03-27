Return-Path: <dmaengine+bounces-4783-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42802A72DB0
	for <lists+dmaengine@lfdr.de>; Thu, 27 Mar 2025 11:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DD9316600C
	for <lists+dmaengine@lfdr.de>; Thu, 27 Mar 2025 10:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6163520E335;
	Thu, 27 Mar 2025 10:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gK1Mv0V0"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C958512CDA5;
	Thu, 27 Mar 2025 10:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743071017; cv=none; b=c3zKOvPPf8x+AutV0h1TbaBzQxMZsKD4yFOmMIWtkUwnmvFEAeCCSMLxkutS8332Ino3fzwZl7NuBfh4bZ6kyiiekB/p4Pf6PkgJss2Ejabm6fs1T1T/ohAoTsP+MJRXz+HqajyibAibfbZaR5ZDb8QhT7dxOACzqPwjY1Q2PYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743071017; c=relaxed/simple;
	bh=2UndzPazQMam1TFU2Z662vdNPVB0UawlwBr1oa36seU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=B+DoyHGw9iGgHh6mnGI+K3CExIa6Flia2NWPxfzhOt0izMWCWXfgysM6ZAIb/2c9masMph1T3tnYSknJXX60eCtCVIt5/hxaGWdmWDSJct3RCfdE5YjUbr7J+Go3cPCaz2V6HsiifAM04A91ySfKtAyKFzr8TEXvRih1XnkBY7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gK1Mv0V0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52R5jaAF022550;
	Thu, 27 Mar 2025 10:23:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bsTKJixskJXIih+9YG2BOGi/3JloTiztSwmkSNf1BgQ=; b=gK1Mv0V0e8Ordy3B
	vQvtG46sYChLOgelNC6ohYOvTl8JrZZGvZQv2i1v41M6H4pwRI4kSAPXi1JFQh8M
	Y4S3VZeBRUjpKC8n3cE+TGkcUgI9upZ/Il4TJhbo3Po1dukpAp/umCNFGemy0lDW
	7EORcilLUDDi5dqGp2hV7NR99sOpD4xA+dJVGaDygBRnizW0QpBzHNBaZaSvUlRn
	S9EDYl253eeqTGeZQDmPMUzCZAfhoCZTrnMmY9nvdFYTHH/zd+ZJhuUfjySu/hRG
	iYz9WazvIaO80HFukHMeh+SLa/fho6JzCxkG5TKTqaYBKfKtyvjqTlJFXyDZYagm
	5Uwolw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45kyr9ny4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 10:23:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52RANFTj001048
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 10:23:15 GMT
Received: from [10.216.8.158] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 27 Mar
 2025 03:23:09 -0700
Message-ID: <5a1b52a3-962b-04f9-cdfc-4e38983610b5@quicinc.com>
Date: Thu, 27 Mar 2025 15:53:06 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 0/6] Enable QPIC BAM and QPIC NAND support for SDX75
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, <vkoul@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <manivannan.sadhasivam@linaro.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <agross@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>
References: <20250313130918.4238-1-quic_kaushalk@quicinc.com>
 <07957f72-ce7e-41f7-8ea8-5839a33f04a3@oss.qualcomm.com>
Content-Language: en-US
From: Kaushal Kumar <quic_kaushalk@quicinc.com>
In-Reply-To: <07957f72-ce7e-41f7-8ea8-5839a33f04a3@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: AUlJKAFe8WUGVUucIJ9OGSKGYZ_s609B
X-Authority-Analysis: v=2.4 cv=UblRSLSN c=1 sm=1 tr=0 ts=67e52714 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=MOhVsGqXc9mDfs5IvFQA:9
 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: AUlJKAFe8WUGVUucIJ9OGSKGYZ_s609B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_09,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 mlxscore=0 impostorscore=0
 adultscore=0 clxscore=1015 mlxlogscore=611 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503270070

On 3/13/2025 8:00 PM, Konrad Dybcio wrote:
> On 3/13/25 2:09 PM, Kaushal Kumar wrote:
>> Hello,
>>
>> This series adds and enables devicetree nodes for QPIC BAM
>> and QPIC NAND for Qualcomm SDX75 platform.
>>
>> This patch series depends on the below patches:
>> https://lore.kernel.org/linux-spi/20250310120906.1577292-5-quic_mdalam@quicinc.com/T/
>>
>> Kaushal Kumar (6):
>>    dt-bindings: mtd: qcom,nandc: Document the SDX75 NAND
>>    dt-bindings: dma: qcom,bam: Document dma-coherent property
>>    ARM: dts: qcom: sdx75: Add QPIC BAM support
>>    ARM: dts: qcom: sdx75: Add QPIC NAND support
>>    ARM: dts: qcom: sdx75-idp: Enable QPIC BAM support
>>    ARM: dts: qcom: sdx75-idp: Enable QPIC NAND support
> subjects: sdx75 is arm64 and the prefix in that dir is:
>
> arm64: dts: qcom: <soc/board>: foo
Agree, will update in v2.
>
> Konrad


