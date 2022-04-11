Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB6B4FBEF4
	for <lists+dmaengine@lfdr.de>; Mon, 11 Apr 2022 16:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347220AbiDKOYF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Apr 2022 10:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbiDKOYC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Apr 2022 10:24:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C68369C2
        for <dmaengine@vger.kernel.org>; Mon, 11 Apr 2022 07:21:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 715C3612FB
        for <dmaengine@vger.kernel.org>; Mon, 11 Apr 2022 14:21:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44694C385A3;
        Mon, 11 Apr 2022 14:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649686907;
        bh=5esbzlQiSDQRKPncRRwaNhS8LMOot6WStrLKqQ9+byM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HBRquvBIOR3gmLU/y5WIc4CcbKG4ivIyMKal0leKy8AlRKCD49oYo3GPnBZxYsOKe
         YavDvK6UoPKRfinFReKI22vwfEvZb4xOL+6EQykB5c4Z/dn3vKkxflTFiW/0T7GsIC
         vr7pB3flmIDrnmbaxu9bMmRlFW2gXIDVordhRLZdSXyMWihHnhPMroI1CDzWTPAoEJ
         oEyNM++Bo0XSGlT9KQ79p2OgtLwIlu05WeC7A5r9n6vSD5FvwENaMyDc45h2r6U/kf
         qpi/6l0nsfbDlMynayqDJGrbTqg0WpWTVPNv9yfHL4hsmeWEkqflxDHGEPdJzr10RS
         vyeR4IgLo1XIA==
Date:   Mon, 11 Apr 2022 19:51:44 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Zhang Qilong <zhangqilong3@huawei.com>
Cc:     angelogioacchino.delregno@collabora.com, sean.wang@mediatek.com,
        matthias.bgg@gmail.com, dmaengine@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH -next v2] dmaengine: mediatek:Fix PM usage reference leak
 of mtk_uart_apdma_alloc_chan_resources
Message-ID: <YlQ5eNbPCV8KCaRz@matsya>
References: <20220319022142.142709-1-zhangqilong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220319022142.142709-1-zhangqilong3@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 19-03-22, 10:21, Zhang Qilong wrote:
> From: zhangqilong <zhangqilong3@huawei.com>
> 
> pm_runtime_get_sync will increment pm usage counter even it failed.
> Forgetting to putting operation will result in reference leak here.
> We fix it:
> 1) Replacing it with pm_runtime_resume_and_get to keep usage counter
>    balanced.
> 2) Add putting operation before returning error.

Applied, thanks

-- 
~Vinod
