Return-Path: <dmaengine+bounces-4158-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB80DA166A0
	for <lists+dmaengine@lfdr.de>; Mon, 20 Jan 2025 07:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 739351884972
	for <lists+dmaengine@lfdr.de>; Mon, 20 Jan 2025 06:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D912717E473;
	Mon, 20 Jan 2025 06:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="A06Ewo+l"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F6D383;
	Mon, 20 Jan 2025 06:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737354339; cv=none; b=XedXzPT69abTHE6v8VQ5tr84NpYOs57R90qLQmoacoqznoMOBUmREu67T29Uu0Tm+/6FGUqld/djtUkQmct/uh4T8kvmIUqhDmlTd3szEzQYyCn59vO90AF/8cik4QgqC/G2KL1MYzhTlHNTBOgEN36m+ZEbRfoSoD0vgcAyg1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737354339; c=relaxed/simple;
	bh=rJFlrfwGbb/7vwCKeF4n66b/v2uZU1UzB+GL4xwBAS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FJ1E5Et9FEbjeD6G+yrmtspbm6pjC7kmQlNYhnHV6ZXxJxoyR/Gi84pRxGATlQ2Eyd41IAbFhwA76jOu8kKTcmqypZ5TpQRlcwFmTz4idsTOOiLAuld8VHcwZzA3fDmRRP0PsZ6wvN9CwTK7BYYDhdvXyPFHL+Xx+Fc8Z3QppSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=A06Ewo+l; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50K14nr0032113;
	Mon, 20 Jan 2025 06:25:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FSyyUwTcGgOtCTfawzw+mMK3adGrxXO0pu6inyX0abM=; b=A06Ewo+lLUhADd90
	fJMd3PY85KfX+nVkqQbADefhfHUSlVfKiqPNJrhuDS9CfVpGJEbb/wxE9c9g6xsj
	a3pod78Y5wG8CFe4y3ohSArm4OdcRaMp9dz1fCRCdW2HkWHnpd/V1ibN0ZvLDB8m
	t+TBOjXwlD6Z7OTz5kwk/IRlfOeQ41/V2GzWZjYi6IcWG7CpHjiYx/1u05s+h6LA
	T1ULtEpjw62U3lsH4JC3o6H9dVg0piaAGfPsqY2dLOjaU0w1guoiwEahw9x6Unnm
	krTtMGMV03DJMT/GviWkTtiybkuQdHQ3aPSHQxoR/1obaPGvIdszFFob6TgyuYJT
	IFEbQg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 449cgr0hkt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 06:25:32 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50K6PVrH026799
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 06:25:31 GMT
Received: from [10.151.36.43] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 19 Jan
 2025 22:25:28 -0800
Message-ID: <211df2ed-0e01-ccb5-ca3d-1d021361ea5e@quicinc.com>
Date: Mon, 20 Jan 2025 11:55:25 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] dmaengine: qcom: bam_dma: Fix BAM_RIVISON register
 handling
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: <vkoul@kernel.org>, <robin.murphy@arm.com>,
        <linux-arm-msm@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_varada@quicinc.com>,
        <quic_srichara@quicinc.com>
References: <20250117111302.2073993-1-quic_mdalam@quicinc.com>
 <20250119054105.rhsathhdqapirszh@thinkpad>
Content-Language: en-US
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <20250119054105.rhsathhdqapirszh@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: kx4rTRJd2_D6fLluSWwzFCzvl5voKQrH
X-Proofpoint-GUID: kx4rTRJd2_D6fLluSWwzFCzvl5voKQrH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-20_01,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=912 adultscore=0 mlxscore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501200051



On 1/19/2025 11:11 AM, Manivannan Sadhasivam wrote:
> On Fri, Jan 17, 2025 at 04:43:02PM +0530, Md Sadre Alam wrote:
>> This patch resolves a bug from the previous commit where the
>> BAM_DESC_CNT_TRSHLD register was conditionally written based on BAM-NDP
>> mode. It also fixes an issue where reading the BAM_REVISION register
> 
> The 'also' sounds like the patch is fixing 2 issues, but it is just fixing one.
Will update the commit message in next revision.
> 
>> would hang if num-ees was not zero, which occurs when the SoCs power on
>> BAM remotely. The BAM_REVISION register read has been moved to inside if
>> condition.
>>
>> Cc: stable@vger.kernel.org
> 
> The offending commit is just in the -next branch. So CCing stable is pointless.
Ok, will remove in next revision.
> 
> - Mani
> 

