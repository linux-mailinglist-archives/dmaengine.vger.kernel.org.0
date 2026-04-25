Return-Path: <dmaengine+bounces-10120-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Lf54AjWW7GnUaAAAu9opvQ
	(envelope-from <dmaengine+bounces-10120-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 25 Apr 2026 12:23:49 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0032A465E18
	for <lists+dmaengine@lfdr.de>; Sat, 25 Apr 2026 12:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 45E83300404C
	for <lists+dmaengine@lfdr.de>; Sat, 25 Apr 2026 10:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1185B39446B;
	Sat, 25 Apr 2026 10:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCCPoSXl"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BB22F2607;
	Sat, 25 Apr 2026 10:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777112624; cv=none; b=qy/t9PQnvMr1P1gvtG1K0029QiZiwrglo0xPWYZjM/B5RnKM0ZBK8Q1qtGAGWFmIVhMckXcgA1LJAdU/3RsbEyU4aCAXcLVHQaZ2juAjM0WvTcSi3C3i/AYCiKlxtm30Ng82XAcyh8Pnh/vv9+Pfvnwa1FboxjxdjcWq9o6lZ4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777112624; c=relaxed/simple;
	bh=zwCFJtmeAUbii235fTcLlj5zP/eaa8Auc9w7sbkO2dQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+GX7tOeau0dIW2Q7yfN0KNdUHA6KEuezLiGvXYz3DwegWTJhOKwpR2oI+k7VSNnTe/hBbas4k/k4UiORAK8fHjNKoMf7U1gCDG1PGAI+pay0LL/lSVmO3+1Y61wuJ2FSOxVJ9H3MYmUyTGvCPHR/3McFarcgR1CJvUxgJKTcbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCCPoSXl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFB9EC2BCB0;
	Sat, 25 Apr 2026 10:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777112623;
	bh=zwCFJtmeAUbii235fTcLlj5zP/eaa8Auc9w7sbkO2dQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GCCPoSXlP3bKNK40bIBroSzsXszNSouGd+DinWM8KD7ByNimt3mbRkDTEesRHxwfm
	 ta/U4EHh1oQL4/D4wQx4VRjvhiqmF8TR1/cR1KZpMk/JQxTKI33Iaghi4Fps9MJiNV
	 HLa8+XVJJtJwdXBHj+4NQVv7AfQXFQYxjbMK/Zrx9cmX43KdaLC5gsq7nn90LRWLfB
	 20lMZGraR0J1A98/jEbfheJ/PXD4JAAWhI1i9v5EkjMUWz+OLuHz4sZ0yRwO7ZNl6N
	 sEVkhv+01U0Q2Bxmizv5Iyc8z7+00kpoxAP+D4ZFox9q86/xt3PwTq3yfc/VQVdUA1
	 fu7Bk7K+UpXyw==
Date: Sat, 25 Apr 2026 12:23:41 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Harshal Dev <harshal.dev@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: dma: qcom: bam-dma: Add support for
 kaanapali BAM v2.0.0
Message-ID: <20260425-handsome-papaya-porcupine-d42df7@quoll>
References: <20260424-knp_qce-v1-0-813e18f8f355@oss.qualcomm.com>
 <20260424-knp_qce-v1-1-813e18f8f355@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260424-knp_qce-v1-1-813e18f8f355@oss.qualcomm.com>
X-Rspamd-Queue-Id: 0032A465E18
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10120-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Fri, Apr 24, 2026 at 05:04:15PM +0530, Kuldeep Singh wrote:
> Kaanapali support newer BAM v2.0.0 version.
> Document the compatible string and update example along with it.

And why v2.0.0 is not compatible with v1.7.0? Or what is not compatible?

> 
> Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/dma/qcom,bam-dma.yaml       | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
> index 6493a6968bb4..0923fb189ada 100644
> --- a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
> +++ b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
> @@ -23,6 +23,8 @@ properties:
>            - qcom,bam-v1.4.0
>            # MSM8916, SDM630
>            - qcom,bam-v1.7.0
> +          # Kaanapali
> +          - qcom,bam-v2.0.0
>        - items:
>            - enum:
>                # SDM845, SM6115, SM8150, SM8250 and QCM2290
> @@ -118,4 +120,23 @@ examples:
>          #dma-cells = <1>;
>          qcom,ee = <0>;
>      };
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +

Drop the example, no need for difference in compatible.

Best regards,
Krzysztof


