Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42D64BE464
	for <lists+dmaengine@lfdr.de>; Mon, 21 Feb 2022 18:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358672AbiBUNNA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Feb 2022 08:13:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350923AbiBUNM6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Feb 2022 08:12:58 -0500
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983371EC73;
        Mon, 21 Feb 2022 05:12:33 -0800 (PST)
Received: from relay1-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::221])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id A2DE7D114C;
        Mon, 21 Feb 2022 12:59:38 +0000 (UTC)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 2BC3024000E;
        Mon, 21 Feb 2022 12:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1645448371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uhTsNJ0kQ/JteUN01wS0pWNvIJDnfr56O80qPFYTQnw=;
        b=Alwdtw0XSor57w4FVemMV1hXlcsJhPuvWYXPMpOc+ZmsLlD+gUr/85IBzkW4AEh+MpD9Pz
        GONNuZNjuZiWPr3bNNBzwK6A6XdPiC5plnS8DQk6Bpma9rwYKFVabKt7huyLV0/iL9eENv
        XZTvGh9ODK0HwLKXHOevSkDK4AAkYqgJdyDnwG/s2XIzRXjZ3MHMi5P2Xf2xZ7g4xnn6M0
        inB2hbEUozQbq3ZVwUdXus0c9CPEr/xU0GRchwkQNWtDifsCCUeyLDWh/KfuGFRlROY2b+
        QZGQ7WVCWy42MLbWe+rtfjbu9EK7fsFpxb0w7YF+53H2YJFefrpvR78+xxEuag==
Date:   Mon, 21 Feb 2022 13:59:27 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Phil Edworthy <phil.edworthy@renesas.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Laetitia MARIOTTINI <laetitia.mariottini@se.com>
Subject: Re: [PATCH 5/8] dma: dw: Avoid partial transfers
Message-ID: <20220221135915.7a441663@xps13>
In-Reply-To: <TYYPR01MB7086F412B035A09AED2037A9F53A9@TYYPR01MB7086.jpnprd01.prod.outlook.com>
References: <20220218181226.431098-1-miquel.raynal@bootlin.com>
        <20220218181226.431098-6-miquel.raynal@bootlin.com>
        <YhIcyyBp53LnMbjU@smile.fi.intel.com>
        <TYYPR01MB7086F412B035A09AED2037A9F53A9@TYYPR01MB7086.jpnprd01.prod.outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Andy,

phil.edworthy@renesas.com wrote on Mon, 21 Feb 2022 08:14:47 +0000:

> Hi Andy,
>=20
> I wrote the patch a few years ago, but didn't get the time to upstream it.
>=20
> I am not aware of a HW integration bug on the RZ/N1 device but can't rule=
 it out. I am struggling to see what kind of HW issue this could be as, iir=
c, word accesses work fine when the size of the transfer is a multiple of t=
he MEM width.
>=20
> I found the issue when testing DMA with the UART transferring different a=
mounts of data.
>=20
> > > +		if (sconfig->dst_addr_width && sconfig->dst_addr_width < =20
> > data_width) =20
> > > +			data_width =3D sconfig->dst_addr_width; =20
> >=20
> > But here no check that you do it for explicitly peripheral to memory, so
> > this
> > will affect memory to peripheral transfers as well. =20
> No, this should be ok as this change is within:
> 	case DMA_DEV_TO_MEM:

I will add this to the commit log to clarify.

Thanks,
Miqu=C3=A8l
