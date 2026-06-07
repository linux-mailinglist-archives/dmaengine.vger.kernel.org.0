Return-Path: <dmaengine+bounces-11277-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NISoMdi4JWqzKwIAu9opvQ
	(envelope-from <dmaengine+bounces-11277-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 07 Jun 2026 20:30:48 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 211636513BF
	for <lists+dmaengine@lfdr.de>; Sun, 07 Jun 2026 20:30:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=Uz1Zjp1p;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=clZQcJxj;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11277-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11277-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66F3B3014120
	for <lists+dmaengine@lfdr.de>; Sun,  7 Jun 2026 18:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3D93128A3;
	Sun,  7 Jun 2026 18:30:32 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE444313E1D
	for <dmaengine@vger.kernel.org>; Sun,  7 Jun 2026 18:30:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780857032; cv=none; b=am2v2tvf9ZW9jDonHaYW0BxRIQyYRwgeOZ1xlBfwGovFex+7U/wXOY0MwFbs50vdHsr3+lEBaHL7y4g5ezU5DYibUeMGTP+4FGHVzqeT81fl/K44nUp3vTtQ8I4c14Dwmt6rWDjvG9zn96n7l5rw2tuvMKRNy6qvNpSerbvpWNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780857032; c=relaxed/simple;
	bh=m6t+49MP7uy5cAZxatTTe11MxFg2tnPW00sY/HGGnxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ulp1cv5tQIwH5u82qsaqgaAOYBLj0SzI0jbuKsSX/4ffxwf7qJWMwMdi5okexGWUUgrmM9nk/AeuUC5NHfDmqJ3FluhuhSkUYmTAggJrtngW+2WewDqrdNEePA2Sb/t6oTRu6vP8o0m/GLxX5b/yjqqZb21XLAdn2CdNGaIcmXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Uz1Zjp1p; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=clZQcJxj; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 657Elqvd867542
	for <dmaengine@vger.kernel.org>; Sun, 7 Jun 2026 18:30:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=zmozr6MMdfPUDaS8e/eCWoR1
	xOPrRCMQtMyGELf3lMM=; b=Uz1Zjp1p6qTYu9mtGwHAYALResZ/6gX6Fp254Gdn
	XoUflZe15R/kn/00n75mLDIv33AROORimVj8g5jfec/K4XinYwokKNliOXdsCR5f
	C3yWIqid+ba6HekqSIUBpT3xDtH5aB1F6AB4npnCOX33VGrYEQI51fR8xIsEcZ+4
	k2aZvqw90zRBjcwd8LX0xB/YwaDvhUW5CaML9KmqXpJh639orWim8cy8pCRpMdqd
	CzslnQ3npTY5Griiic8lZFmnHSCuVrXz9FpHolwtqFnVG9lCKH4YucSLBS/RF/h2
	uz0xJrczpz78ks2ApU0nbwTdzDGyIRN9Gfzde7g6UWykUg==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emb4w4js1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Sun, 07 Jun 2026 18:30:28 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-59bd734ecbcso1669316e0c.3
        for <dmaengine@vger.kernel.org>; Sun, 07 Jun 2026 11:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780857028; x=1781461828; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zmozr6MMdfPUDaS8e/eCWoR1xOPrRCMQtMyGELf3lMM=;
        b=clZQcJxjATyFfWg/ydD6sXuOhlH1W/xpF2cNkmg4jZ8x2lpP/LS4OwKo+4FYlh0J9S
         Z5VchFpB5gtZihaqs1LMVmK02kw1K0pLN714wMDd21D6pg/k1byXPUpEW/XqS1R4X3xC
         fEa6wf1GP3LSETmSYrs+rxSMQ6dRdgrOHrLiASj5oYRK+L5zrSzQjpZY5HUgEWM4J9FN
         bN6aeCGG+ojMiNwZJFj4jDQ4fglzlXsYVx48xK9HLGlaHr2JATqsNiPjIuwbQ66dZQur
         YoabI1iMKBLaLX8bo0YSuU7BljbGwc9dbrwBdHL6Dxu+XoFBlpSw3UJV5aU/6E5FAfWq
         q9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780857028; x=1781461828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zmozr6MMdfPUDaS8e/eCWoR1xOPrRCMQtMyGELf3lMM=;
        b=J5i61v0tt5PCUDgLp6qI0cwo0fWARJYiDqXuzcMedZ4VtXu5UalqwISJUHvRjJ7lLf
         BpQzDuQL4NXjGYyuQuZ5kkpcO296PAJCl62lLPLIOHVQhiN5XeaxXqulvductFr5ieq5
         J49sOakg+/ASWcQNG4yyW4E+tgjAYo9B8UlSR7n4mVZnYyK5KQ/bwaXFuMT4Gd1gmQES
         YgeGy1Bgje96PaoBlHVa7ABLRbvFDTzBfvWUh18BAeYCorqHzhuMPdBm57lTWt3s+Bpr
         fw1xQWufjR9hDJI73T0u234Y8VBZOD3uIaeeL+516o5TMJI+IHFsUjxGmDRmgSBHPWDv
         CTXg==
X-Forwarded-Encrypted: i=1; AFNElJ/aMkF+SiZ1FFIF4s2lL6kGxKeQX4NKwlReKrmI7d7Yem9r9OUe6O6wLsBKwQdYqkrb3ECXSKcunMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtg9JN5XIcxfMw19gE12QIM3JfeeB2/Xbz21LX41cTGKSK4Jpm
	aN4Iv4QUXbWM5ky/9IbEyof+GlEgZuR//cZ0VmDRl4VSb/h8TOLDnr+sQO1pcEagW5kqPTG6xBq
	eX1OPos5kd11M3aYIT/maFCoGNtJeCWNfYNhKG5ZSEh2X++S9wvKVWzNfUEYf0KM=
X-Gm-Gg: Acq92OGkboYluS9wtzXw+1wi1XjoiQl8vuJze3tcTvt0w9pvUoGenZn1QMEWr1SRL7p
	W5lZGSIoeUmpcTuR7O0Iv/riSUJEVi5f7ZOPMVHar1jDSYxQAQE7JadPBatDrJUueGof2bY9WS6
	JtlXhB1i2TDPUd+Ds2ZAf8zLXMF/ExZ14oEjqrdJC1EkKqyUflannTHJhLplcuWC5CZ5qy0/EZ8
	ToFde+4KMyM4u4tTd4K6sRFu2CXLyiSNoNB/DskdWV+qzXSb805ch8SmhJ9TVm8BKnVC5LjmO8U
	dRPwqxSTVUUAPFqHIJtqiuoap3xMqhXZrgrtJ198VywjseY/y0Me1S2sFkI7vSrc+tlca41wLIW
	HNWMpYppenP68Y4yFnjyDeqZ4b5/yq2b2shPL0j/Oq3TzzYxo18OxnTJJzaz2oi4Ad7knMEJ9eN
	0+ZECNbK6tDHZp8LCLobS4VFGpifnCcvjXEqophS8IJwt5Zg==
X-Received: by 2002:a05:6102:5346:b0:6c2:e290:cc69 with SMTP id ada2fe7eead31-6ff05e2d9ccmr5876341137.23.1780857028300;
        Sun, 07 Jun 2026 11:30:28 -0700 (PDT)
X-Received: by 2002:a05:6102:5346:b0:6c2:e290:cc69 with SMTP id ada2fe7eead31-6ff05e2d9ccmr5876331137.23.1780857027872;
        Sun, 07 Jun 2026 11:30:27 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b9862fesm3196569e87.57.2026.06.07.11.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 11:30:26 -0700 (PDT)
Date: Sun, 7 Jun 2026 21:30:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: okaya@kernel.org, vkoul@kernel.org, Frank.Li@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: qcom: hidma: use sysfs_emit() in sysfs show
 callbacks
Message-ID: <nsjfphscjzpxicu3spn6mcpyvmarqsb656lvflalouyupq5syx@leeejbjrohws>
References: <20260607163119.78717-1-dennylin0707@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607163119.78717-1-dennylin0707@gmail.com>
X-Proofpoint-ORIG-GUID: tDUUzwHp_SuByveJ-Vgm_T1FlJBxPWC2
X-Proofpoint-GUID: tDUUzwHp_SuByveJ-Vgm_T1FlJBxPWC2
X-Authority-Analysis: v=2.4 cv=YIWvDxGx c=1 sm=1 tr=0 ts=6a25b8c4 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=4Z4V4W3UNDWYKEzNDnMA:9 a=CjuIK1q_8ugA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA3MDE4NSBTYWx0ZWRfX0e+1Dsi5NO7e
 dF0699gX7HM3zCunO/SbO9+3dk5hP4y6RtUgILl/ODtVaUuxC9+7M6EeQ5/ujd1cuoM8SrlpBry
 nAzayaqeCIcTqdm5uX5picQ3iv/2bgDfQM1G+O7qf/Gl3Je/yKd5EG85sJ0gZfeXtrEa3H1MQ9Z
 DGOvLSliBWUyNHAHzOJwyh4V41Jm7oKIwDrhOgzouXddBxavm52wt7ORQ02MDdoma/uQHT/SPEV
 RkkJVQG+mNuNSVU5PChEvH+rjODvUB2Qp/EwitZxYc1X8acPDVj5d4Hops/ogPnGMjuJAIMNjBh
 Y3Fw/cobd3CdaY0Ll3FD9UeCaczuaKhd3Aryq03DPgmxYmVrT6WG/CDTwB3FwCpIF6kjoQMsbNA
 jPMx3ovUSgaHQmMmhRjo2mVp0E3nkZgtmc3XbYHzxZ58GKdBf8B+FwajfHxt5l92lFCaRCuNiFy
 WiNC91h3kWPIfvrtj7g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-07_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606070185
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11277-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,leeejbjrohws:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:dennylin0707@gmail.com,m:okaya@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[dmitry.baryshkov@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 211636513BF

On Sun, Jun 07, 2026 at 04:31:19PM +0000, Hungyu Lin wrote:
> Replace sprintf() and strlen() patterns in sysfs show callbacks
> with sysfs_emit().
> 
> sysfs_emit() is the preferred helper for formatting sysfs output
> and simplifies the implementation.
> 
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> ---
>  drivers/dma/qcom/hidma.c          |  6 ++----
>  drivers/dma/qcom/hidma_mgmt_sys.c | 19 ++++++++-----------
>  2 files changed, 10 insertions(+), 15 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

