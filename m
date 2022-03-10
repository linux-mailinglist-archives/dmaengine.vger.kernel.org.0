Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4D04D51E2
	for <lists+dmaengine@lfdr.de>; Thu, 10 Mar 2022 20:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245569AbiCJSrt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Mar 2022 13:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245567AbiCJSrs (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Mar 2022 13:47:48 -0500
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD56B19D74B;
        Thu, 10 Mar 2022 10:46:45 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 169C7200005;
        Thu, 10 Mar 2022 18:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646938004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hZU6SVWgpj28SgSGWMJlq8dkif2ZOccvFZ1KeCDp1sk=;
        b=FAOz01qqILI59eL5ElxRP3GT03NPc1HH1ll9vqDcFFee61xZTV22Khog1bIExta4/W41i1
        NUMhmPFfsPJS6vs0mUmrZu72ekB4YcH6MopkfDsKEBR4j8Hl93ITk5Se6QQgc6ak2JyxOV
        TUglNrbYgTnAs4Sirkex6I0Mhw4Arwz2vRoOo7rBDprDvjAdHmHFHW+ZkYpHLEm0um6x3P
        AfkAIMXhXUxrg++lgicu7PioRmhyDVv3C55LyUoQTdWUkDv23TotkWH6jyib1s55ubi66i
        PGFS3oo5C4KE2woLLEZjXvqB80EXt2/daOQNVm8j8P2CPcKjmqUtJPQDIilXSA==
Date:   Thu, 10 Mar 2022 19:46:40 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Ilpo =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>
Subject: Re: [PATCH v4 7/9] dma: dw: Avoid partial transfers
Message-ID: <20220310194640.4bc6e604@xps13>
In-Reply-To: <Yio6UWYIDZWXx2Ux@smile.fi.intel.com>
References: <20220310155755.287294-1-miquel.raynal@bootlin.com>
        <20220310155755.287294-8-miquel.raynal@bootlin.com>
        <Yio6UWYIDZWXx2Ux@smile.fi.intel.com>
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

Hi Andy,

andriy.shevchenko@linux.intel.com wrote on Thu, 10 Mar 2022 19:50:09
+0200:

> +Cc: Ilpo who is currently doing adjoining stuff.
>=20
> Ilpo, this one affects Intel Bay Trail and Cherry Trail platforms.
> Not sure if it's in scope of your interest right now, but it might
> be useful to see how DMA <--> 8250 UART functioning.
>=20
> On Thu, Mar 10, 2022 at 04:57:53PM +0100, Miquel Raynal wrote:
> > As investigated by Phil Edworthy <phil.edworthy@renesas.com> on RZN1 a =
=20
>=20
> Email can be dropped as you put it below, just (full) name is enough.

Sure.

> I'm wondering if Phil or anybody else who possess the hardware can
> test / tested this.

I have a board with an RZN1 SoC but I don't have exactly the same setup
as Phil (I only have one port with DMA working, while he used two as a
loopback device). I tried to reproduce the error with no luck so far. I
however verified that there was apparently no performance hit
whatsoever due to this change. IIRC Phil does not have the hardware
anymore.

> > while ago, pausing a partial transfer only causes data to be written to
> > memory that is a multiple of the memory width setting. Such a situation
> > can happen eg. because of a char timeout interrupt on a UART. In this
> > case, the current ->terminate_all() implementation does not always flush
> > the remaining data as it should.
> >=20
> > In order to workaround this, a solutions is to resume and then pause
> > again the transfer before termination. The resume call in practice
> > actually flushes the remaining data. =20
>=20
> Perhaps Fixes tag?

I don't know exactly what hardware can suffer from this, hence I
decided not to add a Fixes tag given the fact that it was only observed
on RZN1 (which was until now not yet supported upstream).

> > Reported-by: Phil Edworthy <phil.edworthy@renesas.com>
> > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  drivers/dma/dw/core.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >=20
> > diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
> > index 7ab83fe601ed..2f6183177ba5 100644
> > --- a/drivers/dma/dw/core.c
> > +++ b/drivers/dma/dw/core.c
> > @@ -862,6 +862,10 @@ static int dwc_terminate_all(struct dma_chan *chan)
> > =20
> >  	clear_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags);
> > =20
> > +	/* Ensure the last byte(s) are drained before disabling the channel */
> > +	if (test_bit(DW_DMA_IS_PAUSED, &dwc->flags))
> > +		dwc_chan_resume(dwc, true);
> > +
> >  	dwc_chan_pause(dwc, true);
> > =20
> >  	dwc_chan_disable(dw, dwc);
> > --=20
> > 2.27.0
> >  =20
>=20


Thanks,
Miqu=C3=A8l
