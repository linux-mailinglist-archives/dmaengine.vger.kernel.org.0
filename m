Return-Path: <dmaengine+bounces-10111-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEJvNSFc62lGLwAAu9opvQ
	(envelope-from <dmaengine+bounces-10111-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2026 14:03:45 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FBD45E284
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2026 14:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1F6C301683A
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2026 12:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281E83C13F1;
	Fri, 24 Apr 2026 12:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IaoJALgQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DzfPZly5"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23D336F414
	for <dmaengine@vger.kernel.org>; Fri, 24 Apr 2026 12:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777032218; cv=none; b=oi4l0rJ1Uy4nWdXDdRylD6XrQdBZXacz5yQQB5Kx5X03Y/M7ByW2ylaiqLHpmZiYjqFKrx6hyT4an0C9dz04POjEffFmb3fzUeuCZvEDU+KpkKCDieN5Z7M/O6RocLiCow8A9Lh5DxbRXsr7ipwrg1IA6b5vula/+wB3bTLVrvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777032218; c=relaxed/simple;
	bh=P03y8Cz/PQho1qaJY+z7AEvcB9WS9ziyAKvPnj3HDQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HCBme3dBazIoMy0xzy68OYVgY4jzzmiR+DETxEQ7NPIKg7hYfsOxtA+gKt5PTnpwkg27u8+qMWfxEB6pccTX48/zUP7r3wSMN/1L6EkitGNOTQjjPw/hwRXZoKr/13Y0UG/5XyJ7u1Gl7T05Jro/qjAvSOAVL4jXHY5G6Tp8vng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IaoJALgQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DzfPZly5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63O7Z9L74167705
	for <dmaengine@vger.kernel.org>; Fri, 24 Apr 2026 12:03:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UqYU+UVD7SqbPk43y5btMoFYViDdfcSDL9l/g8yShPw=; b=IaoJALgQ74anwTfS
	qnzcMCSb9cSiGZB5L14Gt6WN9GPIkXtjkpy3yh/+Prl0nhegxl+oEAu3V4x4pR9B
	nZFFt+aTha0RYuOi1tR3b49G3Vmwn4DOCopva/o+7aaHE2FQVEJlHxBqHWZRFrTk
	LygjeliOXF4YU8UWRl+mHuXAZm3QSiOA0yw1r1/GHdMicWq0+B/ZkCm+m2OvUFCX
	JM5KSg/YTyxVibTDISaCyDmD0YZeO1qAVYCfykn5Skon28TRTUgDIHWsSrNqTiPU
	2E7rzhcsR6KOKqDpLI9+6yn96QT5YfnLM6QVWLkTbGww9jqAIEAk86IdABczP4gA
	586/zw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dr48n18x2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Fri, 24 Apr 2026 12:03:36 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8d45ebdbc9fso156236285a.1
        for <dmaengine@vger.kernel.org>; Fri, 24 Apr 2026 05:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777032215; x=1777637015; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UqYU+UVD7SqbPk43y5btMoFYViDdfcSDL9l/g8yShPw=;
        b=DzfPZly57mHccVfn2gEEQnpr7jfLrjGtM6vLXovz5GdJJ83F5sk4IplaG9AnoajV/M
         9OJaJIWqMjNMHmus5n9AJMoGKLuuJwPX5XkedMScnxdVGBgNKv4QopmS8OZh3Daz09YT
         GkLu2vxkh1ECAcoXslJT+BVGb5iLyikiXzq+4PA3Kiw8wtiadnByakx2V9T2UH8s+Jkr
         x4gK2TIAfoAirE+jl0FskmeOawniq9vMe2J5VjBzcP4ZC/J/BDVhleHkuiZMKb4IziPE
         O7180PGRKcmiLvS/DwVZnDDErwIiSLC/DPeTQFUfS4lOAbzw1NnyDgPLEPkfOCNMO3XY
         df5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777032215; x=1777637015;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UqYU+UVD7SqbPk43y5btMoFYViDdfcSDL9l/g8yShPw=;
        b=JIRf+9lopc3sXCs0BMs1wT/oEzBXIozXzESptwZglb6gX9syY5w3GtRLHGobDnYAnU
         98d4Q60vjcbptawvIkLCvcVpiTmhNcxfEtR2ZfM3Fh9rEy7V7b67PBY/WBkpkSAkZP3t
         fGdJV0yG33Bm0UEW4CxfxOdSKAHORH+FfRS4vSTf0M9+vR9D0eECwC8vCnu6/vt9xk1V
         o2pYH8Ma9F6CyHanb24FyFA2Q3yAezQIUFx9loN0NQaO1eRH5wgul07GxHIlP+ZbEitZ
         FKI8oZd0hqA904lWvKpxKE/K0ygt7/8tzjQbXtkFHma4CB5emFuYoxpUyQzyp1U0yZJT
         Dsag==
X-Forwarded-Encrypted: i=1; AFNElJ8W5jFQ2C2u9cohxDFlBPidEEL9IKH4liIf5Rdw2eqwwa01f7l6qLhHrISWTtM163FPcmu7SikHWj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmMzgZ+HBvO1tDcIN5lnanjjGKinnvQihCKHETqzAJkASR3Lyp
	6FrXbChzqnEbZDlES8h+L10W8LaBp8moYhgGwTQbtN6rEynjvO1sTDLc5iNi++eIfPhyUuUKio3
	ecrioWXDlhHqTA2z/9QtGoVO9sKFdNetrC+6lNl12RZgmfv3iHH3NDSAWj1+cdETS6mw6gZE=
X-Gm-Gg: AeBDietoBiN1XhScocXpxGuT2JDDOGS43p3LQhMmxi0d49V1ETP4h2XEyC+94s2rIt1
	mfCdyYhsmGXjtiscJqM5q4GIoqQvXNkbu1vpxOmqHmCY6d4uFgbSbRJmh0N6ss5GcCp7T7FN9Qk
	UMCFtPVfmBlm5cZL1k7JFxYDXFMSvKlnMMal+urzhYvWbUxTkOxxstmD7bvqKsaBqneAmc6JZci
	FJhfTM62OOvdD2fBu1zusxMw6LNfC7iyim0K4+pbFG0BOr/tm0uiqOPymsOf6+OOvA5vYKCfaWL
	/YwBH31RvY/xK7LMSV7oH15ghEIYgDR2V/tDlRCe5C98R6Jl8IEEnPIrERkTa/o0r0jDtM30JP4
	hU3EOeZ71lUlVKKUN2+WSlkWkIgg9QeKW627bTkovPlTYKWBRa8B+KGnepmVF4RUZpI3IRFNeGn
	AZzKDrqu+Opr1gNg==
X-Received: by 2002:a05:620a:2ae8:b0:8ea:c7a8:5065 with SMTP id af79cd13be357-8eac7a856ecmr1607169085a.2.1777032214986;
        Fri, 24 Apr 2026 05:03:34 -0700 (PDT)
X-Received: by 2002:a05:620a:2ae8:b0:8ea:c7a8:5065 with SMTP id af79cd13be357-8eac7a856ecmr1607165885a.2.1777032214518;
        Fri, 24 Apr 2026 05:03:34 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-672c4d51820sm5008447a12.22.2026.04.24.05.03.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 05:03:32 -0700 (PDT)
Message-ID: <4d1d71e2-18e9-4262-9dbc-4e05cb17d5a1@oss.qualcomm.com>
Date: Fri, 24 Apr 2026 14:03:29 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: kaanapali: Add qcrypto node support
To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Harshal Dev <harshal.dev@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260424-knp_qce-v1-0-813e18f8f355@oss.qualcomm.com>
 <20260424-knp_qce-v1-3-813e18f8f355@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260424-knp_qce-v1-3-813e18f8f355@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: tCHnFgzgPC_fELYV26_33E2ML5jB5NM_
X-Authority-Analysis: v=2.4 cv=VOjtWdPX c=1 sm=1 tr=0 ts=69eb5c18 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=Vc80FJqyMH11bIRubAIA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: tCHnFgzgPC_fELYV26_33E2ML5jB5NM_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDExNSBTYWx0ZWRfX7kpDlRnCmPqa
 oB4J+58Fi4N5xxYPQNc61dPxTKzblGMMjByL4MqpgTQnD6b6mP4rqSbQs9/Cs/CbjrT2uc98mlj
 bkkwr29bbIQ8vnH0QI3ifBSbIXtrMcyFcMlKdlxPS9h5K/TLJo1t1tefENGZFJS1n3BmwHwyFA7
 IhD0SE64QRAo8jjHjYMYZfqQBY4zspRoOwqC+Bf0w5rsK7EoenqyYmjfp2cASNmb5T6pfWdR79u
 TrXypv66MX6T9aX/kQ20PnKGnhvQOeKtjk7MhNzHd6BmbC+txjWjoRRqN8VLVmTjFWAw+BVJ6Dj
 gllMzrWQsCyV+DBwmlZLeOZRKMlgyiQbQ5Ntcv2xgvgkWGlKTWKJroURtM3ZYhAkhZvkIDwmki5
 4jdQc5iOFbtUBY2zVH+dpLaI0pNK99Oj36NXs3EoEQNX6AWKOQvJSSAOFnUY9sy5VpkfEee1FbH
 tCDk/QBCVRR/LwUAQtQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604240115
X-Rspamd-Queue-Id: 98FBD45E284
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-10111-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

On 4/24/26 1:34 PM, Kuldeep Singh wrote:
> Add qcrypto and cryptobam support for kaanapali target.
> 
> Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

