Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D99D077638
	for <lists+dmaengine@lfdr.de>; Sat, 27 Jul 2019 05:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbfG0DUS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 Jul 2019 23:20:18 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:46860 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfG0DUS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 26 Jul 2019 23:20:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1564197613; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KYjAC67ZYcDwtcnIBpp0BzLOMVIg3F/G58/tAsJimxs=;
        b=ORUDr6CuY7vpgmdik7Ldm16UXWRFBr6Ee4ABQbj6tTfLvxBPwmhKA6bLpfcQxX+exzomjP
        TDrZy1fzdFeQCmOXR6cIQOjxRV8Q06DX/kYE2jocswD/4JlyOxJP5kSuaV94FjAfM/JVnu
        CJlyiJfb7/kikgxqr4FsYUPCYzzFns0=
Date:   Fri, 26 Jul 2019 23:19:45 -0400
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 00/11] JZ4740 SoC cleanup
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Sebastian Reichel <sre@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-pm@vger.kernel.org,
        linux-mips@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, od@zcrc.me,
        linux-mtd@lists.infradead.org, dmaengine@vger.kernel.org
Message-Id: <1564197585.6472.0@crapouillou.net>
In-Reply-To: <20190726184649.GC14981@ravnborg.org>
References: <20190725220215.460-1-paul@crapouillou.net>
        <20190726184649.GC14981@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



Le ven. 26 juil. 2019 =E0 14:46, Sam Ravnborg <sam@ravnborg.org> a=20
=E9crit :
> Hi Paul.
>=20
> On Thu, Jul 25, 2019 at 06:02:04PM -0400, Paul Cercueil wrote:
>>  Hi,
>>=20
>>  This patchset converts the Qi LB60 MIPS board to devicetree and=20
>> makes it
>>  use all the shiny new drivers that have been developed or updated
>>  recently.
>>=20
>>  All the crappy old drivers and custom code can be dropped since they
>>  have been replaced by better alternatives.
>=20
> The overall diffstat is missing.
> Just for curiosity it would be nice to see what was dropped with this
> patch.
>=20
> 	Sam

Diffstat:

 arch/mips/boot/dts/ingenic/jz4740.dtsi         |  84 ++++++++++++
 arch/mips/boot/dts/ingenic/qi_lb60.dts         | 295=20
++++++++++++++++++++++++++++++++++++++++-
 arch/mips/configs/qi_lb60_defconfig            |  44 +++---
 arch/mips/include/asm/mach-jz4740/gpio.h       |  15 ---
 arch/mips/include/asm/mach-jz4740/jz4740_fb.h  |  58 --------
 arch/mips/include/asm/mach-jz4740/jz4740_mmc.h |  12 --
 arch/mips/include/asm/mach-jz4740/platform.h   |  26 ----
 arch/mips/jz4740/Makefile                      |   7 +-
 arch/mips/jz4740/board-qi_lb60.c               | 491=20
-------------------------------------------------------------------
 arch/mips/jz4740/platform.c                    | 250=20
-----------------------------------
 arch/mips/jz4740/prom.c                        |   5 -
 arch/mips/jz4740/setup.c                       |   3 +-
 drivers/dma/Kconfig                            |   6 -
 drivers/dma/Makefile                           |   1 -
 drivers/dma/dma-jz4740.c                       | 623=20
---------------------------------------------------------------------------=
----------
 drivers/hwmon/Kconfig                          |  10 --
 drivers/hwmon/Makefile                         |   1 -
 drivers/hwmon/jz4740-hwmon.c                   | 135=20
-------------------
 drivers/mfd/Kconfig                            |   9 --
 drivers/mfd/Makefile                           |   1 -
 drivers/mfd/jz4740-adc.c                       | 324=20
---------------------------------------------
 drivers/mtd/nand/raw/ingenic/Kconfig           |   7 -
 drivers/mtd/nand/raw/ingenic/Makefile          |   1 -
 drivers/mtd/nand/raw/ingenic/jz4740_nand.c     | 536=20
--------------------------------------------------------------------------
 drivers/power/supply/Kconfig                   |  11 --
 drivers/power/supply/Makefile                  |   1 -
 drivers/power/supply/jz4740-battery.c          | 421=20
----------------------------------------------------------
 drivers/video/fbdev/Kconfig                    |   9 --
 drivers/video/fbdev/Makefile                   |   1 -
 drivers/video/fbdev/jz4740_fb.c                | 690=20
---------------------------------------------------------------------------=
--------------------
 sound/soc/jz4740/Kconfig                       |  25 +---
 sound/soc/jz4740/Makefile                      |   5 -
 sound/soc/jz4740/qi_lb60.c                     | 106 ---------------
 33 files changed, 404 insertions(+), 3809 deletions(-)


=

