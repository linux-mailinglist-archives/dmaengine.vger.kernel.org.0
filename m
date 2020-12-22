Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 705F62E0DBB
	for <lists+dmaengine@lfdr.de>; Tue, 22 Dec 2020 18:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgLVRNo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 22 Dec 2020 12:13:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:39170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727019AbgLVRNo (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 22 Dec 2020 12:13:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 55FD023130;
        Tue, 22 Dec 2020 17:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608657183;
        bh=QMc+Cnpq+Ddufqm1c2v+CyjZvDCdSht11+jAolorCxc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CS8JHhYJ5YgSDZlA0NjddtfXZTgC1Z3fcs9vuoi16+oLbWh1G5PYb9vwKVtKP5GLr
         lR1+78rQs7PignJx8koBMFyh8hotAVDad2YdUA7VBpKiojVDS19+wF/eFn2v+edEd1
         LGqhA/5YmxSoCXmykV9Yc6JaQuZkIpCKexegWD9NNXu/AdFkB5QbrYSK2syTKs4/Hw
         0oCTvLQQbSCuNzPkPxpwSg0I4HorrI8HV93jqjnBASNPVV0i/e4KRMwM3YnrVhDapW
         cgDVQLzlfrq5tgSsx/4OXx/TWUiA9rAdZrJsJ+W9cBdPTIgF/tJH1S4EopLxCltqTN
         aAq7zIHqO7iGw==
Date:   Tue, 22 Dec 2020 17:12:47 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        dri-devel@lists.freedesktop.org, dmaengine@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Drop redundant maxItems/items
Message-ID: <20201222171247.GB5269@sirena.org.uk>
References: <20201222040645.1323611-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uQr8t48UFsdbeI+V"
Content-Disposition: inline
In-Reply-To: <20201222040645.1323611-1-robh@kernel.org>
X-Cookie: Truth can wait
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 21, 2020 at 09:06:45PM -0700, Rob Herring wrote:
> 'maxItems' equal to the 'items' list length is redundant. 'maxItems' is
> preferred for a single entry while greater than 1 should have an 'items'
> list.

Acked-by: Mark Brown <broonie@kernel.org>

--uQr8t48UFsdbeI+V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/iKQ4ACgkQJNaLcl1U
h9BplAgAgMSrJkYiQbh1znz9wN7xnXMTpux0VVJprS9HHh2tnjwzlKS947zZ0q3u
8Mt9Y+XyQf0uqpNcqskq47lPHRMP7Ijo8abvyVe09UYQ/abIojhriXFwRJyOnt3A
U35kRF1wvK7ppmCtZy7uSgLuB3JcEuvJiYHN33BCvxBYYmpNl0fnt2/XHO0tm9q+
8R7+asRLB41jBvgGzhDXg8Iw4XwNLvpVStuU89rxIJhon2jacFTcDyI51B45kCRh
CoqhVphzpvpD0ySa4C7I0GAL6tXmBOt+NYpEChvE4OKgldYl9KiYMBsNdZmtmkuG
c36cabybF2Yn8Y1UN/YJ3NTKvarpKg==
=7Cxt
-----END PGP SIGNATURE-----

--uQr8t48UFsdbeI+V--
