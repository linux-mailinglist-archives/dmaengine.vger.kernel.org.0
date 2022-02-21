Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B643D4BE72C
	for <lists+dmaengine@lfdr.de>; Mon, 21 Feb 2022 19:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377636AbiBUOYm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Feb 2022 09:24:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234903AbiBUOYm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Feb 2022 09:24:42 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BA61EC70;
        Mon, 21 Feb 2022 06:24:18 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6F63720010;
        Mon, 21 Feb 2022 14:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1645453457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YMyn0XaFhroP4AizT39Pp4+gHgYE96LeomWKdKQE/Tg=;
        b=fYUPQmGJiuUTfRALCw2Pn3asdMYOxLMbVzAQKay8a6dv7V/o/Kb+Pb72RM3830xuKgLKSK
        negigQedvYaA6Cj2yDAdzr6YzwdUMagGLt4VQZtizlFuXddkR1IrTz50+lv5TnJ0zLZxVt
        FbaKBBZYjhZOLU/C+f+7YBD1ZhYss/qQ6AGoVOv8Nkq7ttt/6V0xKri3LcvYQCe7axGmMz
        mu7tD8PtpJFqygCc805Y1uNFKFIgNDR4kNCAScGxvrh40ptYKNNB2dL9+CBGONOgZDECbT
        2FlfnRxIOXvXnO+D78vaxthM3o6rfpN9sIRkSSqELktjg9tStaI7I/vejNF1cw==
Date:   Mon, 21 Feb 2022 15:24:13 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-clk@vger.kernel.org,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Vinod Koul <vkoul@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        dmaengine@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-renesas-soc@vger.kernel.org,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Laetitia MARIOTTINI <laetitia.mariottini@se.com>,
        devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/8] dt-bindings: dma: Introduce RZN1 DMA compatible
Message-ID: <20220221152413.4d395fea@xps13>
In-Reply-To: <1645410969.367667.2041542.nullmailer@robh.at.kernel.org>
References: <20220218181226.431098-1-miquel.raynal@bootlin.com>
        <20220218181226.431098-3-miquel.raynal@bootlin.com>
        <1645410969.367667.2041542.nullmailer@robh.at.kernel.org>
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

Hi Rob,

robh@kernel.org wrote on Sun, 20 Feb 2022 20:36:09 -0600:

> On Fri, 18 Feb 2022 19:12:20 +0100, Miquel Raynal wrote:
> > Just like for the NAND controller that is also on this SoC, let's
> > provide a SoC generic and a more specific couple of compatibles.
> >=20
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  .../devicetree/bindings/dma/snps,dma-spear1340.yaml       | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >  =20
>=20
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):

Copy-paste error. Now fixed. Soon the v2.

Thanks,
Miqu=C3=A8l
