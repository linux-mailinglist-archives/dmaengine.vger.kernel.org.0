Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFC33DF7E3
	for <lists+dmaengine@lfdr.de>; Wed,  4 Aug 2021 00:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbhHCWgL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 Aug 2021 18:36:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:53212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231770AbhHCWgL (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 3 Aug 2021 18:36:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D3C4560525;
        Tue,  3 Aug 2021 22:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628030159;
        bh=VLQDPuYtppmqHTWikIAl/LlTeEVdU62YKptNtZBvwDM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XiC4OcyA9vPRScT+26U/MPHk/PLw7cfWKDzQmhm7L/2ifrhJ/zeydraOBFfSielel
         C9CoTPz9m8g5nHPqw5lV3cach9MFKoQo7P1BIrAUEWxt2n34NVbQ8Vq9y9Bk17olEn
         YwLObrlxabk//+7InLHI/JB3MrRVuc6CLmVXUNAItfsddCLQfVMIBm5OTMNUIr0d2j
         6rr6MddHbqKXUpTXihj8VOyu+VpdlXivyHd+uCltwAZVIFEkOJPzox3KYwl2CflZxe
         PtulX27cIMv06Ar6mdPJO8Z5O1byM1L5d1FcFiP35VJWL3P8a4KAnMf4Mgm9Rzd4KU
         G6lou/vcPBEZA==
From:   Mark Brown <broonie@kernel.org>
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Mark Brown <broonie@kernel.org>,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        "open list:INPUT KEYBOARD, MOUSE, JOYSTICK , TOUCHSCREEN..." 
        <linux-input@vger.kernel.org>, YiFei Zhu <yifeifz2@illinois.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>,
        Mike Rapoport <rppt@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
Subject: Re: (subset) [PATCH v2 0/8] arm: ep93xx: CCF conversion
Date:   Tue,  3 Aug 2021 23:35:30 +0100
Message-Id: <162803013703.42391.16928190328940334025.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210726140001.24820-1-nikita.shubin@maquefel.me>
References: <20210726115058.23729-1-nikita.shubin@maquefel.me> <20210726140001.24820-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, 26 Jul 2021 16:59:48 +0300, Nikita Shubin wrote:
> This series series of patches converts ep93xx to Common Clock Framework.
> 
> It consists of preparation patches to use clk_prepare_enable where it is
> needed, instead of clk_enable used in ep93xx drivers prior to CCF and
> a patch converting mach-ep93xx/clock.c to CCF.
> 
> Link: https://lore.kernel.org/patchwork/cover/1445563/
> Link: https://lore.kernel.org/patchwork/patch/1435884/
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[2/8] spi: spi-ep93xx: Prepare clock before using it
      commit: 7c72dc56a631b87043e3c5838f5094db30d8c58d

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
