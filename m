Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9AE050B25
	for <lists+dmaengine@lfdr.de>; Mon, 24 Jun 2019 14:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfFXMwi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 24 Jun 2019 08:52:38 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37065 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbfFXMwi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 24 Jun 2019 08:52:38 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1hfOSW-0005Os-2s; Mon, 24 Jun 2019 14:52:32 +0200
Message-ID: <1561380750.2587.5.camel@pengutronix.de>
Subject: Re: [BUG] imx-sdma: readl_relaxed_poll_timeout_atomic() conversion
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Michael Olbrich <m.olbrich@pengutronix.de>,
        Vinod Koul <vinod.koul@intel.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org
Date:   Mon, 24 Jun 2019 14:52:30 +0200
In-Reply-To: <20190624121533.3sd6mmxjfktllp2j@shell.armlinux.org.uk>
References: <20190622165318.bgyun52hssqmdv4n@shell.armlinux.org.uk>
         <20190622181029.iy72xkz3xcomwjtl@pengutronix.de>
         <20190622184237.ld7xwc5kk7sbghae@shell.armlinux.org.uk>
         <1561378450.2587.3.camel@pengutronix.de>
         <20190624121533.3sd6mmxjfktllp2j@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Am Montag, den 24.06.2019, 13:15 +0100 schrieb Russell King - ARM Linux admin:
> On Mon, Jun 24, 2019 at 02:14:10PM +0200, Lucas Stach wrote:
> > Hi Russell,
> > 
> > Am Samstag, den 22.06.2019, 19:42 +0100 schrieb Russell King - ARM Linux admin:
> > > On Sat, Jun 22, 2019 at 08:10:29PM +0200, Michael Olbrich wrote:
> > > > On Sat, Jun 22, 2019 at 05:53:18PM +0100, Russell King - ARM Linux admin wrote:
> > > > > Old code:
> > > > > 
> > > > > -       while (!(ret = readl_relaxed(sdma->regs + SDMA_H_INTR) & 1)) {
> > > > > -               if (timeout-- <= 0)
> > > > > -                       break;
> > > > > -               udelay(1);
> > > > > -       }
> > > > > 
> > > > > So, while bit 0 is _clear_ the loop continues to poll.
> > > > > 
> > > > > 
> > > > > New code:
> > > > > 
> > > > > +       ret = readl_relaxed_poll_timeout_atomic(sdma->regs + SDMA_H_STATSTOP,
> > > > > +                                               reg, !(reg & 1), 1, 500);
> > > > > 
> > > > > Doesn't really tell us what the termination condition is (because of
> > > > > the obfuscation taking away the details), but if we dig into the
> > > > > macro maze:
> > > > > 
> > > > > #define readl_relaxed_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
> > > > >         readx_poll_timeout_atomic(readl_relaxed, addr, val, cond, delay_us, timeout_us)
> > > > > 
> > > > > #define readx_poll_timeout_atomic(op, addr, val, cond, delay_us, timeout_us) \
> > > > > ({ \
> > > > >         u64 __timeout_us = (timeout_us); \
> > > > >         unsigned long __delay_us = (delay_us); \
> > > > >         ktime_t __timeout = ktime_add_us(ktime_get(), __timeout_us); \
> > > > >         for (;;) { \
> > > > >                 (val) = op(addr); \
> > > > >                 if (cond) \
> > > > >                         break; \
> > > > > 
> > > > > "cond" is passed in to here unmodified, so this becomes:
> > > > > 
> > > > > 	for (;;) {
> > > > > > > > > > > > > > > > 		reg = readl_relaxed(sdma->regs + SDMA_H_STATSTOP);
> > > > > > > > > > > > > > > > 		if (!(reg & 1))
> > > > > > > > 			break;
> > > > > 
> > > > > So, if bit 0 of this register is clear, we terminate the loop.
> > > > > 
> > > > > Seems to me like this is a great illustration why using a helper
> > > > > _introduces_ bugs, because it hides the detail about what the exit
> > > > > condition for the embedded loop actually is, and leads to this kind
> > > > > of error.
> > > > > 
> > > > > In any case, the conversion is obviously incorrect.
> > > > > 
> > > > > I occasionally see the "Timeout waiting for CH0 ready" error during
> > > > > boot on a cbi4, which, given the above, means that we did end up
> > > > > seeing bit 1 set (so according to the old code, we waited
> > > > > successfully.)
> > > > 
> > > > The old code was polling SDMA_H_INTR so it waited for the bit to be set.
> > > > The new code (as documented in the commit message) polls SDMA_H_STATSTOP
> > > > instead.
> > > > I believe this register is called SDMAARM_STOP_STAT in the reference
> > > > manual. And the documentation states: "Reading this register yields the
> > > > current state of the HE[i] bits".
> > > > And from the documentation of the SDMA "DONE" instruction:
> > > > "Clear HE bit for the current channel, send an interrupt to the Arm
> > > > platform for the current channel and reschedule."
> > > > 
> > > > My interpretation of this is, that waiting for the bit in SDMA_H_STATSTOP
> > > > to become zero has the same effect as waiting for the bit in SDMA_H_INTR to
> > > > be set. Or am I missing something?
> > > 
> > > So, why do all my iMX6 platforms now randomly spit out:
> > > 
> > > "imx-sdma 20ec000.sdma: Timeout waiting for CH0 ready"
> > 
> > This is due to a DT misconfiguration which was uncovered with a recent
> > driver change (25aaa75df1e6 dmaengine: imx-sdma: add clock ratio 1:1
> > check) and fixed with (941acd566b18 dmaengine: imx-sdma: Only check
> > ratio on parts that support 1:1). Please switch to a recent stable
> > kernel, 5.1.5 has the fix included.
> 
> Please point to the fix, thanks.

As I stated above the fix is 941acd566b18 (dmaengine: imx-sdma: Only
check ratio on parts that support 1:1), which is 40aab1990f71 in the
5.1.y stable branch.

Regards,
Lucas
