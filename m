Return-Path: <dmaengine+bounces-10849-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBUGMCcUFGorJgcAu9opvQ
	(envelope-from <dmaengine+bounces-10849-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 11:19:35 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2667A5C86E2
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 11:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 842EF3011BF4
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 09:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073753E4C62;
	Mon, 25 May 2026 09:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DZ2ogOOh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Yougnboi"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6E22BEC2B
	for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 09:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779700757; cv=none; b=QV80gubXImB0wgsi44LqGp1AYU3ZHOlJpFrvNcUoio2vHL7ahH1MOdGDr6MzqSE8NRtcxFJz5DC0a2RiwOfz5Az2evJ7qaI2GpeQTeADjWoKYoeAGyDz1mzeCJOVY7u0mCnOcp/CiX3Q0TypJ/87zTVEkweAfitT7VoY2dvyRDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779700757; c=relaxed/simple;
	bh=wUdMiM4gznb6+rt3vTR+q6cMpxLdznGhivqWLAYNrG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B5NwpnNaxWX/2KzzsXemTR5ddiue039Z53mbtTPN7TvSQabXAsAQyKJm5k6VCHBl95lzpAtlTRQ4zOvQQ/GAdRlN/4E0oKpNR+cBcMO/m80PGLinHXKAgXudEoCfKzSJ1uLiu8C4u7pE0h2v0IuHYRMGaSTVxaIjfuso1yxYEZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DZ2ogOOh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Yougnboi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64P3EOQP3816637
	for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 09:19:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=bmgCDfsrFew+pg6RojZwQYb+
	pd6o+Ri4V4tsZlDZDeo=; b=DZ2ogOOhcNvpHlFCfgpKqgyFLqn9yO7FArZS5Paa
	DPpSUGk+80vPBbIJyaEp9thVPUMwsbRgEmPmIu3TzjGsg4DQshxGnV2h+WNybQKJ
	W70mbM51yCHCiCDmgbpFVlGjk1AmL6TzdZPC0YaceT4qGAWy7maCjH6OtveKq/zd
	d3zyvlOd4cpUiTUoACK6LKIegS4tT9gKII6/RdDLORqDcPEaR10qG3BUn4ZbO8G+
	6ApEAtsa57iSR/dE8bWNw/ylUaOA666WeBlz3H1YdUNkoy7/f4BP8qbCBu0jOAlT
	+Bqhqq/nNYdri/g065Mua9piP+NHkFItLcTNnNMY3MRlWw==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb3txp00m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 09:19:15 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5753ef2562aso6989308e0c.2
        for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 02:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779700755; x=1780305555; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bmgCDfsrFew+pg6RojZwQYb+pd6o+Ri4V4tsZlDZDeo=;
        b=YougnboiE8xlKuiDoElCBh3mR1ilC2hCb80HcEuW2UR0navXc+DCOjL95Jdwgirdsk
         CAF+h9y4O/85XwisdIVKIdE6XitEMt4CjecvTnsfori6y8Irn1Q36F/UE3W6sgLdVbzs
         q/Dsp4rUnDdOeWVARCJBXjTgMnyUXz+5Bk/y1HjPs4F0OKdI3wFxVq1Lwoy+zqjN4Q9K
         9gBVHngBSHxyXwfIuxgKJ+YBTc1VoChvGweexR6Fi/lZ3L+fbwEmHfsS1qSy+QFASGxI
         WoXSIBG05cJv0bc9cpwhsqVBJI0rf+oTuvMGOk8pbefT32/P5LnVJ5Yif/XK4zjrvu1W
         Uxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779700755; x=1780305555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bmgCDfsrFew+pg6RojZwQYb+pd6o+Ri4V4tsZlDZDeo=;
        b=RrUzEPe7ZhOOo9n4GwOcvDQbWemJb8I5ldxVIY5EeXJXY2eF0ReVXkj6SPqOizj/Zg
         HZ1/+bhacfvfc7CaSK9uoG1nybZTKHB6OR4JnO5h7LsidtBVjHSr5KaEQBvQ3ke/lgRZ
         hY2u4xc05B8of9S4kmeXHMLpw/4hT/96mus8W6xGwb5xh4REXSzW3Hr7JREMweCNoPjE
         vc5cfNzAKukqW9ajoPEzzKsUan4ZjfDF60mqHmJ6i89wd2eC1+2FuISkfKn2v0eJXW0g
         XETsCwylwLzE55sk31rEeuRgHzDyb4aX2PojUWM7k2r7BH6QdjocxfJPHZIqMOKCD4I1
         5kug==
X-Forwarded-Encrypted: i=1; AFNElJ8ciZ3D3ZnQVbexJxPcj78ndC2ZvWaHPivBowRz8dsETMLrpAFwt7/eF0TUQUPn9Shysbatn7WInTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxDUUawuCZfJFt0eC0z9Dte0SPA0oofDH2J6MR+04xkp3ZttiW
	QAId2bnCrnVOsf7fjPMHmQO8AW3DGysatqJizEuIX/hGKo4I1Lr2mdi1u9ONx4nCnu6P47u9Fxb
	zCzKtkLO1/AHrlWISmLzRuanLtbbItgIcmEVX3FfMU2yOnorOcKR7vmhyGGrdl6o=
X-Gm-Gg: Acq92OHSlLPcCcGzy5ZjmDjN/w6zPR3WVw4R3NH2FiTiKG8ItsWkORfy3SOW4I6vP9P
	FEvoqZjqPj/LZu4EtQPU1OTnayz8UcU7CiWPNVb1BBXgybAEEUUo/fSNQIhAQ1NVs0MEQqLMDx0
	iVxp9csbMNXFJ+0XysRtRDJaFrKrzSNCvl006hEsegMmGQQAFopccwUttoXACt/903WK0XsLSCt
	tiTg0FK3WIGmO/9yWXxmmaG8qi5acX/fGhVpYkoG6kWB/LA+X+lMHcrBmGTP2Qm4w71AogOpO1p
	66B27Wk3zX7aPxdIhIlrfVHJIOmpmmjpWMNrBKnV1dFFH/p/HQ0BVwkbyj15Im5opF9RrkIZnyX
	VOXWkgsStb1WiRAMjSYjDr8MJjrll3kG9zHTLQACvQQmSX1kIl3GH3oxTtUsdIBDXM8i4cqpzBC
	35UFcIHzoYhreS8Yz6t6660Lio4v1kANZSRcc=
X-Received: by 2002:a05:6102:418f:b0:660:d26b:5077 with SMTP id ada2fe7eead31-67c738b7be1mr6149847137.6.1779700755007;
        Mon, 25 May 2026 02:19:15 -0700 (PDT)
X-Received: by 2002:a05:6102:418f:b0:660:d26b:5077 with SMTP id ada2fe7eead31-67c738b7be1mr6149831137.6.1779700754643;
        Mon, 25 May 2026 02:19:14 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa32cb369fsm2511211e87.15.2026.05.25.02.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 02:19:13 -0700 (PDT)
Date: Mon, 25 May 2026 12:19:11 +0300
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
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Aastha Pandey <aastha.pandey@oss.qualcomm.com>
Subject: Re: [PATCH 04/16] arm64: dts: qcom: shikra: Add cpufreq scaling node
Message-ID: <aibebzgnfdvfnb7hapjoym2ruawpsx7qbtedhyvn6b7gd6dqnk@3l4scbc74wsq>
References: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
 <20260525-shikra-dt-m1-v1-4-f51a9838dbaa@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525-shikra-dt-m1-v1-4-f51a9838dbaa@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDA5NCBTYWx0ZWRfX1ZnGEh26pnbo
 VBybMtSaKuN0nOFtUTsw+1HV3B8TrLaQf5LophqTLyDJIPbSLYexKbzluJGUfzpj2e0JMM6ACdV
 ++Lr+ydVWOgTfXEKDYfB1DPb/zCg/rLk/2Aowjv7qeCFvGhK4VUn67kb5nOF3D00ufJ8wyGbVWg
 Bd42RREdnJr5CFc9jzc7Cnz26k9e56wMyooka3DWG7flem+EQMjUD78C4drugTxxlsnzx3uDWnc
 o3usp4ggJ9P/WFKFpsiNlQMWrj8go+pbJLNhqPAM4zCosbga0vLUzDY+gRU+YCirFsM60kxaRin
 1sghNRWx9F7JMb89oFKTV89WDdcXPr0eQ98zB/8l7YWeyk8G3V6xhtTDmbg/+D0BkDesRWb2Lp2
 O63z/B9VS5Pq9s83XmjZHnmXE8EMLfpwSnLphXdIDaP5ewXFOMvGe+ggEyCRu3zwBSVY16uM0V1
 iBaQ/Iu+3B095Cp+H8w==
X-Proofpoint-GUID: ij0pjJrTdzx4TYME4c4OsSjzsTxfL3R7
X-Proofpoint-ORIG-GUID: ij0pjJrTdzx4TYME4c4OsSjzsTxfL3R7
X-Authority-Analysis: v=2.4 cv=MetcfZ/f c=1 sm=1 tr=0 ts=6a141413 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=gR7PYC-x2pxtVi67x8UA:9 a=CjuIK1q_8ugA:10 a=XD7yVLdPMpWraOa8Un9W:22
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
	TAGGED_FROM(0.00)[bounces-10849-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
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
X-Rspamd-Queue-Id: 2667A5C86E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 01:19:08AM +0530, Komal Bajaj wrote:
> From: Imran Shaik <imran.shaik@oss.qualcomm.com>
> 
> Add cpufreq-hw node to support cpufreq scaling on Qualcomm Shikra SoCs.
> 
> Co-developed-by: Aastha Pandey <aastha.pandey@oss.qualcomm.com>
> Signed-off-by: Aastha Pandey <aastha.pandey@oss.qualcomm.com>
> Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/shikra.dtsi | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

