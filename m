Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2ED16047E6
	for <lists+dmaengine@lfdr.de>; Wed, 19 Oct 2022 15:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbiJSNr1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Oct 2022 09:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbiJSNqQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 19 Oct 2022 09:46:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129451C840A;
        Wed, 19 Oct 2022 06:31:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4131561871;
        Wed, 19 Oct 2022 13:31:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D43BC433C1;
        Wed, 19 Oct 2022 13:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666186291;
        bh=yrinlrU4GJFw5V8Pbm68WtjQ9PDNU+MEIvH4dMiemYg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QtQfot2R1zDOvLSyEHXFdv4m6AtscL8NOugTTNHxO+zgyBqLUIk6KxyuELqdVJ8/O
         x67CsoRPxX0cPDzoDEDAGTZ+B/8jAtZvOv25VRXmXoBdVsDmoH079a0nihfQlvLnsF
         +3ef9CUOjsloN1Dg/i001SdTCiTgm6+MvfMAvhNk+VPRGEXnaVG1zZTD4WF6PVD3MU
         46Rw4f22OZqWkUIReKjLqVOGHVFPnWwk2dFjkLO/Y8HOSLv/ZWDg6Y00FY3aMgCAop
         lx70EsZgKD1zmUlwl+zjMvY/Nm7Nq+pGFGvvHO4+NyVmMG0nkKkpPSmXPifOZABD7r
         NgnZMvkrMIepA==
Date:   Wed, 19 Oct 2022 19:01:27 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: stm32-mdma: memset stm32_mdma_chan_config
 struct before using it
Message-ID: <Y0/8L/13dozOA+WG@matsya>
References: <20221017131413.202567-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017131413.202567-1-amelie.delaunay@foss.st.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 17-10-22, 15:14, Amelie Delaunay wrote:
> New bool m2m_hw has been added at the end of stm32_mdma_chan_config struct
> to support the STM32 DMA MDMA chaining.
> 
> m2m_hw is set true in stm32_mdma_slave_config() if peripheral_size is set,
> but m2m_hw is never initialized false.
> 
> To ensure this case, and any further new update of the structure, memset it
> to 0 before using it.

Applied, thanks

-- 
~Vinod
