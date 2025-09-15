Return-Path: <dmaengine+bounces-6516-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 314A1B58016
	for <lists+dmaengine@lfdr.de>; Mon, 15 Sep 2025 17:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F25693B832D
	for <lists+dmaengine@lfdr.de>; Mon, 15 Sep 2025 15:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FA9342C93;
	Mon, 15 Sep 2025 15:09:04 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC9033EB15;
	Mon, 15 Sep 2025 15:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757948943; cv=none; b=QIWCXJwLkDXI0ioOsewAk4ulTJX2rA4xR5mtgklPw96Ps4JpFT4NQDYiB7JFeDqBivPaoS3TLFAdMheNPYUuKMcyIZ1wiwCqQxyFqTdQCNhQ8fW4OGnFm6NgCiBr6Qr5xSyXitwHR9eVNiwP+8+j724CGGWBGxy5I6b9v1Ky3SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757948943; c=relaxed/simple;
	bh=2TS+njpHoWqfcXvZ/AG4mUlZy2MsCcBbzK85MJoZSWM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uexC6aVGHhPsOZ2AnPD3KM+wY6t2RdDbWyd5zs0sansc6OsH7ENDXTxNjaKONLiR0uY3y2Fa0+I26Qaq1JSJTPSahO+ImGVyMdI1lP9vlmhRuzinuMd22Ed7C8ryShSBtMBkeaKjaB2pqwE6/Q3MeuLNInLyYRViEFFQ34/tXdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cQT0g0Yt0z6GD5y;
	Mon, 15 Sep 2025 23:07:31 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 8D7481400DC;
	Mon, 15 Sep 2025 23:08:58 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 15 Sep
 2025 17:08:58 +0200
Date: Mon, 15 Sep 2025 16:08:56 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
CC: <nathan.lynch@amd.com>, Vinod Koul <vkoul@kernel.org>, Wei Huang
	<wei.huang2@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>
Subject: Re: [PATCH RFC 12/13] dmaengine: sdxi: Add Kconfig and Makefile
Message-ID: <20250915160856.000005bc@huawei.com>
In-Reply-To: <20250905-sdxi-base-v1-12-d0341a1292ba@amd.com>
References: <20250905-sdxi-base-v1-0-d0341a1292ba@amd.com>
	<20250905-sdxi-base-v1-12-d0341a1292ba@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 05 Sep 2025 13:48:35 -0500
Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org> wrote:

> From: Nathan Lynch <nathan.lynch@amd.com>
> 
> Add SDXI Kconfig that includes debug and unit test options in addition
> to the usual tristate. SDXI_DEBUG seems necessary because
> DMADEVICES_DEBUG makes dmatest too verbose.
> 
> One goal is to keep the bus-agnostic portions of the driver buildable
> without PCI(_MSI), in case non-PCI SDXI implementations come along
> later.
> 
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
It's up to the dma maintainer, but personally and for subsystems I
do maintain this approach of putting the build files in at the end
is not something I'd accept.

The reason being that it leads to issues in earlier patches being
hidden with stuff not well separated.  I'd much rather see the driver
built up so that it builds at each step with each new patch
adding additional functionality.  Also avoids things like comments
on the build dependencies in patch descriptions earlier in the series.
They become clear as the code is with the patch.  The one about MSIX
for example doesn't seem to be related to what is here.

Anyhow, no idea if dma maintainers prefer that or this approach.

> ---
>  drivers/dma/Kconfig       |  2 ++
>  drivers/dma/Makefile      |  1 +
>  drivers/dma/sdxi/Kconfig  | 23 +++++++++++++++++++++++
>  drivers/dma/sdxi/Makefile | 17 +++++++++++++++++
>  4 files changed, 43 insertions(+)
> 
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 05c7c7d9e5a4e52a8ad7ada8c8b9b1a6f9d875f6..cccf00b73e025944681b03cffe441c372526d3f3 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -774,6 +774,8 @@ source "drivers/dma/fsl-dpaa2-qdma/Kconfig"
>  
>  source "drivers/dma/lgm/Kconfig"
>  
> +source "drivers/dma/sdxi/Kconfig"
> +
>  source "drivers/dma/stm32/Kconfig"
>  
>  # clients
> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> index a54d7688392b1a0e956fa5d23633507f52f017d9..ae4154595e1a6250b441a90078e9df3607d3d1dd 100644
> --- a/drivers/dma/Makefile
> +++ b/drivers/dma/Makefile
> @@ -85,6 +85,7 @@ obj-$(CONFIG_XGENE_DMA) += xgene-dma.o
>  obj-$(CONFIG_ST_FDMA) += st_fdma.o
>  obj-$(CONFIG_FSL_DPAA2_QDMA) += fsl-dpaa2-qdma/
>  obj-$(CONFIG_INTEL_LDMA) += lgm/
> +obj-$(CONFIG_SDXI) += sdxi/
>  
>  obj-y += amd/
>  obj-y += mediatek/
> diff --git a/drivers/dma/sdxi/Kconfig b/drivers/dma/sdxi/Kconfig
> new file mode 100644
> index 0000000000000000000000000000000000000000..c9757cffb5f64fbc175ded8d0c9d751f0a22b6df
> --- /dev/null
> +++ b/drivers/dma/sdxi/Kconfig
> @@ -0,0 +1,23 @@
> +config SDXI
> +	tristate "SDXI support"
> +	select DMA_ENGINE
> +	select DMA_VIRTUAL_CHANNELS
> +	select PACKING
> +	help
> +	  Enable support for Smart Data Accelerator Interface (SDXI)
> +	  Platform Data Mover devices. SDXI is a vendor-neutral
> +	  standard for a memory-to-memory data mover and acceleration
> +	  interface.
> +
> +config SDXI_DEBUG
> +	bool "SDXI driver debug"
> +	default DMADEVICES_DEBUG
> +	depends on SDXI != n
> +	help
> +	  Enable debug output from the SDXI driver. This is an option
> +	  for use by developers and most users should say N here.
> +
> +config SDXI_KUNIT_TEST
> +       tristate "SDXI unit tests" if !KUNIT_ALL_TESTS
> +       depends on SDXI && KUNIT
> +       default KUNIT_ALL_TESTS
> diff --git a/drivers/dma/sdxi/Makefile b/drivers/dma/sdxi/Makefile
> new file mode 100644
> index 0000000000000000000000000000000000000000..c67e475689b45d6260fe970fb4afcc25f8f9ebc1
> --- /dev/null
> +++ b/drivers/dma/sdxi/Makefile
> @@ -0,0 +1,17 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +ccflags-$(CONFIG_SDXI_DEBUG) += -DDEBUG

What does this actually do?  More modern drivers rarely
do this any more because we have nice facilities like dynamic debug.

> +
> +obj-$(CONFIG_SDXI) += sdxi.o
> +
> +sdxi-objs += \
> +	context.o     \
> +	descriptor.o  \
> +	device.o      \
> +	dma.o         \
> +	enqueue.o     \
> +	error.o
> +
> +sdxi-$(CONFIG_PCI_MSI) += pci.o
> +
> +obj-$(CONFIG_SDXI_KUNIT_TEST) += descriptor_kunit.o
> 


