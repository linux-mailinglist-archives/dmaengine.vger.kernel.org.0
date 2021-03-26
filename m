Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FABD34A76E
	for <lists+dmaengine@lfdr.de>; Fri, 26 Mar 2021 13:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbhCZMlG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 Mar 2021 08:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhCZMlD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 26 Mar 2021 08:41:03 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED80C0613AA;
        Fri, 26 Mar 2021 05:41:02 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id h13so6141790eds.5;
        Fri, 26 Mar 2021 05:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ai/sBaJhqrRCWGFUEsUnLWF/QfwBQ52U7SGdirULJxA=;
        b=uCjETYGYNoXkWFnAnxrREMGnWCf4CT3WkSUcUIwelIYp/DG4PNHW59MxV0ndLkmKgw
         L2IWwNo6EyYyTYDtD8OnYmHTc3e6jv9884w6qBn83ztCcGKzBTfT9VZi4FrsY0fAmdgD
         ur9rC0Au9YibHKnhDtRtnuR6TmiDKHMLiKkdFQBru/Rg3CNOG0AO1xf2t/BfGdTfqqmA
         XwvFfXkcKbOAT7hy7hseEdn4+/SVJmzCmlcRTdfpBXzf34azVckBOAtF5T9AGODNsmHi
         JB9fYSTh7FLf8XAc67eXw0GuTEJ4SVHnGJeGbaLRFM/fngNYTBDvYjVjkIiDqEkKOz/Z
         NJ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ai/sBaJhqrRCWGFUEsUnLWF/QfwBQ52U7SGdirULJxA=;
        b=PskyuHmVOQ7HEj1LDTVXQ1f6BBNHgfkTXhdCl8prHgTNxtonMOGlIHSwp2tZCSeXHB
         bXdyGgXwkqzKkPvCDXO9FNpEA5M24TEazXVLarTHCnB7sOff0fCcXMO1YPB7rQEE0kcu
         oi1ObVOy5AoV0S763IeokLDhDQF+SWDjRyQdaGN9YZehJNDADc8ch0fFirS/S8RG4xT9
         mSHRFt/wSLQaXoQHNKnwD9Szs89YpTchjEd3clrg0Kr+59M2Fuh7f+rrHCTPP7L1scAk
         dDvYzuNF/VKpc0ohE7+itMixgpjVSko4NtZhGm1kL5ZvgRTiuTo0lLpFrTxs5bQrM+fm
         BHzA==
X-Gm-Message-State: AOAM533MrmKCwoOhVpgX7K1zK5BOuc0VyOXlaQkLTpT8UwRc3c1KN2xT
        KuD8J3nimkYrTTxxhky1UGI=
X-Google-Smtp-Source: ABdhPJyBfhRplv3kSXtcQVbf9j3CtTsxKbJ2vdFf6xxPS0KZwTr0+U5i0X7OFEFWWah2Xup+2PjS6w==
X-Received: by 2002:a05:6402:254f:: with SMTP id l15mr14885368edb.189.1616762461102;
        Fri, 26 Mar 2021 05:41:01 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id x1sm3830371eji.8.2021.03.26.05.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 05:40:59 -0700 (PDT)
Date:   Fri, 26 Mar 2021 13:41:22 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
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
Message-ID: <YF3WctL0BJON130C@orome.fritz.box>
References: <20210316194918.3528417-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="anrc3HovXG4wMGPC"
Content-Disposition: inline
In-Reply-To: <20210316194918.3528417-1-robh@kernel.org>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--anrc3HovXG4wMGPC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

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

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--anrc3HovXG4wMGPC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBd1nIACgkQ3SOs138+
s6EKNw/+PWZ5d3e0xEwvPK7F2Ar6aLwrAZTugsDRjLWV08E7tyOy+G9o7fONJcWa
rYcXHvrQzc3Vr6/H0Aht9gv8h4N1ouQlIYbKkommVUDHWZlKKKKuf2UW9DeIzbLp
jRdHkqZsdlRy/1UZGl7oXPsDf+OIYG04QbOA1+uBhqW+BdpfEC59ouN/KDCou9aq
7JvFVhtOB5SZBDQhNNyY9VINpf7uHivV+onqfwg40fO/QTkYaHINb29gb73NBZWr
fqP16h7YrpKw+JqePYucWisMfZ8hubG6mNypAlhnRBdaqhoPm+OwmRFfbb9hE0f4
VtTBHT2HndgpshRyqJZegJUueeRQX5scz0IYfDdpHSvJ/+bvZ3HwmxOG3XHOIsEz
o36PE9KKIX3b9PZqEtMrNfnC7a9KzlnGJzQ0N+ZKvNZufnlkpbGuKC2PN/gTnADi
p6Shg4Nz6Jg67p2nWhIoFWMA1sYd1b18urfFn133K3B4R+6ox7NfDl7jDoLO//rO
qxgp4aySmSZyGC0LnhX/rjThoVGggs/Ph99sxbDaObX1bed7K/3MVfuFHv9dgNxq
BMerE+S1zd+XdeI1iSdQ459gqtFuWyTNTX4Atm3ddd+7P1Ay7iRMjyAjZ5MgwUvn
NUVQ+ss5oAt4BguhMPXeKvkkJEDQWl8xSzXm5qd39jSxZ06FAL8=
=w24T
-----END PGP SIGNATURE-----

--anrc3HovXG4wMGPC--
