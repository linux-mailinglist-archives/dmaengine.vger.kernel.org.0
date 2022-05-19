Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1439952DBCE
	for <lists+dmaengine@lfdr.de>; Thu, 19 May 2022 19:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243398AbiESRt4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 19 May 2022 13:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243422AbiESRto (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 19 May 2022 13:49:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48422D028E;
        Thu, 19 May 2022 10:49:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD8CA61913;
        Thu, 19 May 2022 17:49:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFAB8C385AA;
        Thu, 19 May 2022 17:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652982545;
        bh=ac9xGH+1JIcnCHzru2IWbkDZOfZZiXdeXvfoHhLdoqM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=spOW840KGB04EbAqRHdAwCEI4ueJigujG10gmrQZoJohM6H/G5k95LoEo8lMQIRUG
         kb5EgjV5RPlKUXKLzXwJlYXAPbrzUmvcCpkIsEy9yT7mj+kqsXctQyxtnyDoGSfPPR
         vGw9oRS1FSIl4okTHuPOQ27P3GZJb0Bmt537RCgrscZRYwICzTULien/6Av1HMM1Uf
         DuduX7Auy6kWgTAouMt+V/zK487LrCXmjI70yWCZx+rim2RgcJnonMLLim/HxoXn44
         3WcpcMhtBuuWBLGbev6CQvd8UXSbD2uoT8OpUBO9XydaZDIF6ZBHFHOQdVtSh4Y7aM
         KjdTCTo/HfA6A==
Date:   Thu, 19 May 2022 23:19:00 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] STM32 DMA pause/resume support
Message-ID: <YoaDDFtLBjFWAJoQ@matsya>
References: <20220505115611.38845-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505115611.38845-1-amelie.delaunay@foss.st.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 05-05-22, 13:56, Amelie Delaunay wrote:
> This patchset introduces pause/resume support in stm32-dma driver.
> [1/4], [2/4] and [3/4] ease the introduction of device_pause/device_resume
> ops management in [4/4].

Applied, thanks

-- 
~Vinod
