Return-Path: <dmaengine+bounces-12026-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3bcmIYp5R2qYYwAAu9opvQ
	(envelope-from <dmaengine+bounces-12026-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 03 Jul 2026 10:57:46 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0627005A5
	for <lists+dmaengine@lfdr.de>; Fri, 03 Jul 2026 10:57:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=hMm8lBFk;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=XKlUoR9H;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12026-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12026-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8117430045BD
	for <lists+dmaengine@lfdr.de>; Fri,  3 Jul 2026 08:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0958C38239B;
	Fri,  3 Jul 2026 08:57:44 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06BE382F31
	for <dmaengine@vger.kernel.org>; Fri,  3 Jul 2026 08:57:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783069063; cv=none; b=GsuU9GfdpHCs59N5jdaOsinv5RCfHG+l0nvK1gepJzxHx95k9YUsq+7ro2dibLfmGIuqij7S96reJkkAdITBExydZCfESVuf32/6cj7qFlTRmNwZ91K+EgFPxR/eELsXDL99j/6CTsUIuTIRG7mT+y6kruIWriogp+8JxyDcVAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783069063; c=relaxed/simple;
	bh=dWBB8QHWzV0smXiNLQwKYnR7PGnvKRc6FyXeEmLh38c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XQ4Pw2cZYALZRVC9qr/l10TNPKzkBVJw2I10GaTHotCxMtISL3qByazTNirnG9GogB20z8P1Uzfo1Jeq3LcIf0dVqy2OEH0L7Sf9QqPuDqZHg9jZvfug3H49JbmVqwN0+NfWsz/RA71JPqofci/nuf25J+QNr2dS6U0KW+CovkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hMm8lBFk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XKlUoR9H; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6635rfCj3136145
	for <dmaengine@vger.kernel.org>; Fri, 3 Jul 2026 08:57:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TUd+sBdE6ArmNncIlX7wMKayRRbzXx25rT/FYuJHI1I=; b=hMm8lBFk66PCdT6U
	BVKqFqO6el8z19lQ8Zdg5dx/X4axaBsp86f82xddAzMDKpJL7fOVkOiJIfFcpiuJ
	MpRP67hQCaUIUoHzDQAP9PlBYyro0Wyh4FWdA4DsMMFOgTkg7hs4ggYK/7ri3l/E
	Sk5GF3frlNrDxHsgn4+90wh+pfW5wNq3nNpDMg5eaXhVsRF6BCuhPDVCZdo+zzqS
	cQaBYzT+m171mxV16DM3j+xCV/oKf8vu2N64XXByjakGiwq+H59U5oYQZNq7LKLf
	qFNHcd/sX129k0uuxS5LJXfbPt92Y2D8W6pWB1ncrR44EoZoHhVdlRsyDJQAKBvj
	bWGvTw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f64b59gvp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Fri, 03 Jul 2026 08:57:42 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c07313be5so1105341cf.2
        for <dmaengine@vger.kernel.org>; Fri, 03 Jul 2026 01:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783069061; x=1783673861; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TUd+sBdE6ArmNncIlX7wMKayRRbzXx25rT/FYuJHI1I=;
        b=XKlUoR9HPz6BeM1AJIqSuiVDeADP5lGYVUDd0poSMzk5VCDnKiMtXmax22kfit+LdT
         c3U8hX+AewGkvE2j3zX4swIrxlHGt0B3azsFd3HbQ5gUTJWlNQ3LSD+WoWkcCGYhkWEv
         D8bh88cj8QtZOwnCJn2OQcK1z5ULU6krrI6gvYV/c9gbie5vYORqEMNOy15bxxnFsFDq
         khUe855ITZa6+/lCHCxOaXyLhPFdLlNSfOZNLgSdq4eX4OTL1JyX3lB+7Ox8c1Okuygu
         t07TR1jlzV7iZs2qDm8QJGBG/x0BwE/7hW7Z+tro38vs6FAKGQKpfUnpzrwc0JDXgpwt
         8BSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783069061; x=1783673861;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TUd+sBdE6ArmNncIlX7wMKayRRbzXx25rT/FYuJHI1I=;
        b=tJ/m+9OCtHNXe+mVb2yezDuQwTEPSqTz50/aPgosXpEHdZxr/Mz5mAxjNdiea6vUz2
         l55HZ7mdBEmb2cryNCu29YnD4Ym3k2i+0SOFPqsnKo9IHMelFyomzF6EIyAHxK7eBGeU
         /5Xw1uhztxuHn5f1wpei5PCb7YXz2tUN2QZTBUiGwLR5zxPM3tz4AdRR6cKJpi4OKk03
         wZlHRRNo2sHWWfVwP0a5SvOIKhDQI2wJlEREGZ10f2w8i4XBjcTMDahqriyyqGI2htKO
         C9gaOfNK60QW82QrSQ9s9SBs3AHRpsJVPbsQz+ArXw0DcsQ+rozpvsOt469Jn9kgnt1m
         dLRA==
X-Forwarded-Encrypted: i=1; AFNElJ8DNMp83WlufFohQ3zUz82aUn19NsfQLckEDKJsAbTipwb7Nts06Aka/2f37UM/0n6jOavzsjFHXBk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz46ntLF2jiBnhuVpC/CJlCsR3bkKP847Pbfg7XdkUYgZ/qivbI
	0Vz1B3+BYx4FTkW4ViRGMeEVngnAaWxzmaA2ANuxeGK3GH8YVABcH/ZhF4Iiu7pjjwrVyIDmwAd
	BvhxQmW/ZKk5a/5coyH1x9ZFcjaV0i39F+Gb7g15tB1M0qRtyx6K7hllNIyb3ZV0=
X-Gm-Gg: AfdE7ckS66tIXZ9OV3Eo7TKZzH36OC/1be5aa5/7CC9zWBja1X8WSTtlgMCOywT0vb+
	fdtUHdJ/zGWts64WQvLBvee2ryygkVXLW2+34b+pPpFsMdGrt1tJ/faO9sfr9vCHMRPWCDrr4RF
	9EEJ8w5xS7xBbCxL0IE9/j6gI4e7XDFT6k656Jgkxn5CJj+v0xEKm/w6oJcVos2FewHhrRtbEPb
	K8xaizlM5il+5+T0XSMP2xekRI3ElUqdUY8bZ3CTLBOGHshQpNykfnahw15TeT6+8/KodVA7fYJ
	yWvrEs0eesQgmmQbfMclJpbiApwSI547I8ut8RJNAtTYHd7MmI3YyZT+7B2pKFs98DcU1zMq7LE
	CAFqb5itfZm+rGu+mLGF+evmfLnZnCedddtA=
X-Received: by 2002:ac8:7c51:0:b0:51b:f40b:2faf with SMTP id d75a77b69052e-51c26a7769dmr76953921cf.4.1783069061104;
        Fri, 03 Jul 2026 01:57:41 -0700 (PDT)
X-Received: by 2002:ac8:7c51:0:b0:51b:f40b:2faf with SMTP id d75a77b69052e-51c26a7769dmr76953791cf.4.1783069060725;
        Fri, 03 Jul 2026 01:57:40 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b62fc72dsm256179766b.63.2026.07.03.01.57.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 01:57:40 -0700 (PDT)
Message-ID: <0b182566-2a54-4e31-9a1e-40bdbb0f4a65@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 10:57:37 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] dt-bindings: dma: qcom,bam-dma: Increase iommus
 maxItems to seven
To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Konrad Dybcio
 <konradybcio@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
References: <20260702-b4-shikra_crypto_changse-v2-0-66173f2f28b3@qti.qualcomm.com>
 <20260702-b4-shikra_crypto_changse-v2-5-66173f2f28b3@qti.qualcomm.com>
 <20260703-steadfast-greedy-seagull-ad32ab@quoll>
 <e53f9b7d-66f1-4922-ab20-f6e66015c912@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <e53f9b7d-66f1-4922-ab20-f6e66015c912@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA4NCBTYWx0ZWRfX2OaOd3HmKqOk
 wgNXT83TFE873WSSWiRokE23dXcCS4V69h7Mx3gaMVgVzXKOpVZR/iQvVQIfZwc3d1+I03m8Pj/
 OgCLUY5L/5uBM+NP1BTLme4ApTMc06g=
X-Authority-Analysis: v=2.4 cv=FOQrAeos c=1 sm=1 tr=0 ts=6a477986 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=7f3yg-VG_fZZVZRDPQcA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: m2Amk5yBmGK8030QIfg-nItHJWzWt3CS
X-Proofpoint-GUID: m2Amk5yBmGK8030QIfg-nItHJWzWt3CS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA4NCBTYWx0ZWRfX/iIjTLCH3Zl3
 MLmSS33twYXN7UCXurzeXENpxhT5isS4KlrnM/32yqh/EsA8BxzuwAEmxl+Hhn3Gh4JtPvJQMXp
 YZm1nubgTZWNJ+BIBqR7Ziy+9xRScx6yHwHs8MVfyDPWD1B/AjBexhG5XULwtCiWecS1WKmxb3U
 /h16yn/6b+j43wCqopz7Fi/qqATZcFNnhDcYebz8/0V6rT9pwNcEjaVvKy25uwNf0Zi7FNDuVDS
 MNrnvEBd5JczRgkw0P9Afxz6L1oiQgLdmYcasFdBWHZO8xRxBWYxFIioMETAddxTMmhfL5J+s6C
 juqwBzAomG9SwSChktNdg1c5XvM+WTi/At9O5XKz6A1r4UVNajbw0O2wNIf2NW5/EfWhMjfB/AU
 t9FgwThZzk801YlNXiogw3+a/9LnbplKQUV3Neam9CgA/sJomZY1ouSGNJ6fEzedKbmGJ1GWjnI
 cpko5tzKNL/+4t1TFZg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030084
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12026-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim];
	FORGED_SENDER(0.00)[konrad.dybcio@oss.qualcomm.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_RECIPIENTS(0.00)[m:kuldeep.singh@oss.qualcomm.com,m:krzk@kernel.org,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:harshal.dev@oss.qualcomm.com,m:vkoul@kernel.org,m:brgl@kernel.org,m:konradybcio@kernel.org,m:Frank.Li@kernel.org,m:agross@kernel.org,m:krzysztof.kozlowski@oss.qualcomm.com,m:linux-arm-msm@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EA0627005A5

On 7/3/26 10:38 AM, Kuldeep Singh wrote:
> On 03-07-2026 12:24, Krzysztof Kozlowski wrote:
>> On Thu, Jul 02, 2026 at 01:47:15AM +0530, Kuldeep Singh wrote:
>>> Upcoming Shikra BAM DMA uses 7 IOMMU entries and not 6, so increase the
>>> `iommus` maxItems constraint.
>>>
>>> Fix below error:
>>> dma-controller@1b04000 (qcom,bam-v1.7.4): iommus: [[25, 132, 17], [25,
>>
>> There is no dma-controller@1b04000 in DTS. Please drop all the warnings
>> which do not exist.
> 
> Kindly check patch 6/6, it is introducing bam node with 7iommus which IP
> describes and hence, updated bindings before to accustom this which also
> helps in avoiding rob's dt-schema bot error.

Krzysztof is saying that the error doesn't exist in the tree (because
the offending DTS hunk is not merged), so you shouldn't claim this fixes
an error, rather that Shikra simply needs it

Konrad

