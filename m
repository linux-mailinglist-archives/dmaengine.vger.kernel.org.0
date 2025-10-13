Return-Path: <dmaengine+bounces-6812-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83751BD197D
	for <lists+dmaengine@lfdr.de>; Mon, 13 Oct 2025 08:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C94563B3802
	for <lists+dmaengine@lfdr.de>; Mon, 13 Oct 2025 06:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD662E040E;
	Mon, 13 Oct 2025 06:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IOSUmqLL"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BEE2DF13D;
	Mon, 13 Oct 2025 06:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760335879; cv=none; b=ffflGXiK3iSZIWFTnKa9/EfhdN5TgLdzeknFHhay4faJ2ei1RJDdgraI05VlFyorx1JkV/1t7R+yrbRx4NPsXduGiL/tK5ZuylJp/RvdANSYdPbYVUOtod5IgrvAu/whSdWe3z1vt4aGoymVUZIEhlRS9FtlP13LD7wxKcZ0KoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760335879; c=relaxed/simple;
	bh=onl0j6bdyhT9DH9bqjt4WlDV+fWx2qh3hcPmRsTdJI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jpByKk/T5pXcA9fthlop8f24PzlB5Sfn4K1g/1sN2FaHzeEQ80p+2vhzQB539tdJa4d7NNvmw5NNXn0FkXzE6dIkB1V7XSHjrg53rHx3ce8dkkr3TMxDh32QiOAS+XQVxwuPXgDCWYxvrOlln4qpKQ5j/8ixStOY7tWk55e0yIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IOSUmqLL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D2nwOV030097;
	Mon, 13 Oct 2025 06:11:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6f2Kjqvq0ksqPu84UkGwHHIkwRR6OKDutnZzPrjhMNU=; b=IOSUmqLLkeKJxOmA
	TuUlEmNFQokk1wUFZMzpVyO/A7B/LA6afOh4HX0cSGJEETCkpTlC/6hN7YLEDMBj
	OwOc7ox5IL69zHEajE8S8CsSR3MMXU0u4TKMROBNWxtgiP4BnKfNPvJze8YB7bv2
	DWv0M3sU2iNaL2hewU1R0q7+fzmqJ77Blni+GkIkNF397OdHplg/zAPDDIz5NfE3
	08ljrnmgHHlE8h2bGCF4WgkTbsggZAnUZCoPnO5i5Z0xuXrhcAhUQaRWkkdUyXjS
	+uTk8f+9oqRUpMXMMbB5dqUT7DAhf6DxNR4hHIoB0VPkzGyUUJ72G6pV22gXHc2D
	pIgaCA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qff0ke1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Oct 2025 06:11:12 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 59D6BBTw022098
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Oct 2025 06:11:11 GMT
Received: from [10.151.36.184] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.24; Sun, 12 Oct
 2025 23:10:34 -0700
Message-ID: <911ee444-25a9-a645-d14f-72fc239e5eb7@quicinc.com>
Date: Mon, 13 Oct 2025 11:40:22 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 4/9] arm64: dts: qcom: ipq5424: Add QPIC SPI NAND
 controller support
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, <broonie@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <konradybcio@kernel.org>, <vkoul@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
CC: <quic_varada@quicinc.com>
References: <20251008090413.458791-1-quic_mdalam@quicinc.com>
 <20251008090413.458791-5-quic_mdalam@quicinc.com>
 <c7848ee9-dc00-48c1-a9b9-a0650238e3a1@oss.qualcomm.com>
Content-Language: en-US
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <c7848ee9-dc00-48c1-a9b9-a0650238e3a1@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX56iU6SxsKBJI
 VevmlD/xoMeE2UYYrCuJ0LIAIYakd/xqKotB1WFJORttpN5jykJsYV5vttmcDpcF5ZBOEnmBnO6
 Hz0+pq+r5j7YQD6kg/OLP+QvJcB7eL0nIGFxHniWXAvF7yujzOOdu4DzkCa59EF4ziFfBDtAnyC
 leMP/4U/BxqMNUh6DVJ2h5oCWsNbkL+ZUg1tjdMK1XR/ZZSx3PUWsFJd/RsZKUpOL3XHiFC4g9m
 gjLppPoIBn3iG9zJs7yKaUbUiY4vcqlDcnr4xHJoRy8t4r9OKyvu8/5qgkb04WA2XS/pKKSU3t2
 fxJh9LLszIFqsfyvWSvyVL4Xx0gsDrg5eMq4OgtVGFdEwwtB9qGtZENQVOwCzv+oFiPbn6RbApq
 z69uVhQh/yeYRlaOpMRrv7wg1/GksQ==
X-Proofpoint-GUID: ZURUd54dx-qjd1YpqyyPTswHPdJOlCiR
X-Authority-Analysis: v=2.4 cv=PriergM3 c=1 sm=1 tr=0 ts=68ec9800 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8
 a=49Cd_CDO6GkvCW0xFaYA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: ZURUd54dx-qjd1YpqyyPTswHPdJOlCiR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018



On 10/8/2025 6:00 PM, Konrad Dybcio wrote:
> On 10/8/25 11:04 AM, Md Sadre Alam wrote:
>> Add device tree nodes for QPIC SPI NAND flash controller support
>> on IPQ5424 SoC.
>>
>> The IPQ5424 SoC includes a QPIC controller that supports SPI NAND flash
>> devices with hardware ECC capabilities and DMA support through BAM
>> (Bus Access Manager).
>>
>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>> ---
> 
> [...]
> 
>> +		qpic_bam: dma-controller@7984000 {
>> +			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
>> +			reg = <0x0 0x07984000 0x0 0x1c000>;
>> +			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&gcc GCC_QPIC_AHB_CLK>;
>> +			clock-names = "bam_clk";
>> +			#dma-cells = <1>;
>> +			qcom,ee = <0>;
>> +			status = "disabled";
>> +		};
>> +
>> +		qpic_nand: spi@79b0000 {
>> +			compatible = "qcom,ipq5424-snand", "qcom,ipq9574-snand";
>> +			reg = <0x0 0x079b0000 0x0 0x10000>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			clocks = <&gcc GCC_QPIC_CLK>,
>> +				 <&gcc GCC_QPIC_AHB_CLK>,
>> +				 <&gcc GCC_QPIC_IO_MACRO_CLK>;
>> +			clock-names = "core", "aon", "iom";
> 
> 1 a line, please, also below
ok
> 
>> +			dmas = <&qpic_bam 0>,
>> +			       <&qpic_bam 1>,
>> +			       <&qpic_bam 2>;
>> +			dma-names = "tx", "rx", "cmd";
>> +			status = "disabled";
> 
> Is there anything preventing us from enabling both these nodes by
> default on all boards (maybe secure configuration or required
> regulators)?
We can't enable NAND by default in the common DTSI because the GPIOs are 
shared between eMMC and NAND.The decision to enable NAND must be made at 
the board-specific level, depending on the flash type used on that
particular board or RDP.Enabling it globally could lead to conflicts on 
platforms where eMMC is present.

Thanks,
Alam.

