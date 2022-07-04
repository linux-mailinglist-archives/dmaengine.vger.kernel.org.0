Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFC1565A7B
	for <lists+dmaengine@lfdr.de>; Mon,  4 Jul 2022 17:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbiGDP5t (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 4 Jul 2022 11:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234470AbiGDP5t (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 4 Jul 2022 11:57:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B24E03C;
        Mon,  4 Jul 2022 08:57:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFB7A60C02;
        Mon,  4 Jul 2022 15:57:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B532FC3411E;
        Mon,  4 Jul 2022 15:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656950267;
        bh=U8MDGOj5FFXPmmfgfJbJQRYIZ1IcA2PZQe3iwee1+MU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=CPXLe+X/cFRMSPP98YaMuV5SxF1tYOewYdWdS3Z9akQyKIiuD4X14jAUlYmYy5frl
         Y3Ws72Q8d/WckikWAUlbJ4SVBIFZErMmfmvwiHM+lL+7cEj2qf8KKnZpo7iZRshfs9
         ydGuO0wkShAk9EXR7u8hreywhMnhu4gYERfvl+9RBgJeQW2x3wqMKv/koJFrgLtYPW
         9L8RLGgTfk+v0mVf59chXtXh3m3C62obqYBOE69XTK3mevWOZh4CJTSiWz0CgaQ1PH
         0QpB/9GfQeG1V8c+T43I3bYMKInZIYCOoKKRWKDeb2h4h6zh6tEtW0Bop4R8sfvd0x
         itszqJeo+sDgA==
From:   Mark Brown <broonie@kernel.org>
To:     robh+dt@kernel.org, Thierry Reding <thierry.reding@gmail.com>,
        airlied@linux.ie, Eugeniy.Paltsev@synopsys.com,
        krzysztof.kozlowski+dt@linaro.org, sam@ravnborg.org,
        Liam Girdwood <lgirdwood@gmail.com>, daniel@ffwll.ch,
        palmer@dabbelt.com, palmer@rivosinc.com, conor@kernel.org,
        daniel.lezcano@linaro.org, vkoul@kernel.org,
        fancer.lancer@gmail.com
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        dillon.minfei@gmail.com, geert@linux-m68k.org,
        conor.dooley@microchip.com, niklas.cassel@wdc.com,
        alsa-devel@alsa-project.org, dmaengine@vger.kernel.org,
        paul.walmsley@sifive.com, damien.lemoal@opensource.wdc.com,
        joabreu@synopsys.com, aou@eecs.berkeley.edu,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        masahiroy@kernel.org
In-Reply-To: <20220701192300.2293643-1-conor@kernel.org>
References: <20220701192300.2293643-1-conor@kernel.org>
Subject: Re: (subset) [PATCH v4 00/14] Canaan devicetree fixes
Message-Id: <165695026144.481068.15330746749392879216.b4-ty@kernel.org>
Date:   Mon, 04 Jul 2022 16:57:41 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, 1 Jul 2022 20:22:46 +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Hey all,
> This series should rid us of dtbs_check errors for the RISC-V Canaan k210
> based boards. To make keeping it that way a little easier, I changed the
> Canaan devicetree Makefile so that it would build all of the devicetrees
> in the directory if SOC_CANAAN.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[03/14] ASoC: dt-bindings: convert designware-i2s to dt-schema
        commit: bc4c9d85179ca90679c8bb046cf7aad16fb88076

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
