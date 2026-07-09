Return-Path: <dmaengine+bounces-12223-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ebcMI720T2o0nAIAu9opvQ
	(envelope-from <dmaengine+bounces-12223-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:48:29 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C88AC732746
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:48:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=V9oGqgr6;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12223-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12223-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6855030BCDAF
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 14:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5886331A44;
	Thu,  9 Jul 2026 14:27:55 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B811AA780
	for <dmaengine@vger.kernel.org>; Thu,  9 Jul 2026 14:27:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783607275; cv=none; b=pCeRL0hREzZfzBryZ0ZLghqAeC7Q+gBdlWflFuDfkz0uDUxFitZKEMLc14W48okkwaXONnysvxd3k1Rxj9hW6LN/JUMkXQe/V//SNYfuyIwZ1WUXhpPOVlwa0kscoqUx1gM1h7bVwIZiLeBSeFJBHr2VqT7FbYx+OpnOGshSgq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783607275; c=relaxed/simple;
	bh=Qjp6jFj4no2AQ+XhjzeCBwtPfa8kQ/RIP/hh3hJyolE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AbCBzU/+R387g4oQH9OIg5UVevwh6S9W0LEuWEe0CBZenwK+b+gte9uD18DSPtxvJChM2yqyPLtSc0cLWyl9Oe3O9JnGy6JEDxwvJwY2YNw9B0M73lXkustpJsahkVfCEOa8CDHXvFwcY+rw2L40aX1fkp2HG2bFni9yMDC867w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9oGqgr6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E92F1F000E9;
	Thu,  9 Jul 2026 14:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783607274;
	bh=0cXaE/c69MQ6IxbwugUvSUiMm8K0oBvdQ7AQhHBxFmo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V9oGqgr6TwZnalY0ugRDtG+WHq8rJrsLYsAZ/FhnidPuoXNdCFNG4CGZZ4Xiggk6i
	 HYd1F0KQsmMarZJrIwM/cD5rWrJGHtsGvN+bOvBkopCq3hIIPgvOI6aW8wiQ4902L1
	 LKvSqnQ7RLKjtd7wdBXzBdNQG7c0UOy+RUTF6p4m6BAAfR3l3pZ6ccEwct95/RNBAl
	 LAZWWCR9tCztVtNXsko70nebOW530As3VVaagPLXnFkRxj9mVqrBVYy1GPWTNg66cs
	 iZGh6wBoYqJx94C+NHRxvNbbRCg0GeDJ3auPzjarlQ98x8qf4IfnQGT1vFi85C3aAB
	 Wu0PNeVmE+fIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 16/26] dmaengine: sprd-dma: Remove redundant
 dev_err()/dev_err_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pan Chuang" <panchuang@vivo.com>
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260709135846.97972-17-panchuang@vivo.com>
References: <20260709135846.97972-1-panchuang@vivo.com>
 <20260709135846.97972-17-panchuang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 14:27:53 +0000
Message-Id: <20260709142754.0E92F1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-12223-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:panchuang@vivo.com,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sashiko.dev:url,vger.kernel.org:from_smtp,vivo.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C88AC732746

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incorrect Optional Resource Handling / Ignored Probe Deferral
- [High] Premature IRQ Request Causes Potential NULL Pointer Dereference
- [High] Missing Tasklet Cleanup on Probe Failure Leads to Use-After-Free
--

--- Patch [16]: [PATCH 16/26] dmaengine: sprd-dma: Remove redundant dev_err=
()/dev_err_probe() ---
commit e390b8344f4bfbd854daa3d432e12e9099d1828c
Author: Pan Chuang <panchuang@vivo.com>

dmaengine: sprd-dma: Remove redundant dev_err()/dev_err_probe()

The devm_request_irq() now automatically logs detailed error messages on
failure. This eliminates the need for driver-specific dev_err() and
dev_err_probe() calls that previously printed generic messages.

> diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
> index 087fea3af2e41..dbf52ff88b47e 100644
> --- a/drivers/dma/sprd-dma.c
> +++ b/drivers/dma/sprd-dma.c
> @@ -1162,10 +1162,8 @@ static int sprd_dma_probe(struct platform_device *=
pdev)
>  	if (sdev->irq > 0) {

[Severity: High]
This is a pre-existing issue, but does this correctly handle probe deferral?

If platform_get_irq() returns -EPROBE_DEFER, the check if (sdev->irq > 0)=20
ignores it and the driver will start without its IRQ.=20

A similar issue exists earlier in this function with the ashb_eb clock:

	sdev->ashb_clk =3D devm_clk_get(&pdev->dev, "ashb_eb");
	if (IS_ERR(sdev->ashb_clk))
		dev_warn(&pdev->dev, "no optional ashb eb clock\n");

If devm_clk_get() returns -EPROBE_DEFER, the driver merely prints a warning
and continues. If the hardware actually requires this clock, accessing the=
=20
DMA registers unclocked could cause a bus error and freeze the system.

Should this code use devm_clk_get_optional() and platform_get_irq_optional(=
),
and explicitly propagate errors like -EPROBE_DEFER?

>  		ret =3D devm_request_irq(&pdev->dev, sdev->irq, dma_irq_handle,
>  				       0, "sprd_dma", (void *)sdev);

[Severity: High]
This is a pre-existing issue, but can this early IRQ request cause a NULL
pointer dereference?

The interrupt is requested and enabled here, but sdev->glb_base is mapped=20
afterwards:

	sdev->glb_base =3D devm_platform_ioremap_resource(pdev, 0);

If the IRQ line is already active (e.g., from the bootloader or kexec),
dma_irq_handle() will trigger immediately and try to read from glb_base:

	struct sprd_dma_dev *sdev =3D (struct sprd_dma_dev *)dev_id;
	u32 irq_status =3D readl(sdev->glb_base + SPRD_DMA_GLB_INT_MSK_STS);

Since sdev->glb_base hasn't been mapped yet, this will dereference a NULL
pointer. Should the IRQ request be deferred until all hardware mappings and
internal channel structures are fully initialized?

> -		if (ret < 0) {
> -			dev_err(&pdev->dev, "request dma irq failed\n");
> +		if (ret < 0)
>  			return ret;
> -		}
>  	} else {
>  		dev_warn(&pdev->dev, "no interrupts for the dma controller\n");
>  	}

[Severity: High]
This is a pre-existing issue, but does the probe error path leak scheduled
tasklets leading to a use-after-free?

During vchan_init(), tasklets are set up for each channel. If a late probe=
=20
step fails (like of_dma_controller_register()), the error path handles
cleanup:

err_of_register:
	dma_async_device_unregister(&sdev->dma_dev);
err_register:
	pm_runtime_put_noidle(&pdev->dev);
	pm_runtime_disable(&pdev->dev);
err_rpm:
	sprd_dma_disable(sdev);
	return ret;

However, this doesn't call tasklet_kill() for the channels. If an interrupt=
=20
fired or a channel was used, the tasklet remains scheduled. When devres=20
subsequently frees the sdev memory, the scheduled tasklet will execute and
access freed memory, causing a panic.=20

Should the error rollback path manually call tasklet_kill() for all=20
initialized channels?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709135846.9797=
2-1-panchuang@vivo.com?part=3D16

