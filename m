Return-Path: <dmaengine+bounces-11029-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAOTMBN4GWrewwgAu9opvQ
	(envelope-from <dmaengine+bounces-11029-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 29 May 2026 13:27:15 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED04601985
	for <lists+dmaengine@lfdr.de>; Fri, 29 May 2026 13:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0980D3037691
	for <lists+dmaengine@lfdr.de>; Fri, 29 May 2026 11:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2937E3D34A1;
	Fri, 29 May 2026 11:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A7bdhRdR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fQhSvMZz"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9EC3D25C2
	for <dmaengine@vger.kernel.org>; Fri, 29 May 2026 11:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780053892; cv=none; b=hflpTOzDX5rDogZyQ+B9caJefOJvJLL0lod61e2pG6NLBsyjvaL6JU4impAsE9gvSE2yiD6W2t5hVACbfAdGA0vUObx9U+MYGz4Lg0stT130MLkVnNL+PZPZnc8tuZuv7HMGdf2hWAgGObirjU1s3MxK17GspdAeLBagsTBv77c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780053892; c=relaxed/simple;
	bh=v5z54Xk4bSmgyuk9NpYqxo4keii6dzEKvD9OmkaJbK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFEe2d6WjknnVJQ5FW6YH/KyHxyCaAbSxBQiCsHLBjZsUTO786tHv0/w2T01a8IM7P/Cqba6WW5jDg//7fpMiQ7MyPQQOl0YJsGUkpQvROjXKdHnz7HNEFjCBUtCcwEZuKGiKzl9DzJ3bq3l8zvV5nPYOo9CuI4sIQUz892RD5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A7bdhRdR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fQhSvMZz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64T6OrLR1370227
	for <dmaengine@vger.kernel.org>; Fri, 29 May 2026 11:24:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=qloH8P1ospu9RxarNeTE+kqA
	33QizIUuoyflf0m4ulA=; b=A7bdhRdR6ZoVn/jgz4lBLNeY9QR2/Py1cCOeQ0Xu
	dYO0FIlhzWXYYkGYRGUcFDQJKNV+0MxeDY5QGM+ehW6BYk6whBR5S7XpfWFoEvWi
	GPZIDNIz0OvB2HGALPKTYFgOB3N2RNtL3ws3g9IrUGhyAGMfN6MmBkqzHFaHmVjG
	xUTljCrw2R6b9ZqisXOYtX1IphCbl9z5G5rWJbj34Fbue+oEGNv9OXTVL4/8jpri
	wi5Tplp3gSNX/P0g+l3ciuvomu3iqsRJe2PyrskcSpk+OAiINskm/0CD0NGdnnrf
	1pL7nwdF2R5Gz3FiUf1jWkfSwtitlAXd/AlMKF5/lWvG5Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eety5uy1q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Fri, 29 May 2026 11:24:49 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-516d6cf547bso156047431cf.3
        for <dmaengine@vger.kernel.org>; Fri, 29 May 2026 04:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780053889; x=1780658689; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qloH8P1ospu9RxarNeTE+kqA33QizIUuoyflf0m4ulA=;
        b=fQhSvMZztaudcMfEtnPpXfi83O83jKz7wL+kHSgSjdSTuDCZ59uI5qy2sH4S1H6A62
         FZDWc/Unui/UcIlZoSNa8QY+qLsS5h66ns4ttlD8BYcTYDUswl+NuiDN4Xfe9AJYxD/0
         XfBZx+K4n/gc2ryiO6dTooZE4w9Ugy0kZwG/AkwSa98jBeOFz33VBKfTdw1YP2AHQV/o
         3Ui//i+j3AxDBs1wUIVXw9T1lo5K8tovbGUVxPTxmVCK/Qq9LbWpo063d74RsNWe6VVJ
         xFDyWjYaRupaTjv208825CUaUlgaINcMvYtCP86qd1DPKty5xmQzrTXs1eroRyk/aKQX
         XyfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780053889; x=1780658689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qloH8P1ospu9RxarNeTE+kqA33QizIUuoyflf0m4ulA=;
        b=SURoWVssJSybRO/5OsDxynFw6tE0LkfRePM8+E+Jj7h2d3AdvkCajCn+tH4YYL/o1I
         zX4tYurh8oVvgZ+Tbypj+M+XW7wpKnGVTHooPCDW0XO9Q6zXe6NXkMjfPtrpGYPp/ghi
         4ghqnUtif4767LxaHJjSz9HdPhk2NuUJfsO7069vzNJ5pEvMU3wmbgtefzePKvYxC1aB
         aP2vEX8tquQ7nDZcftSbfYHHkQCoVTADykWJAPfVx0AIQiNqKPuDrmjwrxmUA/LJ/JUZ
         Dg6L4LdFBvDaR+Q3MFgPSj1sVne7MY/nEhMfTnF/7Pwn1VRDw9c+Jj5RK1PyQJZk/6xv
         l2Hw==
X-Forwarded-Encrypted: i=1; AFNElJ8CHOyAH0l4x7oqNg1D6cWC4nbtjxSPr5b7Fpv8oWaeEzOgda9uc0KJhzL3wIYrMR+GEc96Vw5aBJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeNa+3NC0gq6Wpxeagn35pnta7YZ187M7tfoI8o67jvwq+txgj
	NtRZfYQS3zKcKJrjE/EAzc9CtvXHjdXB/bH2Hdq/DRZiwZD+NEMXRdBMdQj4LavRigrabSIs94D
	RlTBoST4SNcJswC1XlQ6QU9cVSguUmKV7WwN9fhxhBtQmgKe3GWKI9Q622/DOT5F29wOKjaWUa5
	8x
X-Gm-Gg: Acq92OG99iF7k2HdcLDqSEN/izN2laUBoSu+eOvzEpHVeiNW/VuvsdL08OUr8SzbxpR
	yEJOqub29UPOrpcioe3WaM92StbhduVHVUdXWoEdBLzOxwN1S6FE6uIvyWNGJTVcrmLp+tjo8Jo
	VwTW+UX5n7q8ykwZid+v+nBRElDFTq+27puWowDvlqgpo/b1wPpn7DO+kQG0RbUq8sIcKHTm6n1
	C9HathAHhiD9QHomgTg1eqsMT0DhsRU/5Dc4Ypu8D7gxbA20XHHMWJbdUb+nNr7fI/AIXKmc7Ex
	EcKpXJGSBFhDCgGVw0O5u5lxvct/avnANVQ76DQRkTN4QjBGO0u8Viriivd9+Ti5hdn+wZI85tc
	w/s+VU4crI27RhOaGIUIH+FDe445/G00Tc10+jI5lXxgyKReTMz+l4ifWCxi5I89nZGpYTQ7dtn
	UZAtONdrQCmZy9k16gzO9J8ZyCX1xpY2RwxV7eIhXnEMq5cQ==
X-Received: by 2002:ac8:5fc5:0:b0:516:a471:dfc1 with SMTP id d75a77b69052e-5172dd3e10bmr29950901cf.49.1780053889105;
        Fri, 29 May 2026 04:24:49 -0700 (PDT)
X-Received: by 2002:ac8:5fc5:0:b0:516:a471:dfc1 with SMTP id d75a77b69052e-5172dd3e10bmr29950541cf.49.1780053888618;
        Fri, 29 May 2026 04:24:48 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa5b068abdsm221819e87.12.2026.05.29.04.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 04:24:47 -0700 (PDT)
Date: Fri, 29 May 2026 14:24:45 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Cc: Komal Bajaj <komal.bajaj@oss.qualcomm.com>, Vinod Koul <vkoul@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 16/16] arm64: dts: qcom: shikra: enable WiFi on EVK boards
Message-ID: <teatmsgijdgdfwwqy4nrcvcfkhpqybje52gkjzniqt23si2rms@bksrb5npq6ji>
References: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
 <20260525-shikra-dt-m1-v1-16-f51a9838dbaa@oss.qualcomm.com>
 <qhm4zgn3yiahv6dfucisu7uwcxddty4fvl3wwx6gk2zm5ggzlr@n3nqcpkkwxps>
 <57f8c593-11b7-47bc-8e11-7ec1b97210f6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57f8c593-11b7-47bc-8e11-7ec1b97210f6@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: LnzMloMhQNWvqv8LxkFO2raMj3vvBqG5
X-Authority-Analysis: v=2.4 cv=TeqmcxQh c=1 sm=1 tr=0 ts=6a197781 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=PDj5yD4EQWKW1X4F5PQA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: LnzMloMhQNWvqv8LxkFO2raMj3vvBqG5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDExMyBTYWx0ZWRfX9eUre1U7YCc3
 lXo4hxSQy9uF3EPbkWBT+Rq5YcqGvX1ZDPKLcSdeyl0c/v1mT8uLQUiS/ur1BHZ8go1l1+DtLqi
 4c8MgzthCKPQQYe5ZdBzNJcRzvGNaMawG5JFiqxE9H5PWSR/wE18K6QJyGY9Avp57s5Z2APk0hR
 8nF3xAHc2vA4T0PrGZmH4z3+fuY8zzY5zl1Uoz6d6BCtVyI7IAYmOJa937SMkKtTmGiACpbJWsi
 ZEAa1EvPYJvpfPr1kE1fVAFsycSuUVORiHEsNQk/qd1X+lWDavgWQ6VSLIhXnP7JuvcLp1mMB7O
 E4wYg7Dr8GPublk80FjxLPen+lOSNiccE1H5Clw699mt5ykGkcsvYjqEoCW+BAhIjGz2/I0GLUZ
 h3btBVo2PNDixNwnXglAVffYFdZhUPwud9pxlRPRhCyjGUjGzBxnSX3WJXR4jg9wbcxN+VAiE32
 SpDB64rJDCaSS9FpbeA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290113
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11029-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5ED04601985
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 01:49:03PM +0800, Miaoqing Pan wrote:
> 
> 
> On 5/25/2026 5:34 PM, Dmitry Baryshkov wrote:
> > On Mon, May 25, 2026 at 01:19:20AM +0530, Komal Bajaj wrote:
> > > From: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
> > > 
> > > Enable WiFi support on Shikra CQS, CQM and IQS EVK variants.
> > > 
> > > Provide board-specific WiFi configuration, including power supply
> > > connections and calibration variant selection. The WiFi node is
> > > enabled on each EVK according to the corresponding PMIC and board
> > > design.
> > > 
> > > Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
> > > Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> > > ---
> > >   arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 11 +++++++++++
> > >   arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 11 +++++++++++
> > >   arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 19 +++++++++++++++++++
> > It makes me wonder... You've added DSPs in three patches, one per board,
> > but BT and WiFi go together. Where is the logiic?
> > 
> > >   3 files changed, 41 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
> > > index 259032bd20af..15208e1abff6 100644
> > > --- a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
> > > +++ b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
> > > @@ -69,3 +69,14 @@ bluetooth {
> > >   		vddch0-supply = <&pm4125_l22>;
> > >   	};
> > >   };
> > > +
> > > +&wifi {
> > > +	vdd-0.8-cx-mx-supply = <&pm4125_l7>;
> > > +	vdd-1.8-xo-supply = <&pm4125_l13>;
> > > +	vdd-1.3-rfa-supply = <&pm4125_l10>;
> > > +	vdd-3.3-ch0-supply = <&pm4125_l22>;
> > Squash with the BT changes. Use the PMU-based bindings. Don't forget the
> > swctrl GPIO.
> WCN3990 does not rely on the PMU module; it is managed directly by ath10k,
> so the swctrl GPIO is not needed. The details are described in
> qcom,ath10k.yaml.

See https://lore.kernel.org/all/177432372677.35532.960283784585134331.b4-ty@kernel.org/

> > > +	qcom,calibration-variant = "Shikra_EVK";
> > Was this submitted to ath10k-firmware?
> Not yet.

Please do.

> > > +
> > > +	vreg_wlan_3p3_dummy: regulator-wlan-3p3-dummy {
> > > +		compatible = "regulator-fixed";
> > > +		regulator-name = "wlan_3p3_dummy";
> > > +		regulator-min-microvolt = <3300000>;
> > > +		regulator-max-microvolt = <3300000>;
> > > +		regulator-always-on;
> > Why is it dummy? Is there no regulator on the board?
> 
> WCN3950_3P3_CHAIN0 :is powered by on Board 3rd Party Buck which is always ON, VREG_SYS is always on once the device is powered up.

Then it's not a dummy. Please add a proper regulator describing the
node.

-- 
With best wishes
Dmitry

