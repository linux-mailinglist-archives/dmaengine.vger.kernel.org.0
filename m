Return-Path: <dmaengine+bounces-12084-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id po0nH5JxTWqU0AEAu9opvQ
	(envelope-from <dmaengine+bounces-12084-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 07 Jul 2026 23:37:22 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E58C071FCDF
	for <lists+dmaengine@lfdr.de>; Tue, 07 Jul 2026 23:37:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HG99Q4GQ;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12084-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12084-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17176302BF7D
	for <lists+dmaengine@lfdr.de>; Tue,  7 Jul 2026 21:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BA142E8C7;
	Tue,  7 Jul 2026 21:36:22 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624AF422550;
	Tue,  7 Jul 2026 21:36:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783460182; cv=none; b=hbcgBRA8Vs07hpmNR0eFgILxFbcU02mzrifl6dK6ZokVALqgnFVDt6oV76TrJHtUzFc6LzeAgewaXc2ksfgZoKp0qUjVbc7coatepVAZ4JWHSMA/Y3tacoSYsRO4maGxp6vQGrM5wl49wTC1xqfHYK6Bd5rHu8oYqrrmTouJjx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783460182; c=relaxed/simple;
	bh=rPD8d5G2eauLry56S1lA4mNwewn4/63LMqG4LyUhE70=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Jjvk77Zbl/pivaQWpCX0My/s+VZqyY/IEhzOXhjjRBdhwrtijHb2dNYX0dVlWA8DTJLDz3cFSoeAijw2TEWAOn6Odch9BzQSfU++IVVmj3e7rzgGqPXcmn75Qx15ggrgTHwIWCYvSBpSw2TQFviuuOr90vCXCWQ+8SeszWBlfDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HG99Q4GQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E8421F000E9;
	Tue,  7 Jul 2026 21:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783460181;
	bh=CUr+KdlXNRSXc2JMvdJOxfhYpijs3M9YU1vKWeI98kQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HG99Q4GQWiFSIdWzLTBhhj7U43SFubzOnwyu2MVmCGy1aHtVwt1KiVZgThQSdUaoL
	 0KV+D/RJgfebDvLN+nwPoxRWAVSR43LcjODZPlqQCUtTm61Jgvz9IL3qcWx36SzGkW
	 OIYViTuuPkP7J6MngszwamwG1VZl7qn4WjWITp8cIEpyhjhR0QRUtv0w5bdZ+H3noj
	 syOnj+QvmaxOzDevw45RmOi6QZB+bbJ+1Z7DE8znP+5YjJDgDN/liFQHh/zjfTCsK9
	 +koP/B9pSio0/9/CVFYCx1ZKEVFeSB1U8B4sZFHQOU1fFitPu57aVLOerHOfiIwK8/
	 Dga3quS+yFw9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dt-bindings: dma: ti,dma-crossbar: Convert to DT schema
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bhargav Joshi" <j.bhargav.u@gmail.com>
Cc: conor+dt@kernel.org, robh@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260708-ti-dma-crossbar-v1-1-f62796428f13@gmail.com>
References: <20260708-ti-dma-crossbar-v1-1-f62796428f13@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 21:36:20 +0000
Message-Id: <20260707213620.8E8421F000E9@smtp.kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-12084-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:j.bhargav.u@gmail.com,m:conor+dt@kernel.org,m:robh@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:devicetree@vger.kernel.org,m:jbhargavu@gmail.com,m:conor@kernel.org,s:lists@lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,smtp.kernel.org:mid,vger.kernel.org:from_smtp,devicetree.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E58C071FCDF

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] The YAML conversion drops critical documentation detailing the DMA =
specifier layout for clients (formatting and meaning of the `#dma-cells` pa=
rameters).
- [Low] The `ti,reserved-dma-request-ranges` property is defined as a `uint=
32-matrix` but lacks constraints on its inner tuple dimensions.
--

--- Patch [1]: [PATCH] dt-bindings: dma: ti,dma-crossbar: Convert to DT sch=
ema ---
commit adc2900e39482ff7d8433cdf6ef2cabd79619bea
Author: Bhargav Joshi <j.bhargav.u@gmail.com>

dt-bindings: dma: ti,dma-crossbar: Convert to DT schema

Convert Texas Instruments DMA Crossbar from text to DT schema

> diff --git a/Documentation/devicetree/bindings/dma/ti,dra7-dma-crossbar.y=
aml b/Documentation/devicetree/bindings/dma/ti,dra7-dma-crossbar.yaml
> new file mode 100644
> index 0000000000000..287260396098f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/ti,dra7-dma-crossbar.yaml
> @@ -0,0 +1,105 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/ti,dra7-dma-crossbar.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments DMA Crossbar (DMA request router)
> +
> +maintainers:
> +  - Bhargav Joshi <j.bhargav.u@gmail.com>
> +  - Peter Ujfalusi <peter.ujfalusi@gmail.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,dra7-dma-crossbar
> +      - ti,am335x-edma-crossbar
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#dma-cells":
> +    minimum: 1
> +    maximum: 3
> +

[Severity: Low]
Does this conversion unintentionally drop the documentation explaining the =
DMA
specifier layout for clients?

The deleted text binding included details about the formatting and meaning =
of
the parameters, which device tree authors need to correctly formulate the d=
mas
property:

For ti,am335x-edma-crossbar: the meaning of parameters of dmas for clients:
dmas =3D <&edma_xbar 12 0 1>; where <12> is the DMA request number, <0> is =
the
TC the event should be assigned and <1> is the mux selection for in the
crossbar.

Could this description be preserved in the YAML schema, either in the=20
top-level description or under this #dma-cells property?

> +  dma-requests:
> +    minimum: 1
> +    maximum: 256
> +
> +  dma-masters:
> +    maxItems: 1
> +
> +  ti,dma-safe-map:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Safe routing value for unused request lines
> +
> +  ti,reserved-dma-request-ranges:
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    description:
> +      DMA request ranges which should not be used when mapping xbar inpu=
t to
> +      DMA request, they are either allocated to be used by for example t=
he DSP
> +      or they are used as memcpy channels in eDMA.

[Severity: Low]
Should this uint32-matrix property include constraints on its inner tuple=20
dimensions?

Without items definitions to enforce a tuple length of 2 (start and length)=
,=20
schema validation might fail to reject device trees that have incorrect=20
tuple sizes like <10 5 99>.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-ti-dma-cro=
ssbar-v1-1-f62796428f13@gmail.com?part=3D1

