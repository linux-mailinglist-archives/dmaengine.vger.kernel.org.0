Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC474F79CE
	for <lists+dmaengine@lfdr.de>; Thu,  7 Apr 2022 10:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243087AbiDGIdy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 7 Apr 2022 04:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243138AbiDGIdw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 7 Apr 2022 04:33:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3362B22031C
        for <dmaengine@vger.kernel.org>; Thu,  7 Apr 2022 01:31:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2F55618FE
        for <dmaengine@vger.kernel.org>; Thu,  7 Apr 2022 08:31:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A202C385A0;
        Thu,  7 Apr 2022 08:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649320308;
        bh=3XImbs9tYxaOBQMtogypa7KJuCYfykCfRlkZqbJCaJA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SEVdm7I3h4PQUGOwBmgWIUlzdS5ov5DTIERt225MvujqOny0VHzL+Yb5zsscHbH1z
         SBpGzSks+E8vLVhVXPHbT7ajI7L379w4p4f7ONZVHbiHFzUOhXnb2MLOBOuem+4000
         Y6oy2hYjnqftMl+EYRRTMXKCD1VGITplB2Y+b/DXTVJKtikb2e4eQXKve+S0rXTzN2
         DuS8JJKn0aVeP4e7NmzLAsBA+ui6tIcnbdWcORbLFuF1geLDMSoE0SEBkkeJneGkzw
         2x4Ttz0FtPjP+idJtz/IcWpT5l8PAK6MzK/SXgSsxt2WamHGaf7O34s0euanib5Ov0
         D+wAl1ihqscRw==
Date:   Thu, 7 Apr 2022 14:01:43 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     alsa-devel@alsa-project.org, Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>, kernel@pengutronix.de,
        NXP Linux Team <linux-imx@nxp.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH v3 11/20] dmaengine: imx-sdma: Add multi fifo support
Message-ID: <Yk6hb+vcI95eCshj@matsya>
References: <20220405075959.2744803-1-s.hauer@pengutronix.de>
 <20220405075959.2744803-12-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405075959.2744803-12-s.hauer@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 05-04-22, 09:59, Sascha Hauer wrote:
> The i.MX SDMA engine can read from / write to multiple successive
> hardware FIFO registers, referred to as "Multi FIFO support". This is
> needed for the micfil driver and certain configurations of the SAI
> driver. This patch adds support for this feature.
> 
> The number of FIFOs to read from / write to must be communicated from
> the client driver to the SDMA engine. For this the struct
> dma_slave_config::peripheral_config field is used.

Acked-By: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
