Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC484FE4E8
	for <lists+dmaengine@lfdr.de>; Tue, 12 Apr 2022 17:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357138AbiDLPlc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Apr 2022 11:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357139AbiDLPlb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 12 Apr 2022 11:41:31 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D574621270;
        Tue, 12 Apr 2022 08:39:09 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6ADB91BF20F;
        Tue, 12 Apr 2022 15:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649777948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rKZtJGJxW/aFxcS9buXo0jT+71lDfrClh+EY4VvAKZ8=;
        b=NFPEDLDUjvoDfqIpEQdkNnl2orzguZG1zn0hdbX8XWTmBZcGLFOH3wj5qLaGkg3oMx+qR5
        m5XHV4wb9sniARGqp5cmg858TxaOJth7N5R2kg6xbKAaFNL76X9w0hDgbxu0OLlv5NXC/F
        3DkrAxr7PPmRpPFkft64wembdhVk6LU+ujgRUo7MBDGeDu7hgQ4vNLrqCv9A6HNcwCXEWW
        VMQvHT7lLfsOZAWM6fbNbDQz3e9FWzHctJ2mAvybiwrglgk4LeqQWs174eLm6WhFw3w4rR
        t1t4faF75wbdcTXo6dS4uZ+bjO/dmYzqwaEQRth2Cb/LsEFyQVXqbmPKKLdW5Q==
Date:   Tue, 12 Apr 2022 17:39:03 +0200
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
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v9 5/9] dmaengine: dw: dmamux: Introduce RZN1 DMA router
 support
Message-ID: <20220412173903.2af6df21@xps13>
In-Reply-To: <YlVdNpuYdgzo7Vgi@smile.fi.intel.com>
References: <20220412102138.45975-1-miquel.raynal@bootlin.com>
        <20220412102138.45975-6-miquel.raynal@bootlin.com>
        <YlVdNpuYdgzo7Vgi@smile.fi.intel.com>
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

Hi Andy,

andriy.shevchenko@linux.intel.com wrote on Tue, 12 Apr 2022 14:06:30
+0300:

> On Tue, Apr 12, 2022 at 12:21:34PM +0200, Miquel Raynal wrote:
> > The Renesas RZN1 DMA IP is based on a DW core, with eg. an additional
> > dmamux register located in the system control area which can take up to
> > 32 requests (16 per DMA controller). Each DMA channel can be wired to
> > two different peripherals.
> >=20
> > We need two additional information from the 'dmas' property: the channel
> > (bit in the dmamux register) that must be accessed and the value of the
> > mux for this channel. =20
>=20
> ...
>=20
> Some headers are absent, e.g.: types.h, bitops.h.
>=20
> > +#include <linux/of_device.h>
> > +#include <linux/of_dma.h>
> > +#include <linux/slab.h> =20
>=20
> ...
>=20
> > +	mutex_lock(&dmamux->lock);
> > +	clear_bit(BIT(map->req_idx), dmamux->used_chans); =20
>=20
> Why do you need atomic bit operation here _and_ mutex?
>=20
> > +	mutex_unlock(&dmamux->lock); =20
>=20
> Ditto for the rest similar cases.

We no longer need the lock however I re-ordered things like they were
before because I need to add a check on the bitmap when setting the bit
and this must be done before touching the dmamux registers.

Thanks,
Miqu=C3=A8l
