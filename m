Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5C91CD922
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2020 13:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729475AbgEKL6R (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 May 2020 07:58:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:41716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbgEKL6R (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 11 May 2020 07:58:17 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDFD22075E;
        Mon, 11 May 2020 11:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589198296;
        bh=I7c/5QR0NUZxXyJ3bfQU4K67hU6vugawyRi1MoWi3Ag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hMYxExIkbBzpZ8xg1+7zwz1nUpF1p694bpxCsfJ0x+6ZYVxyIZSYhNLWVUmx5cS2U
         U6vX1F9U22Pn8tffCzSxGDxl96iWaXHHGgGFEDuRfBzRuZP/QWtkoajrB+4xZRf+F8
         yoXXlU4MuhX59fX9LOFqETt7nYbJLAk8zxsUReio=
Date:   Mon, 11 May 2020 12:58:13 +0100
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
Message-ID: <20200511115813.GG8216@sirena.org.uk>
References: <20200306131048.ADBE18030797@mail.baikalelectronics.ru>
 <20200508105304.14065-1-Sergey.Semin@baikalelectronics.ru>
 <20200508105304.14065-5-Sergey.Semin@baikalelectronics.ru>
 <20200508112604.GJ185537@smile.fi.intel.com>
 <20200508115334.GE4820@sirena.org.uk>
 <20200511021016.wptcgnc3iq3kadgz@mobilestation>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fwqqG+mf3f7vyBCB"
Content-Disposition: inline
In-Reply-To: <20200511021016.wptcgnc3iq3kadgz@mobilestation>
X-Cookie: TANSTAAFL
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--fwqqG+mf3f7vyBCB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 11, 2020 at 05:10:16AM +0300, Serge Semin wrote:

> Alas linearizing the SPI messages won't help in this case because the DW DMA
> driver will split it into the max transaction chunks anyway.

That sounds like you need to also impose a limit on the maximum message
size as well then, with that you should be able to handle messages up
to whatever that limit is.  There's code for that bit already, so long
as the limit is not too low it should be fine for most devices and
client drivers can see the limit so they can be updated to work with it
if needed.

--fwqqG+mf3f7vyBCB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl65PdUACgkQJNaLcl1U
h9CBqgf+PZERckWsOqLfM9GL+SqMyC0673X9Gu0EsD3d7Ew+bDzZXCP8IFVs0dXB
kmzF1l+0PHatJ27mV6GPxEAZby+fbbxYZo7/YiDxgE5ortZH58vhYgjFf3gG6XtD
SAsfGyowPpK+/2sIGN7pAzXyFMueva4wfHcz3Q74DiSbwc+XugWuS6yHOYsJVrdx
8xhvwaO2S3Wq9G5yJbETpknlzXhGJgTIYF6H86fPOCkqW06c+RiWubK5c2SLj4d6
6CQ/C0vlsL5GOgC8XcOh8EIgZ/XUfPShqn4/U/f3XotpHVmifCJzvsYB77aB7PFx
jegHvOJtAGGNPdjuGA5MTUIkYefFYQ==
=ko68
-----END PGP SIGNATURE-----

--fwqqG+mf3f7vyBCB--
