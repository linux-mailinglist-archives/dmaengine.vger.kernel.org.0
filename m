Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0317E144BBC
	for <lists+dmaengine@lfdr.de>; Wed, 22 Jan 2020 07:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbgAVG0f (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Jan 2020 01:26:35 -0500
Received: from olimex.com ([184.105.72.32]:53758 "EHLO olimex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbgAVG0c (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 22 Jan 2020 01:26:32 -0500
Received: from 94.155.250.134 ([94.155.250.134])
        by olimex.com with ESMTPSA (ECDHE-RSA-AES128-GCM-SHA256:TLSv1.2:Kx=ECDH:Au=RSA:Enc=AESGCM(128):Mac=AEAD) (SMTP-AUTH username stefan@olimex.com, mechanism PLAIN)
        for <dmaengine@vger.kernel.org>; Tue, 21 Jan 2020 22:26:28 -0800
Subject: Re: [PATCH v2 2/2] drm: sun4i: hdmi: Add support for sun4i HDMI
 encoder audio
To:     Maxime Ripard <mripard@kernel.org>,
        Stefan Mavrodiev <stefan@olimex.com>
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
References: <20200120123326.30743-1-stefan@olimex.com>
 <20200120123326.30743-3-stefan@olimex.com>
 <20200121182905.pxs72ojqx5fz2gi3@gilmour.lan>
From:   Stefan Mavrodiev <stefan@olimex.com>
Message-ID: <7be957d3-9f04-f71c-3e63-910b0145a8cd@olimex.com>
Date:   Wed, 22 Jan 2020 08:26:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200121182905.pxs72ojqx5fz2gi3@gilmour.lan>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 1/21/20 8:29 PM, Maxime Ripard wrote:
> +Mark
>
> On Mon, Jan 20, 2020 at 02:33:26PM +0200, Stefan Mavrodiev wrote:
>> Add HDMI audio support for the sun4i-hdmi encoder, used on
>> the older Allwinner chips - A10, A20, A31.
>>
>> Most of the code is based on the BSP implementation. In it
>> dditional formats are supported (S20_3LE and S24_LE), however
>> there where some problems with them and only S16_LE is left.
> What are those problems?
It was all noise. Guess it's some byte alignment issue, but
I didn't manage to solve it.
>
>> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
>> ---
>> +static int sun4i_hdmi_audio_probe(struct platform_device *pdev)
>> +{
>> +	struct snd_soc_card *card = &sun4i_hdmi_audio_card;
>> +	struct snd_soc_dai_link_component *comp;
>> +	struct snd_soc_dai_link *link;
>> +	struct device *dev = &pdev->dev;
>> +	struct sun4i_hdmi_audio *priv;
>> +	int ret;
>> +
>> +	ret = devm_snd_dmaengine_pcm_register(dev,
>> +					      &sun4i_hdmi_audio_pcm_config, 0);
>> +	if (ret) {
>> +		dev_err(dev, "Failed registering PCM DMA component\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = devm_snd_soc_register_component(dev,
>> +					      &sun4i_hdmi_audio_component,
>> +					      &sun4i_hdmi_audio_dai, 1);
>> +	if (ret) {
>> +		dev_err(dev, "Failed registering DAI component\n");
>> +		return ret;
>> +	}
>> +
>> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	priv->hdmi = dev->parent;
>> +	dev->of_node = dev->parent->of_node;
>> +
>> +	link = devm_kzalloc(dev, sizeof(*link), GFP_KERNEL);
>> +	if (!link)
>> +		return -ENOMEM;
>> +
>> +	comp = devm_kzalloc(dev, sizeof(*comp) * 3, GFP_KERNEL);
>> +	if (!comp)
>> +		return -ENOMEM;
>> +
>> +	link->cpus = &comp[0];
>> +	link->codecs = &comp[1];
>> +	link->platforms = &comp[2];
>> +
>> +	link->num_cpus = 1;
>> +	link->num_codecs = 1;
>> +	link->num_platforms = 1;
>> +
>> +	link->playback_only = 1;
>> +
>> +	link->name = "SUN4I-HDMI";
>> +	link->stream_name = "SUN4I-HDMI PCM";
>> +
>> +	link->codecs->name = dev_name(dev);
>> +	link->codecs->dai_name	= sun4i_hdmi_audio_dai.name;
>> +
>> +	link->cpus->dai_name = dev_name(dev);
>> +
>> +	link->platforms->name = dev_name(dev);
>> +
>> +	link->dai_fmt = SND_SOC_DAIFMT_I2S;
>> +
>> +	card->dai_link = link;
>> +	card->num_links = 1;
>> +	card->dev = dev;
>> +
>> +	snd_soc_card_set_drvdata(card, priv);
>> +	return devm_snd_soc_register_card(dev, card);
>> +}
>> +
>> +static int sun4i_hdmi_audio_remove(struct platform_device *pdev)
>> +{
>> +	return 0;
>> +}
>> +
>> +static struct platform_driver sun4i_hdmi_audio_driver = {
>> +	.probe	= sun4i_hdmi_audio_probe,
>> +	.remove	= sun4i_hdmi_audio_remove,
>> +	.driver	= {
>> +		.name = DRIVER_NAME,
>> +	},
>> +};
>> +module_platform_driver(sun4i_hdmi_audio_driver);
>> +
>> +MODULE_AUTHOR("Stefan Mavrodiev <stefan@olimex.com");
>> +MODULE_DESCRIPTION("Allwinner A10 HDMI Audio driver");
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_ALIAS("platform:" DRIVER_NAME);
> Sorry if I wasn't clear enough in the previous mail, I didn't suggest
> to do a driver, this will open another can of worm (as kbuild already
> pointed out), but to create a new device, and pass that new device to
> ASoC's functions.

The problem here is that I used sunxi_defconfig instead of the arch
defconfig during testing. The difference is that in "our" config the
modules are built-in and thus there is no module_init.

However I've managed to get it working in v3 (it's not submitted
yet).

I've added separate entry in the Kconfig of type bool. This is to
manage the SND_SOC dependency. The current patch will fail if
SND_SOC=m and SUN4I_HDMI=y for example.

Then I've dropped this as it's useless:

> +module_platform_driver(sun4i_hdmi_audio_driver);
> +
> +MODULE_AUTHOR("Stefan Mavrodiev <stefan@olimex.com");
> +MODULE_DESCRIPTION("Allwinner A10 HDMI Audio driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:" DRIVER_NAME);
In sun4i_hdmi_enc.c I've added __init and __exit
functions where I register/unregister the additional platform_driver.
Thus we get 2 platform drivers from one module, which is not something
uncommon.

If you like this approach I can submit v3.

>
> I tried that, and failed, so I guess it's not an option either.
>
> Mark, our issue here is that we have a driver tied to a device that is
> an HDMI encoder. Obviously, we'll want to register into DRM, which is
> what we were doing so far, with the usual case where at remove /
> unbind time, in order to free the resources, we just retrieve our
> pointer to our private structure using the device's drvdata.
>
> Now, snd_soc_register_card also sets that pointer to the card we try
> to register, which is problematic. It seems that it's used to handle
> suspend / resume automatically, which in this case would be also not
> really fit for us (or rather, we would need to do more that just
> suspend the audio part).
>
> Is there anyway we can have that kind of setup? I believe vc4 is in a
> similar situation, but they worked around it by storing the data they
> want to access in a global pointer, but that only works for one device
> which doesn't really suit us either.
>
> Any suggestions?
> Thanks!
> Maxime
