Return-Path: <dmaengine+bounces-12355-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id n3I3Nu7XU2oGfgMAu9opvQ
	(envelope-from <dmaengine+bounces-12355-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 12 Jul 2026 20:07:42 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 70661745993
	for <lists+dmaengine@lfdr.de>; Sun, 12 Jul 2026 20:07:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=Os1X52Gv;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=SJwrTbjX;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12355-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-12355-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DF80A30028B1
	for <lists+dmaengine@lfdr.de>; Sun, 12 Jul 2026 18:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9C33659FD;
	Sun, 12 Jul 2026 18:07:38 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535AB365A1D
	for <dmaengine@vger.kernel.org>; Sun, 12 Jul 2026 18:07:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783879658; cv=none; b=UaJ3q8XSwMN2Azn1UCGLCXttWJJsmDdywguPqaluNYd3ITv3M8uwfV0bg6bkeXpry6/OjfFN4+HxXArpLbk8pH4KuGiaVKVnRaI3XttyEyIHLM7wAyqMgLnkpaRl9C/WRfewVszRxt8Ev7oV6K7hLkEeOwFYJVqD5zMixHbiypA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783879658; c=relaxed/simple;
	bh=C2XR1xDRNiX21r/FCy3HxMDWvtan9TeVXkb/Shhz/BM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=glt+7dn1Ed5oG+77iJd3UmPvrUt2S0Z24G0Yb9InRysRs2+19TkoOfmHiGXav+kbjbwca4U+JvWziZYMKaTz+r+cEWsuYSnPkyt8ZWg0AzOINHLa1aEOM9fsJ2silc8ZMDGizsAnne7OSCGW5pQmOFV8+a0uTVOp5OSDPX6Ikgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Os1X52Gv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SJwrTbjX; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66CGsFMc3010459
	for <dmaengine@vger.kernel.org>; Sun, 12 Jul 2026 18:07:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G/b/zf7UQ7sTa2shIGd1d0rcQISGwGw1nhvIskhwF5o=; b=Os1X52GvT5VrnrF6
	1dd56lRQyKEyZVybVYvjJiI91y80kFH2FqmQnPjdwmJXuKh1OYXz+aQiCf/oxUe+
	v6IeTCoDqG6s1RXqBSfDA7SPfC2I5iW6Upgz7vSklr0qa1yB8K+ivrvFVvePh4FY
	e20RIzla1VxJJ8H4BEIGBBumUXPVzyrxtToirWXCcCnu5lu7e5fv+1tg3Q70WNUc
	ucHTqiO4Gp+mZqkM2IX/45FYO/JhkNEMZgHTXJZgRZXX6jhBKZXW5eESa0G59iVV
	mIAOwDg632naAM+uQ7Vv5bgZvwSAipCB2LTdVek5jN/vV/aQRDqpvbodk1uSoXKp
	d3aEjA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbekck85f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Sun, 12 Jul 2026 18:07:36 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38dc101287aso1822854a91.0
        for <dmaengine@vger.kernel.org>; Sun, 12 Jul 2026 11:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783879656; x=1784484456; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G/b/zf7UQ7sTa2shIGd1d0rcQISGwGw1nhvIskhwF5o=;
        b=SJwrTbjXDbf4xE6u1JFdwkpxfS/i+X/0v5hnB+Bjm5IcSV5mq2mqBBGHZ7teJZ3v4+
         5AzIzJygAXTs19ySpQQUbb9TcsZeeWWabb5iBGoSUN/bw8svcoTjzzpYXfhdfhrCDO8H
         Buq5weJvoeMR+JqsQrBQ8MFS00SPpJbeYGt2rTeDJL/JSA52/oAR8WmcGZJ1qSBoEd3t
         cDkVRLBj7Bj1g4i1TPAEmpQauXhObsmOw7oGoN7M+2VB9nV//DotHe49QXz83DSh40xL
         jw6hfEOK2+WtNV6G6PqFpBjsJgCGnCtcX5KjpN7VVObJjjq5CqhO21xR1CYOOBOBRnRd
         NSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783879656; x=1784484456;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G/b/zf7UQ7sTa2shIGd1d0rcQISGwGw1nhvIskhwF5o=;
        b=sahhLQVe/wvwvD41alFx+vaNzDH+oZx2OAOrWA4FhLSux5UuQj17XRs+sIubJE2ImU
         k2xDnlrhI1roCnzq9migoqgqhiA8qK4oCYOmMbrBHvru/ooDyLhbB3q+WtC3x6FhEbfD
         uY6LctNhGa61C4CZYVTQBeYz9phSMjZs/afb37sTP7Vyk8zTHYe42IjIEjZ/lBfvwhMg
         TMKh6mb1ao0uhHIfroRt307TE47BL99e6eUx/+SxpyREewDmpFrlem3x9vy2FbTvCZME
         8Cr2Csu4D3TYEC0WRau6Uk+n4cpvfMB4zs+cNPvMKWwQgT2YlppxEm34N0JO9uiKu6VI
         qgtA==
X-Forwarded-Encrypted: i=1; AHgh+RoslTc2LOSH4ohkwJ9l3PzRfJn42cF/w9g4U+A9zYwe/vsi7nh295XvIVQNB980ELEQP4eHWg630Lo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMTtRbl5KdhTUg+PxU3A1mpgdVgkEERLZNIO4Zq8tf2U5Rxaty
	S64eyN7cyBz6c+IyzYqbjpqiGqjRNQLL4LFWGXV2ynCnto2+jIUKgxPYp3iXXE6KIQab8RTzB66
	EisPH/Aj1Ni8hsEAjolnLMDISp6OPTaY50jvAvUzun97sXjOcE8KSl18Jhzsmb+c=
X-Gm-Gg: AfdE7ckoytsTUYWRUjiAUOIV7RhgcUEEenBrecW7oMOd7ViwtBzsk5HhgfenOpVXI2h
	4gqabec9getFv6FXBWxGdgwKi1W8JJc0t3P4PthgE6BlJrrHuQGFEGPTsWO7F+Uls2mWbPFY3TL
	qj0mK7l/1CsTPhY9aErjxqsUKuCho75h/ZINnT+CJdltjzDd/L/wK9rIYyUNB95S7I31HiJFq+I
	KMWdaJqKKTSMbmP811f3t4JES/5Nh4oRrQsqy49ejum8AQXdNftgZG5yhZKVy1A4FCrRcAvMnak
	Ertvv0751j//NTm6qLATRZP4muNGXMrlBmic/wz5782e19QN6G9fr4uZzRLKdyf0VF0MUlG0cLU
	okQLH/BE0ebs/jCuV2lp3Xijc+7Iq1HsSY5wCfGgA4w==
X-Received: by 2002:a17:90b:1dcb:b0:387:e0cb:7f5 with SMTP id 98e67ed59e1d1-38dc784208fmr6721462a91.41.1783879655925;
        Sun, 12 Jul 2026 11:07:35 -0700 (PDT)
X-Received: by 2002:a17:90b:1dcb:b0:387:e0cb:7f5 with SMTP id 98e67ed59e1d1-38dc784208fmr6721442a91.41.1783879655488;
        Sun, 12 Jul 2026 11:07:35 -0700 (PDT)
Received: from [192.168.1.11] ([171.61.104.87])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313b4b97661sm28896575eec.7.2026.07.12.11.07.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2026 11:07:34 -0700 (PDT)
Message-ID: <d9b63658-b588-4103-a247-cdd78910a89c@oss.qualcomm.com>
Date: Sun, 12 Jul 2026 23:37:25 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] dt-bindings: crypto: qcom,inline-crypto-engine:
 Fix legacy/new SoC strictness split
To: Krzysztof Kozlowski <krzk@kernel.org>
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
References: <20260706-b4-shikra_crypto_changse-v3-0-23b4c2054227@oss.qualcomm.com>
 <20260706-b4-shikra_crypto_changse-v3-1-23b4c2054227@oss.qualcomm.com>
 <20260708-splendid-outrageous-saluki-aa52f5@quoll>
Content-Language: en-US
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
In-Reply-To: <20260708-splendid-outrageous-saluki-aa52f5@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEyMDE5NCBTYWx0ZWRfX3ls0qFAilYuQ
 b19HFIY59yUnkjj+O+P26Ul65Ta0h7t8TqhgK7Ul9RnEswccv8zxt+wg85vljbj2v3OWwy8SHKS
 p3qeFaycFI3xc4dyiicoZtwmvAuOZIC1lO81prtWx2TlY/wAiPKx0zic/XQCuST9NDpw81ANi5n
 X1jVQEbHpx0J8elWirOpqQ+ulWn/evCGKFpgrkDEV3UrP0i06xKV45jjqvFxBAS+jViMUWY3/bM
 ejJOEXeDMMKLB4DqvJCTmazuYP4SSiMi6zXIak3hUcg/akw3hlMD+bclPGThb6ATF7VKT3FiLcc
 WRfLkr9131MxF65JsKgjju3dx+h3iz/QZEGAZLlNjy/9MEBfltDm2clkfKXy8VUOwb4ZEMN+FlY
 7M5hFwpSVFhXYOrA56F+Xr/j+RQlgIE9lgz2HRyPSW71QOQAF4MXpsRg+7dK4XICAXBce3WTaAh
 gPFCDbJnXSRTT4MdJQg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEyMDE5NCBTYWx0ZWRfX3Ti5letP8ua/
 XS3c9gLaxHa6kCAxXirP5CUG5MoY9KbJPZFfBP+UofX7lXeqUM+Qix/L75Pn8UDxjyf5LqeaSr+
 42P/INt9Lx9ZfcDRtXXMERenxn9KWLc=
X-Proofpoint-GUID: Mq97t0tC08KHH4sKeO2JinsY_4rR7Khh
X-Authority-Analysis: v=2.4 cv=XNsAjwhE c=1 sm=1 tr=0 ts=6a53d7e8 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=6xD26CRXxLrCpw/8GpIQFg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=rLjcKV0j-uWbYnTTcGEA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: Mq97t0tC08KHH4sKeO2JinsY_4rR7Khh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607120194
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12355-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:dkim,vger.kernel.org:from_smtp,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FORGED_SENDER(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:krzk@kernel.org,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:harshal.dev@oss.qualcomm.com,m:vkoul@kernel.org,m:brgl@kernel.org,m:konradybcio@kernel.org,m:Frank.Li@kernel.org,m:agross@kernel.org,m:krzysztof.kozlowski@oss.qualcomm.com,m:linux-arm-msm@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
X-Rspamd-Queue-Id: 70661745993

On 08-07-2026 12:13, Krzysztof Kozlowski wrote:
> On Mon, Jul 06, 2026 at 05:01:29PM +0530, Kuldeep Singh wrote:
>> Couple of already merged SoCs(like sc7280, sm8750, kaanapali etc.)
>> describe ICE as single clock historically which are recently updated
>> with mandatory 2 clocks.
>>
>> Keep only the known legacy compatibles flexible, and make strict
>> validation default(of power-domains and 2 clocks) for all other Soc
>> compatibles.
>>
>> This ensures old DTs are valid while ensuring any new SoC (like hawi,
>> milos, eliza) must follow latest requirements by default.
> 
> To re-iterate: You change the ABI for Hawi, this must be expressed and
> explained why.

Ohh I see, hawi is different case(compared to milos/eliza) where
bindings define the compatible but somehow was relaxed(got missed
probably) from 2 clocks recommendation.
Just hawi compatible is defined but no DT entry is present actually.

> I do not see any change in commit msg (listing "new SoC"
> is not what I meant is not relevant here - it even suggests like
> everything is here done without impact).

I'll update hawi as separate case in commit message to reflect properly.

-- 
Regards
Kuldeep


