Return-Path: <dmaengine+bounces-10716-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANr+HOTKD2obPwYAu9opvQ
	(envelope-from <dmaengine+bounces-10716-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 05:17:56 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC5B5AE47F
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 05:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ADB1B3001F85
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 03:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80349301704;
	Fri, 22 May 2026 03:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aATU9+4u"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7D61D5AD4;
	Fri, 22 May 2026 03:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779419739; cv=none; b=r16xTYDu7WZ9w4EYU7vQj7IoCPNEVcVBMFMAfoBQn9KvTRzNf9Ffs1wlvaPZ016IwI+lxNlvSa4Mdab4obPGTwBfeeoT2/Um8WSVU6moCvxxbMCe++UL2sMXAbh6M920aIlvEgfQsO4z7FQ3fjTj534TxtVUvtQiZ/Y0xnbFgRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779419739; c=relaxed/simple;
	bh=Ul4JusjoaJajLJ39G9jRNljlot8wg/Md5dKsBv3jbG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPLorS5K63t6jPyn4W1nB5hmYebDouJNjg9CM7+TuUkK0l0yN/cRsnMIxxHR0KjZJJDRsbdUeMmFJ6ReQLxzU0jwK8ZO36zBg+jmA4yk/eUyC7ORGSupxItazFM5M/kUqRYfN+HzRiwmVLrjQ/K5K6tqLZ8qddK2P/OzpAGtWSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aATU9+4u; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 647521F000E9;
	Fri, 22 May 2026 03:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779419737;
	bh=37wOsfXm1sb5JTSv/W5rVSZJMhBW3y9iU2qOAo3vewA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aATU9+4up+wq2h6aGBaA7LDrhlY+H6kgxE2/27f1xauSKN/9lQkEvWqwtOL9mlqb9
	 tdJqJpWHzqfZi1+7ROF4H7TAwCon50F9sqodQNGSKqSp36QGXr/8vJGd7lA/SDfEWY
	 pGZ0IUl9KDouM0SeoKQ8/PRSCDRJ6ZjM8pKO69ljMHCe16E2+y1cWG2iTmQwoczQBV
	 1URZqxRzc4CGjvzaoBCLBerwYCOOA4cF0Zizt8eY9Pid6EKHF4SjiIM4yvKzgu/Qy2
	 G72knLYiwpd/O4JafrdCUucEbPk1mEALfeoGreOVxYGSwK6Zdd6NVS/6UxSmYPYEd0
	 Tr/WDqqsLNPYA==
Date: Thu, 21 May 2026 22:15:33 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: viken.dadhaniya@oss.qualcomm.com, andi.shyti@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org, 
	Frank.Li@kernel.org, konradybcio@kernel.org, dmitry.baryshkov@oss.qualcomm.com, 
	linmq006@gmail.com, quic_jseerapu@quicinc.com, agross@kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, krzysztof.kozlowski@oss.qualcomm.com, 
	bartosz.golaszewski@oss.qualcomm.com, bjorn.andersson@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com
Subject: Re: [PATCH v7 4/4] i2c: qcom-geni: Support multi-owner controllers
 in GPI mode
Message-ID: <ag_Ig7aQNNakiry_@baldur>
References: <20260423145705.545552-1-mukesh.savaliya@oss.qualcomm.com>
 <20260423145705.545552-5-mukesh.savaliya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423145705.545552-5-mukesh.savaliya@oss.qualcomm.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10716-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,kernel.org,gmail.com,quicinc.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andersson@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6BC5B5AE47F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 23, 2026 at 08:25:51PM +0530, Mukesh Kumar Savaliya wrote:
> Some platforms use a QUP-based I2C controller in a configuration where the
> controller is shared with another system processor. In this setup the
> operating system must not assume exclusive ownership of the controller or
> its associated pins.
> 
> Add support for enabling multi-owner operation when DeviceTree specifies
> qcom,qup-multi-owner. When enabled, mark the underlying serial engine as
> shared so the common GENI resource handling avoids selecting the "sleep"
> pinctrl state, which could disrupt transfers initiated by the other
> processor.
> 
> For GPI mode transfers, request lock/unlock TRE sequencing from the GPI

"For GPI mode transfers" is there any other form?

> driver by setting a single lock_action selector per message, emitting lock
> before the first message and unlock after the last message (handling the
> single-message case as well). This serializes access to the shared
> controller without requiring message-position flags to be passed into the
> DMA engine layer.
> 
> Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
> ---
>  drivers/i2c/busses/i2c-qcom-geni.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index ae609bdd2ec4..a396ddc7d8f4 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -815,6 +815,14 @@ static int geni_i2c_gpi_xfer(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[], i
>  		if (i < num - 1)
>  			peripheral.stretch = 1;
>  
> +		peripheral.lock_action = GPI_LOCK_NONE;
> +		if (gi2c->se.multi_owner) {
> +			if (i == 0)
> +				peripheral.lock_action = GPI_LOCK_ACQUIRE;
> +			else if (i == num - 1)
> +				peripheral.lock_action = GPI_LOCK_RELEASE;

You say above that single-messages case is handled, but if num == 1 then
we will hit i == 0, set the acquire, we will not hit else, and then we
will exit the loop. What am I missing?

> +		}
> +
>  		peripheral.addr = msgs[i].addr;
>  		if (i > 0 && (!(msgs[i].flags & I2C_M_RD)))
>  			peripheral.multi_msg = false;
> @@ -1014,6 +1022,11 @@ static int geni_i2c_probe(struct platform_device *pdev)
>  		gi2c->clk_freq_out = I2C_MAX_STANDARD_MODE_FREQ;
>  	}
>  
> +	if (of_property_read_bool(pdev->dev.of_node, "qcom,qup-multi-owner")) {
> +		gi2c->se.multi_owner = true;

gi2c->se.multi_owner = of_property_read_bool(pdev->dev.of_node, "qcom,qup-multi-owner");

> +		dev_dbg(&pdev->dev, "I2C controller is shared with another system processor\n");
> +	}
> +
>  	if (has_acpi_companion(dev))
>  		ACPI_COMPANION_SET(&gi2c->adap.dev, ACPI_COMPANION(dev));
>  
> @@ -1089,7 +1102,9 @@ static int geni_i2c_probe(struct platform_device *pdev)
>  	}
>  
>  	if (fifo_disable) {
> -		/* FIFO is disabled, so we can only use GPI DMA */
> +		/* FIFO is disabled, so we can only use GPI DMA.

That's not how we format comments outside the network subsystem.

Regards,
Bjorn

> +		 * SE can be shared in GSI mode between subsystems, each SS owns a GPII.
> +		 */
>  		gi2c->gpi_mode = true;
>  		ret = setup_gpi_dma(gi2c);
>  		if (ret)
> @@ -1098,6 +1113,11 @@ static int geni_i2c_probe(struct platform_device *pdev)
>  		dev_dbg(dev, "Using GPI DMA mode for I2C\n");
>  	} else {
>  		gi2c->gpi_mode = false;
> +
> +		if (gi2c->se.multi_owner)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "I2C sharing not supported in non GSI mode\n");
> +
>  		tx_depth = geni_se_get_tx_fifo_depth(&gi2c->se);
>  
>  		/* I2C Master Hub Serial Elements doesn't have the HW_PARAM_0 register */
> -- 
> 2.43.0
> 

