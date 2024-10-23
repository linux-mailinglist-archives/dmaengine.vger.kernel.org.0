Return-Path: <dmaengine+bounces-3432-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBE59AC7EB
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2024 12:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F2D81C21A52
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2024 10:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1A71A7240;
	Wed, 23 Oct 2024 10:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b="HPezJFmb"
X-Original-To: dmaengine@vger.kernel.org
Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net [178.154.239.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48551A2C27;
	Wed, 23 Oct 2024 10:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729679245; cv=none; b=naplo1HSrJxmIXeItS0QtsszrC8cFC0A4qt6HSyVkWiesvs6pvSB4nmPAuArhWpk10atEHtt3OhjYIdsQ2ZSsMP93U5xhZ4zzPVKqbifB1LQr/bEEVZi09At5yOoarM7G8oEf0i+JigRqRv7enPn+FGBrs5qdniydOxfwk5LLsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729679245; c=relaxed/simple;
	bh=NRizPnDnjCmCoPsGYxhh4pKzqwgyWyPXaBZ4lwkYD4Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jXriYy/Fd/2amOMZ/dMm7wOd2M1Bur7SK5TkqHEiBu6JiWcKL4k4WaOjRwZhu9ztlMTL6QCu+L91IhJ5wyNJhUkpHq1fn+7Bs95wUi7yEfgCZRVCCWMP8msYtqnRMYWx403hhAi/NKk/VnqOIp4eU5AiS9cqvGbuKRIS24LAHSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me; spf=pass smtp.mailfrom=maquefel.me; dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b=HPezJFmb; arc=none smtp.client-ip=178.154.239.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maquefel.me
Received: from mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:422b:0:640:bcad:0])
	by forward102a.mail.yandex.net (Yandex) with ESMTPS id F3C4860AF2;
	Wed, 23 Oct 2024 13:27:11 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 8RQDQb5p5W20-IX3E2hnO;
	Wed, 23 Oct 2024 13:27:10 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
	t=1729679230; bh=7c5fT5e9mU+C7kX3jmP7t0Wk9OvDlnGRCNBdadiICeg=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=HPezJFmbYILa79JtCEyK0aniAexWPVvLh/GQmfxNiTPgRgv1q9OiAKctV45d/uhuJ
	 bqf/UyXgXB1L0B+xBbG3pxD1RNxYUdD7CQQTw0HDlPdGVCloXVwzCpUe55cqHxgyxz
	 HfcBbelprGcG26wmGaWi1Q3wfQp+2Bq3rqPd7LYc=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <da51e20d1c93181057381d232f373fcb2e168ee4.camel@maquefel.me>
Subject: Re: [PATCH] Revert "MAINTAINERS: Remove some entries due to various
 compliance requirements."
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: Kexy Biscuit <kexybiscuit@aosc.io>, jeffbai@aosc.io, 
	gregkh@linuxfoundation.org, wangyuli@uniontech.com, 
	torvalds@linux-foundation.org
Cc: aospan@netup.ru, conor.dooley@microchip.com, ddrokosov@sberdevices.ru, 
 dmaengine@vger.kernel.org, dushistov@mail.ru, fancer.lancer@gmail.com, 
 geert@linux-m68k.org, hoan@os.amperecomputing.com,
 ink@jurassic.park.msu.ru,  linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,  linux-fpga@vger.kernel.org,
 linux-gpio@vger.kernel.org,  linux-hwmon@vger.kernel.org,
 linux-ide@vger.kernel.org,  linux-iio@vger.kernel.org,
 linux-media@vger.kernel.org,  linux-mips@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org,  linux-spi@vger.kernel.org,
 manivannan.sadhasivam@linaro.org, mattst88@gmail.com, 
 netdev@vger.kernel.org, nikita@trvn.ru, ntb@lists.linux.dev, 
 patches@lists.linux.dev, richard.henderson@linaro.org, s.shtylyov@omp.ru, 
 serjk@netup.ru, shc_work@mail.ru, tsbogend@alpha.franken.de, 
 v.georgiev@metrotek.ru, wsa+renesas@sang-engineering.com, xeb@mail.ru
Date: Wed, 23 Oct 2024 13:27:13 +0300
In-Reply-To: <20241023080935.2945-2-kexybiscuit@aosc.io>
References: <a08dc31ab773604d8f206ba005dc4c7a@aosc.io>
	 <20241023080935.2945-2-kexybiscuit@aosc.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Acked-by: Nikita Shubin <nikita.shubin@maquefel.me>

On Wed, 2024-10-23 at 16:09 +0800, Kexy Biscuit wrote:
> This reverts commit 6e90b675cf942e50c70e8394dfb5862975c3b3b2.
>=20
> An absolutely no-one-ever-reviewed patch, not even by the maintainers
> who
> got removed themselves - at least not on the mailing list. Then the
> patch
> just got slipped into an unrelated subsystem pull request, and got
> pulled
> by Torvalds with not even a comment.
>=20
> What about the next time? Who next would be removed from the
> MAINTAINERS
> file, the kernel.org infrastructure? What if the compliance requires
> another XZ backdoor to be developed without further explanation? Is
> the
> kernel development process still done in public?
>=20
> Are the "compliance requirements" documented on docs.kernel.org? Who
> are
> responsible for them? Are all that are responsible employees of
> The Linux Foundation, which is regulated by the U.S. legislature?
>=20
> Fixes: 6e90b675cf94 ("MAINTAINERS: Remove some entries due to various
> compliance requirements.")
> Signed-off-by: Kexy Biscuit <kexybiscuit@aosc.io>
> ---
> Please keep all discussions on at least one of the mailing lists.
>=20
> =C2=A0MAINTAINERS | 178
> ++++++++++++++++++++++++++++++++++++++++++++++++++++
> =C2=A01 file changed, 178 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e9659a5a7fb3..501aa5c0887e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -258,6 +258,12 @@ L:	linux-acenic@sunsite.dk
> =C2=A0S:	Maintained
> =C2=A0F:	drivers/net/ethernet/alteon/acenic*
> =C2=A0
> +ACER ASPIRE 1 EMBEDDED CONTROLLER DRIVER
> +M:	Nikita Travkin <nikita@trvn.ru>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/platform/acer,aspire1-
> ec.yaml
> +F:	drivers/platform/arm64/acer-aspire1-ec.c
> +
> =C2=A0ACER ASPIRE ONE TEMPERATURE AND FAN DRIVER
> =C2=A0M:	Peter Kaestle <peter@piie.net>
> =C2=A0L:	platform-driver-x86@vger.kernel.org
> @@ -882,6 +888,7 @@ F:	drivers/staging/media/sunxi/cedrus/
> =C2=A0
> =C2=A0ALPHA PORT
> =C2=A0M:	Richard Henderson <richard.henderson@linaro.org>
> +M:	Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> =C2=A0M:	Matt Turner <mattst88@gmail.com>
> =C2=A0L:	linux-alpha@vger.kernel.org
> =C2=A0S:	Odd Fixes
> @@ -2256,6 +2263,12 @@
> L:	linux-arm-kernel@lists.infradead.org=C2=A0(moderated for non-subscribe=
rs)
> =C2=A0S:	Maintained
> =C2=A0F:	arch/arm/mach-ep93xx/ts72xx.c
> =C2=A0
> +ARM/CIRRUS LOGIC CLPS711X ARM ARCHITECTURE
> +M:	Alexander Shiyan <shc_work@mail.ru>
> +L:	linux-arm-kernel@lists.infradead.org=C2=A0(moderated for non-
> subscribers)
> +S:	Odd Fixes
> +N:	clps711x
> +
> =C2=A0ARM/CIRRUS LOGIC EP93XX ARM ARCHITECTURE
> =C2=A0M:	Hartley Sweeten <hsweeten@visionengravers.com>
> =C2=A0M:	Alexander Sverdlin <alexander.sverdlin@gmail.com>
> @@ -3802,6 +3815,14 @@ F:	drivers/video/backlight/
> =C2=A0F:	include/linux/backlight.h
> =C2=A0F:	include/linux/pwm_backlight.h
> =C2=A0
> +BAIKAL-T1 PVT HARDWARE MONITOR DRIVER
> +M:	Serge Semin <fancer.lancer@gmail.com>
> +L:	linux-hwmon@vger.kernel.org
> +S:	Supported
> +F:	Documentation/devicetree/bindings/hwmon/baikal,bt1-pvt.yaml
> +F:	Documentation/hwmon/bt1-pvt.rst
> +F:	drivers/hwmon/bt1-pvt.[ch]
> +
> =C2=A0BARCO P50 GPIO DRIVER
> =C2=A0M:	Santosh Kumar Yadav <santoshkumar.yadav@barco.com>
> =C2=A0M:	Peter Korsgaard <peter.korsgaard@barco.com>
> @@ -6455,6 +6476,7 @@ F:	drivers/mtd/nand/raw/denali*
> =C2=A0
> =C2=A0DESIGNWARE EDMA CORE IP DRIVER
> =C2=A0M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +R:	Serge Semin <fancer.lancer@gmail.com>
> =C2=A0L:	dmaengine@vger.kernel.org
> =C2=A0S:	Maintained
> =C2=A0F:	drivers/dma/dw-edma/
> @@ -9737,6 +9759,14 @@ F:	drivers/gpio/gpiolib-cdev.c
> =C2=A0F:	include/uapi/linux/gpio.h
> =C2=A0F:	tools/gpio/
> =C2=A0
> +GRE DEMULTIPLEXER DRIVER
> +M:	Dmitry Kozlov <xeb@mail.ru>
> +L:	netdev@vger.kernel.org
> +S:	Maintained
> +F:	include/net/gre.h
> +F:	net/ipv4/gre_demux.c
> +F:	net/ipv4/gre_offload.c
> +
> =C2=A0GRETH 10/100/1G Ethernet MAC device driver
> =C2=A0M:	Andreas Larsson <andreas@gaisler.com>
> =C2=A0L:	netdev@vger.kernel.org
> @@ -12929,6 +12959,12 @@ S:	Maintained
> =C2=A0F:	drivers/ata/pata_arasan_cf.c
> =C2=A0F:	include/linux/pata_arasan_cf_data.h
> =C2=A0
> +LIBATA PATA DRIVERS
> +R:	Sergey Shtylyov <s.shtylyov@omp.ru>
> +L:	linux-ide@vger.kernel.org
> +F:	drivers/ata/ata_*.c
> +F:	drivers/ata/pata_*.c
> +
> =C2=A0LIBATA PATA FARADAY FTIDE010 AND GEMINI SATA BRIDGE DRIVERS
> =C2=A0M:	Linus Walleij <linus.walleij@linaro.org>
> =C2=A0L:	linux-ide@vger.kernel.org
> @@ -12945,6 +12981,15 @@ F:	drivers/ata/ahci_platform.c
> =C2=A0F:	drivers/ata/libahci_platform.c
> =C2=A0F:	include/linux/ahci_platform.h
> =C2=A0
> +LIBATA SATA AHCI SYNOPSYS DWC CONTROLLER DRIVER
> +M:	Serge Semin <fancer.lancer@gmail.com>
> +L:	linux-ide@vger.kernel.org
> +S:	Maintained
> +T:	git
> git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata.git
> +F:	Documentation/devicetree/bindings/ata/baikal,bt1-ahci.yaml
> +F:	Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
> +F:	drivers/ata/ahci_dwc.c
> +
> =C2=A0LIBATA SATA PROMISE TX2/TX4 CONTROLLER DRIVER
> =C2=A0M:	Mikael Pettersson <mikpelinux@gmail.com>
> =C2=A0L:	linux-ide@vger.kernel.org
> @@ -14140,6 +14185,16 @@ S:	Maintained
> =C2=A0T:	git git://linuxtv.org/media_tree.git
> =C2=A0F:	drivers/media/platform/nxp/imx-pxp.[ch]
> =C2=A0
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
> =C2=A0MEDIA DRIVERS FOR CXD2099AR CI CONTROLLERS
> =C2=A0M:	Jasmin Jessich <jasmin@anw.at>
> =C2=A0L:	linux-media@vger.kernel.org
> @@ -14148,6 +14203,16 @@ W:	https://linuxtv.org
> =C2=A0T:	git git://linuxtv.org/media_tree.git
> =C2=A0F:	drivers/media/dvb-frontends/cxd2099*
> =C2=A0
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
> =C2=A0MEDIA DRIVERS FOR CXD2880
> =C2=A0M:	Yasunari Takiguchi <Yasunari.Takiguchi@sony.com>
> =C2=A0L:	linux-media@vger.kernel.org
> @@ -14192,6 +14257,35 @@ F:	drivers/media/platform/nxp/imx-mipi-
> csis.c
> =C2=A0F:	drivers/media/platform/nxp/imx7-media-csi.c
> =C2=A0F:	drivers/media/platform/nxp/imx8mq-mipi-csi2.c
> =C2=A0
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
> =C2=A0MEDIA DRIVERS FOR MXL5XX TUNER DEMODULATORS
> =C2=A0L:	linux-media@vger.kernel.org
> =C2=A0S:	Orphan
> @@ -14199,6 +14293,16 @@ W:	https://linuxtv.org
> =C2=A0T:	git git://linuxtv.org/media_tree.git
> =C2=A0F:	drivers/media/dvb-frontends/mxl5xx*
> =C2=A0
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
> =C2=A0MEDIA DRIVERS FOR NVIDIA TEGRA - VDE
> =C2=A0M:	Dmitry Osipenko <digetx@gmail.com>
> =C2=A0L:	linux-media@vger.kernel.org
> @@ -14842,6 +14946,13 @@ F:	drivers/mtd/
> =C2=A0F:	include/linux/mtd/
> =C2=A0F:	include/uapi/mtd/
> =C2=A0
> +MEMSENSING MICROSYSTEMS MSA311 DRIVER
> +M:	Dmitry Rokosov <ddrokosov@sberdevices.ru>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/accel/memsensing,msa31
> 1.yaml
> +F:	drivers/iio/accel/msa311.c
> +
> =C2=A0MEN A21 WATCHDOG DRIVER
> =C2=A0M:	Johannes Thumshirn <morbidrsa@gmail.com>
> =C2=A0L:	linux-watchdog@vger.kernel.org
> @@ -15175,6 +15286,7 @@
> F:	drivers/tty/serial/8250/8250_pci1xxxx.c
> =C2=A0
> =C2=A0MICROCHIP POLARFIRE FPGA DRIVERS
> =C2=A0M:	Conor Dooley <conor.dooley@microchip.com>
> +R:	Vladimir Georgiev <v.georgiev@metrotek.ru>
> =C2=A0L:	linux-fpga@vger.kernel.org
> =C2=A0S:	Supported
> =C2=A0F:	Documentation/devicetree/bindings/fpga/microchip,mpf-spi-
> fpga-mgr.yaml
> @@ -15429,6 +15541,17 @@ F:	arch/mips/
> =C2=A0F:	drivers/platform/mips/
> =C2=A0F:	include/dt-bindings/mips/
> =C2=A0
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
> =C2=A0MIPS BOSTON DEVELOPMENT BOARD
> =C2=A0M:	Paul Burton <paulburton@kernel.org>
> =C2=A0L:	linux-mips@vger.kernel.org
> @@ -15441,6 +15564,7 @@ F:	include/dt-bindings/clock/boston-
> clock.h
> =C2=A0
> =C2=A0MIPS CORE DRIVERS
> =C2=A0M:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> +M:	Serge Semin <fancer.lancer@gmail.com>
> =C2=A0L:	linux-mips@vger.kernel.org
> =C2=A0S:	Supported
> =C2=A0F:	drivers/bus/mips_cdmm.c
> @@ -16408,6 +16532,12 @@ F:	include/linux/ntb.h
> =C2=A0F:	include/linux/ntb_transport.h
> =C2=A0F:	tools/testing/selftests/ntb/
> =C2=A0
> +NTB IDT DRIVER
> +M:	Serge Semin <fancer.lancer@gmail.com>
> +L:	ntb@lists.linux.dev
> +S:	Supported
> +F:	drivers/ntb/hw/idt/
> +
> =C2=A0NTB INTEL DRIVER
> =C2=A0M:	Dave Jiang <dave.jiang@intel.com>
> =C2=A0L:	ntb@lists.linux.dev
> @@ -18428,6 +18558,13 @@ F:	drivers/pps/
> =C2=A0F:	include/linux/pps*.h
> =C2=A0F:	include/uapi/linux/pps.h
> =C2=A0
> +PPTP DRIVER
> +M:	Dmitry Kozlov <xeb@mail.ru>
> +L:	netdev@vger.kernel.org
> +S:	Maintained
> +W:	http://sourceforge.net/projects/accel-pptp
> +F:	drivers/net/ppp/pptp.c
> +
> =C2=A0PRESSURE STALL INFORMATION (PSI)
> =C2=A0M:	Johannes Weiner <hannes@cmpxchg.org>
> =C2=A0M:	Suren Baghdasaryan <surenb@google.com>
> @@ -19518,6 +19655,15 @@ S:	Supported
> =C2=A0F:	Documentation/devicetree/bindings/i2c/renesas,iic-emev2.yaml
> =C2=A0F:	drivers/i2c/busses/i2c-emev2.c
> =C2=A0
> +RENESAS ETHERNET AVB DRIVER
> +R:	Sergey Shtylyov <s.shtylyov@omp.ru>
> +L:	netdev@vger.kernel.org
> +L:	linux-renesas-soc@vger.kernel.org
> +F:	Documentation/devicetree/bindings/net/renesas,etheravb.yaml
> +F:	drivers/net/ethernet/renesas/Kconfig
> +F:	drivers/net/ethernet/renesas/Makefile
> +F:	drivers/net/ethernet/renesas/ravb*
> +
> =C2=A0RENESAS ETHERNET SWITCH DRIVER
> =C2=A0R:	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> =C2=A0L:	netdev@vger.kernel.org
> @@ -19567,6 +19713,14 @@
> F:	Documentation/devicetree/bindings/i2c/renesas,rmobile-iic.yaml
> =C2=A0F:	drivers/i2c/busses/i2c-rcar.c
> =C2=A0F:	drivers/i2c/busses/i2c-sh_mobile.c
> =C2=A0
> +RENESAS R-CAR SATA DRIVER
> +R:	Sergey Shtylyov <s.shtylyov@omp.ru>
> +L:	linux-ide@vger.kernel.org
> +L:	linux-renesas-soc@vger.kernel.org
> +S:	Supported
> +F:	Documentation/devicetree/bindings/ata/renesas,rcar-sata.yaml
> +F:	drivers/ata/sata_rcar.c
> +
> =C2=A0RENESAS R-CAR THERMAL DRIVERS
> =C2=A0M:	Niklas S=C3=B6derlund <niklas.soderlund@ragnatech.se>
> =C2=A0L:	linux-renesas-soc@vger.kernel.org
> @@ -19642,6 +19796,16 @@ S:	Supported
> =C2=A0F:	Documentation/devicetree/bindings/i2c/renesas,rzv2m.yaml
> =C2=A0F:	drivers/i2c/busses/i2c-rzv2m.c
> =C2=A0
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
> =C2=A0RENESAS USB PHY DRIVER
> =C2=A0M:	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> =C2=A0L:	linux-renesas-soc@vger.kernel.org
> @@ -22295,11 +22459,19 @@ F:	drivers/tty/serial/8250/8250_lpss.c
> =C2=A0
> =C2=A0SYNOPSYS DESIGNWARE APB GPIO DRIVER
> =C2=A0M:	Hoan Tran <hoan@os.amperecomputing.com>
> +M:	Serge Semin <fancer.lancer@gmail.com>
> =C2=A0L:	linux-gpio@vger.kernel.org
> =C2=A0S:	Maintained
> =C2=A0F:	Documentation/devicetree/bindings/gpio/snps,dw-apb-gpio.yaml
> =C2=A0F:	drivers/gpio/gpio-dwapb.c
> =C2=A0
> +SYNOPSYS DESIGNWARE APB SSI DRIVER
> +M:	Serge Semin <fancer.lancer@gmail.com>
> +L:	linux-spi@vger.kernel.org
> +S:	Supported
> +F:	Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> +F:	drivers/spi/spi-dw*
> +
> =C2=A0SYNOPSYS DESIGNWARE AXI DMAC DRIVER
> =C2=A0M:	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> =C2=A0S:	Maintained
> @@ -23609,6 +23781,12 @@ L:	linux-input@vger.kernel.org
> =C2=A0S:	Maintained
> =C2=A0F:	drivers/hid/hid-udraw-ps3.c
> =C2=A0
> +UFS FILESYSTEM
> +M:	Evgeniy Dushistov <dushistov@mail.ru>
> +S:	Maintained
> +F:	Documentation/admin-guide/ufs.rst
> +F:	fs/ufs/
> +
> =C2=A0UHID USERSPACE HID IO DRIVER
> =C2=A0M:	David Rheinsberg <david@readahead.eu>
> =C2=A0L:	linux-input@vger.kernel.org


