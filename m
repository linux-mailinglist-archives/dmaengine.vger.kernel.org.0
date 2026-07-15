Return-Path: <dmaengine+bounces-12550-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2Qj7G9p7V2pVPAEAu9opvQ
	(envelope-from <dmaengine+bounces-12550-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 14:23:54 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BD075E0CF
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 14:23:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=gUlhy41E;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=YiDiEOpn;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12550-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-12550-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 19D64302199E
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 12:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A13344682F;
	Wed, 15 Jul 2026 12:22:37 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE908438474
	for <dmaengine@vger.kernel.org>; Wed, 15 Jul 2026 12:22:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784118157; cv=none; b=VADuYdheUh9wcMvSzzJTv7x588yPi1Daz55Kh/4yu5qtMKMAwm25iGtVo5iQx9/+Rcva6QKxv7RN3+mKCaCChcCKKywU0583vDM5Y4QwftthrI0729wCLCq0F0z9bBJEF6BkjU7IQRtnOrb7WQd+Dms5B3O0uRNpiyAzab13E7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784118157; c=relaxed/simple;
	bh=PZa+it5ln/dZYcDQVhHQXLPvxKtKTwctIopAUS1NAD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u6yJnMeWN/M6VSaBtlwszturGSB4d6nEBbS6cP/q2Ra3EKt1T24aRz1X3K+NfA/UgBWsuZ4o/y7f6Wnz/PLLeSN26hwqn/HEDxlWJt6Z/PVoIijf+IRFU6cOEruf2MSHtNdTkdRX6QNGnPYeDXEgFyibh80v2nRoiRDYm8xn6pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gUlhy41E; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YiDiEOpn; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66FBcdiq3480060
	for <dmaengine@vger.kernel.org>; Wed, 15 Jul 2026 12:22:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	b9uVtnp4ftgJs/XKrszPRlmmg1Es/wCizqUifj6MXDo=; b=gUlhy41E5kpGea3a
	BB/5TjJubdLBbShBspxaioRA3zRpyuDaKtkVR/wpGTPVFOFfmDQ5VJnluUXqLBoM
	oNWPHNhzq2VZK1v0u5HynxX+G7Pk0W96tCUXdZdLLFcPtERI5rZiY0nCPJj4Txon
	wGIfNPgYbygwq4ldkVQlvR77PLCsywATtUe7pTGRY5kVZdDewvsUVQQBM8lcqFs7
	aQlBBPIXbxL5X0AMHKVOaS2yyHVcMkRjkAB9rtJ26gQLEdMvY9sa90T9+7+aH43t
	ehYUjxSrz7oFz8oCmJV9TgrS5o9mvj9JFTgZN8utN/faivcBtBnhDb5SK1xRbtuQ
	RZrx/Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fe56h99v7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Wed, 15 Jul 2026 12:22:34 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e661ce1dcso98542685a.0
        for <dmaengine@vger.kernel.org>; Wed, 15 Jul 2026 05:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784118153; x=1784722953; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b9uVtnp4ftgJs/XKrszPRlmmg1Es/wCizqUifj6MXDo=;
        b=YiDiEOpnIX6kUmKqJ6UeCTr31JEQPSPMobQYrqFC8yvrQzLIKtWk2X/GrAjTiQPY3k
         i6vIFkQ6miRAIBpQjlZKQtGha7V5vfsBIAx1+zHGdxliaCmjUBnZhAErOz0XLhdfi4QM
         Le/wwF/870k7kEdZBd6rWM6SNOlllMcpnJhaXYGKcVZVeF5woImzVYJzW8u7W535+2BF
         TLKq103haV8/8Qs+e91yc7SaRNhGMwqrCCon62FU54K1xnzvY454lnzCmP1jsfkZbubb
         EaNAHdBL4ph8wiB7NYTFPNS50WsFoQvQOaqBYZkIhDIcgeANg8MOLjs46H5oVwf1Sm3A
         wwqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784118153; x=1784722953;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b9uVtnp4ftgJs/XKrszPRlmmg1Es/wCizqUifj6MXDo=;
        b=NOzwePl08Rxw5fLO7Ka5Uyc1P4Kysq41tztqUVmh6HZ27mAzeS1I35WTjQ8QHvI1VU
         KQDeoJlNxOTuh64wck0/EoP9KbiHnKX5xdV1tCXwJAmMvk6e3cigekLJdMJNrgHEV6n7
         YOl4X9Hz/113N86JX9RerRJRcaw2Y9Z/m4R+WvRrI8sR9niTY0yt8k+lAjqNCw2Hi3H3
         o5ITm8kMJDO2Aohfo4Nq4pTvw7HVKHeqc/kCOLMUtfa4m+lOGtT2UCH6jTXcIm9pXqlv
         mWKyDJDB+hpg30s5NLkajY33Om2+bILk3C4KLDeR0HoU+gM7kSdfTCGfq/fiCSD14keJ
         eMxA==
X-Forwarded-Encrypted: i=1; AHgh+RpXCZ271gkiAlw7z7IDOoqCsOLQImr111LBQZacCH+yfo7Xuk6UIuTJUM5l1dSqLZSCz6l2XXOEg2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT8Wq/cAXFV5iT/1D+z+htowFeSN38MTIuOCrvTK5Va96lV4LI
	brd7ZzYHrQpV86X6gZ8wfIUeHCIj9MutJIiZIQYMgP4LGYHbL2M3LDhvqF2qSZSCLRZwagd5+iL
	rHFvxgv832/Xw01VCAhrJabTOiOlfDksILdE6OemtvdABdBViAbbnFLBSKaVilTU=
X-Gm-Gg: AfdE7clCPc7F3sXeAA7n5MKSflg960oAArtxn5F20wlatKjVGVtVk0jNNXrFbrZfXAd
	nuc2iqKBlOVyIpu6gDjUJH8iIo0DAvZg+xMWpHN+mCTTv0vaHvi3WtlygbMblBgepeCNWvWgC5E
	3HtmRDNID4RwToGy5bqJYkfAl4ANkl8KVEDT4PHcTfNe9RECDu9BSHajzQB8J90W7F8q09jpa+s
	17ndOa8vJMrA58iI/k1A6/W/YtUjs3moaMnuUnMAvGFiivLEMM0AWTnSw6PIW9aI96T6FwgEiKY
	UUPruBtiEHhOpOo1YzqXZVG4F27qKPPDKNl2sd0K8dmkU4U8u58Mbwz8MAcub3JIkV4Oyn44Rz2
	tiTPj4nNiBQyYu/BZ+vtGFavNNC8aM1Vmw6A=
X-Received: by 2002:a05:620a:458a:b0:92e:46cd:7299 with SMTP id af79cd13be357-92ef2c7f24fmr1309036985a.8.1784118152924;
        Wed, 15 Jul 2026 05:22:32 -0700 (PDT)
X-Received: by 2002:a05:620a:458a:b0:92e:46cd:7299 with SMTP id af79cd13be357-92ef2c7f24fmr1309032085a.8.1784118152346;
        Wed, 15 Jul 2026 05:22:32 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c168744bdddsm15401266b.48.2026.07.15.05.22.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2026 05:22:31 -0700 (PDT)
Message-ID: <c9ea2930-d12a-4445-a2ef-3907597ccd86@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 14:22:27 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/4] dmaengine: qcom: gpi: Add lock/unlock TREs for
 multi-owner I2C transfers
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        viken.dadhaniya@oss.qualcomm.com, andi.shyti@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        vkoul@kernel.org, Frank.Li@kernel.org, andersson@kernel.org,
        konradybcio@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        linmq006@gmail.com, quic_jseerapu@quicinc.com, zhengxingda@iscas.ac.cn,
        kees@kernel.org, agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Cc: krzysztof.kozlowski@oss.qualcomm.com, bartosz.golaszewski@oss.qualcomm.com,
        bjorn.andersson@oss.qualcomm.com
References: <20260708051023.2872304-1-mukesh.savaliya@oss.qualcomm.com>
 <20260708051023.2872304-3-mukesh.savaliya@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260708051023.2872304-3-mukesh.savaliya@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDEyMiBTYWx0ZWRfX/QLngdrhKz5W
 Kx4lsPdQWOZ8BCdqRMYeb6FoaHBe7Zz0SpEW3PNsBo35oBkKDsdj+7YKVDbjfdf2MUFsfr108HP
 Gi/GwUDEDB8wBKwHsUuwfXEwJJjP+gY=
X-Proofpoint-ORIG-GUID: ikctD8RAWTApecIKTBR1d86Vs-xPMHYC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDEyMiBTYWx0ZWRfX3rhWDmrKJZw1
 IAvi2g4FIQ98a8sX1nNS8+EuTfvtXdaKw9yK8zcCoBwQSdvsRleVdaskhdxWZTmJU9q5KrtrmWt
 6LE3575xMz1sG7FpABthe3+FkfhqqAEFJkEungckj6QPjjfRQBbXYzd/JqnNOw8yBpL3Oq5i1/3
 6+RNlmcp1Turv/FvsEEfMev7belT1zOQ9GzQU0P76N3CihS5D3BppO5dQkM6E6WglbsdLINyYup
 zsL1UvFIEKDrGBtPPiSTo/HK/sN0CKMS3Nq0r7tomvYL63HRKo+W2Q2koSXZwYRHrxBxk0+YFtY
 E8v7/Jhmm0T4WiWRyPTQ+NALxf48oDEetqVuaLhxBLXqFry7hXLsDMug4hBQLt6QXbrwTChW0iR
 bFYf3sTaoKBnld+noUcK6sbWmW/AebhDQAR6zNnd5KE1qP2BA7i7XBRLuCkSCiiN4CseBpzeBJD
 AIoTcjAfyfkbH6J+hcA==
X-Authority-Analysis: v=2.4 cv=LpKiDHdc c=1 sm=1 tr=0 ts=6a577b8a cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=s1zqTiH2bahLR0COYxoA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: ikctD8RAWTApecIKTBR1d86Vs-xPMHYC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607150122
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-12550-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,gmail.com,quicinc.com,iscas.ac.cn,vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:mukesh.savaliya@oss.qualcomm.com,m:viken.dadhaniya@oss.qualcomm.com,m:andi.shyti@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:dmitry.baryshkov@oss.qualcomm.com,m:linmq006@gmail.com,m:quic_jseerapu@quicinc.com,m:zhengxingda@iscas.ac.cn,m:kees@kernel.org,m:agross@kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-i2c@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:krzysztof.kozlowski@oss.qualcomm.com,m:bartosz.golaszewski@oss.qualcomm.com,m:bjorn.andersson@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[konrad.dybcio@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 09BD075E0CF

On 7/8/26 7:10 AM, Mukesh Kumar Savaliya wrote:
> Some platforms use a QUP-based I2C controller in a configuration where the
> controller is shared with another system processor (described in DT using
> qcom,qup-multi-owner). In such setups, GPI hardware lock/unlock TREs can be
> used to serialize access to the controller.
> 
> Add support to emit lock and unlock TREs around I2C transfers and increase
> the maximum TRE count to account for the additional elements.
> 
> Also simplify the client interface by replacing multiple boolean fields
> (shared flag and message position tracking) with a single lock_action
> selector (acquire/release/none), as the GPI driver only needs to know
> whether to emit lock/unlock TREs for a given transfer.
> 
> Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
> ---

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

