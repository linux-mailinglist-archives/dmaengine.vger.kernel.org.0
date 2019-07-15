Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBEBB682D2
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jul 2019 06:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725850AbfGOERb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 15 Jul 2019 00:17:31 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:34908 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfGOERa (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 15 Jul 2019 00:17:30 -0400
Received: by mail-yw1-f66.google.com with SMTP id g19so6312446ywe.2;
        Sun, 14 Jul 2019 21:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:subject:to:cc:references:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZU+N+jdHFGLm83s+Rk1MKxPtLrSDeM3IVCQzNfaWkQc=;
        b=tH0GJeQ0Qsos4Kd3Jn1sI+2rqlqRqd78CBBlGmEY08eAsMLyduNekysuXcKb3uFlwa
         KLYQaZzNdRkvHKmcpZhJ/GHR1aq6jpvFJgW/+OVF0J4HvDHcGpVp0Ot5WkCE5bkMatkE
         e0jY5TSrHfe2LGdgzwMearR6W5AOtCtWyFg9qPY9ATC+HwtVfQCPanaXoXb4zAKu9IYQ
         6ZprZsP7CR2eMNZUY6rK1ZmWrIz9AumuIuxA10MYnigbkdh1L0vjOIBmfC16lKulHw7E
         QC8EJDT2XVlnfd9CdqMbEquokiGhNglfDRjYsdflw+LPxSXKO6gxgTqJWF0fR4FCmCoi
         U3jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:subject:to:cc:references:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ZU+N+jdHFGLm83s+Rk1MKxPtLrSDeM3IVCQzNfaWkQc=;
        b=sJp59MKitXa3TEDz45rpwEwRBvqriJp1cHdnftXpbztsOHDNJ7Ecrl6e0iDv1Bdqmj
         EADg1p4On6VtJvZqUGbOzsNTJAHasWGpjx/RyQCkofqJbdZTIGh0kT5K+0Y97Zprr8Ky
         1yeMpvU2Rnm7ANJhrBtYhYjLhnGEhY62KDBOdUxDL0M6izXh3bjxNfurY6ybw7bboILF
         mYzaflSsrkZc2NQgRj06YhMfNYJbk4ialKhVdlXIadWBHQX5Z39ElP2KzDumz6CpkYaR
         T+b09oA6vYt/zb6aLP5eecxLccxgu1GUlFEP5Gsa3mkyJcEpuUsxYcZ8pZzNQW+7qnBj
         25QQ==
X-Gm-Message-State: APjAAAXePZcnl54RWLUw8i5I6KMrL/1NLDyYd2ZMFzdgFGNEEAwqBl6c
        NA3Kzchf6zpLl7WzckDTaoA=
X-Google-Smtp-Source: APXvYqygnT51jLI54Y7e4aJEwRF3BA/oh+jUvTlqNkFwBwPCh0tQZ4TodICNd7QYqSTmcFpz2ky6VQ==
X-Received: by 2002:a81:ae0e:: with SMTP id m14mr15251245ywh.308.1563164249752;
        Sun, 14 Jul 2019 21:17:29 -0700 (PDT)
Received: from [192.168.1.74] (75-58-59-55.lightspeed.rlghnc.sbcglobal.net. [75.58.59.55])
        by smtp.gmail.com with ESMTPSA id 206sm4035932ywu.34.2019.07.14.21.17.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jul 2019 21:17:28 -0700 (PDT)
From:   Sinan Kaya <Okaya@kernel.org>
X-Google-Original-From: Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH v3 04/24] dmaengine: qcom_hidma: Remove call to memset
 after dmam_alloc_coherent
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@infradead.org>
References: <20190715031723.6375-1-huangfq.daxian@gmail.com>
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
Message-ID: <72c45b14-f0c0-9d1c-0953-eea70ce513a0@kernel.org>
Date:   Mon, 15 Jul 2019 00:17:27 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190715031723.6375-1-huangfq.daxian@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 7/14/2019 11:17 PM, Fuqian Huang wrote:
> In commit 518a2f1925c3
> ("dma-mapping: zero memory returned from dma_alloc_*"),
> dma_alloc_coherent has already zeroed the memory.
> So memset is not needed.
> 
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>

I don't see SWIO or ARM64 IOMMU drivers getting impacted by
the mentioned change above (518a2f1925c3).

 arch/alpha/kernel/pci_iommu.c    | 2 +-
 arch/arc/mm/dma.c                | 2 +-
 arch/c6x/mm/dma-coherent.c       | 5 ++++-
 arch/m68k/kernel/dma.c           | 2 +-
 arch/microblaze/mm/consistent.c  | 2 +-
 arch/openrisc/kernel/dma.c       | 2 +-
 arch/parisc/kernel/pci-dma.c     | 4 ++--
 arch/s390/pci/pci_dma.c          | 2 +-
 arch/sparc/kernel/ioport.c       | 2 +-
 arch/sparc/mm/io-unit.c          | 2 +-
 arch/sparc/mm/iommu.c            | 2 +-
 arch/xtensa/kernel/pci-dma.c     | 2 +-
 drivers/misc/mic/host/mic_boot.c | 2 +-
 kernel/dma/virt.c                | 2 +-
 14 files changed, 18 insertions(+), 15 deletions(-)

How does this new behavior apply globally?

