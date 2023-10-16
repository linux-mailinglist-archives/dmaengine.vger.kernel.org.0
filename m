Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95777CA653
	for <lists+dmaengine@lfdr.de>; Mon, 16 Oct 2023 13:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjJPLNH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 Oct 2023 07:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjJPLNG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 16 Oct 2023 07:13:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6ED83;
        Mon, 16 Oct 2023 04:13:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5636C433CA;
        Mon, 16 Oct 2023 11:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697454785;
        bh=LpH4MXYRVHeojK0PzBPGh2kX9dO/puTQlGQJy0EUKsY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ioNTQQfw3vZ2/xTXFeMZKdkR46rOPDz0HKF6PvniCWfT9gdj6SVXB2clsJWpU2+pa
         qAhmBp9EaY/pJEtTQLKJ7HGkttQLvp1abGbIdsyA45GLkXl69cGJ8YGoP/EAGYl21h
         Pd8UT1ELdeEco+5xV9kmKkjRW5SMlKbyfE/AVLKSE5jfXeKxOc+TL/T6JluzU3rBOb
         8qvnsFfGHteTHZNy/FtPzr3Qj+LD1cGNOt75/94lWCLh3NvSEs3k8BAnghurOXBhAm
         Qv3xgA0HPSZ4/d021YEEFRTtBPTdmCtfTdPyM7sjdXKrwEImIJ7rRutuLbLQpm3mHH
         4quA2CPsSpbrA==
From:   Vinod Koul <vkoul@kernel.org>
To:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Sergey Khimich <serghox@gmail.com>
Cc:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
In-Reply-To: <20231010101450.2949126-1-serghox@gmail.com>
References: <20231010101450.2949126-1-serghox@gmail.com>
Subject: Re: [PATCH v2 0/1] Add support DMAX_NUM_CHANNELS > 16
Message-Id: <169745478337.211836.16188943435637938366.b4-ty@kernel.org>
Date:   Mon, 16 Oct 2023 16:43:03 +0530
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


On Tue, 10 Oct 2023 13:14:49 +0300, Sergey Khimich wrote:
> This patch adds support for DW AXI DMA controller with
> 32 channels.
> 
> v2:
>  - Fix warning reported by kernel test robot:
>    | Reported-by: kernel test robot <lkp@intel.com>
>    | Closes: https://lore.kernel.org/oe-kbuild-all/202310060144.oLP6NoVL-lkp@intel.com/
> 
> [...]

Applied, thanks!

[1/1] dmaengine: dw-axi-dmac: Add support DMAX_NUM_CHANNELS > 16
      commit: 495e18b16e3dd8218eaec6a8a55334fb55245d59

Best regards,
-- 
~Vinod


