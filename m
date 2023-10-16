Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92BCA7CA652
	for <lists+dmaengine@lfdr.de>; Mon, 16 Oct 2023 13:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbjJPLNG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 Oct 2023 07:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjJPLNE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 16 Oct 2023 07:13:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8508495
        for <dmaengine@vger.kernel.org>; Mon, 16 Oct 2023 04:13:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA0FC433C7;
        Mon, 16 Oct 2023 11:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697454783;
        bh=02xwKPl1uKoLMLgkf/bL2BHVnnB55lOIYg1liZFEpxo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=F4Q8GxwRC0m8eXP20elftjrUvb8/S5h+PKlXsEgI9C4gTInLnlGPp5nFv3zC1up7u
         jsAL8V2Jg9DEIuVdHaCCDNuWWYJbS3dP+9No2EBh0afB3mLCw404phXsAW3nMOggS2
         Igkjob7LgtNOu+OUAQF6n/v0zvTGey81SmP7pjv1Fe4WozjZFz9ApgOdBq4TEA1h00
         +ZKfb17in0aNNDCwFq8VmQ5EwY8pii/fGZdE86gC53Bm0M9XSjujbb4GagBNxs3BEM
         p/owt3WhZjeEbUtMgJ5npr7Q9McVaghUwBYRddqDyUXTp4EJUMZ3N4XB/IpBYq5tBj
         zwUTkIf+E3YSA==
From:   Vinod Koul <vkoul@kernel.org>
To:     =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Rob Herring <robh@kernel.org>,
        Peter Korsgaard <peter@korsgaard.com>,
        Liu Shixin <liushixin2@huawei.com>,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        dmaengine@vger.kernel.org, "Simek, Michal" <michal.simek@amd.com>,
        "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
In-Reply-To: <20231014211656.1512016-2-u.kleine-koenig@pengutronix.de>
References: <20231014211656.1512016-2-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] dmaengine: xilinx: xilinx_dma: Fix kernel doc about
 xilinx_dma_remove()
Message-Id: <169745478033.211836.2433287242174911610.b4-ty@kernel.org>
Date:   Mon, 16 Oct 2023 16:43:00 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Sat, 14 Oct 2023 23:16:57 +0200, Uwe Kleine-König wrote:
> Since commit cc99582d46b4 ("dmaengine: xilinx: xilinx_dma: Convert to
> platform remove callback returning void") xilinx_dma_remove() doesn't
> return zero any more. As the function has no return value any more, just
> drop the statement about the return value.
> 
> 

Applied, thanks!

[1/1] dmaengine: xilinx: xilinx_dma: Fix kernel doc about xilinx_dma_remove()
      commit: c1939c2f76d7971b0a02cad0d1d1e9d44ac37cfc

Best regards,
-- 
~Vinod


