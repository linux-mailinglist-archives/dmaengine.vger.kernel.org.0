Return-Path: <dmaengine+bounces-12101-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0y4ZON3fTWrA/QEAu9opvQ
	(envelope-from <dmaengine+bounces-12101-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 07:27:57 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B89721C96
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 07:27:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="Jygx6Oe/";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12101-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12101-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABF613013279
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jul 2026 05:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353F93B9952;
	Wed,  8 Jul 2026 05:25:54 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F983B8D7B;
	Wed,  8 Jul 2026 05:25:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783488354; cv=none; b=l8TdQ2c926JTq2cEhGAKP6axdbR7cEkHDiBFtUwRZBSU/sdpNBuI5yTXzm1PhC8fUfInyPLIEmaZM1K3FAWFORHJQB4wekw2e07KVDj47PAjP3F8quBuz4B2e9rs1bgN/9wOrsYr2dkymppnjmOCIbR2Gk2sMvyFl2Vpa2jW5pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783488354; c=relaxed/simple;
	bh=uhKpp79vwvAAllwgsXuNKv44khURsPOZcZOWxtQy5aM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ft3Lv01zTK/Wmi2ZpdCGgv2j710MPSMr/I9LlEqipQX/G4Mge8PEf+aaa6p0xY0nyjIDx5PECAyvkZzh5luOL19RrIApWh198J8fpf22MKqxSaX3A/s/JmsQtizun2/yGOgqEm4hIFljWVQVzpBokGN7c88ZFpmNUe/SMd8+hCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jygx6Oe/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 218351F000E9;
	Wed,  8 Jul 2026 05:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783488352;
	bh=7J5TFW61B6HwhQSF4ot+jdZRWpU5CkA0AKbFNP8Sq8s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Jygx6Oe/oBR+5l1smN78zyxvk8KNlqOLAyW9nytycX16WWC/8msQI8SbkiDw2FA5K
	 K2ntiNj//7JWZpZ4QeEKJAoORWXmcsTh9qCqkKqgnkTshBZp9Tfiab1Yjmkzfqx7Jp
	 0aLGfCVcxDoY6xUJ/UWZ2vsd7PSQ4hUc4X+No323TIvyntz7/K0/3S9CNkqCUchE+q
	 Ibfd4pbKqW1yyFaBICOqBq1PT+Q44l5zhCpXUuXZivxNIOKeK65fPaoxDs/Tp6Y6FA
	 e09lZdr4YS8GoKqu5koXt10IrCCphs8SWM1Vchbj6oilr2N4G6GJGc3zllxYVdRfj1
	 slOID4H3dJndg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/4] soc: qcom: geni-se: Keep pinctrl active for
 multi-owner controllers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mukesh Kumar Savaliya" <mukesh.savaliya@oss.qualcomm.com>
Cc: Frank.Li@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260708051023.2872304-4-mukesh.savaliya@oss.qualcomm.com>
References: <20260708051023.2872304-1-mukesh.savaliya@oss.qualcomm.com>
 <20260708051023.2872304-4-mukesh.savaliya@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 05:25:51 +0000
Message-Id: <20260708052552.218351F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-12101-lists,dmaengine=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mukesh.savaliya@oss.qualcomm.com,m:Frank.Li@kernel.org,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:robh@kernel.org,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lists.linux.dev:replyto,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 44B89721C96

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Missing Initialization / Dead Code
- [High] Incomplete Fix
- [High] Buffer Overflow / API Misuse
--

--- Patch [3]: [PATCH v8 3/4] soc: qcom: geni-se: Keep pinctrl active for m=
ulti-owner controllers ---
commit be30e0e06b9485a4fb9a672b4ecaed4d0dc8ff46
Author: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>

soc: qcom: geni-se: Keep pinctrl active for multi-owner controllers

This patch updates the GENI Serial Engine driver to avoid selecting the
"sleep" pinctrl state when the engine is shared with another processor. It
introduces a multi_owner flag to conditionally skip the pinctrl state change
during shutdown.

> diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni=
-se.c
> index 15636a8dc907a..3441ae3431e6a 100644
> --- a/drivers/soc/qcom/qcom-geni-se.c
> +++ b/drivers/soc/qcom/qcom-geni-se.c
> @@ -607,9 +607,17 @@ int geni_se_resources_off(struct geni_se *se)
>  	if (has_acpi_companion(se->dev))
>  		return 0;
> =20
> -	ret =3D pinctrl_pm_select_sleep_state(se->dev);
> -	if (ret)
> -		return ret;
> +	/*
> +	 * Select the "sleep" pinctrl state only when the serial engine is
> +	 * exclusively owned by this system processor. For shared controller
> +	 * configurations, another system processor may still be using the pins,
> +	 * and switching them to "sleep" can disrupt ongoing transfers.
> +	 */
> +	if (!se->multi_owner) {
> +		ret =3D pinctrl_pm_select_sleep_state(se->dev);
> +		if (ret)
> +			return ret;
> +	}

[Severity: High]
Does this regression also affect geni_se_resources_deactivate()?

Shared I2C and SPI buses use geni_se_resources_deactivate() as their active
power management callback. If a shared I2C or SPI controller initiates runt=
ime
suspend, that function still unconditionally changes the pinctrl state:

drivers/soc/qcom/qcom-geni-se.c:geni_se_resources_deactivate() {
    ...
    ret =3D pinctrl_pm_select_sleep_state(se->dev);
    if (ret)
        return ret;
    ...
}

Could this leave the primary protocol drivers vulnerable to the exact
disruption described in the commit message?

> diff --git a/include/linux/soc/qcom/geni-se.h b/include/linux/soc/qcom/ge=
ni-se.h
> index c5e6ab85df099..9571da2c51a88 100644
> --- a/include/linux/soc/qcom/geni-se.h
> +++ b/include/linux/soc/qcom/geni-se.h
> @@ -66,6 +66,7 @@ struct geni_icc_path {
>   * @icc_paths:		Array of ICC paths for SE
>   * @pd_list:		Power domain list for managing power domains
>   * @has_opp:		Indicates if OPP is supported
> + * @multi_owner:	True if SE is shared between multiple owners.
>   */
>  struct geni_se {
>  	void __iomem *base;
> @@ -78,6 +79,7 @@ struct geni_se {
>  	struct geni_icc_path icc_paths[3];
>  	struct dev_pm_domain_list *pd_list;
>  	bool has_opp;
> +	bool multi_owner;
>  };

[Severity: High]
Does this missing initialization cause a regression where the fix fails to
take effect?

The commit message mentions it is described via DeviceTree with
qcom,qup-multi-owner, but it doesn't appear that of_property_read_bool()
is called anywhere to populate multi_owner.

Without this, will the flag always remain false, preventing the fix from
taking effect for shared controllers?

[Severity: High]
Can this regression cause the driver to queue a truncated or corrupted
transfer chain to the DMA engine under heavy IO traffic?

In drivers/dma/qcom/gpi.c, gpi_prep_slave_sg() statically calculates the
required number of TREs without accounting for lock_action, which can add up
to 2 extra TREs (total 5):

drivers/dma/qcom/gpi.c:gpi_prep_slave_sg() {
    ...
    nr_tre =3D 3;
    set_config =3D *(u32 *)gchan->config;
    if (!set_config)
        nr_tre =3D 2;
    ...
}

If the transfer ring has 3 or 4 slots available, validation passes against =
the
smaller bound. However, when ring space runs out, gpi_queue_xfer() silently
drops the TRE:

drivers/dma/qcom/gpi.c:gpi_queue_xfer() {
    ...
    ret =3D gpi_ring_add_element(&gchan->ch_ring, (void **)&ch_tre);
    if (unlikely(ret)) {
        dev_err(gpii->gpi_dev->dev, "Error adding ring element to xfer ring=
\n");
        return;
    }
    ...
}

Will this cause the caller to submit a truncated chain, leading to hardware
hangs or data corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708051023.2872=
304-1-mukesh.savaliya@oss.qualcomm.com?part=3D3

