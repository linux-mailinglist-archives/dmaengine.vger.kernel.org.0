Return-Path: <dmaengine+bounces-11289-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id s08cH09bJmp8VQIAu9opvQ
	(envelope-from <dmaengine+bounces-11289-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 08:03:59 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B9365302C
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 08:03:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=JrglyURu;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=eu37J4I0;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11289-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11289-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C195300D639
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jun 2026 06:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE0B385D61;
	Mon,  8 Jun 2026 06:03:54 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B1929C33F
	for <dmaengine@vger.kernel.org>; Mon,  8 Jun 2026 06:03:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780898634; cv=none; b=D+gYE7FrYjUZV2IZg71sgEFEuyeroLk91IH1n+XiX8uqrJKGhPSYLuyIpuNlJpSlnuMPb541mRXxGnKMn3AJF3jMTdOBUl+qfKMgUceWyo5IzYIPSbB06a6LM3kpMmaOPQaMfklr7OQNSB0iEmSFDmoW1yvbXNjzOB8UfFgO74k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780898634; c=relaxed/simple;
	bh=D43F32dRLsEtsZfTnH6PZw0SGhlJcijecdkwYHf7fmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQ+cdG66eO2iuZjoZPmMcwEBzVcY1lwhJc1mnVt/ZhyyfDLOoyi+NhjSaB89bE/bPU5O8jtouG5iUawZKLh18586hZS2OffkWbeKyPxF9zjB1vkZOT8KEiRH8R3VL8ntPzg640+ftenUo+3bSEUcadR+DqP2fuhgAjbzsc4F2rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JrglyURu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eu37J4I0; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6580EM591574751
	for <dmaengine@vger.kernel.org>; Mon, 8 Jun 2026 06:03:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Cv5efwx26E7PJcE+ABnkMrhr
	HPhPIlDSPzTe7GWtSQw=; b=JrglyURu/bXPrqPvVsJvzKFFh5NVOvIn1WUqOjbs
	ZrkwajJRJiamCNxQtIeCQW3Jfg6LuBQnMm5yRduFWFwdZDDZWbJICVxrQ+sSW9Ql
	tMWA/9GaRrqtqHPLEfGeMaB51WiXiSlrZ2hsPKyHO6swYlTopoxMdT0Gy6mi3Rja
	KQLuGqc5uxW/nw1UHVi/E+KGXl/gUzSkaxpz00aw0i79r6ekcBwQYHOenfB8qq0X
	jT/S3Wx64Mfp0yDXbyrFYqwzpzELixgLDNzgQrl/C2w7yg7gcMSHPbLDTM1i/lAs
	oIPxUzZ6AAHMESIHgXdCjraMVEPRX2f+z+q8Ou+XCVivMg==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4em98cxpft-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 08 Jun 2026 06:03:52 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-6c89de84f33so4454149137.0
        for <dmaengine@vger.kernel.org>; Sun, 07 Jun 2026 23:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780898631; x=1781503431; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cv5efwx26E7PJcE+ABnkMrhrHPhPIlDSPzTe7GWtSQw=;
        b=eu37J4I00ou0j9sTDotrT0pOekxwx5TT/25dpTmbTvTFbWd+kCd8lkR76YHFtGAzlp
         s6nlmdmXCHUOAVvqmjJeA3Wun+9D87laoUnY0KrdbsemKBJWKxHup9/CoBtpvteqMJqj
         kbsenrovQMrjfIYXFCzx3Hw8baxZ0TfrdpHx5oZkrjNAoy5y8JgJvDeoUEkkUkI7UiRz
         IF9d+55k1SQCjXmGmRtZZJtrdpQbGDzUbZdrkKNElL2iidAKdlBPeQTVJ+YP8DVWoZsv
         /Xx5Tr2Q3uy6+HYqbORxLWGrMVGDotQADc75kdit0QUZxXHRRTHAlmxChb6qSG6N4jCr
         lYzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780898631; x=1781503431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cv5efwx26E7PJcE+ABnkMrhrHPhPIlDSPzTe7GWtSQw=;
        b=s0iMU01kl0hf8fRbRndYf4fnljCxPm8/Hr4atJW2iq6HEmHWZnniZplrDte3r7D5mN
         kAD8hkN8HBF5qYviijK9AkPSmO7L34i6j8J+BvZ0r8ZjU3jfTrlFyb2dmCRTtCbnNZ/T
         uBIH7FFdp0gLNEHK9LGcwBzc33GEj3d4m7LFSWvacGZmdflRTZD3aKplWBlb/WeMIrwl
         1eta+K6lqPKRwRxHZw5exmI2UklJr3LEr/87xndhM7bd/L0OyH6MTKzHPirOaC29ZxAz
         K/xlQMBBv6lTV8eD4CW46UPkQFD94iE5l2SDIuU9oOXEGBlD0EUX4lntuetp9a55jDw6
         0sHA==
X-Forwarded-Encrypted: i=1; AFNElJ/z32vIuFBatPWxRxvykNYs8tRjl2hqJlPdR7KT0jV139kG0RVbXUE/WpcoDthTI9+K+1ScmdLh6tM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL3Pw+4DWyeBrbZirWRSV+Iqx2+gOXYt8JIgu4OUG4wlRLjMSx
	fdcM2wpr76BLEimCWCBe2uxRf8eWIUwe/zjLiXrQmJnZPYzbiK+RjZpGLyOjSR2JwhrP+p7PPmj
	p+S+29/u7fYe6TrFMM20qHD6krlV3HTDTAJx3Xh2pjerEVPlmB3qjApNo5zXDK/w=
X-Gm-Gg: Acq92OFVhb1SmlGZ4GGTPk2Y5j9Bxx0WKyfI+T3SX+lWz8iFn/pk4SBIO6bklYsoYKg
	2SA/M/nIujP90Rv0k3UdpO2W+GPU8ReRHBNFt6IhEiSSIXW5YbodPmPhihcVVlt9250O/IruNtz
	8txbV4Jn4+B47rheB6q0gtIjBr2x2HsA2O0OU1nszWXzhCnQsLMtCfiaIGbFTHSTn/DOAbVEHpK
	Qke85hw545tir1y7/izBm0Wyy7dv+4r5VHF0dAh+XiC9p1Haa5kjUCK2nxgAGc6LJdfb4hFuAzH
	PnRC5T8vX0bItKJk1QpZTgTZA6RudDq5FKh3kBeRRhxT2ZDTW7ZcsqZCtNlNmfXkPw9hquYiI3O
	H7hyRgc6P67W4Agi8W4ygNRbRIp3gvb8lvlwHgx7zM4m4dZ9PePxAnygRldTjtY1XjFrhirP3qF
	6oQMWr4b3DrsMfrb+eVLAZHhqHz87k2Jp1/Hd1H5Nfjf7lsg==
X-Received: by 2002:a05:6102:3e20:b0:631:28c1:154e with SMTP id ada2fe7eead31-6fef85336damr6839089137.16.1780898630893;
        Sun, 07 Jun 2026 23:03:50 -0700 (PDT)
X-Received: by 2002:a05:6102:3e20:b0:631:28c1:154e with SMTP id ada2fe7eead31-6fef85336damr6839085137.16.1780898630543;
        Sun, 07 Jun 2026 23:03:50 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b9995b5sm3510351e87.76.2026.06.07.23.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 23:03:48 -0700 (PDT)
Date: Mon, 8 Jun 2026 09:03:46 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Md Sadre Alam <md.alam@oss.qualcomm.com>
Cc: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Abhishek Sahu <absahu@codeaurora.org>, mani@kernel.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, lakshmi.d@oss.qualcomm.com
Subject: Re: [PATCH v5] dma: qcom: bam_dma: Fix command element mask field
 for BAM v1.6.0+
Message-ID: <6qkgzmrr3oxzj47so4jqw6gk6stzjkxbnaflajk5zw5fgf65cn@yj3d55p5b7do>
References: <20260514-bam-fix-v5-1-58f6edb34969@oss.qualcomm.com>
 <agyeh4PZwG0Mu6Wx@vaman>
 <aiFXPPXtjCHj0Ged@hu-varada-blr.qualcomm.com>
 <5c24a3f3-a4c0-43ec-9653-bc374a9c5e22@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c24a3f3-a4c0-43ec-9653-bc374a9c5e22@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA1MyBTYWx0ZWRfXyUpSM1290I9k
 3AF3DrlZkKxbH9OiHsq6pJSbWNnghifecYRyuiK99hWbF+hadoAWqQDUZ//QpeKEKHEfzm8i3xK
 lpV7A8cEh5cKVpvJVpl6oQL76d7WEtBR4vCV6AH0US8QpQ+UpMs2i+ulCF/C0ArtUUCKK2NteBi
 0Q4HNZNvTxfXkXzj3XYsTuv/KKGKhGJlOhcmVacwoudLond3yVYToDTHuz7/6fqpiJlwqHXt8TP
 67aUAAyV6gxHQK9WgSoYNkztcJTLS1XAHg+WsJa96yBKj8hVVPyWhUyG0dKebVIG4fz103tShGs
 JHkCyUeQR4nI2Sxw0kO/ikYGrEixO5e/Mu/+e5UldKAyjIsLg1baP60aqaNOorKGwV1LyyEF7bq
 i0dCKBOGzkrW7lwJieDU8N5R4MHr8+iQ93le75+jIXELjlvZbbx+B5/SfZhBnxcZfd/XGEcfP4E
 3aSpc6N12MaK5GhKv1w==
X-Proofpoint-ORIG-GUID: fACmBfv5tHaPKUEg75qrQiA6LdbvJzyM
X-Proofpoint-GUID: fACmBfv5tHaPKUEg75qrQiA6LdbvJzyM
X-Authority-Analysis: v=2.4 cv=A/pc+aWG c=1 sm=1 tr=0 ts=6a265b48 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=IdiP-_C5k5DUui2OaP0A:9 a=CjuIK1q_8ugA:10
 a=ODZdjJIeia2B_SHc_B0f:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_01,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080053
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11289-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim];
	FORGED_RECIPIENTS(0.00)[m:md.alam@oss.qualcomm.com,m:varadarajan.narayanan@oss.qualcomm.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:absahu@codeaurora.org,m:mani@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lakshmi.d@oss.qualcomm.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[dmitry.baryshkov@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E3B9365302C

On Mon, Jun 08, 2026 at 11:20:01AM +0530, Md Sadre Alam wrote:
> Hi,
> 
> On 6/4/2026 4:15 PM, Varadarajan Narayanan wrote:
> > On Tue, May 19, 2026 at 11:01:51PM +0530, Vinod Koul wrote:
> > > On 14-05-26, 12:09, Varadarajan Narayanan wrote:
> > > > From: Md Sadre Alam <md.alam@oss.qualcomm.com>
> > > > 
> > > > BAM version 1.6.0 and later changed the behavior of the mask field in
> > > > command elements for read operations. In newer BAM versions, the mask
> > > > field for read commands contains the upper 4 bits of the destination
> > > > address to support 36-bit addressing, while for write commands it
> > > > continues to function as a traditional write mask.
> > > 
> > > But this changes behaviour for all versions. What happens to folks on older
> > > versions, wont this break for them, if not what am I missing
> 
> It will not have any impact on older version of BAM controller. Konrad also
> had a similar concern. Please refer to [1]
> 
> [1] https://lore.kernel.org/linux-arm-msm/2394e63f-1df7-764e-5489-3567065707a1@quicinc.com/

So, you got this question once, have resent the patches, but didn't
guess that there will be the similar question from other reviewers?

Usually a question means that the commit needs to be improved. Adding a
simple "Previously this field was ignored for read commands" would have
saved you from futher questions.

-- 
With best wishes
Dmitry

