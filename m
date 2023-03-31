Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2B06D2012
	for <lists+dmaengine@lfdr.de>; Fri, 31 Mar 2023 14:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbjCaMWY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 31 Mar 2023 08:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbjCaMWB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 31 Mar 2023 08:22:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279A220C12;
        Fri, 31 Mar 2023 05:21:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72C5B6252C;
        Fri, 31 Mar 2023 12:21:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 006BAC433EF;
        Fri, 31 Mar 2023 12:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680265288;
        bh=qjxhFHgRDKgQd0YZIE0gdI9Qd2axFPOwPWgUbDSQUaA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mjfOzE6l1QTG4/mErNaWoZBjJ1alTHmmqTbWlj+5N5HCCooR637lHTBfQHwEeFt4D
         vFGQhHaBZrNjWvp9vTdQxKhhu16ybMT0JOUWFoGHJk1kKZmP22DF5JExOyCQeQ2ZWh
         ldx8cQqIlk+32qX7cItCeZ5ghpVN7/iAcL2qDhOsdcM+ZYc38/l0Q3wSmB8HV5tz9C
         OYd8gnolfbdxFl3IV6GfRZt4/B+Sp8MiHkc9Hdul58p9biodYvaZyu9vkUWISrCGU5
         5ORZvdqa6C79BB4N8yxxXwXXhSlgZSmWqEGCNyNGvEDrGldPKlR4WUiD38iNWhwqEg
         7zMd2cwPOsfFA==
Date:   Fri, 31 Mar 2023 17:51:24 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     ldewangan@nvidia.com, jonathanh@nvidia.com,
        thierry.reding@gmail.com, nathan@kernel.org,
        ndesaulniers@google.com, dmaengine@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] dmaengine: tegra-apb: remove unused tdma_read function
Message-ID: <ZCbQRE9MS1Jg43uP@matsya>
References: <20230322121001.2569909-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322121001.2569909-1-trix@redhat.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 22-03-23, 08:10, Tom Rix wrote:
> clang with W=1 reports
> drivers/dma/tegra20-apb-dma.c:236:19: error: unused function
>   'tdma_read' [-Werror,-Wunused-function]
> static inline u32 tdma_read(struct tegra_dma *tdma, u32 reg)
>                   ^
> This function is not used so remove it.

Applied, thanks

-- 
~Vinod
