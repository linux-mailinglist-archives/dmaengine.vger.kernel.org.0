Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB24A1CE77A
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2020 23:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgEKVc0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 May 2020 17:32:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:38720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbgEKVc0 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 11 May 2020 17:32:26 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24876206D9;
        Mon, 11 May 2020 21:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589232745;
        bh=z3P+ciZRlqvUI6Pqf8o4ovW9pXtoLRn9Wot/OO72TAo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OGUPDSMKjydMtSMfFaHrMblmqGwaDOmxz/dBFDSE1wrNvMN5tYxvuwczACX2mkq1U
         V/DIDWiSDQk3Kn7fmFqsXbv7UXLfLf40W4nuYicxav4RWJmvvGUaGiotgM+OhdcNai
         c2UgVM4iPCXEPSlPO14rPUyOkxgc0sF0R5XVi1Us=
Date:   Mon, 11 May 2020 22:32:23 +0100
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
Message-ID: <20200511213223.GB23852@sirena.org.uk>
References: <20200306131048.ADBE18030797@mail.baikalelectronics.ru>
 <20200508105304.14065-1-Sergey.Semin@baikalelectronics.ru>
 <20200508105304.14065-5-Sergey.Semin@baikalelectronics.ru>
 <20200508112604.GJ185537@smile.fi.intel.com>
 <20200508115334.GE4820@sirena.org.uk>
 <20200511021016.wptcgnc3iq3kadgz@mobilestation>
 <20200511115813.GG8216@sirena.org.uk>
 <20200511134502.hjbu5evkiuh75chr@mobilestation>
 <20200511174414.GL8216@sirena.org.uk>
 <20200511183247.y6cfss22pe67nouf@mobilestation>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Yylu36WmvOXNoKYn"
Content-Disposition: inline
In-Reply-To: <20200511183247.y6cfss22pe67nouf@mobilestation>
X-Cookie: APL hackers do it in the quad.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 11, 2020 at 09:32:47PM +0300, Serge Semin wrote:

> Thanks for the explanation. Max segment size being set to the DMA controller generic
> device should work well. There is no need in setting the transfer and messages
> size limitations. Besides I don't really see the
> max_transfer_size/max_message_size callbacks utilized in the SPI core. These
> functions are called in the spi-mem.c driver only. Do I miss something?

We really should validate them in the core but really they're intended
for client drivers (like spi-mem kind of is) to allow them to adapt the
sizes of requests they're generating so the core never sees anything
that's too big.  For the transfers we have a spi_split_transfers_maxsize()
helper if anything wants to use it.  Fortunately there's not that many
controllers with low enough limits to worry about so actual usage hasn't
been that high.

--Yylu36WmvOXNoKYn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl65xGYACgkQJNaLcl1U
h9CMpAf/T2v9WB98ZVIJ2WXZ3oWO8rPy0Y2A3XVDzHMHMF42Arr3PBNm1h5Oar7r
MateSJ9BBaa0GomtFvuqaY+XcTMwDXzyqqaQjdIAwc0Qoq/lk1HHJIxc3W+sSHPh
IvczXH7NChx0jqhs7OQL6G6A5SRxDUVAUvc7cO9wyIJTPzIknKenktHxejqcaayo
nQNuA3tnXAnRHFIJ3IyoXZECF7cYwXUoYyru14CYJ1rF4I58VfPXDf5DqdbNj5x+
5TCcmIo0G/ZNVVWFlGgHWrceHDwS1CvHAWRji7K6jKtcHHEVfGkwUCyhnSvNWxbv
K4lVFhkDMPb/oKCkNovArUDFcrd8gA==
=XNTS
-----END PGP SIGNATURE-----

--Yylu36WmvOXNoKYn--
