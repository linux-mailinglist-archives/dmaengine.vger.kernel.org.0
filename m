Return-Path: <dmaengine+bounces-9037-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCuQFr/PnWn4SAQAu9opvQ
	(envelope-from <dmaengine+bounces-9037-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 17:20:15 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED12F189B35
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 17:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2A6C6304209D
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 16:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F633A7859;
	Tue, 24 Feb 2026 16:20:09 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289643806B8;
	Tue, 24 Feb 2026 16:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771950009; cv=none; b=a/3p31JN+Ln/iVhYClMUdHR3BEsDFxCHW96XzI3tyXtY5LCkp2vrLjg86/BEWyjuipZvFv2s1Y0cqe8joQM+E2YLtk7p5dsjrQ890aFqnxiJG1LiGX7PXqsqORj6ZDEm+02lyVU/bnFW4xDNumuejjzP9warqWLYpTsupDig0IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771950009; c=relaxed/simple;
	bh=6G91BbTqFSYq68w6yhfkl+JDGrXisXHtlEgCseE/wwo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=USqOVO1G8thfgen45iXNVM6Ww1j0fmbiTNzRg5c7dxMz8bF4y4wQ0aLX+j9GyfK2JA3wIrVqkYLQdlrzBkNRCizxSSmBL4mlSz2rAAu5ju1vSO5mAI3PlnyzZd0LFo3AZFrEeaA2khoswtV2yxqdIflZTG4g0REjoy8UHhwRGjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fL2xC01QGzJ46C2;
	Wed, 25 Feb 2026 00:19:43 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id C0C2D40570;
	Wed, 25 Feb 2026 00:20:04 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 24 Feb
 2026 16:20:01 +0000
Date: Tue, 24 Feb 2026 16:20:00 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, "Vaibhaav Ram T . L"
	<vaibhaavram.tl@microchip.com>, Kumaravel Thiagarajan
	<kumaravel.thiagarajan@microchip.com>, Even Xu <even.xu@intel.com>, Xinpeng
 Sun <xinpeng.sun@intel.com>, Srinivas Pandruvada
	<srinivas.pandruvada@linux.intel.com>, Jiri Kosina <jikos@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Zhou Wang
	<wangzhou1@hisilicon.com>, Longfang Liu <liulongfang@huawei.com>, "Vinod
 Koul" <vkoul@kernel.org>, Lee Jones <lee@kernel.org>, Jijie Shao
	<shaojijie@huawei.com>, Jian Shen <shenjian15@huawei.com>, Sunil Goutham
	<sgoutham@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Heiner
 Kallweit" <hkallweit1@gmail.com>, "David S . Miller" <davem@davemloft.net>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>, Oded Gabbay <ogabbay@kernel.org>,
	Maciej Falkowski <maciej.falkowski@linux.intel.com>, Karol Wachowski
	<karol.wachowski@linux.intel.com>, Min Ma <mamin506@gmail.com>, Lizhi Hou
	<lizhi.hou@amd.com>, Andreas Noever <andreas.noever@gmail.com>, "Mika
 Westerberg" <westeri@kernel.org>, Tomasz Jeznach <tjeznach@rivosinc.com>,
	Will Deacon <will@kernel.org>, Xinliang Liu <xinliang.liu@linaro.org>, Tian
 Tao <tiantao6@hisilicon.com>, Davidlohr Bueso <dave@stgolabs.net>, Srujana
 Challa <schalla@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>, Antoine
 Tenart <atenart@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, Raag
 Jadav <raag.jadav@intel.com>, "Hans de Goede" <hansg@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
	<jirislaby@kernel.org>, Andy Shevchenko <andy@kernel.org>, Manivannan
 Sadhasivam <mani@kernel.org>, Mika Westerberg
	<mika.westerberg@linux.intel.com>, Andi Shyti <andi.shyti@kernel.org>, Robert
 Richter <rric@kernel.org>, Mark Brown <broonie@kernel.org>, "Nirmal Patel"
	<nirmal.patel@linux.intel.com>, Kurt Schwemmer
	<kurt.schwemmer@microsemi.com>, Logan Gunthorpe <logang@deltatee.com>, Linus
 Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Sakari
 Ailus <sakari.ailus@linux.intel.com>, Bingbu Cao <bingbu.cao@intel.com>, Ulf
 Hansson <ulf.hansson@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Benjamin
 Tissoires <bentiss@kernel.org>, <linux-input@vger.kernel.org>,
	<linux-i3c@lists.infradead.org>, <dmaengine@vger.kernel.org>, Philipp Stanner
	<phasta@kernel.org>, <netdev@vger.kernel.org>, <nic_swsd@realtek.com>,
	<linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
	<linux-usb@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-riscv@lists.infradead.org>, David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, <linux-cxl@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
	<linux-serial@vger.kernel.org>, <mhi@lists.linux.dev>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Jan Dabros <jsd@semihalf.com>,
	<linux-i2c@vger.kernel.org>, Daniel Mack <daniel@zonque.org>, "Haojian
 Zhuang" <haojian.zhuang@gmail.com>, <linux-spi@vger.kernel.org>, "Jonathan
 Derrick" <jonathan.derrick@linux.dev>, <linux-pci@vger.kernel.org>,
	<linux-gpio@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	<linux-media@vger.kernel.org>, <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH 01/37] PCI/MSI: Add Devres managed IRQ vectors
 allocation
Message-ID: <20260224162000.000001a5@huawei.com>
In-Reply-To: <1771860581-82092-2-git-send-email-shawn.lin@rock-chips.com>
References: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
	<1771860581-82092-2-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml500005.china.huawei.com (7.214.145.207)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,microchip.com,intel.com,linux.intel.com,kernel.org,bootlin.com,hisilicon.com,huawei.com,marvell.com,lunn.ch,gmail.com,davemloft.net,oss.qualcomm.com,amd.com,rivosinc.com,linaro.org,stgolabs.net,gondor.apana.org.au,linuxfoundation.org,microsemi.com,deltatee.com,arndb.de,vger.kernel.org,lists.infradead.org,realtek.com,lists.freedesktop.org,lists.linux.dev,ffwll.ch,semihalf.com,zonque.org,linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9037-lists,dmaengine=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,netdev];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathan.cameron@huawei.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[86];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.953];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,huawei.com:mid]
X-Rspamd-Queue-Id: ED12F189B35
X-Rspamd-Action: no action

On Mon, 23 Feb 2026 23:29:40 +0800
Shawn Lin <shawn.lin@rock-chips.com> wrote:

> pcim_alloc_irq_vectors() and pcim_alloc_irq_vectors_affinity() are created for
> pci device drivers which rely on the devres machinery to help cleanup the IRQ
> vectors.

It might be worth adding some details on why we need the is_msi_managed
flag in the first place vs just doing conventional devm_add_action_or_reset()
with pci_free_irq_vectors().



