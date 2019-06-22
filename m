Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2688C4F731
	for <lists+dmaengine@lfdr.de>; Sat, 22 Jun 2019 18:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfFVQxb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 22 Jun 2019 12:53:31 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60608 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfFVQxb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 22 Jun 2019 12:53:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YMJLmdjWBuv/yw6DcravhU1VRfVOOsawxx5cM1gsR5Y=; b=udlqmBUbT5CzJluTKRDU8TmZ/
        /1sDXni4Iht4l3th3xcfOluVl8vXrmlpUV6P7r07+hTOCchd9SuHY+zUvsb6WY7JmvnGWooxG6FCc
        iymaBocObHTI5VfxzlVlpaXWEl0xZDI8b8qisF+SQdPvQ5C2nhNWIWgMwKeDcGhSyoF2RuKONclxK
        25CL5u1C520cBg453QiClxOY79khdIXzxZK2Iz3wuLVsj4yASLvcrT/BpHZbDRc3Zxv/azgqbon+k
        ScM4jjZFe1VOzwsz6mQTluQlZEHZ3a+mRzeQ4rDuGaRQ4ZS93Dt+aQXGCeuucZ6ySSAHmOXJSzz7C
        tyXwu0jIQ==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:58984)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hejGV-0004nV-Uc; Sat, 22 Jun 2019 17:53:24 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hejGQ-0004Jj-OT; Sat, 22 Jun 2019 17:53:18 +0100
Date:   Sat, 22 Jun 2019 17:53:18 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Michael Olbrich <m.olbrich@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Vinod Koul <vinod.koul@intel.com>
Cc:     linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org
Subject: [BUG] imx-sdma: readl_relaxed_poll_timeout_atomic() conversion
Message-ID: <20190622165318.bgyun52hssqmdv4n@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Old code:

-       while (!(ret = readl_relaxed(sdma->regs + SDMA_H_INTR) & 1)) {
-               if (timeout-- <= 0)
-                       break;
-               udelay(1);
-       }

So, while bit 0 is _clear_ the loop continues to poll.


New code:

+       ret = readl_relaxed_poll_timeout_atomic(sdma->regs + SDMA_H_STATSTOP,
+                                               reg, !(reg & 1), 1, 500);

Doesn't really tell us what the termination condition is (because of
the obfuscation taking away the details), but if we dig into the
macro maze:

#define readl_relaxed_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
        readx_poll_timeout_atomic(readl_relaxed, addr, val, cond, delay_us, timeout_us)

#define readx_poll_timeout_atomic(op, addr, val, cond, delay_us, timeout_us) \
({ \
        u64 __timeout_us = (timeout_us); \
        unsigned long __delay_us = (delay_us); \
        ktime_t __timeout = ktime_add_us(ktime_get(), __timeout_us); \
        for (;;) { \
                (val) = op(addr); \
                if (cond) \
                        break; \

"cond" is passed in to here unmodified, so this becomes:

	for (;;) {
		reg = readl_relaxed(sdma->regs + SDMA_H_STATSTOP);
		if (!(reg & 1))
			break;

So, if bit 0 of this register is clear, we terminate the loop.

Seems to me like this is a great illustration why using a helper
_introduces_ bugs, because it hides the detail about what the exit
condition for the embedded loop actually is, and leads to this kind
of error.

In any case, the conversion is obviously incorrect.

I occasionally see the "Timeout waiting for CH0 ready" error during
boot on a cbi4, which, given the above, means that we did end up
seeing bit 1 set (so according to the old code, we waited
successfully.)

Looking at the date of the commit, this is almost a three year old
bug.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
