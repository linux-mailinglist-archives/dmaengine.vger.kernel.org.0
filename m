Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7266508763
	for <lists+dmaengine@lfdr.de>; Wed, 20 Apr 2022 13:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352702AbiDTLzk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Apr 2022 07:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347396AbiDTLzj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Apr 2022 07:55:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2881208A;
        Wed, 20 Apr 2022 04:52:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 277476195B;
        Wed, 20 Apr 2022 11:52:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2504C385A0;
        Wed, 20 Apr 2022 11:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650455572;
        bh=Y9tpE6eXII7HUGJZvCy6bLohqRKwZvWsLqA0XWyHEfg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p5ILxmJrmD9W2Vt6HqO9NFmOnhnlkU+Ipwss8w0n5PAHehAWv+T4UAjvKz+8ozSiC
         dMKECFCJR4yS47w5v5uk7Ce120HA8LiYf/ZBpeAxHQB48nCP9Xwe3UGOHcNu7RuhLr
         y7aQz9+ZkN7KBcdLgupzYGhZLJrRIrGnFw09qLrb8vbOj5MEfre5Yu1ntIbZQOxboV
         W/FwzANrWlL4c+ox1NDZ5DugxjKqo2vVi/AtoZUDOCcz6Rdmi+pR68Hyjo28gcyBI8
         xbHg1D/GPeOulWwYHTDOFuAWcZA+5sWVCKBFcvFMvQBtckld1zkUDpIG3sJE3os84n
         MBwebGD4dxzfw==
Date:   Wed, 20 Apr 2022 17:22:48 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     gustavo.pimentel@synopsys.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] dmaengine: dw-edma: Fix inconsistent indenting
Message-ID: <Yl/0EMsnFnAXVzy6@matsya>
References: <20220413023442.18856-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413023442.18856-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 13-04-22, 10:34, Jiapeng Chong wrote:
> Eliminate the follow smatch warning:
> 
> drivers/dma/dw-edma/dw-edma-v0-core.c:419 dw_edma_v0_core_start() warn:
> inconsistent indenting.

Applied, thanks

-- 
~Vinod
