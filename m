Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5054F79C5
	for <lists+dmaengine@lfdr.de>; Thu,  7 Apr 2022 10:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243082AbiDGIdF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 7 Apr 2022 04:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243061AbiDGIdD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 7 Apr 2022 04:33:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E4B1637F2
        for <dmaengine@vger.kernel.org>; Thu,  7 Apr 2022 01:31:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05FC3B826C9
        for <dmaengine@vger.kernel.org>; Thu,  7 Apr 2022 08:31:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C1D9C385AA;
        Thu,  7 Apr 2022 08:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649320261;
        bh=m9mZwmfITUG9y7od8bh3zjd0ZA2ymkqK6Y6Y4T2wQ3A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b9KpGhr13M2J52U606lfwZCkz90YFN3domd7I0xQ7ufvgt5hl2L3BX+QIKs2DyUEm
         jlybbhXAmwOiIjF3pM+wRGCGm9BykXHU//CzTUy7uawDVMk40+YaiKyIaX3Yln5old
         spCbVghVr9jd+bnfHlXR3CkJ/Y37KzhUh1Z4B7bR8bmdpMZJ9+xYl4cEPHeagsHThK
         mrV0OCbeJZ7rXo636owmzjAqccSnrs8pgqRLIYiL3d3SSLwwcLjV2ekZgJihFvvheV
         KEkcA1m9JqdgEsLkvCf0S8dxPMqUh/hTVM7icsRZmIV4+0kF8Ba7XnjcdFUkMu8TtO
         QhEkXetJVT2Ew==
Date:   Thu, 7 Apr 2022 14:00:57 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     alsa-devel@alsa-project.org, Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>, kernel@pengutronix.de,
        NXP Linux Team <linux-imx@nxp.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH v3 09/20] dmaengine: imx: Move header to include/dma/
Message-ID: <Yk6hQR/ApMsLY+yf@matsya>
References: <20220405075959.2744803-1-s.hauer@pengutronix.de>
 <20220405075959.2744803-10-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405075959.2744803-10-s.hauer@pengutronix.de>
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
> The i.MX DMA drivers are device tree only, nothing in
> include/linux/platform_data/dma-imx.h has platform_data in it, so move
> the file to include/linux/dma/imx-dma.h.

Acked-By: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
