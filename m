Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C93050AFC8
	for <lists+dmaengine@lfdr.de>; Fri, 22 Apr 2022 07:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbiDVF6i (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Apr 2022 01:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbiDVF6e (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 22 Apr 2022 01:58:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAA64F9C5;
        Thu, 21 Apr 2022 22:55:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F81161DC9;
        Fri, 22 Apr 2022 05:55:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39416C385A4;
        Fri, 22 Apr 2022 05:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650606942;
        bh=yPcgKn7+VM0lcH+ZbeTVmHNXEMBQkHRpFUGHrVbAfn4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DGjFcWT+dCRf+1Ea0UMpZB3BVhFT/mpAUOufRi+F5d42Ebw210evImcesBdkmAE2y
         CojO/L6OwQvvebeoVE6qvReZ7g9PFW9JuEYpetmtjtso83DunufiLr8qgO9O0+FFpn
         GVMccx8ynEYfHuCvjETmo3HW7xzHr3OoSppx9O2wdR3ZEn7HcEdKmSQap5o8e+7dTD
         jgWGncxQTYOOsaLGuI90Mu9fT+ymfCNsIJoAsUtWTNfNAgWP+0rLmO96CJ3OGjOTNi
         cMc2mOyUFIDdlFfXV8S9TmUlpmywWyXsJfWmlDXPjEEw4JKcA8ShoftvG9yEz9x4qA
         iPnvfq7oG+4Qw==
Date:   Fri, 22 Apr 2022 11:25:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-omap@vger.kernel.org, tony@atomide.com, aaro.koskinen@iki.fi,
        jmkrzyszt@gmail.com, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Paul Walmsley <paul@pwsan.com>,
        Kevin Hilman <khilman@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
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
Subject: Re: [PATCH 20/41] dma: omap: hide legacy interface
Message-ID: <YmJDWYcBN5+MWe91@matsya>
References: <20220419133723.1394715-1-arnd@kernel.org>
 <20220419133723.1394715-21-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419133723.1394715-21-arnd@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 19-04-22, 15:37, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The legacy interface for omap-dma is only used on OMAP1, and the
> same is true for the non-DT case. Make both of these conditional on
> CONFIG_ARCH_OMAP1 being set to simplify the dependency.

Acked-By: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
