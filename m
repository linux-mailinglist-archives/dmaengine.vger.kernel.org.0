Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8EE642984
	for <lists+dmaengine@lfdr.de>; Mon,  5 Dec 2022 14:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbiLENi0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 5 Dec 2022 08:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiLENiZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 5 Dec 2022 08:38:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7BDD117;
        Mon,  5 Dec 2022 05:38:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92022B810A7;
        Mon,  5 Dec 2022 13:38:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264DCC433D6;
        Mon,  5 Dec 2022 13:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670247501;
        bh=bekCWIrDwJwNJDJTYD0aY310Agll7BI3ZChFgpmI5KY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S45yVKvtI/1zr/G9DWLq+IHfh4MZvFeMUCqgxFSwqnWZNgzNtaE1rI8b8Mh8OdENc
         z9MeXaFGGtwDEcHo/O9MLAMbpfjV4b4wn0hiXcFDV3n35kdoECHNfXox5u5RYH4hk4
         qcgCe0uBUdS409fcbqWC3XbEw+oTg6VGjvNeQf0T05sdFNWnqReh2wvO+mgQkhUMG9
         kx/6FlCoM1+OLixBCiFAonzpFMnMbq9RtzyrcS7cws0VBKdiHBuke651RyQvX3aRkc
         HCSUJr/R90X3T3+LGUzSnFAoihWR2EN2j3OR0/d9BpSZpUssWZ8A58ue/FIOxuGQ7d
         K1ca4EHdLvKkg==
Date:   Mon, 5 Dec 2022 13:38:14 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        "Paul J. Murphy" <paul.j.murphy@intel.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH 1/2] dt-bindings: Drop Jee Heng Sia
Message-ID: <Y430RlENo2cjtl2r@sirena.org.uk>
References: <20221203162144.99225-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XKB8a64cbKHYLz9M"
Content-Disposition: inline
In-Reply-To: <20221203162144.99225-1-krzysztof.kozlowski@linaro.org>
X-Cookie: If it ain't broke, don't fix it.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--XKB8a64cbKHYLz9M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 03, 2022 at 05:21:43PM +0100, Krzysztof Kozlowski wrote:
> Emails to Jee Heng Sia bounce ("550 #5.1.0 Address rejected.").  Add
> Keembay platform maintainers as Keembay I2S maintainers.

Acked-by: Mark Brown <broonie@kernel.org>

--XKB8a64cbKHYLz9M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmON9EUACgkQJNaLcl1U
h9A33gf/b2Cog2bcg/VPxxlK5WyJaOySjZs31TN8cqPq2zwUIu7qOCxgsixtw4s8
/W6JP2IZC6GOKJay/Pq+EDrhFqkXghjYx7jI4K8JnL/EYb2J+VBAZ1d6GG2ixSd5
j911bMTNDkVFwV2rgCOyIrJBJ24jcy0E8SFuE97IjZBmgDYGtNyEWCouUVvpGcgM
0eCmv8Hmr4nWnj5Jz9TLsBpiRsH7GewlOHsJgpQJP21yPOKT1IDjWqslSZrVu1dY
8Fid5N2IX7DnmGOnhaEr4cCCAUWjmgp/sUQvPnjpPNbPWSbx2d8hIKi8DVDobfkR
a9Dls3HHAM0nh7/HWkaQq4j0gW6/NA==
=+Wfw
-----END PGP SIGNATURE-----

--XKB8a64cbKHYLz9M--
