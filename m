Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED8D4C17B9
	for <lists+dmaengine@lfdr.de>; Wed, 23 Feb 2022 16:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242469AbiBWPuZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Feb 2022 10:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236329AbiBWPuY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Feb 2022 10:50:24 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22490C1CBB;
        Wed, 23 Feb 2022 07:49:55 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id DF076C000B;
        Wed, 23 Feb 2022 15:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1645631394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FRTVVuH7ZkeBO5mQFM5u2bcgAhdzZ/tnO0lfsxfyy+U=;
        b=h8Qtprw2QHzbk3NUuG8hH8iZh7gRIyaiDuJZhrMY7C1mYqYvGq2r/kpoZKPXzQm8wdN1e7
        wfZot8j62Cw3VjLlOVuvi3w3UFUfcixDpeCuM2Q2TvxUuWjoWhfGb6crobuKRU+UTfQ9gl
        bDGJPi/Ht5O2in2JdsdBpBPoR83WXhPqZjVBIsjAIz2r01HfT1m5qwn6pWSEUaRZZn5u3f
        cQIO3crbh/yLgQWrJxNHMzkFQolBLGn6uM2I530aNnYYMx5eh7cI7xVA+5W7bYNujcx69a
        f5VWIbI3tlcHiGWJ1g68Pul2DA7rOIPWMd82quAg5zlJHSBubO/0HLqOcDRbLQ==
Date:   Wed, 23 Feb 2022 16:49:50 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>
Subject: Re: [PATCH v2 2/8] dt-bindings: dma: Introduce RZN1 DMA compatible
Message-ID: <20220223164950.18de06a8@xps13>
In-Reply-To: <CAMuHMdVzMiBn-rZgWkp=v7VWqEf1CX9kPTF7qn0cx9va9Z9dWg@mail.gmail.com>
References: <20220222103437.194779-1-miquel.raynal@bootlin.com>
        <20220222103437.194779-3-miquel.raynal@bootlin.com>
        <CAMuHMdVzMiBn-rZgWkp=v7VWqEf1CX9kPTF7qn0cx9va9Z9dWg@mail.gmail.com>
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

Hi Geert,

geert@linux-m68k.org wrote on Wed, 23 Feb 2022 13:21:47 +0100:

> On Tue, Feb 22, 2022 at 11:35 AM Miquel Raynal
> <miquel.raynal@bootlin.com> wrote:
> > Just like for the NAND controller that is also on this SoC, let's
> > provide a SoC generic and a more specific couple of compatibles for the
> > DMA controller.
> >
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com> =20
>=20
> > +++ b/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml =20
>=20
> Perhaps you want to add the power-domains property?
> The RZ/N1 clock driver is also a clock-domain provider.

I haven't looked at the power domains yet, but I don't plan to invest
time on it right now. Unless I don't understand your request, and you
are telling me that someone else added the description and we should
now point to the right domain from each new node?

> Apart from that:
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks!

Miqu=C3=A8l
