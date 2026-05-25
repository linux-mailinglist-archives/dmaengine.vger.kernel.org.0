Return-Path: <dmaengine+bounces-10850-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIpAFFYUFGo4JgcAu9opvQ
	(envelope-from <dmaengine+bounces-10850-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 11:20:22 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B43295C8720
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 11:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8349E3005D25
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 09:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218D23D3335;
	Mon, 25 May 2026 09:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kLo30QGN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PbANSB55"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0AE2BEC2B
	for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 09:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779700790; cv=none; b=IN9SLxfaapTDiDGfjkU8t+dfzkyfQdwiPbDkPIW2u1Sv3+FvlTXtQRGFfBBCpRSyIqfWqIpK8y39hkDt8PRP6vOh2vJkiJf63Bl7BAqRkTsxtAbPWoeXy4NJ1FEKFj35QgkDhFcm8NcPE15FGGoU5XoCWJUyiFnvfikPHtL8GpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779700790; c=relaxed/simple;
	bh=NMWHkTxNy2mY9CbN/4Pzkn81alBbBSyaCV+OGmHpNe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n3mlZdT/Lk0m4tmAM85YI5FDWRh9TVVptipCamOnzy2+4gtzxcAm9EG4lcQhjFMLGomNGTuiB8iIqnFpn9ZlAiXeaC17m0xkw2QxAaBM+tfJjelLTFAFvycR0q+HJTx5EdaiCnAcq2bXnnjQEHBROok6K3CDSTjLchThcR1t+pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kLo30QGN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PbANSB55; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64P5ZWKH128127
	for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 09:19:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=BavdLDn43DqP7dnx6Q1ZiNLC
	40D+9S2q6v2HPybJae4=; b=kLo30QGNqJbyT3FZzykWbOdwvTFF/VCiAbL4fGmu
	JCOd0cytRCB3Qyg/IPJ4v98i9mENoc9yjY+FJ0jDF8u92KuuNB2P+YXiuaCBqEBb
	7oxlDa08S3n+22LVDlmu6FAVHqR878afCSgXx2zipTAEdBlktG0bcPZmLepZUhoU
	0ylzmKrQDmnXV2rYzLo5/QwKy0qS9lLI2gau0pwrPyrozWDAFb7k7M5O2bHehY5O
	Qk0V2Vl7HblYkyLA9dPj++VCgxea2aRE96zpZUlcmaRx08mVVD3fpJMSfsqAIgAH
	pm77Vky/ay3ygHzsW44KdzONOUhbXtvWFT+Pg/If6GNWow==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb3txp026-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 09:19:47 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-516dd6e4ed4so54717861cf.0
        for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 02:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779700787; x=1780305587; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BavdLDn43DqP7dnx6Q1ZiNLC40D+9S2q6v2HPybJae4=;
        b=PbANSB55F/n0nbl72tJiPOX6nrdaKnbm9plHaHVPUnafkNghkAQ5emWqax9s+bNEGY
         YhxGAtlDcbrNb99570EWvTbac14h5mltNqhdXw0aau1Tvxx/kg1GpzVxC2MDqP1Msq6K
         P+H75JcBoyc8FzqwE8eVeKQ76ba8bMTHYeDeUHngWkga9GBkLFk/SPEdjo44hlIKeARC
         dvIGqNJD7MYFHgiBAGO7pzItmdHkfUu9UnOB0eHellIKpACK8F48RwxCEhKS8iKBylHp
         627b7cmiC5nz9VuJP2EKMHf4hMTyrbiUbCRJNg2uZ6H0ZDxaUKRd08u1LyjyL8WTWiUx
         TC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779700787; x=1780305587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BavdLDn43DqP7dnx6Q1ZiNLC40D+9S2q6v2HPybJae4=;
        b=qzKlWqxVrbdLJYsrY2ulafhJLOe5pQvDNq90tw72z3odmYjzEsWDOyTtzKLHP7Galo
         fNiUCyvN6Sj1qtMZz66bmtBPJiGhxGFg0o1VGZhoIBF+t45b8UxgKmK4T3vo1J3xfrLi
         PBTeOndzWeEkzDtKzWEHB9V+wVTY6IVXIzIOcXnMiUJdt4epaxxc3QZso3EhT5mU0WIi
         2ETBE/vRZH1kELpzNO0/RC2tYvTX2uPNQxya5X6FFM2bsbGhzTJOHuF+EM+9+Nmi3M9+
         QuRsyXiwTo4yHgU1mY9AWygl/1V7ClM9qP1/0aQzI+3iXM/nj94mVYo/dTMtp8IQbYO1
         fY5w==
X-Forwarded-Encrypted: i=1; AFNElJ8BLPkQExX1tfDThYMUwZcsRvdPISw8ucTM+wv+IZnZeTO7jtYZ/MkkQHc2Cl+tMIlwX8cOITQT238=@vger.kernel.org
X-Gm-Message-State: AOJu0YyglcZPJDg8j0gQWKp6y6Oos8uMKqf5tLoiHY9JOYsY+8tHlbwG
	nhrVNTOYsG1QKjJ9MUnNVHcAUhdoyGxDHghIrwUxdVhmRLbfBkeddQ85aBejSUkU3B90c9gxcgS
	lyKlx/MYDVMLcD4yuVPYhXP4t7FvyzIBF0Cii/IYdLjCzbNKZpSpwnoAC+mXqLHs=
X-Gm-Gg: Acq92OEUdBEHtRAKWpq84nzlRRbQ1eMJx1vJxnYoAXfr3ZS6c0mB6UJj8ptwa+C34k8
	eqprklpTrn9q44wkJ0T9sPM3VorZysZHh9LSKDY8C8L0hltm8PR7FRxLEZxRiDk/OLjBYQvRX6W
	zH35iNShCkAVmELPQC5uAKS50FRePP1JCozSrPRqA8jz0XP+3LAGRPv6fK+cFjoDQosxSVSYdrW
	TPowwcTcIZEj0BQUx8yjBLXva6kcSB+57Xfinbi6tDsXaXbDjXBZzd6ngDifOzvHmW++qbljotl
	VxlwrWTQ0l3ghxG7IshkhPGISZvRY6hpi/W/FUOTggH/ke1d2zRPXF/CIeXZNVjYKmubLvpMsjg
	Lvs2wVLSlUvh/OuYb9gkuQ3f9XBx6kWREtQVymFWLd2DEqT/CKdr92ef0nv8J674+S6aLspxUXM
	0mvTrt/lad/ih49PJkxGWmXC+PzBYYwcrhJdXivoUoPU9XZQ==
X-Received: by 2002:a05:622a:11:b0:516:e569:d3f5 with SMTP id d75a77b69052e-516e569d943mr100340031cf.15.1779700787117;
        Mon, 25 May 2026 02:19:47 -0700 (PDT)
X-Received: by 2002:a05:622a:11:b0:516:e569:d3f5 with SMTP id d75a77b69052e-516e569d943mr100339721cf.15.1779700786700;
        Mon, 25 May 2026 02:19:46 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-395dca5e9f0sm22275711fa.10.2026.05.25.02.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 02:19:45 -0700 (PDT)
Date: Mon, 25 May 2026 12:19:43 +0300
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
Subject: Re: [PATCH 05/16] arm64: dts: qcom: shikra: Add DDR BWMON support
Message-ID: <h7jhkbggli3l2ptf7gldjjp6g2h3stiwm3unvh7g6fli4ewpvl@idnpo53mnmti>
References: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
 <20260525-shikra-dt-m1-v1-5-f51a9838dbaa@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525-shikra-dt-m1-v1-5-f51a9838dbaa@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDA5NCBTYWx0ZWRfXz0qTA0XGDf+q
 9QVvBCgn4tTlxmaacQS4ooiOoR377qrA8sUTmN/TCHK6SVLbfY2lZQFNqi27Y3QhQ2keUQ3NsHS
 vGNl4M9tiV4JHdRwGq7OWatYLLjjmRRn7GngqvaU6NkCuGgYGWIvPpbD/L+eVucan9Middbf+pJ
 eKMxMmAip5+klILXwJzYhxY3p3EzP4BkEbqIVoMl5xoshCZqGEegv5wGmhMsxGdjrbYODo4q+Mk
 deRwhrX3XVnYdYsak+7lxQq67BmKOkK9VKtlYOItEsUlX8duqWSbn1tSFwO8jtDrrTL+2711fTQ
 At0hssqd5MDqBF/aA6NU8ktdEfwyJsz0qEUOwq1EK9COB834mugZT/UL3jJ3s+JKN+Co+E7/CZH
 +O/V/V3BEwU89iIUNwwEe5eJAtALi0FGVf/W3nkrcXiNiwyQ85kdmaM5CF8Vz+eb+ZqPrS8Ot/u
 JbbspfpWzzndTcyJuwA==
X-Proofpoint-GUID: IrPnHs6i2bQzJ8fScUELpoI5KdQ5S33d
X-Proofpoint-ORIG-GUID: IrPnHs6i2bQzJ8fScUELpoI5KdQ5S33d
X-Authority-Analysis: v=2.4 cv=MetcfZ/f c=1 sm=1 tr=0 ts=6a141433 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=cJf_ainsN7bWJEJn368A:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250094
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
	TAGGED_FROM(0.00)[bounces-10850-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
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
X-Rspamd-Queue-Id: B43295C8720
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 01:19:09AM +0530, Komal Bajaj wrote:
> From: Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>
> 
> Add CPU-to-DDR BWMON nodes and their corresponding opp tables for
> Shikra SoC. This is necessary to enable power management and optimize
> system performance from the perspective of dynamically changing DDR
> frequencies.
> 
> Signed-off-by: Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/shikra.dtsi | 40 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry

