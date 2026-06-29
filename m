Return-Path: <dmaengine+bounces-11868-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DdhgETSFQmr58wkAu9opvQ
	(envelope-from <dmaengine+bounces-11868-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 16:46:12 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBE56DC369
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 16:46:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=cakNeJZC;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=kmsnVjuj;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11868-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11868-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6968C3042318
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 14:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A1241B346;
	Mon, 29 Jun 2026 14:34:55 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF044192FC
	for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 14:34:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782743695; cv=none; b=taOAFmAj61MEvkGuF/sWw5KC9a5LMdy13dRnn1DnAogEO5a9EQmJyfGEI07uUZXgFs5rXhDDPmZvdH7EyDjJHefBhgA41wt1w+EvW3wSg/8vBhJtPEYstoU0s/OTyTS34aIXO7devpU3zRB7AiX3XuRR33o+kfjHCz2cDYN14bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782743695; c=relaxed/simple;
	bh=d05Fycd2bYo1vzS1RtKd2HZ2iWBH0Agkyzhv3yB91pc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HZ5atpFwYhQMhBRsDxbAYpZYHVSMq66ELDBexhyQXeEnT7t9kc4u8Lkag5nJcVHR7pwelum+dI7xjddc4pRu3ORRAOOs2rxlkYIs69BdPV4czMKdnxlEKXssIlJ3FC7tHzm+S8y5o7wlKs/BM6yCHgFWlsBahjeTv0ExBs7cz+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cakNeJZC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kmsnVjuj; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65TATJYX2642203
	for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 14:34:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HqxLsFSIjpjpgfIsOF0zA+8yLigOIjsUeyr/IlQVCzU=; b=cakNeJZC3hkOaDJg
	x5BeMewWb7qRGF+V1MWGBoz41UrKVB8l+Xdz/ZnFv0BDS0gyGoEiV8dzTwa81ZQE
	ejsT4pWOBbJRs36ULqtLgn/YGEgslOPrQaCqyKeZliyT2Euh8nVrdHoI6yB+Krb2
	MywU3DDkZ2aZolbNHMThMC0uNfSxiYh1XuqIr/9kY/lb5IA3F3jViITOCjaH5pK8
	IAjxb+1ypiYLo47pb1CJdswPEnkygWzn48HqPt2tVR1wTJWQD/gGPRExL1QTvpF7
	2pu5DeN8Mw7av9oN2TIk8CcsDtizuE5ZyOkXVn6Y6az2ZwJUp2hzJOPdCOwUTPFR
	J7+kBA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3n5s1fk6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 14:34:52 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51a8ee253caso2312371cf.0
        for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 07:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782743691; x=1783348491; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HqxLsFSIjpjpgfIsOF0zA+8yLigOIjsUeyr/IlQVCzU=;
        b=kmsnVjujkr84UsusCovTuhtg1awcT2LOEJsQN5YvxHhafyNgBfQ8ssj+lyyO1O2jfu
         Qo7m6YpBDg4ahYjSr2ecRGAkWoeONak8z0NGip7/fyo4loKIRGrHAdi3ltNjAM1HaLje
         gwyrX/mR2B6/pAOCeug/YTPRBeHHGToj0cz/4YwDQ7JkyNamtDAismcwoE3TTtW4mXc6
         rPjnr0A73Ig32PQHaGo0vuBoOYQH1yMnr58YGPqxLhNFMXVXvdxtAe9ZiC4t3J1a18MW
         XFahEcylgaKhZDjDhn+xyUM59eAwzN8DoONuCFKy+AkG92cAq+qF8mDkfsXggRxiGyzw
         BKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782743691; x=1783348491;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HqxLsFSIjpjpgfIsOF0zA+8yLigOIjsUeyr/IlQVCzU=;
        b=gEO9pVcpPxafi9PGO3wT8mQw1n+cJL/iq4rK0UPRkH1S7Xi6HVZsuxzj36JRsv4icl
         ok7pNnjuvxBPrmidPwAIUzXEumak2swiP7+psD7f/3jfLQL6deW5IiukgWbk/0SXl6w8
         Qh7BS1zzQdxV/ATnJnS3Fc9WVK4EHJVsFa9nUzsC148lVBSVRyYLRMRwTnCkYdkB/QcT
         ZACUCjkqudwKMzTpclhLJv7FYePrHKlDN38zTVG5FRoqw/ZIeHPeQUIb3O0bOsfPtYz1
         LwDIyrrPmLpnGidA4mMVlt7ABaf//Nn4ZOc2bi7QTdspZO25esesob4af9qdKjxIgrnc
         rXpA==
X-Forwarded-Encrypted: i=1; AFNElJ9FMpZAzfLlr+RZntTSawtqQ4D0lrPWyXa2IGAcIiHWqV3ym/9pWuZb8wOROfcCWgrjb0bOYQsXeu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwooHsTABETpLmBy8J8412b2k/gMU4u1StBaRfY4WkyYgivjO1S
	w2LiRBUjIlB1pUOZ7PCeU5jtQJWeJM64/omqe3FG+k4XfD6qmV38wkH4cgjDQoQ5w+WsXn1W7UI
	v/BhETPNvIu1iUWTOE6Zomgrk22nlgvzHEbos9KSjJHjuh3+YCAZw4kv9xVvJjwU=
X-Gm-Gg: AfdE7cm6StvBPhskJjs2D9hGmvqsggs/HyE78f44+IPL1bLZ77sKeYsgECXetPxX8pS
	VoJPJjEXCF1jNU38DRI3jsccebxZnN/N+uI6LtC+ymjeBX1s0gO+k/ig9Z6m2XdTk8jdPh5WRWb
	3y9AELzGTSvI7ELbBRYFR7913aFkoMPZGSm+SWxMWE/m+GnMT5hkaSn5LGRlrsbDJUSp3QWVTa6
	VZvRnhEqor2QE/q1walPJqwt6/hrYQHTPvhcJvsdIYftBn362gjBuqaHkbsNxElGHsGp9PAqcEZ
	D+uZbzCoqzipW1/t18k99u2tCJ6jd5CXgFlV7tUDEF95EIolWs2APNGUehEWUV2AF+ySjSZENHl
	O2uQQrGn1Qfx2uSkUCdyDcG/ZCIrGpmPqSwk=
X-Received: by 2002:ac8:7dc7:0:b0:51c:a85:bf91 with SMTP id d75a77b69052e-51c0a85c063mr13123681cf.3.1782743691074;
        Mon, 29 Jun 2026 07:34:51 -0700 (PDT)
X-Received: by 2002:ac8:7dc7:0:b0:51c:a85:bf91 with SMTP id d75a77b69052e-51c0a85c063mr13123191cf.3.1782743690417;
        Mon, 29 Jun 2026 07:34:50 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1250a80b04sm289378066b.34.2026.06.29.07.34.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 07:34:49 -0700 (PDT)
Message-ID: <64691236-178a-4fc2-a9c0-f053b7944e66@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 16:34:46 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/10] arm64: dts: qcom: shikra: Enable Bluetooth and
 WiFi on EVK boards
To: Komal Bajaj <komal.bajaj@oss.qualcomm.com>, Vinod Koul
 <vkoul@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
References: <20260608-shikra-dt-m1-v4-0-2114300594a6@oss.qualcomm.com>
 <20260608-shikra-dt-m1-v4-10-2114300594a6@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260608-shikra-dt-m1-v4-10-2114300594a6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEyMSBTYWx0ZWRfXyro3blH69HuP
 5O8/8KaH5X3DbCD78t4ipPnzEDE4TWQNqRGDdMYU0pFPBFK+vCcCl810nWdP66qOJX4CMrizxXv
 obDqZvj1TBW6pa/ts2uNjofhWElvuBM=
X-Proofpoint-ORIG-GUID: UCPLzHp-5HYw78bp2q8rZGDK2U4si1b3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEyMSBTYWx0ZWRfX2v7uEPPsu2q7
 Lu9wXobbOdXBWGPy88TR/sePZ7yO2+I1dTa7e6qhS+1eTaxXYhWsxCYxpWTIQ0kLKB8clzWimd0
 RMuMm8zycLyzGoyLnbPR0alyMvsmBvjZqmSy0/tSm8urKHO/BqRPWEt7GssNxL8Td+cmugZg2YX
 4RkLUt6xUMxR17YLCIWPuWUNKgExBBS93M4LDhjDM98RKt5pSBD+Sqyvwp1cV2suCVOCHm84wCd
 5s/ptJkxqX/yJ6EW6IBJsVF727IuyJHVmWP69EbERe8z/urAkGILpKI38Q9OhojxNvBZxbc+x1k
 Duc+8sVdWSM2diXJagR4SHqc1vd3Ah9mqHR+JgXw3bARn4Tv+C2aFCxzYiX3q+3rf4dd+A+c8Md
 gKAm/sBfgiiqz8ZvtjYw2wS+H7vJqM0MFU+gQ91vR1rN/4Bax+gNRJvAwbFhYyZFnB/Ia4v4Q3x
 N2279xaY5lc9thE5ETA==
X-Authority-Analysis: v=2.4 cv=NZzWEWD4 c=1 sm=1 tr=0 ts=6a42828c cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=bA5z4lzVfraiEpfBxBMA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: UCPLzHp-5HYw78bp2q8rZGDK2U4si1b3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290121
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11868-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:komal.bajaj@oss.qualcomm.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:krzk@kernel.org,m:djakov@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:yepuri.siddu@oss.qualcomm.com,m:miaoqing.pan@oss.qualcomm.com,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[konrad.dybcio@oss.qualcomm.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2CBE56DC369

On 6/8/26 3:10 PM, Komal Bajaj wrote:
> Enable Bluetooth and WiFi connectivity on Shikra CQM, CQS and IQS
> EVK boards using the WCN3988 combo chip.
> 
> For Bluetooth, enable uart8 and add WCN3988 Bluetooth node with
> board-specific regulator supplies across CQM, CQS and IQS Shikra
> EVK boards.
> 
> For WiFi, introduce the wcn3990-wifi hardware node in shikra.dtsi
> with register space, interrupts, IOMMU configuration and reserved
> memory. The node is kept disabled by default and enabled per-board
> with the appropriate PMIC supply connections and calibration variant
> selection.
> 
> Co-developed-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
> Signed-off-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
> Co-developed-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
> Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> --->  arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 59 +++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 59 +++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/shikra-evk.dtsi    | 15 +++++++
>  arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 67 +++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/shikra.dtsi        | 23 ++++++++++

Split the SoC and board changes

Should most of the board-level changes go to evk.dtsi, since
they're almost identical across all boards? You can e.g. simply
override the supplies in the IQS EVK DTS

Konrad

