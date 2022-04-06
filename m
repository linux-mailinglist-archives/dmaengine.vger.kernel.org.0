Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408044F62D2
	for <lists+dmaengine@lfdr.de>; Wed,  6 Apr 2022 17:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235595AbiDFPNz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Apr 2022 11:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235674AbiDFPNP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 Apr 2022 11:13:15 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D01515794;
        Wed,  6 Apr 2022 05:14:39 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 785081C0003;
        Wed,  6 Apr 2022 12:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649247231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hHtYr2O08mH/wucgqLJsZAiACeshIhGLPI+TYu9KvYA=;
        b=XU8zFzsyu3nWadjmpIG2TsYVz0BJgcYu81SVASG78eMa7aRqa4uDi9q16AccFIRTcwJ2Ac
        sxNNiRtbTMqbczaSVKIkyRsEbsGRQElUNLESwiP6rd2k4WbSEcgkEhgNM64z+GFksWseBW
        o8C4oemzxWvICIgJK5ZLg4zCcVaoHOTSSYUyTD5OPMReOVsfPaVcsvD6gYrt0I2E4L5Uhl
        5VyYmEQj9r0HAYKKHXwIHfnETHD+zuCu8WaVPtZ0Q2Y6c3pi2nG7sqt145pL/iVh4aEdzz
        kxVfesAZCdtF8+YxgKhYq/Ad20ypJU9CgDmEdcIUDJ91BRsjx7HvmCqnOZc0kQ==
Date:   Wed, 6 Apr 2022 14:13:46 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Vinod Koul <vkoul@kernel.org>,
        linux-renesas-soc@vger.kernel.org, dmaengine@vger.kernel.org,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v7 5/9] dmaengine: dw: dmamux: Introduce RZN1 DMA router
 support
Message-ID: <20220406141346.5caf746c@xps13>
In-Reply-To: <Yk1WWaJ9IJsU5HXV@smile.fi.intel.com>
References: <20220405081911.1349563-1-miquel.raynal@bootlin.com>
        <20220405081911.1349563-6-miquel.raynal@bootlin.com>
        <YkxXUdMA75b8keSd@smile.fi.intel.com>
        <20220406094908.48ecc4bb@xps13>
        <Yk1WWaJ9IJsU5HXV@smile.fi.intel.com>
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

andriy.shevchenko@linux.intel.com wrote on Wed, 6 Apr 2022 11:59:05
+0300:

> On Wed, Apr 06, 2022 at 09:49:08AM +0200, Miquel Raynal wrote:
> > andriy.shevchenko@linux.intel.com wrote on Tue, 5 Apr 2022 17:50:57
> > +0300: =20
> > > On Tue, Apr 05, 2022 at 10:19:07AM +0200, Miquel Raynal wrote: =20
>=20
> ...
>=20
> > > > +#define RZN1_DMAMUX_SPLIT 16 =20
> > >
> > > I would name it more explicitly:
> > >=20
> > > #define RZN1_DMAMUX_SPLIT_1_0	 16 =20
> >=20
> > I am sorry but I don't understand this suffix, which probably means
> > that it is not as clear as we wish. Do you mind if I stick to
> > RZN1_DMAMUX_SPLIT? =20
>=20
> The suffix to show that this is the value between part 0 (indexed by 0) a=
nd
> part 1 (indexed by 1) as far as I can see they are different by size. Sin=
ce
> they are not equal, the original name without suffix is confusing (I would
> expect indexing up to 4 in such case).

They are equivalent in size (0-15/16-31), or aren't we talking about the
same thing?

Thanks,
Miqu=C3=A8l
