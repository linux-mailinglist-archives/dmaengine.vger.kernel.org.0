Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5954FBEE7
	for <lists+dmaengine@lfdr.de>; Mon, 11 Apr 2022 16:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343806AbiDKOWT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Apr 2022 10:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347104AbiDKOVs (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Apr 2022 10:21:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8FE334;
        Mon, 11 Apr 2022 07:19:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25C4AB815F3;
        Mon, 11 Apr 2022 14:19:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5088C385A4;
        Mon, 11 Apr 2022 14:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649686742;
        bh=DIEUzAXY+I9aKOrvlBKvP37tHJv4Sdt/lA6/L94VkpI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lGTJnI6QcbTokQx2IEE9EC6xloTYoE/e3kR+mi/HNKCYMdod8LNVDdeZUJ6uuTvRo
         JytKhaNKjcLpFh9BR4bMdOhMxodtx1vK/nW9t1FLB2HshmWt5K9w87VfRhTnTjqK+J
         4ohJleIxmq5QI8B4CaNgciCYqtevcIeLRW9pj/za1ly6B/WJJZRzQAK22v6Idwmw6h
         g7fTld63lfVwaJPb1unkn0YDD7ckPFE6gLcN2KCj/xF0EPQFMqIUTKG1W3lwKzSu9n
         qZha4FjZVaw25j51nug8MQfQCSaDH4PI8GAL+VF4+0Mlp5ia/PImxEh4GOawW8pfpt
         RPv0CLZUZLPmQ==
Date:   Mon, 11 Apr 2022 19:48:58 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Zidan Wang <zidan.wang@freescale.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: imx-sdma: Fix error checking in
 sdma_event_remap
Message-ID: <YlQ40pMGqSmmtF6q@matsya>
References: <20220308064952.15743-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308064952.15743-1-linmq006@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 08-03-22, 06:49, Miaoqian Lin wrote:
> of_parse_phandle() returns NULL on errors, rather than error
> pointers. Using NULL check on grp_np to fix this.

Applied, thanks

-- 
~Vinod
