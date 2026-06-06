Return-Path: <dmaengine+bounces-11265-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vZ2WDAIYJGof3AEAu9opvQ
	(envelope-from <dmaengine+bounces-11265-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 14:52:18 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B69C64D894
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 14:52:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="O39W/cMb";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=Bc9FdYUg;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11265-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11265-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1EA330276AE
	for <lists+dmaengine@lfdr.de>; Sat,  6 Jun 2026 12:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999723AEF47;
	Sat,  6 Jun 2026 12:46:04 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EACA3A7F6E
	for <dmaengine@vger.kernel.org>; Sat,  6 Jun 2026 12:46:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780749964; cv=none; b=VDpH4LwSaF/bSwsOqpBI5jOCTubScP3NSFIhMH6TXZfDG5VVyOvRNbLmHhOXZ1TV6rtZNgscNrYmxgGLJObPOaPMCsKsYz+su6mks1HD6L9tOPUcRkhjSGM/wsUnnja2hTl10lAf9Dk5tUXK6dJJt+GJ+GPTaOZbcE68Fc0Mppo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780749964; c=relaxed/simple;
	bh=pc8EHI9BMBuc7BjdgJHx1xQ9FLAmDHcccW4NFcZ24vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcHkQB7nTv4J4kR7wamlMI3ufC8Sk+g3HPDx2WRpnZfsB9GOgn/TEdQpMdeil5dgRoF3BeEAw3dJ9Gw6cR7tmFPUIEboPTzm8baDcnJ6JQHYxsBscG85PMwf86qScm0w8STWBWEJaOCWTDAEJ+pTMnRfnTLTxa2rS3sfJ4HHdbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O39W/cMb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Bc9FdYUg; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 656BEg8a1258963
	for <dmaengine@vger.kernel.org>; Sat, 6 Jun 2026 12:46:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=6sg4LNPX/0iFwJxDV4MhwcZf
	2oXBafEdAV38XLdgyTg=; b=O39W/cMbgPpbzRhatwGVYL/obWJp5emy3OG/yGNP
	7ePx2Oa7h9BdYayCcE9AFIqXW4C9adJ4Ej52LSLGEJDHZTGtfnCeKFnmTO+9U3VK
	8hJHWkkLoWsRcrATRKgrLYuW+j/+TfCDS2TfBwRvQeMbvbxm5E6LXdIa8PLCEjt6
	zjBW8lUyyQiO1fc1smz51jo89K7nG9vsLr0QQuAEKaii+vTu0+DDAohFjGZrI6fg
	qJ7KRbznt3Zf+T/+B0NJjU0Ct6l+QcefWoB+3DVnDlimL+O9y3S+B8gs2nqAv9XU
	ve+JCSPpUhUxZivj1wXZF7s5pjAbOr4uL3AzMAWp1qEALA==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emcadrw0p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Sat, 06 Jun 2026 12:46:02 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-96396658728so1088846241.1
        for <dmaengine@vger.kernel.org>; Sat, 06 Jun 2026 05:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780749961; x=1781354761; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6sg4LNPX/0iFwJxDV4MhwcZf2oXBafEdAV38XLdgyTg=;
        b=Bc9FdYUg+3d7BxZyz5npQ2qA7G1A9sRsSp+riyIHwFHLI6uqV6aanu6uI0Katekp5Z
         bJOSQkP4kUJ7SlT3qTVz6HpbUBwWjSGYL5ob3X1N6A7MoebySzGjgwXxUWkK+eLZYV11
         IDVr8m4EyWO64Wl9NoxvQiLC9Tw3NiufwZPiQSZmV5dsQXX2yBqMdWu3Fq8oOqaiw6Le
         ILPZdxDi3a6nz/VvA7qlf234fPxJJxPOkxgSr4oTxru6NMB3BSsuKRait60cmYhF0EB7
         RUQP+LLemFlbsBMdC9ZSlLJpiGf6bTztL+COYe+DCfXN6ehaU6FOwMfzwskHecFPfhEE
         PBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780749961; x=1781354761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6sg4LNPX/0iFwJxDV4MhwcZf2oXBafEdAV38XLdgyTg=;
        b=Hhw2lb/NPQ62fHOiYNTVvDE81vMgxOnHYvet1WAwnqheq0fEkFxHoXAHMBDJnU4iPL
         9QBEjlwttlwO9B7DY3S4oiDTq7HsWfTFLLKHytdbXMuTOuxQrBNPVkjJb6weqci7Rya0
         El6r84EKXLyuu3byET7ANe8SPw+8hZMALTKLBYHQhozvtC/d2ubZsOnB9VjZBGJbQsUC
         Ny69s5tvgb2uiOh5lEgWJOCztZ0LaxqIFsEbR4GE+ruEE7UrxGHxz07wlFPaNPKxrEuz
         rEmCOW8bmA+OG5ifSl53k7gH528b1ye3+YGKSDmvRBVROgrLw5S0f8oMll24nAC2zq/A
         nHlg==
X-Forwarded-Encrypted: i=1; AFNElJ8iJ+sZblA4P0tINvRXTrCMcUhCaUHh4VTPjFD4DzbVueQ9zvXcAslb8r2StcXZdGNw52p7zBLUay4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCHsGLOeBZrvRP7K3u/5fxmDWsxlQWGUkJeft6crg6UIn7jNox
	3/aKKCb3MVtnHMbW07doEc78PtsOkdhiQ3tjhTV8Qh5Tm4bsWN/+/eYrxPhtb8VKZINcQJG+eKe
	dhCF4+GZnJ1qo9/y3Vn9Qh9xGfcfkf62coBG9OXV8h57X5A2sQaFbQILG6j5KH2E=
X-Gm-Gg: Acq92OHLegyxpVT7SDFGONboQWksh4oL63JQeiM1U1FFffXZKebvtuErOGR+iyezH4M
	n8wYit51+ecGQoSYqtC4H+7g0+6+SPZkFM8bKz1gJs3s6mSx7tOd7eNf1Rxquk550Xk7jxMRgxM
	OTfZfJB2Z0ED+XsXKSKaqq4R07ykGSQdK6sh0XSoaVYkScqW3k62cOoznRc7iOw3Y3AgLWywxIM
	S/qtNd5XCcJsbq/vUzx/anbVpDQT+z30zcZZJEiSE9ihm2bXUU8iLjZIEtuOC0HLXKa5ZVJyPQv
	AKsomQKKjhHbjilpvGMa/BXXcsQPrYB2Gn5TT49P77s+q6Frd7e3y1qdYhYKK91OmCUB4dbLlyR
	h8qTsHzBcRoxJRgoNv08cyyRtKf8y8Jl984CeUm2p6FZBGxPpiI5jxaBtvNiygsqYeh/fIw9282
	a4T2sjrf/TgkMG2lsm+eGGN/hxcoctfzhu2JlDpw6Yq+JNSg==
X-Received: by 2002:a05:6102:c08:b0:62f:39a9:ae67 with SMTP id ada2fe7eead31-6fefa8ecab5mr3893492137.17.1780749961340;
        Sat, 06 Jun 2026 05:46:01 -0700 (PDT)
X-Received: by 2002:a05:6102:c08:b0:62f:39a9:ae67 with SMTP id ada2fe7eead31-6fefa8ecab5mr3893477137.17.1780749960954;
        Sat, 06 Jun 2026 05:46:00 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-396ac2be2absm30620321fa.23.2026.06.06.05.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 05:45:59 -0700 (PDT)
Date: Sat, 6 Jun 2026 15:45:58 +0300
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
        Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
Subject: Re: [PATCH v3 06/10] arm64: dts: qcom: shikra: Add SMP2P nodes
Message-ID: <xzh75zc7mpbqkqwqze3btcrwt4355tnty6k3l6k763f2jx3t6f@ql5ml6hdxkzf>
References: <20260601-shikra-dt-m1-v3-0-0fe3f8d9ec48@oss.qualcomm.com>
 <20260601-shikra-dt-m1-v3-6-0fe3f8d9ec48@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601-shikra-dt-m1-v3-6-0fe3f8d9ec48@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=DIa/JSNb c=1 sm=1 tr=0 ts=6a24168a cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=YUvwHg7a0UAiIoF5iVoA:9 a=CjuIK1q_8ugA:10 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-GUID: 5zma-iMJGzu-OGRiIXeK82_oDbeQ7sdC
X-Proofpoint-ORIG-GUID: 5zma-iMJGzu-OGRiIXeK82_oDbeQ7sdC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDEyNyBTYWx0ZWRfXxuKum+ZQcSZQ
 bYxGS7515EAd8L1zp+uabittIhOXqxGCiP4rzxvaS9lO+AbewEk+xaor7LZ0oAM7tWgiJXv3TMv
 Yw4lT5gPQtLpoIHKDKVqPdmDpQY52CzSBidiGldpVY2GQi7HxEf37jt6bw02OFtf/sLJg0rRDei
 8npQxEdMW/MEzbVTpYmMfuXj8Zj7f5DxNJLj2LOliePG1E3f3WIQAk6vhg28PjOtKhrV9ZDqL2w
 SdWc3Xn5kqgBNn2nuD1kq5ONtFxVR2uzeZtixjBzLnvmKeL9J+oJa+enTRXP99gcVlnB+fRyo5u
 uE74MEPOzNOJwpQZ3ZL8FyVrSWQ5/qAS8rJkEm8LNIjGvZwCGZrtwx7I0p2tpnmTNM/ggPOrQRj
 5i1XSVNJbuaVOjURVMk1qDkAdn/7DzQ2oiXxQk/TjPKpubEEDp3c98Pd16+iPzBNhCWXUlrIQKH
 ldDnEXxPn88v23WXb2A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606060127
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11265-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ql5ml6hdxkzf:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	FORGED_SENDER(0.00)[dmitry.baryshkov@oss.qualcomm.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:komal.bajaj@oss.qualcomm.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:krzk@kernel.org,m:djakov@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:vishnu.santhosh@oss.qualcomm.com,m:conor@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8B69C64D894

On Mon, Jun 01, 2026 at 06:25:08PM +0530, Komal Bajaj wrote:
> From: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
> 
> Add SMP2P nodes for the cdsp, modem and lmcu subsystems to enable
> inter-processor signalling for remoteproc state management.
> 
> Signed-off-by: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/shikra.dtsi | 69 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

