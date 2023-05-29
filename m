Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618767143B1
	for <lists+dmaengine@lfdr.de>; Mon, 29 May 2023 07:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbjE2FXC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 May 2023 01:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjE2FW7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 29 May 2023 01:22:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167D5B1;
        Sun, 28 May 2023 22:22:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83DF1611F0;
        Mon, 29 May 2023 05:22:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7103C433D2;
        Mon, 29 May 2023 05:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685337769;
        bh=ggrBfM5Pkx6rzaVYqbUXNj5/omnkZEAUkcCnHkhmQ38=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=moNGhNs0pZI4d94Czmaj5IpoVe9wK0bA6CFjla1rjPgX4TJPMNrytbQjcZ2KdoB1D
         /0YRPJ93oJI1lfJ+3vrc5B06TxpZj7h6mscg9STG8mrBDoZhXDPc2XhTz32saZOYNB
         OFf7RulZVLDuRdwBJh8vGLib3/MVTAcMsFfkaLXZfRe/nEWYRDiK88KJVSPhhZ6WSm
         +fMNmubD0mKSkuVF7mwRVdupC2IMmKTny8bNzjWO6xMOUkaMsBvBXj2U+CzAciN5U4
         lF/qVmlp02zX6GXJyTlM3VpzF0rEqTxA3/JxTNbE4CiCfsudiCkN9PM6caUqVQ3w3H
         dHL2jiTuwyK8g==
Date:   Mon, 29 May 2023 10:52:27 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Cai Huoqing <cai.huoqing@linux.dev>
Cc:     fancer.lancer@gmail.com, gustavo.pimentel@synopsys.com,
        vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add Cai Huoqing as dw-edma maintainer
Message-ID: <20230529052227.GA2856@thinkpad>
References: <20230529032423.11650-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230529032423.11650-1-cai.huoqing@linux.dev>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

On Mon, May 29, 2023 at 11:24:23AM +0800, Cai Huoqing wrote:
> Since HDMA mode was merged, including the commits:
> commit e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA"),
> commit 353d5c241e83 ("dmaengine: dw-edma: Add HDMA DebugFS support"),
> I would like to add myself as maintainer of the dw-edma driver
> to recive patch for HDMA part. 
> 
> I can test HDMA part by our chip and cmodel and do some code review.
> I'm active in linux contribution, if possible, I want to
> take the dw-edma maintainership.
> 

Thanks for your interest in maintaining this driver. However, maintainership
involves active reviewing and maintaining the whole driver and not just the HDMA
part. If that's what you are intend to do, then I'd encourage you to first spend
some time reviewing and testing the patches targeting the dw-edma driver.

This will help justifying the reviewer/maintainership role in the future.

- Mani

> Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3a0504731524..541601feabd0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5881,6 +5881,7 @@ F:	drivers/mtd/nand/raw/denali*
>  
>  DESIGNWARE EDMA CORE IP DRIVER
>  M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +M:	Cai Huoqing <cai.huoqing@linux.dev>
>  R:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>  R:	Serge Semin <fancer.lancer@gmail.com>
>  L:	dmaengine@vger.kernel.org
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
