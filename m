Return-Path: <dmaengine+bounces-11869-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qDskEFOGQmqA9AkAu9opvQ
	(envelope-from <dmaengine+bounces-11869-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 16:50:59 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FC46DC4A5
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 16:50:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=NS95HeDZ;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="Ygz/Ex3y";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11869-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11869-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6AF693016C0F
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 14:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A3641B346;
	Mon, 29 Jun 2026 14:39:01 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F284192FC
	for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 14:39:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782743941; cv=none; b=ugmeV6IRnvlqai7YL0bJov34ja6N0VKBRzpf3wE0E18j/dmaJ3Kju4uJRRO3G+oivfx2TjfgjIRSGvhVwOGEeXKVYGmv6chL8AzvCo/owF3ex4QfTWn1gYGp/DmQctMYvqzCmT7W9tTqpGDcHS9UzgXYyuJWn//pN56JEI3wUyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782743941; c=relaxed/simple;
	bh=dJ2JTp6OFiB0mDOUeLX87yYQ+VnXucP5xQ/OK7M2m44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cVqQwEHD/UkqqSD/VGkLBBV94LFQpKLNB5+68LN6j4sszL2K7oV1mT61cs0YTJTMZsMieogqGaFGHuYJ1vbLgLmpZAisuT3FhnM0bYT1JxIPblth2tD6X8rA2NOHPheisv8gLsiqlxhfJt3Cv0qQgyW5eVUItxp82SdO5zSfvFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NS95HeDZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ygz/Ex3y; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65TASqqL2601127
	for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 14:39:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t9F0ZQvdgCZ175pSXQOqitXo6ftMA07Jyq3N/MCBR0A=; b=NS95HeDZbikRVR2L
	CDbdAEuKNbD4Bc/z8M8aR3CAtyBF/pWucf/5uTVV0RFapYgsHjzPYc4FQLV1+t88
	/rIEWdm8GIkJ2Q/EXFtwmym8tJ+hGgo48rfkq4W1YDciQn3HpmwsHP5FRQ4O22Ey
	v9JQJARm571mVhShSfQ0RJhYLw2XEUzSsGXd7lSqDm6QPJh02Vm4sXN99yuSTZf8
	JPTIY2eC5ASHR+FcCF9jq5zv7lkIA3/FVqLyqLj8Cx2U6eBtKCxUCTs7H4LFV+Td
	y3Q54UfP040JuLQM0li7HYENa1p1qNVT6gOKNvgi0iZ171F88OJR1awSjGJDR1R4
	McZEKA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nnw9bc8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 14:38:59 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-734f7d8bb37so283943137.3
        for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 07:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782743939; x=1783348739; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t9F0ZQvdgCZ175pSXQOqitXo6ftMA07Jyq3N/MCBR0A=;
        b=Ygz/Ex3yySJCXWmnYA4yiIVVdGT7nZDFwQRJeYDzNFR1hM93TtfBimbbn1khwNBGEj
         ML6M5L/W9lG1OiXrkI77CIpNCxmxTzq7u0x2lvkpnRuZRU+181I6O2KYPvXRKOA9x2g8
         EREgT0S4rVBqGEQ0I7B0kFKtkTvo/v8lL9PykOFrvmX0cL/7YaLlZ001otz0dyOeWeV1
         aU4Y6ui2gOSaBotrvBCWnMLWZnOgNlRIdAiFAduSYaCdnVnnys+rGSqva9nTMQ9/2czL
         gax+4c8dCWlx2+k3f62GxXw5bj3qnArxq7PPlp4cg303ohumvCwcMcI0sEB9CtRd0/Ox
         z/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782743939; x=1783348739;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t9F0ZQvdgCZ175pSXQOqitXo6ftMA07Jyq3N/MCBR0A=;
        b=B2UUIKFJrAhMPAlS4clQoVz2LrcHxNSaLkwYIaKTVcOPQDwntCMV/HlKl6LXOuPNAF
         PZm4a4Kjg7ByMZVtJkr1lwlvbV6bpYihYu3m8wNrfsBY7CB0brBYTM8qasE0W+n9Og+p
         zOdr3pohMi6Q3mWgKpp9Mk3/NjFl9fl48j8Bpyy5EaGu8f3d3axRao64JVk8zn6/SQI4
         dNJXf/GRaz6DlukyP/jlp3O7jn+oFQ254ZY2iffqvvyZ2Fbhh0AOyjLEUYEZ6HsMZUMt
         ZvwlerIYYBO6sucY5gIZxx0O5HTAEEtZTe42zI9LdR3CcDszKqZvh8uzC2PFEcqI/Sw5
         DQJw==
X-Forwarded-Encrypted: i=1; AHgh+RoFNkGIkFap+iOslRq6300Lk7ZW0w0Xt+4PJRcENmXVSpiVC3P71f8zw/WF78SfVoGmGM8pHOee4HU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3Uq3YAf831hO8MK6p+qyTCIG0nyiBdgRNdt614ulwaeuzGrYv
	h4Jg95LlHudnKc323cyspOKqRtf6cQnWYXrU2mkQux4wNtPIAdGvb/tdpyl6m4FDAt7VMyvp4NK
	S5shmr9FuNj+fK6kjj6O9DOFYNgATaM9tcqtUdkXqjugBlRaMqyPpXxzHPabKVsA=
X-Gm-Gg: AfdE7cka5V08+VlZ6CWQUOGSqEDxx8SwkNgWF5lDrye33p4cxCGd5VRHkhufTUn0BVw
	v5oXESPRC1gj8s6ddqbcM+A4+matBJ1OLCr53pLYKp0C0nkddDJgHwNOEJf46s/alGlKHP5LlWr
	n6HXiGwmokkdAaUoB2QIhmHr94Ou6Q7gBeVxRXeWRbUZinMXooORZJBo78Z/Np0NURRzdvJRIva
	EN8Yftd1vaXK0gQvMXOg8SUANTe5KoTJaJ3bWICsm9nMuxXgLC27LhvzTXMhVQrc01rRW51CkSB
	BIaDjrgqWQfDl0P6TV9YS7AfacScyXxdrZn2RZMgnqtwSASlbPkFtCLFs/nABMXE8oIc+BVhOda
	q+gutar7FBd/SGql9wUCU00ds5lgnbSG0grE=
X-Received: by 2002:a05:6102:1607:b0:739:b6bf:bc9e with SMTP id ada2fe7eead31-739b6bfbe2bmr297188137.3.1782743939032;
        Mon, 29 Jun 2026 07:38:59 -0700 (PDT)
X-Received: by 2002:a05:6102:1607:b0:739:b6bf:bc9e with SMTP id ada2fe7eead31-739b6bfbe2bmr297178137.3.1782743938563;
        Mon, 29 Jun 2026 07:38:58 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69870eac1f5sm1099403a12.2.2026.06.29.07.38.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 07:38:57 -0700 (PDT)
Message-ID: <a0a96e9a-2df0-4576-86a1-95683dcef4f4@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 16:38:55 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/10] arm64: dts: qcom: shikra: Add CDSP, LPAICP, MPSS
 remoteproc PAS nodes
To: Komal Bajaj <komal.bajaj@oss.qualcomm.com>, Vinod Koul
 <vkoul@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
References: <20260608-shikra-dt-m1-v4-0-2114300594a6@oss.qualcomm.com>
 <20260608-shikra-dt-m1-v4-7-2114300594a6@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260608-shikra-dt-m1-v4-7-2114300594a6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEyMiBTYWx0ZWRfX9ECY69TcXARo
 7WJYz/1u5m5DdE/EdCtnD2gA/uAr/QcxcFLsELZfP+XtpLArVZLOXiPW1qzgJZYRIztHmL+CX8X
 LQm8p0PIDrs7vZxTaHrJc1AGC79HyY0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEyMiBTYWx0ZWRfX5ZhsYazUdk4X
 ZT9wfhzfiUdi+tONKUOvF6o5MHd5QbtkOSJX2b63DTS9ehYbShG2u72XfBW4stK22OjfRBBi/yu
 ADvT3Ccijodzf9abbLON0UuX7HwMF12m8y7m+mnPSLItZ+k8fOxSXzMsDHt1PTQmciPj4zaQMed
 1W2WsY4FajmCyxzPz5AdMu1p2pGg5v6LCuPKy2ki6CtUlFSfJx9Q8++zVGsuibupHM+rvKYgSZl
 ZZViXU4D6yEb9DHaLAaY8/+1TT7IXS4WXAkiSDBoaMuU+ZmGpzMw8RbB9xjXh2+RLLG5y8TifwV
 ou8HkjnrO0ZOrojDXFHImPX66yeWnJuJphYIJBA/GJMpHMMDDCyJfUQ3it1ucsrtWpCP7ptWG3D
 YQEnN4M03fccqK1D47SK63QhvHV4Vmaasixz0S2eAnpxQBmVeeLbMevPa3AJcf1kUPp9nf32nqs
 qhrvoToGVhn+kfBW3CQ==
X-Proofpoint-GUID: Fdzw2SBJ1aUC1S-4Fk3r7LGuN3W4_h_t
X-Authority-Analysis: v=2.4 cv=cefiaHDM c=1 sm=1 tr=0 ts=6a428383 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=l7gszL_yuYPfzADJGiwA:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-ORIG-GUID: Fdzw2SBJ1aUC1S-4Fk3r7LGuN3W4_h_t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290122
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11869-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:komal.bajaj@oss.qualcomm.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:krzk@kernel.org,m:djakov@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:bibek.patro@oss.qualcomm.com,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[konrad.dybcio@oss.qualcomm.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 24FC46DC4A5

On 6/8/26 3:10 PM, Komal Bajaj wrote:
> From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> 
> Add nodes for remoteproc PAS loader for CDSP, LPAICP, MPSS subsystem.
> 
> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/shikra.dtsi | 164 +++++++++++++++++++++++++++++++++++
>  1 file changed, 164 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
> index 219c904fba29..445dd8bb7269 100644
> --- a/arch/arm64/boot/dts/qcom/shikra.dtsi
> +++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
> @@ -1798,6 +1798,170 @@ &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
>  			};
>  		};
>  
> +		remoteproc_mpss: remoteproc@6080000 {
> +			compatible = "qcom,shikra-mpss-pas";
> +			reg = <0x0 0x06080000 0x0 0x100>;

0x10_000

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

