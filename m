Return-Path: <dmaengine+bounces-10397-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIAzO0vAA2or+AEAu9opvQ
	(envelope-from <dmaengine+bounces-10397-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 02:05:31 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B89452B7B3
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 02:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E484730086D9
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 00:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068C6B640;
	Wed, 13 May 2026 00:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sKRRdxpK"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80123C2E;
	Wed, 13 May 2026 00:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778630726; cv=none; b=hC7Lx10Z6WmyiFA4SneZLZOVKx+aLXQ/35fJsm4OqUXVct08LBK/3QIM/MPa91DPhe1ZP3LuWQd2/wzm+/TyLhE+vWY3IokyZt7buS5hyLU7mvOjFEHamz+G2skC/f5Uhu0LwBZuLQyud9vAKfZrRfg7hqkjCOzhJC+8/M5WKTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778630726; c=relaxed/simple;
	bh=RZYvMUBsdqb2XFXXfibRFHhK/Al0aA4SFrf3esDhf6U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H3d3wcqYqFR3ICfObWUMMAjCkZywUdDXgxiERFD6C7KNrcOvAbyp6rj+JLeSl+tT2s9IQkV6k1miD5zY7dkz8KEuIPCSgYrj12eQZ9nOqgiQI6384gvSUn3QbeSRnoMGmUewJPepNMX7izkQ4A/4tPUu1V6/neTsB6FwnOKlZYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sKRRdxpK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55647C2BCB0;
	Wed, 13 May 2026 00:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778630726;
	bh=RZYvMUBsdqb2XFXXfibRFHhK/Al0aA4SFrf3esDhf6U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=sKRRdxpK557JEXjoTU1/nT7ZiTx4pS8l0Nk9MoNYsDdpsiUejQILvIrrhJQCi7nkR
	 aZ3gFxV0OToQ76xzoW6nluXiA6QX1vVnGaQJXmUtufRTdZceZaK0Uh9mGjUWhXNcXc
	 IPSF1f3Cnd89e94KjCkvltB5VkQx5ZVukt2elcYiYhYsJyyKe87N1JtIs6kUtpqBen
	 TC5whJvwjGnrqq5G9EfSWg3ACEV0jho05E+K7/fM66rI9MB5z2fulHjjYiBTMpPPA+
	 yv2Vo2yNRh+xSqb/gVvTOz2uj8kSrxtYKAMMajH1a/pt3EJfjMv98wrlj3kTd9uq2t
	 hkIvTyrAT4bFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/23] dmaengine: sdxi: Add PCI initialization
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch via B4 Relay" <devnull+nathan.lynch.amd.com@kernel.org>
Cc: linux-pci@vger.kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260511-sdxi-base-v2-3-889cfed17e3f@amd.com>
References: <20260511-sdxi-base-v2-3-889cfed17e3f@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 00:05:25 +0000
Message-Id: <20260513000526.55647C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 9B89452B7B3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lists.linux.dev:replyto];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10397-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,nathan.lynch.amd.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The Kconfig symbol `CONFIG_SDXI` lacks a dependency on `PCI` or `P=
CI_MSI`, and the Makefile conditionally links `pci.o` using `sdxi-$(CONFIG_=
PCI_MSI) +=3D pci.o`.
- [Low] The return value of `dma_set_mask_and_coherent()` is ignored in `sd=
xi_pci_init()`.
--

commit bdb690a4c497e7a353f0143e03e32ba75daa6013
Author: Nathan Lynch <nathan.lynch@amd.com>

dmaengine: sdxi: Add PCI initialization

This commit adds PCI initialization to bind an SDXI device via the class
code. It maps the control registers and doorbell region, managing resources
with devres and registering the device with the generic SDXI core.

> diff --git a/drivers/dma/sdxi/Makefile b/drivers/dma/sdxi/Makefile
> new file mode 100644
> --- /dev/null
> +++ b/drivers/dma/sdxi/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_SDXI) +=3D sdxi.o
> +
> +sdxi-objs +=3D device.o
> +
> +sdxi-$(CONFIG_PCI_MSI) +=3D pci.o

If CONFIG_SDXI is enabled but CONFIG_PCI_MSI is disabled, pci.o is omitted
from the build. Because pci.c is the only file containing the driver
registration macro (module_pci_driver) and the module license declaration,
would this result in a module that lacks an initialization entry point and
fails to load properly while also tainting the kernel?

[ ... ]

> diff --git a/drivers/dma/sdxi/pci.c b/drivers/dma/sdxi/pci.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/dma/sdxi/pci.c
[ ... ]
> +static int sdxi_pci_init(struct sdxi_dev *sdxi)
> +{
> +	struct pci_dev *pdev =3D sdxi_to_pci_dev(sdxi);
> +	struct device *dev =3D &pdev->dev;
> +	int ret;
> +
> +	ret =3D pcim_enable_device(pdev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to enable device\n");
> +
> +	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));

The return value of dma_set_mask_and_coherent() is ignored here. If the
platform or IOMMU does not support 64-bit DMA, this function returns an err=
or
code and leaves the device's DMA mask at its default 32-bit value.

Is it expected to proceed without handling the fallback or logging a warnin=
g?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511-sdxi-base-=
v2-0-889cfed17e3f@amd.com?part=3D3

