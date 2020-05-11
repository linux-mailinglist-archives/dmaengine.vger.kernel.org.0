Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB091CE200
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2020 19:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbgEKRsE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 May 2020 13:48:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:47228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbgEKRsD (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 11 May 2020 13:48:03 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0F2F206D6;
        Mon, 11 May 2020 17:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589219283;
        bh=wMEMJYTv7QV0ECsZmoOg8Kr2JK7/KvfUPQh00brbquI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NHW97AiwEUgFPiC2JXkXrlrBnms7ixFyLSl/kfMXK3WJWFNSOMDf8lEPJKfCVQLS/
         OBkZcgbGx5PgH4HODCmGlO6+3EHYA3AAe3Zwyc1fRUn0X9MfIi1w/PmP+qQV8dU06h
         k+i6kgGtq6xyeDdbEM0jlxTYkob9FnLUT3fwYu2Q=
Date:   Mon, 11 May 2020 18:48:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
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
        devicetree <devicetree@vger.kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/6] dmaengine: dw: Print warning if multi-block is
 unsupported
Message-ID: <20200511174800.GM8216@sirena.org.uk>
References: <20200306131048.ADBE18030797@mail.baikalelectronics.ru>
 <20200508105304.14065-1-Sergey.Semin@baikalelectronics.ru>
 <20200508105304.14065-5-Sergey.Semin@baikalelectronics.ru>
 <20200508112604.GJ185537@smile.fi.intel.com>
 <20200508115334.GE4820@sirena.org.uk>
 <20200511021016.wptcgnc3iq3kadgz@mobilestation>
 <20200511115813.GG8216@sirena.org.uk>
 <20200511134502.hjbu5evkiuh75chr@mobilestation>
 <CAHp75VdOi1rwaKjzowhj0KA-eNNL4NxpiCeqfELFgO_RcnZ-xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iAzLNm1y1mIRgolD"
Content-Disposition: inline
In-Reply-To: <CAHp75VdOi1rwaKjzowhj0KA-eNNL4NxpiCeqfELFgO_RcnZ-xw@mail.gmail.com>
X-Cookie: TANSTAAFL
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--iAzLNm1y1mIRgolD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 11, 2020 at 04:58:53PM +0300, Andy Shevchenko wrote:
> On Mon, May 11, 2020 at 4:48 PM Serge Semin

> > So the question is of how to export the multi-block LLP flag from DW DMAc
> > driver. Andy?

> I'm not sure I understand why do you need this being exported. Just
> always supply SG list out of single entry and define the length
> according to the maximum segment size (it's done IIRC in SPI core).

If there's a limit from the dmaengine it'd be a bit cleaner to export
the limit from the DMA engine (and it'd help with code reuse for clients
that might work with other DMA controllers without needing to add custom
compatibles for those instantiations).

--iAzLNm1y1mIRgolD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl65j9AACgkQJNaLcl1U
h9CW7Qf/WGO8TNWVzyUGl/3wXiPWSDeKL6mPAy3EcUtkcXRuUnK07U+BAtkYT7c/
R+5/XKdntnpIGjzQAZRmYkJEh6Jxjjh+AIep/mWOMTF/DsyI1SD5wqKiFbTtm3oS
TtVssPbTrfMQBa4TygfXjr5eTTLaShLK4Jn9S2sWSwk+Exhsu2BJfCBPYJkZO1Vr
dA0mvt6Yka80WEMDnSa5iVsScFre0+x/9aMRLEFnHfbZz1QLj9XrjMXJo3zB21zn
t3ZvfPlgjq0bCGCwpxS87A8Iti565Ot9EK3z6TzFW4t+jxm9EVsSMFrbw1/0JU94
HWu8ra8zI8sxBaQXhFl2HPANU0bAPg==
=hNqm
-----END PGP SIGNATURE-----

--iAzLNm1y1mIRgolD--
