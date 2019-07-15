Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23E1769834
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jul 2019 17:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730722AbfGOPRK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 15 Jul 2019 11:17:10 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45706 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730221AbfGOPRK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 15 Jul 2019 11:17:10 -0400
Received: by mail-qt1-f196.google.com with SMTP id x22so11091350qtp.12;
        Mon, 15 Jul 2019 08:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:subject:to:cc:references:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E/egqeiPmeR+wTmeoTlfpr/9l78nB77vFY1VUyDOmQo=;
        b=fdAmHhIIQ5M5U7SJWntEaFH5x/7ZSNGV/zJLzvCc6oy4ze5UqIr+ewk8gIlu3LdeuD
         bSVEyGeFqfynptNWDeMxR39rY9enAHf0Fv1HLodHpi15tfBmQUEXzcug2siLXm7QiiV+
         nvoFtKO/+CJy9ikan9o/6tAq9hW4sFK4dBkAI48pIMeG2iYFU+HZnSor5brUWCEWjDSW
         IqydetLko55QSdg+D97dxHsmuqyEdIZtiX2rG9LU3EpWaMWJpfmlcAWAVyFkW3BRMDCt
         wYMyell5jTZlhr0A5x34LrJqIB+pLUrHN9vlFu3BF4RmKpB8O9BH0bblbyQTl1+semWS
         Q6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:subject:to:cc:references:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=E/egqeiPmeR+wTmeoTlfpr/9l78nB77vFY1VUyDOmQo=;
        b=dFa5nhVHprauNC67XuYkZUsyv9Ot6zcU6BVsiegyz5AdyfXpmzvlQ2qdxwC+Xdl0t+
         YVTYganwwziYJXgkeyMD18oxbLY8F0PNYl31awfoeMwHIN8Xoh8cbZXPpRv3vWa0R/xC
         gLUHTYB4Q1OjxunkahfLQn3qDFkk2In4FqU3tputEAw6aLE9gYM9vmsbTO6LcTiPfiA/
         XFrznnUnVJDEOC38TsNlkQ40951XeIKzPPgRGlU0kN7sObaCI/DF++1rdTRrb7LWDKiO
         lHLw9GaX/EJPCHHqJTqJppblRFHw0DrGwm/GI0kgdDPKWNneBSL0D1GirIxUdFIY3E6U
         2SyA==
X-Gm-Message-State: APjAAAXECgRkddBdwz2IIKCVeCntbN8nZILDRhs8/Nva+Hl4DvHaQB3Z
        l2Rg3tuT83M4FHfYHCStclc=
X-Google-Smtp-Source: APXvYqw+Jj/zJuzoP/WabIMtvOAfiFGap4BYM3yfG3iS6kDjoZ16oLEcwXvluS9Yi+h/DsFIMYTcnQ==
X-Received: by 2002:ac8:1106:: with SMTP id c6mr17077663qtj.332.1563203829090;
        Mon, 15 Jul 2019 08:17:09 -0700 (PDT)
Received: from [10.84.150.27] ([167.220.148.27])
        by smtp.gmail.com with ESMTPSA id q17sm3683624qtl.13.2019.07.15.08.17.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 08:17:08 -0700 (PDT)
From:   Sinan Kaya <Okaya@kernel.org>
X-Google-Original-From: Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH v3 04/24] dmaengine: qcom_hidma: Remove call to memset
 after dmam_alloc_coherent
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@infradead.org>
References: <20190715031723.6375-1-huangfq.daxian@gmail.com>
 <72c45b14-f0c0-9d1c-0953-eea70ce513a0@kernel.org>
 <CABXRUiQXweOLRTpdyhx9xT_B1VBmoSoNm=_+Qr4prmz7u1QRFA@mail.gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=okaya@kernel.org; keydata=
 mQENBFrnOrUBCADGOL0kF21B6ogpOkuYvz6bUjO7NU99PKhXx1MfK/AzK+SFgxJF7dMluoF6
 uT47bU7zb7HqACH6itTgSSiJeSoq86jYoq5s4JOyaj0/18Hf3/YBah7AOuwk6LtV3EftQIhw
 9vXqCnBwP/nID6PQ685zl3vH68yzF6FVNwbDagxUz/gMiQh7scHvVCjiqkJ+qu/36JgtTYYw
 8lGWRcto6gr0eTF8Wd8f81wspmUHGsFdN/xPsZPKMw6/on9oOj3AidcR3P9EdLY4qQyjvcNC
 V9cL9b5I/Ud9ghPwW4QkM7uhYqQDyh3SwgEFudc+/RsDuxjVlg9CFnGhS0nPXR89SaQZABEB
 AAG0HVNpbmFuIEtheWEgPG9rYXlhQGtlcm5lbC5vcmc+iQFOBBMBCAA4FiEEYdOlMSE+a7/c
 ckrQvGF4I+4LAFcFAlztcAoCGwMFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQvGF4I+4L
 AFfidAf/VKHInxep0Z96iYkIq42432HTZUrxNzG9IWk4HN7c3vTJKv2W+b9pgvBF1SmkyQSy
 8SJ3Zd98CO6FOHA1FigFyZahVsme+T0GsS3/OF1kjrtMktoREr8t0rK0yKpCTYVdlkHadxmR
 Qs5xLzW1RqKlrNigKHI2yhgpMwrpzS+67F1biT41227sqFzW9urEl/jqGJXaB6GV+SRKSHN+
 ubWXgE1NkmfAMeyJPKojNT7ReL6eh3BNB/Xh1vQJew+AE50EP7o36UXghoUktnx6cTkge0ZS
 qgxuhN33cCOU36pWQhPqVSlLTZQJVxuCmlaHbYWvye7bBOhmiuNKhOzb3FcgT7kBDQRa5zq1
 AQgAyRq/7JZKOyB8wRx6fHE0nb31P75kCnL3oE+smKW/sOcIQDV3C7mZKLf472MWB1xdr4Tm
 eXeL/wT0QHapLn5M5wWghC80YvjjdolHnlq9QlYVtvl1ocAC28y43tKJfklhHiwMNDJfdZbw
 9lQ2h+7nccFWASNUu9cqZOABLvJcgLnfdDpnSzOye09VVlKr3NHgRyRZa7me/oFJCxrJlKAl
 2hllRLt0yV08o7i14+qmvxI2EKLX9zJfJ2rGWLTVe3EJBnCsQPDzAUVYSnTtqELu2AGzvDiM
 gatRaosnzhvvEK+kCuXuCuZlRWP7pWSHqFFuYq596RRG5hNGLbmVFZrCxQARAQABiQEfBBgB
 CAAJBQJa5zq1AhsMAAoJELxheCPuCwBX2UYH/2kkMC4mImvoClrmcMsNGijcZHdDlz8NFfCI
 gSb3NHkarnA7uAg8KJuaHUwBMk3kBhv2BGPLcmAknzBIehbZ284W7u3DT9o1Y5g+LDyx8RIi
 e7pnMcC+bE2IJExCVf2p3PB1tDBBdLEYJoyFz/XpdDjZ8aVls/pIyrq+mqo5LuuhWfZzPPec
 9EiM2eXpJw+Rz+vKjSt1YIhg46YbdZrDM2FGrt9ve3YaM5H0lzJgq/JQPKFdbd5MB0X37Qc+
 2m/A9u9SFnOovA42DgXUyC2cSbIJdPWOK9PnzfXqF3sX9Aol2eLUmQuLpThJtq5EHu6FzJ7Y
 L+s0nPaNMKwv/Xhhm6Y=
Message-ID: <245ffd79-316c-e985-d1da-2ccea6d29636@kernel.org>
Date:   Mon, 15 Jul 2019 11:17:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CABXRUiQXweOLRTpdyhx9xT_B1VBmoSoNm=_+Qr4prmz7u1QRFA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 7/15/2019 1:43 AM, Fuqian Huang wrote:
> Should I rewrite the commit log? Just mention that dma_alloc_coherent
> has already
> zeroed the memory and not to reference the commit?

I'd like to hear from Robin Murphy that arm smmu driver follows this as
well.
