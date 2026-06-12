Return-Path: <dmaengine+bounces-11493-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Tn+FD4y3K2ouCwQAu9opvQ
	(envelope-from <dmaengine+bounces-11493-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 12 Jun 2026 09:38:52 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B9C6774F8
	for <lists+dmaengine@lfdr.de>; Fri, 12 Jun 2026 09:38:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=h8SWiVAO;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=UCdcuW49;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11493-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-11493-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DC1C2301AA45
	for <lists+dmaengine@lfdr.de>; Fri, 12 Jun 2026 07:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2513E00A9;
	Fri, 12 Jun 2026 07:38:08 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73A93DEAC1
	for <dmaengine@vger.kernel.org>; Fri, 12 Jun 2026 07:38:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781249888; cv=none; b=KEoPVkVbXLhwETyNXQF8DR5uHnlpDq2BBSknPeQ165zffaCtoTRtqEynSrSM+bWCbusDbczKodfZDP+jDSTPE1OrZ2VekuNBEhZZfG8qMV2UWssdGpSVw91emPIOYEhZdpIJjfHQSd6Vzx3/BbSPKfiFEGduiJk8XxolXIN8ZPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781249888; c=relaxed/simple;
	bh=DOP+NEjs0aZ8AjB9Kb3C72IcIFeqDyCdhC77UBl//ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKTstBb6nafRpiV29P0NkFsruXe1PeOEURWm6aBjdObgGomVl0kjmHyxBU/ZParuiIodvPh9lXNF6iPgedQL7sjMc0Gii145Snw+jv7N7BLyQw8yDtnje8qC2GXfXa4haIpKMoYyS+iF2WclIco5/UYVpUdIhPDS5OIIcWGp+zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h8SWiVAO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UCdcuW49; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65C39NWK2475823
	for <dmaengine@vger.kernel.org>; Fri, 12 Jun 2026 07:38:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=FtRrwXijfX7jRcNOtiyO9WkT
	MQFqO0ZC2KWKNOB7OPs=; b=h8SWiVAOr/HjgZKoNKMp97PEMyff1+X+dwHmAj9x
	Jqsvu+PfBmQkjdyCDR/OT4ezsJKcW62RC22owB6l4PF1gIQ1cgdUMeNrsQxyh4gI
	KwxjsjKD1qOK+8GtryA6UVJRuYYP407gxUG/Mri/1IAdeu+M76ABVs9DP3zBMTu7
	gfo0GvoEaG+TPBP4HB8gfsRmh+/Yxm7VolXeJ2h3Dl6nbEDiOH6Orml9DkKcWXYG
	ZuEJtCKbDZG1F3bOaTqmg+EzGdAmJznz8TLvs79QExokC1PAB4oO40nGJiNc4EIU
	WkDO1UATKOvTG1Q96GvwwWvmZ1oWt1zcvr2PWsR7/57K4A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er2r5t2w0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Fri, 12 Jun 2026 07:38:07 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5176d949c58so15063351cf.0
        for <dmaengine@vger.kernel.org>; Fri, 12 Jun 2026 00:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781249886; x=1781854686; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FtRrwXijfX7jRcNOtiyO9WkTMQFqO0ZC2KWKNOB7OPs=;
        b=UCdcuW49u6DGqWrj2mOA+BPv3gyNkR+erBWzO9czokPcSWhaEGo+arhA55gNhrRXCz
         d4xc8qmPWJ/u5KgReZ3CgTXFctZweGt+epb2yODkwH7TP3Keq0KdobZDX+uog0dUeYDU
         ejErasHtznHDIGw6xc45I8NbAl2TYFKSw8HCNXTlS63+AgcB3xyIx157XwqzuRAPNOko
         L+hsi44+Upfc2bef4zaeet8d+MJ3pS6OcJJzB9Q0HeRmX1KhpSJ3mLKXdaG7I59rD7IQ
         1q9FfwkwWIq/PxnY97EMMFlPVc4WkAJHOe8KmT2X1eEV7cQsH9Zdg9PXuhzQRyJFO1aU
         rFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781249886; x=1781854686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FtRrwXijfX7jRcNOtiyO9WkTMQFqO0ZC2KWKNOB7OPs=;
        b=roOfGG4K4YoywEp4jkgBnM+L9PfDPAfCMik+fcksHQt2UivnKN3OdvXIfet9V89X6z
         ALI1Rnc+Ap5mJ396VDcnAW49L+vBqnVcQ1cc5CFbXHJABmy+Ndkllt4a5vHu9gvYHfiW
         SFc8nZKWNbMhP1RXwkDsjRLr7KPHBdDxmswlB2zRMFTg2XcgfYuTINYdyDuJHOmivfkC
         y9H5nQhl2fnD5K5bIw+AGy2go46xraVYvFCVi6M4yiBKt+o+ibcN+ohoxyViEVieYA2/
         VnRGnCt72Sv0tsuCdcaQjKkn/BnvR5sgHDmFxdPeyG2DPNNK9gb2nLmGfqFmkZTxU3lB
         icag==
X-Forwarded-Encrypted: i=1; AFNElJ/5A9eIidhV2JVhYGEQtjDhOmJv1Rk6N5uaSGlE2t8Dk1vPZjxabNiApc9ukI9sPw3tefeNcpjJRz4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfnv+HIPWVjQMNJEx+96YYOh9xbeSNa7ovmS2q4ysI/tUK1WEZ
	eEcKXwKK5mNlNTE6Bc1tXr4LEjBnLNu+pFHhYejA7N91CPgHlv4UYd+qTRJE6H419GY2ikauXJm
	VMN5zHlXF+ZuI+yLO/qMrj6gxaINpk4yknOs9uCKHqgralPz5gW33Q6g1tcVJXsw=
X-Gm-Gg: Acq92OEJhQvQLgLHeG2aX5KjWdGexBtDF2fKkjNgH8vFlo80EVGcPO7uFlGYUMYSJCR
	4mDV/B2KVF3m1p2YzKrkKRECTqNb2Uu9t9/GR9UVQ6I53gehJJ5HTZsh3yIWjycdsz8nrcFZtku
	4lGSxSXLuLKI2h7HrdRwU8jv3finCu4Um5o59CsdRqDGOzVIzRk9KozWiLOX5dHrc/LXpioIWAV
	JKbFTvnrQUUoaWZWJC+SA2dtLi170/vT4k6ZcGJv6OrxilIujcEgRtmH4cIaz5PSroX4biGMGM0
	UqLW/jTiS4YswCWj1VJtkHrXg33CxliR14KbkAQh3xxPlR0t7CnMLfe7fsC4XOSTfpxIvD6+9/M
	HkMWKHsYE2GUu8qEuOVuUElRIv7/d1/cAg0E1ktfP1Jc3lDpx9iPWl4oSRV3YouFuGixzUtF1aG
	fQuCANlHpwjCNkw9F2lvkA+6mBz03TbAtz++M=
X-Received: by 2002:a05:622a:24b:b0:517:7d9a:a88 with SMTP id d75a77b69052e-517fe4edb35mr20865801cf.37.1781249886114;
        Fri, 12 Jun 2026 00:38:06 -0700 (PDT)
X-Received: by 2002:a05:622a:24b:b0:517:7d9a:a88 with SMTP id d75a77b69052e-517fe4edb35mr20865481cf.37.1781249885707;
        Fri, 12 Jun 2026 00:38:05 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e1a7283sm302576e87.39.2026.06.12.00.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 00:38:03 -0700 (PDT)
Date: Fri, 12 Jun 2026 10:38:02 +0300
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
Subject: Re: [PATCH v4 08/10] arm64: dts: qcom: shikra: Enable CDSP, LPAICP
 and MPSS on EVK boards
Message-ID: <po2gqpbmqw2tnkjn45ywgnsiaz2tpsprr5yowe3lw4y2lxk5ga@m52i77h5ymu4>
References: <20260608-shikra-dt-m1-v4-0-2114300594a6@oss.qualcomm.com>
 <20260608-shikra-dt-m1-v4-8-2114300594a6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608-shikra-dt-m1-v4-8-2114300594a6@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: dS7HshdxOV_ouRKX6DIK7hY3Tikb7C2D
X-Proofpoint-GUID: dS7HshdxOV_ouRKX6DIK7hY3Tikb7C2D
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDA2OCBTYWx0ZWRfX30HOC++FP1Ti
 eGOUxEFMhJwduBip6SSaRmbACjNjmJIzAkcgQhzR9NcsLBfXf6BYdDM4pfcC0lb1lM4vXxP2AAD
 EwK87+b5Tl8h3wpfd/Vw9VvePIx+ZeA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDA2OCBTYWx0ZWRfX0xmvCeBob26/
 9TD3VCH5J3yICaLxjH3bfJ0vdeLkrgOYvCkk/EILM71/juz6K85BIBRtStLJQ7gmVmI6tujMciG
 PYYks4/Ojyt+u/dBqgG7mLV4Ptu66NWmJj2LRsOJTnnvo/bYJ/CsCuQlhj9wklM3s6HRqzCWU3g
 OUq7AMUFzojXTRNkZB/HPdUeP3P2OHNp1s84z0ECb93EeFbVWKOwdblqrXwhZBc6diRt/RLGXH9
 q0JodbdgoDvmBQ+HSc811MLFRfDKNEvK0arMIjm5ptMom85i7N1+GzPBRVBDWYPAD4SxmFivif/
 b7Dcyq5Fw+4+ApUJExW/53TMEpSuARXf4rWxByYNEG5hk+KrFJhQjn+8b6GknCi0CVZnPyD+/DD
 s/j04JMyxXjV27LCwrNIRwVa0jHO6TSQmZOTa42YRAt0kJd9qQ/YXbkzpP8Ws6dMiUmI/gSoLJy
 17YgLIcDMrn0NgKbe4w==
X-Authority-Analysis: v=2.4 cv=M6p97Sws c=1 sm=1 tr=0 ts=6a2bb75f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=2wNq6JH_cIzNK18R0_EA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0
 phishscore=0 clxscore=1015 malwarescore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120068
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11493-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:from_mime];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C8B9C6774F8

On Mon, Jun 08, 2026 at 06:40:28PM +0530, Komal Bajaj wrote:
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

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

