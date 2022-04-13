Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A924E4FF729
	for <lists+dmaengine@lfdr.de>; Wed, 13 Apr 2022 14:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235640AbiDMMzs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 Apr 2022 08:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbiDMMzs (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 13 Apr 2022 08:55:48 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3154A53B4C;
        Wed, 13 Apr 2022 05:53:26 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 19A0F100003;
        Wed, 13 Apr 2022 12:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649854404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jMM1Syt6Hb7HT86R4R4Lg8BJZKzBGi7RXcW2xbIgcVc=;
        b=FMdpcKK7I4B4GTQ6T7VC2cgv3L/jz5eqCgFceBWM3qKgMVghduEdAlo7GofwrG8R0zNWxl
        endHPgd8SN3Ob1WCHWNJ0TwE+NW9V+Eil9RfWN3JHiGn95B0OXSwjpsPT0gqh/ceTSvtmn
        18y4uQdfJsTqHKguWEuchW/DwQIJ87Cdp2/GXeXiiszR9gUqt7X6eA6vi0dLKGQY3AC8aN
        L7uE88pGxhL2akALO/eeijrh4osCzdlg7DpYjQ3OyXcWPzx5aaAIQitdw5t6XnY9HHHOoO
        NGx9Du4jJ6YpaDLtpWW8UKkKQu5sOla9eF6gz7fch7aTj96IP0sSghxuECJ7HA==
Date:   Wed, 13 Apr 2022 14:53:19 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
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
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v10 5/9] dmaengine: dw: dmamux: Introduce RZN1 DMA
 router support
Message-ID: <20220413145319.6d3f1cce@xps13>
In-Reply-To: <Ylao068kNANViy4B@smile.fi.intel.com>
References: <20220412193936.63355-1-miquel.raynal@bootlin.com>
        <20220412193936.63355-6-miquel.raynal@bootlin.com>
        <CAMuHMdV_KWuDRWtNaL2n8+1y4GbOSSosesd3RPK60i6zYkQPDA@mail.gmail.com>
        <20220413100026.73e11004@xps13>
        <CAMuHMdU3pEX3oGoHQ71cm7m0DpguJOqpOTq4_kfAxD98XN325A@mail.gmail.com>
        <Ylao068kNANViy4B@smile.fi.intel.com>
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

Hi Andy, Geert,

andriy.shevchenko@linux.intel.com wrote on Wed, 13 Apr 2022 13:41:23
+0300:

> On Wed, Apr 13, 2022 at 10:05:43AM +0200, Geert Uytterhoeven wrote:
> > On Wed, Apr 13, 2022 at 10:00 AM Miquel Raynal
> > <miquel.raynal@bootlin.com> wrote: =20
>=20
> ...
>=20
> >     DECLARE_BITMAP(used_chans, 2 * RZN1_DMAMUX_MAX_LINES); =20

I'll make the update. Do you mind if I send only this patch as a v11?
There is no change in any of the other patches anyway and I think I've
received all the acks required.

Thanks,
Miqu=C3=A8l
