Return-Path: <dmaengine+bounces-12160-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6TGvILw0T2pfcAIAu9opvQ
	(envelope-from <dmaengine+bounces-12160-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 07:42:20 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F7D72CD1A
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 07:42:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=PMF7MIfe;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12160-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12160-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EC00303D4D2
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 05:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0113AA182;
	Thu,  9 Jul 2026 05:41:18 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C533A7858;
	Thu,  9 Jul 2026 05:41:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783575678; cv=none; b=USzP2bWOrV6Kedt+mLsJj8wG34JRjSjOIgYDANDZTheb5phvB2WaZAouVC5KPfSmejB4HEhx6hl9h414ryXUoK1tQuRR3iRelgxQe8Sv4W7NbhQ3tocqXuW1BWd3WdC8N8WvWbKQHOlAPIz3W5dGtNVwiEqkISKTUegRyC44cWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783575678; c=relaxed/simple;
	bh=vd/pKHnN9hHEq/PC2ZKa5Ks5FAZG9ipiDZlCtIFKHWA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Sz+AMAyFvMaIp2ihH/XHgskQbhUvphToTAOUip8OSlcT4ZwgVSYZ5RLdHGSqaLSFcCyqY7FP5CNKrq2Aj+R26BW153pLHwRNBXYsN+kGhdIV3R2va4LrL5luOzrWzq8KJpv4vo2BDoV3P7SdYpn9LodkJ10feZ+KCBIncmmCP5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMF7MIfe; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EAE21F000E9;
	Thu,  9 Jul 2026 05:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783575677;
	bh=GUR46VabSVZbPyehLw4syLT30MNmMe+mudnTx0VnTpA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=PMF7MIfeOb6sPplAJM3ptwtGVrsjDjcmNM8+KBGIZapvBcxEoEW05Z71w8wT7OiCo
	 DpyTqd8LBQSOVV2LXf12bv3I6Pc0h9ojZxvVDoieC+rI/KlduqQsbmNYRbApokpMUS
	 906x2f5dfccmHGNLaQwrgeNkFJeM+vrwSPjhiXoBgGmr7P/GzXUVoT8b+iN+kTpuYZ
	 3miqhB4alxgUPujwFkL9mVwHxHABNpvGLd+MKygFosR17bCiXd9AFhTno3Tpzpr8G2
	 W04sec2rt03zdANmLtdpyqOtx7Xh3Wl/PfkGMSLLD5Y/7X7CmPps6HOirGFsnoRUm/
	 YRXFW3BE6RuOQ==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 "Vaibhaav Ram T . L" <vaibhaavram.tl@microchip.com>, 
 Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>, 
 Even Xu <even.xu@intel.com>, Xinpeng Sun <xinpeng.sun@intel.com>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 Jiri Kosina <jikos@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Zhou Wang <wangzhou1@hisilicon.com>, Longfang Liu <liulongfang@huawei.com>, 
 Vinod Koul <vkoul@kernel.org>, Lee Jones <lee@kernel.org>, 
 Jijie Shao <shaojijie@huawei.com>, Jian Shen <shenjian15@huawei.com>, 
 Sunil Goutham <sgoutham@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>, Oded Gabbay <ogabbay@kernel.org>, 
 Maciej Falkowski <maciej.falkowski@linux.intel.com>, 
 Karol Wachowski <karol.wachowski@linux.intel.com>, 
 Min Ma <mamin506@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>, 
 Andreas Noever <andreas.noever@gmail.com>, 
 Mika Westerberg <westeri@kernel.org>, Will Deacon <will@kernel.org>, 
 Xinliang Liu <xinliang.liu@linaro.org>, Tian Tao <tiantao6@hisilicon.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, Srujana Challa <schalla@marvell.com>, 
 Bharat Bhushan <bbhushan2@marvell.com>, Antoine Tenart <atenart@kernel.org>, 
 Herbert Xu <herbert@gondor.apana.org.au>, Raag Jadav <raag.jadav@intel.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Andi Shyti <andi.shyti@kernel.org>, Robert Richter <rric@kernel.org>, 
 Mark Brown <broonie@kernel.org>, 
 Nirmal Patel <nirmal.patel@linux.intel.com>, 
 Kurt Schwemmer <kurt.schwemmer@microsemi.com>, 
 Logan Gunthorpe <logang@deltatee.com>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Bingbu Cao <bingbu.cao@intel.com>, 
 Tomasz Jeznach <tomasz.jeznach@linux.dev>, 
 Jonathan Cameron <jic23@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
 Shawn Lin <shawn.lin@rock-chips.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Benjamin Tissoires <bentiss@kernel.org>, 
 linux-input@vger.kernel.org, linux-i3c@lists.infradead.org, 
 dmaengine@vger.kernel.org, Philipp Stanner <phasta@kernel.org>, 
 netdev@vger.kernel.org, nic_swsd@realtek.com, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org, 
 iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 linux-cxl@vger.kernel.org, linux-crypto@vger.kernel.org, 
 platform-driver-x86@vger.kernel.org, linux-serial@vger.kernel.org, 
 mhi@lists.linux.dev, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Jan Dabros <jsd@semihalf.com>, linux-i2c@vger.kernel.org, 
 Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, 
 linux-spi@vger.kernel.org, Jonathan Derrick <jonathan.derrick@linux.dev>, 
 linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
 linux-mmc@vger.kernel.org
In-Reply-To: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
References: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
Subject: Re: (subset) [PATCH 0/37] PCI/MSI: Enforce explicit IRQ vector
 management by removing devres auto-free
Message-Id: <178357565325.731734.7291964273199898845.b4-ty@b4>
Date: Thu, 09 Jul 2026 07:40:53 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bhelgaas@google.com,m:vaibhaavram.tl@microchip.com,m:kumaravel.thiagarajan@microchip.com,m:even.xu@intel.com,m:xinpeng.sun@intel.com,m:srinivas.pandruvada@linux.intel.com,m:jikos@kernel.org,m:alexandre.belloni@bootlin.com,m:wangzhou1@hisilicon.com,m:liulongfang@huawei.com,m:vkoul@kernel.org,m:lee@kernel.org,m:shaojijie@huawei.com,m:shenjian15@huawei.com,m:sgoutham@marvell.com,m:andrew+netdev@lunn.ch,m:hkallweit1@gmail.com,m:davem@davemloft.net,m:jeff.hugo@oss.qualcomm.com,m:ogabbay@kernel.org,m:maciej.falkowski@linux.intel.com,m:karol.wachowski@linux.intel.com,m:mamin506@gmail.com,m:lizhi.hou@amd.com,m:andreas.noever@gmail.com,m:westeri@kernel.org,m:will@kernel.org,m:xinliang.liu@linaro.org,m:tiantao6@hisilicon.com,m:dave@stgolabs.net,m:schalla@marvell.com,m:bbhushan2@marvell.com,m:atenart@kernel.org,m:herbert@gondor.apana.org.au,m:raag.jadav@intel.com,m:hansg@kernel.org,m:gregkh@linuxfoundation.org,m:jirislaby@kernel.org,m:andy@kernel.org,m:mika.westerberg
 @linux.intel.com,m:andi.shyti@kernel.org,m:rric@kernel.org,m:broonie@kernel.org,m:nirmal.patel@linux.intel.com,m:kurt.schwemmer@microsemi.com,m:logang@deltatee.com,m:linusw@kernel.org,m:brgl@kernel.org,m:sakari.ailus@linux.intel.com,m:bingbu.cao@intel.com,m:tomasz.jeznach@linux.dev,m:jic23@kernel.org,m:ulfh@kernel.org,m:shawn.lin@rock-chips.com,m:arnd@arndb.de,m:bentiss@kernel.org,m:linux-input@vger.kernel.org,m:linux-i3c@lists.infradead.org,m:dmaengine@vger.kernel.org,m:phasta@kernel.org,m:netdev@vger.kernel.org,m:nic_swsd@realtek.com,m:linux-arm-msm@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-usb@vger.kernel.org,m:iommu@lists.linux.dev,m:linux-riscv@lists.infradead.org,m:airlied@gmail.com,m:simona@ffwll.ch,m:linux-cxl@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:platform-driver-x86@vger.kernel.org,m:linux-serial@vger.kernel.org,m:mhi@lists.linux.dev,m:andriy.shevchenko@linux.intel.com,m:jsd@semihalf.com,m:linux-i2c@vger.kernel.org,m:daniel@zonque.org,m:haojian.zh
 uang@gmail.com,m:linux-spi@vger.kernel.org,m:jonathan.derrick@linux.dev,m:linux-pci@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:mchehab@kernel.org,m:linux-media@vger.kernel.org,m:linux-mmc@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[google.com,microchip.com,intel.com,linux.intel.com,kernel.org,bootlin.com,hisilicon.com,huawei.com,marvell.com,lunn.ch,gmail.com,davemloft.net,oss.qualcomm.com,amd.com,linaro.org,stgolabs.net,gondor.apana.org.au,linuxfoundation.org,microsemi.com,deltatee.com,linux.dev,rock-chips.com];
	TAGGED_FROM(0.00)[bounces-12160-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mani@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_GT_50(0.00)[86];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mani@kernel.org,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[arndb.de,kernel.org,vger.kernel.org,lists.infradead.org,realtek.com,lists.freedesktop.org,lists.linux.dev,gmail.com,ffwll.ch,linux.intel.com,semihalf.com,zonque.org,linux.dev];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D2F7D72CD1A


On Mon, 23 Feb 2026 23:29:39 +0800, Shawn Lin wrote:
> This patch series addresses a long-standing design issue in the PCI/MSI
> subsystem where the implicit, automatic management of IRQ vectors by
> the devres framework conflicts with explicit driver cleanup, creating
> ambiguity and potential resource management bugs.
> 
> ==== The Problem: Implicit vs. Explicit Management ====
> Historically, `pcim_enable_device()` not only manages standard PCI resources
> (BARs) via devres but also implicitly triggers automatic IRQ vector management
> by setting a flag that registers `pcim_msi_release()` as a cleanup action.
> 
> [...]

Applied, thanks!

[13/37] bus: mhi: host: Replace pci_alloc_irq_vectors() with pcim_alloc_irq_vectors()
        commit: 256995e80fcd39cab94eee8135dd90f6da6ac744

Best regards,
-- 
மணிவண்ணன் சதாசிவம்



