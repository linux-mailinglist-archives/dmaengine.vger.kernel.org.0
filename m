Return-Path: <dmaengine+bounces-12548-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id N/s6EOh7V2pXPAEAu9opvQ
	(envelope-from <dmaengine+bounces-12548-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 14:24:08 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE1F75E0D2
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 14:24:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=OdVwuaRI;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12548-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-12548-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BBEA33003481
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 12:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7D2438030;
	Wed, 15 Jul 2026 12:13:20 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7F83EB818
	for <dmaengine@vger.kernel.org>; Wed, 15 Jul 2026 12:13:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784117600; cv=none; b=ANNfVpfrIrTRc6XxqlNzzE9AnEgSll80zVZLFWuTZi82SQ4os1Uv+CK+MtZ33vLRUNwTTNCwr4Nw5SxJupiKrn1kWfe7psFr6veHiQRUpl/gIEUwZf8tWkR+ta7pzWQ+ADs8l2t1sp9QwcEpBCww2LANQcpL4WsMm9VLdFv/md0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784117600; c=relaxed/simple;
	bh=gNl5/ZnFxiNLQCcvtvH8upGV8QmIKJ7OniNlJJrNsto=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G5Oo78H5z528QesCMyLPPkzCpIKvooPSOO3JlkcB5eFB0Q/pWglAUhh6T7bPPiJzf6zUOSNRpui1jmcJfQK9YBaP/tdQhXBkfq7wD4F+zqrjzal02RK5C1nd+gaFxQq8b3/nONqJZpbNR339GiE6f8/I/ufwicHo1vxOMsmHzCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OdVwuaRI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B64B91F01559
	for <dmaengine@vger.kernel.org>; Wed, 15 Jul 2026 12:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784117599;
	bh=IvqJ6hW+hUO9tvsLL6o5nEWp718Mhw+RBi7JmsGm4BE=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=OdVwuaRI70Nq2v/5ItDFn/LeHAMt2u46DJKRsbAvJHjoXiIwpQ5AqlIVlDYvxKvqB
	 ICTuouuOqFtR3W/JMCcAEDFn8EgaxTMnrc9mFU9JCmzFbU9cUeojpN819MHLxmQuyC
	 KWXKF6lp2/q6Xfd8iWulAcWLmYxTwVsyFe9DFDPV+tvMGZbcC/ezAqJb/X3FGZ7Lwn
	 9fkjgjagycosHNIPv+Dcp+7D0f3mmOBJdxWYcQmZ+3CJohmMg0qPhcPo0UN88lHdOR
	 ZQU0/agCgQLTG0ob4Iwxh3TDjYu86ryG4EhpHkPiNZ99XY1LBNeNSev76DNLVuEgnU
	 jyBnBK6YCGKbw==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39c94fccf3eso31998751fa.0
        for <dmaengine@vger.kernel.org>; Wed, 15 Jul 2026 05:13:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpZtFFwfEQO5WHV+RyKrOLbzbz1fbwE+B/krLe8EN3OR5PwaGMhC7WqAbhNrlzATC+geZnHN2ip0gI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEu56JOEKZGcvKwtfQYT6Fu1LMLNWZMn/zWG336roBxg2l3n0/
	Wvcu/duWvrz/45aiBegsnSwqIiC49beWuih6MNCwc+bo2GNWBBJVRyyej7oG8jy6SDKfGsddLTB
	TYnavG5tSNB0Mpxxj5Whje6rz4MH3ox7ex1sDGIEZCQ==
X-Received: by 2002:a2e:a913:0:b0:39b:f25:6050 with SMTP id
 38308e7fff4ca-39db6d4d3a6mr6178751fa.20.1784117598343; Wed, 15 Jul 2026
 05:13:18 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Jul 2026 05:13:16 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Jul 2026 05:13:16 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260714-b4-shikra_crypto_changse-v4-5-06a4ea97c209@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714-b4-shikra_crypto_changse-v4-0-06a4ea97c209@oss.qualcomm.com>
 <20260714-b4-shikra_crypto_changse-v4-5-06a4ea97c209@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 05:13:16 -0700
X-Gmail-Original-Message-ID: <CAMRc=MeWeMfry1UThKdw5U7mLcGc2LFOCiDikPEps5K+0nQg6A@mail.gmail.com>
X-Gm-Features: AUfX_mzuoja5mZwmlfZnsqzI2FkD2yFcwkvWpiPulhTnwjEhajmQYmGlODoqU04
Message-ID: <CAMRc=MeWeMfry1UThKdw5U7mLcGc2LFOCiDikPEps5K+0nQg6A@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] dt-bindings: dma: qcom,bam-dma: Increase iommus
 maxItems to 7
To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, 
	linux-crypto@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Harshal Dev <harshal.dev@oss.qualcomm.com>, 
	Vinod Koul <vkoul@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Andy Gross <agross@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12548-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER(0.00)[brgl@kernel.org,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kuldeep.singh@oss.qualcomm.com,m:krzysztof.kozlowski@oss.qualcomm.com,m:linux-arm-msm@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:harshal.dev@oss.qualcomm.com,m:vkoul@kernel.org,m:brgl@kernel.org,m:konradybcio@kernel.org,m:Frank.Li@kernel.org,m:agross@kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:email,mail.gmail.com:mid];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brgl@kernel.org,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2FE1F75E0D2

On Tue, 14 Jul 2026 12:05:16 +0200, Kuldeep Singh
<kuldeep.singh@oss.qualcomm.com> said:
> Qualcomm Shikra platform describes the BAM DMA node with 7 iommus
> entries. The current schema limit to 6, so update the binding to allow
> up to 7 entries.
>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
> index 0923fb189ada..e72adc172af1 100644
> --- a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
> +++ b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
> @@ -48,7 +48,7 @@ properties:
>
>    iommus:
>      minItems: 1
> -    maxItems: 6
> +    maxItems: 7
>
>    num-channels:
>      $ref: /schemas/types.yaml#/definitions/uint32
>
> --
> 2.34.1
>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

