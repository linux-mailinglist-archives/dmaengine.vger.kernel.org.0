Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A2C5632DC
	for <lists+dmaengine@lfdr.de>; Fri,  1 Jul 2022 13:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbiGALsr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 1 Jul 2022 07:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbiGALsn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 1 Jul 2022 07:48:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A237969A;
        Fri,  1 Jul 2022 04:48:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6BF30B82DDC;
        Fri,  1 Jul 2022 11:48:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 671DDC341C7;
        Fri,  1 Jul 2022 11:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656676119;
        bh=2pQzU7gqkY/nFOfuO9ZtU39DvZKJA/Zp8kdwz95glOE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fRu4vqJ6hwMjkzZwp3/5O8VUQMqcEZiC1wHno3BVb6MXb5ikS3sLuqgauLEZFJoy8
         2LODdJzRU6C7PQV69ulgBngq589ah6DbFPN+5K1I3vDCoz6V867Bfk15RXJD+pgDOA
         RjPXl72HgcKwUHwHMhPB4AmwzQ3XZS6k4pNUcC+LUUKn4AkrWvezKxSMkrUf0X4gf+
         v13bjq5W7lycxbxOuQBfgtePHPQn5RYvuR1uWaYnjKOEN7K8hLw3B7Ll7JmTQWg9ru
         3lS45uNG1XezfAZne4lIup9ZbUb8yNW06f+qmETpdHIC/UBmML7Lvi5Lnk36jl2Ym5
         d/DL6q3SF62wA==
Date:   Fri, 1 Jul 2022 17:18:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        dmaengine@vger.kernel.org, Emil Renner Berthing <kernel@esmil.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Pandith N <pandith.n@intel.com>,
        Michael Zhu <michael.zhu@starfivetech.com>,
        linux-kernel@vger.kernel.org,
        Samin Guo <samin.guo@starfivetech.com>
Subject: Re: [PATCH] dmaengine: dw-axi-dmac: Fix RMW on channel suspend
 register
Message-ID: <Yr7fEleQDs2qBJTP@matsya>
References: <20220627090939.1775717-1-emil.renner.berthing@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627090939.1775717-1-emil.renner.berthing@canonical.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 27-06-22, 11:09, Emil Renner Berthing wrote:
> From: Emil Renner Berthing <kernel@esmil.dk>
> 
> When the DMA is configured for more than 8 channels the bits controlling
> suspend moves to another register. However when adding support for this
> the new register would be completely overwritten in one case and
> overwritten with values from the old register in another case.
> 
> Found by comparing the parallel implementation of more than 8 channel
> support for the StarFive JH7100 SoC by Samin.

Applied, thanks

-- 
~Vinod
