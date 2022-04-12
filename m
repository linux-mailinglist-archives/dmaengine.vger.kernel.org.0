Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0ED04FDB72
	for <lists+dmaengine@lfdr.de>; Tue, 12 Apr 2022 12:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354452AbiDLKDz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Apr 2022 06:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377928AbiDLHyl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 12 Apr 2022 03:54:41 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9FF506D2;
        Tue, 12 Apr 2022 00:32:00 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 87B521BF204;
        Tue, 12 Apr 2022 07:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649748719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X35WNGkpzJuR8QwsexhB4AiDSNFg4aYG2MXJXgXQfu4=;
        b=MftXS1qpch3u8BR/zUR5NpnKYwxy/YXxXE6EbNy5pCKENpwvf1eRA88j2ojUrqJ7NGFW+X
        7zPncsxaft5BZNtXXU1nKt2EBbajHilEQN3dVe745BDKCbYTOenH/NKbuo+0bww6O2u3DH
        MyaMUm+FaoEXY5ZITJQcDU+V9mv26k9BMIchkDW7RORJ/IiPssHvpAGxf3FTRT1wcwg8DC
        RMbf+2ItuOAWmXdQeOTLgwbunN6fzeY+FKdjMVNiMFO9b+Ta3d4fhnxz46U5xabDqpQ+tu
        QZVYxbLyHzjIw81FCtF63yQltACz2EJq7xJ/suXor6CVW6o5C8poPAVDzDXmCg==
Date:   Tue, 12 Apr 2022 09:31:55 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Vinod Koul <vkoul@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v8 0/9] RZN1 DMA support
Message-ID: <20220412093155.090de9d6@xps13>
In-Reply-To: <CAMuHMdUZFTm+0NFLUFoXT7ujtxDot_Y+gya9ETK1FOai2MXfvA@mail.gmail.com>
References: <20220406161856.1669069-1-miquel.raynal@bootlin.com>
        <20220407004511.3A6D1C385A3@smtp.kernel.org>
        <20220407101605.7d2a17cc@xps13>
        <CAMuHMdUZFTm+0NFLUFoXT7ujtxDot_Y+gya9ETK1FOai2MXfvA@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Geert,

geert@linux-m68k.org wrote on Mon, 11 Apr 2022 17:09:50 +0200:

> Hi Miquel,
>=20
> On Thu, Apr 7, 2022 at 10:16 AM Miquel Raynal <miquel.raynal@bootlin.com>=
 wrote:
> > sboyd@kernel.org wrote on Wed, 06 Apr 2022 17:45:09 -0700: =20
> > > Quoting Miquel Raynal (2022-04-06 09:18:47) =20
> > > > Here is a first series bringing DMA support to RZN1 platforms. Soon=
 a
> > > > second series will come with changes made to the UART controller
> > > > driver, in order to interact with the RZN1 DMA controller.
> > > >
> > > > Stephen acked the sysctrl patch (in the clk driver) but somehow I f=
eel
> > > > like it would be good to have this patch applied on both sides
> > > > (dmaengine and clk) because more changes will depend on the additio=
n of
> > > > this helper, that are not related to DMA at all. I'll let you folks
> > > > figure out what is best. =20
> > >
> > > Are you sending more patches in the next 7 weeks or so that will touch
> > > the same area? If so, then it sounds like I'll need to take the clk
> > > patch through clk tree. I don't know what is best because I don't have
> > > the information about what everyone plans to do in that file. =20
> >
> > This series brings DMA support and needs to access the dmamux registers
> > that are in the sysctrl area.
> >
> > I've sent an RTC series which needs to access this area as well, but
> > it is not fully ready yet as it was advised to go for a reset
> > controller in this case. The reset controller would be registered by
> > the clock driver, so yes it would touch the same file.
> >
> > Finally, there is an USB series that is coming soon, I don't know if
> > it will be ready for merge for 5.19, but it needs to access a specific
> > register in this area as well (h2mode).
> >
> > So provided that we are able to contribute this reset driver quickly
> > enough, I would argue that it is safer to merge the clk changes in the
> > clk tree. =20
>=20
> The clk tree or the renesas-clk tree? ;-)

Actually I forgot about this tree, would you mind to merge *all* the
patches that depend on the sysctrl changes in the renesas/renesas-clk
tree? This also stands for the UART and RTC for instance. Otherwise
you'll need to set up immutable branches and share them with the
dmaengine, serial and rtc trees. I'm fine either way, it's just much
less work in the first situation IMHO.

Thanks,
Miqu=C3=A8l
