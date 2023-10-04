Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA47B7B8253
	for <lists+dmaengine@lfdr.de>; Wed,  4 Oct 2023 16:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242793AbjJDO3X (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Oct 2023 10:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242825AbjJDO3W (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 Oct 2023 10:29:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0CBE8
        for <dmaengine@vger.kernel.org>; Wed,  4 Oct 2023 07:29:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6662BC433C7;
        Wed,  4 Oct 2023 14:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696429758;
        bh=45qqQNUXmVH1cezGZyq/yCoMg6exi773ylSyZ3lV01Q=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UomuURuz3LbG8OoFfHRgPaXKw/rDswE1ceKc6Z25bNFveMbhpVlgBNwbB1GoZXlm1
         uEZVJMdBJt3392fWp5AA0tv0BVB/hHHp5MeScZWPV5hxbxWJ/cA5011vFQQVVFWbZM
         cJFaBuRsFuGSfuBHwDR2kjbREKnl2mcyfff5paU3TSp8hz7Hzo1MMbTF1K4awYwxZb
         Gw1w6redOeZxv04loGj+WF9/cOGd2swy7K25imGEDp4FhhvdL2Th8zmLnki5IZE8Qh
         Pjp20b+r3j0YZP2//AlUO7oVsssGN4TbGeWh4lkVCHJQ1Cj8dD7ZwRZLS5jqO/OHDE
         TqM7lP4oF8ONw==
From:   Vinod Koul <vkoul@kernel.org>
To:     laurentiu.tudor@nxp.com, leoyang.li@nxp.com,
        Li Zetao <lizetao1@huawei.com>
Cc:     ioana.ciornei@nxp.com, uwe@kleine-koenig.org,
        dmaengine@vger.kernel.org
In-Reply-To: <20230804100245.100068-1-lizetao1@huawei.com>
References: <20230804100245.100068-1-lizetao1@huawei.com>
Subject: Re: [PATCH -next] dmaengine: fsl-dpaa2-qdma: Remove redundant
 initialization owner in dpaa2_qdma_driver
Message-Id: <169642975601.440009.5684667869219911706.b4-ty@kernel.org>
Date:   Wed, 04 Oct 2023 19:59:16 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Fri, 04 Aug 2023 18:02:45 +0800, Li Zetao wrote:
> The fsl_mc_driver_register() will set "THIS_MODULE" to driver.owner when
> register a fsl_mc_driver driver, so it is redundant initialization to set
> driver.owner in dpaa2_qdma_driver statement. Remove it for clean code.
> 
> 

Applied, thanks!

[1/1] dmaengine: fsl-dpaa2-qdma: Remove redundant initialization owner in dpaa2_qdma_driver
      commit: a1cb2ffe5fe59b0f5612e5e9148c5311c32f311c

Best regards,
-- 
~Vinod


