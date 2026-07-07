Return-Path: <dmaengine+bounces-12063-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eTucJnaETGrHlgEAu9opvQ
	(envelope-from <dmaengine+bounces-12063-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 07 Jul 2026 06:45:42 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF12E717473
	for <lists+dmaengine@lfdr.de>; Tue, 07 Jul 2026 06:45:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=Y2F3xtTf;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=Mfi3pp1t;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12063-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12063-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93E673030B37
	for <lists+dmaengine@lfdr.de>; Tue,  7 Jul 2026 04:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C490136729A;
	Tue,  7 Jul 2026 04:45:33 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C8E2BFC7B
	for <dmaengine@vger.kernel.org>; Tue,  7 Jul 2026 04:45:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783399533; cv=none; b=YiQ/4H/ZBOsZC8STAmYmM0RuliiLvRnzej1BtoXmP/IJRk2oZ9btJhRfL3Nf0x1sHIRzM/ZB3n2S12q7l4TXDWM6tkhIyyZSYb+HapuP9UxmQiJoeji/knUVGNRuDV9nNip2uAqvy6o8drs0+Gwvi0i1vs3usjGVU7Jx1dmkJzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783399533; c=relaxed/simple;
	bh=bOaen4HQBqLDxgRE5hyhkg9PTG8dtkmNvWLObiWeEAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G6ax9WID8dULMqqVJ0KGi1SwQNGaMizH4ADBoYUXvUN1LsMu6Bknoj5L++4wlGqsU/dlncGFoHgZdg1X7x/Mdy/BRqPpZU6xKm8nbRm95+IHw1rHDom8OyR8TAyEthNmTQC+JqgPPkswJ9hFys1Qbz9lbIEwtbRtWp1VOh+JzsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y2F3xtTf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Mfi3pp1t; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66749GRl2499136
	for <dmaengine@vger.kernel.org>; Tue, 7 Jul 2026 04:45:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q+k3HncfY880D3KURL9SNiHOlxwrlnkZIkiKMuzSj2I=; b=Y2F3xtTfyd6BLRRk
	BgpGOZOoWOxO0apoZ9nms/Xu0fgEoUlTTi9kW/4wYx9kzSi96rZd5en0OnaFkwHQ
	oay/Rdi+ZtPda9+o/7PpY7NoNgsTaNV9Z4LMG+LkBALufCDA6GF8NfxnpGu+8AU1
	4+KxpMvt57w2yZBl6HCGwVMcnvXUrQsh2GBdbsofVYMkUSzrHmFw/LzD3AP+VLVV
	KoEVOy/SYJyrQ+4GsPKBFS4YZG5EjevP99aAkDP8FsVqhYODsgKzSDvToIjHcCGC
	besq1ArKplIlKmIKnrETi1a+KT3YYzIrYVog1ZFTUcdXmq3wVfPb4gnlNUx5lAPV
	VuQ5Vw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88hsckht-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Tue, 07 Jul 2026 04:45:31 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-37fca5f21b1so357279a91.0
        for <dmaengine@vger.kernel.org>; Mon, 06 Jul 2026 21:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783399530; x=1784004330; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q+k3HncfY880D3KURL9SNiHOlxwrlnkZIkiKMuzSj2I=;
        b=Mfi3pp1teW11+axrC+bBScKRZLUxs8pynUEWG3/cNFv+oPs2fZENe282B/Ddd1+s3r
         bG2rBdXnQWdlNYPuQZyrIejjX4Kls+aGBODS0Md6RvhkCvTzpiJWCKo+z3j8ia6ykV2s
         PrR5Q8clfTwW2Mdss2qdG57GqjoIQHxwxRQsjEXg5H8w7qILwakL+36CFNXt96JPgXtF
         xRLH9V3ZslLwNDvRsAcGX33mxN+TSAIWqBjO1O2l8OGgZYn2p9eOV7o0nDnpJa8EZlsK
         R0V2pjc7QfYVkVkRdUyw9qngW9wIe80WR523hHLCfUH29MvmQ1jxOeWWIVXl8TRlzULS
         Uz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783399530; x=1784004330;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q+k3HncfY880D3KURL9SNiHOlxwrlnkZIkiKMuzSj2I=;
        b=V5OGlIcvjCRlD+/hDwsliE7mQqeV2K4TqFQqNwEPW2A2wuGDEImVRRvKirCqK2EiPl
         VcQOrDCTpDtMDx+Pb3scBkkvPE/t0fy/xPnZxrW6vSFVaxeIf4HXH3qGvy/I0gYCVcBt
         BeyPfptu0BuaSF1ERAez23vbbEIjOhlZpp1CPRfA58eCKn2mpXNFA+wwuWyp2rrbJLvk
         Q7OU3pJDHmgYDNIWLE+q2y3V3OqYTt0/XBAicNkRNjgF5wXIUYScBfwEbcvoQDFtFFlM
         6s/DiR9gp2anOfrIf/vYUnQIYmjB7vXw8ZZf2qzxRt2AWmBEHr9n86XXAaeZlS/dkr2b
         c4cw==
X-Forwarded-Encrypted: i=1; AHgh+RpqF2YWHFKcXsyVCoMh6NCzffhkSMUSGrZ+Sx8HfpzdSLlO/Mkr3zWeQn/yBFPkwc+ODZmqjD6rgMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YziT4w7bnLd15R8o6VFT9h/X/YIHIWkKCKKL/DQlBgROlpk4Llt
	EO3FJGzGzn0/79WjNq5+UAtFyEjA45HMcacJ8PmdVDTnWtaRIsOZZJire6sKfIvqyqhBMrCuBki
	B2FxHF7Ii4kNOWjN4IT30EVLYvROhqATQ0+vGGTCWvHfnZRq11EkKNJZTqNewDB0=
X-Gm-Gg: AfdE7cmxuHDuQMC+UG0S9K4T47oP2AWh3HKEwXv3tqzo3+mIPhw6vAY4PADw+EBwRm+
	PoS42y4Jj8ZoSjTJ+Nni+2rDYevfp5vIUqZZ66OycKXZS4e2TS3pKnlKMVGIR2JWHqbnu9QBMY6
	W3cadiWKBqaXR5qQ4uRp/sbDVnaH0UszAC1E4eEkt4mPqrkF2D4B0DZNtGwjl0gKV2M6Na/D87+
	XsvE5bWzi/fh7vcQ+ASrnGDf88143eAf4k72anPOiy3DXFZ7/ALZA24qDmLJ9nHaWcP+3NGb39h
	VJlXXy2nfLk9zWQB+ePPV32SiQjQPptul9ya7JAUhrAWeRSfbR3cC+Fj2j0OPfz9LHw94JsNC20
	19u2LWZHe9s3+Elfb777Opu+Or5Jtsg8Fo2xVZPTGorM=
X-Received: by 2002:a17:90b:1801:b0:387:d9cc:7dc1 with SMTP id 98e67ed59e1d1-387d9cc8dd9mr1414253a91.19.1783399530365;
        Mon, 06 Jul 2026 21:45:30 -0700 (PDT)
X-Received: by 2002:a17:90b:1801:b0:387:d9cc:7dc1 with SMTP id 98e67ed59e1d1-387d9cc8dd9mr1414224a91.19.1783399529894;
        Mon, 06 Jul 2026 21:45:29 -0700 (PDT)
Received: from [10.217.222.146] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117483ddd1sm3586885eec.9.2026.07.06.21.45.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 21:45:29 -0700 (PDT)
Message-ID: <44d4c55c-bf8c-4baf-aebd-49ad35350909@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 10:15:22 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] Shikra: Add DT support for ICE, RNG and QCE
To: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Konrad Dybcio
 <konradybcio@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, Andy Gross <agross@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
References: <20260706-b4-shikra_crypto_changse-v3-0-23b4c2054227@oss.qualcomm.com>
Content-Language: en-US
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
In-Reply-To: <20260706-b4-shikra_crypto_changse-v3-0-23b4c2054227@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: cuG3Lx-hTvMflCG08iUt47eNYawpn1el
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA0MiBTYWx0ZWRfXyKa1ZwbT3vwV
 UI8Fa4iczpGc50fhFG7slI3CqtfJVLjWQJge83tYaMlbndy7825yATN9XZ0m6CsBGWCZ1XxyweQ
 Iof/O+udpMjpqmziq1JjWh47Fczxlw0WfmXISeOrwPzswYPphyEOZgkdaat8nyb0HAEvXJAO32n
 WAsVWTz1KG78jRfD9L3j9QsC5T9sEWTcwxGaD6+KuNAAyVWyFK8Z9j8tKN6x1ftmA2fgBGqQ//t
 qiz7Ke3S4OM3Yfamn/Af/35gYiFT7smoBCRcpSLPyzj70wpV4Lj0IrUnVnDmYTD4u99cUvNDtsM
 D2BsUQlQ75flR85FnQ32h8LuF1x06O80xGZdfrxqu+LhCywNrODii1m3TlH670Ag36jbl/B/WGV
 QUd8nIkjcWcyQbQTHoI8NETquUqnRR6vioKx2SX6wUpmpOF9neHaJPVWe0fMHOs+KMC1cebfUJv
 Hg3FfTT5KxiP2NURilA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA0MiBTYWx0ZWRfX8j9Ri4Hr/qT4
 sd7rhIZEE/XHomFYCBT21L/hE8656hMcBx4ElLt1jgEZLMrS+EBul5msitiLnY3ndL4L36dORog
 tuboGDOpXWrX3akwONJbnun+3Tgsp9E=
X-Authority-Analysis: v=2.4 cv=XIwAjwhE c=1 sm=1 tr=0 ts=6a4c846b cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=hD90gCo8i-7HE4vOkn4A:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: cuG3Lx-hTvMflCG08iUt47eNYawpn1el
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070042
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12063-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,vger.kernel.org:from_smtp,qualcomm.com:dkim];
	FORGED_SENDER(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:harshal.dev@oss.qualcomm.com,m:vkoul@kernel.org,m:brgl@kernel.org,m:konradybcio@kernel.org,m:Frank.Li@kernel.org,m:agross@kernel.org,m:krzysztof.kozlowski@oss.qualcomm.com,m:linux-arm-msm@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:bartosz.golaszewski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EF12E717473

On 06-07-2026 17:01, Kuldeep Singh wrote:
> This patch series enables SDHC ICE, RNG and QCE support on Shikra,
> aligned with how similar support is modeled on other Qualcomm platforms.
> 
> These DT and dt-bindings updates were previously posted as three
> separate series. Based on review feedback, they are grouped here as one
> crypto-focused series.
> 
> Previous threads:
> QCE: https://lore.kernel.org/lkml/20260515-shikra_qcrypto-v1-0-80f07b345c29@oss.qualcomm.com/
> RNG: https://lore.kernel.org/lkml/20260514-shikra_rng-v1-0-4ea721a1429a@oss.qualcomm.com/
> ICE: https://lore.kernel.org/lkml/20260515-shikra_ice_ufs-v2-0-2724a54339db@oss.qualcomm.com/
> 
> Prerequisite series:
> - https://lore.kernel.org/all/20260612-shikra-dt-v6-0-6b6cb58db477@oss.qualcomm.com/
> - https://lore.kernel.org/lkml/20260629-ice_emmc_support-v8-0-1a26e1717b85@oss.qualcomm.com/

Above prerequisite is no longer a dependency, as sdhci-msm bindings for
defining qcom,ice property are picked for -next by Ulf.
https://lore.kernel.org/lkml/CAPx+jO8t_kQ5q4XmNJoJ1nR4Kro-2M1s_Xj93qxuFUW7VPQpTw@mail.gmail.com/

-- 
Regards
Kuldeep


