Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0F7705533
	for <lists+dmaengine@lfdr.de>; Tue, 16 May 2023 19:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjEPRoc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 May 2023 13:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEPRob (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 16 May 2023 13:44:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B68FC;
        Tue, 16 May 2023 10:44:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C45363D1F;
        Tue, 16 May 2023 17:44:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D81C433EF;
        Tue, 16 May 2023 17:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684259069;
        bh=QFHWIbp7xVmzwRiivQjuxHEv7aR4ZQD6vkzepj5JacU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FYV19NujHbagsyC1cAomrbyAind2xfpeegaLb1HRGWSvOfFGbJmQfEiKYJ2M+oMkF
         Z6yDHZK6X2y0vxpGI1687M0o6DULdHEE0OY/x1c3RhKD7Oyim8HRI2yOdsOvHrMi+s
         n9a8RH8ccZLPufuG7LP8oJ9i26fl3hInVxVSBVVEXg1S67uEf5nZQUlbuUrWTcSWG5
         cG+hYyCOYXCy8UaFuU65tHmBQvT0ffxfLL6DAQiuHcvTeGB/ePYQyAZbYbI+2IQ0G4
         mWVxt/+kMGR0N+dBdjUzLvqqjEkfNxW1yD8/dCpIoo47P/xpecu6CDPIwugy/cq48A
         JxbS91iI62rJg==
Date:   Tue, 16 May 2023 23:14:25 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     peter.ujfalusi@gmail.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ti: k3-udma: define udma_pm_resume,suspend
 with CONFIG_PM_SLEEP
Message-ID: <ZGPA+V5WqZItfp74@matsya>
References: <20230501025647.2905317-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230501025647.2905317-1-trix@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 30-04-23, 22:56, Tom Rix wrote:
> gcc reports
> drivers/dma/ti/k3-udma.c:5552:12: error: ‘udma_pm_resume’
>   defined but not used [-Werror=unused-function]
>  5552 | static int udma_pm_resume(struct device *dev)
>       |            ^~~~~~~~~~~~~~
> drivers/dma/ti/k3-udma.c:5530:12: error: ‘udma_pm_suspend’
>   defined but not used [-Werror=unused-function]
>  5530 | static int udma_pm_suspend(struct device *dev)
>       |            ^~~~~~~~~~~~~~~
> 
> These functions are used conditionally with CONFIG_PM_SLEEP,
> so they should be likewise defined.

A better way would be to use __maybe_unused. I have sent a patch with
that change

> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/dma/ti/k3-udma.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index fc3a2a05ab7b..f189b0f2e423 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -5527,6 +5527,7 @@ static int udma_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> +#ifdef CONFIG_PM_SLEEP
>  static int udma_pm_suspend(struct device *dev)
>  {
>  	struct udma_dev *ud = dev_get_drvdata(dev);
> @@ -5573,6 +5574,7 @@ static int udma_pm_resume(struct device *dev)
>  
>  	return 0;
>  }
> +#endif
>  
>  static const struct dev_pm_ops udma_pm_ops = {
>  	SET_LATE_SYSTEM_SLEEP_PM_OPS(udma_pm_suspend, udma_pm_resume)
> -- 
> 2.27.0

-- 
~Vinod
