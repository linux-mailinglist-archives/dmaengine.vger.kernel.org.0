Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F2D4FDE06
	for <lists+dmaengine@lfdr.de>; Tue, 12 Apr 2022 13:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbiDLLgk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Apr 2022 07:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbiDLLeu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 12 Apr 2022 07:34:50 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BB075E72;
        Tue, 12 Apr 2022 03:13:00 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B91CE60003;
        Tue, 12 Apr 2022 10:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649758379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=68UMe/N6Z3nFxIrYdpsovoXjPbZxFhEBEnyv/vU9mcw=;
        b=NOJcrTnbofpEXSCB/eWW3epn5H6PfJo97VOcruxHuNItNcwXcS7y7xH+h1/m+S7Abuvs8S
        g6pu3R3xx8XHHcL1dvAI058NzOP7A6JhLR8yly/HhrkMndi5XCzHbtSbllF74wwpW3ECuy
        z8qy/jd3l/SkiyMTfKlvAgEIKxGFqz0y6EDRO4cGloQXok57QTYG54sHX9cq6B1yJFoChV
        u7bijyh2cnJxFnmuIvsdeb6RnivjDDMe2wVDFjkf14iXPjAHadlQW0t4g4xfcnvz/p40gS
        EemqwIJLg0iAOIPfRHo/Xdrcitl2JfGsgwAHWn6xgBaSe2kF9Hq2G6MJsyp7MQ==
Date:   Tue, 12 Apr 2022 12:12:55 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Ilpo =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Magnus Damm <magnus.damm@gmail.com>,
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
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v8 5/9] dmaengine: dw: dmamux: Introduce RZN1 DMA router
 support
Message-ID: <20220412121255.63ebe280@xps13>
In-Reply-To: <8d10c313-ecfe-4460-4040-8886aa421ef@linux.intel.com>
References: <20220406161856.1669069-1-miquel.raynal@bootlin.com>
        <20220406161856.1669069-6-miquel.raynal@bootlin.com>
        <6fbeebe2-9693-f91-78bd-451480f7a6dd@linux.intel.com>
        <YlAgbh2AFevBktxd@smile.fi.intel.com>
        <8d10c313-ecfe-4460-4040-8886aa421ef@linux.intel.com>
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

Hi Ilpo, Andy,

ilpo.jarvinen@linux.intel.com wrote on Fri, 8 Apr 2022 15:38:48 +0300
(EEST):

> On Fri, 8 Apr 2022, Andy Shevchenko wrote:
>=20
> > On Fri, Apr 08, 2022 at 12:55:47PM +0300, Ilpo J=C3=A4rvinen wrote: =20
> > > On Wed, 6 Apr 2022, Miquel Raynal wrote:
> > >  =20
> > > > The Renesas RZN1 DMA IP is based on a DW core, with eg. an addition=
al
> > > > dmamux register located in the system control area which can take u=
p to
> > > > 32 requests (16 per DMA controller). Each DMA channel can be wired =
to
> > > > two different peripherals.
> > > >=20
> > > > We need two additional information from the 'dmas' property: the ch=
annel
> > > > (bit in the dmamux register) that must be accessed and the value of=
 the
> > > > mux for this channel. =20
> >  =20
> > > > +	mask =3D BIT(map->req_idx);
> > > > +	mutex_lock(&dmamux->lock);
> > > > +	dmamux->used_chans |=3D mask;
> > > > +	ret =3D r9a06g032_sysctrl_set_dmamux(mask, val ? mask : 0);
> > > > +	if (ret)
> > > > +		goto release_chan_and_unlock;
> > > > +
> > > > +	mutex_unlock(&dmamux->lock);
> > > > +
> > > > +	return map;
> > > > +
> > > > +release_chan_and_unlock:
> > > > +	dmamux->used_chans &=3D ~mask; =20
> > >=20
> > > Now that I check this again, I'm not sure why dmamux->used_chans |=3D=
 mask;=20
> > > couldn't be done after r9a06g032_sysctrl_set_dmamux() call so this=20
> > > rollback of it wouldn't be necessary. =20
> >=20
> > I would still need the mutex unlock which I believe is down path there =
under
> > some other label. Hence you are proposing something like
> >=20
> > 	mask =3D BIT(map->req_idx);
> >=20
> > 	mutex_lock(&dmamux->lock);
> > 	ret =3D r9a06g032_sysctrl_set_dmamux(mask, val ? mask : 0);
> > 	if (ret)
> > 		goto err_unlock; // or whatever label is
> >=20
> > 	dmamux->used_chans |=3D mask;
> > 	mutex_unlock(&dmamux->lock);
> >=20
> > 	return map;
> >=20
> > Is that correct? If so, I don't see impediments either. =20
>=20
> Yes, and yes, the mutex still has to be unlocked on that error path.
>=20
> > > Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> =20

I've done the modification, thanks for your feedback.

Thanks,
Miqu=C3=A8l
