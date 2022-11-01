Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A976149BD
	for <lists+dmaengine@lfdr.de>; Tue,  1 Nov 2022 12:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbiKALsH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 1 Nov 2022 07:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbiKALry (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 1 Nov 2022 07:47:54 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E85DEE4;
        Tue,  1 Nov 2022 04:40:21 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id a13so21406977edj.0;
        Tue, 01 Nov 2022 04:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GmDhui1fuCaXgbg430oH7yny2k6M/vj7S6F1BQ8jHzQ=;
        b=kNZxCYHyKpEf/VhYMlbdCM0GXt8X1ZLFnwkyKicobyel30LMpeY6HItBS0lE+CZTWV
         iAc+A7jKTPJhGj3ogsoozhxmFtURG7gshFOpQGRCWkPhBmehQ36p23sqQ6WeuFin82rQ
         4tCefaKN/zuFW7/DsgLpFnRtk2q6lzTHTNTc+ja6/liRrmS0NENoTCIFw4In56kuAEXd
         UbpNGdVb2Z2IN4ZJybhue2ClPgyLrmIuiZL7WqK3PFkDnGQVWRFnU15na3LPgRPyMDcw
         rvc94TOb69cNPjpaFRXYQJOXJNoEWOFpod7tEg3zQ3uOTxrRSFUeh2bpoVZlYQYe18jx
         n8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GmDhui1fuCaXgbg430oH7yny2k6M/vj7S6F1BQ8jHzQ=;
        b=pjYrCH+OWjCJ2yFPO95/fRQuFkKwpWMztYLA0915evz0+61MamJ3+Ks9eop2Td8cpR
         6l7AY6L1l4QmPvfEhqlee7yfcqY5USL1xFgJ4q1DqBW9wg9DRb5IbbWBqF2QspmHKQo8
         aXMLVM5r61nBBXGnpM99BzE6MtO1/R83fxU76pKM2iOuDnMv4e1pnrzGpEJe7rVkfUJr
         hEJuqquZ/d5SIEmxRxhCBPEq1+qFXnY+7pueIGe/WgVLYBswDfv/y6IGQLhzGtQZIkjv
         hPkzx+htKYUVO2EqGlOOPjdU945tSGgHk/dTaAOzcLrAOBgRAR7rO62/zX4wpwWahzZj
         6CPg==
X-Gm-Message-State: ACrzQf0ZR6MS3stOj/BO3+4ZhHea0oKKs/ge87S5keLKXg0UNrA2C/d5
        cYJ5RUCUNu3yGImJTVFTYR4mzHJvyzE=
X-Google-Smtp-Source: AMsMyM5AW45Zb4lvw6D/an20McEeD1S0voOspF4Vm3vpzNUWEMPSMeHLU/BYR/GoKjfQ3zkECFjipQ==
X-Received: by 2002:a05:6402:114a:b0:454:85e4:2295 with SMTP id g10-20020a056402114a00b0045485e42295mr19204344edw.348.1667302819300;
        Tue, 01 Nov 2022 04:40:19 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id y21-20020a1709060a9500b0078d76ee7543sm4077256ejf.222.2022.11.01.04.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 04:40:18 -0700 (PDT)
Date:   Tue, 1 Nov 2022 12:40:16 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Akhil R <akhilrajeev@nvidia.com>, Rob Herring <robh@kernel.org>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>
Subject: Re: [PATCH RESEND v2 3/3] dmaengine: tegra: Add support for
 dma-channel-mask
Message-ID: <Y2EFoG1H9YpfxRjs@orome>
References: <20221020083322.36431-1-akhilrajeev@nvidia.com>
 <20221020083322.36431-4-akhilrajeev@nvidia.com>
 <20221021021604.GA2181729-robh@kernel.org>
 <SJ1PR12MB63399B01D750CD4725A13A03C0309@SJ1PR12MB6339.namprd12.prod.outlook.com>
 <76617e20-2a1d-baba-719d-bd8b32fa69be@nvidia.com>
 <SJ1PR12MB6339F181734DA0A05B4862AFC0339@SJ1PR12MB6339.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oesM7UOI0DB+Ei+g"
Content-Disposition: inline
In-Reply-To: <SJ1PR12MB6339F181734DA0A05B4862AFC0339@SJ1PR12MB6339.namprd12.prod.outlook.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--oesM7UOI0DB+Ei+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 27, 2022 at 10:13:00AM +0000, Akhil R wrote:
> > On 26/10/2022 05:44, Akhil R wrote:
> > >> On Thu, Oct 20, 2022 at 02:03:22PM +0530, Akhil R wrote:
> > >>> Add support for dma-channel-mask so that only the specified channels
> > >>> are used. This helps to reserve some channels for the firmware.
> > >>>
> > >>> This was initially achieved by limiting the channel number to 31 in
> > >>> the driver and adjusting the register address to skip channel0 which
> > >>> was reserved for a firmware. Now, with this change, the driver can
> > >>> align more to the actual hardware which has 32 channels.
> > >>>
> > >>> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> > >>> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> > >>> ---
> > >>>   drivers/dma/tegra186-gpc-dma.c | 37 +++++++++++++++++++++++++++--=
--
> > ---
> > >>>   1 file changed, 30 insertions(+), 7 deletions(-)
> > >>>
> > >>> diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-=
gpc-
> > >> dma.c
> > >>> index fa9bda4a2bc6..1d1180db6d4e 100644
> > >>> --- a/drivers/dma/tegra186-gpc-dma.c
> > >>> +++ b/drivers/dma/tegra186-gpc-dma.c
> > >>> @@ -161,7 +161,10 @@
> > >>>   #define TEGRA_GPCDMA_BURST_COMPLETION_TIMEOUT        5000 /* 5
> > >> msec */
> > >>>
> > >>>   /* Channel base address offset from GPCDMA base address */
> > >>> -#define TEGRA_GPCDMA_CHANNEL_BASE_ADD_OFFSET 0x20000
> > >>> +#define TEGRA_GPCDMA_CHANNEL_BASE_ADDR_OFFSET        0x10000
> > >>> +
> > >>> +/* Default channel mask reserving channel0 */
> > >>> +#define TEGRA_GPCDMA_DEFAULT_CHANNEL_MASK    0xfffffffe
> > >>>
> > >>>   struct tegra_dma;
> > >>>   struct tegra_dma_channel;
> > >>> @@ -246,6 +249,7 @@ struct tegra_dma {
> > >>>        const struct tegra_dma_chip_data *chip_data;
> > >>>        unsigned long sid_m2d_reserved;
> > >>>        unsigned long sid_d2m_reserved;
> > >>> +     u32 chan_mask;
> > >>>        void __iomem *base_addr;
> > >>>        struct device *dev;
> > >>>        struct dma_device dma_dev;
> > >>> @@ -1288,7 +1292,7 @@ static struct dma_chan
> > *tegra_dma_of_xlate(struct
> > >> of_phandle_args *dma_spec,
> > >>>   }
> > >>>
> > >>>   static const struct tegra_dma_chip_data tegra186_dma_chip_data =
=3D {
> > >>> -     .nr_channels =3D 31,
> > >>> +     .nr_channels =3D 32,
> > >>
> > >> This is an ABI break. A new kernel with an old DTB will use 32 chann=
els
> > >> instead of 31. You should leave this and use the dma-channel-mask to
> > >> enable all 32 channels.
> > >>
> > > Hi Rob,
> > >
> > > If using an old DTB, tdma->chan_mask will be default to 0xfffffffe si=
nce it
> > > would not have the dma-channel-mask property. The driver would still
> > > use 31 channels even if it uses an old DTB. Shouldn't it prevent the
> > > ABI break?
> >=20
> > Unfortunately no. Yes for an old DTB without the dma-channel-mask
> > property, we set the channel mask to 0xfffffffe, but this is not correct
> > because it only has 31 interrupts/channels and not 32. So I think we
> > will need to use of_irq_count() here.
> >
>=20
> Shall I put it in a way that only the used interrupts are mentioned in th=
e DT?
> With this I can revert the interrupt change in the DT and would not break
> the ABI as well.
>=20
> The code would look something like this.
>=20
> int chan_count =3D 0;
>=20
> if (of_irq_count(pdev->dev.of_node) !=3D hweight_long(tdma->chan_mask)) {
>         dev_err(&pdev->dev, "Interrupt count doesn't match with channels\=
n");
>         return -EINVAL;
> }
>=20
> for (i =3D 0; i < cdata->nr_channels; i++) {
>         struct tegra_dma_channel *tdc =3D &tdma->channels[i];
>    =20
>         /* Check for channel mask */
>         if (!(tdma->chan_mask & BIT(i)))
>             continue;
>=20
>         tdc->irq =3D platform_get_irq(pdev, chan_count);
>         chan_count++;
>         if (tdc->irq < 0)
>             return tdc->irq;
>     ...
>     ...
> }

This is all getting quite complicated for what is essentially a bug fix.
The root of this problem is that the original bindings were simply wrong
and didn't accurately represent the hardware.

The GPC DMA controller has 32 channels and each channel has one DMA
interrupt. So the right way to describe this in DT is by listing all of
the interrupts. If the firmware then ends up using one of those channels
the right way is not to make it seem like the controller supports only
31 channels, but rather to mark the used channels as reserved.

So I think the bottom line here is that the original binding has a bug
that we're trying to address. Any workaround for this is problematic,
and I think breaking backwards-compatibility is the cleanest solution
here.

Now, GPC DMA was introduced on Tegra186 and the DT bindings were added
in 5.19. Any products released with this IP were released with kernels
prior to 5.19 and bindings that were never in-tree. Any of those
products that are supported upstream we know have replaceable DTB images
(i.e. by default they are flashed at the same time as the kernel image),
so breaking DT ABI should be okay.

In fact, there are slight incompatibilities between product and upstream
DT bindings (we're in the process of removing those as part of the
upstreaming process), so being able to reflash the DTB is a prerequisite
for supporting upstream Linux on these devices.

I think going forward we should be extra careful about these kinds of
problems, so that we don't have to keep dealing with fallout like this.

Rob, given the above, do you think it's okay to proceed with the ABI
break?

Thierry

--oesM7UOI0DB+Ei+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmNhBZ0ACgkQ3SOs138+
s6Eqwg/9EjmFdYeGMUhmTZiHZu7Ycw3dCkWi7Fg5GidVRzZ8fxWd6/GvFUDU73gg
WTNvZkT+wS1eBZcYXsnybwZMtgP9Bxu2nHz7e0KCRD18ePrqBi7/qiDv1EldVcUb
xX171nBNKoBdDY8BthVw45RJ8TbozkhRgQhUC9gyqBlw0y3/HrnNPKCVT770yOsJ
t9EAUyc0IHKkuYkfCH7Zu1g64yEKLxvM8Dm9SN63BsYC7OXbFM95/XyZJ/7kvkis
+J1YQf17qoSfpxKTIWZcYgDTE3nST3NF4E4E5F9DftQk4U31bM5jiQMZk4bvvD7M
zus4+vKbVdfyjmXsiKLFaULBf2Tia+j8Vel6oyflXkLd/S/wL7Ebc3v00uvBW+4e
qYM+PjBdNH79iipFBTjV1y008UFz3GUKUf0JXW52RqCihc0DkM/bJliiLjlteGzY
AEy+EKJssJgTSyqiAUCxjftAsEIr+m0GHX1v2ZOG4uno/hrgXxvgb9qfDnjmffcu
gZgdZjLkvBULXQac5i8M7Em/WxmmPWUuLupB/TRfUE4brpnlnZEPx8Uo9NtnBh6y
rOZ7PFHsY91g5EtcjM4Icn8bVQowmiwQulMB8cgdmSDFco/Q+mrXR9R8uc+Il5Ge
7kSfGJ+x7p21VPsKPWyssL01r2y0smKQsoArnMa0HqDwwQysxHQ=
=5cml
-----END PGP SIGNATURE-----

--oesM7UOI0DB+Ei+g--
