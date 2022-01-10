Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC5C489622
	for <lists+dmaengine@lfdr.de>; Mon, 10 Jan 2022 11:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243739AbiAJKQ4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 Jan 2022 05:16:56 -0500
Received: from smtp23.cstnet.cn ([159.226.251.23]:39668 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243744AbiAJKQj (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 10 Jan 2022 05:16:39 -0500
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-03 (Coremail) with SMTP id rQCowABnbFhnB9xheltfBQ--.36673S2;
        Mon, 10 Jan 2022 18:16:07 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     geert@linux-m68k.org
Cc:     vkoul@kernel.org, yoshihiro.shimoda.uh@renesas.com,
        laurent.pinchart@ideasonboard.com,
        wsa+renesas@sang-engineering.com, zou_wei@huawei.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: Re: Re: [PATCH] dmaengine: sh: rcar-dmac: Check for error num after setting mask
Date:   Mon, 10 Jan 2022 18:16:06 +0800
Message-Id: <20220110101606.429119-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABnbFhnB9xheltfBQ--.36673S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYY7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
        6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
        kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8I
        cVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2js
        IEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE
        5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeV
        CFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l
        c2xSY4AK67AK6r4DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
        0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
        tVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
        CY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
        uYvjfUonmRUUUUU
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jan 10, 2022 at 05:37:34PM +0800, Geert Uytterhoeven wrote:
>> --- a/drivers/dma/sh/rcar-dmac.c
>> +++ b/drivers/dma/sh/rcar-dmac.c
>> @@ -1869,7 +1869,9 @@ static int rcar_dmac_probe(struct platform_device *pdev)
>>         dmac->dev = &pdev->dev;
>>         platform_set_drvdata(pdev, dmac);
>>         dma_set_max_seg_size(dmac->dev, RCAR_DMATCR_MASK);
>
> dma_set_max_seg_size() can fail, too.

Thanks for your reminder.
I will submit another patch to fix it and add
"Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>".

Sincerely thanks,
Jiang

