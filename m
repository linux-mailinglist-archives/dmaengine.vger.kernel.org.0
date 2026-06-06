Return-Path: <dmaengine+bounces-11266-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3aWyEhAYJGok3AEAu9opvQ
	(envelope-from <dmaengine+bounces-11266-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 14:52:32 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD5764D89F
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 14:52:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=HqT+ZoyP;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="CYM/YM2F";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11266-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11266-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55946302A69B
	for <lists+dmaengine@lfdr.de>; Sat,  6 Jun 2026 12:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1E0302146;
	Sat,  6 Jun 2026 12:46:41 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7906260580
	for <dmaengine@vger.kernel.org>; Sat,  6 Jun 2026 12:46:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780750001; cv=none; b=fX9ELTSRGhVCF7zXpsdzXM76XAJekQl9wh+OWXN9MCU3LSMsyFQzy4z5pv/m2b6omNcau22TZ7B3P684bRBWmwJJ9aHmst4p8fa2grP1PNJDwNQkH8DBTVWy4hqU00oU8CVj2peFYYxw7cuebH2hXTI7MlfJFeW/8OPCX2GHWVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780750001; c=relaxed/simple;
	bh=OI567XHaJA6LozE7XWwl+YveZRRZTacd3XbS8yKhF5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WvORNQ8Mih/8E9OAcHP3xqjIu7B4t0z+Tvf/OVCQ3tzG9mCa3LSmCGVYBbrHinq2OBz1JkKVhM74h9b3Hkbe4HaFCaQsCVFvn3qEaNhAbFj5c/twOV8uUznqf7etHBI/PvJyuY9mkHkF4yRhotDLhGnE8+UAjvzdU+6xRIkTpPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HqT+ZoyP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CYM/YM2F; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 656BDWda1329053
	for <dmaengine@vger.kernel.org>; Sat, 6 Jun 2026 12:46:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=I36GPlABczqU3ZvBjdX1WKxM
	8wMh046hFW/NpGLSrOY=; b=HqT+ZoyPu7rihrID5L+BzIf5xcfvfvCCSObd1m+x
	wbvfU8azUbim4fQkVhepBhZuOpPNUJR9ENl6VTx++tqfZJ6x4ViWO1dWatBB6Wzi
	64CwBXaz+dEmvdJ5ySZZ04ayt8vEFoQNrMFvuWxpAbSbFZ2yQInPdwFfkVebDvcE
	0kp2U4xtexlKiRzXLACGyV/R+A0XW2N2gZtjquclB08VgUzF7U1lzJ5xswznIWZF
	4798Fdkxj5cM956yRAgJT0x3/YE6ThflMjD2JWkijcnykxfRVvdu4aMGeFo+DJ46
	BhyCub+RLD03LiblXY4uf+dMzT3W6qtOy+qYDgsoExAGQw==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4embs190e2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Sat, 06 Jun 2026 12:46:39 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5ab02fb3054so1997400e0c.0
        for <dmaengine@vger.kernel.org>; Sat, 06 Jun 2026 05:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780749999; x=1781354799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I36GPlABczqU3ZvBjdX1WKxM8wMh046hFW/NpGLSrOY=;
        b=CYM/YM2Fwa7E7MlLUu8bP0npR3tWAYYrU/vdIO49uPON9lOtSa662G4fJOoJWPCps2
         bXbBh4IcLxRzQaLD/f11zFt7uwCDrkDWOaoDF72L91HUqWPvmw8qrcwUl11imUpG7wiH
         cgJhEf7H3hpeh6AKYxNs2WzMwJcFPlEZckwcKbfluO2KlKjdauH+MscJf4OgtZOgcDd8
         AUmQGpFygWaXrULK629S9TuUu/hK0unqltQO6Pw4R++ukriwoKAGZn40I+kAGJdPeSB+
         aGVMZKTCFRTQt+143P+G7QneM9xCVYxGDmcSYnVVKBappfkyM1NypSjVySY/zU64jEi5
         M38g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780749999; x=1781354799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I36GPlABczqU3ZvBjdX1WKxM8wMh046hFW/NpGLSrOY=;
        b=s7/bR5LSCz7eFhYF/Vge9Q2fQTUG4d50UWAYzaOH7oOe+Bb5zRb+SLSHVMM1E23tAX
         wt85kYuWURVLa4UMlx8lbXZVUeLHld4U1OPJdSjxK60nXUFqfierpFJbsgBnu6QAiIye
         5hcVEQ+GRUVf7CTa9YucqTDcnvUyqR5iH6leqI1siIyGU/FJ3m+PqL+JgFCj3cMmKzYM
         +P34ohPhTr87nQDFVAgeWNtC4RGa22PHWAPmaDeu35nntoLudlqHUYCmzr+qhy6m9Kh5
         m0By1Z7NqBRuPfpxujTVlTYPdh4k00xoViuflgMdMbgMXv/WbRVnkO7ReQSxH527fsg7
         3fNg==
X-Forwarded-Encrypted: i=1; AFNElJ/wH5qFM9LIvXnLGRDCe/Fe9TsI60J1oAVp0EppziV+gMkdwIR0Sv9xlXn6cJVDI5fQCxhnsfJsxTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBwTJNoprhzSie+4ACvx9/qA/Hme+660XVPW/T09Hfl0Sru7GW
	PFw6UczuCuCX0JxDQrVRgHCZGrAJt56KrZMdq2AsALpqBqmc9oqdkA90O+P3qJDb5v/+y2VTjUG
	qb5NErKcserJTgSw/i/o64HxpHWOaZacnmG2lmgTFghxEioZQhdgkVEQcQWpHYaQ=
X-Gm-Gg: Acq92OHqpopwLUfbzvtJoW+gP1iRjJc689043gyTP7AFiABrmQescbEt13swtD24R3J
	/8xUkQwz+7DH0W/N2rImejTqFppS0yJ9SC89y0Ov5ywFEnWtfFwe9gVauXMbzmriTfUrgO1JfMe
	5U+PL36FkHbsHNeV7AA6BsPhJqFuG0AJgQ5wBPjBgi6lfb3IEmKYjrIbFDIoUiWelpAgMivzkul
	ASKqmqCumqlCUFOrUQSN6GmABuCwGmsqGLei+ffAz9Et5Enu2rpUSo+9EpFewfzrdgZa8TL6POm
	3KXe9aQAoJbk/6cgnwFEuoE3ipnu9rJG7irj2yAI1yCa7Zy8AFlGkS2Ujz52Wxc4N+qSAncmQXl
	/tYvVeVxT98e3qps4lz3ZxTr82bG1PyHG+Ze9pmhwQOg8AIdk0TpF7CdI2DY4AzULR4o3n8V+iI
	2T86pK27ro8WhBIkayyZgv7LIva5je5e0uya1BXyUVaT/5dg==
X-Received: by 2002:a05:6102:c03:b0:6ef:dd26:e2c3 with SMTP id ada2fe7eead31-6feffcf11e1mr3964112137.24.1780749998998;
        Sat, 06 Jun 2026 05:46:38 -0700 (PDT)
X-Received: by 2002:a05:6102:c03:b0:6ef:dd26:e2c3 with SMTP id ada2fe7eead31-6feffcf11e1mr3964092137.24.1780749998585;
        Sat, 06 Jun 2026 05:46:38 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-396abf66b1csm31175831fa.9.2026.06.06.05.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 05:46:37 -0700 (PDT)
Date: Sat, 6 Jun 2026 15:46:35 +0300
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
        Xueyao An <xueyao.an@oss.qualcomm.com>
Subject: Re: [PATCH v3 03/10] arm64: dts: qcom: Add QUPv3 configuration for
 Shikra
Message-ID: <6u4rkb5b5m4p475h3excgaufeipor3o4oifga4dmsnf3rcqe2j@b6us6m4h6m6s>
References: <20260601-shikra-dt-m1-v3-0-0fe3f8d9ec48@oss.qualcomm.com>
 <20260601-shikra-dt-m1-v3-3-0fe3f8d9ec48@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601-shikra-dt-m1-v3-3-0fe3f8d9ec48@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDEyNyBTYWx0ZWRfXyfh90jLQqHCQ
 Y6GsAu8nqvI1/O5eD1ZAoucozObd9B++NxXUbGqDmOPsgTDtKR3aMNszhXtnEA95kADnFh3CsQe
 sRWlHQ7zO3tcUkM3E58zRiLV4ZoPQTXSzF0HcQqmdGDOy3p92zIbwyheJqgDmykhTFxiar56y9o
 Kh2J7bh+qN7hixtw8XMtb8O8QGBBPxI2ej9+pNOAIhOXKrbbXSE8dDRRUDe4QD0zyGKnKlx3Waj
 oRiy3SVJvcWMNH8ODtyjoEDAG5VH+g3yyj7yyiyuzA5SlZUCc68uOYxGClwIZHjV1rMYpQgrKuP
 L8eDzY7buY4QL629WFspa7TUhPYEFvB+ze70XH1yxAY9k/mfJcSlFqbhYIbZBz+NcEemwJBh9LA
 oPZ90gDu8GizoaD21toD+qlAZJA6YBjV/Sx28wgNzxB94mi7ulRGpkYE0CsQqrA27jI2DwsMsPT
 qATl0gkGnlc0CDO697w==
X-Authority-Analysis: v=2.4 cv=CeY4Irrl c=1 sm=1 tr=0 ts=6a2416b0 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=lJH66iwPDgcm3tFhcnEA:9 a=CjuIK1q_8ugA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-ORIG-GUID: XCqJrQq0J7c0nFR1M97TmD1ftbUNUQ2s
X-Proofpoint-GUID: XCqJrQq0J7c0nFR1M97TmD1ftbUNUQ2s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606060127
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11266-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,vger.kernel.org:from_smtp,b6us6m4h6m6s:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim];
	FORGED_SENDER(0.00)[dmitry.baryshkov@oss.qualcomm.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:komal.bajaj@oss.qualcomm.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:krzk@kernel.org,m:djakov@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:xueyao.an@oss.qualcomm.com,m:conor@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DFD5764D89F

On Mon, Jun 01, 2026 at 06:25:05PM +0530, Komal Bajaj wrote:
> From: Xueyao An <xueyao.an@oss.qualcomm.com>
> 
> Add device tree support for QUPv3 serial engine protocols on Shikra.
> Shikra has 10 QUP serial engines under a single QUP wrapper, all with
> support of GPI DMA engines.
> 
> Signed-off-by: Xueyao An <xueyao.an@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/shikra.dtsi | 951 +++++++++++++++++++++++++++++++++++
>  1 file changed, 951 insertions(+)
> 

I didn't completely cross-check, but it looks good otherwise.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

> 

-- 
With best wishes
Dmitry

