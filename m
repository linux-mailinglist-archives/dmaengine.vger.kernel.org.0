Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DA14B62A7
	for <lists+dmaengine@lfdr.de>; Tue, 15 Feb 2022 06:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbiBOF1j (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Feb 2022 00:27:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiBOF1i (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 15 Feb 2022 00:27:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0845BC7D6D;
        Mon, 14 Feb 2022 21:27:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9518561280;
        Tue, 15 Feb 2022 05:27:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A63CC340EC;
        Tue, 15 Feb 2022 05:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644902849;
        bh=fEtyuqIWCrrTss2EnD/rDj7H0JxHslgvhSfuXmBo0GY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IwoGSe85tjDu3ePjvrSZaZ4qUvaHRkRIYvKnz6t0ixClUCSiSHr4Kgx5ifZZJgP2D
         E9PA4nufiIj71/+INk4RMyA8hKNTGRhIEdSLhQat3gw9/KczJGyAmwjjocoVqVFmjU
         fmQ4GaxcGHchcWR+y2qrUgtQfol0pRe9C45F9Rxx7huai4y4RInLz+jDZ6sxS+vQ65
         38UxwSWJFy86K/Q5TE9AtX7NP4/sTgon9G9/A2kk8DFMnvsh+irnuXVlYk8AdkPQO6
         2eB9JqeBLbkQRJPMZH2Qgnnv0AVD6PAmsb4k1Q4dqdwqbqGZJpvjLtQXS/rNhn/Sd7
         TiJc/x65jNsaw==
Date:   Tue, 15 Feb 2022 10:57:25 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     geert+renesas@glider.be, yoshihiro.shimoda.uh@renesas.com,
        laurent.pinchart@ideasonboard.com,
        wsa+renesas@sang-engineering.com, zou_wei@huawei.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: sh: rcar-dmac: Check for error num after
 setting mask
Message-ID: <Ygs5vYxqjuIyc87Z@matsya>
References: <20220106030939.2644320-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106030939.2644320-1-jiasheng@iscas.ac.cn>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06-01-22, 11:09, Jiasheng Jiang wrote:
> Because of the possible failure of the dma_supported(), the
> dma_set_mask_and_coherent() may return error num.
> Therefore, it should be better to check it and return the error if
> fails.

Applied, thanks

-- 
~Vinod
