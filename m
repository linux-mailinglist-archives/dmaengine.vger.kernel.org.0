Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F77817CEA
	for <lists+dmaengine@lfdr.de>; Wed,  8 May 2019 17:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfEHPPX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 May 2019 11:15:23 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39151 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfEHPPX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 8 May 2019 11:15:23 -0400
Received: by mail-io1-f65.google.com with SMTP id m7so15120560ioa.6;
        Wed, 08 May 2019 08:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+JvC1TwFB/yeFp3szSBzEe5PaSFdNgPtLmVR0CVhzV0=;
        b=P520ai87ain/12F06dWOpKLegIs9pHmj77TJiLVqWBksGuwmnPQ9oHIcIZkCTzgAYb
         yNm1ZULEFwZbwyb2HZJily30k7XvqR6MFsA+kxux4sros9GHsvowioklLxW7axy7P7dq
         pJZp8Utphzr3M/MpDWIWA4FrqVjB54/fOd0UzqEP60pU3PtVXv0fLongNxylqw7T6Eok
         TBVSz10u6hfEKibtFv/WqbWC29L3TFuznnev4IKeKgkRD1X/O9lvn6cFdBy7Y0CEuMHX
         3pTjaPeJ4fv5KxL5fQujz3kBfpZkT300C/OAe1s3XdFNxn/EbkdKkw3xpU6IbdYVf9dG
         iEfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+JvC1TwFB/yeFp3szSBzEe5PaSFdNgPtLmVR0CVhzV0=;
        b=CQaXsfJA1STP7XvBMTfYl5v3hP80RMnWWlQySDvb/Cs11iHpDOPvSDVRqmFe3UovC3
         X1onemJRC58Pms+zz2wYscxLV50zeS+uenJp8yKDJMHv40jUh83FKpas7XFxX+f9IOxT
         ANmy90e547FJ8fb02dhkMbhiCo3hY92ohMzxRFnsIBw0LOKsVbQf/5phiPPGSI3OnRsc
         A2USfUZS4N82nHflMzoZsvcSfeVXDgDlG8XHrj92dd1EoX0BKbioanHKq0X68qIQ+fQK
         wW8cH5HUus2P0+YRA6yuYYvQlbvSqSUJsDaO2VVsdijjxB7LvMsQUBkxUto9QbDpL6gU
         CFbw==
X-Gm-Message-State: APjAAAVjvDEdDABU48Yl60pqkMZU3uSpQ3CTzaRZKuGFrRe8AAPQEUIE
        viwKAXUQo1NW/inw7sSXvYg=
X-Google-Smtp-Source: APXvYqyRBRQRNRoAgWDbktnpSDjj6gYnZ8joNI/amECzhKI8MWPpKHG0KCjghyCQaRwWnHb5TZWcQQ==
X-Received: by 2002:a05:6602:2247:: with SMTP id o7mr665200ioo.156.1557328522424;
        Wed, 08 May 2019 08:15:22 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id 81sm1298939itv.23.2019.05.08.08.15.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 08:15:21 -0700 (PDT)
Subject: Re: [PATCH 2/8] soc: tegra: fuse: Change to the correct
 __dma_request_channel() prototype
To:     Baolin Wang <baolin.wang@linaro.org>, dan.j.williams@intel.com,
        vkoul@kernel.org
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, Zubair.Kakakhel@imgtec.com,
        wsa+renesas@sang-engineering.com, jroedel@suse.de,
        vincent.guittot@linaro.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1557206859.git.baolin.wang@linaro.org>
 <1ddb1abe8722154dd546d265d5c4536480a24a87.1557206859.git.baolin.wang@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <8746a913-0014-7036-7fab-4e0dfab04e1b@gmail.com>
Date:   Wed, 8 May 2019 18:15:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1ddb1abe8722154dd546d265d5c4536480a24a87.1557206859.git.baolin.wang@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

07.05.2019 9:09, Baolin Wang пишет:
> Since we've introduced one device node parameter for __dma_request_channel(),
> thus change to the correct function prototype.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  drivers/soc/tegra/fuse/fuse-tegra20.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/tegra/fuse/fuse-tegra20.c b/drivers/soc/tegra/fuse/fuse-tegra20.c
> index 49ff017..e2571b6 100644
> --- a/drivers/soc/tegra/fuse/fuse-tegra20.c
> +++ b/drivers/soc/tegra/fuse/fuse-tegra20.c
> @@ -110,7 +110,7 @@ static int tegra20_fuse_probe(struct tegra_fuse *fuse)
>  	dma_cap_zero(mask);
>  	dma_cap_set(DMA_SLAVE, mask);
>  
> -	fuse->apbdma.chan = __dma_request_channel(&mask, dma_filter, NULL);
> +	fuse->apbdma.chan = __dma_request_channel(&mask, dma_filter, NULL, NULL);
>  	if (!fuse->apbdma.chan)
>  		return -EPROBE_DEFER;
>  
> 

1) Kernel should be kept bisect'able by not having intermediate patches
that break compilation. Hence you should squash the changes into a
single patch.

2) Better to replace __dma_request_channel() with dma_request_channel()
since they are equal.

-- 
Dmitry
