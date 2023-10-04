Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDC97B8248
	for <lists+dmaengine@lfdr.de>; Wed,  4 Oct 2023 16:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbjJDO3O (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Oct 2023 10:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242750AbjJDO3N (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 Oct 2023 10:29:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A5FC1
        for <dmaengine@vger.kernel.org>; Wed,  4 Oct 2023 07:29:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B25C433C8;
        Wed,  4 Oct 2023 14:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696429750;
        bh=1+vE+/v1IUKVGMmYRM/EOfUwW1yijaJIfT9Ad/Xm77w=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=ffbNHhFi4kjKwRihSQmh74BETGMKssfzNSn1nr+viLNoLG5CAQDG/6Vlz44t6bsSs
         Z2LcAr+t6BJAesz+nvEFgTHdDbafalrFL4/Qix3XSFGBsD7qSB7JAAxN3c0VVJnpZJ
         nrRQS3tA6oImYCtVk3QsOpCrHCZ8fTaJI6+quGR4K5GZ+LTpaqpuatFdv3PfXAL6lu
         u461EJQDsBC0MvE85QOMDyshaWk6eSgbM2t7Yxf8hzA6YIn5/P7q3n2FYebeWGwYLn
         DdxlRRK8YZOE88NFQ9JVBhFh4GqnP+v+TLpy4+txekMvKBLEuszVwUucwohxJ2bia9
         GQzOI3xw+8UnQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     dmaengine@vger.kernel.org, Frank Li <Frank.Li@nxp.com>,
        Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20230901071115.1322000-1-ruanjinjie@huawei.com>
References: <20230901071115.1322000-1-ruanjinjie@huawei.com>
Subject: Re: [PATCH -next] dmaengine: fsl-edma: Remove redundant dev_err()
 for platform_get_irq()
Message-Id: <169642974865.440009.2488849155862421145.b4-ty@kernel.org>
Date:   Wed, 04 Oct 2023 19:59:08 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Fri, 01 Sep 2023 15:11:14 +0800, Jinjie Ruan wrote:
> Since commit 7723f4c5ecdb ("driver core: platform: Add an error message
> to platform_get_irq*()") and commit 2043727c2882 ("driver core:
> platform: Make use of the helper function dev_err_probe()"), there is
> no need to call the dev_err() function directly to print a custom
> message when handling an error from platform_get_irq() function as it is
> going to display an appropriate error message in case of a failure.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: fsl-edma: Remove redundant dev_err() for platform_get_irq()
      commit: 88ba97688a03843755803bfc28b975ae27d533d1

Best regards,
-- 
~Vinod


