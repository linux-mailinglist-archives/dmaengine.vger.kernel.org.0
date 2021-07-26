Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF6403D58EE
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jul 2021 13:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233696AbhGZLRy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 26 Jul 2021 07:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233606AbhGZLRy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 26 Jul 2021 07:17:54 -0400
X-Greylist: delayed 405 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 26 Jul 2021 04:58:22 PDT
Received: from forward105o.mail.yandex.net (forward105o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712E1C061757;
        Mon, 26 Jul 2021 04:58:22 -0700 (PDT)
Received: from iva8-40f91c705526.qloud-c.yandex.net (iva8-40f91c705526.qloud-c.yandex.net [IPv6:2a02:6b8:c0c:b9a7:0:640:40f9:1c70])
        by forward105o.mail.yandex.net (Yandex) with ESMTP id 57BEC4200B66;
        Mon, 26 Jul 2021 14:51:31 +0300 (MSK)
Received: from iva6-2d18925256a6.qloud-c.yandex.net (iva6-2d18925256a6.qloud-c.yandex.net [2a02:6b8:c0c:7594:0:640:2d18:9252])
        by iva8-40f91c705526.qloud-c.yandex.net (mxback/Yandex) with ESMTP id lkre8hYrIW-pTH0Ga7j;
        Mon, 26 Jul 2021 14:51:31 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1627300291;
        bh=syS++HTe1Cfn1grqGafzmOlSb2JtfOhz46f0mgWNJy4=;
        h=Date:Subject:To:From:Message-Id:Cc;
        b=E0wy+n4muSO1ZLMeBWliO0BhcyWs6KoSoeJWdqaCR52kWT6mHi7gxowiUFGY6irYT
         be1AwLTE4dNL+xYTAkyBJYWgCXYptO8V83/LNeZFDp4RbyoGeo2C+M9Dr7oKoKzW4P
         dZKZcvyhEJp7DS7GLat0LUjSneb5gTIb+hVwaHc8=
Authentication-Results: iva8-40f91c705526.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
Received: by iva6-2d18925256a6.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id PIKatQa27D-pR2S8g73;
        Mon, 26 Jul 2021 14:51:28 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Nikita Shubin <nikita.shubin@maquefel.me>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...),
        Andrew Morton <akpm@linux-foundation.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        dmaengine@vger.kernel.org (open list:DMA GENERIC OFFLOAD ENGINE
        SUBSYSTEM), Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        dri-devel@lists.freedesktop.org (open list:FRAMEBUFFER LAYER),
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM PORT),
        linux-fbdev@vger.kernel.org (open list:FRAMEBUFFER LAYER),
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        linux-input@vger.kernel.org (open list:INPUT (KEYBOARD, MOUSE, JOYSTICK
        , TOUCHSCREEN)...), linux-kernel@vger.kernel.org (open list),
        linux-pwm@vger.kernel.org (open list:PWM SUBSYSTEM),
        linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
        Mark Brown <broonie@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, YiFei Zhu <yifeifz2@illinois.edu>
Subject: [PATCH 0/8] arm: ep93xx: CCF conversion
Date:   Mon, 26 Jul 2021 14:50:44 +0300
Message-Id: <20210726115058.23729-1-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This series series of patches converts ep93xx to Common Clock Framework.

It consists of preparation patches to use clk_prepare_enable where it is 
needed, instead of clk_enable used in ep93xx drivers prior to CCF and
a patch converting mach-ep93xx/clock.c to CCF.

Link: https://lore.kernel.org/patchwork/cover/1445563/
Link: https://lore.kernel.org/patchwork/patch/1435884/

Alexander Sverdlin (7):
  iio: ep93xx: Prepare clock before using it
  spi: spi-ep93xx: Prepare clock before using it
  Input: ep93xx_keypad: Prepare clock before using it
  video: ep93xx: Prepare clock before using it
  dmaengine: ep93xx: Prepare clock before using it
  ASoC: cirrus: i2s: Prepare clock before using it
  pwm: ep93xx: Prepare clock before using it

Nikita Shubin (1):
  ep93xx: clock: convert in-place to COMMON_CLK

 arch/arm/Kconfig                       |   2 +-
 arch/arm/mach-ep93xx/clock.c           | 975 ++++++++++++++-----------
 arch/arm/mach-ep93xx/core.c            |   2 +-
 arch/arm/mach-ep93xx/soc.h             |  42 +-
 drivers/dma/ep93xx_dma.c               |   6 +-
 drivers/iio/adc/ep93xx_adc.c           |   6 +-
 drivers/input/keyboard/ep93xx_keypad.c |   4 +-
 drivers/pwm/pwm-ep93xx.c               |  12 +-
 drivers/spi/spi-ep93xx.c               |   4 +-
 drivers/video/fbdev/ep93xx-fb.c        |   4 +-
 sound/soc/cirrus/ep93xx-i2s.c          |  12 +-
 11 files changed, 605 insertions(+), 464 deletions(-)


base-commit: 64376a981a0e2e57c46efa63197c2ebb7dab35df
-- 
2.26.2

