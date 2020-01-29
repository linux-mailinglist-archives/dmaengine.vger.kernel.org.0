Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0428214CFD4
	for <lists+dmaengine@lfdr.de>; Wed, 29 Jan 2020 18:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbgA2Rr1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Jan 2020 12:47:27 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:51687 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbgA2Rr1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Jan 2020 12:47:27 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200129174724euoutp011b52cb9762063003fd20608eda5d48e2~ubLU9xp0M1422914229euoutp01t
        for <dmaengine@vger.kernel.org>; Wed, 29 Jan 2020 17:47:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200129174724euoutp011b52cb9762063003fd20608eda5d48e2~ubLU9xp0M1422914229euoutp01t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580320044;
        bh=Gv4yBUMCeYHdHBHWfyFydKrL6tXtlVDup9vy81yiy50=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=pz9lJtiln5AXtGTpuPv3Wgqxb373lIHBSsOFUsAmccxO1fuQ2cN87R3aBM3tjgexW
         oluuxs3/UvkI+ioLlOMqsAdTcqMfpmNpLXQIp6VXp1wOefYlzkDoD5ns4+YvkTuFkh
         8x7VjPPe2RzK3ef/AHxplzufQy+77ox3GfjPHm4g=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200129174724eucas1p2b1ab8eb72df18d25afac410fd98ee200~ubLUglMA72293422934eucas1p2y;
        Wed, 29 Jan 2020 17:47:24 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 6E.75.61286.C25C13E5; Wed, 29
        Jan 2020 17:47:24 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200129174723eucas1p1fe4f76325f463fc9e3645ce18740d2eb~ubLUC1z9l1193711937eucas1p11;
        Wed, 29 Jan 2020 17:47:23 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200129174723eusmtrp27e6644c724431c052887f52ce7594860~ubLUCPrV-2706627066eusmtrp2J;
        Wed, 29 Jan 2020 17:47:23 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-8d-5e31c52c4e2d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D5.C0.07950.B25C13E5; Wed, 29
        Jan 2020 17:47:23 +0000 (GMT)
Received: from [106.120.51.15] (unknown [106.120.51.15]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200129174723eusmtip1fc91445ca438891f4e1af0c633757ce7~ubLTqw4nq1608116081eusmtip1L;
        Wed, 29 Jan 2020 17:47:23 +0000 (GMT)
Subject: Re: [PATCH v2] dmaengine: Create symlinks between DMA channels and
 slaves
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <fde812a2-aea6-c16e-5ed7-ab5195b1259f@samsung.com>
Date:   Wed, 29 Jan 2020 18:47:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200117153056.31363-1-geert+renesas@glider.be>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsWy7djP87o6Rw3jDK7OlbCYPvUCo8XqqX9Z
        LebOnsRocXnXHDaLrS/fMVnsvHOC2YHNY+JZXY/Fe14yeWxa1cnm8XmTXABLFJdNSmpOZllq
        kb5dAlfG0wmlBUt5Kw79OMjewPieq4uRk0NCwERi1uE/LCC2kMAKRol9i5W6GLmA7C+MEhdW
        /mGFcD4zSryY9IUFpmPevK2MEB3LGSX2TPSEKHrLKPFpz2ImkISwQIjEvnPtYEUiAlUSZ77+
        YwOxmQUSJE48vgxWwyZgKNH1tgsszitgJ/F97zawBSwCqhJv7/0HqxEViJW4v3oqI0SNoMTJ
        mU/AajgFbCWmnp/KAjFTXqJ562xmCFtc4taT+UwgB0kIzGOXaJrxFOpqF4m7K1ugbGGJV8e3
        sEPYMhL/d8I0NDNKPDy3lh3C6WGUuNw0gxGiylrizrlfQKdyAK3QlFi/Sx/ElBBwlGi8HQlh
        8knceCsIcQOfxKRt05khwrwSHW1CEDPUJGYdXwe39eCFS8wTGJVmIflsFpJvZiH5ZhbC2gWM
        LKsYxVNLi3PTU4sN81LL9YoTc4tL89L1kvNzNzECE83pf8c/7WD8einpEKMAB6MSD69EmWGc
        EGtiWXFl7iFGCQ5mJRFeUVegEG9KYmVValF+fFFpTmrxIUZpDhYlcV7jRS9jhQTSE0tSs1NT
        C1KLYLJMHJxSDYyKS/NiXs1IWvBw+WtPbk/hn49j0vtfdv9Z8mta9LsjU2KPnO5Y9c69PFVs
        9/XvPy5JLiz2c4qXqC9Zs9njhn3lZ6sA/ml5zTUMm3csvHTZZo/ArarbrMr2KnNX8eV+ehRa
        pywSXFX7cQH/gx7NjAnn7mv98mHhqarkbBTRYN0ox3bjCNPEb4eVWIozEg21mIuKEwHMQNfw
        MAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsVy+t/xu7raRw3jDJbtM7KYPvUCo8XqqX9Z
        LebOnsRocXnXHDaLrS/fMVnsvHOC2YHNY+JZXY/Fe14yeWxa1cnm8XmTXABLlJ5NUX5pSapC
        Rn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7G0wmlBUt5Kw79OMje
        wPieq4uRk0NCwERi3rytjCC2kMBSRonfq6Ug4jISJ6c1sELYwhJ/rnWxdTFyAdW8ZpRYcvwU
        E0hCWCBEYt+5drBmEYEqiXl7toDFmQUSJE48X8HexcgB1GAjcee1C0iYTcBQoustyBxODl4B
        O4nve7exgNgsAqoSb+/9B2sVFYiV+H/mGlSNoMTJmU/AajgFbCWmnp/KAjHeTGLe5ofMELa8
        RPPW2VC2uMStJ/OZJjAKzULSPgtJyywkLbOQtCxgZFnFKJJaWpybnltspFecmFtcmpeul5yf
        u4kRGFnbjv3csoOx613wIUYBDkYlHl6JMsM4IdbEsuLK3EOMEhzMSiK8oq5AId6UxMqq1KL8
        +KLSnNTiQ4ymQM9NZJYSTc4HRn1eSbyhqaG5haWhubG5sZmFkjhvh8DBGCGB9MSS1OzU1ILU
        Ipg+Jg5OqQbGHeoHbmcckGgJr4+uf1wsGZd66eYbvoxc8+CqyVpXuX/8ePeyMfXRJ93yb0vv
        vb7QPJf535qpQfYVj9JPcz0RTFz5lmOy6Zpp7d+ULO7yLtyYqVP9SdFZssJh6pl1Ld8r/qzh
        d/u+0Tv90g43BZ9/87LS2k88n/Z/U63DGvNHyt/EX9QeVfO+ocRSnJFoqMVcVJwIANypueDC
        AgAA
X-CMS-MailID: 20200129174723eucas1p1fe4f76325f463fc9e3645ce18740d2eb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200129174723eucas1p1fe4f76325f463fc9e3645ce18740d2eb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200129174723eucas1p1fe4f76325f463fc9e3645ce18740d2eb
References: <20200117153056.31363-1-geert+renesas@glider.be>
        <CGME20200129174723eucas1p1fe4f76325f463fc9e3645ce18740d2eb@eucas1p1.samsung.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Geert,

On 17.01.2020 16:30, Geert Uytterhoeven wrote:
> Currently it is not easy to find out which DMA channels are in use, and
> which slave devices are using which channels.
>
> Fix this by creating two symlinks between the DMA channel and the actual
> slave device when a channel is requested:
>    1. A "slave" symlink from DMA channel to slave device,
>    2. A "dma:<name>" symlink slave device to DMA channel.
> When the channel is released, the symlinks are removed again.
> The latter requires keeping track of the slave device and the channel
> name in the dma_chan structure.
>
> Note that this is limited to channel request functions for requesting an
> exclusive slave channel that take a device pointer (dma_request_chan()
> and dma_request_slave_channel*()).
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: Niklas Söderlund <niklas.soderlund@ragnatech.se>

This patch breaks booting on almost all Exynos based boards:

https://lore.kernel.org/linux-samsung-soc/20200129161113.GE3928@sirena.org.uk/T/#u

I've already sent a fix:

https://lkml.org/lkml/2020/1/29/498

BTW, this patch reminds me some of my earlier work:

https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1329778.html

I had similar need to keep a client's struct device pointer for every 
requested channel, but it turned out to be much more complicated than 
I've initially thought. I've abandoned that, due to lack of time, but 
maybe some of that discussion and concerns are still valid (I hope that 
links to earlier versions are still working)...

 > ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

