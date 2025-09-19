Return-Path: <dmaengine+bounces-6658-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C53E1B87F3B
	for <lists+dmaengine@lfdr.de>; Fri, 19 Sep 2025 07:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EB335808B9
	for <lists+dmaengine@lfdr.de>; Fri, 19 Sep 2025 05:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F5628488D;
	Fri, 19 Sep 2025 05:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZinNULJY"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220AD2153D2;
	Fri, 19 Sep 2025 05:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758261506; cv=none; b=YHNZe6+BvHbEMo63UxOahl7FtmmsczBgXvsKuJQT/n2JEcfWSoXtiLpI5YCP2jUOmqcp8v9jATC0Oc+5jOjX7sZP0waPYFQTtaT1o9RZj1jZYTYrUZQdfxmBcxgo1f04c/QPOHQCNGQ8tOoP/h6H4nDcQvcjwyg2V4xTjUHTsPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758261506; c=relaxed/simple;
	bh=3JacfOF5n6w44tOIChktkhdrySqZuFs4Zmio87E0RxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kzpJop7iyfKhBAoNLQzvRu4E72Bg+IQC8784pvGUOTa/GSib0zT2mNs/5AK2MrzEceEYsrXZWMwP7PVTIuP8JwTi9gOri5AU5X6bPirEpOok+ydGbfjNk3JruhAiWW0SZ3vZP15cSFhr83my0yRJXX16oy41wMZ9B0SxF3NKh3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZinNULJY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ILmHJX027120;
	Fri, 19 Sep 2025 05:58:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5Z7z3c1VcYxS18wLiborKeuJVzl25GW11t6vVaqHxsU=; b=ZinNULJYABoRrcIj
	Gelze+ehO+1s0/0o9Ksl7sZdX8WruAKlN2EvlBXBY2SZSc9exyj13B2E0PTYF0l3
	LkFjsrNPmXnAnfn9nOlO+W1JQq/a44GYTRNGU17jY2ASvbNnH0QMLLlGohnxHAzt
	3jDQBIgfIZlbWLoBluI5UKpr3NTnPRvcFG9KiCu9qJUIZ7LRVjsNXApZzrXRIxoF
	xyD6cjEA+jHTobyVk5/hhWfzkeKhLOWbEHk9g2rjGJVbtOf8LKi3U9F9mqLEf6c6
	NXwmZI6oDvax/K/P3DhBVeW7PxS1L34nQW9BCJIA1lnS7Z6XANaGMBDV55AudVPM
	kcVvBA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497v1jf6g3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 05:58:09 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58J5w8i3029375
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 05:58:08 GMT
Received: from [10.50.44.58] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.24; Thu, 18 Sep
 2025 22:58:04 -0700
Message-ID: <984ed1c5-6971-0922-3712-ddf401e8f568@quicinc.com>
Date: Fri, 19 Sep 2025 11:28:01 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 8/9] arm64: dts: qcom: ipq5424: Remove eMMC support
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, <broonie@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <konradybcio@kernel.org>, <vkoul@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
CC: <quic_varada@quicinc.com>
References: <20250918094017.3844338-1-quic_mdalam@quicinc.com>
 <20250918094017.3844338-9-quic_mdalam@quicinc.com>
 <3c42a3b0-b8b3-4c37-963a-e9cec2d3d025@oss.qualcomm.com>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <3c42a3b0-b8b3-4c37-963a-e9cec2d3d025@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KvMdk-zDhPOqgKWHyLOKM7t84_v9s484
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDExMCBTYWx0ZWRfX6boss5DiqsE+
 tsaL+Fv3c1hXT6RsMOyZdKReRvTu++JcAwuLUV8QUEaI1QwSP5u86AbUn5TubtQl5Y/QO1RMwtA
 hsX7tWXicGC10ElZ5Lx70tApEQj4rTrnCf3lgenycxhcVoQL5rLuykpp0eaq49fB1Q6tMNnt753
 qr6ds7G48GF4kEp2RwpnwCNZ3TaBiBSXNWF3X3D08KHqe3+2E1ksU+tcDRXCA9paPWzhrfJsn2Z
 a1sBEu8TSwFKTf2P8mvFeep7p4eQCph7S1QFGjkCWWa+QXPfWEy3yk87GLhn4q5QdOEOdCnFApg
 T7PBDMj3B2pZLKDfFa74GMmuwoUCen40y1Xryhfeu44Y55HIzRgf+RSbCh4OAPf00a2FRvyMTeI
 3i015pdW
X-Authority-Analysis: v=2.4 cv=AeqxH2XG c=1 sm=1 tr=0 ts=68ccf0f1 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8
 a=AmzfQV_qY4rmN1R1o4MA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: KvMdk-zDhPOqgKWHyLOKM7t84_v9s484
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_03,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509170110



On 9/18/2025 6:16 PM, Konrad Dybcio wrote:
> On 9/18/25 11:40 AM, Md Sadre Alam wrote:
>> Remove eMMC support from the IPQ5424 RDP466 board configuration to
>> resolve GPIO pin conflicts with SPI NAND interface.
>>
>> The IPQ5424 RDP466 board is designed with NOR + NAND as the default boot
>> mode configuration. The eMMC controller and SPI NAND controller share
>> the same GPIO pins, creating a hardware conflict:
>>
>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>> ---
> 
> The subject should contain the board name, i.e.:
> 
> arm64: dts: qcom: ipq5424-rdp466: xxx
Ok, will add in next revision.
> 
> same for patch 9
ok



