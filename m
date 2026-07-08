Return-Path: <dmaengine+bounces-12100-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4R3mDb3eTWqB/QEAu9opvQ
	(envelope-from <dmaengine+bounces-12100-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 07:23:09 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 975F7721C3A
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 07:23:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZnuORjaF;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12100-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-12100-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 969EF3018421
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jul 2026 05:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5838435E1AF;
	Wed,  8 Jul 2026 05:23:05 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B089282F22;
	Wed,  8 Jul 2026 05:23:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783488185; cv=none; b=nhf/ED4JKKRvdqHV3VXguMLHFhGfoomMfdkTyDoZFxc+/0QZcEjCExOAfUGuVwAyWC5Iq12MfvVvQZ4+5PqCwWTvFlYx17YNKd0V7HQVfCpWPyyIoHPttBQTEsUx/V0LegeYJCZHEpZ0PqYz6K5GHJEMkSmLWzInV+9PLto4FmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783488185; c=relaxed/simple;
	bh=uWr4qEWzGVb8gqjrdAuwMCSGiIEOoj9zTwHhMqywj58=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XZx4eCzY3xlDOf+ZuTCyh63votPzApiZJkU1cpW9olBEKHezzExBBmTafvHp3K37xU1HyXESfG23osLXCH+qW5M8JhS6+7NiE8e53ILApWBGD5YM3PdenoUvI3kS9m7n1apZ7p/NipYsjWMlI6jgh15AN2+MbaSRV98SD6xYjGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZnuORjaF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390171F000E9;
	Wed,  8 Jul 2026 05:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783488183;
	bh=4yVfV6uRKfI993/v4mltqnVvDznqKeLz8sXQcNlqxPw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZnuORjaFrK9HMz3snFY5WECKJIHPYrC5mRpyupu0bGXhYvCSrreww9in/dEU5UU4C
	 caloiWCrZhgou+vxFnvo8FGwipD1B82JzxbuZ6a/WQ1++3oGL31sLZWhwHnugTlGIP
	 Q0l6eh8l0Ptz5GT+WYpycmILupLJB1d2L8GMl/PPxRqESpVj5zKPn/uWVZ/LxCVQFt
	 lcxNJwedZ/28acKGVKPOeyo5V2xcdvdLzNQs9N34w7G9HNe9XhURSnV48WOlQDDPjR
	 kA7WmhVGgKQs3xmLxmrzp+2SFPD7Kw4xOe9eJJXS8a2e+UCilb3Y/pLjcraYeHWbNL
	 dzs9Ipvmamvcw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/4] i2c: qcom-geni: Support multi-owner controllers
 in GPI mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mukesh Kumar Savaliya" <mukesh.savaliya@oss.qualcomm.com>
Cc: Frank.Li@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260708051023.2872304-5-mukesh.savaliya@oss.qualcomm.com>
References: <20260708051023.2872304-1-mukesh.savaliya@oss.qualcomm.com>
 <20260708051023.2872304-5-mukesh.savaliya@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 05:23:02 +0000
Message-Id: <20260708052303.390171F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-12100-lists,dmaengine=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mukesh.savaliya@oss.qualcomm.com,m:Frank.Li@kernel.org,m:robh@kernel.org,m:devicetree@vger.kernel.org,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:conor+dt@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:email,smtp.kernel.org:mid,lists.linux.dev:replyto,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 975F7721C3A

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Single-message transfers on a multi-owner controller acquire the h=
ardware lock but never release it, deadlocking the shared controller.
- [High] Extraneous lock command TRE is emitted on the RX DMA channel for r=
ead transfers, violating hardware protocol.
- [Medium] PM runtime usage counter is leaked when rejecting multi-owner co=
nfigurations in non-GPI mode.
- [Low] Usage of `of_property_read_bool()` ignores ACPI configurations for =
multi-owner support.
--

--- Patch [4]: [PATCH v8 4/4] i2c: qcom-geni: Support multi-owner controlle=
rs in GPI mode ---
commit 6f8199761192397d64a43320106d79fa18ae0f1f
Author: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>

i2c: qcom-geni: Support multi-owner controllers in GPI mode

This commit introduces support for sharing a QUP-based I2C controller with
another system processor. It enables multi-owner operation using the
qcom,qup-multi-owner property and serializes GPI mode transfers using
hardware lock/unlock commands.

> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-=
qcom-geni.c
> index 96dbf04138bee..757c2c8eb2071 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -832,6 +832,14 @@ static int geni_i2c_gpi_xfer(struct geni_i2c_dev *gi=
2c, struct i2c_msg msgs[], i
>  		if (i < num - 1)
>  			peripheral.stretch =3D 1;
> =20
> +		peripheral.lock_action =3D GPI_LOCK_NONE;
> +		if (gi2c->se.multi_owner) {
> +			if (i =3D=3D 0)
> +				peripheral.lock_action =3D GPI_LOCK_ACQUIRE;
> +			else if (i =3D=3D num - 1)
> +				peripheral.lock_action =3D GPI_LOCK_RELEASE;
> +		}
> +

[Severity: High]
Does this code deadlock the shared controller for single-message transfers?

If num =3D=3D 1, i =3D=3D 0 evaluates to true and peripheral.lock_action is=
 set
to GPI_LOCK_ACQUIRE. The else if (i =3D=3D num - 1) branch is skipped entir=
ely,
meaning GPI_LOCK_RELEASE is never requested. Since lock_action is a single=
=20
enum value, it doesn't appear possible to emit both lock and unlock commands
for a single message this way.

[Severity: High]
Can this cause an extraneous lock command TRE to be emitted on the RX DMA
channel?

Because config.peripheral_config points to peripheral, the lock_action is
passed to the TX channel when calling geni_i2c_gpi() for I2C_WRITE. However,
if this is a read transfer (msgs[i].flags & I2C_M_RD), the same config
structure is immediately reused to configure the RX channel.=20

Because peripheral.lock_action is not cleared back to GPI_LOCK_NONE, the RX
channel will also receive a GPI_LOCK_ACQUIRE command TRE, which could viola=
te
the hardware protocol expecting command TREs only on the TX channel.

>  		peripheral.addr =3D msgs[i].addr;
>  		if (i > 0 && (!(msgs[i].flags & I2C_M_RD)))
>  			peripheral.multi_msg =3D false;

[ ... ]

> @@ -1028,6 +1040,11 @@ static int geni_i2c_init(struct geni_i2c_dev *gi2c)
>  		dev_dbg(gi2c->se.dev, "Using GPI DMA mode for I2C\n");
>  	} else {
>  		gi2c->gpi_mode =3D false;
> +
> +		if (gi2c->se.multi_owner)
> +			return dev_err_probe(gi2c->se.dev, -EINVAL,
> +					     "I2C sharing not supported in non GSI mode\n");
> +

[Severity: Medium]
Does this direct return leak the PM runtime usage counter?

At the beginning of geni_i2c_init(), pm_runtime_resume_and_get() is called.=
=20
By returning directly here instead of using the goto err; cleanup path,=20
the driver bypasses pm_runtime_put(), leaving the device power domain activ=
e.

>  		tx_depth =3D geni_se_get_tx_fifo_depth(&gi2c->se);
> =20
>  		/* I2C Master Hub Serial Elements doesn't have the HW_PARAM_0 register=
 */

[ ... ]

> @@ -1098,6 +1115,11 @@ static int geni_i2c_probe(struct platform_device *=
pdev)
>  		gi2c->clk_freq_out =3D I2C_MAX_STANDARD_MODE_FREQ;
>  	}
> =20
> +	if (of_property_read_bool(pdev->dev.of_node, "qcom,qup-multi-owner")) {
> +		gi2c->se.multi_owner =3D true;
> +		dev_dbg(&pdev->dev, "I2C controller is shared with another system proc=
essor\n");
> +	}
> +

[Severity: Low]
Does this hardcode the multi-owner feature strictly to DeviceTree?

The driver supports ACPI companions (checked right below this via
has_acpi_companion(dev)). Using of_property_read_bool() ignores ACPI
platforms. Could this use device_property_read_bool(dev, "qcom,qup-multi-ow=
ner")
to uniformly support both ACPI _DSD and DeviceTree?

>  	if (has_acpi_companion(dev))
>  		ACPI_COMPANION_SET(&gi2c->adap.dev, ACPI_COMPANION(dev));
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708051023.2872=
304-1-mukesh.savaliya@oss.qualcomm.com?part=3D4

