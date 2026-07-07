Return-Path: <dmaengine+bounces-12067-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 76jFJLgDTWoNtgEAu9opvQ
	(envelope-from <dmaengine+bounces-12067-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 07 Jul 2026 15:48:40 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FA371C1C1
	for <lists+dmaengine@lfdr.de>; Tue, 07 Jul 2026 15:48:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=AzIN4Bpq;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=dpEGI2cK;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12067-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12067-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 831CD309280C
	for <lists+dmaengine@lfdr.de>; Tue,  7 Jul 2026 13:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BEB41F7C3;
	Tue,  7 Jul 2026 13:43:53 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E9341DEC9
	for <dmaengine@vger.kernel.org>; Tue,  7 Jul 2026 13:43:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783431833; cv=none; b=IChSxWJsiQfHaC5YtNcAYcg7D7UUyxKSmCtim+sED3bKCE2luCtg6zUVzho+BKEwwSYo9v6zUzqIPKZB9H/4vY66/FaLSI1fpsIcX8IyKFcAuh3FRYiRpuSDNUbGwxPbBOyF3Fqg5R2Iv6JlQT1cfuxtUXlc3ozhT/EiwGDPpIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783431833; c=relaxed/simple;
	bh=ohClIIl9VS++4F9zDo7Gf4dQCPR5WJwNWE8dI8K11BI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MLkfpMZlLW5xpFMxgK7GcNxvkIl/6rAmckYvKnS/IbzP0HmW59E2rYlXSNi+HbzlhqJldFtr8njisdE+3kegVdYGbWcRcD909MC/Imu7+BEHDkzTw7uIAEqVp6/os5T4uYyZcwE15WvqUIIyt5jhs/RG7b2N1xoMMx43LGP/lbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AzIN4Bpq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dpEGI2cK; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 667C93uf3590157
	for <dmaengine@vger.kernel.org>; Tue, 7 Jul 2026 13:43:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HKulkMLDTrRpC8myoqrXcMTbvHZ0aB99k0psGH/8hpc=; b=AzIN4BpqXJYD0OO+
	ChYs4OOtOmzmeawMdGATZz+5jqfiozRMXqWZdqM0G/BQHWqG3BVnkbnNTB/+OpXh
	0RqkmfihqI66tKc2AKagsHi4yby14/wh6NRtP10rCeqxTV0kQMlHezy2U+CPHzU4
	Iw83HyP/UkU3vNU2pkLi7w3DKi/lpfi3VhI52tWAx/dmdLi9izGIBNLznnuMZWn4
	QsukiYNp4NF2OJ8nIgVE3wz7+KtGr+Nf6MI9IYB2RXtYnckmEDerJQ+SsCMNtpSB
	qbvb1K8SdOlUA9yUa/qk53Zaq+CX9yXkQ0SlbU6akdZl8XB+2u8J4pHEn9M/fXwz
	1Oil1A==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8w2u9fgr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Tue, 07 Jul 2026 13:43:50 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cc73f47bdcso57668915ad.3
        for <dmaengine@vger.kernel.org>; Tue, 07 Jul 2026 06:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783431830; x=1784036630; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HKulkMLDTrRpC8myoqrXcMTbvHZ0aB99k0psGH/8hpc=;
        b=dpEGI2cKzBDHHWXChRbmJSIpu4N6VEvND2mIBVvBnpKG6qKe8aCnAtHeYbipydx4Vd
         ASbVhHr+8Fcf6M8nmgLc6FccKUl1DfqmMZqr1FP63wFrQB3I0aLZfHknK2tJzUZAa0R4
         FMvzz+8ubcEqOxKcmBSfKUVY7Sy68eW05AW+tTD+jeBgGF8xOhbMzjhpJvyDfp75wO7+
         sskyAmgD8w1/kjKMm2CcLO6O8nFTuqMjPz7iVA/A2ywad9RbDTTmowVBnsOYMU2WKuXQ
         QVlxNhodrNsKsWbTR9GlgVyNsHIUqGAXD+pBHbWPE5Ji2/Be7xCFoO7PWgwb4Y7smFMo
         1Vlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783431830; x=1784036630;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HKulkMLDTrRpC8myoqrXcMTbvHZ0aB99k0psGH/8hpc=;
        b=aAxyk4e/le54buyCOsXTkfUqr1lMowmwsaPR8pSuZ0zzDcANebgX8b17E/GcT9xaVU
         rI4KAfsBhROnVs5VygzPrXqiJJEd6XmHvB9aGJ5boBp8KTCgwKocc98sCBM2Uh3AcuCO
         abzshQ/OgTXf//7iac/SRg9EL0wMwDIF6LI2kq0zUQ82cAqo8CHCSa/h/5wHDeVoGcWT
         RiUyOiKinDbdYtTCmZRIDF/sTYVJ2YORb0ae7EMM4LK+ROocihwJn4IWWJZcCD7KczuA
         WZIyfazIqznyHDG0JAat+AnUUfL5ixFOA8CCZ+WPJTmRRnn5eLavbx4fFw+9Or5WqxSp
         U1wA==
X-Forwarded-Encrypted: i=1; AHgh+RprB5pNcddpeebok2oiQHFVNMWyXDMk/uYEeZN29SYNh8TOomRKgCq+BmARULfJpGOHjrVCIxOL8kM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWzj1t9Ho7zuYHhQhVE+r6ZLIFWpeBM769pmdIPPItcPqXECRX
	IKPWGVzyTiiRQYyXNuU2lotbpTGQV9OkAsLgWR6HJKxjl8WH/2DUiSxwXDSFjKesR12EyvxijfH
	wcJAwTRIbufe618m1zb51rxZlAmJEpd/zigeIk40Ro7w8jMkS1ne9h4n5zBpo5AE=
X-Gm-Gg: AfdE7cmsK+vgN+axO26ycr/9hnOgRv+/GNeECEBGPkn22dCLdcJDAx7uSatp9RE6gbq
	nfPmxV3WUqWEidbE7HalbeYk96+ptF/fXxMItuqhflDAdsSKht68//ki3cykvtry3gK3w/S/XUi
	v6+VwTXtrBMZKLfFhseFZqqEWC2eidNYYt8oPQlZlcJWi4PC62Yaw/VYJ/bZ9oxE60XiJJ0R2G3
	LfwZgpzjKfuJw13u/V21D2awJMiTvTuJ2Aqw6CDMJKbkmiskp7H/w/FBpPMpqmbjvSz0DVxcx+c
	AlCkKTuK1f9mFeYb9q/gYQr7QH4BzWFVVunBiNEkHmw5vCBw5G6zSui+PecRaM/o5Cneaf+wuHH
	NxhQhB1fQXd9NzXtuh1A2TbryKh6k6N8bFGeC4NM=
X-Received: by 2002:a17:902:f645:b0:2ca:9d5a:8b6c with SMTP id d9443c01a7336-2ccbe3fcc82mr53604435ad.5.1783431829960;
        Tue, 07 Jul 2026 06:43:49 -0700 (PDT)
X-Received: by 2002:a17:902:f645:b0:2ca:9d5a:8b6c with SMTP id d9443c01a7336-2ccbe3fcc82mr53603855ad.5.1783431829373;
        Tue, 07 Jul 2026 06:43:49 -0700 (PDT)
Received: from [10.219.57.117] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb75fsm12457695ad.8.2026.07.07.06.43.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 06:43:48 -0700 (PDT)
Message-ID: <1bbe5560-3a65-41d0-8aec-4d07bc8d05bd@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 19:13:42 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/11] arm64: dts: qcom: shikra: Enable Bluetooth and
 WiFi on EVK boards
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
References: <20260702-shikra-dt-m1-v5-0-f911ac92720c@oss.qualcomm.com>
 <20260702-shikra-dt-m1-v5-10-f911ac92720c@oss.qualcomm.com>
 <zjvb6i3rahc2kwojxrg4cwaqtddcho2nj3sfcr63xkkrm7tdd2@2yl6rxb7rtcb>
Content-Language: en-US
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
In-Reply-To: <zjvb6i3rahc2kwojxrg4cwaqtddcho2nj3sfcr63xkkrm7tdd2@2yl6rxb7rtcb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEzMyBTYWx0ZWRfX7HZ30MQHRlNk
 MGqqgYYBj/szcQA54feFpVEXVlQCh0znukkqn9+YWbkYvUG8TZYu3D1AQjNOwSq1vO7wlG/SutU
 v+gwKLn9mgoxQcB6nr4Qirurhq5Gemk=
X-Proofpoint-GUID: 9iOUOG4y9f2s6ZcjpLsvDQ_8ChGyowhK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEzMyBTYWx0ZWRfX+a7dZ5rXsYZ4
 WS7eF4cBjl3FhCJ5YVz4nQ3t0RxHoIlsdzIKgfCNgpvBX+YAfyL+S2R3jqAdZvMZLw0I9f0bo+z
 RMfdjhf1lWYNQeLHMb8o1ypNL5Mb25cT8pMPCNNxcG98RHnv6mpHgesnJHEkbR6a10MCuBChSuL
 1vt+r+cZUi6VlpgOQ/e8XbKQrQlKjQgDoGqSUFD6GuiWojvby05Vq3nRM/lzmUUpXgB9jpvYm4c
 fHYV566OEkPBt2qoyk5+qvUHATrLJ0FR+cFPSTAvVmDlGWUjECCl1u9Mu3wZLBQymvYIbLcPETF
 bAGltRzBfYVNXA7/3pKoS/MG+fDVyNNMUXyb3EFDtFgfzPF0SdgbOwERc5Y05RexENJvolsE+2e
 nZuR57sDtsx5609h3ZxNllWY4dMvxLCoiD6kTLjh5ZMzdfip7vfIf5805YM1lM8nB8UeeBrLBhK
 k26qkPzMZxBHDqW7A3w==
X-Proofpoint-ORIG-GUID: 9iOUOG4y9f2s6ZcjpLsvDQ_8ChGyowhK
X-Authority-Analysis: v=2.4 cv=bPQm5v+Z c=1 sm=1 tr=0 ts=6a4d0297 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=iGamDvFj7nsy-0Hi-dkA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070133
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12067-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dmitry.baryshkov@oss.qualcomm.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:krzk@kernel.org,m:djakov@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:yepuri.siddu@oss.qualcomm.com,m:miaoqing.pan@oss.qualcomm.com,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:email,qualcomm.com:dkim,vger.kernel.org:from_smtp];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 40FA371C1C1

On 7/2/2026 5:26 PM, Dmitry Baryshkov wrote:
> On Thu, Jul 02, 2026 at 03:20:52PM +0530, Komal Bajaj wrote:
>> Enable Bluetooth and WiFi connectivity on Shikra CQM, CQS and IQS
>> EVK boards using the WCN3988 combo chip.
>>
>> For Bluetooth, enable uart8 and add WCN3988 Bluetooth node with
>> board-specific regulator supplies across CQM, CQS and IQS Shikra
>> EVK boards.
>>
>> For WiFi, enable per-board with the appropriate PMIC supply
>> connections and calibration variant selection.
> This is obvious from the patch itself. Don't repeat patch contents, say
> something useful.

ACK, will update commit message.

>
>> Co-developed-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
>> Signed-off-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
>> Co-developed-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
>> Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 18 +++++++++
>>   arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 18 +++++++++
>>   arch/arm64/boot/dts/qcom/shikra-evk.dtsi    | 61 +++++++++++++++++++++++++++++
>>   arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 26 ++++++++++++
>>   4 files changed, 123 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
>> index b112b21b1d79..c9409ab0a3f1 100644
>> --- a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
>> +++ b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
>> @@ -16,11 +16,19 @@ / {
>>   	aliases {
>>   		mmc0 = &sdhc_1;
>>   		serial0 = &uart0;
>> +		serial1 = &uart8;
>>   	};
>>   
>>   	chosen {
>>   		stdout-path = "serial0:115200n8";
>>   	};
>> +
>> +	wcn3988-pmu {
>> +		vddio-supply = <&pm4125_l7>;
>> +		vddxo-supply = <&pm4125_l13>;
>> +		vddrf-supply = <&pm4125_l10>;
>> +		vddch0-supply = <&pm4125_l22>;
>> +	};
> Is the WiFI/BT chip a part of common schematics or not? Why do you
> define power supplies here, while the chip itself is defined in a common
> file?

You're right. WCN3988 is integrated on SoM, and its regulator 
dependencies are provided by SoM PMIC.
I'll move the supply definitions to SoM DTSI.

>
>>   };
>>   
>>   &remoteproc_cdsp {
>> @@ -57,3 +65,13 @@ &sdhc_1 {
>>   
>>   	status = "okay";
>>   };
>> +
>> +&uart8 {
>> +	status = "okay";
>> +};
> Same question.

I'll move to SoM DTSI.

Thanks
Komal

>
>> +
>> +&wifi {
>> +	vdd-0.8-cx-mx-supply = <&pm4125_l7>;
>> +
>> +	status = "okay";
>> +};
>> diff --git a/arch/arm64/boot/dts/qcom/shikra-evk.dtsi b/arch/arm64/boot/dts/qcom/shikra-evk.dtsi
>> index d0c48bad704c..4b7be09eb5a5 100644
>> --- a/arch/arm64/boot/dts/qcom/shikra-evk.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/shikra-evk.dtsi
>> @@ -3,13 +3,74 @@
>>    * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>>    */
>>   
>> +/ {
>> +	wcn3988-pmu {
>> +		compatible = "qcom,wcn3988-pmu";
>> +
>> +		pinctrl-0 = <&sw_ctrl_default>;
>> +		pinctrl-names = "default";
>> +
>> +		swctrl-gpios = <&tlmm 88 GPIO_ACTIVE_HIGH>;
>> +
>> +		regulators {
>> +			vreg_pmu_io: ldo0 {
>> +				regulator-name = "vreg_pmu_io";
>> +			};
>> +
>> +			vreg_pmu_xo: ldo1 {
>> +				regulator-name = "vreg_pmu_xo";
>> +			};
>> +
>> +			vreg_pmu_rf: ldo2 {
>> +				regulator-name = "vreg_pmu_rf";
>> +			};
>> +
>> +			vreg_pmu_ch0: ldo3 {
>> +				regulator-name = "vreg_pmu_ch0";
>> +			};
>> +
>> +			vreg_pmu_ch1: ldo4 {
>> +				regulator-name = "vreg_pmu_ch1";
>> +			};
>> +		};
>> +	};
>> +};
>> +
>>   &qupv3_0 {
>>   	firmware-name = "qcom/shikra/qupv3fw.elf";
>>   
>>   	status = "okay";
>>   };
>>   
>> +&tlmm {
>> +	sw_ctrl_default: sw-ctrl-default-state {
>> +		pins = "gpio88";
>> +		function = "gpio";
>> +		bias-pull-down;
>> +	};
>> +};
>> +
>>   &uart0 {
>>   	status = "okay";
>>   };
>>   
>> +&uart8 {
>> +	bluetooth {
>> +		compatible = "qcom,wcn3988-bt";
>> +		max-speed = <3200000>;
>> +
>> +		vddio-supply = <&vreg_pmu_io>;
>> +		vddxo-supply = <&vreg_pmu_xo>;
>> +		vddrf-supply = <&vreg_pmu_rf>;
>> +		vddch0-supply = <&vreg_pmu_ch0>;
>> +	};
>> +};
>> +
>> +&wifi {
>> +	vdd-1.8-xo-supply = <&vreg_pmu_xo>;
>> +	vdd-1.3-rfa-supply = <&vreg_pmu_rf>;
>> +	vdd-3.3-ch0-supply = <&vreg_pmu_ch0>;
>> +
>> +	qcom,calibration-variant = "Shikra_EVK";
>> +	firmware-name = "shikra";
>> +};


