Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6692733ED28
	for <lists+dmaengine@lfdr.de>; Wed, 17 Mar 2021 10:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhCQJiI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 17 Mar 2021 05:38:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:54088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229887AbhCQJhq (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 17 Mar 2021 05:37:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 29BE964F42;
        Wed, 17 Mar 2021 09:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615973866;
        bh=q9bt8ndbjgWxAXXGIz5ebDFuy1AD72zrKuf9BJMT8bc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dKseEiEQZ9mgB7GveqYx75p9oGGxxpkWJJI3OUSHagbtpzysp8p7hD80IfbPBT6sY
         JsbtN9XG7qCsLkaNw6rdcVDrlLLeJnTRO3VffmmeWUZ8+qNFesT0gilAm3X4no4emO
         ErWkKWxKVMbnNxTa/hIayA77OSr5a9Td9y0rPBTEKL4BHGHchbwVuoZ1FCHlzlHZiy
         XH4UJ8D8pgTdDyTPsmSJTX4ByiMuIbu8v2rSU8bBdLQAAgRW0F7X5e2oxAECB6XaTm
         TLP1OXt9V/lzq8vA6dnm7c9TR25RUegNO5qWyl1PddrbCQRBu/AEn3TVPb1N+LuErm
         elvkA1wuroDFQ==
Received: by earth.universe (Postfix, from userid 1000)
        id 0BDC93C0C96; Wed, 17 Mar 2021 10:37:44 +0100 (CET)
Date:   Wed, 17 Mar 2021 10:37:43 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, Vinod Koul <vkoul@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-clk@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-i3c@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Clean-up undocumented compatible strings
Message-ID: <20210317093743.t3oycycfs72coj6w@earth.universe>
References: <20210316194918.3528417-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qrhbcpdidyozg7aj"
Content-Disposition: inline
In-Reply-To: <20210316194918.3528417-1-robh@kernel.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--qrhbcpdidyozg7aj
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

Acked-by: Sebastian Reichel <sre@kernel.org>

-- Sebastian

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
>=20
> diff --git a/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-=
pll1-clk.yaml b/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10=
-pll1-clk.yaml
> index e9c4cf834aa7..e5d9d45dab8a 100644
> --- a/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-pll1-cl=
k.yaml
> +++ b/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-pll1-cl=
k.yaml
> @@ -44,7 +44,7 @@ examples:
>    - |
>      clk@1c20000 {
>          #clock-cells =3D <0>;
> -        compatible =3D "allwinner,sun4i-a10-pll1";
> +        compatible =3D "allwinner,sun4i-a10-pll1-clk";
>          reg =3D <0x01c20000 0x4>;
>          clocks =3D <&osc24M>;
>          clock-output-names =3D "osc24M";
> diff --git a/Documentation/devicetree/bindings/clock/milbeaut-clock.yaml =
b/Documentation/devicetree/bindings/clock/milbeaut-clock.yaml
> index 0e8b07710451..6d39344d2b70 100644
> --- a/Documentation/devicetree/bindings/clock/milbeaut-clock.yaml
> +++ b/Documentation/devicetree/bindings/clock/milbeaut-clock.yaml
> @@ -18,10 +18,12 @@ description: |
> =20
>  properties:
>    compatible:
> -    oneOf:
> -      - items:
> -          - enum:
> -              - socionext,milbeaut-m10v-ccu
> +    enum:
> +      - socionext,milbeaut-m10v-ccu
> +
> +  reg:
> +    maxItems: 1
> +
>    clocks:
>      maxItems: 1
>      description: external clock
> @@ -41,7 +43,7 @@ examples:
>    # Clock controller node:
>    - |
>      m10v-clk-ctrl@1d021000 {
> -        compatible =3D "socionext,milbeaut-m10v-clk-ccu";
> +        compatible =3D "socionext,milbeaut-m10v-ccu";
>          reg =3D <0x1d021000 0x4000>;
>          #clock-cells =3D <1>;
>          clocks =3D <&clki40mhz>;
> diff --git a/Documentation/devicetree/bindings/display/brcm,bcm2835-dsi0.=
yaml b/Documentation/devicetree/bindings/display/brcm,bcm2835-dsi0.yaml
> index 55c60919991f..32608578a352 100644
> --- a/Documentation/devicetree/bindings/display/brcm,bcm2835-dsi0.yaml
> +++ b/Documentation/devicetree/bindings/display/brcm,bcm2835-dsi0.yaml
> @@ -77,12 +77,6 @@ examples:
> =20
>          clock-output-names =3D "dsi1_byte", "dsi1_ddr2", "dsi1_ddr";
> =20
> -        pitouchscreen: panel@0 {
> -            compatible =3D "raspberrypi,touchscreen";
> -            reg =3D <0>;
> -
> -            /* ... */
> -        };
>      };
> =20
>  ...
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-dpi.ya=
ml b/Documentation/devicetree/bindings/display/panel/panel-dpi.yaml
> index 0cd74c8dab42..dae0676b5c6e 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-dpi.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-dpi.yaml
> @@ -40,7 +40,7 @@ additionalProperties: false
>  examples:
>    - |
>      panel {
> -        compatible =3D "osddisplays,osd057T0559-34ts", "panel-dpi";
> +        compatible =3D "startek,startek-kd050c", "panel-dpi";
>          label =3D "osddisplay";
>          power-supply =3D <&vcc_supply>;
>          backlight =3D <&backlight>;
> diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Docume=
ntation/devicetree/bindings/dma/qcom,gpi.yaml
> index f8142adf9aea..2e66840a78fe 100644
> --- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
> +++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
> @@ -64,7 +64,7 @@ examples:
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
>      #include <dt-bindings/dma/qcom-gpi.h>
>      gpi_dma0: dma-controller@800000 {
> -        compatible =3D "qcom,gpi-dma";
> +        compatible =3D "qcom,sdm845-gpi-dma";
>          #dma-cells =3D <3>;
>          reg =3D <0x00800000 0x60000>;
>          iommus =3D <&apps_smmu 0x0016 0x0>;
> diff --git a/Documentation/devicetree/bindings/i3c/i3c.yaml b/Documentati=
on/devicetree/bindings/i3c/i3c.yaml
> index 52042aa44d19..1f82fc923799 100644
> --- a/Documentation/devicetree/bindings/i3c/i3c.yaml
> +++ b/Documentation/devicetree/bindings/i3c/i3c.yaml
> @@ -157,9 +157,10 @@ examples:
>          i2c-scl-hz =3D <100000>;
> =20
>          /* I2C device. */
> -        nunchuk: nunchuk@52 {
> -            compatible =3D "nintendo,nunchuk";
> -            reg =3D <0x52 0x0 0x10>;
> +        eeprom@57 {
> +            compatible =3D "atmel,24c01";
> +            reg =3D <0x57 0x0 0x10>;
> +            pagesize =3D <0x8>;
>          };
> =20
>          /* I3C device with a static I2C address. */
> diff --git a/Documentation/devicetree/bindings/iio/adc/brcm,iproc-static-=
adc.yaml b/Documentation/devicetree/bindings/iio/adc/brcm,iproc-static-adc.=
yaml
> index c562d25bee3b..547697e8bc8b 100644
> --- a/Documentation/devicetree/bindings/iio/adc/brcm,iproc-static-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/brcm,iproc-static-adc.yaml
> @@ -53,11 +53,6 @@ examples:
>          #address-cells =3D <1>;
>          #size-cells =3D <1>;
> =20
> -        ts_adc_syscon: ts_adc_syscon@180a6000 {
> -            compatible =3D "brcm,iproc-ts-adc-syscon","syscon";
> -            reg =3D <0x180a6000 0xc30>;
> -        };
> -
>          adc {
>              compatible =3D "brcm,iproc-static-adc";
>              adc-syscon =3D <&ts_adc_syscon>;
> diff --git a/Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas2100=
2c.yaml b/Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.ya=
ml
> index d97ee774d6a6..3f57a1b813e6 100644
> --- a/Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.yaml
> +++ b/Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.yaml
> @@ -83,7 +83,7 @@ examples:
>          #size-cells =3D <0>;
> =20
>          gyroscope@0 {
> -          compatible =3D "nxp,fxas2102c";
> +          compatible =3D "nxp,fxas21002c";
>            reg =3D <0x0>;
> =20
>            spi-max-frequency =3D <2000000>;
> diff --git a/Documentation/devicetree/bindings/iio/light/upisemi,us5182.y=
aml b/Documentation/devicetree/bindings/iio/light/upisemi,us5182.yaml
> index de5882cb3360..dd78abe0ec8d 100644
> --- a/Documentation/devicetree/bindings/iio/light/upisemi,us5182.yaml
> +++ b/Documentation/devicetree/bindings/iio/light/upisemi,us5182.yaml
> @@ -11,12 +11,12 @@ maintainers:
> =20
>  properties:
>    compatible:
> -    const: upisemi,asd5182
> +    const: upisemi,usd5182
> =20
>    reg:
>      maxItems: 1
> =20
> -  upsemi,glass-coef:
> +  upisemi,glass-coef:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description: |
>        glass attenuation factor - compensation factor of resolution 1000
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/loong=
son,htpic.yaml b/Documentation/devicetree/bindings/interrupt-controller/loo=
ngson,htpic.yaml
> index d1d52d1db2be..d6bc1a687fc7 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/loongson,htp=
ic.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,htp=
ic.yaml
> @@ -47,7 +47,7 @@ examples:
>    - |
>      #include <dt-bindings/interrupt-controller/irq.h>
>      htintc: interrupt-controller@1fb000080 {
> -      compatible =3D "loongson,htintc-1.0";
> +      compatible =3D "loongson,htpic-1.0";
>        reg =3D <0xfb000080 0x40>;
>        interrupt-controller;
>        #interrupt-cells =3D <1>;
> diff --git a/Documentation/devicetree/bindings/leds/leds-lgm.yaml b/Docum=
entation/devicetree/bindings/leds/leds-lgm.yaml
> index 32bbf146c01d..f8d7963c3a13 100644
> --- a/Documentation/devicetree/bindings/leds/leds-lgm.yaml
> +++ b/Documentation/devicetree/bindings/leds/leds-lgm.yaml
> @@ -14,6 +14,17 @@ properties:
>    compatible:
>      const: intel,lgm-ssoled
> =20
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: sso
> +      - const: fpid
> +
>    gpio-controller: true
> =20
>    '#gpio-cells':
> @@ -36,8 +47,15 @@ properties:
> =20
>      additionalProperties: false
> =20
> +    properties:
> +      '#address-cells':
> +        const: 1
> +
> +      '#size-cells':
> +        const: 0
> +
>      patternProperties:
> -      "^led@[0-23]$":
> +      "^led@[0-2]$":
>          type: object
> =20
>          properties:
> @@ -81,7 +99,7 @@ examples:
>      #include <dt-bindings/leds/common.h>
> =20
>      ssogpio: ssogpio@e0d40000 {
> -      compatible =3D "intel,sso-led";
> +      compatible =3D "intel,lgm-ssoled";
>        reg =3D <0xE0D40000 0x2E4>;
>        gpio-controller;
>        #gpio-cells =3D <2>;
> @@ -103,8 +121,8 @@ examples:
>            led-gpio =3D <&ssogpio 0 0>;
>          };
> =20
> -        led@23 {
> -          reg =3D <23>;
> +        led@2 {
> +          reg =3D <2>;
>            function =3D LED_FUNCTION_POWER;
>            color =3D <LED_COLOR_ID_GREEN>;
>            led-gpio =3D <&ssogpio 23 0>;
> diff --git a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml =
b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
> index bbbd85501ada..d0040255c591 100644
> --- a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
> +++ b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
> @@ -218,7 +218,7 @@ examples:
>             };
> =20
>             serdes@5000000 {
> -                  compatible =3D "cdns,ti,sierra-phy-t0";
> +                  compatible =3D "ti,sierra-phy-t0";
>                    reg-names =3D "serdes";
>                    reg =3D <0x5000000 0x10000>;
>                    #address-cells =3D <1>;
> diff --git a/Documentation/devicetree/bindings/power/supply/cw2015_batter=
y.yaml b/Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml
> index 5fcdf5801536..c73abb2ff513 100644
> --- a/Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml
> @@ -61,7 +61,7 @@ examples:
>          #size-cells =3D <0>;
> =20
>          cw2015@62 {
> -            compatible =3D "cellwise,cw201x";
> +            compatible =3D "cellwise,cw2015";
>              reg =3D <0x62>;
>              cellwise,battery-profile =3D /bits/ 8 <
>                  0x17 0x67 0x80 0x73 0x6E 0x6C 0x6B 0x63
> diff --git a/Documentation/devicetree/bindings/power/supply/power-supply.=
yaml b/Documentation/devicetree/bindings/power/supply/power-supply.yaml
> index c5c55f627251..259760167759 100644
> --- a/Documentation/devicetree/bindings/power/supply/power-supply.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/power-supply.yaml
> @@ -18,25 +18,3 @@ properties:
> =20
>  additionalProperties: true
> =20
> -examples:
> -  - |
> -    power {
> -      #address-cells =3D <1>;
> -      #size-cells =3D <0>;
> -
> -      usb_charger:charger@e {
> -        compatible =3D "some,usb-charger";
> -        reg =3D <0xe>;
> -      };
> -
> -      ac_charger:charger@c {
> -        compatible =3D "some,ac-charger";
> -        reg =3D <0xc>;
> -      };
> -
> -      battery:battery@b {
> -        compatible =3D "some,battery";
> -        reg =3D <0xb>;
> -        power-supplies =3D <&usb_charger>, <&ac_charger>;
> -      };
> -    };
> diff --git a/Documentation/devicetree/bindings/serial/serial.yaml b/Docum=
entation/devicetree/bindings/serial/serial.yaml
> index 65e75d040521..eea300405816 100644
> --- a/Documentation/devicetree/bindings/serial/serial.yaml
> +++ b/Documentation/devicetree/bindings/serial/serial.yaml
> @@ -134,7 +134,7 @@ examples:
>              interrupts =3D <1>;
> =20
>              bluetooth {
> -                    compatible =3D "brcm,bcm43341-bt";
> +                    compatible =3D "brcm,bcm4330-bt";
>                      interrupt-parent =3D <&gpio>;
>                      interrupts =3D <10>;
>              };
> diff --git a/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc=
=2Eyaml b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
> index 667dedefd69f..e3fb553d9180 100644
> --- a/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
> +++ b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
> @@ -90,8 +90,8 @@ examples:
>            #address-cells =3D <1>;
>            #size-cells =3D <0>;
> =20
> -          ethernet-switch@0 {
> -              compatible =3D "micrel,ks8995m";
> +          display@0 {
> +              compatible =3D "lg,lg4573";
>                spi-max-frequency =3D <1000000>;
>                reg =3D <0>;
>            };
> diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/=
Documentation/devicetree/bindings/spi/spi-controller.yaml
> index 06786f1b43d2..0477396e4945 100644
> --- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
> @@ -181,22 +181,23 @@ additionalProperties: true
> =20
>  examples:
>    - |
> -    spi@f00 {
> +    spi@80010000 {
>          #address-cells =3D <1>;
>          #size-cells =3D <0>;
> -        compatible =3D "fsl,mpc5200b-spi","fsl,mpc5200-spi";
> -        reg =3D <0xf00 0x20>;
> -        interrupts =3D <2 13 0 2 14 0>;
> -        interrupt-parent =3D <&mpc5200_pic>;
> -
> -        ethernet-switch@0 {
> -            compatible =3D "micrel,ks8995m";
> +        compatible =3D "fsl,imx28-spi";
> +        reg =3D <0x80010000 0x2000>;
> +        interrupts =3D <96>;
> +        dmas =3D <&dma_apbh 0>;
> +        dma-names =3D "rx-tx";
> +
> +        display@0 {
> +            compatible =3D "lg,lg4573";
>              spi-max-frequency =3D <1000000>;
>              reg =3D <0>;
>          };
> =20
> -        codec@1 {
> -            compatible =3D "ti,tlv320aic26";
> +        sensor@1 {
> +            compatible =3D "bosch,bme680";
>              spi-max-frequency =3D <100000>;
>              reg =3D <1>;
>          };
> diff --git a/Documentation/devicetree/bindings/spi/spi-mux.yaml b/Documen=
tation/devicetree/bindings/spi/spi-mux.yaml
> index 6c21a132b51f..d09c6355e22d 100644
> --- a/Documentation/devicetree/bindings/spi/spi-mux.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-mux.yaml
> @@ -75,16 +75,12 @@ examples:
>              spi-flash@0 {
>                  compatible =3D "jedec,spi-nor";
>                  reg =3D <0>;
> -                #address-cells =3D <1>;
> -                #size-cells =3D <0>;
>                  spi-max-frequency =3D <40000000>;
>              };
> =20
> -            spi-device@1 {
> -                compatible =3D "lineartechnology,ltc2488";
> +            sensor@1 {
> +                compatible =3D "bosch,bme680";
>                  reg =3D <1>;
> -                #address-cells =3D <1>;
> -                #size-cells =3D <0>;
>                  spi-max-frequency =3D <10000000>;
>              };
>          };
> diff --git a/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml b/Do=
cumentation/devicetree/bindings/spi/st,stm32-spi.yaml
> index d11806b1ede3..2d9af4c506bb 100644
> --- a/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
> +++ b/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
> @@ -96,12 +96,6 @@ examples:
>        dma-names =3D "rx", "tx";
>        cs-gpios =3D <&gpioa 11 0>;
> =20
> -      aardvark@0 {
> -        compatible =3D "totalphase,aardvark";
> -        reg =3D <0>;
> -        spi-max-frequency =3D <4000000>;
> -        st,spi-midi-ns =3D <4000>;
> -      };
>      };
> =20
>  ...
> --=20
> 2.27.0
>=20

--qrhbcpdidyozg7aj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBRzd4ACgkQ2O7X88g7
+ppl9A/9GqjLPEUyeJtatXFTPijvQqBBdkBjb+Broe12cwWYVh9o7npJHXHSaRb1
iLq8pIRotI4ESOjiXvHNJE7hwwxpi0sLHQaXZ4y6OJJud7kTq7hgM8XMFJLU0w8i
E7BTARRLiUfKzwNa9V8MiDn8N5j2M2ye9PmR/d9VC2iDJab6swukYoJtm9uy0Fwl
+lplSOEcSb1rTSzXXlfB/LyFXbMKmeVy52Sh4XKa8Jypu4+lX5zHiDfBCYz/GL8l
dU7t4T8rya9f307Nbaz4qEzfP1ufovHEFh+DNBksUV40cbNY52CJ19h1wGD2RFKx
xl2hysyGZSSQhTVFxVZH9h0dmI/gacT5fHfWf9T4YvfGmKkCh55DuMNCRcmCKPGx
wwmlYB6m0newV0RFqunlY5lH1XNM+T6TOP/B3GSNYEsDQHQ4QAvsY6WfhDU7Tjxx
8xVPUVafrZ/M9ffl/s2pMj73jFIHeAIiv25asCAw56B827b3jqzDVxpjbkSa+Epf
El86nvkromNil53Q0zvSIwiof59dNK7i4xYXpOArqp5vxnsK94PqIPZOW4isIUXk
ulWrGW1MqTKpUWeVcOtsboo+MFUFkJdIEOohq4cj5tj4Q8YUUTqg6tapq6xft9CY
gXvZ2IGwk/4mDLcKdVC14Ms46GvVaaRmLCGIDbp4Ji2Uva+yiT4=
=15qI
-----END PGP SIGNATURE-----

--qrhbcpdidyozg7aj--
