Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6CAC1CAA06
	for <lists+dmaengine@lfdr.de>; Fri,  8 May 2020 13:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgEHLxi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 8 May 2020 07:53:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:43806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbgEHLxh (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 8 May 2020 07:53:37 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F28420708;
        Fri,  8 May 2020 11:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588938816;
        bh=jzJEqUl7O2hoMsDgMhYgkpN3Z6UxDEbLpvdrbJ3KRrI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=unZZyYdpUTKrHMtCm8KsBWR5frLQlAiisCSejaTBg+JDqqEeVcSetcJfh4htKJXWr
         H1XUC2+vGwayrJFMuiJo6HOc/OwQPwy6RSE5unyim2rfFgJKQ9na6uaHNNjeWmlVqR
         DxOrv4P7w22gfrFLPRfxDx3bfzuUWoLwSqiG0SlQ=
Date:   Fri, 8 May 2020 12:53:34 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Vinod Koul <vkoul@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Serge Semin <fancer.lancer@gmail.com>,
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
Message-ID: <20200508115334.GE4820@sirena.org.uk>
References: <20200306131048.ADBE18030797@mail.baikalelectronics.ru>
 <20200508105304.14065-1-Sergey.Semin@baikalelectronics.ru>
 <20200508105304.14065-5-Sergey.Semin@baikalelectronics.ru>
 <20200508112604.GJ185537@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="N1GIdlSm9i+YlY4t"
Content-Disposition: inline
In-Reply-To: <20200508112604.GJ185537@smile.fi.intel.com>
X-Cookie: Give him an evasive answer.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--N1GIdlSm9i+YlY4t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 08, 2020 at 02:26:04PM +0300, Andy Shevchenko wrote:
> On Fri, May 08, 2020 at 01:53:02PM +0300, Serge Semin wrote:

> > Multi-block support provides a way to map the kernel-specific SG-table so
> > the DW DMA device would handle it as a whole instead of handling the
> > SG-list items or so called LLP block items one by one. So if true LLP
> > list isn't supported by the DW DMA engine, then soft-LLP mode will be
> > utilized to load and execute each LLP-block one by one. A problem may
> > happen for multi-block DMA slave transfers, when the slave device buffers
> > (for example Tx and Rx FIFOs) depend on each other and have size smaller
> > than the block size. In this case writing data to the DMA slave Tx buffer
> > may cause the Rx buffer overflow if Rx DMA channel is paused to
> > reinitialize the DW DMA controller with a next Rx LLP item. In particular
> > We've discovered this problem in the framework of the DW APB SPI device

> Mark, do we have any adjustment knobs in SPI core to cope with this?

Frankly I'm not sure I follow what the issue is - is an LLP block item
different from a SG list entry?  As far as I can tell the problem is
that the DMA controller does not support chaining transactions together
and possibly also has a limit on the transfer size?  Or possibly some
issue with the DMA controller locking the CPU out of the I/O bus for
noticable periods?  I can't really think what we could do about that if
the issue is transfer sizes, that just seems like hardware which is
never going to work reliably.  If the issue is not being able to chain
transfers then possibly an option to linearize messages into a single
transfer as suggested to cope with PIO devices with ill considered
automated chip select handling, though at some point you have to worry
about the cost of the memcpy() vs the cost of just doing PIO.

> > working in conjunction with DW DMA. Since there is no comprehensive way to
> > fix it right now lets at least print a warning for the first found
> > multi-blockless DW DMAC channel. This shall point a developer to the
> > possible cause of the problem if one would experience a sudden data loss.

I thought from the description of the SPI driver I just reviewed that
this hardware didn't have DMA?  Or are there separate blocks in the
hardware that have a more standard instantiation of the DesignWare SPI
controller with DMA attached?

--N1GIdlSm9i+YlY4t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl61SD0ACgkQJNaLcl1U
h9DP6wf/dFDiSHbfTbYpSBNRkptpoGaeMDgglGVpj5gntGcn3CfTESvxjfYguuNL
N0xgW+7ee24CfMkR02v6ZvvKavFGKggBsOw/WjyHnltNYKXiY1vfdk+bDnVLoXEM
hq7TOqA7PZkP2ChJVoG7Vnd/WBFVpWKijUcYzv8t4T2ZaHO7tymWslrXwf0wHKgK
z9nxZa3131s4PqJdAG6PQ7AMDiTahYC8sRV+g3Kt7sNG/Ub/TWfjS1mjJ01t7uZq
BS6BvYsSGJgmKXqE9dqVkQMs/zttV8LFDK+ScuAArL/ReS0g1OUdNP4S8AiTUgNn
aqIe5ALvWnDBWfIi0sP1ZYXSHWI+sA==
=gYvy
-----END PGP SIGNATURE-----

--N1GIdlSm9i+YlY4t--
