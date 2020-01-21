Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71AFA144441
	for <lists+dmaengine@lfdr.de>; Tue, 21 Jan 2020 19:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgAUS3J (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 Jan 2020 13:29:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:60392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729080AbgAUS3J (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 21 Jan 2020 13:29:09 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CF052087E;
        Tue, 21 Jan 2020 18:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579631348;
        bh=qPFExtTt5h+kOuG3+TkRFE3BfIRxdJRVf2QDJvNewII=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kf7V4o/oSwcgA2ETVwf8yAyvu9oUNRxUT2OOYfIA8UQv10ZpVh8+S/3FOGZUyCJLT
         VkXxDTwUgx/hHXrJzsLqgH4OmBwUsSQXnXI2p1/4PlyUQ6qhu+3pOmOPT/c0PkioHD
         jS2rKawudvFLVieooIfngZTEOtm5B/FGnz2UDraA=
Date:   Tue, 21 Jan 2020 19:29:05 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Stefan Mavrodiev <stefan@olimex.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:DRM DRIVERS FOR ALLWINNER A10" 
        <dri-devel@lists.freedesktop.org>, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 2/2] drm: sun4i: hdmi: Add support for sun4i HDMI
 encoder audio
Message-ID: <20200121182905.pxs72ojqx5fz2gi3@gilmour.lan>
References: <20200120123326.30743-1-stefan@olimex.com>
 <20200120123326.30743-3-stefan@olimex.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uoqfuck44v3rmnkh"
Content-Disposition: inline
In-Reply-To: <20200120123326.30743-3-stefan@olimex.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--uoqfuck44v3rmnkh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

+Mark

On Mon, Jan 20, 2020 at 02:33:26PM +0200, Stefan Mavrodiev wrote:
> Add HDMI audio support for the sun4i-hdmi encoder, used on
> the older Allwinner chips - A10, A20, A31.
>
> Most of the code is based on the BSP implementation. In it
> dditional formats are supported (S20_3LE and S24_LE), however
> there where some problems with them and only S16_LE is left.

What are those problems?

> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
> ---

> +static int sun4i_hdmi_audio_probe(struct platform_device *pdev)
> +{
> +	struct snd_soc_card *card = &sun4i_hdmi_audio_card;
> +	struct snd_soc_dai_link_component *comp;
> +	struct snd_soc_dai_link *link;
> +	struct device *dev = &pdev->dev;
> +	struct sun4i_hdmi_audio *priv;
> +	int ret;
> +
> +	ret = devm_snd_dmaengine_pcm_register(dev,
> +					      &sun4i_hdmi_audio_pcm_config, 0);
> +	if (ret) {
> +		dev_err(dev, "Failed registering PCM DMA component\n");
> +		return ret;
> +	}
> +
> +	ret = devm_snd_soc_register_component(dev,
> +					      &sun4i_hdmi_audio_component,
> +					      &sun4i_hdmi_audio_dai, 1);
> +	if (ret) {
> +		dev_err(dev, "Failed registering DAI component\n");
> +		return ret;
> +	}
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->hdmi = dev->parent;
> +	dev->of_node = dev->parent->of_node;
> +
> +	link = devm_kzalloc(dev, sizeof(*link), GFP_KERNEL);
> +	if (!link)
> +		return -ENOMEM;
> +
> +	comp = devm_kzalloc(dev, sizeof(*comp) * 3, GFP_KERNEL);
> +	if (!comp)
> +		return -ENOMEM;
> +
> +	link->cpus = &comp[0];
> +	link->codecs = &comp[1];
> +	link->platforms = &comp[2];
> +
> +	link->num_cpus = 1;
> +	link->num_codecs = 1;
> +	link->num_platforms = 1;
> +
> +	link->playback_only = 1;
> +
> +	link->name = "SUN4I-HDMI";
> +	link->stream_name = "SUN4I-HDMI PCM";
> +
> +	link->codecs->name = dev_name(dev);
> +	link->codecs->dai_name	= sun4i_hdmi_audio_dai.name;
> +
> +	link->cpus->dai_name = dev_name(dev);
> +
> +	link->platforms->name = dev_name(dev);
> +
> +	link->dai_fmt = SND_SOC_DAIFMT_I2S;
> +
> +	card->dai_link = link;
> +	card->num_links = 1;
> +	card->dev = dev;
> +
> +	snd_soc_card_set_drvdata(card, priv);
> +	return devm_snd_soc_register_card(dev, card);
> +}
> +
> +static int sun4i_hdmi_audio_remove(struct platform_device *pdev)
> +{
> +	return 0;
> +}
> +
> +static struct platform_driver sun4i_hdmi_audio_driver = {
> +	.probe	= sun4i_hdmi_audio_probe,
> +	.remove	= sun4i_hdmi_audio_remove,
> +	.driver	= {
> +		.name = DRIVER_NAME,
> +	},
> +};
> +module_platform_driver(sun4i_hdmi_audio_driver);
> +
> +MODULE_AUTHOR("Stefan Mavrodiev <stefan@olimex.com");
> +MODULE_DESCRIPTION("Allwinner A10 HDMI Audio driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:" DRIVER_NAME);

Sorry if I wasn't clear enough in the previous mail, I didn't suggest
to do a driver, this will open another can of worm (as kbuild already
pointed out), but to create a new device, and pass that new device to
ASoC's functions.

I tried that, and failed, so I guess it's not an option either.

Mark, our issue here is that we have a driver tied to a device that is
an HDMI encoder. Obviously, we'll want to register into DRM, which is
what we were doing so far, with the usual case where at remove /
unbind time, in order to free the resources, we just retrieve our
pointer to our private structure using the device's drvdata.

Now, snd_soc_register_card also sets that pointer to the card we try
to register, which is problematic. It seems that it's used to handle
suspend / resume automatically, which in this case would be also not
really fit for us (or rather, we would need to do more that just
suspend the audio part).

Is there anyway we can have that kind of setup? I believe vc4 is in a
similar situation, but they worked around it by storing the data they
want to access in a global pointer, but that only works for one device
which doesn't really suit us either.

Any suggestions?
Thanks!
Maxime

--uoqfuck44v3rmnkh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXidC8QAKCRDj7w1vZxhR
xdhjAQDAc/yNp70ZVKdve6593LTwm1iFX5zjlIF0vAXCTIfazQD/bIxCUQXdVxow
tvphlLwx2z01SmLI341xYHBiu+FtEQI=
=c05y
-----END PGP SIGNATURE-----

--uoqfuck44v3rmnkh--
