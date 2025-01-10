Return-Path: <dmaengine+bounces-4105-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C945A0903D
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jan 2025 13:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FD25188C875
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jan 2025 12:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F2D20CCFF;
	Fri, 10 Jan 2025 12:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="M0Ke93HN"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4562920CCE3;
	Fri, 10 Jan 2025 12:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736511821; cv=none; b=GZ3EiVsudQMejv+gNPwLtzvcWfLCvyaGkWqdfuy9zaxE8gss0UDaIdHLOgZZi54rZbqRsqB6KhHKubqvOuCS+2C1KYzBUTQkbPMVYrLQPhHIkJpDulMtMr1N1C5NJsIVwIbwsJN2u8AJ1DGvaTk1BSfWUGtrErRkDmz2e5+/pFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736511821; c=relaxed/simple;
	bh=+FA7H4STrw+JEDIxLQDlnVp2bLisbr9zCZmqMiF0rQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cPegqm4ndw3/026eH5GE2knl4tPBohIZNylh3KY/elIlltdf1EJpItQu89oxAq5fAbUYg9fa7V4x8ki8k/9s1kpkapt+Ls+luU8+nH23hh0TX7Y6gSNnCR4z3BwJMk2hpw+ocuXB+E7BvANXRos4ffWEiQwpmM9E3X2WgPp0eDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=M0Ke93HN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50A97vmG011289;
	Fri, 10 Jan 2025 12:23:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	++EmC/20yf7hwqRN0XwkY0VoGAoG2cpMo+50uiQQXfY=; b=M0Ke93HNQpQaYk+W
	iXZ0j1CzM6kBtWo4DlEJ1fArTdf4uQMcsFmzL3sWtKZTjl42mem7+6O0eAdkUPZ1
	kogIY4yxl70Lg3y4C/6Rhy9w3zfihuKTKUtD/onf1dAfc22hGL47zfugXpcrHVGM
	wpNBcXyXut/BOkK1I0/C5IvHd9aS/s/BurZlSk8n/WIFLWPoiOLvt1DLyAzAYM43
	Hq4iU7sxfVhmECayGfOMiF5pMPIitWL2QwZHscv+OjyGPHrnwn98gBTtLsrhuVCR
	0qSe/kbxTVSPWQQgekLWxWUr51ogEa6FxoYr8XvQ3UAoGro4hPptIXVi9YgRZFZT
	nv0LSA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4430n5ggt8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 12:23:29 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50ACNS0I020463
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 12:23:28 GMT
Received: from [10.151.36.43] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 10 Jan
 2025 04:23:24 -0800
Message-ID: <1964d238-d56a-b9ea-cda8-0b9ff32481cb@quicinc.com>
Date: Fri, 10 Jan 2025 17:53:21 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4] dmaengine: qcom: bam_dma: Avoid writing unavailable
 register
Content-Language: en-US
To: Stephan Gerhold <stephan.gerhold@linaro.org>
CC: <vkoul@kernel.org>, <robin.murphy@arm.com>, <u.kleine-koenig@baylibre.com>,
        <martin.petersen@oracle.com>, <fenghua.yu@intel.com>,
        <av2082000@gmail.com>, <linux-arm-msm@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_mmanikan@quicinc.com>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.com>
References: <20241220094203.3510335-1-quic_mdalam@quicinc.com>
 <Z4D2jQNNW94qGIlv@linaro.org>
 <fb253fa0-7877-e1b8-138a-b9d9a80c81f1@quicinc.com>
 <Z4ENabbDjT8kfpQF@linaro.org>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <Z4ENabbDjT8kfpQF@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3InJ54gMHhgAsy2MbuEsm-8RdCr9pZ6H
X-Proofpoint-ORIG-GUID: 3InJ54gMHhgAsy2MbuEsm-8RdCr9pZ6H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501100096



On 1/10/2025 5:37 PM, Stephan Gerhold wrote:
> On Fri, Jan 10, 2025 at 05:29:29PM +0530, Md Sadre Alam wrote:
>> On 1/10/2025 3:59 PM, Stephan Gerhold wrote:
>>> On Fri, Dec 20, 2024 at 03:12:03PM +0530, Md Sadre Alam wrote:
>>>> Avoid writing unavailable register in BAM-Lite mode.
>>>> BAM_DESC_CNT_TRSHLD register is unavailable in BAM-Lite
>>>> mode. Its only available in BAM-NDP mode. So only write
>>>> this register for clients who is using BAM-NDP.
>>>>
>>>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>>>
>>> What are we actually fixing here? Which platform is affected? Is there a
>>> crash, reset, or incorrect behavior?
>> On SDX75, QPIC use BAM-Lite and as per HW description this
>> BAM_DESC_CNT_TRSHLD register is not available, and writing to this
>> SDX75 was hanging.
>>>
>>> We have had this code for years without reported issues, with both
>>> BAM-NDP and BAM-Lite instances. The register documentation on APQ8016E
>>> documents the BAM_DESC_CNT_TRSHLD register even for the BAM-Lite
>>> instance. There is a comment that it doesn't apply to BAM-Lite, but I
>>> would expect the written value just ends up being ignored in that case.
>> With older xPU it was being ignored but with new xPU its hanging. HW
>> team suggested don't write this register for BAM-Lite mode since its not
>> available.
>>>
> 
> OK, thanks for the explanation.
> 
>>> Also, there is not just BAM-NDP and BAM-Lite, but also plain "BAM". What
>>> about that one? Should we write to BAM_DESC_CNT_TRSHLD?
>> Apart from BAM-Lite this register available in all the BAM
> 
> Please check again if we need to check for additional revision numbers
> for the non-NDP BAM types then. Or alternatively, change the check to
> write the register on if (!BAM-Lite) instead of if (BAM-NDP). That might
> be easier.
Ok Thanks. will check once again this and post in next revision.
> 
> Thanks,
> Stephan

