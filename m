Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830F7563165
	for <lists+dmaengine@lfdr.de>; Fri,  1 Jul 2022 12:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbiGAKbZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 1 Jul 2022 06:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbiGAKbY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 1 Jul 2022 06:31:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E715C76942;
        Fri,  1 Jul 2022 03:31:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 906FEB82F4D;
        Fri,  1 Jul 2022 10:31:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58122C3411E;
        Fri,  1 Jul 2022 10:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656671480;
        bh=PzSQe20vyGgKjj7bh4FY+eUYxZ15YBI0Skb7DjyLz/8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=kwBlRyc/+7zHK/+D1Orop4T33zg2uPrmUjsGkNZAU52FjlKmpsb++xU1wPmV1Sdrw
         k4lB1lGBPqolSXmaVZcNAGFjgST13USJwcNorRHO0OGx/hzi0VABG7ZTo8N7/TuHE2
         HxaECpn986NnZFTn1yzoeBsf+ZI4OSJnoey0UsvUno7oDZ+pMXkeNnXKR1PwQQv7H/
         N9kuWrxo5c2iCitQqKmW068YiY9uPx4FEOea91RPuRZGwW8oY4qU7G4DXYqbe8FC8m
         c/Z3X/cBEeVfPh/ZqshT/s0Jav6xLxcoMGxNTeEs/B5Wuklqf7C6n5RtWyUg6RAJla
         6Gx1v1dJgB63g==
From:   Mark Brown <broonie@kernel.org>
To:     mail@conchuod.ie, palmer@dabbelt.com, palmer@rivosinc.com,
        lgirdwood@gmail.com, thierry.reding@gmail.com,
        fancer.lancer@gmail.com, daniel.lezcano@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        daniel@ffwll.ch, sam@ravnborg.org, vkoul@kernel.org,
        airlied@linux.ie, Eugeniy.Paltsev@synopsys.com
Cc:     conor.dooley@microchip.com, paul.walmsley@sifive.com,
        linux-riscv@lists.infradead.org, linux-spi@vger.kernel.org,
        niklas.cassel@wdc.com, linux-kernel@vger.kernel.org,
        damien.lemoal@opensource.wdc.com, dmaengine@vger.kernel.org,
        aou@eecs.berkeley.edu, joabreu@synopsys.com, tglx@linutronix.de,
        dillon.minfei@gmail.com, alsa-devel@alsa-project.org,
        geert@linux-m68k.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, masahiroy@kernel.org
In-Reply-To: <20220629184343.3438856-1-mail@conchuod.ie>
References: <20220629184343.3438856-1-mail@conchuod.ie>
Subject: Re: (subset) [PATCH v3 00/15] Canaan devicetree fixes
Message-Id: <165667147407.1756128.12037224598634241859.b4-ty@kernel.org>
Date:   Fri, 01 Jul 2022 11:31:14 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, 29 Jun 2022 19:43:29 +0100, Conor Dooley wrote:
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

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[04/15] spi: dt-bindings: dw-apb-ssi: update spi-{r,t}x-bus-width
        commit: 8b037cabc4966b010c44a76e05a43d276318bc49

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
