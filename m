Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3CEF6BEFA1
	for <lists+dmaengine@lfdr.de>; Fri, 17 Mar 2023 18:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjCQR04 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Mar 2023 13:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjCQR04 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Mar 2023 13:26:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB3C1A4B4;
        Fri, 17 Mar 2023 10:26:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2C64B82641;
        Fri, 17 Mar 2023 17:26:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14966C433D2;
        Fri, 17 Mar 2023 17:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679074012;
        bh=+nvNxMzFMvS8V7tYMsKVsfHsBxJtFJ5AXs5g5mvcxtk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lf7PcvLGLvz2di5OVjJZ7itAqmLQAOcB9dys9b5s8hY5ZW1om/SccOnBukiTr1srk
         ThtuBvjArTvOY/+oue0QNJGkrbsigczQEEIGCyQ5+EIOSwSNa3u+fB5Fl9vh7aqaSU
         u7fplynUS1eG4O8LNedChmKnGEeHm4Ticzb9SJ8kB4tnepZoMnX5Ie9DflDQ116/yO
         RKZq/vDnGbIXmqTjZlaGRqBpGHnZLTxrH1TTOhrLCiJOrfYR1og18kbfgOi1qYf+0p
         2U9IPOuAUgrSHdeQBlDBheRoZLxc0MrZZy/ML+QJJBv0690V5fjCE0EpMdc/WZQUZe
         eKXnSh+CWtVlQ==
Date:   Fri, 17 Mar 2023 22:56:49 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        dmaengine@vger.kernel.org,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dmaengine: sh: rz-dmac: Add reset support
Message-ID: <ZBSi2YecQDFK6OZD@matsya>
References: <20230315064501.21491-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315064501.21491-1-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15-03-23, 06:45, Biju Das wrote:
> Add reset support for DMAC module found on RZ/G2L alike SoCs.
> 
> For booting the board, reset release of the DMAC module is required
> otherwise we don't get GIC interrupts. Currently the reset release
> was done by the bootloader now move this to the driver instead.

Applied, thanks

-- 
~Vinod
