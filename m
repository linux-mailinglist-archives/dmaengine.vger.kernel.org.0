Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4BD69A8A5
	for <lists+dmaengine@lfdr.de>; Fri, 17 Feb 2023 10:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjBQJz7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Feb 2023 04:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjBQJz7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Feb 2023 04:55:59 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C245F82B
        for <dmaengine@vger.kernel.org>; Fri, 17 Feb 2023 01:55:57 -0800 (PST)
Received: (Authenticated sender: peter@korsgaard.com)
        by mail.gandi.net (Postfix) with ESMTPSA id AEABE60004;
        Fri, 17 Feb 2023 09:55:52 +0000 (UTC)
Received: from peko by dell.be.48ers.dk with local (Exim 4.94.2)
        (envelope-from <peter@korsgaard.com>)
        id 1pSxT5-006WNo-Mn; Fri, 17 Feb 2023 10:55:51 +0100
From:   Peter Korsgaard <peter@korsgaard.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     <dmaengine@vger.kernel.org>, <lizhi.hou@amd.com>,
        <brian.xu@amd.com>, <raj.kumar.rampelli@amd.com>,
        <vkoul@kernel.org>, <michal.simek@xilinx.com>,
        <sonal.santan@amd.com>, <max.zhen@amd.com>, <liwei391@huawei.com>
Subject: Re: [PATCH -next] dmaengine: xilinx: xdma: fix return value check
 in xdma_probe()
References: <20230217062652.172480-1-yangyingliang@huawei.com>
Date:   Fri, 17 Feb 2023 10:55:51 +0100
In-Reply-To: <20230217062652.172480-1-yangyingliang@huawei.com> (Yang
        Yingliang's message of "Fri, 17 Feb 2023 14:26:52 +0800")
Message-ID: <87cz684nvc.fsf@dell.be.48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

>>>>> "Yang" == Yang Yingliang <yangyingliang@huawei.com> writes:

 > devm_ioremap_resource() never returns NULL pointer, it will return
 > ERR_PTR() when it fails, so replace the check with IS_ERR().

 > Fixes: 17ce252266c7 ("dmaengine: xilinx: xdma: Add xilinx xdma driver")
 > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Acked-by: Peter Korsgaard <peter@korsgaard.com>

> ---
 >  drivers/dma/xilinx/xdma.c | 3 ++-
 >  1 file changed, 2 insertions(+), 1 deletion(-)

 > diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
 > index 462109c61653..1c836cbdafa1 100644
 > --- a/drivers/dma/xilinx/xdma.c
 > +++ b/drivers/dma/xilinx/xdma.c
 > @@ -892,8 +892,9 @@ static int xdma_probe(struct platform_device *pdev)
 >  	}
 
 >  	reg_base = devm_ioremap_resource(&pdev->dev, res);
 > -	if (!reg_base) {
 > +	if (IS_ERR(reg_base)) {
 >  		xdma_err(xdev, "ioremap failed");
 > +		ret = PTR_ERR(reg_base);
 >  		goto failed;
 >  	}
 
 > -- 

 > 2.25.1


-- 
Bye, Peter Korsgaard
