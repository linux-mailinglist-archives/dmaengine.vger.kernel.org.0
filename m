Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2073673552
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jul 2019 19:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfGXRZc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Jul 2019 13:25:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:33354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbfGXRZc (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 24 Jul 2019 13:25:32 -0400
Received: from [10.84.150.89] (unknown [167.220.148.89])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9064222387;
        Wed, 24 Jul 2019 17:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563989131;
        bh=YymAhmHDxUWIUcOOfNXSzHixv8ogCiB0eKvQ24FxcNs=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=MAg5f5uAxCYetoBOVINOdCTKRWoLmTcFmump7tZvOHIwFXEz4tLEcmEQjSpQlbFFF
         jAhXVzNocg5ktbCyXz8DOMz5BNa3SLWTdOM2zWG14A8LCc9zbxVljBRa4TAzpnzd6d
         Q/SWx5AxvKQM9eRrowfuD5j/1brTEQFqCC/X4YAY=
Subject: Re: [PATCH v2] dma: qcom: hidma_mgmt: Add of_node_put() before goto
To:     Nishka Dasgupta <nishkadg.linux@gmail.com>, agross@kernel.org,
        vkoul@kernel.org, dan.j.williams@intel.com,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org
References: <20190724081609.9724-1-nishkadg.linux@gmail.com>
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
Message-ID: <eab2555a-07ad-9e48-14d4-e34417d52fbb@kernel.org>
Date:   Wed, 24 Jul 2019 13:25:29 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190724081609.9724-1-nishkadg.linux@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 7/24/2019 4:16 AM, Nishka Dasgupta wrote:
> Each iteration of for_each_available_child_of_node puts the previous
> node, but in the case of a goto from the middle of the loop, there is
> no put, thus causing a memory leak. 
> Hence add an of_node_put under the label that the gotos point to.
> In order to avoid decrementing an already-decremented refcount, copy the
> original contents of the label (including the return statement) to just
> above the label, so that the code under the label is executed only when
> a goto exit from the loop occurs.
> Additionally, remove an unnecessary get/put pair from the loop, as the
> loop itself already keeps track of refcount.
> Issue found with Coccinelle.
> 
> Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>

nit: please post v3 with dmaengine:qcom:hidma_mgmt:....

Vinod doesn't like commit subjectss in this directory to have dma name
on it. You can keep my acked-by.

Acked-by: Sinan Kaya <okaya@kernel.org>


