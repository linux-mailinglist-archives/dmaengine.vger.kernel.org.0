Return-Path: <dmaengine+bounces-12106-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y0qnFlT+TWpkBQIAu9opvQ
	(envelope-from <dmaengine+bounces-12106-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 09:37:56 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D272E722B4A
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 09:37:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="XTDKM/RO";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=Tiv98RjT;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12106-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12106-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 179943048F6F
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jul 2026 07:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73833E7BAD;
	Wed,  8 Jul 2026 07:29:19 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E489A3E95B3
	for <dmaengine@vger.kernel.org>; Wed,  8 Jul 2026 07:29:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783495757; cv=none; b=ixP1KDc8P4e6Ua9l/XUK2Ip9LdxaoZ0zx9MlfbJjmxWaf+A3edIJNLLW4eT/8YteVm0Fej6jRIsXLsJhwHZhYgSFhNicEVwJCKRbuQsymLFEVI35ur8DKGHGV/AkE2leWnxchieTCIYNBdpYMpLQOq/xVJEYwPlmVlCO+dPVj6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783495757; c=relaxed/simple;
	bh=Ugb0YDtHFZrdU/ufa9BpgTebHed1Xy+3F4Qxx+d9MZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YkEnDVIpd7pmfBFDSEcethV7HR1ZTD5tTlPL8MYHsvqQSk3zw8mPG4OX8xJMwCOOD/hrbgAgwtM8q1Wf4egTGKepyoFeYCurXJG+5HaUQmFEWQpKEzvspuziTVxT5teFPrwFo0G48fbEhgHhZpiYJFBEhHWbFp8rs4a0zsrIY6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XTDKM/RO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Tiv98RjT; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66842k3s1491932
	for <dmaengine@vger.kernel.org>; Wed, 8 Jul 2026 07:28:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dvh5gJVY8//gKF0mr/H5qtFP7jMpQbhKSM7yYtQ3njU=; b=XTDKM/ROgQW88A9J
	4ceQC92h/kboQMOd1fmCWfZ8IYSXbZ6/H5KiGZw67SckXZuBdjfdOO4qfryYSD05
	n7d5FYscK0bC86lRG4MltHZvMaKBFeaQ7fCFg/AVfRho56byqzhHPvzf84FkzL1p
	wL2HD3HogKNLn4nT2wlStHldKeBn4DL4ncu+8/lpZCtpMWiVsw8QJybYd1duVr0v
	eu6V+Tu8Ar9q6QqY/JtvU6iEe0ZHhevwLgyHTtH5ArSC/JRkFCrrgyO6XfrYpV8x
	TVoVmqW+8nd1b2I4o0FatWOgO6JgABsjqL94LFSkIPpqNA8HBQwZxz7a4XUAyh3j
	+g4PUw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9b5g9jsr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Wed, 08 Jul 2026 07:28:58 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2c354050c34so7335685ad.3
        for <dmaengine@vger.kernel.org>; Wed, 08 Jul 2026 00:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783495737; x=1784100537; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dvh5gJVY8//gKF0mr/H5qtFP7jMpQbhKSM7yYtQ3njU=;
        b=Tiv98RjT4OW6m8gu6Zuf/LORu2SEB1EWZAnaLIVxK2WDrYnek6oNLPOsZqyeXlK0ZG
         gnWZa7kQLhsTlgVJ+dZm23+cFLgnV+wnJHfvjYRImvXd634m/yFQOHXnZEGzv4yv1dFB
         EFBx3Lad4wYTFdnLcEHNEy9+CbDIA7x3WcdElTED8AhWPnDp/v8lwG4v8ZplN47VXFUh
         syX6UNYDPXeCIF41dKYaLJYCfe45LqhlcjIYAdjvQWTql4pEyXhFNnWr+LKKS14409GY
         h0ncYTkX5x4cWQ2nWnlFpyLeNKLrFc5emK27UMZT+z2ecTNGjnyoXzAvOS6QXBkBnYo6
         ognA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783495737; x=1784100537;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dvh5gJVY8//gKF0mr/H5qtFP7jMpQbhKSM7yYtQ3njU=;
        b=TDtUqB6hDWvwVTtxcAlFC+ONBkGibrMofETkKHkQLXfM+d6GTGP10iBvp1t8pCIndu
         4IX0+Mu1MmhiM7+XKduEvINCZzRd9oHOM+xIwdGjJWkKNO18VOX/KKpcq06OZGSwtXBw
         yfJ4MxeWJn5M36RskEoESay7NyJU0aXhO7fLIQFfFGAqK5T8B+452q6Q4pzZj81lZ2Cx
         LFkNlW3LA1/aCpK31gC/raigd0PKbdMqErIyPpJBqnl6qZGcuLwAkS22csGVmIwXGcKE
         Sws2gdQLrxWp4aIagpgBOTXyt17ZTzZnFYmSCo/a0vJypEkwktfBiOy9+WFbfdoMlJC6
         BvaQ==
X-Forwarded-Encrypted: i=1; AHgh+RpGlR1VrVMnEaMUt5LvMtANAFOVedKDe0Ms+6xH8MLDv2ku4mOsG5NbfcnAjfTHVbcOfnXUdF8fbsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcC2XqfbhZy1HAZVic1F/A6sUD1j/GfD00WGHXjM9LDFRhT5L1
	MdRUghSeJiYDYkdnEDSCNuMqJIpxjq/Hs9Sqphnse57CXGk6WPK6eTQOWZV6fSd6thcAT1TiFwP
	CebEfkJGCS6OSSaKj+zuu/ZiV+a1/jP9RANC97W5hHZXsXnAPYXtvHpacdLiwY7A=
X-Gm-Gg: AfdE7cmXNTSgrUf3hXlaS0HLvDm0oLmuPmLOwwH0JZT66y1MQZFDr7HDDrvAQwtJXU4
	zFv8+92x/fcAIgiFi0Q2WKUWkivBcnMSFTFjLHcvvvYpN35lfDTPN14/bPL76/44u5F3FYdXwVd
	5Z4U5wiBIG0xFG7rPtfg4C+J4tWIyNlPUUGw18/+p1vv4fwO082gnQG0zRPDw18M0esDjl2y0Sj
	d4QIm9iClFZXEj134iHsWmjoxHS8E0m7z3WfvhVGXWtlP5STj2sPa7cm2RzZLunaGwmRHC20UAx
	7rJPV7MZJ3mhiihp4nmPTrAJdIZvXguhmo7oeIQpMAK4UhazZcEzS1yRBBYCrml6ceI0ygr1i1E
	A5I+FcaZ0IR+fWZCqFCqDgaMTrKiH7DoD7rDg0T8X4eG0
X-Received: by 2002:a17:902:e950:b0:2ca:ecf6:9104 with SMTP id d9443c01a7336-2ccea384155mr14778715ad.4.1783495737345;
        Wed, 08 Jul 2026 00:28:57 -0700 (PDT)
X-Received: by 2002:a17:902:e950:b0:2ca:ecf6:9104 with SMTP id d9443c01a7336-2ccea384155mr14778405ad.4.1783495736875;
        Wed, 08 Jul 2026 00:28:56 -0700 (PDT)
Received: from [10.217.219.87] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc99cc5aasm23834915ad.0.2026.07.08.00.28.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 00:28:56 -0700 (PDT)
Message-ID: <55298d53-9609-44fb-bf02-1d2e8ee03635@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 12:58:52 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] dt-bindings: dma: qcom,gpi: Document GPI DMA engine
 for Maili
To: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260708-maili_upstream_gpi_binding-v1-1-e48cb7e216e3@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260708-maili_upstream_gpi_binding-v1-1-e48cb7e216e3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA3MCBTYWx0ZWRfX7OKd+U2QOark
 dmj8rLGNv3W/6F8bpOIYF1POUSJsbQ/Ohpg0oFhqbpApNAM933OCem//jjc1faFQFoMIC0NS/3w
 /ZtoBWNnNEofTQIsKw9FJDZLRJI6gf8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA3MCBTYWx0ZWRfX/faYagNacfGt
 K3yAL4kFXf0gs4/SL79uNTPcpNRn/EOz3YawH/Ruc2C28/dzC0412T0NEwNIDfx5Kxkl0yppTCG
 D7Ch5Kz4vjluIbE1N7WPvlpAZ6lKynGxDtqItg2orQnaTyan9tLbDwmGVkYAhtwqAonX6HIjhWt
 dkRrlgh70EPfzdPfsJcQGfWcWsTnVXWnbL9PqrsR0DJ5jiyuufIvIcfNbr2BPvStGT6Yb7gU8bE
 5jxhPO1iY1tHplcb1QSKdkTJJN8/5d23Hyv3FECI+Dt0lLMOkU5FlX2wgBKKp6WM4d14uCb9dzA
 yyB1AYby2UgHG3cSNWaxogZTANBbgkkyfKakoEF8UnB9GN3p4mjtRm4Qf2BdBT6zN8HrEqBeMZ+
 H0/KYVUPN7SJR/pTDZYcs5KS9GL/UncXSsOJzBV2gPVNJBteVmR0ZFrEq9vpkOOvv9msfR2E0gt
 gI3nZEFKC5L3F39BVQQ==
X-Proofpoint-ORIG-GUID: 0mH9tEEz4eDtLECcKuYdAXk283bNcn_s
X-Authority-Analysis: v=2.4 cv=JLULdcKb c=1 sm=1 tr=0 ts=6a4dfc3a cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=vY-R0Ho-sSes-qxfqNcA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: 0mH9tEEz4eDtLECcKuYdAXk283bNcn_s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 suspectscore=0 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080070
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-12106-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mukesh.savaliya@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jyothi.seerapu@oss.qualcomm.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mukesh.savaliya@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D272E722B4A



On 7/8/2026 12:35 PM, Jyothi Kumar Seerapu wrote:
> Document the GPI DMA engine on the Maili platform.
> 
> Signed-off-by: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
> ---
>   Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 

Acked-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>



