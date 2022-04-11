Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD054FB46F
	for <lists+dmaengine@lfdr.de>; Mon, 11 Apr 2022 09:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244947AbiDKHT2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Apr 2022 03:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242735AbiDKHT1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Apr 2022 03:19:27 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5271321260;
        Mon, 11 Apr 2022 00:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5hihIePquetd4aWy3suo+aDqVPEvM45LHw98QVseVOA=; b=kXva0I5Hl4bc7vM3Sd99eZmDic
        2+SUbsJm1znky37gaD/KD9LJRBfkdLJ0uOabAsnZ4CpPESO/sQ7jrbR4Fl6YJXC+dLuLwek6iU8j4
        2tUMbaoaizmVJZi1nsJrWd75I6kroOznRW+jQP+6mn2LNGKlwmAhyYK5lKa5OyxJtldPFyxuwC9Ep
        42Wxl0Ot+KpfHPNpfYPLEdj8CUF8TWc+G1MtEAbCFaujXsa29jU59X0fMkhYp0kUzPd9ucj1tCIfv
        aPi5UvAvCxSqPSDKv53Ok03FC+MnuxNh3sD9Nx/rR523y/41+mPoop/Zzk08qFreLAMxQ3G2Sdarz
        /UsPW6RQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58200)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1ndoIH-0008VM-Qa; Mon, 11 Apr 2022 08:17:01 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1ndoIF-0001E9-8a; Mon, 11 Apr 2022 08:16:59 +0100
Date:   Mon, 11 Apr 2022 08:16:59 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kevin Groeneveld <kgroeneveld@lenbrook.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Robin Gong <yibin.gong@nxp.com>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: imx-sdma: fix regression with uart scripts
Message-ID: <YlPV6ywRITfNigE1@shell.armlinux.org.uk>
References: <20220406224809.29197-1-kgroeneveld@lenbrook.com>
 <YlBzQpWEqMHz/HsU@matsya>
 <3b26a4e2-93a8-8b3f-20c3-c1593ea0d48b@lenbrook.com>
 <YlPDu3lu0rHJztNQ@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlPDu3lu0rHJztNQ@matsya>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Apr 11, 2022 at 11:29:23AM +0530, Vinod Koul wrote:
> Hi Kevin,
> 
> On 10-04-22, 18:28, Kevin Groeneveld wrote:
> > On 2022-04-08 13:39, Vinod Koul wrote:
> > > 1. Patch title should reflect the change introduced, so the title is not
> > > apt, pls revise
> > 
> > In hindsight the title was not very descriptive. I will update and send a
> > v2. Maybe something like:
> > 
> > dmaengine: imx-sdma: fix init of uart scripts
> > 
> > > 2. Is this in response to rmk's report, if so, please add reported-by
> > 
> > No. I am not even aware of any report on this issue. I discovered the issue
> > on my own and found the problem commit by doing a bisect.
> 
> Okay I am adding Russell here to see if this fixes his issue as well..

I "fixed" my issue by updating my SDMA firmware to the later version,
which I think is fine provided I don't down-grade the kernel.

That said, I do support this attempt to fix NXP's cockup, so, having
looked at the patch:

Acked-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
