Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B0A509779
	for <lists+dmaengine@lfdr.de>; Thu, 21 Apr 2022 08:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384805AbiDUG14 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Apr 2022 02:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384803AbiDUG13 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Apr 2022 02:27:29 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0BBBC13EBD;
        Wed, 20 Apr 2022 23:24:40 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 53E33811B;
        Thu, 21 Apr 2022 06:21:49 +0000 (UTC)
Date:   Thu, 21 Apr 2022 09:24:39 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-omap@vger.kernel.org, aaro.koskinen@iki.fi,
        jmkrzyszt@gmail.com, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Paul Walmsley <paul@pwsan.com>,
        Kevin Hilman <khilman@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Mark Brown <broonie@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-input@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-serial@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH 40/41] [TO BE REBASED] ARM: OMAP1: clock: Convert to CCF
Message-ID: <YmD4p+09B/dq54XL@atomide.com>
References: <20220419133723.1394715-1-arnd@kernel.org>
 <20220419133723.1394715-41-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419133723.1394715-41-arnd@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

* Arnd Bergmann <arnd@kernel.org> [220419 13:39]:
> From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> +	/* protect clk->enable_reg from concurrent access via clk_set_rate() */
> +	if (clk->enable_reg == OMAP1_IO_ADDRESS(ARM_CKCTL))
> +		spin_lock_irqsave(&arm_ckctl_lock, flags);
> +	else if (clk->enable_reg == OMAP1_IO_ADDRESS(ARM_IDLECT2))
> +		spin_lock_irqsave(&arm_idlect2_lock, flags);
> +	else if (clk->enable_reg == OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0))
> +		spin_lock_irqsave(&mod_conf_ctrl_0_lock, flags);
> +	else if (clk->enable_reg == OMAP1_IO_ADDRESS(MOD_CONF_CTRL_1))
> +		spin_lock_irqsave(&mod_conf_ctrl_1_lock, flags);
> +	else if (clk->enable_reg == OMAP1_IO_ADDRESS(SWD_CLK_DIV_CTRL_SEL))
> +		spin_lock_irqsave(&swd_clk_div_ctrl_sel_lock, flags);
> +

Eventually there should be just separate clock controller instances for
the clock registers banks, and then this should all disappear as the
lock is instance specific. Anyways, that's probably best done as a separate
changes later on.

Regards,

Tony
