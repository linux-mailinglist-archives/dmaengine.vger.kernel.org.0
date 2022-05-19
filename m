Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E20B52DBFF
	for <lists+dmaengine@lfdr.de>; Thu, 19 May 2022 19:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243365AbiESRxS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 19 May 2022 13:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243363AbiESRwf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 19 May 2022 13:52:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A85C9ECA;
        Thu, 19 May 2022 10:51:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 041F361957;
        Thu, 19 May 2022 17:51:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB05CC3411E;
        Thu, 19 May 2022 17:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652982702;
        bh=4HOH8hGdisT7kvObHMoru1/cjL66qqMhvek5a+tvt8k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AI4Pzlgd6rgGA2MBUXLnpQtyJJgNqOZOhfsS5eIObcFDhd+TMl5OgUVUDxE3ihWDY
         6KkxbTJJuYKnmcrkzwRveKHAM9zr50hGesj+yPAeSSD+NdSmHQSRV2k7eibI+vum93
         dG9zDs1n0b2SdE72RcEFfzyWHpUR5QAjq1G+RTV8Yf4wBD49jbCq1Ad2cMO9M6uxUJ
         ha1m8E/UYcFMfZVFHW3APvyMyUYq/BLIN0TfhlXkkmveWAvBjDArePvITEQh/IsDdk
         947AGtvPgaU3uOc03a4yRs9Jp43bWrQpOLoKuidgBum440XPk/mEkeINywsVTK79ce
         Ay269JkheM9lw==
Date:   Thu, 19 May 2022 23:21:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] STM32 MDMA IRQ handler code cleaning
Message-ID: <YoaDqY4xa/Yq8ECS@matsya>
References: <20220504155322.121431-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504155322.121431-1-amelie.delaunay@foss.st.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 04-05-22, 17:53, Amelie Delaunay wrote:
> This patchset cleans stm32-mdma interrupt handler:
> - GISR1 register is not used on any STM32 SoC with MDMA
> - Remove chan wrong initialization
> - Lower the log level to debug instead of warn in case of spurious it
>   on stopped channel

Applied, thanks

-- 
~Vinod
