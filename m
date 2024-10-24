Return-Path: <dmaengine+bounces-3473-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8599AE747
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 16:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5307E1F2464B
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 14:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64EB1E8826;
	Thu, 24 Oct 2024 14:04:46 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.tlmp.cc (unknown [148.135.104.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB821E766B;
	Thu, 24 Oct 2024 14:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.135.104.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729778686; cv=none; b=M+kdMEmQ0P+MXEH1hvNbnsroBZ6vBcgW/S32yvELLfp5v4kesd+YasVe+bLZK2TmHhlMO2TeWNLZXxb7zNBaV8PKqExZuD80eH10VMqIeQE0thhdOclhGg3v1J0DOwqtz64lGyGs4fsTqULMxKk4Gx2ona98zwbayq9sdUrZkaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729778686; c=relaxed/simple;
	bh=xV3+YM4csR8hWKehkwGClwHk/OeWAo/jHKOiuMsEgNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nNkR4VU33sfFhyIYKPT6I6h/koTftY5gtMsmrL0vZLYAB8093NVAdkZF/WPN1Wa3LGN+FQOGHhTfydBF7dNl123RK82Fnqs2pR71hlHjEv0iBho9K50IBiUghHm48CJRhiTeui4AWZCJ8Z65O915OZOTcdNL4/jwFYG7NQmIbGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kremlin.ru; spf=fail smtp.mailfrom=kremlin.ru; arc=none smtp.client-ip=148.135.104.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kremlin.ru
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kremlin.ru
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9DE695E5DA;
	Thu, 24 Oct 2024 10:04:30 -0400 (EDT)
From: Vladimir Vladimirovich Putin <vladimir_putin_rus@kremlin.ru>
To: torvalds@linux-foundation.org
Cc: aospan@netup.ru,
	conor.dooley@microchip.com,
	ddrokosov@sberdevices.ru,
	dmaengine@vger.kernel.org,
	dushistov@mail.ru,
	fancer.lancer@gmail.com,
	geert@linux-m68k.org,
	gregkh@linuxfoundation.org,
	hoan@os.amperecomputing.com,
	ink@jurassic.park.msu.ru,
	jeffbai@aosc.io,
	kexybiscuit@aosc.io,
	linux-alpha@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-fpga@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-spi@vger.kernel.org,
	manivannan.sadhasivam@linaro.org,
	mattst88@gmail.com,
	netdev@vger.kernel.org,
	nikita@trvn.ru,
	ntb@lists.linux.dev,
	patches@lists.linux.dev,
	richard.henderson@linaro.org,
	s.shtylyov@omp.ru,
	serjk@netup.ru,
	shc_work@mail.ru,
	torvic9@mailbox.org,
	tsbogend@alpha.franken.de,
	v.georgiev@metrotek.ru,
	wangyuli@uniontech.com,
	wsa+renesas@sang-engineering.com,
	xeb@mail.ru,
	LKML <linux-kernel@vger.kernel.org>,
	Vladimir Vladimirovich Putin <vladimir_putin_rus@kremlin.ru>
Subject: [PATCH 2/2] MAINTAINERS: Remove Loongson due to compilance requirements.
Date: Thu, 24 Oct 2024 22:03:53 +0800
Message-ID: <20241024140353.384881-3-vladimir_putin_rus@kremlin.ru>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024140353.384881-1-vladimir_putin_rus@kremlin.ru>
References: <CAHk-=whNGNVnYHHSXUAsWds_MoZ-iEgRMQMxZZ0z-jY4uHT+Gg@mail.gmail.com>
 <20241024140353.384881-1-vladimir_putin_rus@kremlin.ru>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Loongson was added to the US Entity List[1] on 03/06/2023

The Entity List is a trade restriction list published by the United
States Department of Commerce's Bureau of Industry and Security (BIS),
consisting of certain foreign persons, entities, or governments.
It is published as Supplement 4 of Part 744 of the Code
of Federal Regulations. [2]

[1]: https://www.federalregister.gov/documents/2023/03/06/2023-04558/
additions-and-revisions-of-entities-to-the-entity-list
[2]: https://en.wikipedia.org/wiki/Entity_List

Signed-off-by: Vladimir Vladimirovich Putin <vladimir_putin_rus@kremlin.ru>
---
 MAINTAINERS | 50 --------------------------------------------------
 1 file changed, 50 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 725a72e17a4a..c2de74bc8e38 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4041,7 +4041,6 @@ S:	Supported
 F:	arch/arm64/net/
 
 BPF JIT for LOONGARCH
-M:	Tiezhu Yang <yangtiezhu@loongson.cn>
 R:	Hengqi Chen <hengqi.chen@gmail.com>
 L:	bpf@vger.kernel.org
 S:	Maintained
@@ -5280,7 +5279,6 @@ F:	Documentation/dev-tools/checkpatch.rst
 
 CHINESE DOCUMENTATION
 M:	Alex Shi <alexs@kernel.org>
-M:	Yanteng Si <siyanteng@loongson.cn>
 S:	Maintained
 F:	Documentation/translations/zh_CN/
 
@@ -7629,11 +7627,9 @@ F:	drivers/gpu/drm/lima/
 F:	include/uapi/drm/lima_drm.h
 
 DRM DRIVERS FOR LOONGSON
-M:	Sui Jingfeng <suijingfeng@loongson.cn>
 L:	dri-devel@lists.freedesktop.org
 S:	Supported
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
-F:	drivers/gpu/drm/loongson/
 
 DRM DRIVERS FOR MEDIATEK
 M:	Chun-Kuang Hu <chunkuang.hu@kernel.org>
@@ -12426,8 +12422,6 @@ F:	tools/testing/selftests/kvm/*/aarch64/
 F:	tools/testing/selftests/kvm/aarch64/
 
 KERNEL VIRTUAL MACHINE FOR LOONGARCH (KVM/LoongArch)
-M:	Tianrui Zhao <zhaotianrui@loongson.cn>
-M:	Bibo Mao <maobibo@loongson.cn>
 M:	Huacai Chen <chenhuacai@kernel.org>
 L:	kvm@vger.kernel.org
 L:	loongarch@lists.linux.dev
@@ -13285,81 +13279,48 @@ M:	Huacai Chen <chenhuacai@kernel.org>
 R:	WANG Xuerui <kernel@xen0n.name>
 L:	loongarch@lists.linux.dev
 S:	Maintained
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git
 F:	Documentation/arch/loongarch/
 F:	Documentation/translations/zh_CN/arch/loongarch/
 F:	arch/loongarch/
 F:	drivers/*/*loongarch*
-F:	drivers/cpufreq/loongson3_cpufreq.c
 
 LOONGSON GPIO DRIVER
-M:	Yinbo Zhu <zhuyinbo@loongson.cn>
 L:	linux-gpio@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
-F:	drivers/gpio/gpio-loongson-64bit.c
 
 LOONGSON LS2X APB DMA DRIVER
-M:	Binbin Zhou <zhoubinbin@loongson.cn>
 L:	dmaengine@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/dma/loongson,ls2x-apbdma.yaml
 F:	drivers/dma/ls2x-apb-dma.c
 
 LOONGSON LS2X I2C DRIVER
-M:	Binbin Zhou <zhoubinbin@loongson.cn>
 L:	linux-i2c@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.yaml
 F:	drivers/i2c/busses/i2c-ls2x.c
 
 LOONGSON-2 SOC SERIES CLOCK DRIVER
-M:	Yinbo Zhu <zhuyinbo@loongson.cn>
 L:	linux-clk@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/clock/loongson,ls2k-clk.yaml
-F:	drivers/clk/clk-loongson2.c
-F:	include/dt-bindings/clock/loongson,ls2k-clk.h
 
 LOONGSON SPI DRIVER
-M:	Yinbo Zhu <zhuyinbo@loongson.cn>
 L:	linux-spi@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/spi/loongson,ls2k-spi.yaml
-F:	drivers/spi/spi-loongson-core.c
-F:	drivers/spi/spi-loongson-pci.c
-F:	drivers/spi/spi-loongson-plat.c
-F:	drivers/spi/spi-loongson.h
 
 LOONGSON-2 SOC SERIES GUTS DRIVER
-M:	Yinbo Zhu <zhuyinbo@loongson.cn>
 L:	loongarch@lists.linux.dev
 S:	Maintained
-F:	Documentation/devicetree/bindings/hwinfo/loongson,ls2k-chipid.yaml
-F:	drivers/soc/loongson/loongson2_guts.c
 
 LOONGSON-2 SOC SERIES PM DRIVER
-M:	Yinbo Zhu <zhuyinbo@loongson.cn>
 L:	linux-pm@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-pmc.yaml
-F:	drivers/soc/loongson/loongson2_pm.c
 
 LOONGSON-2 SOC SERIES PINCTRL DRIVER
-M:	zhanghongchen <zhanghongchen@loongson.cn>
-M:	Yinbo Zhu <zhuyinbo@loongson.cn>
 L:	linux-gpio@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/pinctrl/loongson,ls2k-pinctrl.yaml
-F:	drivers/pinctrl/pinctrl-loongson2.c
 
 LOONGSON-2 SOC SERIES THERMAL DRIVER
-M:	zhanghongchen <zhanghongchen@loongson.cn>
-M:	Yinbo Zhu <zhuyinbo@loongson.cn>
 L:	linux-pm@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml
-F:	drivers/thermal/loongson2_thermal.c
 
 LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
 M:	Sathya Prakash <sathya.prakash@broadcom.com>
@@ -15432,28 +15393,17 @@ MIPS/LOONGSON1 ARCHITECTURE
 M:	Keguang Zhang <keguang.zhang@gmail.com>
 L:	linux-mips@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/*/loongson,ls1*.yaml
-F:	arch/mips/include/asm/mach-loongson32/
-F:	arch/mips/loongson32/
-F:	drivers/*/*loongson1*
-F:	drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c
 
 MIPS/LOONGSON2EF ARCHITECTURE
 M:	Jiaxun Yang <jiaxun.yang@flygoat.com>
 L:	linux-mips@vger.kernel.org
 S:	Maintained
-F:	arch/mips/include/asm/mach-loongson2ef/
-F:	arch/mips/loongson2ef/
-F:	drivers/cpufreq/loongson2_cpufreq.c
 
 MIPS/LOONGSON64 ARCHITECTURE
 M:	Huacai Chen <chenhuacai@kernel.org>
 M:	Jiaxun Yang <jiaxun.yang@flygoat.com>
 L:	linux-mips@vger.kernel.org
 S:	Maintained
-F:	arch/mips/include/asm/mach-loongson64/
-F:	arch/mips/loongson64/
-F:	drivers/irqchip/irq-loongson*
 F:	drivers/platform/mips/cpu_hwmon.c
 
 MIROSOUND PCM20 FM RADIO RECEIVER DRIVER
-- 
2.47.0


