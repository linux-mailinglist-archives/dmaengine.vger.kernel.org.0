Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491B5500B1A
	for <lists+dmaengine@lfdr.de>; Thu, 14 Apr 2022 12:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbiDNKbu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 14 Apr 2022 06:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241834AbiDNKbt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 14 Apr 2022 06:31:49 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDC3FC9
        for <dmaengine@vger.kernel.org>; Thu, 14 Apr 2022 03:29:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 89B74CE292C
        for <dmaengine@vger.kernel.org>; Thu, 14 Apr 2022 10:29:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02163C385A5;
        Thu, 14 Apr 2022 10:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649932162;
        bh=NVCX9XRjtVkfZkMq6lnnXLzxuKXz8YkTsns499QHdj8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tf5Y0i1TQR9xlzKJ8ku9Tgdd0Ba8ntqqcTgxb7g4rNsoVaD8MyeylGdx4T6lI411i
         P4X+Pww8YBvmBui6u5YLuVAkpiIcuU/qTxRKtEID1gwrm7VffjNX9+ZsOly2/A4CPK
         /ZF3/Lynz3przf19KYW87UUd/8yxVsEseoBrBLQM7PsvIfWPEgu+vweZSmG5snp/9H
         +popEuLmWAJIx+6FJWap7RN6DTbBuS6waqHtiIc7HpW2+WlW2nxiuhcQTQR0O3/zkH
         HFLLvxw0Lzk3mW7I3sab3PbL0/vY3FP4kzwIkrN9MIsr7crRuKCl1DdiA9N0jctRml
         +Me3awv3prk1w==
Date:   Thu, 14 Apr 2022 11:29:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     alsa-devel@alsa-project.org, Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>, kernel@pengutronix.de,
        Vinod Koul <vkoul@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH v5 00/21] ASoC: fsl_micfil: Driver updates
Message-ID: <Ylf3fAU5TV/RnHBW@sirena.org.uk>
References: <20220408112928.1326755-1-s.hauer@pengutronix.de>
 <20220414075114.GC2387@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0MtUBW2crG30UMoy"
Content-Disposition: inline
In-Reply-To: <20220414075114.GC2387@pengutronix.de>
X-Cookie: Available while quantities last.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--0MtUBW2crG30UMoy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 14, 2022 at 09:51:14AM +0200, Sascha Hauer wrote:

> Ok to apply this series? I just realized that I missed to Cc: you on
> this series. Let me know if I should resend.

Please resend.  What's the plan with the dmaengine bits - it looks like
the ASoC bits are relatively substatantial here?

--0MtUBW2crG30UMoy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJX93sACgkQJNaLcl1U
h9BZqwf/Sz0ZbUHbd7F/7Wkgdp4rn8hEyQE0ytnOC3YYvmgcD9VzWXB5MIaZ+8ln
f4Iiayqh+oeL3fFmMMziTzg/ExD9fq1WzVbKrCavZ7VrbsYwz/5q3FIdt78UL393
+HcMaFb9SCe39Oll78CJuPymVNDqQsiKU6jgr8HxerQJXWOIFkS5AN9wD/Ty4ePr
m52je0qAlUwMt8ghxEPjakD2svtM7aDvl5UxiYZcwCO+hCXI67ZY/M10QsNF4W/r
XamSmp+JeKKYKvbr0jfjtQ9fM0UrlnrJzhW+0fMuHynJy1+cGVTno1gwSqccN16H
X3yos1ltE56mcJ9A5klumtgDLv+nCw==
=EFgn
-----END PGP SIGNATURE-----

--0MtUBW2crG30UMoy--
