Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA9F567E21
	for <lists+dmaengine@lfdr.de>; Wed,  6 Jul 2022 08:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiGFGA4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Jul 2022 02:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiGFGAz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 Jul 2022 02:00:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CF312AD2;
        Tue,  5 Jul 2022 23:00:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F07B61CB0;
        Wed,  6 Jul 2022 06:00:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 425A5C3411C;
        Wed,  6 Jul 2022 06:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657087253;
        bh=QxLabDfGGa0boLjx8uK7OSPiiu9DN2HnJiPLYUEQi7s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=STPky/rxNlut0gbGbY07fE2xRNRfdygV8WyWcsA6iyecWAjtZh9SoJKMDfaBN/YF+
         /qcd7E4jCIo3Mz64srjitN4J3V0RTsJa6kZybvGaXcJHe847jOKtCT9cHbK9mRnhHT
         L4QkA1eoHeiUMQEjWX1jYrHw754NqUP7JpS/Im0qh57Cuza3m36Janzo2bRFqVtBP8
         He+sI4N7UM8Tgp26K7mp+N4dglUTblTzkgduu89m0yvnZNceiv373VKs1Ng/zS2EYy
         iA0sVpMNxyiq2pEfztE1d6YFJFqYKCPG28LvCXvN2Btld8wkyL2eXyZYiRYb0u7JjX
         +mSAXYZ1ClkWQ==
Date:   Wed, 6 Jul 2022 11:30:49 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, shengjiu.wang@gmail.com, joy.zou@nxp.com,
        linux-imx@nxp.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dmaengine: imx-sdma: Add FIFO stride support for
 multi FIFO script
Message-ID: <YsUlESAPklVFxpzy@matsya>
References: <1655782566-21386-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1655782566-21386-1-git-send-email-shengjiu.wang@nxp.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 21-06-22, 11:36, Shengjiu Wang wrote:
> The peripheral may have several FIFOs, but some case just select
> some FIFOs from them for data transfer, which means FIFO0 and FIFO2
> may be selected. So add FIFO address stride support, 0 means all FIFOs
> are continuous, 1 means 1 word stride between FIFOs. All stride between
> FIFOs should be same.
> 
> Another option words_per_fifo means how many audio channel data copied
> to one FIFO one time, 1 means one channel per FIFO, 2 means 2 channels
> per FIFO.
> 
> If 'n_fifos_src =  4' and 'words_per_fifo = 2', it means the first two
> words(channels) fetch from FIFO0 and then jump to FIFO1 for next two words,
> and so on after the last FIFO3 fetched, roll back to FIFO0.

this fails to apply for me, pls rebase on dmaengine/next and revise

-- 
~Vinod
