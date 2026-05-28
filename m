Return-Path: <dmaengine+bounces-10988-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JHIAibTF2qOSAgAu9opvQ
	(envelope-from <dmaengine+bounces-10988-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 07:31:18 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDB95ECD1F
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 07:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C73C6301C10B
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 05:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E946322C78;
	Thu, 28 May 2026 05:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CMKNz5kP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EH3Ramm4"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE0B2C0F84
	for <dmaengine@vger.kernel.org>; Thu, 28 May 2026 05:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779946274; cv=none; b=BJ09BtPRwnoP5wuzmwxJKDPlX7uVblPzlDMgidWro7gW5KH/OrYaCUfn9+FLBh6fOHRg8qHOrBMmSrfOVOcH6NAjToqKo4rX4A7xrO2wOz7IlJOGPrOvH6uXbiwup92kDGNnprVoEVudNQS0qKVRcno+v7bdkX3S+yldunwGZJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779946274; c=relaxed/simple;
	bh=PqyQv5lR4CSDal3C1K6XS5brllo/mkSEyVrmaA2Skw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BtLMuPzS/CKkXtPFxA9otEcewKq17Ld7BBi9WrHaNFJWZtpO5i8GrvCxo3I/wWYMamqgu9cm8X0pF7oGrQU3JHp3qN4C8aL0X5MqRH2OvAIRXoMad1BRsytThC1u1Kx4/MPcxfxPqY2tXEMbQe+KOKIbCSnrrrtd+ilNbggLIpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CMKNz5kP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EH3Ramm4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RKliTE2931477
	for <dmaengine@vger.kernel.org>; Thu, 28 May 2026 05:31:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=bheMS1C3LAWE/VCtZ8G7QH4E
	3JfFT6z3QwuAGkiTibI=; b=CMKNz5kPSHCyOAQChseFIsRvkUlRhLTWbyB4gjyY
	Fd1oQz/kojOhEa/3/cLsGU6eGeOzd7nXsotl5FerwwFscC2WTOeEcnEalFH1SEFo
	Nu57TKntYQ96H9/KR3Rx4RZTBtcMXpEtJ9BPrWJcYmZBbXcvYLMGibUdJD27OLsx
	/bTzPBtWMem+WalwOI0M+KT/Q5JOcjkK1+M617SNAfrl6bPvZ23sss7Pr29zKZ7Z
	Fy7Lo3XPJ+BwPewD/1hFMyVeEocw3/GeAr4Y6MfBXNtfiwyIOkruNHWt1yZeRN2g
	NoAQYF6C3SYVI6MIm3d18U/8uQyR0YZyPNXt0Hhl0Ila3w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7yahe9u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Thu, 28 May 2026 05:31:10 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-914c8954923so855162285a.1
        for <dmaengine@vger.kernel.org>; Wed, 27 May 2026 22:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779946269; x=1780551069; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bheMS1C3LAWE/VCtZ8G7QH4E3JfFT6z3QwuAGkiTibI=;
        b=EH3Ramm4pqDy3kFtzHExrOK6gN7HoisG9vrPjobJVu6vg+FJ8Fokua4hA2iddGl8T/
         47U9BWlKMi6zUg5TiMb6FUhtMdjAihweH8uglnSVFAnSfdU+rj22P9FFa9x0FWBdzgi0
         PnKPo0kWMk0GqBcoJWzkP00TRBmoQ0AGqJMncPq99Szglc+bgwt28p0r+7w+3oZM2Gtv
         A2vnT5U/fqk3riTq5UJ80XCF0XKBmhw8a4OF4s2y8xstFmZj9UR+WCXl3QanFu+OmdKP
         U2tbAGkJex+tT+daTPy1/Bu2bGTl7jXWzMmqMo+8EFkmhBLUhYT2ep/fyls3ueweYGvy
         O/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779946269; x=1780551069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bheMS1C3LAWE/VCtZ8G7QH4E3JfFT6z3QwuAGkiTibI=;
        b=MFbwBC6LrBL3NrFXBGsui16V+N66/CorJI+4rQc2NXiOPdM5PbrzI1l2wsUbFnE9Zn
         Avb9KoschpxESPCb7mEinih49vAQ8a66BtMnBg2gMZLKr76xsl5b0inEcSnxJvKM403o
         lluFfu/Q6SB+zKH05Yh0KGtwHPQ/J70YRetvO/hH/p6s6Jn7VFvAbsBGatRAOMM0InNh
         OgWszzOBvBUpuowtzGEla3N0u+ITdiTdYPCUCx6cJtdFpDlklJdSEA6YxbTvsAKGNY1+
         aH/rqua76NH+Cg7XYF8+kP1u0qkd1/lD8+9K+VuhQHnA2MFqQgiKX6IZh587zPEZoLRR
         URlw==
X-Forwarded-Encrypted: i=1; AFNElJ8VytEr3DSyWuFphBYpm/8zZVRz2K3Rbkjxd7c5qs/eircylc6RIX7KLOSeAA+vew77kwFd0gqRp6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDe6hXztDdM7FLxoHuIl8HbkxNrOY6lxnxVPpIHLHW8AnNGXDd
	2j2PbQdsm0l66qW+kXp2JVpNRC5SeoCXbnwBWHmMx1ldIaBOZdh3ZEoxgzIlVnkt1+cReYY6cIq
	aeTdUIy8Ie0fphfcUrrmDIgpapGsiqZJaMZ10qog0V+1WiQcTO5UrXJCtapxfGJg=
X-Gm-Gg: Acq92OFe5TAfdg1+C9nZZiDLe3N/gGBFk/9RVs3SH6cbgP7leKy3bRCLCfSZhPWsqDI
	ckchaKPVuiaBtgi6+btpE59OOZdQ+K3XlbBDpcGAYvoPQQlS6ColQbF/je5gCqSFqXDl9zElOwD
	AL6L4ptYuzb+9etAk1PGri8iywO1RwYaluql33pWJoKphNGrQDIHIuZuE9xvZucXv+J5KDrjcNH
	+0ggBkKVzkaDm0XoBctzP9DsZZYHDAJlfNLyCz3shwX90jVqP8YgHoZARr/LIJHHBNjCUw2BDFJ
	T04E+ewcwBVYz+tA2zAOVBa08g1BXu6+lqZsZPTcUVkiLQe235YS7S+agyAIVHw7khmQsQTZrK9
	nn47/rpitNuWsjtEg8pheOSoEOQIfKZoEHueKDN4uQurw8XkAykJjgdBlrC9GuJAnrVc5Te+VGO
	e5A1XSzUvtlitDiuSKCqBj/ahXDVI/05ptm7ptJkW/40VY2w==
X-Received: by 2002:a05:620a:4111:b0:8f8:cdd0:df82 with SMTP id af79cd13be357-914b4a3daddmr3603195585a.58.1779946269575;
        Wed, 27 May 2026 22:31:09 -0700 (PDT)
X-Received: by 2002:a05:620a:4111:b0:8f8:cdd0:df82 with SMTP id af79cd13be357-914b4a3daddmr3603191885a.58.1779946269115;
        Wed, 27 May 2026 22:31:09 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa4632236asm1671483e87.47.2026.05.27.22.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 22:31:07 -0700 (PDT)
Date: Thu, 28 May 2026 08:31:06 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
Cc: Komal Bajaj <komal.bajaj@oss.qualcomm.com>, Vinod Koul <vkoul@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Yepuri Siddu <ysiddu@qti.qualcomm.com>, hbandi@qti.qualcomm.com,
        rahul.samana@oss.qualcomm.com
Subject: Re: [PATCH 14/16] arm64: dts: qcom: shikra: Enable BT support on EVK
 boards
Message-ID: <6lkpmjtpozsfrk6ljnzwek7q3kgj7t6cjzre7k5vijx4ta6apu@bdotfbblxpu3>
References: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
 <20260525-shikra-dt-m1-v1-14-f51a9838dbaa@oss.qualcomm.com>
 <rbu5oub4uc4rubdlfth7undrirlyfwbnst5clgyvm63fde3tcw@fulet3k3a4sf>
 <30a33da1-6424-47f3-9e7e-a09ca61a1234@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30a33da1-6424-47f3-9e7e-a09ca61a1234@oss.qualcomm.com>
X-Proofpoint-GUID: Cc3JiKSo3S6ShHTnmTiEAIYnMbOHwO3u
X-Proofpoint-ORIG-GUID: Cc3JiKSo3S6ShHTnmTiEAIYnMbOHwO3u
X-Authority-Analysis: v=2.4 cv=CaE4Irrl c=1 sm=1 tr=0 ts=6a17d31e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=o6hecVIOLF8SStibk4YA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDA1MSBTYWx0ZWRfX/J85FhUVpc91
 44K1YmtaSdMg1THe74qzJWTX9VOZyl2exYj/eaR/JLfZ31bB+d4W58ck+elMEAjOXCb6Smslnee
 nkigLIgz1OH4Wly9XUxGlLcZevUEFlClQqdhyTYZDLaPUqZbsVDGIJP0kkVZO3mJcCBJwBasTDk
 c2VV/urgknzgdK7dvMJ5BayU/WLyRYuH9iy6JH4N177SF5ediMWLww/X86bSC7FQTb0VDi2ww8Q
 RJSgrzJHlnAXo9f0cgIvuoM/WGn2StpLiOo2/lyR0gMBK8y8WsfcSUWzfykHjRKaIVGWemb6byC
 +/cUMuJ6K/RGC3QMXRIZxjmDcFvBDC3sVfAC8Z4YGEF8/Y+zHB/JQzBTJN1vZAvNeLhM6b/mXTu
 XWSwvdtOCSpCyUdwgvFTOukeZuAmMdstFQi8WXVqBb/IC8Vqmpwx1XRwEDVyMjIHWph/kGWTKf1
 kDFv5ESpWowe826ulEg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_01,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280051
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10988-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: 6CDB95ECD1F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 06:53:30PM +0530, Yepuri Siddu wrote:
> 
> 
> On 5/25/2026 3:01 PM, Dmitry Baryshkov wrote:
> > On Mon, May 25, 2026 at 01:19:18AM +0530, Komal Bajaj wrote:
> > > From: Yepuri Siddu <ysiddu@qti.qualcomm.com>
> > > 
> > > Enable uart8 and add WCN3988 Bluetooth node with board-specific regulator
> > > supplies across CQM, CQS and IQS Shikra EVK boards.
> > > 
> > > Signed-off-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
> > > Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> > > ---
> > >   arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 12 ++++++++++++
> > >   arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 12 ++++++++++++
> > >   arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 20 ++++++++++++++++++++
> > >   arch/arm64/boot/dts/qcom/shikra.dtsi        |  7 +++++++
> > >   4 files changed, 51 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
> > > index b112b21b1d79..259032bd20af 100644
> > > --- a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
> > > +++ b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
> > > @@ -16,6 +16,7 @@ / {
> > >   	aliases {
> > >   		mmc0 = &sdhc_1;
> > >   		serial0 = &uart0;
> > > +		serial1 = &uart8;
> > >   	};
> > >   	chosen {
> > > @@ -57,3 +58,14 @@ &sdhc_1 {
> > >   	status = "okay";
> > >   };
> > > +
> > > +&uart8 {
> > > +	status = "okay";
> > > +
> > > +	bluetooth {
> > > +		vddio-supply = <&pm4125_l7>;
> > > +		vddxo-supply = <&pm4125_l13>;
> > > +		vddrf-supply = <&pm4125_l10>;
> > > +		vddch0-supply = <&pm4125_l22>;
> > 
> > Use the modern (PMU) bindings. Also please add WiFi.
> The modern PMU support for the WCN39xx family is currently not available in
> hci qca driver, that is why we have defined the regulators directly within
> the Bluetooth node.

Of course it is, see commit 9f168e4de5fd ("Bluetooth: qca: enable pwrseq
support for WCN39xx devices").


-- 
With best wishes
Dmitry

