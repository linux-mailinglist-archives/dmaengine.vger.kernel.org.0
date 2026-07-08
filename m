Return-Path: <dmaengine+bounces-12099-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jnC6Nv/dTWpo/QEAu9opvQ
	(envelope-from <dmaengine+bounces-12099-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 07:19:59 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA8F721C19
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 07:19:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=dvlDANn4;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12099-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12099-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B8B33007AD4
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jul 2026 05:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3743AC0E5;
	Wed,  8 Jul 2026 05:19:56 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F3C331222;
	Wed,  8 Jul 2026 05:19:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783487996; cv=none; b=QZLAXVsK7nzk+zSTjNzlHRWhX0n2V3CTQXxq6nGltVoG/rl7sXLEYerhmYmioXjPox44Al8kOyZ35qC8zKAYYe06iScSB8ap6jYLEKvTgJ2gZSxUpnnCFCiCxI0gj30Erji3kUAmzbQBqTVw5taqudYwR9puim34Z31rUsOCDvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783487996; c=relaxed/simple;
	bh=6eDfkCTAmOkSqvhRtkW5wTaUfweLRtqkeS2K+TGtino=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fwmI9+7EgjUhu6VKsPPRO/jmo+V9CoqfGprLCqn0J3NyNq8Hbz00rdLMWHyvDWMuwXRQsDNKmddZ7G83sh0UE6ZNM0GaOLefbNuquN/J2O9JnMco1w6Pi5bgGObhvtcAS647HxwMVbKuentIdOiv8icbru8CayNav5LQ7VVCyMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvlDANn4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E231F000E9;
	Wed,  8 Jul 2026 05:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783487995;
	bh=sV1lImlGaGI4xyYYlP1aZWjAAwk6Xk1SEEZ12erpZMs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dvlDANn4bAtuZq53ISvHwuWxQN3y+4Af34E7XUD7LvIbw1VT2pceMSL//uCY0UeJg
	 g9QQz2UmgctMw36vHX9f7AyHjTh0X3Sc5RglC/CyOn3QybXlyElpXgbtIvF9+206D+
	 lgpBbArqsxI4svLXIhIYGJQhphR2EcQkyIbzG2Div2LJ4jhrr23yv0P2J6hB99Oygi
	 GkfrhWrWSo2bSItX3sdKVvnCpjCm8mms5Q3s6AYkKGTi0QyRyUW/VfUP/j61n/QDNJ
	 r4xOB1u5l/pBiKWHN9UVptGQEKB7yCn8Na1rqDaj8QaV+fyv3bbbgQDcxnDWYQ1jxi
	 0Uza74z07Bjxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/4] dt-bindings: i2c: qcom,i2c-geni: Document
 multi-owner controller support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mukesh Kumar Savaliya" <mukesh.savaliya@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, Frank.Li@kernel.org, robh@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260708051023.2872304-2-mukesh.savaliya@oss.qualcomm.com>
References: <20260708051023.2872304-1-mukesh.savaliya@oss.qualcomm.com>
 <20260708051023.2872304-2-mukesh.savaliya@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 05:19:54 +0000
Message-Id: <20260708051954.E3E231F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-12099-lists,dmaengine=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mukesh.savaliya@oss.qualcomm.com,m:devicetree@vger.kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:conor+dt@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,smtp.kernel.org:mid,sashiko.dev:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lists.linux.dev:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3FA8F721C19

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] YAML syntax error in `qcom,qup-multi-owner` description due to miss=
ing block scalar indicator.
--

--- Patch [1]: [PATCH v8 1/4] dt-bindings: i2c: qcom,i2c-geni: Document mul=
ti-owner controller support ---
commit d38e4d9aefae5285416967f29ecb244ec4f2d7e0
Author: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>

dt-bindings: i2c: qcom,i2c-geni: Document multi-owner controller support

This commit adds a boolean property to the qcom,i2c-geni device tree binding
to describe QUP-based I2C controllers that are shared across multiple system
processors. It notes that the operating system must not assume exclusive
ownership of such controllers or reconfigure associated GPIOs into sleep
states.

> diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yam=
l b/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
> --- a/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
> +++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
> @@ -60,6 +60,22 @@ properties:
>    power-domains:
>      maxItems: 1
> =20
> +  qcom,qup-multi-owner:
> +    type: boolean
> +    description:
> +      Indicates that the QUP-based controller is shared with one or more
> +      other system processors and must not be assumed to have exclusive
> +      ownership by the operating system.
> +
> +      The associated GPIOs must not be reconfigured into a sleep state

[Severity: Low]
Will this description format cause a YAML parsing error during a schema che=
ck?

Because the description spans multiple paragraphs separated by blank lines,
it appears to need a block scalar indicator (such as '|' or '>') immediately
following the 'description:' key.=20

Without it, a YAML 1.2 parser may treat the blank line as the end of the
scalar and fail to parse the next paragraph, throwing an error when it cann=
ot
find a mapping key for the subsequent text.

> +      during runtime suspend, as doing so may disrupt transactions
> +      initiated by another owner of the controller.
> +
> +      Each owner is responsible for maintaining any resource votes
> +      required for operation of the shared controller (for example clock=
s,
> +      power domains, interconnect bandwidth, or other platform-specific
> +      resources)
> +
>    reg:
>      maxItems: 1

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708051023.2872=
304-1-mukesh.savaliya@oss.qualcomm.com?part=3D1

