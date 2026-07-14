Return-Path: <dmaengine+bounces-12483-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pcC2OfYNVmpkygAAu9opvQ
	(envelope-from <dmaengine+bounces-12483-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 12:22:46 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 566AD75359E
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 12:22:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=BOSDqRrC;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12483-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12483-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E0033036720
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 10:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C612036896D;
	Tue, 14 Jul 2026 10:22:42 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7ADE36494C;
	Tue, 14 Jul 2026 10:22:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784024562; cv=none; b=AihGWwNVGhbKpRGtwF3HVgN86So8WDWBYshZb4HMjDYpF4qGqGWPu2GS39suhN40iyvJte3gzXch/dPcgtaBqdv/OgmA2lHZYkI9FzeIL6Lz8aOMh3hQwOB+vihfIopWl2rc3jYLRLUZV6a4tJ81kh/oiYKWMQ1rDj6Yr0kHWvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784024562; c=relaxed/simple;
	bh=x4NxDbIYRfForqY7HJ+9R0ZwxKt+oIW/YSWVVkcUvhw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R1i/Irl+J6dZlk090Lm/pzJlPxMj6/5116kWk5nG8saWPjmI12gBpHBjqdImvJcaFcJ17SmrfqN1G8298r/pxt2vNrwJT2yiNUDBvaBkxP8uUq/qtLMfumZnQ8cOPcv7JTVZ3e676knUPYhyF5lEyd5b4h7KR+J4xwC6toO9+uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOSDqRrC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B586C1F00A3A;
	Tue, 14 Jul 2026 10:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784024561;
	bh=5r3Z27pksi5p/yMYuepepwFIYgmdYvC+UIShzwCa1E8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BOSDqRrCHT4xZXgfCpfcYhuiV2Si/dlgT1Q5OmErqNMdycQO77sY/tPnfuSBLODF8
	 Zm7yHmKgxiiU4oa3kfMgXJKE4BnPxkU6VqtHz7/nFpY2Lm/MC/nbWuXRczBhiwmY5G
	 bFSqBhaCWV+q6aTFC3f4vw5r2vu5T2iLIJRPZ5tYYMhtrHf0PfUFUWSrRqTrhA2mR2
	 cfegmxAnpL4cDh2J61WakJr+75NU72hM+VQOqajlVoJsCI6ryzp/4hJFgYqEZLl55B
	 1TL2LeIM4bD6k8PON1i7jUuDQx6Af4OctldIwP09FfGMle8w4nXZwaDo6jWCbnUakC
	 dK9OsMlgraYWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 6/6] arm64: dts: qcom: shikra: Add ICE, TRNG and QCE
 nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuldeep Singh" <kuldeep.singh@oss.qualcomm.com>
Cc: conor+dt@kernel.org, vkoul@kernel.org, robh@kernel.org, Frank.Li@kernel.org, devicetree@vger.kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260714-b4-shikra_crypto_changse-v4-6-06a4ea97c209@oss.qualcomm.com>
References: <20260714-b4-shikra_crypto_changse-v4-0-06a4ea97c209@oss.qualcomm.com>
 <20260714-b4-shikra_crypto_changse-v4-6-06a4ea97c209@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 10:22:40 +0000
Message-Id: <20260714102240.B586C1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-12483-lists,dmaengine=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuldeep.singh@oss.qualcomm.com,m:conor+dt@kernel.org,m:vkoul@kernel.org,m:robh@kernel.org,m:Frank.Li@kernel.org,m:devicetree@vger.kernel.org,m:dmaengine@vger.kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,qualcomm.com:email,vger.kernel.org:from_smtp,lists.linux.dev:replyto,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 566AD75359E

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The `sdhc_ice` node uses the conceptually incorrect power domain id=
entifier `RPMHPD_CX` (an RPMh macro) instead of the correct `RPMPD_VDDCX` (=
an RPM SMD macro).
--

--- Patch [6]: [PATCH v4 6/6] arm64: dts: qcom: shikra: Add ICE, TRNG and Q=
CE nodes ---
commit ac9385e506169b93982d324a8fd1c94a56ace5b0
Author: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>

arm64: dts: qcom: shikra: Add ICE, TRNG and QCE nodes

This commit adds device tree nodes describing the crypto hardware blocks
present on the Qualcomm Shikra platform, including the BAM DMA controller,
QCE engine, TRNG, and Inline Crypto Engine (ICE). It also connects the
SDHC controller to ICE to support inline encryption.

> diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/q=
com/shikra.dtsi
> index 4e5bc9e17c8ed..a95e2140416c2 100644
> --- a/arch/arm64/boot/dts/qcom/shikra.dtsi
> +++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
[ ... ]
> @@ -604,6 +645,17 @@ opp-384000000 {
>  			};
>  		};
> =20
> +		sdhc_ice: crypto@4748000 {
> +			compatible =3D "qcom,shikra-inline-crypto-engine",
> +				     "qcom,inline-crypto-engine";
> +			reg =3D <0x0 0x04748000 0x0 0x18000>;
> +			clocks =3D <&gcc GCC_SDCC1_ICE_CORE_CLK>,
> +				 <&gcc GCC_SDCC1_AHB_CLK>;
> +			clock-names =3D "core",
> +				      "iface";
> +			power-domains =3D <&rpmpd RPMHPD_CX>;

[Severity: Low]
Does this code use an RPMh power domain macro (RPMHPD_CX) for an RPM SMD
power controller instead of RPMPD_VDDCX?

The sdhc_ice node references the rpmpd (RPM SMD) provider but incorrectly
assigns it the RPMHPD_CX macro. Because dt-bindings/power/qcom-rpmpd.h
explicitly includes dt-bindings/power/qcom,rpmhpd.h, the macro is defined
and evaluates to 0, which happens to match RPMPD_VDDCX.=20

While this avoids build errors and runtime impact, should this use the
correct RPMPD_VDDCX macro to prevent a semantic mismatch?

> +		};
> +
>  		qupv3_0: geniqup@4ac0000 {
>  			compatible =3D "qcom,geni-se-qup";
>  			reg =3D <0x0 0x04ac0000 0x0 0x2000>;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-b4-shikra_=
crypto_changse-v4-0-06a4ea97c209@oss.qualcomm.com?part=3D6

