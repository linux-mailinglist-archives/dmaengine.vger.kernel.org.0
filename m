Return-Path: <dmaengine+bounces-12549-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Coe4KnV6V2qzOwEAu9opvQ
	(envelope-from <dmaengine+bounces-12549-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 14:17:57 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA2275E01D
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 14:17:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZS8Zez77;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12549-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12549-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6996C30453B3
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 12:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E20F44C66F;
	Wed, 15 Jul 2026 12:14:09 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868AA438474
	for <dmaengine@vger.kernel.org>; Wed, 15 Jul 2026 12:14:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784117649; cv=none; b=ukagDg/GP7L+dHuj2N4iAn0sBpzqTDSdX45spv+muQNrLu1fqL1HMdM9v//Zpbtb3VWZ3uxcUzcodJVaqUrJP+39EvoxK7cDPRafuDsHonYLb8F0R4KGwnUatKK6UWI5o4JUwXeYX1zoe5cjMviY67FdVTwuHLL8Of7G0vMi2Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784117649; c=relaxed/simple;
	bh=YvgJwlRpkS4j5aFo+iirEvbab1JzInwGnelmvUdllFs=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lnz4wQiVGgd1kWI7X7Os70meeNJdJUNk/pGNP+9NMYSv92DqGpYOm/ALwWA2WiWRAxfl2lU9eOZsf8Td5Qgdfst/fbpZQ9lY9zNM6yCMcpTkyEGgWVPwcd7Qxpq8R25paqSiUhf8E81RCl+nM7Ehuo1Fm4Zj+SOIi2RyV4PxEcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZS8Zez77; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DFB51F0155E
	for <dmaengine@vger.kernel.org>; Wed, 15 Jul 2026 12:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784117647;
	bh=1Qoi+UWj99+JFyBfVjJ3X8HhkjskHToO4hndHwTkgUI=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=ZS8Zez77lkvzR2E3edpyn+xXc7laO5LJOum++DQRWFZ/8lgkjcm0JZTQ2YXjtQMdZ
	 hXr+/wEqd7SxfxBQPaCKQ+uuCYKHpuPv99syvBoJbjk03+kBBOi5oTaHFn6yVbE/HM
	 ntzJ3uzpdWzeoFv5EERUIfWFxmev8t3LaMyYU4KxLrk1uYjikIs5dYhC28IeVG+Cu8
	 r+24VE4I17f++cD6WyDkSdmJCDWNRhBJBIOwJ3wS6cZTnEljkhQAIia3YPRkWXhuv9
	 1Zvv2B2pBvlGWm0wH8ktyDCTvkY1iEdS26FEo2FlLleFNu0/1i94f4RzKj4uLr8quw
	 PhxrxIkMGtw8A==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-39c74c469e8so41748121fa.0
        for <dmaengine@vger.kernel.org>; Wed, 15 Jul 2026 05:14:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqNUM6wb2bMSTLkWzX/nbSy85et4f+K6phH7fx+Zi0POjzaZf/XCoCE0aedaYFzz09ci78JmJE9T+M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyehl8N+jVPkYY1zmQoip8Y6MhMD3C2INGWynG4o/hYu+hK/3cb
	YpfXUcxCga5h7C8IZ8teZCCJV0s7OZj3IL9ZKSrrn1im1oi0r6oOVAuXz0ncOu/aO/vYcXBdOe9
	/qQjMNlGzsF92QmK6oYrhRLZ1S9pCn21+6j3c9X1Jcw==
X-Received: by 2002:a05:6512:2508:b0:5b0:e15:772e with SMTP id
 2adb3069b0e04-5b15d7a87e3mr637916e87.51.1784117645993; Wed, 15 Jul 2026
 05:14:05 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Jul 2026 05:14:04 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Jul 2026 05:14:04 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260714-b4-shikra_crypto_changse-v4-1-06a4ea97c209@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714-b4-shikra_crypto_changse-v4-0-06a4ea97c209@oss.qualcomm.com>
 <20260714-b4-shikra_crypto_changse-v4-1-06a4ea97c209@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 05:14:04 -0700
X-Gmail-Original-Message-ID: <CAMRc=McQbz3NgrKu-6OLp80VerWWRM1dCYkinznvrU4KYXxQow@mail.gmail.com>
X-Gm-Features: AUfX_myx3qsvrOOlj_433vZ0yt5OaPHQ_RTUX3Ukm6BF9xfctDg7hyDHWNlbUm0
Message-ID: <CAMRc=McQbz3NgrKu-6OLp80VerWWRM1dCYkinznvrU4KYXxQow@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] dt-bindings: crypto: qcom,inline-crypto-engine:
 Fix legacy/new SoC strictness split
To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Harshal Dev <harshal.dev@oss.qualcomm.com>, 
	Vinod Koul <vkoul@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Andy Gross <agross@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, 
	linux-crypto@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12549-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER(0.00)[brgl@kernel.org,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kuldeep.singh@oss.qualcomm.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:harshal.dev@oss.qualcomm.com,m:vkoul@kernel.org,m:brgl@kernel.org,m:konradybcio@kernel.org,m:Frank.Li@kernel.org,m:agross@kernel.org,m:krzysztof.kozlowski@oss.qualcomm.com,m:linux-arm-msm@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,qualcomm.com:email,vger.kernel.org:from_smtp];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2CA2275E01D

On Tue, 14 Jul 2026 12:05:12 +0200, Kuldeep Singh
<kuldeep.singh@oss.qualcomm.com> said:
> Couple of already merged SoCs(like sc7280, sm8750, kaanapali etc.)
> describe ICE as single clock historically which are recently updated
> with mandatory 2 clocks.
>
> Keep only the known legacy compatibles flexible, and make strict
> validation default(of power-domains and 2 clocks) for all other Soc
> compatibles.
>
> This ensures old DTs are valid while ensuring any new SoC (like hawi,
> milos, eliza, nord, maili or any upcoming ones) must follow latest
> requirements by default.
>
> Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
> ---
>  .../bindings/crypto/qcom,inline-crypto-engine.yaml | 26 ++++++++++++++--------
>  1 file changed, 17 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml b/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
> index 7be14e99be28..cce21aae6499 100644
> --- a/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
> +++ b/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
> @@ -57,17 +57,25 @@ required:
>
>  additionalProperties: false
>
> +# Do not extend the list.
> +# Legacy SoCs are allowed for single clock.
> +# New SoCs must provide both clocks and power domains.
>  allOf:
>    - if:
> -      properties:
> -        compatible:
> -          contains:
> -            enum:
> -              - qcom,eliza-inline-crypto-engine
> -              - qcom,hawi-inline-crypto-engine
> -              - qcom,maili-inline-crypto-engine
> -              - qcom,milos-inline-crypto-engine
> -              - qcom,nord-inline-crypto-engine

Huh, so it did get in first after all, I wasn't aware.

> +      not:
> +        properties:
> +          compatible:
> +            contains:
> +              enum:
> +                - qcom,kaanapali-inline-crypto-engine
> +                - qcom,qcs8300-inline-crypto-engine
> +                - qcom,sa8775p-inline-crypto-engine
> +                - qcom,sc7180-inline-crypto-engine
> +                - qcom,sc7280-inline-crypto-engine
> +                - qcom,sm8450-inline-crypto-engine
> +                - qcom,sm8550-inline-crypto-engine
> +                - qcom,sm8650-inline-crypto-engine
> +                - qcom,sm8750-inline-crypto-engine
>
>      then:
>        required:
>
> --
> 2.34.1
>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

