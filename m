Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEDC4ACB9A
	for <lists+dmaengine@lfdr.de>; Mon,  7 Feb 2022 22:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242675AbiBGVuT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Feb 2022 16:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240952AbiBGVuT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Feb 2022 16:50:19 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB36C061355;
        Mon,  7 Feb 2022 13:50:18 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id u6so29505135lfm.10;
        Mon, 07 Feb 2022 13:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8KR8TAE4T+b81v1A/EZJdCn/FtNSrIEkM3uPzd1DPRY=;
        b=HdLaK3ZfHe689Tp8tot/VVJY42NmPt5hBj+pj/iuScYhndldleTrCYxzw3s28Uo1sP
         P7GSPmXULLp95vmMMxpJcBh7lOuyt3yPXdfX/oe2I0JgWkCDmRwS3Bk4jJ0qW+qQXtsh
         DxI/I3zE/7Kg5PVR8pcCpHAYWbMcSLclIAMcfozaIzD7u41lVO4uDexExIMhl0mhr2/S
         2IU8DkJG1ozDnP4wK/sw425sxP6rIB/4PtJ35CMWGIzJ+y1Uf/m49we4VRymb1nfPusf
         mSmaBJps4NyQnIOxMsbGN90O2VuSnrM8UajJEurxSKWJCwDAqNSImQvYU3He7nA1y+/H
         5Vlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8KR8TAE4T+b81v1A/EZJdCn/FtNSrIEkM3uPzd1DPRY=;
        b=46FIDiG5zuzOMfFyBB2WsTjral6+s+b08vyoCA9E8m7YvkPdjS/93OW3krvrpgfjkm
         AeQOtat3OMOmiIWYRYn9ct/8JM6SQXEb6+sOxsINpO9TzSjwV5RKCYPW3wkLwxq1iG9o
         o49qw+geuONmK0DaRYVvJlnq/Dud99SAZqGmG0NJqzdbhGDShDoTOoeYYCbv3B14AH9A
         KpfqwzJcqfet7fq7AKbMRKWHp9ZMelvT3iGf+CA4EjQnHrZUe+qJEl2c8OI+ZDdDBq+R
         CHxqcnlZiO8x2Ut2bkX0VCEZsZ/iRiM3Bhv1G3c8bD/TnJVYpVkzVKVV0gfy8p6Evh3s
         77qA==
X-Gm-Message-State: AOAM5313bWyr3Kuyz4MapvJSWuYJ1mZc6UVh1ij8b3M8zPubPCILz7bW
        mo9IEgpLfYqt9TvCXjJjTAY=
X-Google-Smtp-Source: ABdhPJypQF9kCG4qJaDjHN8XTm8D3HyDNVK5iLXsXIzLeFfrNn1XK7M7kqRj8b99JkgfNdLVx4ahqA==
X-Received: by 2002:a05:6512:151e:: with SMTP id bq30mr1031460lfb.604.1644270616824;
        Mon, 07 Feb 2022 13:50:16 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.googlemail.com with ESMTPSA id i18sm1645506lfv.257.2022.02.07.13.50.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 13:50:16 -0800 (PST)
Message-ID: <fd8ba6fc-b389-3e8e-2671-51656d3d8e5c@gmail.com>
Date:   Tue, 8 Feb 2022 00:50:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v19 2/4] dmaengine: tegra: Add tegra gpcdma driver
Content-Language: en-US
To:     Akhil R <akhilrajeev@nvidia.com>, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, jonathanh@nvidia.com,
        kyarlagadda@nvidia.com, ldewangan@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        p.zabel@pengutronix.de, rgumasta@nvidia.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, vkoul@kernel.org
Cc:     Pavan Kunapuli <pkunapuli@nvidia.com>
References: <1644246094-29423-1-git-send-email-akhilrajeev@nvidia.com>
 <1644246094-29423-3-git-send-email-akhilrajeev@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <1644246094-29423-3-git-send-email-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

07.02.2022 18:01, Akhil R пишет:
> Adding GPC DMA controller driver for Tegra. The driver supports dma
> transfers between memory to memory, IO peripheral to memory and
> memory to IO peripheral.
> 
> Co-developed-by: Pavan Kunapuli <pkunapuli@nvidia.com>
> Signed-off-by: Pavan Kunapuli <pkunapuli@nvidia.com>
> Co-developed-by: Rajesh Gumasta <rgumasta@nvidia.com>
> Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/dma/Kconfig            |   11 +
>  drivers/dma/Makefile           |    1 +
>  drivers/dma/tegra186-gpc-dma.c | 1505 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1517 insertions(+)
>  create mode 100644 drivers/dma/tegra186-gpc-dma.c

Looks okay to me. Thank you for the effort!

Coding style isn't ideal:

 - inconsistent alignment of the code
 - unnecessary whitespaces and parens
 - inconsistent variables type signes
 - all abbreviation should be capitalized in comments and commit msg

but this is not critical and could be improved later on.

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
