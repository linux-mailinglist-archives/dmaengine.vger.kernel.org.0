Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF75650A85
	for <lists+dmaengine@lfdr.de>; Mon, 24 Jun 2019 14:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfFXMPr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 24 Jun 2019 08:15:47 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:33340 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfFXMPr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 24 Jun 2019 08:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Skz2i2GLxDIs+4Dp5tjr44s+M5OvlNMyQcX73QC/PZs=; b=BzRFADz8EJEfkwk7xXOCAUP0p
        B8gDGknZjR/z6LQLUm+25EIRVSrszt54AW/hrtHQ72pdGNNB+tagPhHc29l8UeBsn+D/PPhsOvnls
        AgdaS7VzK8h5v5ewrplnnu9ANTA2/iTYNl5aPSgJZ28jRUI6kh3z2h9ei60KGuEyym5cYlUv8Yk6M
        dM+EqbBk/fq23JvdSIBFaWxESSEOGuXJTyj8LuwQGIZGVA+p9t2sK04A1sujusUagPT//Ix5RQTIG
        +uAC8R9JTZXqtrjIVUxGrWflKvko6uVfHrwj9jREcqwuCW8Of+YOYoKVC/xqXM+vC54ZxKJbvbpuF
        /JZgsDMqA==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:59026)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hfNso-0007r3-Bf; Mon, 24 Jun 2019 13:15:38 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hfNsj-0006H1-Pv; Mon, 24 Jun 2019 13:15:33 +0100
Date:   Mon, 24 Jun 2019 13:15:33 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Michael Olbrich <m.olbrich@pengutronix.de>,
        Vinod Koul <vinod.koul@intel.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org
Subject: Re: [BUG] imx-sdma: readl_relaxed_poll_timeout_atomic() conversion
Message-ID: <20190624121533.3sd6mmxjfktllp2j@shell.armlinux.org.uk>
References: <20190622165318.bgyun52hssqmdv4n@shell.armlinux.org.uk>
 <20190622181029.iy72xkz3xcomwjtl@pengutronix.de>
 <20190622184237.ld7xwc5kk7sbghae@shell.armlinux.org.uk>
 <1561378450.2587.3.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1561378450.2587.3.camel@pengutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jun 24, 2019 at 02:14:10PM +0200, Lucas Stach wrote:
> Hi Russell,
> 
> Am Samstag, den 22.06.2019, 19:42 +0100 schrieb Russell King - ARM Linux admin:
> > On Sat, Jun 22, 2019 at 08:10:29PM +0200, Michael Olbrich wrote:
> > > On Sat, Jun 22, 2019 at 05:53:18PM +0100, Russell King - ARM Linux admin wrote:
> > > > Old code:
> > > > 
> > > > -       while (!(ret = readl_relaxed(sdma->regs + SDMA_H_INTR) & 1)) {
> > > > -               if (timeout-- <= 0)
> > > > -                       break;
> > > > -               udelay(1);
> > > > -       }
> > > > 
> > > > So, while bit 0 is _clear_ the loop continues to poll.
> > > > 
> > > > 
> > > > New code:
> > > > 
> > > > +       ret = readl_relaxed_poll_timeout_atomic(sdma->regs + SDMA_H_STATSTOP,
> > > > +                                               reg, !(reg & 1), 1, 500);
> > > > 
> > > > Doesn't really tell us what the termination condition is (because of
> > > > the obfuscation taking away the details), but if we dig into the
> > > > macro maze:
> > > > 
> > > > #define readl_relaxed_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
> > > >         readx_poll_timeout_atomic(readl_relaxed, addr, val, cond, delay_us, timeout_us)
> > > > 
> > > > #define readx_poll_timeout_atomic(op, addr, val, cond, delay_us, timeout_us) \
> > > > ({ \
> > > >         u64 __timeout_us = (timeout_us); \
> > > >         unsigned long __delay_us = (delay_us); \
> > > >         ktime_t __timeout = ktime_add_us(ktime_get(), __timeout_us); \
> > > >         for (;;) { \
> > > >                 (val) = op(addr); \
> > > >                 if (cond) \
> > > >                         break; \
> > > > 
> > > > "cond" is passed in to here unmodified, so this becomes:
> > > > 
> > > > 	for (;;) {
> > > > > > > 		reg = readl_relaxed(sdma->regs + SDMA_H_STATSTOP);
> > > > > > > 		if (!(reg & 1))
> > > > > > > 			break;
> > > > 
> > > > So, if bit 0 of this register is clear, we terminate the loop.
> > > > 
> > > > Seems to me like this is a great illustration why using a helper
> > > > _introduces_ bugs, because it hides the detail about what the exit
> > > > condition for the embedded loop actually is, and leads to this kind
> > > > of error.
> > > > 
> > > > In any case, the conversion is obviously incorrect.
> > > > 
> > > > I occasionally see the "Timeout waiting for CH0 ready" error during
> > > > boot on a cbi4, which, given the above, means that we did end up
> > > > seeing bit 1 set (so according to the old code, we waited
> > > > successfully.)
> > > 
> > > The old code was polling SDMA_H_INTR so it waited for the bit to be set.
> > > The new code (as documented in the commit message) polls SDMA_H_STATSTOP
> > > instead.
> > > I believe this register is called SDMAARM_STOP_STAT in the reference
> > > manual. And the documentation states: "Reading this register yields the
> > > current state of the HE[i] bits".
> > > And from the documentation of the SDMA "DONE" instruction:
> > > "Clear HE bit for the current channel, send an interrupt to the Arm
> > > platform for the current channel and reschedule."
> > > 
> > > My interpretation of this is, that waiting for the bit in SDMA_H_STATSTOP
> > > to become zero has the same effect as waiting for the bit in SDMA_H_INTR to
> > > be set. Or am I missing something?
> > 
> > So, why do all my iMX6 platforms now randomly spit out:
> > 
> > "imx-sdma 20ec000.sdma: Timeout waiting for CH0 ready"
> 
> This is due to a DT misconfiguration which was uncovered with a recent
> driver change (25aaa75df1e6 dmaengine: imx-sdma: add clock ratio 1:1
> check) and fixed with (941acd566b18 dmaengine: imx-sdma: Only check
> ratio on parts that support 1:1). Please switch to a recent stable
> kernel, 5.1.5 has the fix included.

Please point to the fix, thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
