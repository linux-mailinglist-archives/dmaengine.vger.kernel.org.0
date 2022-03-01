Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81CCF4C8864
	for <lists+dmaengine@lfdr.de>; Tue,  1 Mar 2022 10:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbiCAJpO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 1 Mar 2022 04:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233982AbiCAJpF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 1 Mar 2022 04:45:05 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E57B6005C;
        Tue,  1 Mar 2022 01:44:18 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nOz3I-0003z9-00; Tue, 01 Mar 2022 10:44:16 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id A90D6C2860; Tue,  1 Mar 2022 10:09:58 +0100 (CET)
Date:   Tue, 1 Mar 2022 10:09:58 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Paul Cercueil <paul@crapouillou.net>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] MIPS: Remove TX39XX support
Message-ID: <20220301090958.GA6517@alpha.franken.de>
References: <20220222090435.62571-1-tsbogend@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222090435.62571-1-tsbogend@alpha.franken.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Feb 22, 2022 at 10:04:28AM +0100, Thomas Bogendoerfer wrote:
> No (active) developer owns this hardware, so let's remove Linux support.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> ---
>  arch/mips/Kbuild.platforms                    |   1 -
>  arch/mips/Kconfig                             |  24 +-
>  arch/mips/Makefile                            |   1 -
>  arch/mips/configs/jmr3927_defconfig           |  50 ---
>  arch/mips/include/asm/cpu-features.h          |   3 -
>  arch/mips/include/asm/cpu-type.h              |   6 -
>  arch/mips/include/asm/cpu.h                   |   6 -
>  arch/mips/include/asm/isadep.h                |   2 +-
>  .../asm/mach-ath25/cpu-feature-overrides.h    |   1 -
>  .../asm/mach-ath79/cpu-feature-overrides.h    |   1 -
>  .../asm/mach-au1x00/cpu-feature-overrides.h   |   1 -
>  .../asm/mach-bcm47xx/cpu-feature-overrides.h  |   1 -
>  .../cpu-feature-overrides.h                   |   1 -
>  .../asm/mach-cobalt/cpu-feature-overrides.h   |   1 -
>  .../asm/mach-dec/cpu-feature-overrides.h      |   1 -
>  .../asm/mach-ingenic/cpu-feature-overrides.h  |   1 -
>  .../asm/mach-ip27/cpu-feature-overrides.h     |   1 -
>  .../asm/mach-ip30/cpu-feature-overrides.h     |   1 -
>  .../falcon/cpu-feature-overrides.h            |   1 -
>  .../mach-loongson2ef/cpu-feature-overrides.h  |   1 -
>  .../mach-loongson64/cpu-feature-overrides.h   |   1 -
>  .../mt7620/cpu-feature-overrides.h            |   1 -
>  .../mt7621/cpu-feature-overrides.h            |   1 -
>  .../rt288x/cpu-feature-overrides.h            |   1 -
>  .../rt305x/cpu-feature-overrides.h            |   1 -
>  .../rt3883/cpu-feature-overrides.h            |   1 -
>  .../asm/mach-rc32434/cpu-feature-overrides.h  |   1 -
>  arch/mips/include/asm/mach-tx39xx/ioremap.h   |  25 --
>  .../include/asm/mach-tx39xx/mangle-port.h     |  24 -
>  arch/mips/include/asm/mach-tx39xx/spaces.h    |  17 -
>  arch/mips/include/asm/stackframe.h            |   6 +-
>  arch/mips/include/asm/txx9/boards.h           |   3 -
>  arch/mips/include/asm/txx9/jmr3927.h          | 179 --------
>  arch/mips/include/asm/txx9/tx3927.h           | 341 ---------------
>  arch/mips/include/asm/txx9irq.h               |   4 -
>  arch/mips/include/asm/txx9tmr.h               |   4 -
>  arch/mips/include/asm/vermagic.h              |   2 -
>  arch/mips/kernel/Makefile                     |   1 -
>  arch/mips/kernel/cpu-probe.c                  |  23 -
>  arch/mips/kernel/cpu-r3k-probe.c              |  22 -
>  arch/mips/kernel/entry.S                      |   2 +-
>  arch/mips/kernel/genex.S                      |   4 +-
>  arch/mips/kernel/idle.c                       |  10 -
>  arch/mips/kernel/irq_txx9.c                   |  13 -
>  arch/mips/kernel/proc.c                       |   2 -
>  arch/mips/kernel/process.c                    |   2 +-
>  arch/mips/lib/Makefile                        |   1 -
>  arch/mips/lib/r3k_dump_tlb.c                  |   4 -
>  arch/mips/mm/Makefile                         |   1 -
>  arch/mips/mm/c-tx39.c                         | 414 ------------------
>  arch/mips/mm/cache.c                          |   5 -
>  arch/mips/mm/tlb-r3k.c                        |  40 +-
>  arch/mips/pci/Makefile                        |   2 -
>  arch/mips/pci/fixup-jmr3927.c                 |  79 ----
>  arch/mips/pci/ops-tx3927.c                    | 231 ----------
>  arch/mips/txx9/Kconfig                        |  18 -
>  arch/mips/txx9/Makefile                       |   6 -
>  arch/mips/txx9/Platform                       |   3 -
>  arch/mips/txx9/generic/Makefile               |   1 -
>  arch/mips/txx9/generic/irq_tx3927.c           |  25 --
>  arch/mips/txx9/generic/setup.c                |  55 ---
>  arch/mips/txx9/generic/setup_tx3927.c         | 136 ------
>  arch/mips/txx9/jmr3927/Makefile               |   6 -
>  arch/mips/txx9/jmr3927/irq.c                  | 128 ------
>  arch/mips/txx9/jmr3927/prom.c                 |  52 ---
>  arch/mips/txx9/jmr3927/setup.c                | 223 ----------
>  drivers/dma/Kconfig                           |   2 +-
>  drivers/watchdog/Kconfig                      |   2 +-
>  68 files changed, 18 insertions(+), 2212 deletions(-)
>  delete mode 100644 arch/mips/configs/jmr3927_defconfig
>  delete mode 100644 arch/mips/include/asm/mach-tx39xx/ioremap.h
>  delete mode 100644 arch/mips/include/asm/mach-tx39xx/mangle-port.h
>  delete mode 100644 arch/mips/include/asm/mach-tx39xx/spaces.h
>  delete mode 100644 arch/mips/include/asm/txx9/jmr3927.h
>  delete mode 100644 arch/mips/include/asm/txx9/tx3927.h
>  delete mode 100644 arch/mips/mm/c-tx39.c
>  delete mode 100644 arch/mips/pci/fixup-jmr3927.c
>  delete mode 100644 arch/mips/pci/ops-tx3927.c
>  delete mode 100644 arch/mips/txx9/generic/irq_tx3927.c
>  delete mode 100644 arch/mips/txx9/generic/setup_tx3927.c
>  delete mode 100644 arch/mips/txx9/jmr3927/Makefile
>  delete mode 100644 arch/mips/txx9/jmr3927/irq.c
>  delete mode 100644 arch/mips/txx9/jmr3927/prom.c
>  delete mode 100644 arch/mips/txx9/jmr3927/setup.c

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
