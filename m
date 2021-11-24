Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6765C45CB25
	for <lists+dmaengine@lfdr.de>; Wed, 24 Nov 2021 18:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237597AbhKXRkO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Nov 2021 12:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236657AbhKXRkJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 24 Nov 2021 12:40:09 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF872C061574;
        Wed, 24 Nov 2021 09:36:58 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id b1so9152567lfs.13;
        Wed, 24 Nov 2021 09:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZIcn+RRc9Rps+7b0T+IyJm79uMUpyF3YvcCN2OC7l9Y=;
        b=FLBSX0+olXTOAlp7C+knSf/7drnIn7H/UX7TDK9AoSp4PkuSj60LVuYkKMnjcC9YY3
         ikWuFdLfD1kbuzClK7j2r8uE52m0ciCo0F41wb7XU00orL14Q13pQk+6d+pyM7vdO2QK
         LYUIqSIXIslxr1QmFi4Bl0ADQeiZ5m+/BOBB6vDflgHIEMsk0Q88DdJUo3wVEYI8Pr5Z
         sXvAtuyUfl3+J0677+KUwo73hWKLP5dVAe3qav01Qm9WaXlqZU7Qi87kYoIB9qdRIWxe
         kKTxqqpAJ0WWNVIjLM+Cf5/IG4PS+Rx6faWvmZ4/OGrH5fC0tZn54q+Z8fHjDwt1vOnd
         kYzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZIcn+RRc9Rps+7b0T+IyJm79uMUpyF3YvcCN2OC7l9Y=;
        b=uQIzkJn0wSAkVuAw8V7ZbZCiZb2EQ0p8Ko6qYDfSsV+plbKIXBP7i7xvDtXNHj0jTj
         qRp2UUtb3OsqGRjm4k3CW4HyABMP8hmbGmNUz0R9y9SyGxI0SLmFmHEjOBdHCWTP6cRV
         aGKYy/I8tkJ77dGvCJw7kBd/PnfqI964WqLxwSuOUiR+ciCmsFqEu7U5b59BcozcGR0S
         YQSs28vZnHBHdl+LVCEFEMmkcOvIzW3beeV7oPx6degewSh9e2n/o5qRuF53vTnQtfmv
         CcJfuigbRt7OaTn0Yoy3s8O8pP7DqSBswckosVoSU4uwLFHrpA1AIw555A31uX6vS+iG
         sQqA==
X-Gm-Message-State: AOAM5304oSOUx7N0KWKhx9uJm4Fa87p+VEk1g/gocNbCq4ZDyaJiz1a3
        nCjtgt+2l/Jh+JySVcHNMHuDqrYkl74=
X-Google-Smtp-Source: ABdhPJxrgNz+71paDdUUv/N7my06bflGW6cF8iV2RywOAz26KaDrmDsPh/ZBuabbAUbFBAGdMU59uQ==
X-Received: by 2002:a05:6512:2341:: with SMTP id p1mr16884188lfu.204.1637775417014;
        Wed, 24 Nov 2021 09:36:57 -0800 (PST)
Received: from [192.168.2.145] (94-29-48-99.dynamic.spd-mgts.ru. [94.29.48.99])
        by smtp.googlemail.com with ESMTPSA id e14sm42342ljn.78.2021.11.24.09.36.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Nov 2021 09:36:56 -0800 (PST)
Subject: Re: [PATCH v2 01/11] ASoC: tegra20-spdif: stop setting slave_id
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Andy Gross <agross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jon Hunter <jonathanh@nvidia.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Scott Branden <sbranden@broadcom.com>,
        Takashi Iwai <tiwai@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        dmaengine@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-staging@lists.linux.dev,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>
References: <20211122222203.4103644-1-arnd@kernel.org>
 <20211122222203.4103644-2-arnd@kernel.org>
 <1dbe0c9f-e209-49e1-f05c-765d9f9b91eb@gmail.com>
 <CAK8P3a0ojMBib+6UGGxO1GyQ4a22RM3yn79Uv=ixQ2KFUCfGrw@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <e455d008-9389-b15b-b2d1-b2193cbd77c7@gmail.com>
Date:   Wed, 24 Nov 2021 20:36:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0ojMBib+6UGGxO1GyQ4a22RM3yn79Uv=ixQ2KFUCfGrw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

24.11.2021 19:47, Arnd Bergmann пишет:
> On Wed, Nov 24, 2021 at 5:32 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>> 23.11.2021 01:21, Arnd Bergmann пишет:
>>
>> The commit message is correct, however you could remove even more code
>> here. But there is no need to make a v3 just because this patch because
>> I already prepared patchset that revives this S/PDIF driver and enables
>> HDMI audio on Tegra20. I'll take care of cleaning up the whole code of
>> this driver.
> 
> Ok, perfect, thanks for taking a closer look as well.
> 
>>
>> -       dmareq = platform_get_resource(pdev, IORESOURCE_DMA, 0);
>> -       if (!dmareq) {
>> -               dev_err(&pdev->dev, "No DMA resource\n");
>> -               return -ENODEV;
>> -       }
>> -
> 
> Right, I think I considered doing this at some point as well, not sure
> why I left it in for the version I posted. Passing the IORESOURCE_DMA
> values is clearly wrong by itself and needs to be removed, though
> it's not obvious what the correct way of requesting the DMA channel
> is for this driver either, without a DT binding or users.

Yes, it's indeed not obvious.
