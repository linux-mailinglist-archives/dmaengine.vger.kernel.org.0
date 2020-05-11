Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE7E1CE1EE
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2020 19:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgEKRoS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 May 2020 13:44:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:41816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbgEKRoS (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 11 May 2020 13:44:18 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A81E206D6;
        Mon, 11 May 2020 17:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589219057;
        bh=TyqQgXbRU7CHTNnWXo92tDp4bkKKH+QHCcrcrAeZ0Xg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M5M0yr01sJrjR4NQQHjYco8Zm2A79QvQoS+JgFLzt3UtWZozf/K5RaXdDLDwpsV4n
         wQ4Llyx/KGkvcaEaZuIe/aT5WnmIVgxYInVSxRkj1xyI6x7VQqYBwTQcCt1+Wq38K2
         eFbuTzTTMJ7pHQiH04ug7PF5ar1YT8bmqKYk6agc=
Date:   Mon, 11 May 2020 18:44:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] dmaengine: dw: Print warning if multi-block is
 unsupported
Message-ID: <20200511174414.GL8216@sirena.org.uk>
References: <20200306131048.ADBE18030797@mail.baikalelectronics.ru>
 <20200508105304.14065-1-Sergey.Semin@baikalelectronics.ru>
 <20200508105304.14065-5-Sergey.Semin@baikalelectronics.ru>
 <20200508112604.GJ185537@smile.fi.intel.com>
 <20200508115334.GE4820@sirena.org.uk>
 <20200511021016.wptcgnc3iq3kadgz@mobilestation>
 <20200511115813.GG8216@sirena.org.uk>
 <20200511134502.hjbu5evkiuh75chr@mobilestation>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="W/+CTqSGWdiRg+8j"
Content-Disposition: inline
In-Reply-To: <20200511134502.hjbu5evkiuh75chr@mobilestation>
X-Cookie: TANSTAAFL
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--W/+CTqSGWdiRg+8j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 11, 2020 at 04:45:02PM +0300, Serge Semin wrote:
> On Mon, May 11, 2020 at 12:58:13PM +0100, Mark Brown wrote:

> > That sounds like you need to also impose a limit on the maximum message
> > size as well then, with that you should be able to handle messages up
> > to whatever that limit is.  There's code for that bit already, so long
> > as the limit is not too low it should be fine for most devices and
> > client drivers can see the limit so they can be updated to work with it
> > if needed.

> Hmm, this might work. The problem will be with imposing such limitation through
> the DW APB SSI driver. In order to do this I need to know:

> 1) Whether multi-block LLP is supported by the DW DMA controller.
> 2) Maximum DW DMA transfer block size.

There is a constraint enumeration interface in the DMA API which you
should be able to extend for this if it doesn't already support what you
need.

> Then I'll be able to use this information in the can_dma() callback to enable
> the DMA xfers only for the safe transfers. Did you mean something like this when
> you said "There's code for that bit already" ? If you meant the max_dma_len
> parameter, then setting it won't work, because it just limits the SG items size
> not the total length of a single transfer.

You can set max_transfer_size and/or max_message_size in the SPI driver
- you should be able to do this on probe.

--W/+CTqSGWdiRg+8j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl65ju0ACgkQJNaLcl1U
h9BWuwf9GYDZfT9SEAR6UO5jhJk6RWwFsHU3BhxdAnvDK/l2K93uI+11WQq2An8H
yiMiIaTllJPZmNs7mg1+lxpT1gRmKbmoXqb3DFml9K4gKxVJMXoIAPyhTL6wLqaV
wiCzkwszsZsVvzFiQyPNAau0qzkaOC+wHPr8PUiEFxZIRUxEsThin07HXK7X0APj
7LoKnOaB28MWVN/ezndCECaxoOgexp8LZ6jhVMMg/Kpd8UMCaJwB8yEz80uBFL+q
mglQQesF6cb/dQZcynpOyCWm2dZhnCdd5yvyHWH1d2rVbcfi3xoTq+tWfPMLbW12
45bciv1TxBU7iqLX1sF/YYO33YIO1Q==
=HGPI
-----END PGP SIGNATURE-----

--W/+CTqSGWdiRg+8j--
