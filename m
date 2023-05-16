Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077CF70556C
	for <lists+dmaengine@lfdr.de>; Tue, 16 May 2023 19:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjEPRvI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 May 2023 13:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjEPRvI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 16 May 2023 13:51:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275A62105;
        Tue, 16 May 2023 10:51:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B96E863374;
        Tue, 16 May 2023 17:51:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DE3C433D2;
        Tue, 16 May 2023 17:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684259466;
        bh=tFdn3U26VrkcjKuupCgxoRxeva+b+ssaUCHapcmlff0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kC4NYC37cO55tO/3rz9SvIk+5fK/J/ORYx/7ReL1ZQHNfm9wqOgXQKgXKiDRv0qjT
         85D5l0naX6Ogapi8dpJmS3I7gWA3G1h23ntf1MMXM26B5ugPTgUXdaQWRSGTznd6hu
         YigJyXEjPTHK6dSVlIg+QH8wh7Vk3BYa+DiIIAgO16WxmPqu/VpnsewF16CMxVEHlx
         kFOLFHiApLk0P7wO0LnOyANBynrkXbwHf+FXcXFuJgU/12FtywzB+dXLiUIVEYjaG7
         QBZNzrgczC2XRCNjm4lQCoOzn1JTc/VfQMcZCh750TrE4bVTaFE/O/DjmsOrJc22nt
         Qr3l9+L+tnQ9A==
Date:   Tue, 16 May 2023 23:21:01 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     error27@gmail.com, kernel-janitors@vger.kernel.org,
        dan.carpenter@linaro.org, Fenghua Yu <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: Fix passing freed memory in
 idxd_cdev_open()
Message-ID: <ZGPChVyCDwX2wEJs@matsya>
References: <20230509060716.2830630-1-harshit.m.mogalapalli@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509060716.2830630-1-harshit.m.mogalapalli@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 08-05-23, 23:07, Harshit Mogalapalli wrote:
> Smatch warns:
> 	drivers/dma/idxd/cdev.c:327:
> 		idxd_cdev_open() warn: 'sva' was already freed.
> 
> When idxd_wq_set_pasid() fails, the current code unbinds sva and then
> goes to 'failed_set_pasid' where iommu_sva_unbind_device is called
> again causing the above warning.
> [ device_user_pasid_enabled(idxd) is still true when calling
> failed_set_pasid ]

Applied, thanks

-- 
~Vinod
