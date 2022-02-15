Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBF74B6300
	for <lists+dmaengine@lfdr.de>; Tue, 15 Feb 2022 06:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiBOFmc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Feb 2022 00:42:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiBOFmc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 15 Feb 2022 00:42:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1189E22502;
        Mon, 14 Feb 2022 21:42:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BB1E6B8175C;
        Tue, 15 Feb 2022 05:42:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F64FC340EC;
        Tue, 15 Feb 2022 05:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644903739;
        bh=ea5uavDZWYK+1btNRQTGqmqDvg/Qnuw0OTjPXj0lYaA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c7+SElxUQ+qFQPU2reBVjOq/J4pODDFbxRufI7yBhTG4U4XceJvnk6gRFXHvWvax9
         eoVV8+AQHviE7J2oaANhRo8nrxhKJng8moYtiv9QPlgrWSLoQUz7sg3IgZEkAXdsHs
         if/jmjQsNyw9Ifpm8/+qbbzvEBVhrPyqkPinZWLePoPktx7xx3IcF3sOwhOZhX5m8Q
         wXvPlHHSAyJq93PPe9GTdxwHPqQuZzY8Nbkt1QB9MYt7W6ohQ8z3qv77ipZxx/TT8o
         EMsqVbEkmh9vqlaSSY5goh1XwmjbDXEIl9GwS5h6Vhzf2XclL7nu3TgcRnwGJnmMNa
         t/UyqHIRCzLDQ==
Date:   Tue, 15 Feb 2022 11:12:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alain Volmat <alain.volmat@foss.st.com>
Subject: Re: [PATCH] dmaengine: stm32-dma: set dma_device max_sg_burst
Message-ID: <Ygs9N9VTEIwciL4o@matsya>
References: <20220117091740.11064-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220117091740.11064-1-amelie.delaunay@foss.st.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 17-01-22, 10:17, Amelie Delaunay wrote:
> Some stm32-dma consumers [1] rather use dma_get_slave_caps() to get
> max_sg_burst of their DMA channel as dma_get_max_seg_size() is specific to
> the DMA controller.
> All stm32-dma channels have the same features so, don't need to implement
> device_caps ops. Let dma_get_slave_caps() relies on dma_device
> configuration.
> That's why this patch sets dma_device max_sg_burst to the maximum segment
> size, which is the maximum of data items that can be transferred without
> software intervention.

Applied, thanks

-- 
~Vinod
