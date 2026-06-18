Return-Path: <dmaengine+bounces-11602-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id weK8Kwp9M2qyCgYAu9opvQ
	(envelope-from <dmaengine+bounces-11602-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 07:07:22 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 252DE69DA16
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 07:07:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=aLblJfly;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11602-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11602-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1D81303E6F4
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 05:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BE937E2E5;
	Thu, 18 Jun 2026 05:07:19 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28ADF33F8BC;
	Thu, 18 Jun 2026 05:07:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781759239; cv=none; b=XpkloQFf7boYO616RUPDtKw5qVxb80uyClCCirNir2eL7XIv3XU4Vnnk7HF13dwSbK66gCIvTObE1pmBjOp1TftRRisLHI9aSa/fci6iMbt8mL1jIZlt897yue+rS0dqAIrtmjCYYXIeY52YRAXocVdfy7peZLXHqKd9/ETM8Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781759239; c=relaxed/simple;
	bh=hCNBCVQZCoSls9PDC06VONgNWx06rQ4+wyN9jWbe9og=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mlSRn2XawcIFWLeSpUSzad69km9Rw6dSwkRN6DHXQFwj90j+LqUpIBoWaO3kHrIk0xC0U5VUDMO/MS1umo1ZerhaXLSsEqw5bUIQfy5NHaHfce3yEleFNgHoHxywoQiSw/ghYdzxkTSbF6tvJQtdIICS10EY54h2n8EOi3qnxWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLblJfly; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8101C1F000E9;
	Thu, 18 Jun 2026 05:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781759237;
	bh=VtoFkjQ72jcgGKCMeeCMx+/0yn8W4bXsMpFdpVKr/mg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aLblJflyiBqE/VJ8xg6Gidd3rAJ9VwrjfzMMQk4PECzQ5nV3f900N/HnXunvxDQbx
	 3PBMIHGl440DuAVItPQMB57sKYZ/X5l7/lS0mFGXyO7A6m5Yb3ROYvvb4+xP2zhcXF
	 RK9d8B39E0kC9rk4z/lKn5vnS8dKs0/EjswTZRaGAqDqU+MFsygRG00KeciBSYPZ5x
	 RjVqFKNMie4gPef9yULUbgJeCvn0/bUkXelnc2TKVsfgKFUVb2YfqQtpcWpV6icgj7
	 OV4FIuoLJ5dPTy8vlfuAfiSPe/PQfpDG6iL6CnlojL76OI2aXcpLfgwVpBGdT1UhAO
	 qP9tE0GhVEPog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/11] dt-bindings: power: Convert Ux500 PM domains to
 schema
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linus Walleij" <linusw@kernel.org>
Cc: devicetree@vger.kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org, dri-devel@lists.freedesktop.org, conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260618-ux500-power-domains-v7-1-v1-1-eb5e50b1a588@kernel.org>
References: <20260618-ux500-power-domains-v7-1-v1-0-eb5e50b1a588@kernel.org>
 <20260618-ux500-power-domains-v7-1-v1-1-eb5e50b1a588@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 05:07:17 +0000
Message-Id: <20260618050717.8101C1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-11602-lists,dmaengine=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linusw@kernel.org,m:devicetree@vger.kernel.org,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,m:vkoul@kernel.org,m:dri-devel@lists.freedesktop.org,m:conor+dt@kernel.org,m:robh@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 252DE69DA16

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The example consumer node `sdi0_per1@80126000` will fail `dt_bindin=
g_check` validation due to missing required properties and will trigger a `=
dtc` warning.
--

commit b98e3bf1a2da87a6966744348740e230bb97bdfd
Author: Linus Walleij <linusw@kernel.org>

dt-bindings: power: Convert Ux500 PM domains to schema

This commit converts the legacy Ux500 power domain text binding to YAML.
It moves the binding under bindings/power and updates the MAINTAINERS file
accordingly.

> diff --git a/Documentation/devicetree/bindings/power/stericsson,ux500-pm-=
domains.yaml b/Documentation/devicetree/bindings/power/stericsson,ux500-pm-=
domains.yaml
> new file mode 100644
> index 0000000000000..72c39c083efbf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/stericsson,ux500-pm-domains=
.yaml

[ ... ]

> +examples:
> +  - |
> +    #include <dt-bindings/arm/ux500_pm_domains.h>
> +
> +    pm_domains: power-controller {
> +        compatible =3D "stericsson,ux500-pm-domains";
> +        #power-domain-cells =3D <1>;
> +    };
> +
> +    sdi0_per1@80126000 {
> +        compatible =3D "arm,pl18x", "arm,primecell";
> +        power-domains =3D <&pm_domains DOMAIN_VAPE>;
> +    };

[Severity: Low]
Will this example consumer node trigger warnings during dt_binding_check?

The node is matched against the arm,pl18x.yaml schema, which requires both
the reg and interrupts properties. Since they are missing here, dt-schema
will likely report validation errors.

Additionally, because the node includes a unit address (@80126000) but lacks
a reg property, does this cause dtc to emit a unit_address_vs_reg warning?
Should dummy reg and interrupts properties be added to the example to
satisfy the schema validation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-ux500-powe=
r-domains-v7-1-v1-0-eb5e50b1a588@kernel.org?part=3D1

