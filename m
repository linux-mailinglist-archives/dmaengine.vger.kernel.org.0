Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A52633ED55
	for <lists+dmaengine@lfdr.de>; Wed, 17 Mar 2021 10:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbhCQJqr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 17 Mar 2021 05:46:47 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:49535 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229602AbhCQJqf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 17 Mar 2021 05:46:35 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 39FC15807E1;
        Wed, 17 Mar 2021 05:46:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 17 Mar 2021 05:46:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=SD34cQGILclXIBMZGly7bJwgwkZ
        qQWYs+kYonejcnrM=; b=LGjaXQhsw8y3FcJJpYiFSX9hUmwn3rGVPI5pKLIXWWO
        Zo0giPc1ksLmjWwTJiFuh7gOe6j8Lywf32/Q3bl82L3bGjOXxVnC59VBsowhuW7R
        qqxzr5qGy3kBZJsvbi2eWcX9u971CEgR4NtIWhvMoMsjK4kMN+5SnZjnzRWITQSd
        i5Yn0EdDi6sG+G6oUXVHmCP1GiF4fFFKnDmz9rrt41tPiwdaMIry+CqBoa4LEui4
        pDfK6mgb9BsmdoLi8ztEekuJ+3J7kd8FHGg71QEYnfqbxdBiPNUodF6sXBpZuMDO
        YX/GgBiAwZcvv9IhNz8YluIEi+INwiT2zcNhtinwdQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=SD34cQ
        GILclXIBMZGly7bJwgwkZqQWYs+kYonejcnrM=; b=gPfsLje6k/bE0/md5mMNSy
        4ZclrFr8JzjQMGl0hbxE3NxCMzWDbIiFRS0Y+HxCRb/6t/6CqZFBW9REfW7NADVJ
        cIfkwPq5JcugshE6DEF3+jrn1tydXYX7oXaoYpPxqFrD35pulpPWpOo5Mhd+rQQM
        dv5Gq9H/SuOe++/exqU+bJFgC6o1I2kOnjLTzmDKfClW2lp3T44LHYLyYzZTTgLD
        S8uS9ql6Swpe8lfTuZ8X6jiCQ5VPgHuIklj/Qq/FMLJ7eLY1rP1vAMckgwlxY2gM
        qPxZ8rBPD+kpxc650PnnsIcADSlEdt4lgzKTC1vqcoUwS4ks72EPOYe8BTiuLW2w
        ==
X-ME-Sender: <xms:-M9RYIc7wRP4P61V7YTZc2lBuIl5_rXScWXvH90bmTfx_87BqXmOWw>
    <xme:-M9RYKO-Kz9mRQ_k2S1YRnQVGydTJhg90l6rBh-MWWdx4PyuknlNFKookk2f8IVLW
    3YN-pfqGPFzwSL3qog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudefgedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:-M9RYJj1ikL-JB3URR9P1T2v4FoDwMlAF5bO250WX9hbkENVdjZsWw>
    <xmx:-M9RYN-N1Kp5qvqK6uResQOxDOgcNOVZxZYwLNYf6lrV41kEpY7kOA>
    <xmx:-M9RYEuGzhsWi6z8fYtIx9-knLw56_jz3ZNGbhwMRyHWe00IYuxGDg>
    <xmx:-s9RYMQp3nwLiMpINNRYwO9uxVqaGmJd7EFTmIhA5IDfBeRfJPsryA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 801FA24005A;
        Wed, 17 Mar 2021 05:46:32 -0400 (EDT)
Date:   Wed, 17 Mar 2021 10:46:30 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, Vinod Koul <vkoul@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-clk@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-i3c@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Clean-up undocumented compatible strings
Message-ID: <20210317094630.7ethkxrmmrihr6a2@gilmour>
References: <20210316194918.3528417-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fneuf23rsjk3gu7p"
Content-Disposition: inline
In-Reply-To: <20210316194918.3528417-1-robh@kernel.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--fneuf23rsjk3gu7p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 16, 2021 at 01:49:18PM -0600, Rob Herring wrote:
> Adding checks for undocumented compatible strings reveals a bunch of
> warnings in the DT binding examples. Fix the cases which are typos, just
> a mismatch between the schema and the example, or aren't documented at al=
l.
> In a couple of cases, fixing the compatible revealed some schema errors
> which are fixed.
>=20
> There's a bunch of others remaining after this which have bindings, but
> those aren't converted to schema yet.
>=20
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-clk@vger.kernel.org
> Cc: dmaengine@vger.kernel.org
> Cc: linux-i3c@lists.infradead.org
> Cc: linux-iio@vger.kernel.org
> Cc: linux-leds@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: linux-serial@vger.kernel.org
> Cc: linux-spi@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../clock/allwinner,sun4i-a10-pll1-clk.yaml   |  2 +-
>  .../bindings/clock/milbeaut-clock.yaml        | 12 +++++----
>  .../bindings/display/brcm,bcm2835-dsi0.yaml   |  6 -----
>  .../bindings/display/panel/panel-dpi.yaml     |  2 +-
>  .../devicetree/bindings/dma/qcom,gpi.yaml     |  2 +-
>  .../devicetree/bindings/i3c/i3c.yaml          |  7 ++---
>  .../iio/adc/brcm,iproc-static-adc.yaml        |  5 ----
>  .../iio/gyroscope/nxp,fxas21002c.yaml         |  2 +-
>  .../bindings/iio/light/upisemi,us5182.yaml    |  4 +--
>  .../interrupt-controller/loongson,htpic.yaml  |  2 +-
>  .../devicetree/bindings/leds/leds-lgm.yaml    | 26 ++++++++++++++++---
>  .../bindings/phy/ti,phy-j721e-wiz.yaml        |  2 +-
>  .../bindings/power/supply/cw2015_battery.yaml |  2 +-
>  .../bindings/power/supply/power-supply.yaml   | 22 ----------------
>  .../devicetree/bindings/serial/serial.yaml    |  2 +-
>  .../bindings/spi/amlogic,meson-gx-spicc.yaml  |  4 +--
>  .../bindings/spi/spi-controller.yaml          | 21 ++++++++-------
>  .../devicetree/bindings/spi/spi-mux.yaml      |  8 ++----
>  .../devicetree/bindings/spi/st,stm32-spi.yaml |  6 -----
>  19 files changed, 58 insertions(+), 79 deletions(-)

Acked-by: Maxime Ripard <maxime@cerno.tech>

Thanks!
Maxime

--fneuf23rsjk3gu7p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYFHP9gAKCRDj7w1vZxhR
xbrkAQCgtB5ZHt3TGhS2VGicZoo9ghf09d2rbv2UE4BnJiY2+gD9G7JtdZB5MEDD
GsoP7v+XURdek0PTMadCRwdIJ+V0egc=
=XZE5
-----END PGP SIGNATURE-----

--fneuf23rsjk3gu7p--
