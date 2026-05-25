Return-Path: <dmaengine+bounces-10824-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMxLBxnvE2qmHgcAu9opvQ
	(envelope-from <dmaengine+bounces-10824-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 08:41:29 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDC35C6A2D
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 08:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8024A30036C4
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 06:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D0F72627;
	Mon, 25 May 2026 06:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYfCYHXG"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FBD313532
	for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 06:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779691285; cv=none; b=Y2+8VZYZLKpkMrp0XWdn+PsyutWpXS2gLFezPqsTWAedrH9EG8lqMT5oomUzTaHqdrluZJZBTDQ84kbH2B+7Vx/CD+gqHv3PmYBrrL/Oq1vy1q8tkFkyY12+aClwhQi9Z1rlDKeQpGvk2iI9/HDO8j/CEh69NSEre0LxgzktPrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779691285; c=relaxed/simple;
	bh=/Nw7ZZoyii+UkOPXmDVdSPd/N7H0kX+qtJv/KF84WSo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LMhviPAy12v4PDJ0Ug4Ecb6OCKplv4MHkBKcJFf/sCPowo/Hoqb3274ZEuc4G5NnUZVLu8SCTZB9gQcF8KTHdOI15YOZJcw939wx/lgPpdciv0FEFFzJP8Qn5jywKx69lX7zPYgfNVFnwvkNNPaH/Rx6g1c6Q+mVUWnvapt2HJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYfCYHXG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB791F000E9;
	Mon, 25 May 2026 06:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779691283;
	bh=bbiPZIgR7NsTxfdu/ADew75aB/SURqDf/Lt03JDCZsQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JYfCYHXGaRD9iNic2+1UOR/Gg0e+tSKhoNLi7dqkx7A/KOzMDriVCX5sU4TxZbGPs
	 O9GoBslq7q6LbFqP264oohWQ1ixRTjDsp8/W6+SN6UYRTmV2NxlmzPsbRYa2cGQrwU
	 cbzNZJgX+KiuYzGO7EDWppWK6QA5fiNRqQSxoYWbZwMlAixbBfNgckEqQrvoudbQO6
	 /0EACypziLq3pf6TWqfiLR0+K/68ysAfFpA7cXpqJfPKvTGpcuTWogKbz40+NYT50v
	 1hEZA0fbrBmi0ramIuHr11C78fXa8ACMRkxl85xf4aGn9NZ4yFT5Tqi2HCGvmMldMH
	 M6dPjlXCtgQ3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/12] dmaengine: dw-edma-pcie: Add default IRQ mode
 to match data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: Frank.Li@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260525062420.3315904-8-den@valinux.co.jp>
References: <20260525062420.3315904-8-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 06:41:22 +0000
Message-Id: <20260525064123.4FB791F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10824-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,valinux.co.jp:email,lists.linux.dev:replyto,sashiko.dev:url]
X-Rspamd-Queue-Id: 7BDC35C6A2D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver unconditionally dereferences `match` (derived from `pid=
->driver_data`) without validating it against NULL. If the driver is dynami=
cally bound to a device via the sysfs `new_id` interface without providing =
driver_data, `match` will be NULL, causing an immediate kernel panic.
--

commit 79fb581a9917122a98d59cda2fcb9dd96f6df078
Author: Koichiro Den <den@valinux.co.jp>

dmaengine: dw-edma-pcie: Add default IRQ mode to match data

Stores the default per-channel interrupt routing mode in the
dw-edma-pcie match data and copies it into dw_edma_chip during probe.

> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-=
edma-pcie.c
> index c7362f1bf80cc..9aed1005854dc 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
[ ... ]
> @@ -432,6 +433,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	chip->dev =3D dev;
> =20
>  	chip->mf =3D dma_data->mf;
> +	chip->default_irq_mode =3D match->default_irq_mode;

[Severity: High]
This is a pre-existing issue, but I noticed that this patch adds another
dereference of match without validating it against NULL first.

If the driver is dynamically bound to a device via the sysfs new_id interfa=
ce
(e.g., echo "<vendor> <device>" > /sys/bus/pci/drivers/dw-edma-pcie/new_id),
the PCI core initializes the new pci_device_id with driver_data defaulting
to 0 (NULL). Since match is derived from pid->driver_data, match will be
NULL in this scenario.

Can this cause an immediate kernel panic when match->default_irq_mode
(and match->data earlier in the probe function) is evaluated?

>  	chip->nr_irqs =3D nr_irqs;
>  	chip->ops =3D &dw_edma_pcie_plat_ops;
>  	chip->cfg_non_ll =3D dma_data->cfg_non_ll;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525062420.3315=
904-1-den@valinux.co.jp?part=3D7

