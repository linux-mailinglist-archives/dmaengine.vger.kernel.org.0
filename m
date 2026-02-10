Return-Path: <dmaengine+bounces-8869-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MO1oFSD+imlyPAAAu9opvQ
	(envelope-from <dmaengine+bounces-8869-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 10 Feb 2026 10:45:04 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A281190A0
	for <lists+dmaengine@lfdr.de>; Tue, 10 Feb 2026 10:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B14AD30205EE
	for <lists+dmaengine@lfdr.de>; Tue, 10 Feb 2026 09:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAFC341AAE;
	Tue, 10 Feb 2026 09:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MxXiqzsF"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6A234106D;
	Tue, 10 Feb 2026 09:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770716701; cv=none; b=d3AXlkE6o8jSO4+MYkxhUO5GJ78ehhBPorJgksFJg5GN2fZ4tmTMYe19TWSSIO/KW1wdzFdv9HOBpHG7FWzh5QA4xnUpQeTvafafKCBUFtPzs6+ib2CzgzoQoHXb/pOcbX8BCoB6Aw/Ql0LCKJTvNLcYRZYsTtXATHa9ddjc/IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770716701; c=relaxed/simple;
	bh=U1QrkqJP4kK4VH9sCiWK3UQ3vrzXoR2lGYukSr3g4W0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=isv9KfD9mI6FiCd4R7nSrl4Fd7Gqk7sO840WVfC3PLfnGspnYa+u5JUWIAW1VZ9aIBq+PM5/dSAO/xbNaPQfcVe8JaBvXbT9Og9/vc+WZwb1s4oZOtQbNxjeJUhNx/VjgBzLGGziFYOlhrtYY1Ta7t3GCbAg+CvZORZYJbI0U0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MxXiqzsF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61A6lrxs3436819;
	Tue, 10 Feb 2026 09:44:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tQGKLGWah9W7FaVER4qAVlJswPtgodKSIfn47Es8I3Q=; b=MxXiqzsFlC6qIwHu
	XVgUP39rqGBIfVLZCNqkyum1yNBG8IWDOGhymEn0yMzqAwxFBMZX/f1avLhlUXfB
	8NqqNS0nY0zuFUyK6pM+kUx4cmjjs3B+RULovdUG3p2AyT3BW6rQxAn1+/W4R4vC
	9+xdnioktCZloYNDoj7z/G0x0Riht5Eocsosu95VCHUTe+VFQffIvFWFXOtpv9fB
	5E2g++px/Lo4SaSk9/OLgv/90rACQmpqwDGcfaWTX2GXr3FOW6xvU3xeijVKwVDN
	3bpWhfeLXy5v2mZU2KXgqzTeIQBwOurOJh/vaD+NpL3D4K6mmKcLfljrJkT3vFje
	P4V30Q==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c7fevbug8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Feb 2026 09:44:58 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 61A9ivLj009115
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Feb 2026 09:44:57 GMT
Received: from [10.151.36.184] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Feb
 2026 01:44:53 -0800
Message-ID: <e0556d38-249f-d8ef-ab91-d5dd3a528d5c@quicinc.com>
Date: Tue, 10 Feb 2026 15:14:40 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 1/7] dma: qcom: bam_dma: Fix command element mask field
 for BAM v1.6.0+
To: Krzysztof Kozlowski <krzk@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <vkoul@kernel.org>, <Frank.Li@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>
CC: <quic_varada@quicinc.com>
References: <20260206100202.413834-1-quic_mdalam@quicinc.com>
 <20260206100202.413834-2-quic_mdalam@quicinc.com>
 <409c2e5f-1bf2-44ed-9c0f-df762320e068@kernel.org>
 <153241e9-f71a-970c-c929-53b195807259@quicinc.com>
 <3d3a3b14-e305-439a-b6bd-2339202ad66d@kernel.org>
Content-Language: en-US
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <3d3a3b14-e305-439a-b6bd-2339202ad66d@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Dd447cCDbTSME75oAazetbb5YvxLtxBp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDA4MSBTYWx0ZWRfX6mH9k60HZTc/
 p2t0wABWVlgGa5Z4m0eh8HAMNfsKxNW8CC+EbJ3ILJQe2c3lWvGmMnsCL7dXBOmfPbuADWrxCcU
 rTnRXizEMUZW6p1w4N1lecgnz19PfD7XHNlaU2+NrUVbETDRKpGzK83a/5L+4M1Bkl5WtD/D5k0
 WtR9MoF+S5h4wtaFg/oN/5JDv0joayhasj49VkC4Whgs2/GQBwF92lrVY7i+fXvLW0u+7RU6V6F
 u8Lo4Z/wJhWcqfvfkS0xK6QbKXT7Ggvwfd68Ne4BF2yM9bc3ugIWtlRsIyeOKmBkGQxTC8p8//z
 uj3DVCl3Xv3zRe1uyP6t2cUZe5sdYPTAUcV0kL9weOOk++JcjGXDpyjKlUShBOfZG+6yGdOjnkP
 Wrb8EIKym8AsnQb7LI+19GFV7j9L3TEj4sQWPgTzvU0+X6UJGFwQSJHUakJKlxKQVtTOws8bKGB
 FNXYq4PsiAp5ykQyI9A==
X-Authority-Analysis: v=2.4 cv=F6Rat6hN c=1 sm=1 tr=0 ts=698afe1a cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=Ye0eM1Z4n2nGo6S4sv4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Dd447cCDbTSME75oAazetbb5YvxLtxBp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602100081
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[quicinc.com,none];
	R_DKIM_ALLOW(-0.20)[quicinc.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DKIM_TRACE(0.00)[quicinc.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quic_mdalam@quicinc.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8869-lists,dmaengine=lfdr.de];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C1A281190A0
X-Rspamd-Action: no action

Hi,

On 2/9/2026 5:36 PM, Krzysztof Kozlowski wrote:
> On 09/02/2026 12:43, Md Sadre Alam wrote:
>>>> that use BAM v1.6.0+, because the current code sets mask=0xffffffff
>>>> for all commands. For read commands on newer BAM versions, this results
>>>> in the hardware interpreting the destination address as 0xf_xxxxxxxx
>>>> (invalid high memory) instead of the intended 0x0_xxxxxxxx address.
>>>>
>>>> Fixed this issue by:
>>>> 1. Updating the bam_cmd_element structure documentation to reflect the
>>>>      dual purpose of the mask field
>>>> 2. Modifying bam_prep_ce_le32() to set appropriate mask values based on
>>>>      command type:
>>>>      - For read commands: mask = 0 (32-bit addressing, upper bits = 0)
>>>>      - For write commands: mask = 0xffffffff (traditional write mask)
>>>> 3. Maintaining backward compatibility with older BAM versions
>>>>
>>>> This fix enables proper NAND functionality on IPQ5424 and other platforms
>>>> using BAM v1.6.0+ while preserving compatibility with existing systems.
>>>
>>> Fixes tag? CC-stable?
>>
>> This patch is not fixing an existing commit. This is to address the
>> update in the newer version of the hardware.
> 
> Then "this fix" is misleading. Either you fix or not fix.
You are right — the wording is misleading. I will update the commit 
message in next revision.

Thanks,
Alam.

