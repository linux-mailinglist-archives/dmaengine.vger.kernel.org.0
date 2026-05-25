Return-Path: <dmaengine+bounces-10851-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDgLCFwVFGpOJgcAu9opvQ
	(envelope-from <dmaengine+bounces-10851-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 11:24:44 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 530A25C8813
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 11:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A27263005ADD
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 09:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D49B39A80E;
	Mon, 25 May 2026 09:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TMtLprGb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jMbOop1d"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF2A125AA
	for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 09:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779701033; cv=none; b=Ym5g4IxgPXu7rDAWHaU1BDTGBLHhbVU+fujX3BsuGNiPgNvgAacM+EzvAS2nAY6V1WvGMGR/LtLmlfZDkXc546bjzC94OeXEZnK1Hqa04NSeBz/B4yfGxg3C0tA2QNB9PvGjnhKHq0/+mV5z+PqY5czcJA/sDSN7cdUPp/c8p7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779701033; c=relaxed/simple;
	bh=yMesBNc83KFeDSyEVsHsqZR1yAWMj5zw8lrvjBNS3N8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UIyLGNdlkeyPqGmONzrt4Id7DuOfDSDZnDKD0hVU+Nqzv/DIDudxyrb4B363dFheNqwbdCq1XqAkChyr4dxkE8HGoMIupXbRb1btQagrixmVeDcb6YxIWOnIT5HiR9x7vM/v6AoC0nc75M/Gj9hGWkS6LyVIq4abDS50IarKgi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TMtLprGb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jMbOop1d; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64P5am6Y311737
	for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 09:23:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ZgEROvWEv1cb9w2QdV5vokQY
	l9MdDAQ1ReIXJgtHI+8=; b=TMtLprGbDMI/hnPqqiYx+U/blMZFw0vbp82uc7bV
	ooCXpTVMNnGMYmPP2wGeLXGZlLmClFHi9qjstlIAnKAWK7GAD990gatTG2frv2eR
	XQ/r6guqNDn+yeFlbFGFzW5sqEGxbRi5fA2m16RCeHrnjG44WiQbG+ExlTu2qV2B
	X/WKO+uYWXz8plEefKKasBbG4JxRg7RNHAKyjoG0RnStdGTvD7BrnP9TmEJR71G8
	rbyum6Nq4U1csA97iDrFXzcMgPLjXkJih+JdfychF2q5NwPN9Ihp2x9BTHSNxbUi
	UKopP6vYMNA6s+ku9VTahM+Wkx3YaaCGIlEgQ17FBrZGUQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb1kmpd4r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 09:23:51 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-516cde13e8cso81455741cf.1
        for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 02:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779701031; x=1780305831; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZgEROvWEv1cb9w2QdV5vokQYl9MdDAQ1ReIXJgtHI+8=;
        b=jMbOop1dqPsfu+VeBFOFpXpPwXOcY3gYx56YjvAl+Qj0H0X0bUgdQ4+fb/Bd5bMNbd
         XlYra/zQIUa0/0EtWoMIaPhP/3I4LvL0jCY0roH+MyEIPGTTJqJxpVkomgjX41dRukZT
         S2nfbXoM5XCc1pbp2nF9h2nMwfvBTvWtC7n25PInDTMSR5zt/Jp3+f4S5gu+xXMw82uh
         zOAUK/Ecrkgg14E4ItMpxOt961ji4IdjRPnK9VrYPOwNZeU33PqLXhGwvxiryOPmEK7G
         5XpXLQNdcYPhmSUKn57BWeITMbemzod4smY5L2EOe6G7HqZZq9YaV1rJaNQ9YGjvaMgp
         jYGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779701031; x=1780305831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZgEROvWEv1cb9w2QdV5vokQYl9MdDAQ1ReIXJgtHI+8=;
        b=YDAkO3MHNmjEtj6dxsmx17tll/I9i5zAMvXlAwqQ6W+vm7zV/4U6QUoa5nsU/qv4XD
         YmDW4FLWQalA4T8/LM4PWzL6kSBaQ2k+t2Efr8/YXLjEGrE1WmHJdumgPJuc2VwuijEL
         WZ58yi6fKxHnsWSAmOpXXZVydt8y24ecZtip3yiwk3eUr5nQ0TaBNFIkeljWTfUbWDNh
         bYdwsedXIorMdc/VDOxXA4Zmg8p4N+4stLFFwEjU4DY8OsD3mHVuuSAiZuVAlcWCaSkJ
         UKdFWGv+wM02H40vb/f/1AhhKlElzABI+Y46VKs+20R2rluErj/MFWvb6PPM8d9aDE6d
         E+nA==
X-Forwarded-Encrypted: i=1; AFNElJ/N0wMl3A5pobXhdcwIdIqnxBKAGVIqNRlSnghf9btuxg3Oe8UTaoId4C3H5wBk9IW1GI9bNNoolIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTyIBPr1t6368Q+PxBYQYTz7FqFlk8QKFoP+EpClWxLX8a9AJP
	ZGaIj6q59rCYdjlIYyQb4vp7I72Dn7ZaNWjN4OVEbimNiKG6WXldOI/+wQ4i0BWGD0wThWhKw32
	/LM2MMAZz9RyBvngDvXtURdwoKgMyP4nFMGVnlst8DbkkeUMmDJciWY5YAGAAZ8I=
X-Gm-Gg: Acq92OEW7QKXdoqWTCuU1jSFpBv6MmDA8yHKGTQenPvseZHke8ZRYARCQhjNNvgoPg9
	XDKmMlKu4TwmhbN1D64v6PMl7AutXwajV9aVhSMssxohiSJVkwbE9UsGJO7f9z806vF+OewssEm
	FHBvKiwNe2YHqQsbfPUtskVmV8IQwRWVQlwR/xM6ihtZkHMxhlvl3OS3i6c7NAmMBgVK05vemaj
	xDMjF3QLGr7/M/Z08etl7vlyI8VkE1kX8zeHxc+UBw6gGOqztpD81yjg0I10cm59FADqQZyHgjX
	gtZVzpUC6a2p6+F76OrrTfhdL2OGLjLYjRdcTXBA71PoG5gsOHq6+oPJNSe8b371T6V2AxwpG53
	Ng24SqbqBsR9977U7cRckbFppsqWcP594mifT+n+Xrl4tndgB/w5DgazEdbgYliskU8W5XDQsg5
	JGVCauuJ+okL3JV+M3yn3hZB4WL8yMZRHuo4U=
X-Received: by 2002:ac8:7e93:0:b0:50f:c36a:3826 with SMTP id d75a77b69052e-516d42bfb1amr206103301cf.16.1779701030672;
        Mon, 25 May 2026 02:23:50 -0700 (PDT)
X-Received: by 2002:ac8:7e93:0:b0:50f:c36a:3826 with SMTP id d75a77b69052e-516d42bfb1amr206103101cf.16.1779701030247;
        Mon, 25 May 2026 02:23:50 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-395dcc41ca0sm22447561fa.36.2026.05.25.02.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 02:23:49 -0700 (PDT)
Date: Mon, 25 May 2026 12:23:47 +0300
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
        Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>
Subject: Re: [PATCH 07/16] arm64: dts: qcom: shikra: Add CPU OPP tables to
 scale DDR/L3
Message-ID: <4ugjyb73ftcjypi6wfqz47j2vvvfxj3ljunsqlixzdzzajy72c@3gb2bnx7coy5>
References: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
 <20260525-shikra-dt-m1-v1-7-f51a9838dbaa@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525-shikra-dt-m1-v1-7-f51a9838dbaa@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDA5NSBTYWx0ZWRfX0AcMa74aHJFN
 1qNveSWHw5jyrkqS67iGeKPueiJOeDLx1p9y5lzBDs3fI25Mu+ijnuOqUgsiob8JY2cAcNotp5P
 lMViDDpoHrUYEPkqSzpyAjgoeP44bxcDKpluHKRyIoPtJqV43vlANR6O+f1C7PNj+7iTWp2ygIA
 pAPwFrqF3uhgwKd1hB8HqcLQJQ70uDI+G4tHHKQKeJ6jvpki38qmLM+0pEGsmcVuuEyyBrORtjx
 BgKSgSh7Ea1j4WvPTZS+j870sUQgBjpJQoOZmf4OCq3Y7/GDA83eLgPUEfLGMyjuKwJZb4slZaN
 psVN75EERiFndSQ9hc4U57cbCzm6iBfHWbyo6mLs5z8R6xT4k+NK/Nh1AHdEzfltMGxGlyZbHKb
 L20J05aHSqxZBIr3KFHxwKiulznBW7cABaoQGqbbiLkZizoREu3dTHSMqevJzB5DrHcFGtDSXyd
 zxN/1FX0h4+VSH0qUhA==
X-Proofpoint-ORIG-GUID: 8qP_lQRBYDRTMY_QNzJCVxeSndhXhKRW
X-Authority-Analysis: v=2.4 cv=cN3QdFeN c=1 sm=1 tr=0 ts=6a141527 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=djs_V13T0nIvbdZk5PcA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: 8qP_lQRBYDRTMY_QNzJCVxeSndhXhKRW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501 phishscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250095
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10851-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[4.196.180.0:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 530A25C8813
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 01:19:11AM +0530, Komal Bajaj wrote:
> From: Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>
> 
> Add OPP tables required to scale DDR and L3 per freq-domain on
> Shikra SoC.
> 
> Signed-off-by: Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/shikra.dtsi | 84 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)

Does it really make sense to split cpufreq_hw, EPSS and OPP tables into
three separate patches?

> 
> @@ -144,6 +164,70 @@ memory@80000000 {
>  		/* We expect the bootloader to fill in the size */
>  		reg = <0x0 0x80000000 0x0 0x0>;
>  	};
> +	cpu0_opp_table: opp-table-cpu0 {

Missing empty line.

> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		cpu0_opp_768mhz: opp-768000000 {

Drop useless labels.

> +			opp-hz = /bits/ 64 <768000000>;
> +			opp-peak-kBps = <1200000 17817600>;
> +		};

-- 
With best wishes
Dmitry

