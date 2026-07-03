Return-Path: <dmaengine+bounces-12023-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qIonI5V0R2ruYQAAu9opvQ
	(envelope-from <dmaengine+bounces-12023-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 03 Jul 2026 10:36:37 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE79700227
	for <lists+dmaengine@lfdr.de>; Fri, 03 Jul 2026 10:36:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="KfLt/9EI";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12023-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12023-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 427B5319CA7C
	for <lists+dmaengine@lfdr.de>; Fri,  3 Jul 2026 08:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825E233BBB9;
	Fri,  3 Jul 2026 08:17:19 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFF4148850
	for <dmaengine@vger.kernel.org>; Fri,  3 Jul 2026 08:17:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783066639; cv=none; b=pZOunQ5ZkDONp8+BEpBpAXr8XqW/PNIEBcvTE4XBg1MNWebKqYN08vjdhzwTGMNX1Qt5EijH3Tju1qw7eCP9ykQ8zssQ12+8LPInEqup1koJ3/lPIijpc/G574XG3Rt5gl35mmVkzWx1iclD04BNE+mef2/radFr5YUkV0O8GeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783066639; c=relaxed/simple;
	bh=OUf0qjGFFxksslj6x5pLYjlkNxo4nBzeIug7Q6fIVs0=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IknDzQLr9NarFYD/9ZI8Ih+jxIHIuduFBaMQw5sTIZBVKt8VHM4/PJ81YhZ1sC8IOgZCtoyILML8l/+9Dt13viRTKmhDFBWnttNuApGH99m6FwyL0Th6ZZphNyb0s+NsaZm7hY2wVvfAGI8BRMuycDFuFS/TcQNfwFKDaBGNIro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfLt/9EI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF081F01559
	for <dmaengine@vger.kernel.org>; Fri,  3 Jul 2026 08:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783066638;
	bh=JwhY3idhTm383WR3+G7GxVaTBhOUK0/Ypiz1L3Lcda0=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=KfLt/9EIkrBWCtRywWlaMfYHFpedrq/wLqwVbccRBplz4B39klNFryzaVD/fs5d1U
	 3PbTKpBBWSasTXYYXG9TuzAeFKlJOSI5TlWeFiVPWu/2JXrjogd1IkpLFFWCM6KOFi
	 HeUNCYoQj/2P0bTMMoLkpM/Y+WE7S5y7StALfG3sEZ57FK1T1B16rlGTOkJhhzRnFe
	 DuSQyOcJ1a/5jUdOHSvI5m3RJTCHvSqoVeeAyEOMyHklwDqxdfSVGMnw0tO6KPJesV
	 NxBGWbPRIUyhq2uYNWn2o9WixrkTPT0FIghW6C2txBh9Ca55/oq6PWT91aR3V7adZ4
	 Dp67PIYNYZUsA==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-39b19e7d6fcso2540641fa.1
        for <dmaengine@vger.kernel.org>; Fri, 03 Jul 2026 01:17:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpCFGxxqbyyuVqGxdJVE6X2FdSkCalE7AeAaFM6/BYTT1Zj3tBKJ+Rj/MojqsoekIcD+1xH49qteIs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+fOjiqEKTnnl41yR+MyPGaQNC8QI7+eIFB2K7jTvFvHTg4i3B
	faeEoAfSDyGWQOTBHu0gyZe1GkiUzucb7NXiwvrDtzpAl/KQK/SnTivsmcCp/hvpc4iBTB1xBur
	+k86PJmxmYQ1BHdhW++MKIJ0yj24VkMqy8eNJ0wYj+g==
X-Received: by 2002:a05:6512:630f:b0:5ae:aeea:c60a with SMTP id
 2adb3069b0e04-5aec6797417mr1950427e87.11.1783066637026; Fri, 03 Jul 2026
 01:17:17 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 3 Jul 2026 03:17:15 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 3 Jul 2026 03:17:15 -0500
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260702-b4-shikra_crypto_changse-v2-2-66173f2f28b3@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702-b4-shikra_crypto_changse-v2-0-66173f2f28b3@qti.qualcomm.com>
 <20260702-b4-shikra_crypto_changse-v2-2-66173f2f28b3@qti.qualcomm.com>
Date: Fri, 3 Jul 2026 03:17:15 -0500
X-Gmail-Original-Message-ID: <CAMRc=Md92bojjNn+YG=0RYgK8aN+kKs27B=_E-6=px_CSfamLw@mail.gmail.com>
X-Gm-Features: AVVi8CcvVahfa37Rc1yk796o3IULO9dBSYjJtrJ1IzN0S4aK3kI5E3-zWO8HD3Y
Message-ID: <CAMRc=Md92bojjNn+YG=0RYgK8aN+kKs27B=_E-6=px_CSfamLw@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] dt-bindings: crypto: qcom,inline-crypto-engine:
 Document Shikra ICE
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12023-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER(0.00)[brgl@kernel.org,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kuldeep.singh@oss.qualcomm.com,m:krzysztof.kozlowski@oss.qualcomm.com,m:linux-arm-msm@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:harshal.dev@oss.qualcomm.com,m:vkoul@kernel.org,m:brgl@kernel.org,m:konradybcio@kernel.org,m:Frank.Li@kernel.org,m:agross@kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,mail.gmail.com:mid];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DBE79700227

On Wed, 1 Jul 2026 22:17:12 +0200, Kuldeep Singh
<kuldeep.singh@oss.qualcomm.com> said:
> Document the Inline Crypto Engine (ICE) on the Qualcomm Shikra platform.
>
> Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml b/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
> index 4f3689a24410..9e6d3af42971 100644
> --- a/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
> +++ b/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
> @@ -21,6 +21,7 @@ properties:
>            - qcom,sa8775p-inline-crypto-engine
>            - qcom,sc7180-inline-crypto-engine
>            - qcom,sc7280-inline-crypto-engine
> +          - qcom,shikra-inline-crypto-engine
>            - qcom,sm8450-inline-crypto-engine
>            - qcom,sm8550-inline-crypto-engine
>            - qcom,sm8650-inline-crypto-engine
>
> --
> 2.34.1
>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

