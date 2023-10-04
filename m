Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B2E7B824D
	for <lists+dmaengine@lfdr.de>; Wed,  4 Oct 2023 16:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242781AbjJDO3T (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Oct 2023 10:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242817AbjJDO3T (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 Oct 2023 10:29:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2048ED7;
        Wed,  4 Oct 2023 07:29:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 658E1C433C8;
        Wed,  4 Oct 2023 14:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696429755;
        bh=XO7xocwSPfccQZGvIUZpCbzPGKYcrGynkzAL145VGIg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=eR00oIK97Dpo3L7jO/zuUhQzY1GjSybRnvanmb4Fv2o+EfInX7lrfNmC6CJRqxI6I
         MLe1G35hUrW5zC2O8u/xzNMgJ8UaqV1EKYpNaJBWKXAC6xQkGqoPDVCZBUFOXcJwH6
         rVGkGh+C8HAEIn8CDanyXDJ9tlALfwNCC2+Qxyxp1RPcUv9NEpuFFF3rPYCZ2LW02+
         RMQasqYX8dLhbIqaYTvqejDmrAGLNO899R5AEKzKXEL/109yiesre3rpzSFlMQ8LPo
         DCqQKemLcxYFT36SigAhTRLaBalAy0rf02VgDCJJXDtRcZzLOdtFAVFntBayKAgtsc
         3BAdaYIFQdUpg==
From:   Vinod Koul <vkoul@kernel.org>
To:     andriy.shevchenko@linux.intel.com,
        Yue Haibing <yuehaibing@huawei.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230809080012.22000-1-yuehaibing@huawei.com>
References: <20230809080012.22000-1-yuehaibing@huawei.com>
Subject: Re: [PATCH v2 -next] dmaengine: Remove unused declaration
 dma_chan_cleanup()
Message-Id: <169642975403.440009.12483299622206621683.b4-ty@kernel.org>
Date:   Wed, 04 Oct 2023 19:59:14 +0530
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


On Wed, 09 Aug 2023 16:00:12 +0800, Yue Haibing wrote:
> Commit f27c580c3628 ("dmaengine: remove 'bigref' infrastructure")
> removed the implementation but left declaration in place. Remove it.
> 
> 

Applied, thanks!

[1/1] dmaengine: Remove unused declaration dma_chan_cleanup()
      commit: 09361abc346102c505657db4f3ae19ed70e1b703

Best regards,
-- 
~Vinod


