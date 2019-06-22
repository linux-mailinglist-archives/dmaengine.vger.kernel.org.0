Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF7504F7D1
	for <lists+dmaengine@lfdr.de>; Sat, 22 Jun 2019 20:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbfFVSmt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 22 Jun 2019 14:42:49 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:33580 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfFVSmt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 22 Jun 2019 14:42:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eGtI+SBCNPuMoZ5QNUSXud9bLq8Mn52T/EQZOyRDgEI=; b=JqvR7m3NDnraa4vdiEUFU9xja
        L5KGqkdQjoiDWxCdkcZkjdPLGDXNXQ4DaQddyfO/DCYVkfKbpYDlE2HPdAzcjfMiXoYSqSOIP/PyW
        l4jwgK+a0UuiZvBF6rRLJ5FN7nsKgjIgHIIGOTcvCJiOYClGEYYjPSz0nKJvQ+KETFAbRGnMQYF4z
        waoKPqUgoKb3VxahTy4deZLjM2Q90UrLC0x1XDEm64BY1xDdgT1iaRBtaHUlURS8xqxRpY5Un/ZuC
        ro2/O0iH32xxxtx4EqzzrO3COWLUU7AD15tdBX0IRCYP09H11DnF2Hjt1gpxNru9OEo7EcuwVnb+6
        jpvFRTW2w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59890)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hekyH-0005IY-J2; Sat, 22 Jun 2019 19:42:41 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hekyD-0004Ng-7l; Sat, 22 Jun 2019 19:42:37 +0100
Date:   Sat, 22 Jun 2019 19:42:37 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Michael Olbrich <m.olbrich@pengutronix.de>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Vinod Koul <vinod.koul@intel.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org
Subject: Re: [BUG] imx-sdma: readl_relaxed_poll_timeout_atomic() conversion
Message-ID: <20190622184237.ld7xwc5kk7sbghae@shell.armlinux.org.uk>
References: <20190622165318.bgyun52hssqmdv4n@shell.armlinux.org.uk>
 <20190622181029.iy72xkz3xcomwjtl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190622181029.iy72xkz3xcomwjtl@pengutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sat, Jun 22, 2019 at 08:10:29PM +0200, Michael Olbrich wrote:
> On Sat, Jun 22, 2019 at 05:53:18PM +0100, Russell King - ARM Linux admin wrote:
> > Old code:
> > 
> > -       while (!(ret = readl_relaxed(sdma->regs + SDMA_H_INTR) & 1)) {
> > -               if (timeout-- <= 0)
> > -                       break;
> > -               udelay(1);
> > -       }
> > 
> > So, while bit 0 is _clear_ the loop continues to poll.
> > 
> > 
> > New code:
> > 
> > +       ret = readl_relaxed_poll_timeout_atomic(sdma->regs + SDMA_H_STATSTOP,
> > +                                               reg, !(reg & 1), 1, 500);
> > 
> > Doesn't really tell us what the termination condition is (because of
> > the obfuscation taking away the details), but if we dig into the
> > macro maze:
> > 
> > #define readl_relaxed_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
> >         readx_poll_timeout_atomic(readl_relaxed, addr, val, cond, delay_us, timeout_us)
> > 
> > #define readx_poll_timeout_atomic(op, addr, val, cond, delay_us, timeout_us) \
> > ({ \
> >         u64 __timeout_us = (timeout_us); \
> >         unsigned long __delay_us = (delay_us); \
> >         ktime_t __timeout = ktime_add_us(ktime_get(), __timeout_us); \
> >         for (;;) { \
> >                 (val) = op(addr); \
> >                 if (cond) \
> >                         break; \
> > 
> > "cond" is passed in to here unmodified, so this becomes:
> > 
> > 	for (;;) {
> > 		reg = readl_relaxed(sdma->regs + SDMA_H_STATSTOP);
> > 		if (!(reg & 1))
> > 			break;
> > 
> > So, if bit 0 of this register is clear, we terminate the loop.
> > 
> > Seems to me like this is a great illustration why using a helper
> > _introduces_ bugs, because it hides the detail about what the exit
> > condition for the embedded loop actually is, and leads to this kind
> > of error.
> > 
> > In any case, the conversion is obviously incorrect.
> > 
> > I occasionally see the "Timeout waiting for CH0 ready" error during
> > boot on a cbi4, which, given the above, means that we did end up
> > seeing bit 1 set (so according to the old code, we waited
> > successfully.)
> 
> The old code was polling SDMA_H_INTR so it waited for the bit to be set.
> The new code (as documented in the commit message) polls SDMA_H_STATSTOP
> instead.
> I believe this register is called SDMAARM_STOP_STAT in the reference
> manual. And the documentation states: "Reading this register yields the
> current state of the HE[i] bits".
> And from the documentation of the SDMA "DONE" instruction:
> "Clear HE bit for the current channel, send an interrupt to the Arm
> platform for the current channel and reschedule."
> 
> My interpretation of this is, that waiting for the bit in SDMA_H_STATSTOP
> to become zero has the same effect as waiting for the bit in SDMA_H_INTR to
> be set. Or am I missing something?

So, why do all my iMX6 platforms now randomly spit out:

"imx-sdma 20ec000.sdma: Timeout waiting for CH0 ready"

at boot, whereas they didn't used to with older kernels?  Maybe channel
0 does not clear the HE[0] bit?

The documentation explicitly states that for initialisation, the
following is required:

• Set bit 0 of the SDMA_HSTART register to set HE[0] and allow Channel 0
  to run (assumes EO[0] and DO[0] were both set in previous step). This
  will cause SDMA toload the program RAM and channel contexts configured
  previously.
• Wait for Channel 0 to finish running. This is indicated by HI[0]=1 in
  the SDMA_SDMA_INTR register, or by optional interrupt to the ARM platform.

So, is there a way for a HI bit to be set without clearing the HE bit?
Yes, via the NOTIFY command:

55.5.2.35 NOTIFY (Notify to ARM platform)
Operation:
if (jjj & 4 == 0)
{
  if (jjj&2 == 2)
    HE[CCR] ← 0
  if (jjj&1== 1)
    HI[CCR] ← 1
}
else if (jjj == 4)
  EP[CCR] ← 0
else

So, if jjj is 001 binary, the HE bit can remain set while the HI bit
is cleared.  Maybe the firmware uses this rather than a DONE instruction
when performing the initialisation functions, which means your idea of
going against what is specified in the manual, and using HE[0] instead
of HI[0] is on _very_ shakey ground.

Given that I'm seeing the same issue on _four_ iMX6 platforms here,
I think it's pretty much obvious that your assumptions here are
false.
 
> Michael
> 
> > Looking at the date of the commit, this is almost a three year old
> > bug.
> > 
> > -- 
> > RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> > FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
> > According to speedtest.net: 11.9Mbps down 500kbps up
> > 
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
