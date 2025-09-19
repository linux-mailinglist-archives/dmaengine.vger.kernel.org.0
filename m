Return-Path: <dmaengine+bounces-6657-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B36B87F2D
	for <lists+dmaengine@lfdr.de>; Fri, 19 Sep 2025 07:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 523661C8381E
	for <lists+dmaengine@lfdr.de>; Fri, 19 Sep 2025 05:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4B1284686;
	Fri, 19 Sep 2025 05:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="L8bAx6LC"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F67D248F51;
	Fri, 19 Sep 2025 05:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758261440; cv=none; b=e0nN7RNZve8gAMVvg7VRE8q9I80jAB8OB4ViCeQMQ1Oxq/K3tF2ZKBQn4wuxLR0AehXf55YuLf8L/+3ZUjdhvN4zM55/Jy4+xXnO8v/h9fMMEQ/GRKsFc2xWNNpJlRk7chi+PwrJKzz55obtxbenECXKUo2QQpkFBUU6DkWUrSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758261440; c=relaxed/simple;
	bh=3/neqeoz3dR36pzmXn8NzzsA7fMzfe5HS4/BkxssVOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=k//G2eBZB2IAVRQOy+hvTLFhE5YD2OfL6rhkY6XGNozipHkELoWAa/2S6MZAPcV3NJLuAKUPH9pqLo5pXgCEOdrLnj3fIDCDOSfJXscR0BLB3peInXdlmSbLSOEYSvYLuTO3cZcV6WHfxg90zzNMmSOIsTtytHQqoIKlvin97bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=L8bAx6LC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IIV1V9029614;
	Fri, 19 Sep 2025 05:57:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4TwweCMeQcFLfszimtHQ88ugV7vqgQWjFSaEotoMWe8=; b=L8bAx6LCjF5TfmDX
	VlDS03RB1EDCXAh9INq/LEWMvppl/ly+T9nACY0vuuFUl8kB3ywqtLTERnT86pjj
	AuGF0cvD4aMc7XtOOCfdUi5jxzaMOquXyzFc9gLbCJ68GCimC4IyLvnVXoPDEonb
	SQ9+1MvU+GPU0Pz9HEjMtGjMnu9v3dAOqS5zRiAM4vnDxhusQXF5s5VNbuqSGBQ4
	yyyezETvgN2Cz+lI4ugDjN43E3q/AMMKTip4DAyDhU0M3lL/fo9W4EAuPHGRkFWR
	w9fkqv/FeDsD5Uq9XCcJhSbDJfVf9JrNMk3AWXp5/qs8avW5+jBmyWnDc2e+2JNh
	YkMMMw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fy11510-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 05:57:03 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58J5v29a019999
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 05:57:02 GMT
Received: from [10.50.44.58] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.24; Thu, 18 Sep
 2025 22:56:58 -0700
Message-ID: <2394e63f-1df7-764e-5489-3567065707a1@quicinc.com>
Date: Fri, 19 Sep 2025 11:26:55 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 3/9] dma: qcom: bam_dma: Fix command element mask field
 for BAM v1.6.0+
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, <broonie@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <konradybcio@kernel.org>, <vkoul@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
CC: <quic_varada@quicinc.com>
References: <20250918094017.3844338-1-quic_mdalam@quicinc.com>
 <20250918094017.3844338-4-quic_mdalam@quicinc.com>
 <c5d5c026-3240-4828-b9b3-455f057fb041@oss.qualcomm.com>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <c5d5c026-3240-4828-b9b3-455f057fb041@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9-JoQtRTpVI2r9Lokjbnkcuo1rVxbeXP
X-Authority-Analysis: v=2.4 cv=btZMBFai c=1 sm=1 tr=0 ts=68ccf0af cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10
 a=5kgzbmhzmrmLAAh7KT4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 9-JoQtRTpVI2r9Lokjbnkcuo1rVxbeXP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX/mqX81BMEqt0
 Cs5dlwt2twmVv4t+yOqcvpQJW2h0WGhvrwqbB1XdQot8riYhvfansLefqMFKDQS3ycwqIS6wEB7
 bwLKfNguC+f/sPx7teDNXLzz0Aadunq5+tMnrMC5SXb3nJ5gx6OZ822IPyTBpHhTSwOU0m3hST6
 wI3Y/JJ8VSWVvfb0uTHP12W9TL58R0Y+ejwD9ccVozLY1CZe9w/VbciNFx4sbHHoRQfK+2yZxX4
 LbQDIOnSct/IwSl6uQ9+5FCA+fgZggXFXgdo3Gu25BPbWWRJjItP5l9HKSeBxM1Z5nOxSwmjy8/
 BaTFnvNMHEmkdh8R5cQQQ1D/R9C4lQMmdwhQN8AZ1LXIFGWd8pPZhDfF20MF6k5UbXEtx38imj8
 l1/If817
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_03,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202



On 9/18/2025 3:57 PM, Konrad Dybcio wrote:
> On 9/18/25 11:40 AM, Md Sadre Alam wrote:
>> BAM version 1.6.0 and later changed the behavior of the mask field in
>> command elements for read operations. In newer BAM versions, the mask
>> field for read commands contains the upper 4 bits of the destination
>> address to support 36-bit addressing, while for write commands it
>> continues to function as a traditional write mask.
> 
> So the hardware can read from higher addresses but not write to them?
No,
Write Operations: Can target any 32-bit address in the peripheral 
address space (up to 4GB)

Read Operations: Can read from any 32-bit peripheral address and
place the data into 36-bit memory addresses (up to 64GB) starting
from BAM v1.6.0
> 
> Plus, you didn't explain what the mask register does on BAM <1.6.0.
> If it really masks the address, all reads will now point to 0x0
The mask field never masks addresses in any BAM version. Here's the 
complete specification:

BAM Command Element Structure

Write Command Elements (All BAM Versions):

| Field  | Bits  | Description                                         |
|--------|-------|-----------------------------------------------------|
| 1st DW | 31:24 | Command (must be 0 for write)                       |
|        | 23:0  | Address - target address in peripheral              |
|-----------------------------------------------------------------------
| 2nd DW | 31:0  | Data - the data to be written                       |
------------------------------------------------------------------------
| 3rd DW | 31:0  | Mask - 32-bit mask defining which bits to modify    |
-----------------------------------------------------------------------
| 4th DW | 31:0  | Reserved                                            |
------------------------------------------------------------------------

Read Command Elements (BAM < v1.6.0):

| Field  | Bits  | Description                                         |
|--------|-------|-----------------------------------------------------|
| 1st DW | 31:24 | Command (must be 1 for read)                        |
|        | 23:0  | Address - source address in peripheral              |
------------------------------------------------------------------------
| 2nd DW | 31:0  | Destination - memory address to write read-data     |
------------------------------------------------------------------------
| 3rd DW | 31:0  | Reserved (IGNORED by hardware)                      |
------------------------------------------------------------------------
| 4th DW | 31:0  | Reserved                                            |
------------------------------------------------------------------------

Read Command Elements (BAM >= v1.6.0):

| Field  | Bits  | Description                                         |
|--------|-------|-----------------------------------------------------|
| 1st DW | 31:24 | Command (must be 1 for read)                        |
|        | 23:0  | Address - source address in peripheral              |
------------------------------------------------------------------------
| 2nd DW | 31:0  | Destination - 32 LSBs of 36-bit destination addr    |
------------------------------------------------------------------------
| 3rd DW | 31:4  | Reserved                                            |
|        | 3:0   | Destination Address 4 MSBs (bits 35:32)             |
------------------------------------------------------------------------
| 4th DW | 31:0  | Reserved                                            |
------------------------------------------------------------------------

For Read Commands:
- BAM < v1.6.0: 3rd Dword completely ignored by hardware
- BAM >= v1.6.0: 3rd Dword[3:0] contains upper 4 bits of destination
address

Thanks,
Alam.

