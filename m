Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F711BEB28
	for <lists+dmaengine@lfdr.de>; Thu, 30 Apr 2020 00:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgD2WAS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Apr 2020 18:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726871AbgD2WAS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Apr 2020 18:00:18 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8462CC03C1AE;
        Wed, 29 Apr 2020 15:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SU1lWpCnN4KpLvmDuejl0gdjsgj91EnjRHLqH1AwXoM=; b=J1Foq9OaB+iP4PYEBrX39RUdo
        tJ5tsJ8/9rST4bb7FzV62t+KI4JNsBIjYzvw8juY/7TRNXfOh+TcPTWOMCXKjTPnLyueveQNu94W0
        OthGAP2QVE3xZbSZlzsNdFf3HsnN55X2CQlXD6mCcnMVa3Dze7EsdAVIpExgNhVHMwpCga7xLDGH7
        +AUuXkxpeg7HIapJHUiTSVLBgWxmB/U79IUkOjT+lqInAWQ1sMQash19DdQBJNN7hX81zGwRPuo+3
        +bx9E9ZeZQHPaMFeloKfkyhapBWC8KctXdFN7X+1Zs+gCglwkM6DGzVH+BXV7wE2XT79ZDjtCJO4u
        rLXtBwNvA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54122)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jTukH-0001ra-Vx; Wed, 29 Apr 2020 22:59:58 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jTukF-0001SH-KI; Wed, 29 Apr 2020 22:59:55 +0100
Date:   Wed, 29 Apr 2020 22:59:55 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lad Prabhakar <prabhakar.csengg@gmail.com>,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 04/18] ARM: debug-ll: Add support for r8a7742
Message-ID: <20200429215955.GN1551@shell.armlinux.org.uk>
References: <1588197415-13747-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1588197415-13747-5-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588197415-13747-5-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Apr 29, 2020 at 10:56:41PM +0100, Lad Prabhakar wrote:
> @@ -1701,6 +1709,7 @@ config DEBUG_UART_PHYS
>  	default 0xe6e60000 if DEBUG_RCAR_GEN2_SCIF0
>  	default 0xe6e68000 if DEBUG_RCAR_GEN2_SCIF1
>  	default 0xe6ee0000 if DEBUG_RCAR_GEN2_SCIF4
> +	default 0xe6c60000 if DEBUG_RCAR_GEN2_SCIFA2

Hi,

This is ordered by address.  Please keep it so.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
