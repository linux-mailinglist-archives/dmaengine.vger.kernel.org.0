Return-Path: <dmaengine+bounces-6930-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF96BFCD90
	for <lists+dmaengine@lfdr.de>; Wed, 22 Oct 2025 17:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53D083A95EE
	for <lists+dmaengine@lfdr.de>; Wed, 22 Oct 2025 15:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCF334D4E2;
	Wed, 22 Oct 2025 15:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kUYGrGyn"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C75334B43C;
	Wed, 22 Oct 2025 15:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761146473; cv=none; b=oxvb5I0+YNk0vhjaEYG42QB1TzOPIO+CcITjjJHIchZa7n9p2x4fpDe2v3OOKxMRPzElLelVsCXqRnK9NVGnnXUCiif4B7qeD17Sd3+GutLaWPPuBuS5QELatUWIP1EGmJw4K2OsjNlZFUQQ+vFft7NZ5nwvx1+egKN1/VDZH60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761146473; c=relaxed/simple;
	bh=lvDvz0bgj3CT/1F2bST8lcX8d0GKbIb+N8vIljgy0Kk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fvx6wOC8k8ybSuvyVoCunB/zIpyU61aGoeQvlOzd1JQH/Cra4FyqV/tsTrSgdNFsUHldzW1+GAwg3SO/iOg48J5pzz00RPJFxuds2qZE1iPH0bRKkm5Mbkhg0/ABLlkaL/SvQ8JMRFqrtR6U4IGqH7F7h6kXogKKJUuyIVmsEIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kUYGrGyn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MALVZK026903;
	Wed, 22 Oct 2025 15:21:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V0duspwE+cwcMAc6jB2d8+uPRGFige4d0MtKepNDCE0=; b=kUYGrGyn/9Cym+Pa
	8sL7cQm0wyZZhdftvydfQnF7G1bBA1oZqoKfHJmETGFupHxEh7WyODn/0jl5Bv2M
	DE+F47YgfDiJnLHSY69Ucl6ILzxk6IpRP7k7yj66/3ZtcDXpbkp25JAvuIGmxx/E
	bHDz22f7oarxUeliA7F4+5H2bowrq2D/mX+L+INzyQ9j7/0IZCes6qPtkB+KDOkH
	nadUsy+rZVi7dNkwiReRBMUxjIDbIWnr887L/VN1dZeWPLysmgoZIhkL49JEmS9p
	o2iW5yGiM0fJCZsd/xPN76INCbNPxaYy+uihKvPAA8xG5CyArpBQpLQPziWv2bic
	XCfIvw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v08pnca0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 15:21:07 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 59MFL6O0018299
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 15:21:06 GMT
Received: from [10.50.62.229] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.24; Wed, 22 Oct
 2025 08:20:55 -0700
Message-ID: <49eb9f15-fad9-4f8d-1463-04cd692bbe51@quicinc.com>
Date: Wed, 22 Oct 2025 20:50:52 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 1/9] spi: dt-bindings: spi-qpic-snand: Add IPQ5424
 compatible
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
CC: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <konradybcio@kernel.org>, <vkoul@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <quic_varada@quicinc.com>
References: <20251014110534.480518-1-quic_mdalam@quicinc.com>
 <20251014110534.480518-2-quic_mdalam@quicinc.com>
 <dd1e4289-5e36-4b24-9afd-f09569459a96@sirena.org.uk>
 <96ae7d38-4ce0-fa34-e6f0-6bb6e4ceaa28@quicinc.com>
 <0a743099-face-4cc1-91ef-098a748604b7@sirena.org.uk>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <0a743099-face-4cc1-91ef-098a748604b7@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAwMCBTYWx0ZWRfX3fndvC2z4Jf2
 EMIKM/io4lOkH1z7jtlUJLdhHV6A9s4s+23qa38dBWYwoIFgdLUS47JoSwyw47Q6hAjlEvVvr8R
 LGXG5QFEZseZ5rFB73I7Yky0srf5RDnckuCuGAdjEg7f+hkx619vsRk8ld5s4nxvx0CgRh58uhF
 MFP6VL1LB3x4Ote9I0owdwakqZNcDycY2fijJaX+DJlQTgOYiPXCDYnex1o72C2+MD6xhTWEdjh
 2r8uaqfskyjkW4iFcfd6ZV1uu/qHbym5szMpyG0rMDL2ergD4tbJxetlduOSvKd58D+cReboraU
 pnEppnLb68o3HNnYdidilkjFO/67usf38H/cS+F9fCzNk01gjyHqmOGdyYM/C1n6TyfvxOWN26r
 iumUH/7gD5F5LVUa8seg1ZYo0z/iDg==
X-Proofpoint-GUID: 65YCwVdkDve8ZPZzVJjBx15qYWOPZiEX
X-Authority-Analysis: v=2.4 cv=Up1u9uwB c=1 sm=1 tr=0 ts=68f8f663 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=BAz0yG0TH0QP3-mkIuYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=HhbK4dLum7pmb74im6QT:22
 a=cPQSjfK2_nFv0Q5t_7PE:22 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-ORIG-GUID: 65YCwVdkDve8ZPZzVJjBx15qYWOPZiEX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180000

Hi,

On 10/22/2025 4:12 PM, Mark Brown wrote:
> On Wed, Oct 22, 2025 at 12:29:01PM +0530, Md Sadre Alam wrote:
>> On 10/22/2025 12:39 AM, Mark Brown wrote:
>>> On Tue, Oct 14, 2025 at 04:35:26PM +0530, Md Sadre Alam wrote:
>>>> IPQ5424 contains the QPIC-SPI-NAND flash controller which is the same as
>>>> the one found in IPQ9574. So let's document the IPQ5424 compatible and
>>>> use IPQ9574 as the fallback.
> 
>>> This doesn't apply against current code, please check and resend.
> 
>> Thank you for the feedback. I’d appreciate a bit more clarity on what
>> “doesn't apply against current code” refers to in this context. I’ve
>> manually applied the patch against the latest mainline (torvalds/linux) and
>> it applied cleanly without any conflicts. Please let me know if there’s a
>> specific tree or integration point I should be checking against.
> 
> I tried to apply it to the spi tree
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-6.19
Thanks for letting me know — I’ll rebase the patch on the SPI tree 
(for-6.19) and resend it.

Thanks,
Alam.

