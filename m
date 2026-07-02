Return-Path: <dmaengine+bounces-11961-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FMk4KmBTRmpkQwsAu9opvQ
	(envelope-from <dmaengine+bounces-11961-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 14:02:40 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E30BE6F73DB
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 14:02:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=bLYg0owq;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=VCF2lr5I;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11961-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11961-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 591EA30158A8
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2026 11:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFFC451047;
	Thu,  2 Jul 2026 11:56:12 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D7C4229B7
	for <dmaengine@vger.kernel.org>; Thu,  2 Jul 2026 11:56:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782993372; cv=none; b=iJRqvazktj/IKr8W0WeME0Ks7rVH/6QYTFEo1+tHUenKDnW18REBOUADP+4C2WiN7lzSlprtMKpUfO6XSUX93++rkqQn4bnWkW/2rzr1L67nEspjKFXX0756TOmXb4LmtatNyfR6mcPRmPBHUlqlvMn1x8KBi6GBbtC/EzQOUMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782993372; c=relaxed/simple;
	bh=nB/zMxB9x6TdcDbMP1nhGGG/kEhO7YibS2cx8eu1P00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLdPhtLrxQwniS/c1Z3l6urp8TApSWbfRl43TWdEgzEC9wl0UgoTPph+pLEpnKpoypoYffpwNUPdgzlJPXHSr9qLUgLokO4x+ktjxt/hz0AopeXdcLqR2ofJ0KWXxhEAaZ6BtTwl0x16veUYy1gRQvmtdQABLYCCw0/G3YhAA8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bLYg0owq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VCF2lr5I; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6627TuiR3964270
	for <dmaengine@vger.kernel.org>; Thu, 2 Jul 2026 11:56:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=8rXPAj7Jv6FwojH8z1SXt4q+
	7Q7RDsm6ISneeiOt8LY=; b=bLYg0owqoLkCpZVkzD69fgd0iuzReoP3MvXXOj4A
	ngjIaj9SuGtBPq3ki56VbaziiIeqZCLhPWvN/hCcOiEIVXA32lk0FcfBTeKFPIsn
	5uX1OrrlYXpptg2qPu0y/cMBKP9N9oqw7E8kc48KSQB/opp8rMq7Sm2rup3FeZuq
	BnSl/DCkX/dAhwZRWUzCa5+mcGdBZHbJUvpTAIrfJcgs+zH4QCSOcDwn6WHQDxF6
	N/yEoLMe5mCeObQcVi5Vi3K13varJ1EmWEdVK+g5wwqftrQ+eiSC2wBEVqVLgOUu
	trYfZz/0/flAJHyyety6hoGwkhkfHLbLzp9JpGkDNkEBEQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5knc10nr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Thu, 02 Jul 2026 11:56:10 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e82060977so66770185a.1
        for <dmaengine@vger.kernel.org>; Thu, 02 Jul 2026 04:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782993370; x=1783598170; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8rXPAj7Jv6FwojH8z1SXt4q+7Q7RDsm6ISneeiOt8LY=;
        b=VCF2lr5IimxYUqTqbBMkMyQw9Zu8DbWuz9UNlI05jjnqS5TqzxrMENm/SUcoJthEuq
         gmRL9035/4F83+/Ut1u3Jt6Jpm7zXevi8STRZwvRlmanO/p5eh926vfAaPAShHyh4VoV
         VWBKlPxnhQAnJ9txuUJrDhnF1TQ8KGh+S8MujqJE5xXtQw2D7KS5LPFD6yg2vfG8N6K0
         071V5qTDMUSnhWEFE7o8lxwxx10pO4AijBhYsdLBknYZP+8XO/y94bt1IK/5zsr3htBC
         JqgdBk1q0DuTvyDPfa2CmJWTWGoWhE/zyjMrSXm0olClQP8lnV1fYYqjBgbE5DFOzygX
         Aapw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782993370; x=1783598170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8rXPAj7Jv6FwojH8z1SXt4q+7Q7RDsm6ISneeiOt8LY=;
        b=lzaEwYZkUKSYhmpfM7fCuTYJ01QZIRZLSKwsAm4oX2Xm5I1VlqdnUBqQSVRUlBDIVW
         vXgTSs0usjfQNL/keaNkvXUEFBzEw6gjpZpUiLCVRmhoy4jZwQvr0X+FT16gYhfA1qV/
         VxSLtCFnLz2t15yv8VAjcnw6mSY12kPGKkNaaIUvFhv0Ww/EXri12HhoEQ3YUHmTto9m
         fFLmHdRBT+S5MPw7miTE3BRw6WmqY8Hz1tDIC5K8RujbhkdgB6fgKg24LnqLNOC6uq2k
         XozXusaHk2nBQ6VIAukleRBJZ/of4XEoT7i2JGPhBCr8W0k/UNG5/G00/di/2bbXd32J
         e49g==
X-Forwarded-Encrypted: i=1; AFNElJ/+fIrBhkgQbOPhFONkvaygOjYBQbYA3a/bgoCDAeZJgBael8U6/F66cgQuNA3vNUGy/SCzuSqlGQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdae0wpMBUS5vMh+nEvWwqAGzScWKf+ZHY+NNnVBMyI1dCK3/u
	PI8Z4MXe06qxdLFTDUFbF3g2qjVggoqyaMEhQULvknmr7zw2WOWNsCStpN4pPM5ZVflwC5SzG1+
	IDc8zjGaCYLJLEAtVYf5D+fQyyr4UQLtJioelakGa0GyWVvavn8F3n13noYD22qM=
X-Gm-Gg: AfdE7claSFvi2VWgppCTuMgcR4pl8w/yiPwkFzyXECBwWdu+xUX4WPIm0tt6qheUWGd
	2sq/wS2w0slZzuI3aQ/B4Oqqk+nsWP1Hry5BoafZhv+L9bPfFmUBhDyYd9ZNz2jjCvTXZIsW2LK
	NW3DadKVowI3o83waJ3Jk+yJXDXIyFUb5HrQlOijBAWP5WoSO6QWtcsrOCt1LnjrW5DHEUibe17
	0n+7LA77FUG4iRSKrBCTmfuKl0FUr429Hpq/5Vwu+kuV/GhNahatfQvYTiQw/bbbgqvji6s4Vg1
	Qn+GVCwNLAj+XvnY6cgU9sSv3ppZveOJXEj8BZAX/mOREB0DjKCA3gmMblGWcmAd35QAHkgDNts
	mu2/co2g5X6KY3E+T4lrYzIj8qpXUfKWEOR5HJKYNFBpM1jm6K0aEuWzPNtW1WgPIRDMSjYLgg2
	BTid85ASyLuQf2zUZfTTHUk69C
X-Received: by 2002:a05:620a:2b97:b0:92a:f74f:904 with SMTP id af79cd13be357-92e696af821mr1226287785a.1.1782993369624;
        Thu, 02 Jul 2026 04:56:09 -0700 (PDT)
X-Received: by 2002:a05:620a:2b97:b0:92a:f74f:904 with SMTP id af79cd13be357-92e696af821mr1226283885a.1.1782993369079;
        Thu, 02 Jul 2026 04:56:09 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aec89dc064sm613173e87.62.2026.07.02.04.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 04:56:08 -0700 (PDT)
Date: Thu, 2 Jul 2026 14:56:06 +0300
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
        Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Subject: Re: [PATCH v5 10/11] arm64: dts: qcom: shikra: Enable Bluetooth and
 WiFi on EVK boards
Message-ID: <zjvb6i3rahc2kwojxrg4cwaqtddcho2nj3sfcr63xkkrm7tdd2@2yl6rxb7rtcb>
References: <20260702-shikra-dt-m1-v5-0-f911ac92720c@oss.qualcomm.com>
 <20260702-shikra-dt-m1-v5-10-f911ac92720c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702-shikra-dt-m1-v5-10-f911ac92720c@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: bm_GJKdMcZD-zCDKMsueEZjYZjzXzLTx
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a4651da cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=kGXCqVC9NZuRQAUF07cA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEyMyBTYWx0ZWRfX5ispjsNDrGO5
 s+OK6mj2OQPPDI0wQvIN/F2Hnhzazr/fgFqKPsbEyu9o87fHN8KLBqsoM4lr3SMDCpMa1gc02S7
 9ERJtZZUusitYTICykKkII2v5wGbC2Q7zZM7TToZ5byPKfVhCZNZjDBhNIyfvek3SL2gXGnc934
 6dkkhJiuCyL4dCi8adfZbIMl42S3fVVGYX0GKO4ghKJ8mxE7BRbnlVhTaaZ8XMNVzZ+aSOZZD1O
 ko/7GB1tvABIqHvGmBs6fHst8ugdqy5FJSYOeBY30vmnZq6aL3vzcU6LHo7Iohzl8kuFjbAdFqy
 YlCXka8vpOV1xHdnaWX6h9a3vFmKsdr9ZjaTloj8pkVd1H8ggu9ASSuA4BGk8VDYFUlLHhP8ut3
 QyJeuM3TCIYWvg3495EqbWQSQDOe7YF/6BoO60Y+xAP9uPSqYAMthVP77gqyMaGGnMGK3egCNf0
 /yOjdZYlZt5LtFLY2ag==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEyMyBTYWx0ZWRfX0hO0qLm2rSJS
 Zws2NIXw3wbqb+nfQEA2rlPmAFRI6AkkvnvaUCJob7d/O5F9iwfPNszpSFV12+4VqYxi4jqNtUp
 b2BxGRXqfQX7PHuR5jV8GB9GMIi69zI=
X-Proofpoint-GUID: bm_GJKdMcZD-zCDKMsueEZjYZjzXzLTx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020123
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11961-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:from_mime];
	FORGED_SENDER(0.00)[dmitry.baryshkov@oss.qualcomm.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS(0.00)[m:komal.bajaj@oss.qualcomm.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:krzk@kernel.org,m:djakov@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:yepuri.siddu@oss.qualcomm.com,m:miaoqing.pan@oss.qualcomm.com,m:conor@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E30BE6F73DB

On Thu, Jul 02, 2026 at 03:20:52PM +0530, Komal Bajaj wrote:
> Enable Bluetooth and WiFi connectivity on Shikra CQM, CQS and IQS
> EVK boards using the WCN3988 combo chip.
> 
> For Bluetooth, enable uart8 and add WCN3988 Bluetooth node with
> board-specific regulator supplies across CQM, CQS and IQS Shikra
> EVK boards.
> 
> For WiFi, enable per-board with the appropriate PMIC supply
> connections and calibration variant selection.

This is obvious from the patch itself. Don't repeat patch contents, say
something useful.

> 
> Co-developed-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
> Signed-off-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
> Co-developed-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
> Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 18 +++++++++
>  arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 18 +++++++++
>  arch/arm64/boot/dts/qcom/shikra-evk.dtsi    | 61 +++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 26 ++++++++++++
>  4 files changed, 123 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
> index b112b21b1d79..c9409ab0a3f1 100644
> --- a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
> +++ b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
> @@ -16,11 +16,19 @@ / {
>  	aliases {
>  		mmc0 = &sdhc_1;
>  		serial0 = &uart0;
> +		serial1 = &uart8;
>  	};
>  
>  	chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
> +
> +	wcn3988-pmu {
> +		vddio-supply = <&pm4125_l7>;
> +		vddxo-supply = <&pm4125_l13>;
> +		vddrf-supply = <&pm4125_l10>;
> +		vddch0-supply = <&pm4125_l22>;
> +	};

Is the WiFI/BT chip a part of common schematics or not? Why do you
define power supplies here, while the chip itself is defined in a common
file?

>  };
>  
>  &remoteproc_cdsp {
> @@ -57,3 +65,13 @@ &sdhc_1 {
>  
>  	status = "okay";
>  };
> +
> +&uart8 {
> +	status = "okay";
> +};

Same question.

> +
> +&wifi {
> +	vdd-0.8-cx-mx-supply = <&pm4125_l7>;
> +
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/shikra-evk.dtsi b/arch/arm64/boot/dts/qcom/shikra-evk.dtsi
> index d0c48bad704c..4b7be09eb5a5 100644
> --- a/arch/arm64/boot/dts/qcom/shikra-evk.dtsi
> +++ b/arch/arm64/boot/dts/qcom/shikra-evk.dtsi
> @@ -3,13 +3,74 @@
>   * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>   */
>  
> +/ {
> +	wcn3988-pmu {
> +		compatible = "qcom,wcn3988-pmu";
> +
> +		pinctrl-0 = <&sw_ctrl_default>;
> +		pinctrl-names = "default";
> +
> +		swctrl-gpios = <&tlmm 88 GPIO_ACTIVE_HIGH>;
> +
> +		regulators {
> +			vreg_pmu_io: ldo0 {
> +				regulator-name = "vreg_pmu_io";
> +			};
> +
> +			vreg_pmu_xo: ldo1 {
> +				regulator-name = "vreg_pmu_xo";
> +			};
> +
> +			vreg_pmu_rf: ldo2 {
> +				regulator-name = "vreg_pmu_rf";
> +			};
> +
> +			vreg_pmu_ch0: ldo3 {
> +				regulator-name = "vreg_pmu_ch0";
> +			};
> +
> +			vreg_pmu_ch1: ldo4 {
> +				regulator-name = "vreg_pmu_ch1";
> +			};
> +		};
> +	};
> +};
> +
>  &qupv3_0 {
>  	firmware-name = "qcom/shikra/qupv3fw.elf";
>  
>  	status = "okay";
>  };
>  
> +&tlmm {
> +	sw_ctrl_default: sw-ctrl-default-state {
> +		pins = "gpio88";
> +		function = "gpio";
> +		bias-pull-down;
> +	};
> +};
> +
>  &uart0 {
>  	status = "okay";
>  };
>  
> +&uart8 {
> +	bluetooth {
> +		compatible = "qcom,wcn3988-bt";
> +		max-speed = <3200000>;
> +
> +		vddio-supply = <&vreg_pmu_io>;
> +		vddxo-supply = <&vreg_pmu_xo>;
> +		vddrf-supply = <&vreg_pmu_rf>;
> +		vddch0-supply = <&vreg_pmu_ch0>;
> +	};
> +};
> +
> +&wifi {
> +	vdd-1.8-xo-supply = <&vreg_pmu_xo>;
> +	vdd-1.3-rfa-supply = <&vreg_pmu_rf>;
> +	vdd-3.3-ch0-supply = <&vreg_pmu_ch0>;
> +
> +	qcom,calibration-variant = "Shikra_EVK";
> +	firmware-name = "shikra";
> +};

-- 
With best wishes
Dmitry

