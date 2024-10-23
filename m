Return-Path: <dmaengine+bounces-3443-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0419ACE27
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2024 17:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 803D21C20978
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2024 15:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EA61C9B75;
	Wed, 23 Oct 2024 15:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="LXXO91C4"
X-Original-To: dmaengine@vger.kernel.org
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0AD1C728E
	for <dmaengine@vger.kernel.org>; Wed, 23 Oct 2024 15:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729695803; cv=none; b=WxabuXx0uIMpr6speh+lT7F561s7KXvidlViWe7yEvN7S/Fr7HYNNnnB//cUepSEzPSzJ/bVk5M0AQ9prM1eX/DszomPRV5SNA7CjTotkaowceLL6KluA2ioOuxc489Q0Hey5C7NBnz7+r98p4Ooa++p+k9h/d8K8+t+E2d1QzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729695803; c=relaxed/simple;
	bh=IXHJa5RQcBe9FMOfbzUii64NPCDAhUxZUns0+9xZNqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VKbFcRsF71Okl4lFHhSGf+N8tk7ClGp56tX+JN/GGY+XwNuN/Uwh5V0qz+/O0VkiY3V04yhmodwd+4w3mDHuBNOpUgABDTPvT+utjPt+Jmfzz8TPQKiEQhWVJPnTQXaOZfQx3G0yV3g75AwudGfAZqNb+sCeViFX8O3Na4aeE84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=pass smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=LXXO91C4; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1729695793; bh=O2vgyHc/qd9IY8tmRPayOa/IPLbcMryM1fWzEPdubOc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=LXXO91C40hYzMjKiULTDGXZTFgn39Wex6qVpAejOhoq+OShSuPU9rGopH0Qptk9/z
	 39N2rN0XXRkpeNufAhAGWdebzftw0EASMmQSHyDqkB7RYqnCUOz6wtS9xVELTyN7Sd
	 urvBM17UvJldQqRhCxBv6lO0iV4vSH0azEk9XeKg=
Received: from [IPV6:2408:8207:18a1:fd20:ec7f:d727:3cc2:ded9] ([2408:8207:18a1:fd20:ec7f:d727:3cc2:ded9])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id C4982B3; Wed, 23 Oct 2024 23:03:04 +0800
X-QQ-mid: xmsmtpt1729695784tknky4f7b
Message-ID: <tencent_E5B5A91C2B70BF6346432A1A3DF9AC047709@qq.com>
X-QQ-XMAILINFO: NNoVXaH09J17SGad50D8Zq2LBGlcfi9ovxOaekxYE+K6rbvaH0gC7kRcka2hd/
	 +Vv3XvkKl/5NEuGvqi3HW6J6Ee1dvxvRmSB7BGw0MBKd5+nXUYgVWCA6C5AzRimjFsCReS9Fy4OB
	 91BW+ZejIyQxEPqJVtM0F34UGWtvl1PgKtg5gh8CfvzwLoktw6ve/1WOi5tdFKtZe0vaIYleQS9Q
	 +h34lsbAvG4GZbQKfFOhurbUC4b/ugA1qKrURsUYspoRSMB8A0XfyMcfHSrP+DCBrPQHo9gqdxBP
	 5xc71R9TR2Nhlln4NyBoWnvdptI/yceIfoSYZRVe8iLCxV0nopMXAzrKQdSJogFyumgbva1rbDuw
	 PBGMLaKVt3f2RtnaUz8Jb+Pauwe5dTUTkSRWBkggMANBc0mV3zgMOToc0gv6/fqpY7UpcCrEMjdJ
	 jcYm5RLyQWziS/KVrnhQEpk1XorcUWVonMYZmT8gku8X09iO0C3uxkQkPrLm4L6sWgmv4/sQ5w74
	 5dIgQlzwxA9saWmrV2j46MJ0P6Udk1Q8VGbnYQiME9FUAGpuTA0j1dV1Ytnd37z+JQ6ANQ65dMhp
	 KkWi98aAhxUF4tWSWEgGx+cmiGu/zHhLo85jZDaVAJE7VzZMLVoUP1azfbDwon1bZJ5o5R/HzJC3
	 cjP1QS6tj2kxfdJ09joUSMuqFJJRQ2R4NI/eoS0rvJ6sDcYMFdY8AKksk7EKFh1ztkJTyMNsDUhd
	 fA7WoHYNEvA0aHyuk4p9mA8c05IZMJmNLC8rkTO9YdRvIhKpFNYfHjSZnGUdkVC6NOKBQeYXdx3z
	 be7Mp8tvGHyyHDmvzDesE7ZX3RWBzDfho62bCvkGLAO784t+zSD1t/fn6f7BSQ6YXkPID9HnwJ0u
	 3E+hYXSCqcc81KXH/WUcQ5C8gd6c1XvJ3hQA2hOpYzFWBimevp0pVaqTIpQGxnahVyBkXiI5GH1O
	 +kZtGJRDoPP2RpnSzARO2m9QNSX2Xd7tTsNddPow7bhKbNYsrnWlzGmBAd5/BA0AchBcROo5Ph9o
	 xHXwBw+Q==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-OQ-MSGID: <ca446a13-76e7-4c04-bc28-070c01bb3428@cyyself.name>
Date: Wed, 23 Oct 2024 23:03:02 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "MAINTAINERS: Remove some entries due to various
 compliance requirements."
To: Kexy Biscuit <kexybiscuit@aosc.io>, jeffbai@aosc.io,
 gregkh@linuxfoundation.org, wangyuli@uniontech.com,
 torvalds@linux-foundation.org
Cc: aospan@netup.ru, conor.dooley@microchip.com, ddrokosov@sberdevices.ru,
 dmaengine@vger.kernel.org, dushistov@mail.ru, fancer.lancer@gmail.com,
 geert@linux-m68k.org, hoan@os.amperecomputing.com, ink@jurassic.park.msu.ru,
 linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-spi@vger.kernel.org, manivannan.sadhasivam@linaro.org,
 mattst88@gmail.com, netdev@vger.kernel.org, nikita@trvn.ru,
 ntb@lists.linux.dev, patches@lists.linux.dev, richard.henderson@linaro.org,
 s.shtylyov@omp.ru, serjk@netup.ru, shc_work@mail.ru,
 tsbogend@alpha.franken.de, v.georgiev@metrotek.ru,
 wsa+renesas@sang-engineering.com, xeb@mail.ru
References: <a08dc31ab773604d8f206ba005dc4c7a@aosc.io>
 <20241023080935.2945-2-kexybiscuit@aosc.io>
Content-Language: en-US
From: Yangyu Chen <cyy@cyyself.name>
In-Reply-To: <20241023080935.2945-2-kexybiscuit@aosc.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/10/23 16:09, Kexy Biscuit wrote:
> This reverts commit 6e90b675cf942e50c70e8394dfb5862975c3b3b2.
> 
> An absolutely no-one-ever-reviewed patch, not even by the maintainers who
> got removed themselves - at least not on the mailing list. Then the patch
> just got slipped into an unrelated subsystem pull request, and got pulled
> by Torvalds with not even a comment.
> 

I agree.

> What about the next time? Who next would be removed from the MAINTAINERS
> file, the kernel.org infrastructure? What if the compliance requires
> another XZ backdoor to be developed without further explanation? Is the
> kernel development process still done in public?
> 
> Are the "compliance requirements" documented on docs.kernel.org? Who are
> responsible for them? Are all that are responsible employees of
> The Linux Foundation, which is regulated by the U.S. legislature?
> 

Please consider how a neutral maintainer would perceive these commit
messages; if they sign off on this commit, what does it mean?

I recommend focusing on factual information rather than inciting
emotions. Including these statements in the commit message may not
be the best approach to gaining objective support. I suggest removing
these two paragraphs and submitting a revised patch v2.

Otherwise, it looks good to me.

Reviewed-by: Yangyu Chen <cyy@cyyself.name>

> Fixes: 6e90b675cf94 ("MAINTAINERS: Remove some entries due to various compliance requirements.")
> Signed-off-by: Kexy Biscuit <kexybiscuit@aosc.io>
> Acked-by: Nikita Travkin <nikita@trvn.ru>
> Acked-by: WangYuli <wangyuli@uniontech.com>
> Acked-by: Mingcong Bai <jeffbai@aosc.io>
> Acked-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> Acked-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
> Please keep all discussions on at least one of the mailing lists.
> 
>   MAINTAINERS | 178 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 178 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e9659a5a7fb3..501aa5c0887e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -258,6 +258,12 @@ L:	linux-acenic@sunsite.dk
>   S:	Maintained
>   F:	drivers/net/ethernet/alteon/acenic*
>   
> +ACER ASPIRE 1 EMBEDDED CONTROLLER DRIVER
> +M:	Nikita Travkin <nikita@trvn.ru>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/platform/acer,aspire1-ec.yaml
> +F:	drivers/platform/arm64/acer-aspire1-ec.c
> +
>   ACER ASPIRE ONE TEMPERATURE AND FAN DRIVER
>   M:	Peter Kaestle <peter@piie.net>
>   L:	platform-driver-x86@vger.kernel.org
> @@ -882,6 +888,7 @@ F:	drivers/staging/media/sunxi/cedrus/
>   
>   ALPHA PORT
>   M:	Richard Henderson <richard.henderson@linaro.org>
> +M:	Ivan Kokshaysky <ink@jurassic.park.msu.ru>
>   M:	Matt Turner <mattst88@gmail.com>
>   L:	linux-alpha@vger.kernel.org
>   S:	Odd Fixes
> @@ -2256,6 +2263,12 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>   S:	Maintained
>   F:	arch/arm/mach-ep93xx/ts72xx.c
>   
> +ARM/CIRRUS LOGIC CLPS711X ARM ARCHITECTURE
> +M:	Alexander Shiyan <shc_work@mail.ru>
> +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> +S:	Odd Fixes
> +N:	clps711x
> +
>   ARM/CIRRUS LOGIC EP93XX ARM ARCHITECTURE
>   M:	Hartley Sweeten <hsweeten@visionengravers.com>
>   M:	Alexander Sverdlin <alexander.sverdlin@gmail.com>
> @@ -3802,6 +3815,14 @@ F:	drivers/video/backlight/
>   F:	include/linux/backlight.h
>   F:	include/linux/pwm_backlight.h
>   
> +BAIKAL-T1 PVT HARDWARE MONITOR DRIVER
> +M:	Serge Semin <fancer.lancer@gmail.com>
> +L:	linux-hwmon@vger.kernel.org
> +S:	Supported
> +F:	Documentation/devicetree/bindings/hwmon/baikal,bt1-pvt.yaml
> +F:	Documentation/hwmon/bt1-pvt.rst
> +F:	drivers/hwmon/bt1-pvt.[ch]
> +
>   BARCO P50 GPIO DRIVER
>   M:	Santosh Kumar Yadav <santoshkumar.yadav@barco.com>
>   M:	Peter Korsgaard <peter.korsgaard@barco.com>
> @@ -6455,6 +6476,7 @@ F:	drivers/mtd/nand/raw/denali*
>   
>   DESIGNWARE EDMA CORE IP DRIVER
>   M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +R:	Serge Semin <fancer.lancer@gmail.com>
>   L:	dmaengine@vger.kernel.org
>   S:	Maintained
>   F:	drivers/dma/dw-edma/
> @@ -9737,6 +9759,14 @@ F:	drivers/gpio/gpiolib-cdev.c
>   F:	include/uapi/linux/gpio.h
>   F:	tools/gpio/
>   
> +GRE DEMULTIPLEXER DRIVER
> +M:	Dmitry Kozlov <xeb@mail.ru>
> +L:	netdev@vger.kernel.org
> +S:	Maintained
> +F:	include/net/gre.h
> +F:	net/ipv4/gre_demux.c
> +F:	net/ipv4/gre_offload.c
> +
>   GRETH 10/100/1G Ethernet MAC device driver
>   M:	Andreas Larsson <andreas@gaisler.com>
>   L:	netdev@vger.kernel.org
> @@ -12929,6 +12959,12 @@ S:	Maintained
>   F:	drivers/ata/pata_arasan_cf.c
>   F:	include/linux/pata_arasan_cf_data.h
>   
> +LIBATA PATA DRIVERS
> +R:	Sergey Shtylyov <s.shtylyov@omp.ru>
> +L:	linux-ide@vger.kernel.org
> +F:	drivers/ata/ata_*.c
> +F:	drivers/ata/pata_*.c
> +
>   LIBATA PATA FARADAY FTIDE010 AND GEMINI SATA BRIDGE DRIVERS
>   M:	Linus Walleij <linus.walleij@linaro.org>
>   L:	linux-ide@vger.kernel.org
> @@ -12945,6 +12981,15 @@ F:	drivers/ata/ahci_platform.c
>   F:	drivers/ata/libahci_platform.c
>   F:	include/linux/ahci_platform.h
>   
> +LIBATA SATA AHCI SYNOPSYS DWC CONTROLLER DRIVER
> +M:	Serge Semin <fancer.lancer@gmail.com>
> +L:	linux-ide@vger.kernel.org
> +S:	Maintained
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata.git
> +F:	Documentation/devicetree/bindings/ata/baikal,bt1-ahci.yaml
> +F:	Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
> +F:	drivers/ata/ahci_dwc.c
> +
>   LIBATA SATA PROMISE TX2/TX4 CONTROLLER DRIVER
>   M:	Mikael Pettersson <mikpelinux@gmail.com>
>   L:	linux-ide@vger.kernel.org
> @@ -14140,6 +14185,16 @@ S:	Maintained
>   T:	git git://linuxtv.org/media_tree.git
>   F:	drivers/media/platform/nxp/imx-pxp.[ch]
>   
> +MEDIA DRIVERS FOR ASCOT2E
> +M:	Sergey Kozlov <serjk@netup.ru>
> +M:	Abylay Ospan <aospan@netup.ru>
> +L:	linux-media@vger.kernel.org
> +S:	Supported
> +W:	https://linuxtv.org
> +W:	http://netup.tv/
> +T:	git git://linuxtv.org/media_tree.git
> +F:	drivers/media/dvb-frontends/ascot2e*
> +
>   MEDIA DRIVERS FOR CXD2099AR CI CONTROLLERS
>   M:	Jasmin Jessich <jasmin@anw.at>
>   L:	linux-media@vger.kernel.org
> @@ -14148,6 +14203,16 @@ W:	https://linuxtv.org
>   T:	git git://linuxtv.org/media_tree.git
>   F:	drivers/media/dvb-frontends/cxd2099*
>   
> +MEDIA DRIVERS FOR CXD2841ER
> +M:	Sergey Kozlov <serjk@netup.ru>
> +M:	Abylay Ospan <aospan@netup.ru>
> +L:	linux-media@vger.kernel.org
> +S:	Supported
> +W:	https://linuxtv.org
> +W:	http://netup.tv/
> +T:	git git://linuxtv.org/media_tree.git
> +F:	drivers/media/dvb-frontends/cxd2841er*
> +
>   MEDIA DRIVERS FOR CXD2880
>   M:	Yasunari Takiguchi <Yasunari.Takiguchi@sony.com>
>   L:	linux-media@vger.kernel.org
> @@ -14192,6 +14257,35 @@ F:	drivers/media/platform/nxp/imx-mipi-csis.c
>   F:	drivers/media/platform/nxp/imx7-media-csi.c
>   F:	drivers/media/platform/nxp/imx8mq-mipi-csi2.c
>   
> +MEDIA DRIVERS FOR HELENE
> +M:	Abylay Ospan <aospan@netup.ru>
> +L:	linux-media@vger.kernel.org
> +S:	Supported
> +W:	https://linuxtv.org
> +W:	http://netup.tv/
> +T:	git git://linuxtv.org/media_tree.git
> +F:	drivers/media/dvb-frontends/helene*
> +
> +MEDIA DRIVERS FOR HORUS3A
> +M:	Sergey Kozlov <serjk@netup.ru>
> +M:	Abylay Ospan <aospan@netup.ru>
> +L:	linux-media@vger.kernel.org
> +S:	Supported
> +W:	https://linuxtv.org
> +W:	http://netup.tv/
> +T:	git git://linuxtv.org/media_tree.git
> +F:	drivers/media/dvb-frontends/horus3a*
> +
> +MEDIA DRIVERS FOR LNBH25
> +M:	Sergey Kozlov <serjk@netup.ru>
> +M:	Abylay Ospan <aospan@netup.ru>
> +L:	linux-media@vger.kernel.org
> +S:	Supported
> +W:	https://linuxtv.org
> +W:	http://netup.tv/
> +T:	git git://linuxtv.org/media_tree.git
> +F:	drivers/media/dvb-frontends/lnbh25*
> +
>   MEDIA DRIVERS FOR MXL5XX TUNER DEMODULATORS
>   L:	linux-media@vger.kernel.org
>   S:	Orphan
> @@ -14199,6 +14293,16 @@ W:	https://linuxtv.org
>   T:	git git://linuxtv.org/media_tree.git
>   F:	drivers/media/dvb-frontends/mxl5xx*
>   
> +MEDIA DRIVERS FOR NETUP PCI UNIVERSAL DVB devices
> +M:	Sergey Kozlov <serjk@netup.ru>
> +M:	Abylay Ospan <aospan@netup.ru>
> +L:	linux-media@vger.kernel.org
> +S:	Supported
> +W:	https://linuxtv.org
> +W:	http://netup.tv/
> +T:	git git://linuxtv.org/media_tree.git
> +F:	drivers/media/pci/netup_unidvb/*
> +
>   MEDIA DRIVERS FOR NVIDIA TEGRA - VDE
>   M:	Dmitry Osipenko <digetx@gmail.com>
>   L:	linux-media@vger.kernel.org
> @@ -14842,6 +14946,13 @@ F:	drivers/mtd/
>   F:	include/linux/mtd/
>   F:	include/uapi/mtd/
>   
> +MEMSENSING MICROSYSTEMS MSA311 DRIVER
> +M:	Dmitry Rokosov <ddrokosov@sberdevices.ru>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/accel/memsensing,msa311.yaml
> +F:	drivers/iio/accel/msa311.c
> +
>   MEN A21 WATCHDOG DRIVER
>   M:	Johannes Thumshirn <morbidrsa@gmail.com>
>   L:	linux-watchdog@vger.kernel.org
> @@ -15175,6 +15286,7 @@ F:	drivers/tty/serial/8250/8250_pci1xxxx.c
>   
>   MICROCHIP POLARFIRE FPGA DRIVERS
>   M:	Conor Dooley <conor.dooley@microchip.com>
> +R:	Vladimir Georgiev <v.georgiev@metrotek.ru>
>   L:	linux-fpga@vger.kernel.org
>   S:	Supported
>   F:	Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
> @@ -15429,6 +15541,17 @@ F:	arch/mips/
>   F:	drivers/platform/mips/
>   F:	include/dt-bindings/mips/
>   
> +MIPS BAIKAL-T1 PLATFORM
> +M:	Serge Semin <fancer.lancer@gmail.com>
> +L:	linux-mips@vger.kernel.org
> +S:	Supported
> +F:	Documentation/devicetree/bindings/bus/baikal,bt1-*.yaml
> +F:	Documentation/devicetree/bindings/clock/baikal,bt1-*.yaml
> +F:	drivers/bus/bt1-*.c
> +F:	drivers/clk/baikal-t1/
> +F:	drivers/memory/bt1-l2-ctl.c
> +F:	drivers/mtd/maps/physmap-bt1-rom.[ch]
> +
>   MIPS BOSTON DEVELOPMENT BOARD
>   M:	Paul Burton <paulburton@kernel.org>
>   L:	linux-mips@vger.kernel.org
> @@ -15441,6 +15564,7 @@ F:	include/dt-bindings/clock/boston-clock.h
>   
>   MIPS CORE DRIVERS
>   M:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> +M:	Serge Semin <fancer.lancer@gmail.com>
>   L:	linux-mips@vger.kernel.org
>   S:	Supported
>   F:	drivers/bus/mips_cdmm.c
> @@ -16408,6 +16532,12 @@ F:	include/linux/ntb.h
>   F:	include/linux/ntb_transport.h
>   F:	tools/testing/selftests/ntb/
>   
> +NTB IDT DRIVER
> +M:	Serge Semin <fancer.lancer@gmail.com>
> +L:	ntb@lists.linux.dev
> +S:	Supported
> +F:	drivers/ntb/hw/idt/
> +
>   NTB INTEL DRIVER
>   M:	Dave Jiang <dave.jiang@intel.com>
>   L:	ntb@lists.linux.dev
> @@ -18428,6 +18558,13 @@ F:	drivers/pps/
>   F:	include/linux/pps*.h
>   F:	include/uapi/linux/pps.h
>   
> +PPTP DRIVER
> +M:	Dmitry Kozlov <xeb@mail.ru>
> +L:	netdev@vger.kernel.org
> +S:	Maintained
> +W:	http://sourceforge.net/projects/accel-pptp
> +F:	drivers/net/ppp/pptp.c
> +
>   PRESSURE STALL INFORMATION (PSI)
>   M:	Johannes Weiner <hannes@cmpxchg.org>
>   M:	Suren Baghdasaryan <surenb@google.com>
> @@ -19518,6 +19655,15 @@ S:	Supported
>   F:	Documentation/devicetree/bindings/i2c/renesas,iic-emev2.yaml
>   F:	drivers/i2c/busses/i2c-emev2.c
>   
> +RENESAS ETHERNET AVB DRIVER
> +R:	Sergey Shtylyov <s.shtylyov@omp.ru>
> +L:	netdev@vger.kernel.org
> +L:	linux-renesas-soc@vger.kernel.org
> +F:	Documentation/devicetree/bindings/net/renesas,etheravb.yaml
> +F:	drivers/net/ethernet/renesas/Kconfig
> +F:	drivers/net/ethernet/renesas/Makefile
> +F:	drivers/net/ethernet/renesas/ravb*
> +
>   RENESAS ETHERNET SWITCH DRIVER
>   R:	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>   L:	netdev@vger.kernel.org
> @@ -19567,6 +19713,14 @@ F:	Documentation/devicetree/bindings/i2c/renesas,rmobile-iic.yaml
>   F:	drivers/i2c/busses/i2c-rcar.c
>   F:	drivers/i2c/busses/i2c-sh_mobile.c
>   
> +RENESAS R-CAR SATA DRIVER
> +R:	Sergey Shtylyov <s.shtylyov@omp.ru>
> +L:	linux-ide@vger.kernel.org
> +L:	linux-renesas-soc@vger.kernel.org
> +S:	Supported
> +F:	Documentation/devicetree/bindings/ata/renesas,rcar-sata.yaml
> +F:	drivers/ata/sata_rcar.c
> +
>   RENESAS R-CAR THERMAL DRIVERS
>   M:	Niklas Söderlund <niklas.soderlund@ragnatech.se>
>   L:	linux-renesas-soc@vger.kernel.org
> @@ -19642,6 +19796,16 @@ S:	Supported
>   F:	Documentation/devicetree/bindings/i2c/renesas,rzv2m.yaml
>   F:	drivers/i2c/busses/i2c-rzv2m.c
>   
> +RENESAS SUPERH ETHERNET DRIVER
> +R:	Sergey Shtylyov <s.shtylyov@omp.ru>
> +L:	netdev@vger.kernel.org
> +L:	linux-renesas-soc@vger.kernel.org
> +F:	Documentation/devicetree/bindings/net/renesas,ether.yaml
> +F:	drivers/net/ethernet/renesas/Kconfig
> +F:	drivers/net/ethernet/renesas/Makefile
> +F:	drivers/net/ethernet/renesas/sh_eth*
> +F:	include/linux/sh_eth.h
> +
>   RENESAS USB PHY DRIVER
>   M:	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>   L:	linux-renesas-soc@vger.kernel.org
> @@ -22295,11 +22459,19 @@ F:	drivers/tty/serial/8250/8250_lpss.c
>   
>   SYNOPSYS DESIGNWARE APB GPIO DRIVER
>   M:	Hoan Tran <hoan@os.amperecomputing.com>
> +M:	Serge Semin <fancer.lancer@gmail.com>
>   L:	linux-gpio@vger.kernel.org
>   S:	Maintained
>   F:	Documentation/devicetree/bindings/gpio/snps,dw-apb-gpio.yaml
>   F:	drivers/gpio/gpio-dwapb.c
>   
> +SYNOPSYS DESIGNWARE APB SSI DRIVER
> +M:	Serge Semin <fancer.lancer@gmail.com>
> +L:	linux-spi@vger.kernel.org
> +S:	Supported
> +F:	Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> +F:	drivers/spi/spi-dw*
> +
>   SYNOPSYS DESIGNWARE AXI DMAC DRIVER
>   M:	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
>   S:	Maintained
> @@ -23609,6 +23781,12 @@ L:	linux-input@vger.kernel.org
>   S:	Maintained
>   F:	drivers/hid/hid-udraw-ps3.c
>   
> +UFS FILESYSTEM
> +M:	Evgeniy Dushistov <dushistov@mail.ru>
> +S:	Maintained
> +F:	Documentation/admin-guide/ufs.rst
> +F:	fs/ufs/
> +
>   UHID USERSPACE HID IO DRIVER
>   M:	David Rheinsberg <david@readahead.eu>
>   L:	linux-input@vger.kernel.org


