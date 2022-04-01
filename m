Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09434EF877
	for <lists+dmaengine@lfdr.de>; Fri,  1 Apr 2022 18:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245636AbiDAQ4G (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 1 Apr 2022 12:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349886AbiDAQzc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 1 Apr 2022 12:55:32 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5E924966;
        Fri,  1 Apr 2022 09:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hnfwsLgZVOZIuT10KF5Y8OYWiXObcAHQE/c7M1fjDc0=; b=HcYyiy+58bOxPhq9eI47Tx4i59
        sFiUQBSBqbPaBq4b62MYXvR9ZMNc1DF+F2aVc/N0teqxKpX3wkmMZgqderzDUiVs/YNd/8O2i/l8o
        0qMhyxBxiakSw/uZJp6jfESpENPZ42VPX+gwwqCPPHqtNxADYdnSqPC28wHOABKh3XFHAnKSlHnEf
        +G+cpromG2/59eQrdza4WQ3RfbknpilV5m+nPLHZKsp+WNTd/5NFrtibL2W2lild0ETI6YbTpi/oA
        sq2/yN6KTYDSBg9Vkbredx4xNHlGEkG6Cq+x91FDkgLMdCHNtZLRBaTyK9xXY3ycQdrdijDl1x6ht
        cZFHnk+g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58084)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1naKV6-0006Mv-OR; Fri, 01 Apr 2022 17:51:52 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1naKV1-0000Ms-D9; Fri, 01 Apr 2022 17:51:47 +0100
Date:   Fri, 1 Apr 2022 17:51:47 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     vkoul@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        robh+dt@kernel.org, catalin.marinas@arm.com, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        frieder.schrempf@kontron.de, m.felsch@pengutronix.de,
        l.stach@pengutronix.de, xiaoning.wang@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v15 11/12] dmaengine: imx-sdma: add uart rom script
Message-ID: <Ykcto7pM3xSGRIse@shell.armlinux.org.uk>
References: <1626201709-19643-1-git-send-email-yibin.gong@nxp.com>
 <1626201709-19643-12-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626201709-19643-12-git-send-email-yibin.gong@nxp.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Jul 14, 2021 at 02:41:48AM +0800, Robin Gong wrote:
> For the compatibility of NXP internal legacy kernel before 4.19 which
> is based on uart ram script and upstreaming kernel based on uart rom
> script, add both uart ram/rom script in latest sdma firmware. By default
> uart rom script used.
> Besides, add two multi-fifo scripts for SAI/PDM on i.mx8m/8mm and add
> back qspi script miss for v4(i.mx7d/8m/8mm family, but v3 is for i.mx6).
> 
> rom script:
>         uart_2_mcu_addr
> 	uartsh_2_mcu_addr /* through spba bus */
> am script:
> 	uart_2_mcu_ram_addr
> 	uartsh_2_mcu_ram_addr /* through spba bus */
> 
> Please get latest sdma firmware from the below and put them into the path
> (/lib/firmware/imx/sdma/):
> https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git
> /tree/imx/sdma

Thanks for breaking my platforms when upgrading from 5.13 to 5.16, that
was a really nice experience.

This is _not_ what we do with the Linux kernel. We do not require random
bits of userspace to be upgraded/downgraded in lock-step with the
kernel. There is absolutely no reason for this to happen in this case.

The SDMA firmware is already versioned. You know what version is
present. Randomly renaming stuff in a structure that represents the
contents of firmware like this is just not on.

I know it's taken 9 months to find this, but PLEASE do not ever do this
again, and never think this kind of thing is acceptable. It isn't.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
