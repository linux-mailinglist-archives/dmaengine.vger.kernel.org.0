Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 842994F7BD
	for <lists+dmaengine@lfdr.de>; Sat, 22 Jun 2019 20:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfFVSKn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 22 Jun 2019 14:10:43 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58417 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfFVSKn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 22 Jun 2019 14:10:43 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mol@pengutronix.de>)
        id 1hekT8-0005Xe-EE; Sat, 22 Jun 2019 20:10:30 +0200
Received: from mol by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mol@pengutronix.de>)
        id 1hekT7-0003ug-1g; Sat, 22 Jun 2019 20:10:29 +0200
Date:   Sat, 22 Jun 2019 20:10:29 +0200
From:   Michael Olbrich <m.olbrich@pengutronix.de>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Vinod Koul <vinod.koul@intel.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org
Subject: Re: [BUG] imx-sdma: readl_relaxed_poll_timeout_atomic() conversion
Message-ID: <20190622181029.iy72xkz3xcomwjtl@pengutronix.de>
Mail-Followup-To: Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Lucas Stach <l.stach@pengutronix.de>,
        Vinod Koul <vinod.koul@intel.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org
References: <20190622165318.bgyun52hssqmdv4n@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190622165318.bgyun52hssqmdv4n@shell.armlinux.org.uk>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 19:59:46 up 36 days, 17 min, 59 users,  load average: 0.04, 0.06,
 0.07
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mol@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sat, Jun 22, 2019 at 05:53:18PM +0100, Russell King - ARM Linux admin wrote:
> Old code:
> 
> -       while (!(ret = readl_relaxed(sdma->regs + SDMA_H_INTR) & 1)) {
> -               if (timeout-- <= 0)
> -                       break;
> -               udelay(1);
> -       }
> 
> So, while bit 0 is _clear_ the loop continues to poll.
> 
> 
> New code:
> 
> +       ret = readl_relaxed_poll_timeout_atomic(sdma->regs + SDMA_H_STATSTOP,
> +                                               reg, !(reg & 1), 1, 500);
> 
> Doesn't really tell us what the termination condition is (because of
> the obfuscation taking away the details), but if we dig into the
> macro maze:
> 
> #define readl_relaxed_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
>         readx_poll_timeout_atomic(readl_relaxed, addr, val, cond, delay_us, timeout_us)
> 
> #define readx_poll_timeout_atomic(op, addr, val, cond, delay_us, timeout_us) \
> ({ \
>         u64 __timeout_us = (timeout_us); \
>         unsigned long __delay_us = (delay_us); \
>         ktime_t __timeout = ktime_add_us(ktime_get(), __timeout_us); \
>         for (;;) { \
>                 (val) = op(addr); \
>                 if (cond) \
>                         break; \
> 
> "cond" is passed in to here unmodified, so this becomes:
> 
> 	for (;;) {
> 		reg = readl_relaxed(sdma->regs + SDMA_H_STATSTOP);
> 		if (!(reg & 1))
> 			break;
> 
> So, if bit 0 of this register is clear, we terminate the loop.
> 
> Seems to me like this is a great illustration why using a helper
> _introduces_ bugs, because it hides the detail about what the exit
> condition for the embedded loop actually is, and leads to this kind
> of error.
> 
> In any case, the conversion is obviously incorrect.
> 
> I occasionally see the "Timeout waiting for CH0 ready" error during
> boot on a cbi4, which, given the above, means that we did end up
> seeing bit 1 set (so according to the old code, we waited
> successfully.)

The old code was polling SDMA_H_INTR so it waited for the bit to be set.
The new code (as documented in the commit message) polls SDMA_H_STATSTOP
instead.
I believe this register is called SDMAARM_STOP_STAT in the reference
manual. And the documentation states: "Reading this register yields the
current state of the HE[i] bits".
And from the documentation of the SDMA "DONE" instruction:
"Clear HE bit for the current channel, send an interrupt to the Arm
platform for the current channel and reschedule."

My interpretation of this is, that waiting for the bit in SDMA_H_STATSTOP
to become zero has the same effect as waiting for the bit in SDMA_H_INTR to
be set. Or am I missing something?

Michael

> Looking at the date of the commit, this is almost a three year old
> bug.
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
> According to speedtest.net: 11.9Mbps down 500kbps up
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
