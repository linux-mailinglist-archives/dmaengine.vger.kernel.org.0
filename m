Return-Path: <dmaengine+bounces-12439-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dDxjFCNDVWrlmAAAu9opvQ
	(envelope-from <dmaengine+bounces-12439-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 21:57:23 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A05274EEB5
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 21:57:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QTzJGmjX;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12439-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12439-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F12C130305CC
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 19:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691D4359A6C;
	Mon, 13 Jul 2026 19:57:12 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D173358379;
	Mon, 13 Jul 2026 19:57:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783972632; cv=none; b=fnO0AYqAKUb/Rs2BrzGgKNmOXOBnnf+l7AZDpUrB1cbJPwWGt/pQlmq/klhLvLIgOSQfMRMpl+wuf9Jmb/cgOdoR56BJI1bQFdCyMRIokBY3pkcVVy91Mc6St0k3ikbLMX9rygc19Bh5pHJgS1Fg+5sstHQWLRHbmctnvQ3DJGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783972632; c=relaxed/simple;
	bh=7HBr9bx16WNpztiZ+imRF+Iuppqc6u1b3CX8c0GjIlc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KtTVy/HfaRES4d5fotJwKQs/8dBWJ9PpF0ON48vJXjHqBx4rHZKPJ9aEagRVazr8FWLNKOjBMJa6nkX8KburwLODjW8uzIgDrxPWIYfIl/nGr7kz0PHxjYW4KJbI1Nnm9aiH4nvMTEDIwmXMhKwLaqxbSYjBBuXzcft4C11rpfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTzJGmjX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D5241F000E9;
	Mon, 13 Jul 2026 19:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783972630;
	bh=s1OhJA6QAkINroSZ4Je9QlXJbHB576JiAJRMdWngvTw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QTzJGmjXtyozHYBX0KqfpAGK7dz3LC+QFGQqHFKM1Ats1eoGGs8Bkn3exLh6Rp9Eh
	 SS96kp6joifcB2KuP1cb1nG6A5I3r1m4SNV4HPyqm4bkopgVM/Gsj1+StO3cKhMTwH
	 IBnD5rgcAI/9Cc3MH8UKJZ5OpsFSyWIs+Bew9n35k7WFo5NJKWIz5KRHAgdiHoE772
	 5vkQ4fzZZ4uPgGaUFYTwQcw2Dr/0OwFjOxo7xSVZ0ugHqV245c7Vhak6g/ikafm6jj
	 4azBEWajBkXJc57AGpVV8CEpXzFxaSvZ7OrSRX251rcvNkEjQ99IJD/FJ9ohd81JGW
	 nul11J0Eo3RbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 10/11] arm64: dts: qcom: shikra: Enable WiFi/BT on
 SoMs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Komal Bajaj" <komal.bajaj@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, dmaengine@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260714-shikra-dt-m1-v6-10-bee265d3499b@oss.qualcomm.com>
References: <20260714-shikra-dt-m1-v6-0-bee265d3499b@oss.qualcomm.com>
 <20260714-shikra-dt-m1-v6-10-bee265d3499b@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 19:57:09 +0000
Message-Id: <20260713195710.5D5241F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-12439-lists,dmaengine=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:komal.bajaj@oss.qualcomm.com,m:devicetree@vger.kernel.org,m:dmaengine@vger.kernel.org,m:robh@kernel.org,m:conor+dt@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,sashiko.dev:url,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9A05274EEB5

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] Critical under-voltage and over-voltage hazards due to incorre=
ct regulator assignments for the WCN3988 PMU and WiFi nodes.
- [High] Missing `vddch1-supply` causes power sequencing driver probe failu=
re on constrained systems.
- [Medium] Spurious definition of `vreg_pmu_ch1` (ldo4) for a 1x1 WiFi chip.
- [Low] Incorrect indentation of properties inside the pinctrl node.
--

--- Patch [10]: [PATCH v6 10/11] arm64: dts: qcom: shikra: Enable WiFi/BT o=
n SoMs ---
commit a8e0b18d5ed43960802fc198b1e54e52d1ff11d0
Author: Komal Bajaj <komal.bajaj@oss.qualcomm.com>

arm64: dts: qcom: shikra: Enable WiFi/BT on SoMs
   =20
Shikra SoM cards include WCN3988 WiFi/Bluetooth chip, with supplies
provided by on-card PMICs. Enable both interfaces and provide the
required supply and calibration data.

> diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi b/arch/arm64/bo=
ot/dts/qcom/shikra-cqm-som.dtsi
> index dc3861489f64d..8e30d451ab410 100644
> --- a/arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi
> +++ b/arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi
[ ... ]
> @@ -27,6 +31,42 @@ key-volume-up {
>  			linux,can-disable;
>  		};
>  	};
> +
> +	wcn3988-pmu {
> +		compatible =3D "qcom,wcn3988-pmu";
> +
> +		pinctrl-0 =3D <&sw_ctrl_default>;
> +		pinctrl-names =3D "default";
> +
> +		swctrl-gpios =3D <&tlmm 88 GPIO_ACTIVE_HIGH>;
> +
> +		vddio-supply =3D <&pm4125_l7>;

[Severity: Critical]
Does this correctly assign the voltage rail for the VDDIO supply?
pm4125_l7 appears to be a 664mV LDO, but VDDIO requires 1.8V. This assignme=
nt
could result in severe undervoltage and failure to power the PMU.

> +		vddxo-supply =3D <&pm4125_l13>;
> +		vddrf-supply =3D <&pm4125_l10>;
> +		vddch0-supply =3D <&pm4125_l22>;
> +

[Severity: High]
Does this node also need a vddch1-supply?

Although omitting the vddch1-supply correctly models the 1x1 WCN3988 hardwa=
re,
the qcom,wcn3988-pmu driver hardcodes vddch1 as a strictly required regulat=
or.
Without it, devm_regulator_bulk_get() will fail with -ENODEV on systems with
full constraints enabled, which disables Wi-Fi/Bluetooth initialization ent=
irely.

A dummy regulator supply might be needed here to bypass the driver bug until
it is fixed.

> +		regulators {
[ ... ]
> +			vreg_pmu_ch0: ldo3 {
> +				regulator-name =3D "vreg_pmu_ch0";
> +			};
> +
> +			vreg_pmu_ch1: ldo4 {
> +				regulator-name =3D "vreg_pmu_ch1";
> +			};

[Severity: Medium]
Is it correct to define vreg_pmu_ch1 for this chip?

The WCN3988 is a 1x1 WiFi module and physically lacks a second RF chain.
Exposing a non-existent hardware LDO to the regulator core misrepresents
the hardware capabilities of the PMU.

> +		};
> +	};
>  };
[ ... ]
> +&tlmm {
> +	sw_ctrl_default: sw-ctrl-default-state {
> +	pins =3D "gpio88";
> +	function =3D "gpio";
> +	bias-pull-down;
> +	};
> +};

[Severity: Low]
Are these properties properly indented? Standard device tree formatting req=
uires
properties inside a node to be indented by an additional level relative to =
the
node name.

[ ... ]
> diff --git a/arch/arm64/boot/dts/qcom/shikra-iqs-som.dtsi b/arch/arm64/bo=
ot/dts/qcom/shikra-iqs-som.dtsi
> index 73945bf42112d..62e37409ac8f6 100644
> --- a/arch/arm64/boot/dts/qcom/shikra-iqs-som.dtsi
> +++ b/arch/arm64/boot/dts/qcom/shikra-iqs-som.dtsi
[ ... ]
> +	wcn3988-pmu {
[ ... ]
> +		regulators {
[ ... ]
> +			vreg_pmu_ch0: ldo3 {
> +				regulator-name =3D "vreg_pmu_ch0";
> +			};
> +
> +			vreg_pmu_ch1: ldo4 {
> +				regulator-name =3D "vreg_pmu_ch1";
> +			};

[Severity: Medium]
Is it correct to define vreg_pmu_ch1 here as well? The WCN3988 is a 1x1 WiFi
module, so exposing this non-existent hardware LDO misrepresents the actual
hardware capabilities.

> +		};
> +	};
>  };
[ ... ]
> +&tlmm {
> +	sw_ctrl_default: sw-ctrl-default-state {
> +	pins =3D "gpio88";
> +	function =3D "gpio";
> +	bias-pull-down;
> +	};
> +};

[Severity: Low]
Could we indent these properties by an additional level to follow standard
device tree formatting guidelines?

[ ... ]
> +&wifi {
> +	vdd-0.8-cx-mx-supply =3D <&pm8150_s4>;

[Severity: Critical]
Does this correctly assign the supply for the 0.8V CX/MX digital core?

pm8150_s4 is a 1.08V - 2.04V SMPS. Assigning it here will severely over-volt
the 0.8V rail and risks permanently damaging the Wi-Fi/BT silicon.

> +	vdd-1.8-xo-supply =3D <&vreg_pmu_xo>;
> +	vdd-1.3-rfa-supply =3D <&vreg_pmu_rf>;
> +	vdd-3.3-ch0-supply =3D <&vreg_pmu_ch0>;
> +
> +	qcom,calibration-variant =3D "Shikra_EVK";
> +	firmware-name =3D "shikra";
> +
> +	status =3D "okay";
> +};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-shikra-dt-=
m1-v6-0-bee265d3499b@oss.qualcomm.com?part=3D10

