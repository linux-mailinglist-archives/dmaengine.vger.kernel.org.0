Return-Path: <dmaengine+bounces-10837-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NEGHLn3E2puHwcAu9opvQ
	(envelope-from <dmaengine+bounces-10837-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 09:18:17 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB50D5C7078
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 09:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCF473026773
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 07:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465E03CF67A;
	Mon, 25 May 2026 07:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ty91wsRl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aVomSAs3"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CBA3CF67D
	for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 07:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779693382; cv=none; b=MS8cLPSv0sHTvJLMIszuA93EbvBtJqzfMdDbZ0mnBTIbTABTNHR9at2L39KTLN2q7tFyZrIoV7YTN1aX15fNXO39CvJdWr6r44Pee7uTQXfeP/vFmB5ms5vUq9idL81ff1sMCrFnluco4/Cg2fKpsyP1ZL/16uxNycZdm6Q8c4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779693382; c=relaxed/simple;
	bh=I2CWT5X/+wO3lGtzQ8XKY0hFFrg3LJ5WWF0j3IQr0r0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y65VceXe2f/YG0aRLPfbmGNX7Z/Wc/F0S27iCMA4OY8xG1a9Iz5jZjAtaEWgAVoT5d6HiX8V1Le0j8Zz1A7bq8lJar48jjnU6df4A13DDwFW3YzmC11wiVa38ajWH0446hRNW6xRF/v2GjKF3Hy14wHFipj4Gq2nAMU7oqG3M4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ty91wsRl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aVomSAs3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64OLjI9W1518829
	for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 07:16:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DfFX/9N/HJ+7ZdKXlPX+dckwA6rQWh6qJncjMyHbYV8=; b=Ty91wsRltsoE2oun
	2PO2cc/LxU2VicEvx+xhM0DT1g56wkfPJwiU1b/ZPAjxt1kDHLFBcBh/YLNrgNPe
	2W9NNSG+e90RgsV3NV3YOMOsADAg/1ZZbA3FI6DnlIZIIsxl1zP9tgsZhSepS9gN
	+1q41CXntP3uvObjVjkhXK3oAe8w41fKifJTv4MZ/c/7BXINH0cDtiY+ocxs4dIq
	cZ5aNAATzdtRuq3p+9UM+Cz3oav1yCd3FpQqRyh/hqi3cZWI2Fkni766b8EEFShR
	2/xPYY72UaBiMggSRrdiRdiiIoaxI4k6Oc/fubaDSHs3rTPW+XlD2Bf1iH+PeO7n
	IAbwbg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb3txnh4q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 07:16:19 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b9a3c3c4eeso92018345ad.3
        for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 00:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779693378; x=1780298178; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DfFX/9N/HJ+7ZdKXlPX+dckwA6rQWh6qJncjMyHbYV8=;
        b=aVomSAs3bxb63VmdX5Pa1GuIrA72a+ZzgxnDM5DfOjF/nv6IYCrhh9QhpftFswP8mR
         13zlF5PuRX6J7xmqFlzv3iadCMKPOlpBOedTDAJz0ym7hnnLBu+sCLd9XLE2JIQz8hQE
         xPw+dbCFSrgnrMdNLw5kSDqL3+VvqzvVa7X3Jpa7Mr0cWOSGaoRX/B03wysG4QDfNh0I
         JIef0SspXLGD4AOPl4thtd67vCFhJBduKRknmjz6wYLKweuDtr0BBvHMOz2MCeLVrYm3
         ZyMDF7DlNUlgnH8ZjoppjGE9kLC3C8ZZiPVHcxn9XR1HqBD4tKvmKavDAL3NOxboYdz1
         sAlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779693378; x=1780298178;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DfFX/9N/HJ+7ZdKXlPX+dckwA6rQWh6qJncjMyHbYV8=;
        b=tOFeiCWCYM5FY56aKkrrZgjEDCCdPln9Tko3ublu8tkEhQzxRKbZJxqIqPYc8vxvga
         g8igvGNoRqEkxE8LOCm4yugOL4noPWDFzI0bCwijZ8THFtVZ57pSunUI36EchxWOmrTZ
         2D2j3fkiHSNKgMIu9bf+tUCurDE7svj8OA4E6dzqQooJaC0v41cO4bzbszawohBUNiQv
         IMjffJTZo8y4JO+U1lW6LDAkrrb7BSJB22AhyWABF+yZAcOV7ey2PoFYFWprpPML/gVo
         /S4EX/7DEd4NOInx4UgjbsxzpQjPL0Gz2JuVxSgH7/LVrHuDi15rzhsI9Gnv9ozyRrT2
         FKtQ==
X-Forwarded-Encrypted: i=1; AFNElJ/d7iDnSBMTssRTWxwWiAU2Yw9A5aMi0nX1DN/z0Kh9XO1xN0TknOIUkuYW24wibV2o9FkWR997hh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEChv+Z0jnbpZrdOt4F/MXLTX3liwoWFfLHqWLqt6D9jwx7OvX
	3UptpsGl1BRP4o65W+h0oW92DRZjJoIeHpJHL2lorU81QwYKR5j71g+P2kkUmtHlaqc6XAe7bDI
	gQu3Bj6yJ1LwnyDlGRuOlRMRV8rU0QZ0Hsa8OxOONvyTFRId4YRSof3F02dYoTh4=
X-Gm-Gg: Acq92OFIj0Lj8Ud3Db3hmhqF5ItgWMYqUUqMUX7fPllOna7QTf2tymGX+kkYsNjwwLv
	fC/cpCqU8yTqYo8P83mpcZ/j9FazoG2uz91WGgbB4T8dI9546uHC3jytmSefZY01S0UyBrl2eg1
	D7UAJOBADZ0PmAyCdAQqCGsjKdRYb6lHni0hvOsUjc3eFzKcixDIN/HdyV6EwydENIRl9Sg1SFx
	Se7OkuDJvFsnSNutHPkjvOBmWO5ML9zcwtvglRqunbLs4ZKwPQgWnyY46BNBB9LeMVSYLdcWq/L
	Ts5mpmQt1by8DVE7m26Br977zHQV4rJKiacvjrGSdQSbEI+dU7a457k+xdwPW2XQxd6Yz2UxvpN
	y1qbKoDiZ8YHr4nzbjfPVsowtIhqVbAMX35cRF0iRh5P01ysNhuMpTA==
X-Received: by 2002:a17:902:cf4b:b0:2bc:dc0b:ab1a with SMTP id d9443c01a7336-2beb06fed74mr142504925ad.35.1779693378033;
        Mon, 25 May 2026 00:16:18 -0700 (PDT)
X-Received: by 2002:a17:902:cf4b:b0:2bc:dc0b:ab1a with SMTP id d9443c01a7336-2beb06fed74mr142504475ad.35.1779693377420;
        Mon, 25 May 2026 00:16:17 -0700 (PDT)
Received: from [10.92.183.29] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bed2061c59sm28566265ad.2.2026.05.25.00.16.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 00:16:16 -0700 (PDT)
Message-ID: <9a0a2ba2-4f1b-425d-979b-fe59192bb2cd@oss.qualcomm.com>
Date: Mon, 25 May 2026 12:46:09 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/4] soc: qcom: geni-se: Keep pinctrl active for
 multi-owner controllers
To: Bjorn Andersson <andersson@kernel.org>
Cc: viken.dadhaniya@oss.qualcomm.com, andi.shyti@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org,
        Frank.Li@kernel.org, konradybcio@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, linmq006@gmail.com,
        quic_jseerapu@quicinc.com, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, krzysztof.kozlowski@oss.qualcomm.com,
        bartosz.golaszewski@oss.qualcomm.com, bjorn.andersson@oss.qualcomm.com,
        konrad.dybcio@oss.qualcomm.com
References: <20260423145705.545552-1-mukesh.savaliya@oss.qualcomm.com>
 <20260423145705.545552-4-mukesh.savaliya@oss.qualcomm.com>
 <ag_HGVQjIQuMoKO6@baldur>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <ag_HGVQjIQuMoKO6@baldur>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDA2OSBTYWx0ZWRfXzr89YM72XaF+
 dxrhyxtlXJ16GIUdBx3uaAJhlPz+xKiIkCYu6yyZyhjHgmQqGfXkjPB5pncf/82DvaBQrHxYx1L
 qOGH7H0OzmosqdtyUKgVGig190FdTv0uWzHLkU5WN+MwRVP+F85dx8wwo315pCTX/mWFWmlAgWC
 h0Q5+owXdJ7Sk0nM4z665uhx+ezlkH/SvlyptSiqbPru3qVW2sI0ggkT/teJsNVkWzYqVPx8DyK
 kHeJGaO/Mcya0ciy2pizk0xCV8YTudcBpp7WvSxzZKtsMK5MvN3YpbcXSWeS+KkQkxdyN6OYTFi
 OiaNaF/XEVyOkKUbBf+dca07JZ3da+l/mFGzWLUFfLF2pBPtSq1Nv5NgKigzz29753K2JBZNMk1
 6Ezlt5TKWS1R30G1BYWn43nI3d0RqXrkoOhJCQ2c5BP4uC4hvWP0jwXj8XI+Cr9Emi3chA4vmog
 dYahxtrwTZanwSY2k+g==
X-Proofpoint-GUID: zbAkCp8Psglm6t-0EEEMdNcCiOmzGpu-
X-Proofpoint-ORIG-GUID: zbAkCp8Psglm6t-0EEEMdNcCiOmzGpu-
X-Authority-Analysis: v=2.4 cv=MetcfZ/f c=1 sm=1 tr=0 ts=6a13f743 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=XeA8sPVIX9ygFgyEX44A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250069
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,kernel.org,gmail.com,quicinc.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-10837-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mukesh.savaliya@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BB50D5C7078
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Bjorn, Thanks for the detailed review.

On 5/22/2026 8:36 AM, Bjorn Andersson wrote:
> On Thu, Apr 23, 2026 at 08:25:50PM +0530, Mukesh Kumar Savaliya wrote:
>> On platforms where a GENI Serial Engine is shared with another system
>> processor, selecting the "sleep" pinctrl state can disrupt ongoing
>> transfers initiated by the other processor.
>>
> 
> Isn't it strange that the DeviceTree will define a sleep state for the
> OS to select, but when this other property is set the OS should never
> select this state?
>

The intent here is that for multi-owner configurations the
“sleep” pinctrl state is not safe to use, since the pins may
still be actively driven by another execution environment.
Selecting the sleep state in such cases can disrupt transfers
initiated by the other owner.

You're right that this constraint is currently not described
in the binding, which makes the behavior non-obvious.

shall i update the DT binding to clarify that when
"qcom,qup-multi-owner" is present ? The OS must not transition
the pins to the "sleep" state, as the hardware is shared and
may be active outside of Linux control.

Alternatively, we can also consider relaxing the requirement
to define a sleep state for such nodes if that aligns better
with DT expectations.

>> Teach geni_se_resources_off() to skip selecting the pinctrl sleep state
>> when the Serial Engine is marked as shared, while still allowing the
>> rest of the resource shutdown sequence to proceed.
>>
>> This is required for multi-owner configurations (described via DeviceTree
>> with qcom,qup-multi-owner on the protocol controller node).
>>
> 
> The requirement as such is reasonable, but you don't define in the
> binding that when this property is set, the sleep state must not be
> selected by the OS...
> 

Please let me know if you prefer second approach over the first, i shall 
update accordingly.

> Regards,
> Bjorn
> 
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>> Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
>> ---
[...]

