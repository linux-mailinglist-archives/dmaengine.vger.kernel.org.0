Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA2A56AB6F
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jul 2019 17:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbfGPPKT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 Jul 2019 11:10:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:38654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728384AbfGPPKS (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 16 Jul 2019 11:10:18 -0400
Received: from [10.84.150.84] (unknown [167.220.148.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D79052173B;
        Tue, 16 Jul 2019 15:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563289817;
        bh=qsVYG/AAKfZqvM/AL48HHkboJVYj6AAMTA3FfuN1840=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cA0qN5tFZBu+I0MkNLY1rdU6KqOdCmjmgBZqfB3AYRCy+6Cx+1bm4YhjQvkbyzmvD
         HunhvZyLo8l2aLhfLvSgNC/rgeU95ST08kkJkAJB5nUfQk3aTdvW70dMweVgXFYDcf
         TC4WiUmbxp4t1zcUxnICgEl+WIfag5taN+tPq2p8=
Subject: Re: [PATCH v3 04/24] dmaengine: qcom_hidma: Remove call to memset
 after dmam_alloc_coherent
To:     Robin Murphy <robin.murphy@arm.com>,
        Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
References: <20190715031723.6375-1-huangfq.daxian@gmail.com>
 <72c45b14-f0c0-9d1c-0953-eea70ce513a0@kernel.org>
 <CABXRUiQXweOLRTpdyhx9xT_B1VBmoSoNm=_+Qr4prmz7u1QRFA@mail.gmail.com>
 <245ffd79-316c-e985-d1da-2ccea6d29636@kernel.org>
 <9ea5f97f-5963-5836-6ab2-dc30628c6820@arm.com>
From:   Sinan Kaya <okaya@kernel.org>
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
Message-ID: <ee011ef9-fe02-8fea-b34d-cb7628abac19@kernel.org>
Date:   Tue, 16 Jul 2019 11:10:15 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9ea5f97f-5963-5836-6ab2-dc30628c6820@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 7/16/2019 7:35 AM, Robin Murphy wrote:
> On 15/07/2019 16:17, Sinan Kaya wrote:
>> On 7/15/2019 1:43 AM, Fuqian Huang wrote:
>>> Should I rewrite the commit log? Just mention that dma_alloc_coherent
>>> has already
>>> zeroed the memory and not to reference the commit?
>>
>> I'd like to hear from Robin Murphy that arm smmu driver follows this as
>> well.
> 
> I'd be lying if I said it did.
> 
> ...but only because that's never been part of the SMMU driver's
> responsibility either way. The iommu-dma layer however, and thus the
> respective arm64 iommu_dma_ops, has always zeroed allocations right from
> its inception.
> 
> 518a2f1925c3 was just cleaning up the last of the stragglers which
> *weren't* already clearing buffers anyway, such that we could formalise
> that behaviour into the API.

Thanks for confirming the behavior for arm64 arch.

Acked-by: Sinan Kaya <okaya@kernel.org>

