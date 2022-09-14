Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02CE5B8A57
	for <lists+dmaengine@lfdr.de>; Wed, 14 Sep 2022 16:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiINOXy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Sep 2022 10:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiINOX2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 14 Sep 2022 10:23:28 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7DA7C75C;
        Wed, 14 Sep 2022 07:23:25 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id z14-20020a05600c0a0e00b003b486df42a3so6531660wmp.2;
        Wed, 14 Sep 2022 07:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=9YfXbc2FnaTM2JzFHv5XmU3vPqJrtHyXgze75LBBZ94=;
        b=nZ3RRq0BCyLVp3+0JltgaJ7x4+A77fyguXyuvJXBDIG9fBpCac0h8kKWaVk5A7HuJq
         o8dvajhXdoBIKGNECSOph/AK9y8sFZTMRKCWlvVvDfZtQPsNUmtuQ2zpLI5WM1oR5YDu
         yoweLEU6+IZQAwWEftGPXqsGOIR4ZAFMJUzfzzeDp6blD+kfAioMH8tlnFF/mRUrFyIZ
         tC0wxS7MHM17d5rZ35GA20l9s28h5oln01KSTXX/6MwsfiQfXbBPIw1bXp9A+8+2Apgx
         BCG2kf+l0n2bUssYDpgohx+z5QRJFmKOiBuDa9SLyOvJ3kVbQlQ4v2oJA/vXt1nv0Vqr
         aK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=9YfXbc2FnaTM2JzFHv5XmU3vPqJrtHyXgze75LBBZ94=;
        b=vi+TR5ShH8zhoiKtkaTSf6zf+LQP/WKoqVpNo2w/it4gLzPX9TkDO30vf5xAayQorN
         yALp5n50fpMrEZXMLG0fD2lvG8Zytvg/TJZDlr5g0sDg5pCRHXauaZQU/+veQGKFcpw8
         qVRrghufboe7Z5AqehiKxBR8KxhDEa4E6QK5OhTo+BP8hIQFXYvc7gokwcEJensrjSHQ
         11vyWAX8td1fryAr7b/sxi4eMmRQwGO76817BY0RBg5YFTjbOuhkfgUxH6Tio3U+BNih
         8Hv10vznVOTei/r6w23FLXKWfJE7EMmOMjZCguD4r/W0jUZeMbR+BYIwx5o9XJMi8E5J
         mcPA==
X-Gm-Message-State: ACgBeo3vp26W6UpxZhHeXxZDzp4qgQ7m9SDgOyRz8m/UvA9s/858nUxs
        hBCYj+AibByfOT6VocpOj1AEQblralA=
X-Google-Smtp-Source: AA6agR51YAdnCj4EeTy1N5yyoojS4RA4vRptmbkJobTiWF+mYPPCsUx4txSjB9Mjni6zPLtu+4gH9A==
X-Received: by 2002:a05:600c:5128:b0:3b4:8601:2da2 with SMTP id o40-20020a05600c512800b003b486012da2mr3394214wms.193.1663165403315;
        Wed, 14 Sep 2022 07:23:23 -0700 (PDT)
Received: from orome (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id fc11-20020a05600c524b00b003b48dac344esm11454112wmb.43.2022.09.14.07.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 07:23:22 -0700 (PDT)
Date:   Wed, 14 Sep 2022 16:23:20 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Akhil R <akhilrajeev@nvidia.com>
Cc:     ldewangan@nvidia.com, jonathanh@nvidia.com, vkoul@kernel.org,
        p.zabel@pengutronix.de, dmaengine@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dmaengine: tegra: Add support for dma-channel-mask
Message-ID: <YyHj2J1WblUiKkAL@orome>
References: <20220913155251.59375-1-akhilrajeev@nvidia.com>
 <20220913155251.59375-4-akhilrajeev@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xLNYABVN+YKfQJcC"
Content-Disposition: inline
In-Reply-To: <20220913155251.59375-4-akhilrajeev@nvidia.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--xLNYABVN+YKfQJcC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 13, 2022 at 09:22:51PM +0530, Akhil R wrote:
> Add support for dma-channel-mask so that only the specified channels
> are used. This helps to reserve some channels for the firmware.
>=20
> This was initially achieved by limiting the channel number to 31 in
> the driver and adjusting the register address to skip channel0 which
> was reserved for a firmware. Now, with this change, the driver can
> align more to the actual hardware which has 32 channels.
>=20
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> ---
>  drivers/dma/tegra186-gpc-dma.c | 35 ++++++++++++++++++++++++++++------
>  1 file changed, 29 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dm=
a.c
> index fa9bda4a2bc6..f69a800c4f80 100644
> --- a/drivers/dma/tegra186-gpc-dma.c
> +++ b/drivers/dma/tegra186-gpc-dma.c
> @@ -161,7 +161,10 @@
>  #define TEGRA_GPCDMA_BURST_COMPLETION_TIMEOUT	5000 /* 5 msec */
> =20
>  /* Channel base address offset from GPCDMA base address */
> -#define TEGRA_GPCDMA_CHANNEL_BASE_ADD_OFFSET	0x20000
> +#define TEGRA_GPCDMA_CHANNEL_BASE_ADDR_OFFSET	0x10000
> +
> +/* Default channel mask reserving channel0 */
> +#define TEGRA_GPCDMA_DEFAULT_CHANNEL_MASK	0xfffffffe
> =20
>  struct tegra_dma;
>  struct tegra_dma_channel;
> @@ -246,6 +249,7 @@ struct tegra_dma {
>  	const struct tegra_dma_chip_data *chip_data;
>  	unsigned long sid_m2d_reserved;
>  	unsigned long sid_d2m_reserved;
> +	u32 chan_mask;
>  	void __iomem *base_addr;
>  	struct device *dev;
>  	struct dma_device dma_dev;
> @@ -1288,7 +1292,7 @@ static struct dma_chan *tegra_dma_of_xlate(struct o=
f_phandle_args *dma_spec,
>  }
> =20
>  static const struct tegra_dma_chip_data tegra186_dma_chip_data =3D {
> -	.nr_channels =3D 31,
> +	.nr_channels =3D 32,
>  	.channel_reg_size =3D SZ_64K,
>  	.max_dma_count =3D SZ_1G,
>  	.hw_support_pause =3D false,
> @@ -1296,7 +1300,7 @@ static const struct tegra_dma_chip_data tegra186_dm=
a_chip_data =3D {
>  };
> =20
>  static const struct tegra_dma_chip_data tegra194_dma_chip_data =3D {
> -	.nr_channels =3D 31,
> +	.nr_channels =3D 32,
>  	.channel_reg_size =3D SZ_64K,
>  	.max_dma_count =3D SZ_1G,
>  	.hw_support_pause =3D true,
> @@ -1304,7 +1308,7 @@ static const struct tegra_dma_chip_data tegra194_dm=
a_chip_data =3D {
>  };
> =20
>  static const struct tegra_dma_chip_data tegra234_dma_chip_data =3D {
> -	.nr_channels =3D 31,
> +	.nr_channels =3D 32,
>  	.channel_reg_size =3D SZ_64K,
>  	.max_dma_count =3D SZ_1G,
>  	.hw_support_pause =3D true,
> @@ -1380,15 +1384,28 @@ static int tegra_dma_probe(struct platform_device=
 *pdev)
>  	}
>  	stream_id =3D iommu_spec->ids[0] & 0xffff;
> =20
> +	ret =3D device_property_read_u32(&pdev->dev, "dma-channel-mask",
> +				       &tdma->chan_mask);
> +	if (ret) {
> +		dev_warn(&pdev->dev,
> +			 "Missing dma-channel-mask property, using default channel mask %#x\n=
",
> +			 TEGRA_GPCDMA_DEFAULT_CHANNEL_MASK);
> +		tdma->chan_mask =3D TEGRA_GPCDMA_DEFAULT_CHANNEL_MASK;
> +	}
> +
>  	INIT_LIST_HEAD(&tdma->dma_dev.channels);
>  	for (i =3D 0; i < cdata->nr_channels; i++) {
>  		struct tegra_dma_channel *tdc =3D &tdma->channels[i];
> =20
> +		/* Check for channel mask */
> +		if (!((1 << i) & tdma->chan_mask))

It's more idiomatic to reverse the operands and use the BIT macro, which
checkpatch should've warned about:

	if (!(tdma->chan_mask & BIT(i)))

There's a few other occurrences of that below.

Thierry

> +			continue;
> +
>  		tdc->irq =3D platform_get_irq(pdev, i);
>  		if (tdc->irq < 0)
>  			return tdc->irq;
> =20
> -		tdc->chan_base_offset =3D TEGRA_GPCDMA_CHANNEL_BASE_ADD_OFFSET +
> +		tdc->chan_base_offset =3D TEGRA_GPCDMA_CHANNEL_BASE_ADDR_OFFSET +
>  					i * cdata->channel_reg_size;
>  		snprintf(tdc->name, sizeof(tdc->name), "gpcdma.%d", i);
>  		tdc->tdma =3D tdma;
> @@ -1450,7 +1467,7 @@ static int tegra_dma_probe(struct platform_device *=
pdev)
>  	}
> =20
>  	dev_info(&pdev->dev, "GPC DMA driver register %d channels\n",
> -		 cdata->nr_channels);
> +		 hweight_long(tdma->chan_mask));
> =20
>  	return 0;
>  }
> @@ -1473,6 +1490,9 @@ static int __maybe_unused tegra_dma_pm_suspend(stru=
ct device *dev)
>  	for (i =3D 0; i < tdma->chip_data->nr_channels; i++) {
>  		struct tegra_dma_channel *tdc =3D &tdma->channels[i];
> =20
> +		if (!((1 << i) & tdma->chan_mask))
> +			continue;
> +
>  		if (tdc->dma_desc) {
>  			dev_err(tdma->dev, "channel %u busy\n", i);
>  			return -EBUSY;
> @@ -1492,6 +1512,9 @@ static int __maybe_unused tegra_dma_pm_resume(struc=
t device *dev)
>  	for (i =3D 0; i < tdma->chip_data->nr_channels; i++) {
>  		struct tegra_dma_channel *tdc =3D &tdma->channels[i];
> =20
> +		if (!((1 << i) & tdma->chan_mask))
> +			continue;
> +
>  		tegra_dma_program_sid(tdc, tdc->stream_id);
>  	}
> =20
> --=20
> 2.17.1
>=20

--xLNYABVN+YKfQJcC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmMh49gACgkQ3SOs138+
s6Fctg/8C7aEA24X7yjt/TsXn4e4T+pcs7nRF6M6b3V5/lgNvnbDoUICZndvyN4G
bBXdqpm2G/DylASHLWZDEsZA5iwtZrwr9/ybf3nJwGu2m4RjQ/OebNtKrrDLDfqT
FibanEgWO4SdllNYsJ3xCCdPcxQHX1xftnpUlZNIgDieaZSBjBfqpMZ1qGHIDgj4
RN0H8Bjm/K/st7pkr5/XtqGGbsH/Qk0IVx3WrEfi3RnanVr3qv27njMQ9wC6RT89
djtpbx7OUnSVCcv7OiTdmc1k7oJ7j+qjXu5+KJ91fR5wwvT1ZczymBRTe/n97dMG
OjDTIRS8QGfFXVMv4kTvkGKGRVT3jARCNGRKmVTWlFAV9vWLzQg3SrkHcVY20PXX
ZeUydiE+BT4Kgqy/R/ddmQVmHv5TtH9vwrKvDpTen4Jwp0DV5RcMYe4FSZ6ihXyr
TYjUURB82dOVGRTlPbXzQUWkMlqzm2sk70H733nvye26cdAf81g7JivZUBhWDXGa
/NdmHqRF1iKTPge0xk4UuWvtFgzr0PLdrQjtMyf8jondQZLRyCuNj75LwSF4q4n/
MTgQHy4W73phdVBsaWUUxYWtDIaa+d6jaEgqECntD4qpUGGBeIOXkSmo3QiMuaS3
WdCY2/Dj9JJaeM2xLQukJVxj+X8eGg5LB08lXedrmuCAX1BLXFc=
=1RE1
-----END PGP SIGNATURE-----

--xLNYABVN+YKfQJcC--
