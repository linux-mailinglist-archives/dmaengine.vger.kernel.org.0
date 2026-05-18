Return-Path: <dmaengine+bounces-10508-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yE8tEPTzCmpZ+QQAu9opvQ
	(envelope-from <dmaengine+bounces-10508-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 13:11:48 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5AC56B4F5
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 13:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A015B3066BD9
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 11:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F063F23D9;
	Mon, 18 May 2026 11:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PmxrNzsi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A2ECIGOx"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353A03EF66F
	for <dmaengine@vger.kernel.org>; Mon, 18 May 2026 11:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779102393; cv=none; b=Lo+QRJDX4+WpUiQsWYL3FTNH2m7cjs/7p6b/Lss/RTu1ig5FXlcj+Gc46UShqKbgtJCyXacKDTX9WgcJlZx9LMAZ3C3JjHfCBFLKedj18vDSDixR7pw8piltuSep9SvAst5XVKDlKk5CcYqf3x9ks11LbX1maiv58PZvMvkCBIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779102393; c=relaxed/simple;
	bh=CpUYG6vS3S+Zh4vlEXo3mC+63dtXNGF7YJZd8O0qHUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RDTg7V/OKgOk02sVffZNZdntJHcnF5LZpu5UWCogbBRzhqo/F/CDdWCgIm+W1qMwVfeUdBHC0C2T0117wJ4JSInXIyqwwCZfycB/JJn4KgHzk7d4zfF0mzRfVFYgPpa5c8A0QtWmMUts6mSs3ktzvvLGHrftsMWjEBSAJoWu52E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PmxrNzsi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A2ECIGOx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64IB5GXc1696763
	for <dmaengine@vger.kernel.org>; Mon, 18 May 2026 11:06:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=oxxEq02mQW5EXX7GWmzdPFvm
	pta8PWyHWKrV/zZVHTM=; b=PmxrNzsiVWBqg7AOYPAHkkBkMDVhcHaOhNF+EAr1
	7BU+zZSac8lCxz8GYzEUcsXFfS9fDo28XQ61gAcip/faPEzekKrxiKFwuKY9byVX
	bMCHvw+wqZwssIcew5vV8/evEL5/Y9E4kD9BAzcxp85e4aVPzF4KRxEiNP5TaBe4
	1p9XtEXqPrOp891WhmqZNbu9o5mDrZ1VU0Jz1Wx6sWZCrEBB6fGKnL/k4xr3RXrb
	zpb6m6SwYQ77rAUJa7gMimBaTReSYnzr7mHtXd+k/1LtU6qyKzTg+ocbgK+rt7Ex
	3PQPRANHzt7yjXS1+xyFR8FccHChzduCVLxaex7mvLABDQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e7vsk1ddq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 18 May 2026 11:06:28 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3692f395339so2156070a91.1
        for <dmaengine@vger.kernel.org>; Mon, 18 May 2026 04:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779102387; x=1779707187; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oxxEq02mQW5EXX7GWmzdPFvmpta8PWyHWKrV/zZVHTM=;
        b=A2ECIGOx+tUTHrYwpex/0UKFqVS6Uy/Voz5KMXCD+YYOIti7cNCIwfypmGt9LMJhUx
         dfuaShznah7lUCmfS13kZ5uzg2LsXgrfD7GmzqFTkEP1yXZApQ+ANqvR33/Y7AZFcxQC
         6LfMx+t0br1JIi8VOKaWZ4T8QVJYwtXB326nYOHLHYK9DPiwkRwfe1bWNxldbEXVyuVg
         vxK7TGX4i2EHvVqWrAxoC8fvr97X/8ydcgiEyccVe745S1R02IXmvRI4mL/LMy/L9ZWV
         aJJdr+le3rFtHNEZHklV1lx/wiNHDG8rK3eQTLbnhVfmfbt6Xvjo/ma6Oxuv2+Wqle0+
         ClSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779102387; x=1779707187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oxxEq02mQW5EXX7GWmzdPFvmpta8PWyHWKrV/zZVHTM=;
        b=ffHDvGqLaGHRF1byLxGiW+r7hOS4OxSae3BT4AVcY01AtQSnCumt97GrrhcIYpU9xs
         Ox/EPuJxViwRySVB8y4cA0+tyd1B4fftrep69cMVzb7vCU3pKduE/LCFRPXi8YZi4YZz
         KEsJkLRFXEhJLU0afBAJ/kwhHlJBbrF2RVpVbgqnwGCTek/d1aK+BYsNo00dFTIzGVUx
         uelDrF5ziriYCIuYLVNa31UaU0rFFbcnYQS/KyhgvFqnGjWzQj8KIMjLMHFyIoTsxMC/
         Tz6yMqzU+4evmcbLL1u5ZTyYTp7KB6ARb022k38QSOxDox2DysUUAFTreOloyEPHNBug
         mA+g==
X-Forwarded-Encrypted: i=1; AFNElJ8RwoOW7eXSyoTBQmkazjNUcDnmnOEvsdGBaEb3rZEM0mLOC13tk1zF6Odo+LcvSlVTLizNLMqkLPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnIkechDlb/tH9J9vB82GQqi+4mp4Fj5ql658MvWPKUKxDILxl
	QF7HkrkBb7hN29nrApvrMqkCmvY4fmwpCVgsE80gJpwWcWJWngaj/wSjPRHpCzyh+LXf4Z+td8f
	paHEc5m6+Y3hzK4YqsIs8Sdmx8Sa6Q9LzenDrmdy+QcWPihg+ajrMPffha5Hx09Q=
X-Gm-Gg: Acq92OGjpUw77B+nxiieuVNF/7nyjLXl7hdKTbUlsh/hdRonlgMn/cFMaVRnwdiIXRx
	3P2SjLzExEf1Y2wcUSgSIxYZ1yOF2QCHZli7FZM3oZYBeAinngIAYmI3vj4lGt5yC4IxJ5bg9Yp
	55nyji4A9jckDCGb+9SFYr7VzJEvxvL94JMY2JaOjG1oDfv/uwTZs4DGtnQi9IgggrzNTuBzwy4
	HT2SaOZfQMaYLyo4AwRJgW7PAy9jmpRgocUh94pvlybg7vQPPUlK70iztEolYkwzyy/qFymVvsr
	CgJwC6bKfrkQ/zkUvGiY/JuZXE2ZWq8jOYtDpxW5M1bB0QcJhMKTJEOK88/7XT/RKZfKCiJ4YKE
	ItamzaW7cOGfU7yjcy9t/x9aRV3N2oQRmtPSllRu2v4Ju+7ungAFq+/kt2T0=
X-Received: by 2002:a17:902:da90:b0:2bd:612b:912d with SMTP id d9443c01a7336-2bd7e8ad548mr152759305ad.14.1779102386830;
        Mon, 18 May 2026 04:06:26 -0700 (PDT)
X-Received: by 2002:a17:902:da90:b0:2bd:612b:912d with SMTP id d9443c01a7336-2bd7e8ad548mr152758855ad.14.1779102386228;
        Mon, 18 May 2026 04:06:26 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5f30bsm167923825ad.16.2026.05.18.04.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 04:06:25 -0700 (PDT)
Date: Mon, 18 May 2026 16:36:19 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: Frank Li <Frank.Li@kernel.org>, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xueyao An <xueyao.an@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH] dt-bindings: dma: qcom,gpi: Document GPI DMA engine for
 Hawi SoC
Message-ID: <20260518110619.su7gh442g3kon6ch@hu-mojha-hyd.qualcomm.com>
References: <20260401124028.589931-1-mukesh.ojha@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401124028.589931-1-mukesh.ojha@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDEwNiBTYWx0ZWRfXyeYRdhFyqCVa
 u1JZTTeRLiRMrCdQIJOZNLuNdbXWk/0j9GzyMr4oNYObLC/N/tMSRaMnsaKb6qngg1NwMGbWJPi
 Z4HZKyJFKVQCGBXyzjymqfQ57KGPRef9ummwoTDTdBXElL+kce8d133TSGRZDtU1VJ5eu4weLzK
 2JH4IdSNycswrKZ37EA7cQORESZG/UJgJsMXNUYUykn1QM20WiMMGsF3OJxQUVHmMl5Nfzqrbhv
 MGxJQI1sVLph8cfENhPzxHpCFF4tkERM4m+XUo7fvkqRgskMnCJceBsKn7oEvlI+At8pfy5SC/k
 cVJ5LPfnD0HqO7kRb77QUXE5zMuaWPmc7U7ng/b68vTQz/g2t7reHfTw1SoFYtmcP6pUlJ1vj+r
 FV0VSjj+ezpobHPPaBkt3bv9LDNm31XJHQY/p71Kf9MRlB+0ylW1Akm92PTLXRCChHtjyGoI+Pe
 o5mIcgqK46pPmCXJ2Jw==
X-Authority-Analysis: v=2.4 cv=Bq+tB4X5 c=1 sm=1 tr=0 ts=6a0af2b4 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=YxT5vFHApILTLK8CKXUA:9 a=CjuIK1q_8ugA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: le8gMLtNHQNKZf-dO226cTfxv6J5p0ac
X-Proofpoint-ORIG-GUID: le8gMLtNHQNKZf-dO226cTfxv6J5p0ac
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_02,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 spamscore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180106
X-Rspamd-Queue-Id: EA5AC56B4F5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,hu-mojha-hyd.qualcomm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10508-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mukesh.ojha@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Wed, Apr 01, 2026 at 06:10:28PM +0530, Mukesh Ojha wrote:
> From: Xueyao An <xueyao.an@oss.qualcomm.com>

Hi Vinod,

> 
> The Hawi GPI DMA engine follows the same programming model and
> register interface as previous generation of Qualcomm SoCs like
> kaanapali, glymur, and is fully compatible with earlier GPI DMA
> implementations.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Xueyao An <xueyao.an@oss.qualcomm.com>
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
> index fde1df035ad1..caa2ef90d8f2 100644
> --- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
> +++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
> @@ -25,6 +25,7 @@ properties:
>        - items:
>            - enum:
>                - qcom,glymur-gpi-dma
> +              - qcom,hawi-gpi-dma
>                - qcom,kaanapali-gpi-dma
>                - qcom,milos-gpi-dma
>                - qcom,qcm2290-gpi-dma
> -- 
> 2.53.0
> 

Would you be picking this ?

-- 
-Mukesh Ojha

