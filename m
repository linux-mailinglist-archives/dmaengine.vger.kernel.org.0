Return-Path: <dmaengine+bounces-12539-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IBwLDe4gV2qnFgEAu9opvQ
	(envelope-from <dmaengine+bounces-12539-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 07:55:58 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF6875AC54
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 07:55:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=HlM6796R;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=jq4JFBnx;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12539-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12539-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9B9573031D9C
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 05:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34DA3B71A9;
	Wed, 15 Jul 2026 05:55:44 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004EC3B7759
	for <dmaengine@vger.kernel.org>; Wed, 15 Jul 2026 05:55:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784094944; cv=none; b=V+IQLeg0oc/xhtK1IHIZwOdLp4tTNVsARdKuR3lPR1h/cTYSnP7gdvMYMKEYOCCv8ZbMln61A4tKRqVQuPtLxCOPJISvvPyezjHlLN4IBbY25E51ZyNpiMyDUrgWpEP42eo1NqJ84Ws9bwwJfbZGoPwUzIxtjAoq47eHHYLDRi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784094944; c=relaxed/simple;
	bh=B4Zmlu2VreGmMwudKumfsHsYVzHL9X2ieoVGQe/OCmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JIlU22NEqz1w6WVPqaTL3jVDL2q6Zp+bVm76yMFi92roN67G65t6mb3xLnLS4wwNFQ0aajY71u0roe4Z0E/4unkNNrR76D08BQHbegvznCu0CIv2JojlLO95Hgu51ctHS038S8/ra8p0hwWL0vdvqovrsTvp9f1RgjS8aB0Rtdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HlM6796R; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jq4JFBnx; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66F3lLOJ2528222
	for <dmaengine@vger.kernel.org>; Wed, 15 Jul 2026 05:55:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N/B6IES+9ZXNm6GUIpKPEsMYXkmhaQ/SumHrsSWagv8=; b=HlM6796RnhvW2YJV
	iqrKV0vmI+rFhjQcwPOzG9JDkiGoxrgjB+2DJKHPh4TF939Sd1CL9UuEQpUK84sj
	nVRkUcFGTpNDNwa1HTn9ONaVY6qzURJd4Q0n4bGcHo33QAi6zONOmVCcc/Lviz+U
	CXefwQe1FtTfUsCtUiYHuc0ns8mP1NThDrapl0vgqDXOnx2HILpfhlyQV2xC7+fC
	gOkVJEG0hNnpv1S/8VHP9Nd+COI2YWzJnv4dqHXZvsQ9ysSfGYHl5fXPYFDsYBLC
	JXmCUQqcaiAjka6lguxr+QDlekwauUU1bcO+aMGyt1NIr1WgDM1lAZOTF+a7jyBP
	vd/AFQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdnnr36ty-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Wed, 15 Jul 2026 05:55:41 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cc640dfde3so22755555ad.1
        for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2026 22:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784094941; x=1784699741; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N/B6IES+9ZXNm6GUIpKPEsMYXkmhaQ/SumHrsSWagv8=;
        b=jq4JFBnx9GHsauAe5qK421yFsL6RJtEs6BNganyVwK7v87XKb7+nIY+VtD9cZU6TmR
         8B0tiBw7zz6VD6NyXX4Co9sgMaVg8oue7hoRzGRQni71yPf3dsbWc0QaQlTI1021ISju
         2Z5QzCKKq07tzoDBEv259jvhp2Ur0U10w1nzOU5ZFCLH4U6Yp8bD7V3gDgV5uBwNlbHQ
         ebQq9Q0uhUNXqbqhVenHLhbm281b+2PgYmMHMKKKUsEovzlxNmnN6CRP7JuSgPCCJbMW
         Cti7nGemXlLcTz/6hbDOEvDiOorCL06UbAfNyq6DaixQc4tnAWYkvqCmXEw5uWnh6Fmp
         LCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784094941; x=1784699741;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N/B6IES+9ZXNm6GUIpKPEsMYXkmhaQ/SumHrsSWagv8=;
        b=QSOOPKMVGAqG9jS8LwxDd63wzABLGRCVjO9eN29pqrqPYyW4BM1vPdw2TWdb4/lefn
         sJrdSiWbjttAAlpirMnsgNCYXVxxK9s//XLcqlwyb/tlFTU9rwAtlOhzUPudBbQxHiRZ
         RSVzRqadbezFsv3FyU715WAQWPRcScXEaSNi2DsaNMjHH98x94dvyfYQbM1khvhBDe4F
         OMar0446tW0OJFcmsKCIQUxceUDPuHj8LYB1HbxwEYjLY+BoD5hSFJNfSIkhcJiP1nmI
         UKYLDeSR3H4aZN1zlXdcSYGC9PbTtmg0H7JDZBT7eoH0E9W/od3KC9ywYz78LM6rYpep
         Eq1Q==
X-Forwarded-Encrypted: i=1; AHgh+Rq5+wYt6jI2C9sfU52ydnHapm+d2pbEkkRq1LHMCGsh5/GmHJ9GKGL7hx66IGCz76nrMTUtLKWTLdY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw18AP6ZwY/rnPGxaUTHF3/8eLsOa351MHLCstuCxi6L1Ehn0nT
	0RJ9BZSIZ8UJe42ws5M3n0qWjACNIeRIbZlplrg7pUPR/TLVBP0jkvtmQzhrS0IyrXVaWtmpeG3
	f0J3zttowAGVHsiTk85wyuAZvp4/T0Kgy7Src611lew2YG/t47EzeiQ7Kqh+DneM=
X-Gm-Gg: AfdE7cmflYhSdtyzSuqcAqiu/zoVLiCAiVnBvP9Ei623IdN3IsEoqErDtIN3NpzXcsb
	ktZw1/yEePQnP6cpbDRqAzWYnxXH1mmuEkiO7nK7tXp66nQcx5S/xqm/KihCjwPMW4Ik5Noa7CZ
	ruM/fKGzCtHpMlej3Hrio4QW5/R/qaJTpabBScJ1ApsF5dFj8w2+8mItseqUP605u59D8PtcJAT
	zDAVdEYEQ/sKxTHRVReApSYk08eou9NdG5s0J9Daz0YtGelK1y0Rrt2cpjELikdEqj9J+yobKD2
	MxXjUVXLaEIWGUJvsY/9VNLK83TiCUYWS1zapbQYoPwV1eKh9TLoMYMEVrOd7tEnmpdy8DOoFhS
	WstmqAvPF1s8rI4vwsQD9MgBeQkmr5ftynYuYkJfUPg==
X-Received: by 2002:a17:903:2c8b:b0:2ca:b48f:3395 with SMTP id d9443c01a7336-2ce9f3a112fmr152899345ad.34.1784094940651;
        Tue, 14 Jul 2026 22:55:40 -0700 (PDT)
X-Received: by 2002:a17:903:2c8b:b0:2ca:b48f:3395 with SMTP id d9443c01a7336-2ce9f3a112fmr152899185ad.34.1784094940219;
        Tue, 14 Jul 2026 22:55:40 -0700 (PDT)
Received: from [10.218.31.125] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3d952sm126360485ad.61.2026.07.14.22.55.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 22:55:39 -0700 (PDT)
Message-ID: <e34de9f0-f828-4b96-a115-27d262969a25@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 11:25:35 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] arm64: dts: qcom: shikra: Add ICE, TRNG and QCE
 nodes
To: sashiko-reviews@lists.linux.dev
Cc: conor+dt@kernel.org, vkoul@kernel.org, robh@kernel.org,
        Frank.Li@kernel.org, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org
References: <20260714-b4-shikra_crypto_changse-v4-0-06a4ea97c209@oss.qualcomm.com>
 <20260714-b4-shikra_crypto_changse-v4-6-06a4ea97c209@oss.qualcomm.com>
 <20260714102240.B586C1F00A3A@smtp.kernel.org>
Content-Language: en-US
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
In-Reply-To: <20260714102240.B586C1F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDA1MyBTYWx0ZWRfX8cY2rTtvmiBA
 LJjz9MSc5JUUzT52li/p7GbBM/rvvfF3JumsUwkXcfB9kC/eW0zZAHT8xtHK4YJx4H9/bsDCCOa
 kN1Oqv9omPZYmindkTCNTV2e+d1PNzQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDA1MyBTYWx0ZWRfX7s/julqZmbGr
 IDek3wjUkeq8TOZcvYlmM46madNeoIlju6JOXm+IC8mHLlJMd0ULS7y906hHg4tJPJ7lxVRXPF4
 t1+jdB6Rc9/nqu+l3MPIq4sftibCb+kCYVWDZwsNcHpQSyYd0s5aqom0RYjl+gGsXpRalHYT55t
 1XahXFPv32pbR/jZajy85LWyICVdxSRfKg39ETpfF43SK7GBUOs5/cxO2ildLKrYytlPBY5dz3h
 zZ+xCQewWry7IzVhtWJU/2KM9bByNo22qROmUKQ9i3ikZAufn8fD9lpUdA5tynDzy8Hh5GQ27lR
 Wcpm2dC5Soc3A+d5UPltom6tS2uoP1kONG+gkTpg9oNsFkxd3xsQGNWGJhafy79y/VVvekB9PL8
 w3kSiI0OT/Di9qhUgSC4QADaO98w7C0nru3uWMeEZrPf9iHFxhI5tE6HydWOvHAb0mXaiNxlr2V
 W2ZGyhmyfjOdQIHH4cg==
X-Proofpoint-ORIG-GUID: 0R7nf5FgwVTdtG9MBdz9AyEDp_0fkhSs
X-Authority-Analysis: v=2.4 cv=NfPWEWD4 c=1 sm=1 tr=0 ts=6a5720dd cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=8wWWxnHPA6uIG9S2x-oA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: 0R7nf5FgwVTdtG9MBdz9AyEDp_0fkhSs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015 spamscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150053
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:dkim,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-12539-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:conor+dt@kernel.org,m:vkoul@kernel.org,m:robh@kernel.org,m:Frank.Li@kernel.org,m:devicetree@vger.kernel.org,m:dmaengine@vger.kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BBF6875AC54

>> +		sdhc_ice: crypto@4748000 {
>> +			compatible = "qcom,shikra-inline-crypto-engine",
>> +				     "qcom,inline-crypto-engine";
>> +			reg = <0x0 0x04748000 0x0 0x18000>;
>> +			clocks = <&gcc GCC_SDCC1_ICE_CORE_CLK>,
>> +				 <&gcc GCC_SDCC1_AHB_CLK>;
>> +			clock-names = "core",
>> +				      "iface";
>> +			power-domains = <&rpmpd RPMHPD_CX>;
> 
> [Severity: Low]
> Does this code use an RPMh power domain macro (RPMHPD_CX) for an RPM SMD
> power controller instead of RPMPD_VDDCX?
> 
> The sdhc_ice node references the rpmpd (RPM SMD) provider but incorrectly
> assigns it the RPMHPD_CX macro. Because dt-bindings/power/qcom-rpmpd.h
> explicitly includes dt-bindings/power/qcom,rpmhpd.h, the macro is defined
> and evaluates to 0, which happens to match RPMPD_VDDCX. 
> 
> While this avoids build errors and runtime impact, should this use the
> correct RPMPD_VDDCX macro to prevent a semantic mismatch?

This is valid, though both macros resolve to 0 value but best to match
with RPMPD_VDDCX which also matches sdhc power-domains property too.

-- 
Regards
Kuldeep


