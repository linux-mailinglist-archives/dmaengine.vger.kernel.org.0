Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E275084D9
	for <lists+dmaengine@lfdr.de>; Wed, 20 Apr 2022 11:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377181AbiDTJ1F (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Apr 2022 05:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377174AbiDTJ06 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Apr 2022 05:26:58 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD283B039;
        Wed, 20 Apr 2022 02:24:12 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id w1so1749960lfa.4;
        Wed, 20 Apr 2022 02:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u55Ek4ovTu93jGC6owGr6QZtrHl98TBOqnvlwoTCUt0=;
        b=VCx/HeNdAIrVvK22LWtPVkq9Bv1IKELkDsHc9ZDCJpEzPZXiUk1L12Dy+mMZouB4Kb
         Sm5gqeWiHiAo7O1rqL4fR/FRWrLwV1sxcNCEE/ser/ng6KnPEXuXeI6mJT4hEuhbpkyR
         CnEwq7dF8XjnevURjfPXlQSPsthUbrMgXmTx0ftPiqNOdHSrKFkOiwbXMIgL4L8pif1x
         S2OC7crPo4slcyULVJrhskiIc37n3wR0KWOXQ2sj5i0hsb8hGWYGa7c9kFuF9uQx1Lrd
         PnwrnrwZvh2dBVEvqkQHhB/xuL6v+vJ4eVgGVRgIh8ublrifvFa02qV7bdCp+CMifVZv
         cETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u55Ek4ovTu93jGC6owGr6QZtrHl98TBOqnvlwoTCUt0=;
        b=55Zz5VXfyuyO9tEV2yEjN8Ldm9TK+io3F/MI5EJqGc/HQ3mH8rXju020y4VXUolXIW
         bwOoTjeDuH2JlairDwziZgu+vYQvmRPH/kEwoqdiZnNazOyuxEOfph2YCBCvU6+6nzP8
         3Eq4c6ZMMe7x1040quAHf2M7bz++V5VU+YO8ZycDlz0NIQJfidDzQiWYmxlmQMu7JFhH
         LISM9zxiezlh5A/wYrjslqwk/J94zCB9qSYkeKsIAAus+7Z80wdpk71wbd6ZviFTUbd3
         QtVf2T9AYjbwz2QNTW29xs+RR72sBgXZxr5xrEnD/zDw3AyTe0scJ4ODCLTSypD3wFoe
         ZMXQ==
X-Gm-Message-State: AOAM533CBkLY+YR3ZKlRpB/NBnnDAvN9wpGQyeRXL0Kuyo1BrncCldyr
        B24iMJH+xrswkBbCL9WgEF8=
X-Google-Smtp-Source: ABdhPJwBIjGhPQR/MG3suNBpw+sG1uqlbM+4wIOJy5ZknDOvMCYopGuZbVrLmdXv8OTjIhB4lEs0Kw==
X-Received: by 2002:a05:6512:168d:b0:471:6cb9:c20f with SMTP id bu13-20020a056512168d00b004716cb9c20fmr11611107lfb.229.1650446651069;
        Wed, 20 Apr 2022 02:24:11 -0700 (PDT)
Received: from [192.168.1.103] ([178.176.74.70])
        by smtp.gmail.com with ESMTPSA id d11-20020a19384b000000b0046bbd144dfesm1760268lfj.125.2022.04.20.02.24.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 02:24:10 -0700 (PDT)
Subject: Re: [PATCH 01/41] video: fbdev: omapfb: lcd_ams_delta: fix unused
 variable warning
To:     Arnd Bergmann <arnd@kernel.org>, linux-omap@vger.kernel.org,
        tony@atomide.com, aaro.koskinen@iki.fi, jmkrzyszt@gmail.com
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Paul Walmsley <paul@pwsan.com>,
        Kevin Hilman <khilman@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Mark Brown <broonie@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-input@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-serial@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
References: <20220419133723.1394715-1-arnd@kernel.org>
 <20220419133723.1394715-2-arnd@kernel.org>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <ddaf112d-f997-84b7-2c57-bab3d0cca382@gmail.com>
Date:   Wed, 20 Apr 2022 12:24:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220419133723.1394715-2-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello!

On 4/19/22 4:36 PM, Arnd Bergmann wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> A recent cleanup patch removed the only reference to a local variable
> in some configurations.
> 
> Move the variable into the one block it is still used in, inside
> of an #ifdef, to avoid this warning.
> 
> Fixes: 9d773f103b89 ("video: fbdev: omapfb: lcd_ams_delta: Make use of the helper function dev_err_probe()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/video/fbdev/omap/lcd_ams_delta.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/omap/lcd_ams_delta.c b/drivers/video/fbdev/omap/lcd_ams_delta.c
> index bbf871f9d862..01944ce46aa1 100644
> --- a/drivers/video/fbdev/omap/lcd_ams_delta.c
> +++ b/drivers/video/fbdev/omap/lcd_ams_delta.c
[...]
> @@ -145,7 +144,7 @@ static int ams_delta_panel_probe(struct platform_device *pdev)
>  						&ams_delta_lcd_ops);
>  
>  	if (IS_ERR(lcd_device)) {
> -		ret = PTR_ERR(lcd_device);
> +		int ret = PTR_ERR(lcd_device);

   How about inserting an empty line after declaration?

>  		dev_err(&pdev->dev, "failed to register device\n");
>  		return ret;
>  	}

MBR, Sergey
