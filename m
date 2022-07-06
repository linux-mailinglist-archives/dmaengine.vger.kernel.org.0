Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C46568F1F
	for <lists+dmaengine@lfdr.de>; Wed,  6 Jul 2022 18:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbiGFQ2T (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Jul 2022 12:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbiGFQ2S (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 Jul 2022 12:28:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE21627FD3;
        Wed,  6 Jul 2022 09:28:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 695B261CFD;
        Wed,  6 Jul 2022 16:28:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F170C3411C;
        Wed,  6 Jul 2022 16:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657124896;
        bh=hbt9LML4k5snC/PjqahX7eIoBOgADAowwktQqhDMz6g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a0rsbbMXTAMdsBUZCW0CcdSr1Q0wa2wzTYuLHI+qGlOsBszUcACTKJMdK2VH2IW+Y
         IbOj5whbQ+5XcQvTiC78DAfNhLupa5SCoUF/WYanutrpBM2pI6XbzcgOyGo1eODcdV
         Q76k5A2xDyzcMOO6HUkPIGsVs+4SrpwBb8AYo5uYTop5XHvUhNuAmi/twu2NTmh/WX
         qn6ZXga3TnZOrMRlAoAGKFjf4BeMUdFZYagD8W/+hycq4fYfp9Ra8SYrJtK9qXg/gD
         Xi9dULHylGZqRWTiZi4T4CvExHGoENIbMkPVmJpRB9NuIwXTodM0pziaT1VsrOI5qc
         6DEhq94nrTZjg==
Date:   Wed, 6 Jul 2022 21:58:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, shengjiu.wang@gmail.com, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: imx-sdma: Add missing struct documentation
Message-ID: <YsW4HGYQX6RTHQQb@matsya>
References: <1657086309-7964-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1657086309-7964-1-git-send-email-shengjiu.wang@nxp.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06-07-22, 13:45, Shengjiu Wang wrote:
> Fix compile warning that 'Function parameter or member not described'
> with 'W=1' option:
> 
> Add missing description for struct sdma_desc
> 
> There is not any description for struct sdma_script_start_addrs,
> so use /* instead of /**

Applied, thanks

-- 
~Vinod
