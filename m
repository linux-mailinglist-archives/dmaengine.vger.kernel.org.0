Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664077CA657
	for <lists+dmaengine@lfdr.de>; Mon, 16 Oct 2023 13:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbjJPLNL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 Oct 2023 07:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjJPLNK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 16 Oct 2023 07:13:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221B283;
        Mon, 16 Oct 2023 04:13:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE142C433CB;
        Mon, 16 Oct 2023 11:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697454788;
        bh=UAUugA1TRH3GNFHUIn31bVskNVQzeqghhP8ABGtukvE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=YAqoi0iUbfPDUjpjVXO6wBfsmdA54PwDqLnlg/LzHbRnh41ED/N+x3X8P2cJ74Znt
         xi4jBbxym5JSYILiAXV3+mnyBwcrIKqXyRYQJK5zBax2zMJ0pllHT+nN8R09wIItqv
         edhkwzj2RH8z1Dcd3uFtC66uCpCcit/6Kbuq3ls+7HqxWwjKrPjOoZVE5Fswi5SWWd
         RkSfNglzLl/VHogRcITq0Jk3+9cfRjVpOG9tUwHzca6gLLNAwWPqs8pyjR/fqB6zdX
         oLtvR9mvjdu3grHwTTTUroGDWT3BNnOzCXG2XuKuAs3MnxhMp5C4zBsmi66yo8Nu2d
         E60hGccgKUtWw==
From:   Vinod Koul <vkoul@kernel.org>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        M'boumba Cedric Madianga <cedric.madianga@gmail.com>,
        Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc:     Alain Volmat <alain.volmat@foss.st.com>, stable@vger.kernel.org,
        dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231009082450.452877-1-amelie.delaunay@foss.st.com>
References: <20231009082450.452877-1-amelie.delaunay@foss.st.com>
Subject: Re: [PATCH] dmaengine: stm32-mdma: correct desc prep when channel
 running
Message-Id: <169745478541.211836.5231413059323245231.b4-ty@kernel.org>
Date:   Mon, 16 Oct 2023 16:43:05 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Mon, 09 Oct 2023 10:24:50 +0200, Amelie Delaunay wrote:
> In case of the prep descriptor while the channel is already running, the
> CCR register value stored into the channel could already have its EN bit
> set.  This would lead to a bad transfer since, at start transfer time,
> enabling the channel while other registers aren't yet properly set.
> To avoid this, ensure to mask the CCR_EN bit when storing the ccr value
> into the mdma channel structure.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: stm32-mdma: correct desc prep when channel running
      commit: 03f25d53b145bc2f7ccc82fc04e4482ed734f524

Best regards,
-- 
~Vinod


