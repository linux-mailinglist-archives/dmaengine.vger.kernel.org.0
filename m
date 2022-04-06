Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99BB14F5BFB
	for <lists+dmaengine@lfdr.de>; Wed,  6 Apr 2022 13:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347325AbiDFLGb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Apr 2022 07:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355260AbiDFLFX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 Apr 2022 07:05:23 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B9952D903;
        Wed,  6 Apr 2022 00:31:26 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A818910000A;
        Wed,  6 Apr 2022 07:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649230282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nHj5k5RzXeFddFrVB4M3iAfHYNCiMLQrlVcvkv7tNwY=;
        b=QQ5TYeKl8nxr5lg5xsdiD7SuJg8yDXW1F3juR7fPgJYpvK08QuPE7EUW/W6PxBk35X/bkI
        2U0fwd4SCh3wyKlp8+o3l5XiTMtU8kAtBrzRE13elbV53+4g2CzJA+kLcO9KSBQzgVqlN2
        HKHJTi/YZPm66mEm/kY9Jz3HDTsV30BMXAa8RNcJNQVKdxgeP6v0mXxGNz7Dv16PI2PLcH
        AGrY5R6n9401GPAOrJfN2ejcm4gL7AjqusI3PJVB7yLWrBYxCtA9pCgZcirL1dxBfN22nH
        Ft8GXJLBCXyz8aKnfaojBfueyrreClpIfWdVsFYBTWE3eFgPq96WB/NRIFHVAg==
Date:   Wed, 6 Apr 2022 09:31:17 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Vinod Koul <vkoul@kernel.org>,
        "open list:MEDIA DRIVERS FOR RENESAS - FCP" 
        <linux-renesas-soc@vger.kernel.org>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v7 1/9] dt-bindings: dmaengine: Introduce RZN1 dmamux
 bindings
Message-ID: <20220406093117.128bc7f1@xps13>
In-Reply-To: <CAL_JsqK3VJ=5VxF5DgZh58zkmWkaAHu9TL9dYOAeTw5nry1Xrg@mail.gmail.com>
References: <20220405081911.1349563-1-miquel.raynal@bootlin.com>
        <20220405081911.1349563-2-miquel.raynal@bootlin.com>
        <CAL_JsqK3VJ=5VxF5DgZh58zkmWkaAHu9TL9dYOAeTw5nry1Xrg@mail.gmail.com>
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

Hi Rob,

robh@kernel.org wrote on Tue, 5 Apr 2022 13:12:19 -0500:

> On Tue, Apr 5, 2022 at 3:19 AM Miquel Raynal <miquel.raynal@bootlin.com> =
wrote:
> >
> > The Renesas RZN1 DMA IP is based on a DW core, with eg. an additional
> > dmamux register located in the system control area which can take up to
> > 32 requests (16 per DMA controller). Each DMA channel can be wired to
> > two different peripherals.
> >
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../bindings/dma/renesas,rzn1-dmamux.yaml     | 51 +++++++++++++++++++
> >  MAINTAINERS                                   |  1 +
> >  2 files changed, 52 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/dma/renesas,rzn1-=
dmamux.yaml =20
>=20
> Please send to the DT list so checks run. I've already reviewed this,
> but what passes does change over time. Such as RiscV cpuidle patches
> that were picked up after 2 months on Thurs and sent to Linus on
> Fri... :(

Oh, ok, no problem.

Thanks,
Miqu=C3=A8l
