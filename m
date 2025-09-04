Return-Path: <dmaengine+bounces-6378-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3493B43913
	for <lists+dmaengine@lfdr.de>; Thu,  4 Sep 2025 12:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6D1E5664AE
	for <lists+dmaengine@lfdr.de>; Thu,  4 Sep 2025 10:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DF32FC002;
	Thu,  4 Sep 2025 10:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p6tDNKi6"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64A42EDD7D
	for <dmaengine@vger.kernel.org>; Thu,  4 Sep 2025 10:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756982559; cv=none; b=hD6VsfqfsjMH9H88epmb6efaUxv7AW8HHCru7l+OmLiJEJPmYUgpWDkA7Uhjazz7EyxUIXSUIcza2oe7glzW5LXn3d6i6Xuupwjb2p1SzBVwhgo6ulfO+vw1PYgTEGT6vt8f/5l8Ak6ZOm1IJzaOig2eBmkAscCTv0rCA/cEZlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756982559; c=relaxed/simple;
	bh=iNJ4FeVeT7B6e+//AQVG1salcqyAcnoFzo0f2zbeifg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q+dwT/ZFJNrW7/dWcHxnk0YL64zqCVElY9gO0EtJi4H/zoqPmve8xZTjMjFZSjfYtBxoiban2ws4CWHlnwCXlR9cdOhOA9CYKEzi1SjyaDRAVw8IMUOPEQOnUaSmVokn1y8AEEToTFb8wbsoZ10lvqjzCal378fw4Pf6Vsb6xLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p6tDNKi6; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e970e624b7cso1698673276.0
        for <dmaengine@vger.kernel.org>; Thu, 04 Sep 2025 03:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756982555; x=1757587355; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3IXOKsIqYkTA4LRuIysZBK9RbBlxCbzGVz/R04fan+Q=;
        b=p6tDNKi69Yb08qECMOlPAcDxB77f+UgH/9tA6Z+OaH+0w+86QaK3bEFSc3sgjZdUPU
         jlmKA0oQkw3Mcu7l4+jmKbokfc9QzmabR435uxb3lfsSMZmjTHSEqujeFhjZ9PAgA/yc
         QtMDvUOm+UDI5qmGiTJZ1vnJBHFWCZz24e8tyQXFZTLwQ/Iof9/lNWBmZGkV9hV4RwkK
         9BY+PchKKit2hbeL8zRTWyZOPtCMfw+4OuixvNO8VFdxTI+0OSkfePsGS1BiZg+4XBbq
         ZXMlNkDCfeBK5OxIvrJtisAMkMGsbIrLVzkxJa8MYYMXIDwB6rb3DMvSCDRinQiiGdbT
         PRSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756982555; x=1757587355;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3IXOKsIqYkTA4LRuIysZBK9RbBlxCbzGVz/R04fan+Q=;
        b=fKUPqBlY6FP3bIzftISZTS0NR4BaSdDf5hkPmx+pFX41f+bPzbo7MYIitIqqmXsXzz
         mfDDmuGF1pnFobL3eRlU5tyBHN2LwjLkScDRCwhVwVCy48G5Idio85n+T0uV3WR5DRzE
         VhJ3Oe0EwsdhZsK7311xuoruaUeQC6E2SzywAPyC6VlYnYzLLFzDG9H72T8dOU44NffV
         N98Hsu2r6dHeViiIof3vsy24orua6/XeFOfTQY9bNigmjpvTZ0BdqiGOWAnVHBboFc0B
         eLjFtrsZRurC27M+hQxaLuLBtzPnn+cGtglQ5OWpysgQY8q82r+diW1cLLgkMNDM+Yy9
         AHMA==
X-Forwarded-Encrypted: i=1; AJvYcCW4QjdbXWaam9Z2xA14Vzb0Dmi+zNfw64LX2fSiy0bnHnxq6cBOQXSMtXr6QN43E6EjXFytX+qTNu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgQ4mT+FLefOhnQDyqNbg/vD7530susKE1o1FrFDYCHPEKXNS6
	FwYHhpW1025c7H8XjwF0l5ykGaXliTorI0SdK5qZ5kD292GcLNXP+E6GF+RAzk3lCuFqVFz4Zd6
	HLW2zClqxzzNGJFjUNlBbQvFyeiKbZ2eBZ1W1rxOlGw==
X-Gm-Gg: ASbGncv50aV1RdvZCFUlMSAFxIoA8P0ArDwccldXI/JBDUpWDior0oYvz2aaFlXllco
	nu4ceLK/5dfWKc3K+1IP/EXVGgvSWeaozhv8qGhVt20J5Iz+1hyw9zXvjd9KZu5DoXeodKG0/AB
	/hm6+QW0hi61cHgVzu7XNdvyhnDTET4tHdlJaVFcVn3hzc84bLXvqFiHBRYpJmYG/VK/rBHjjGG
	gVXV/HKPR540dhNTHo=
X-Google-Smtp-Source: AGHT+IEeSGB7E+U5AfztCn/a0prTDkWoIwMcrRTgDGYjoK5cQKuLypMWypNuVlG8aGFMELgSR6JxD1pZQxnU/zZ73ew=
X-Received: by 2002:a53:a106:0:b0:5f3:317e:40a8 with SMTP id
 956f58d0204a3-6014a94e9c5mr1611129d50.12.1756982554409; Thu, 04 Sep 2025
 03:42:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828-dt-apple-t6020-v1-0-507ba4c4b98e@jannau.net>
In-Reply-To: <20250828-dt-apple-t6020-v1-0-507ba4c4b98e@jannau.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 4 Sep 2025 12:41:58 +0200
X-Gm-Features: Ac12FXza5NBe8gQAzu9NnR9-urtLUV1_9O5Z3gtqmfhrws2_iw3qa7_NAVfym40
Message-ID: <CAPDyKFr3WO5nLXYWoyH13KirmfNU+sVrvhefuwC+GrpAgynBgQ@mail.gmail.com>
Subject: Re: [PATCH 00/37] arm64: Add initial device trees for Apple M2
 Pro/Max/Ultra devices
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Hector Martin <marcan@marcan.st>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Mark Kettenis <kettenis@openbsd.org>, 
	Andi Shyti <andi.shyti@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Sasha Finkelstein <fnkl.kernel@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Johannes Berg <johannes@sipsolutions.net>, 
	van Spriel <arend@broadcom.com>, Lee Jones <lee@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, Michael Turquette <mturquette@baylibre.com>, 
	=?UTF-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>, 
	Vinod Koul <vkoul@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, iommu@lists.linux.dev, 
	linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-bluetooth@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, linux-clk@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Aug 2025 at 16:01, Janne Grunau <j@jannau.net> wrote:
>
> This series adds device trees for Apple's M2 Pro, Max and Ultra based
> devices. The M2 Pro (t6020), M2 Max (t6021) and M2 Ultra (t6022) SoCs
> follow design of the t600x family so copy the structure of SoC *.dtsi
> files.
>
> t6020 is a cut-down version of t6021, so the former just includes the
> latter and disables the missing bits.
>
> t6022 is two connected t6021 dies. The implementation seems to use
> t6021 and disables blocks based on whether it is useful to carry
> multiple instances. The disabled blocks are mostly on the second die.
> MMIO addresses on the second die have a constant offset. The interrupt
> controller is multi-die aware. This setup can be represented in the
> device tree with two top level "soc" nodes. The MMIO offset is applied
> via "ranges" and devices are included with preprocessor macros to make
> the node labels unique and to specify the die number for the interrupt
> definition.
>
> The devices itself are very similar to their M1 Pro, M1 Max and M1 Ultra
> counterparts. The existing device templates are SoC agnostic so the new
> devices can reuse them and include their t602{0,1,2}.dtsi file. The
> minor differences in pinctrl and gpio numbers can be easily adjusted.
>
> With the t602x SoC family Apple introduced two new devices:
>
> The M2 Pro Mac mini is similar to the larger M1 and M2 Max Mac Studio. The
> missing SDHCI card reader and two front USB3.1 type-c ports and their
> internal USB hub can be easily deleted.
>
> The M2 Ultra Mac Pro (tower and rack-mount cases) differs from all other
> devices but may share some bits with the M2 Ultra Mac Studio. The PCIe
> implementation on the M2 Ultra in the Mac Pro differs slightly. Apple
> calls the PCIe controller "apcie-ge" in their device tree. The
> implementation seems to be mostly compatible with the base t6020 PCIe
> controller. The main difference is that there is only a single port with
> with 8 or 16 PCIe Gen4 lanes. These ports connect to a Microchip
> Switchtec PCIe switch with 100 lanes to which all internal PCIe devices
> and PCIe slots connect too.
>
> This series does not include PCIe support for the Mac Pro for two
> reasons:
> - the linux switchtec driver fails to probe and the downstream PCIe
>   connections come up as PCIe Gen1
> - some of the internal devices require PERST# and power control to come
>   up. Since the device are connected via the PCIe switch the PCIe
>   controller can not do this. The PCI slot pwrctrl can be utilized for
>   power control but misses integration with PERST# as proposed in [1].
>
> This series depends on "[PATCH v2 0/5] Apple device tree sync from
> downstream kernel" [2] due to the reuse of the t600x device templates
> (patch dependencies and DT compilation) and 4 page table level support
> in apple-dart and io-pgtable-dart [3] since the dart instances report
> 42-bit IAS (IOMMU device attach fails without the series).
>
> After discussion with the devicetree maintainers we agreed to not extend
> lists with the generic compatibles anymore [1]. Instead either the first
> compatible SoC or t8103 is used as fallback compatible supported by the
> drivers. t8103 is used as default since most drivers and bindings were
> initially written for M1 based devices.
>
> The series adds those fallback compatibles to drivers where necessary,
> annotates the SoC lists for generic compatibles as "do not extend" and
> adds t6020 per-SoC compatibles.
>
> [1]: https://lore.kernel.org/linux-pci/20250819-pci-pwrctrl-perst-v1-0-4b74978d2007@oss.qualcomm.com/
> [2]: https://lore.kernel.org/asahi/20250823-apple-dt-sync-6-17-v2-0-6dc0daeb4786@jannau.net/
> [3]: https://lore.kernel.org/asahi/20250821-apple-dart-4levels-v2-0-e39af79daa37@jannau.net/
> [4]: https://lore.kernel.org/asahi/12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@kernel.org/
>
> Signed-off-by: Janne Grunau <j@jannau.net>

Is it okay for me to pick up the pmdomain patches (patch3 and patch4)
by now - or what route are you planning to get this merged through?

Kind regards
Uffe

> ---
> Hector Martin (3):
>       arm64: dts: apple: Add initial t6020/t6021/t6022 DTs
>       arm64: dts: apple: Add J414 and J416 Macbook Pro device trees
>       arm64: dts: apple: Add J180d (Mac Pro, M2 Ultra, 2023) device tree
>
> Janne Grunau (34):
>       dt-bindings: arm: apple: Add t6020x compatibles
>       dt-bindings: arm: apple: apple,pmgr: Add t6020-pmgr compatible
>       pmdomain: apple: Add "apple,t8103-pmgr-pwrstate"
>       dt-bindings: power: apple,pmgr-pwrstate: Add t6020 compatible
>       dt-bindings: cpufreq: apple,cluster-cpufreq: Add t6020 compatible
>       dt-bindings: interrupt-controller: apple,aic2: Add apple,t6020-aic compatible
>       dt-bindings: iommu: dart: Add apple,t6020-dart compatible
>       pinctrl: apple: Add "apple,t8103-pinctrl" as compatible
>       dt-bindings: pinctrl: apple,pinctrl: Add apple,t6020-pinctrl compatible
>       dt-bindings: i2c: apple,i2c: Add apple,t6020-i2c compatible
>       dt-bindings: mailbox: apple,mailbox: Add t6020 compatible
>       dt-bindings: gpu: apple,agx: Add agx-{g14s,g14c,g14d} compatibles
>       dt-bindings: iommu: apple,sart: Add apple,t6020-sart compatible
>       nvme-apple: Add "apple,t8103-nvme-ans2" as compatible
>       dt-bindings: nvme: apple: Add apple,t6020-nvme-ans2 compatible
>       dt-bindings: net: bcm4377-bluetooth: Add BCM4388 compatible
>       dt-bindings: net: bcm4329-fmac: Add BCM4388 PCI compatible
>       mfd: macsmc: Add "apple,t8103-smc" compatible
>       dt-bindings: mfd: apple,smc: Add t6020-smc compatible
>       dt-bindings: pwm: apple,s5l-fpwm: Add t6020-fpwm compatible
>       spmi: apple: Add "apple,t8103-spmi" compatible
>       dt-bindings: spmi: apple,spmi: Add t6020-spmi compatible
>       watchdog: apple: Add "apple,t8103-wdt" compatible
>       dt-bindings: watchdog: apple,wdt: Add t6020-wdt compatible
>       clk: clk-apple-nco: Add "apple,t8103-nco" compatible
>       dt-bindings: clock: apple,nco: Add t6020-nco compatible
>       dmaengine: apple-admac: Add "apple,t8103-admac" compatible
>       dt-bindings: dma: apple,admac: Add t6020-admac compatible
>       ASoC: apple: mca: Add "apple,t8103-mca" compatible
>       ASoC: dt-bindings: apple,mca: Add t6020-mca compatible
>       spi: apple: Add "apple,t8103-spi" compatible
>       spi: dt-bindings: apple,spi: Add t6020-spi compatible
>       arm64: dts: apple: Add ethernet0 alias for J375 template
>       arm64: dts: apple: Add J474s, J475c and J475d device trees
>
>  Documentation/devicetree/bindings/arm/apple.yaml   |   39 +-
>  .../devicetree/bindings/arm/apple/apple,pmgr.yaml  |   33 +-
>  .../devicetree/bindings/clock/apple,nco.yaml       |   17 +-
>  .../bindings/cpufreq/apple,cluster-cpufreq.yaml    |    3 +
>  .../devicetree/bindings/dma/apple,admac.yaml       |   17 +-
>  .../devicetree/bindings/gpu/apple,agx.yaml         |    6 +
>  .../devicetree/bindings/i2c/apple,i2c.yaml         |   27 +-
>  .../bindings/interrupt-controller/apple,aic2.yaml  |    1 +
>  .../devicetree/bindings/iommu/apple,dart.yaml      |   14 +-
>  .../devicetree/bindings/iommu/apple,sart.yaml      |    4 +-
>  .../devicetree/bindings/mailbox/apple,mailbox.yaml |    1 +
>  .../devicetree/bindings/mfd/apple,smc.yaml         |   17 +-
>  .../net/bluetooth/brcm,bcm4377-bluetooth.yaml      |    1 +
>  .../bindings/net/wireless/brcm,bcm4329-fmac.yaml   |    1 +
>  .../devicetree/bindings/nvme/apple,nvme-ans.yaml   |   29 +-
>  .../devicetree/bindings/pinctrl/apple,pinctrl.yaml |   27 +-
>  .../bindings/power/apple,pmgr-pwrstate.yaml        |   27 +-
>  .../devicetree/bindings/pwm/apple,s5l-fpwm.yaml    |    3 +-
>  .../devicetree/bindings/sound/apple,mca.yaml       |   17 +-
>  .../devicetree/bindings/spi/apple,spi.yaml         |   16 +-
>  .../devicetree/bindings/spmi/apple,spmi.yaml       |   17 +-
>  .../devicetree/bindings/watchdog/apple,wdt.yaml    |   27 +-
>  arch/arm64/boot/dts/apple/Makefile                 |    8 +
>  arch/arm64/boot/dts/apple/t600x-j375.dtsi          |    1 +
>  arch/arm64/boot/dts/apple/t6020-j414s.dts          |   26 +
>  arch/arm64/boot/dts/apple/t6020-j416s.dts          |   26 +
>  arch/arm64/boot/dts/apple/t6020-j474s.dts          |   47 +
>  arch/arm64/boot/dts/apple/t6020.dtsi               |   22 +
>  arch/arm64/boot/dts/apple/t6021-j414c.dts          |   26 +
>  arch/arm64/boot/dts/apple/t6021-j416c.dts          |   26 +
>  arch/arm64/boot/dts/apple/t6021-j475c.dts          |   37 +
>  arch/arm64/boot/dts/apple/t6021.dtsi               |   69 +
>  arch/arm64/boot/dts/apple/t6022-j180d.dts          |  121 ++
>  arch/arm64/boot/dts/apple/t6022-j475d.dts          |   42 +
>  arch/arm64/boot/dts/apple/t6022-jxxxd.dtsi         |   38 +
>  arch/arm64/boot/dts/apple/t6022.dtsi               |  347 +++
>  arch/arm64/boot/dts/apple/t602x-common.dtsi        |  465 ++++
>  arch/arm64/boot/dts/apple/t602x-die0.dtsi          |  577 +++++
>  arch/arm64/boot/dts/apple/t602x-dieX.dtsi          |  129 ++
>  arch/arm64/boot/dts/apple/t602x-gpio-pins.dtsi     |   81 +
>  arch/arm64/boot/dts/apple/t602x-j414-j416.dtsi     |   45 +
>  arch/arm64/boot/dts/apple/t602x-j474-j475.dtsi     |   38 +
>  arch/arm64/boot/dts/apple/t602x-nvme.dtsi          |   42 +
>  arch/arm64/boot/dts/apple/t602x-pmgr.dtsi          | 2268 ++++++++++++++++++++
>  drivers/clk/clk-apple-nco.c                        |    1 +
>  drivers/dma/apple-admac.c                          |    1 +
>  drivers/mfd/macsmc.c                               |    1 +
>  drivers/nvme/host/apple.c                          |    1 +
>  drivers/pinctrl/pinctrl-apple-gpio.c               |    1 +
>  drivers/pmdomain/apple/pmgr-pwrstate.c             |    1 +
>  drivers/spi/spi-apple.c                            |    1 +
>  drivers/spmi/spmi-apple-controller.c               |    1 +
>  drivers/watchdog/apple_wdt.c                       |    1 +
>  sound/soc/apple/mca.c                              |    1 +
>  54 files changed, 4722 insertions(+), 113 deletions(-)
> ---
> base-commit: 50ee15a27ec4cc41e99ee5e9011de7875569cd52
> change-id: 20250811-dt-apple-t6020-1359ce9bf2e7
> prerequisite-change-id: 20250813-apple-dt-sync-6-17-d1fc1c89f7ca:v2
> prerequisite-patch-id: 1405c7c78139704a4cbeb1adc67786b2c7971a3f
> prerequisite-patch-id: 65865050e9e7427bac04f47d0b7927aacaac19bd
> prerequisite-patch-id: 9240e5f435fb3406e77b4e4e9b02eb3d52e660e6
> prerequisite-patch-id: c16715c9a9fcb396b7e4365fd767b05604b8de81
> prerequisite-patch-id: a675ad20c2b427a021dafb5d6c8716497741604c
>
> Best regards,
> --
> Janne Grunau <j@jannau.net>
>

