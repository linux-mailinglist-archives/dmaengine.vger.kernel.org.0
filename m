Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094504C3152
	for <lists+dmaengine@lfdr.de>; Thu, 24 Feb 2022 17:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiBXQbA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Feb 2022 11:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiBXQa7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Feb 2022 11:30:59 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2563E21D081;
        Thu, 24 Feb 2022 08:30:13 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id CF56AFF812;
        Thu, 24 Feb 2022 16:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1645720212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s8oCo+M22Obem+506INwTsgvqAs+7mebrwhLClGvSIU=;
        b=HYL5g4uq90MpMjhQtZcyHDOaPVs1DqGqdeGAqpBB3vSCe4p8FyfLaamnnyEgtwzm/HlSSX
        N/DKOMqg9a74beNIoaY+ogN7WcXvfaxK//Hf0TX1/0doggy7vAQhff5Bs7YiQYpC1Auce3
        4ocd9YlXd6Es4iItuz1iORjLC76OU1aWUgWNE9x9gsomrya73+IrDvCXkh5fbuLWaXmcBh
        JETcQowot2tY1HMtWKUFVxl85NFAXsBRxPLucirlyu/9UkSZiLSi+i2ZNHUxzOSDacuqQ+
        UqWcff2k0FoKFI52X8VZg8eA39icDrHOYoRZfu0ZKu1C1qr1nDRlBWigAUha+A==
Date:   Thu, 24 Feb 2022 17:30:09 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>
Subject: Re: [PATCH v2 5/8] dma: dw: Avoid partial transfers
Message-ID: <20220224173009.0d37c12e@xps13>
In-Reply-To: <YhY4PqqOgYTLgpKr@smile.fi.intel.com>
References: <20220222103437.194779-1-miquel.raynal@bootlin.com>
        <20220222103437.194779-6-miquel.raynal@bootlin.com>
        <YhY4PqqOgYTLgpKr@smile.fi.intel.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Andy, Phil,

andriy.shevchenko@linux.intel.com wrote on Wed, 23 Feb 2022 15:35:58
+0200:

> On Tue, Feb 22, 2022 at 11:34:34AM +0100, Miquel Raynal wrote:
> > From: Phil Edworthy <phil.edworthy@renesas.com>
> >=20
> > Pausing a partial transfer only causes data to be written to memory that
> > is a multiple of the memory width setting.
> >=20
> > However, when a DMA client driver finishes DMA early, e.g. due to UART
> > char timeout interrupt, all data read from the device must be written to
> > memory.
> >=20
> > Therefore, allow the slave to limit the memory width to ensure all data
> > read from the device is written to memory when DMA is paused. =20
>=20
> (I have only 2.17d and 2.21a datasheets, so below based on the latter)
>=20
> It seems you are referring to the chapter 7.7 "Disabling a Channel Prior
> to Transfer Completion" of the data sheet where it stays that it does not
> guarantee to have last burst to be completed in case of
> SRC_TR_WIDTH < DST_TR_WIDTH and the CH_SUSP bit is high, when the FIFO_EM=
PTY
> is asserted.
>=20
> Okay, in iDMA 32-bit we have a specific bit (seems like a fix) that drains
> FIFO, but still it doesn't drain the FIFO fully (in case of misalignment)
> and the last piece of data (which is less than TR width) is lost when cha=
nnel
> gets disabled.
>=20
> Now, if we look at the implementation of the serial8250_rx_dma_flush() we
> may see that it does
>  1. Pause channel without draining FIFO
>  2. Moves data to TTY buffer
>  3. Terminates channel.
>=20
> During termination it does pause channel again (with draining enabled),
> followed by disabling channel and resuming it again.
>=20
> According to the 7.7 the resuming channel allows to finish the transfer
> normally.
>=20
> It seems the logic in the ->terminate_all() is broken and we actually need
> to resume channel first (possibly conditionally, if it was suspended), th=
en
> pause it and disable and resume again.
>=20
> The problem with ->terminate_all() is that it has no knowledge if it has
> been called on paused channel (that's why it has to pause channel itself).
> The pause on termination is required due to some issues in early steppings
> of iDMA 32-bit hardware implementations.
>=20
> If my theory is correct, the above change should fix the issues you see.

I don't have access to these datasheets so I will believe your words
and try to apply Andy's solution. I ended up with the following fix,
hopefully I got it right:

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 48cdefe997f1..59822664d8ec 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -865,6 +865,10 @@ static int dwc_terminate_all(struct dma_chan *chan)
=20
        clear_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags);
=20
+       /* Ensure the last byte(s) are drained before disabling the channel=
 */
+       if (test_bit(DW_DMA_IS_PAUSED, &dwc->flags))
+               dwc_chan_resume(dwc, true);
+
        dwc_chan_pause(dwc, true);
=20
        dwc_chan_disable(dw, dwc);

Phil, I know it's been 3 years since you investigated this issue, but
do you still have access to the script reproducing the issue? Even
better, do you still have the hardware to test?

Thanks,
Miqu=C3=A8l
