Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA7E4F7948
	for <lists+dmaengine@lfdr.de>; Thu,  7 Apr 2022 10:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbiDGISP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 7 Apr 2022 04:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243012AbiDGISM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 7 Apr 2022 04:18:12 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939651FB511;
        Thu,  7 Apr 2022 01:16:10 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 1C0C360002;
        Thu,  7 Apr 2022 08:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649319369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PNNgtO2v7ENqtk/jVwRLHaYczs4fWocw9XAg9DMnNI0=;
        b=cebAgBByATw3RDkwnLPy9L1kcp908n3TLvnba95ZuhnIxXdV412kIN68Ft2XcDxR9fnqqt
        Fr3QxKxnVh+rDlCvHtSERhe3+L4y5ZTC6A6FWxGY+LYr+pLs82nh8Y9oV4Dfn0dURxIV+E
        hV3lc/K3PVlmbrjmPuwWvsXmsj7sUxMb3VMyRiekrXso6B3dDVn3h9RzzlOTUbgfjnYn/H
        eoiB8bdIln7qkGNO/g8NYBQl6UWZQeBqLmsAfjMtjmWVYIzGl8ub9BGQehfLh4EHQGSHLo
        xc57piQ5xgvJxB9K8SU3WjdKJlOkCfieN9mZBHIQi5dz/jRYIXxNEgJfHgc/qQ==
Date:   Thu, 7 Apr 2022 10:16:05 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Gareth Williams <gareth.williams.jx@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Vinod Koul <vkoul@kernel.org>,
        linux-renesas-soc@vger.kernel.org, dmaengine@vger.kernel.org,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v8 0/9] RZN1 DMA support
Message-ID: <20220407101605.7d2a17cc@xps13>
In-Reply-To: <20220407004511.3A6D1C385A3@smtp.kernel.org>
References: <20220406161856.1669069-1-miquel.raynal@bootlin.com>
        <20220407004511.3A6D1C385A3@smtp.kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Stephen,

sboyd@kernel.org wrote on Wed, 06 Apr 2022 17:45:09 -0700:

> Quoting Miquel Raynal (2022-04-06 09:18:47)
> > Hello,
> >=20
> > Here is a first series bringing DMA support to RZN1 platforms. Soon a
> > second series will come with changes made to the UART controller
> > driver, in order to interact with the RZN1 DMA controller.
> >=20
> > Stephen acked the sysctrl patch (in the clk driver) but somehow I feel
> > like it would be good to have this patch applied on both sides
> > (dmaengine and clk) because more changes will depend on the addition of
> > this helper, that are not related to DMA at all. I'll let you folks
> > figure out what is best. =20
>=20
> Are you sending more patches in the next 7 weeks or so that will touch
> the same area? If so, then it sounds like I'll need to take the clk
> patch through clk tree. I don't know what is best because I don't have
> the information about what everyone plans to do in that file.

This series brings DMA support and needs to access the dmamux registers
that are in the sysctrl area.

I've sent an RTC series which needs to access this area as well, but
it is not fully ready yet as it was advised to go for a reset
controller in this case. The reset controller would be registered by
the clock driver, so yes it would touch the same file.

Finally, there is an USB series that is coming soon, I don't know if
it will be ready for merge for 5.19, but it needs to access a specific
register in this area as well (h2mode).

So provided that we are able to contribute this reset driver quickly
enough, I would argue that it is safer to merge the clk changes in the
clk tree.

Thanks,
Miqu=C3=A8l
