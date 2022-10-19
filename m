Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62658604798
	for <lists+dmaengine@lfdr.de>; Wed, 19 Oct 2022 15:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbiJSNmT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Oct 2022 09:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbiJSNln (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 19 Oct 2022 09:41:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91ED2DBD;
        Wed, 19 Oct 2022 06:29:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7949FB8201E;
        Wed, 19 Oct 2022 13:28:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 946C5C433D6;
        Wed, 19 Oct 2022 13:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666186102;
        bh=QLdJKSFkl5cNch6YWy028NXYBYaR4Mm59JRe5twJVfM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KTCl/FFlseTActg+uY7KGwN3IickSQAifQjatLRVvIxKwdH8jfYuJgh5XPYy0kAv0
         t/GVuObg3TaKppM27/9cjGIGeh8BCFatRdv9q2pbBFSWfwTprTWYUW4VYZXJC1IGmH
         3zCepn5VU/UDFCC6wAXo40sRd8LV9pfyatsM4tfQ9VUzF9IBs37fimm1/kmC5tv7uH
         bcqFqGysf4p69E4AsXrQ7hHEegQurTbJW7+CugTtpbj6YaOnoGhUype160QzDlZuO3
         Z1UcKSkOL1sMHkyCOfzZhWvgFlCvQZ0M3wJO6haLc/luReXkYHmvzzz2YRLF0L79ja
         wswqGUnjUCkug==
Date:   Wed, 19 Oct 2022 18:58:18 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        dmaengine@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Nicolas Frayer <nfrayer@baylibre.com>
Subject: Re: [PATCH v3 0/3] dma/ti: enable udma and psil to be built as
 modules
Message-ID: <Y0/7cumzrrGx74N9@matsya>
References: <20220929234820.940048-1-khilman@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929234820.940048-1-khilman@baylibre.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 29-09-22, 16:48, Kevin Hilman wrote:
> Enable the UDMA driver & glue and PSIL lib to be built & loaded as modules.                                                                                                   
>                                                                                                                                                                                
> The defauilt Kconfig settings are not changed, so default upstream is                                                                                                          
> still to be built in.  This series just enables the option to build as                                                                                                         
> modules.      

Applied, thanks

-- 
~Vinod
