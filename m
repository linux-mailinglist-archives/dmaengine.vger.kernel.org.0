Return-Path: <dmaengine+bounces-11262-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kxA6MZATJGra2gEAu9opvQ
	(envelope-from <dmaengine+bounces-11262-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 14:33:20 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F0564D6C1
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 14:33:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="E/FAz9rD";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=etr7bukI;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11262-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11262-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF7F6302F4F2
	for <lists+dmaengine@lfdr.de>; Sat,  6 Jun 2026 12:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364FF3A7F6B;
	Sat,  6 Jun 2026 12:32:44 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E428379ED5
	for <dmaengine@vger.kernel.org>; Sat,  6 Jun 2026 12:32:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780749164; cv=none; b=uDD+w0/iL4FX5KjkApsmI8lfQ0jbhOcgmn5MoM87EPZiLbBQXj3M+s5vD1MWJuDzkdwenGtivBPbmwgLAax1WUFLRNExH/rKVYozm37AhFyfZy7h6jjMGSOH/TQpNc27ySaby4vGztVb0pyPiOryMbdQtqlAG25L8cagTyT8FdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780749164; c=relaxed/simple;
	bh=uArRKwydgi7Awi4QPGR51VyhpX7czobobNZeG3o9P0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5TKiR+M0uCf4q7LV4YoK9gT5DE14dczZUISA9X5IzTWJfSHQ6oeDwNAl0976/gxAzNz8Avie0ljt6H7Jhc/Cp4ztDglXC0HKT22V8fbpzEPuOmOdMZ+rzCmIQCiB+F8UJvUfQqrk/fkJTkCg608kxQhVxaqkyhGCAYo0S9LS4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E/FAz9rD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=etr7bukI; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 656BDf5u1329102
	for <dmaengine@vger.kernel.org>; Sat, 6 Jun 2026 12:32:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=J7Jk6biw3e7jArCRN6UqVLK8
	rysHv0R52SpzdK/4FYE=; b=E/FAz9rDat47MAmRdOnoSqI7RkGCWRGIiEDC51vj
	JLkwxEz/tmIyvekIfi6YxXkyorWJua3ag9xd9BWtmJJXEP6psl3iJcnKjT8KEEJs
	0yIJotazgYMkChJ7zncLaPbnjYzmx1ZBMyJNdZ5IJSZDL7pyWGMBEguyx0o8NSJ2
	UXThhukq5USxC+w/HpEZNFtNyj0CsiDdcP+yd3jsCXGkBZ+PnEJtKMH4IaD31EHT
	lLCjItmIe5+szFktITBMFzgrIu5vKOlLFe5xQsLPKbYcTuce+q/RDoNVhhqmXGlk
	wIZqMJ31B4GDYyFaUPhd4dvPY7qFaT6vo2DeLUl8ed7kZA==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4embs18ym4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Sat, 06 Jun 2026 12:32:40 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-59bf1a43cd9so7667457e0c.1
        for <dmaengine@vger.kernel.org>; Sat, 06 Jun 2026 05:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780749160; x=1781353960; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J7Jk6biw3e7jArCRN6UqVLK8rysHv0R52SpzdK/4FYE=;
        b=etr7bukIK2frDt50OzMcg67khqXOtR245s49ghOJZ7EBEAKCx5hxD8uOs0st22U8FO
         1LX1IyiksadBCqllzb3iSfHErb2C302JU8c42k3qlbkAPeKUDlog07FuiiCIfFF6E0qi
         pcNvdSfoDtDkN4cEWGUpIZT1q7DiliyMUm/uhgt5u9K0KpAeLWFe12FZ+ixXSl5FE8Mm
         zzL23mWKkvFR9pqpuTDW0aOn/laVLJw36j6ullZj36j0WgHvLGZqkhgxzsHo+420aJt7
         kZ/7JQeTpJoJK/a16IbcP2/E2PE4toqd3S5LITfjKQblXDoDlz9IUVkxyRYlHPez0ANk
         o6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780749160; x=1781353960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J7Jk6biw3e7jArCRN6UqVLK8rysHv0R52SpzdK/4FYE=;
        b=R71igIv7aAyEwMx07Tm02Por4ghKTkUyoTr2/+uBYjaT/KF48IYQ9aLRBLDFZ3d9/x
         l4vwoEreziNF3mQLM4h+qhjCoidsISPVI6mpjNj3WQyVv89gmYU2/unLVpRWOssHbjqp
         r+N9clEmjtykc8SoMOVs3m8i/3hTtw73sHbRM61RWOznhio+wO2ajCVLzJNxMgw6BTF8
         Wc3esdUBU+J2m8BOI5uhXBzeo7/WaN9lv3iLZkYXO4XFWqYRKidwxxTiMy2fSZ/ucNOY
         fKH88Cq7yZeawNKHNykKBp0sPdSfILOEdYbFEeOhsS/+jXUHDtNdm5mMJdCnY9RRAKko
         bYHw==
X-Forwarded-Encrypted: i=1; AFNElJ9CG6JWTNShpZlNiJtRTLhViclW62vYAsHJ7syeWlgvZFIqzHg8PN54SPoMxUP7lMvukq8dQDrFCyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YweDFKvpkJv8NUSyx2Yarq4sd2ai71IMhevt38d8NZnrqP96fp3
	a7oup1yZC9Erm3cmwsbhKR6CSf89aPurKm0jnQtkknuJQJnoRFBnDB3gh+dnhOrP/3R6nPpvkjB
	elOo0IPM4opMhoD/MMa8jpevvkDL3xDv44AupwqtiVIrhfMDSYPk9UQStXxf0dP0=
X-Gm-Gg: Acq92OFeMs7RJheVLWzJMsQgFmM60BfS7tP8nLdmmH362u5F4tuXDi8fyml2nt7XZQr
	ZkEWr5G8OWkB1eeYPDEA5Qs5HP6UaIZtzXgBxuT3DX0dtb3ourtZOMqWFQDhJbvyHUkb7VK7m/M
	/8ZrssKTNa62OYB4wBpg3PHVUnIw9sHZDXMemSRcKp1ai3CmwFIG97eEZmj1oKXR9KG5YuCr3bI
	fEJYQiUv6e3mKVb2bYqq0epKBc/iTU0ygyWVKmNzxZTFMKtQ2hFLEol56W00h1Dp22xVS+cuwtP
	CD5jM0NkMdpZFU7GCDCp96LSV4MYuE5TfGLHYLrgkTWxxSIRqA91G6eadVYIaajbqt6HN6K4x2l
	R6MINYYdHLnkEZamtYxLEdPyeyt9OcUZBMULKnMKfShyrNQGpV8yrC1ihmAt0Q/R1ToyTEb1MSe
	bxEhBFC3RYV8fo5UFNcQT/0dLsyXQNEv6TH7WabAPIFCvE9Q==
X-Received: by 2002:a05:6102:284f:b0:6dc:c4aa:472 with SMTP id ada2fe7eead31-700359f5425mr1741705137.14.1780749159944;
        Sat, 06 Jun 2026 05:32:39 -0700 (PDT)
X-Received: by 2002:a05:6102:284f:b0:6dc:c4aa:472 with SMTP id ada2fe7eead31-700359f5425mr1741697137.14.1780749159549;
        Sat, 06 Jun 2026 05:32:39 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b8fba4asm2415013e87.18.2026.06.06.05.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 05:32:37 -0700 (PDT)
Date: Sat, 6 Jun 2026 15:32:35 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
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
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Subject: Re: [PATCH v3 08/10] arm64: dts: qcom: shikra: Enable CDSP, LPAICP
 and MPSS on EVK boards
Message-ID: <ykcbo7dkl2rrjdzutpwsc3wmnub5r7h3zuspxiyh5v432whb65@sbaar24glpta>
References: <20260601-shikra-dt-m1-v3-0-0fe3f8d9ec48@oss.qualcomm.com>
 <20260601-shikra-dt-m1-v3-8-0fe3f8d9ec48@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601-shikra-dt-m1-v3-8-0fe3f8d9ec48@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDEyNSBTYWx0ZWRfX0g+h+uFfjMJ9
 kWaeICVnC+oYJs2hyWdSQtISSfFMG9ne4AtUIFUq5HGde0Cn1/RuIHPjNW9InK6W5HY4g0Xp1ei
 t5dH4A7SBld5utjM7LcH1OsAlCe9J7e50tbXXEQWAwBuRI7HTHdnmWLPzqVowAxamc5RLEdRnGO
 IieNdbLu3nK9JJQrz+2CKktHNQaE6gl0WZKP8FSe9bEH+mfZPojfkluEIkJBgmazqUxh/EzOBDv
 jzQ7f6yw4Ov5rSMquTgSWHVYC0AqxPKW4O/sHm1L4qaF0mU1fmb++teYL1y0CSayqk/4e9q1WNu
 OZv9JxybBodlxIo2DL3Oag4tt0pasO2xfJwfSTHuelMErKyEF00shPKV4I29QW1z9J8TsNe+a7Y
 5HL9FH9OG0leJiYOzOMPBGsw4U0LOi49LwNohPCXLg1v0xovCl35AbI5UvAG+rDkWrdGhMSLYbt
 0y9W9HbbmGtvzUB/l0A==
X-Authority-Analysis: v=2.4 cv=CeY4Irrl c=1 sm=1 tr=0 ts=6a241368 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=0thynvrgsBQo68K9vjAA:9 a=CjuIK1q_8ugA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-ORIG-GUID: Pm1gSdgq_Mcz6QcEFC5caxIUpVAU7hQY
X-Proofpoint-GUID: Pm1gSdgq_Mcz6QcEFC5caxIUpVAU7hQY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606060125
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11262-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,sbaar24glpta:mid];
	FORGED_SENDER(0.00)[dmitry.baryshkov@oss.qualcomm.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:komal.bajaj@oss.qualcomm.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:krzk@kernel.org,m:djakov@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:bibek.patro@oss.qualcomm.com,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 43F0564D6C1

On Mon, Jun 01, 2026 at 06:25:10PM +0530, Komal Bajaj wrote:
> From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> 
> Enable CDSP, LPAICP and MPSS for Qualcomm's Shikra CQM, CQS and
> IQS EVK board.
> 
> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 19 +++++++++++++++++++
>  arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 19 +++++++++++++++++++
>  arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 19 +++++++++++++++++++
>  3 files changed, 57 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
> index 0a52ab9b7a4c..b112b21b1d79 100644
> --- a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
> +++ b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
> @@ -23,6 +23,25 @@ chosen {
>  	};
>  };
>  
> +&remoteproc_cdsp {
> +	firmware-name = "qcom/shikra/cdsp.mbn";
> +
> +	status = "okay";
> +};
> +
> +&remoteproc_lpaicp {
> +	firmware-name = "qcom/shikra/lpaicp.mbn",
> +			"qcom/shikra/lpaicp_dtb.mbn";
> +
> +	status = "okay";
> +};
> +
> +&remoteproc_mpss {
> +	firmware-name = "qcom/shikra/cqm/qdsp6sw.mbn";

qcom/shikra/qdsp6sw.mbn

> +
> +	status = "okay";
> +};
> +
>  &sdhc_1 {
>  	vmmc-supply = <&pm4125_l20>;
>  	vqmmc-supply = <&pm4125_l14>;
> diff --git a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
> index b3f19a64d7ae..e62ba5aef71f 100644
> --- a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
> +++ b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
> @@ -23,6 +23,25 @@ chosen {
>  	};
>  };
>  
> +&remoteproc_cdsp {
> +	firmware-name = "qcom/shikra/cdsp.mbn";
> +
> +	status = "okay";
> +};
> +
> +&remoteproc_lpaicp {
> +	firmware-name = "qcom/shikra/lpaicp.mbn",
> +			"qcom/shikra/lpaicp_dtb.mbn";
> +
> +	status = "okay";
> +};
> +
> +&remoteproc_mpss {
> +	firmware-name = "qcom/shikra/cqs/qdsp6sw.mbn";

qcom/shikra/qdsp6sw_nm.mbn

> +
> +	status = "okay";
> +};
> +
>  &sdhc_1 {
>  	vmmc-supply = <&pm4125_l20>;
>  	vqmmc-supply = <&pm4125_l14>;
> diff --git a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
> index 3003a47bd759..727809430fd1 100644
> --- a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
> +++ b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
> @@ -23,6 +23,25 @@ chosen {
>  	};
>  };
>  
> +&remoteproc_cdsp {
> +	firmware-name = "qcom/shikra/cdsp.mbn";
> +
> +	status = "okay";
> +};
> +
> +&remoteproc_lpaicp {
> +	firmware-name = "qcom/shikra/lpaicp.mbn",
> +			"qcom/shikra/lpaicp_dtb.mbn";
> +
> +	status = "okay";
> +};
> +
> +&remoteproc_mpss {
> +	firmware-name = "qcom/shikra/cqs/qdsp6sw.mbn";

qcom/shikra/qdsp6sw_nm.mbn

> +
> +	status = "okay";
> +};
> +
>  &sdhc_1 {
>  	vmmc-supply = <&pm8150_l17>;
>  	vqmmc-supply = <&pm8150_s4>;
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

