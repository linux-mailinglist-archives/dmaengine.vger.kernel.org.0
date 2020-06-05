Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52DB91EFC0F
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jun 2020 17:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgFEPBG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 5 Jun 2020 11:01:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:58854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727857AbgFEPBG (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 5 Jun 2020 11:01:06 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83F232065C;
        Fri,  5 Jun 2020 15:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591369266;
        bh=atSo0Qb+rMrsZv5QANKFcbcUcwoez30MfjPtT8ppNS8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iNOTh3GVfGr8Oi8u3jquG56gWGC7TwnPsXkrbsAbPb8no4OYQZMIe9uExtbQjaTy9
         gN0gj1O7xUzlW4M5FuRDzTu1MTHRk5b2MVEdO6hxErTu4/ctKjd4fisO4gD4RRctgv
         mk+YqE/s7yEhcLm0OsNy9zGIzVtS6bdm06fJsPTI=
Date:   Fri, 5 Jun 2020 16:01:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     mark.rutland@arm.com, robh+dt@kernel.org, catalin.marinas@arm.com,
        vkoul@kernel.org, will.deacon@arm.com, shawnguo@kernel.org,
        festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-imx@nxp.com, dmaengine@vger.kernel.org
Subject: Re: [PATCH v9 05/14] spi: imx: fallback to PIO if dma setup failure
Message-ID: <20200605150103.GG5413@sirena.org.uk>
References: <1591392755-19136-1-git-send-email-yibin.gong@nxp.com>
 <1591392755-19136-6-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+sHJum3is6Tsg7/J"
Content-Disposition: inline
In-Reply-To: <1591392755-19136-6-git-send-email-yibin.gong@nxp.com>
X-Cookie: Air is water with holes in it.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--+sHJum3is6Tsg7/J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 06, 2020 at 05:32:26AM +0800, Robin Gong wrote:
> Fallback to PIO in case dma setup failed. For example, sdma firmware not
> updated but ERR009165 workaroud added in kernel.

Please do not submit new versions of already applied patches, please
submit incremental updates to the existing code.  Modifying existing
commits creates problems for other users building on top of those
commits so it's best practice to only change pubished git commits if
absolutely essential.

--+sHJum3is6Tsg7/J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7aXi8ACgkQJNaLcl1U
h9ACrwf/RD2Rv/jpt2YPaf64q5u9KvPJTvEmVU5U5Bntbxu4kMr9w/H6cT0QyhUg
pfOGftQDcUXm9x+HC0Q+xC3+bPmgzzzbjGZLxMfVfgvpyV6JJ+GhTVX/LjR6Jpi+
eyVMWffvIVKSZH8PO+nymh1/fcrOLbz3g+6D7fQJ+XNh7XmJJV0ysIpE/43KLvZs
X4netF+zcPwX2jBYdDpP0WRi+yzBDaJSNv3rV2AJgxO0Yug7d31On8HkRYxCoMaz
q0RJ/8s/ol2Pv0uT8GaVF7wJbDLA4XKhR53l4EeaBluFn9bh9lLYf9i3Mi53mbJQ
2XlQLzL/GxTo2szSSv9mBII/D6nXaA==
=LU0r
-----END PGP SIGNATURE-----

--+sHJum3is6Tsg7/J--
