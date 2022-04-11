Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F39C4FBEEE
	for <lists+dmaengine@lfdr.de>; Mon, 11 Apr 2022 16:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242440AbiDKOXV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Apr 2022 10:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244163AbiDKOWS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Apr 2022 10:22:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5C61D0E9;
        Mon, 11 Apr 2022 07:20:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BC13612F0;
        Mon, 11 Apr 2022 14:20:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EBA6C385A3;
        Mon, 11 Apr 2022 14:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649686803;
        bh=sgP3P4ipZLRGUcgtNG2mIb2KbvJgeAxsPApan/y5dvA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V0LfJ2D6qJyps1l+0l78tiKcfNsNt0/XvGvuuxHfRpOY7il1xjf2ol/6G2UIVs5Ta
         5gEh79thPddUIaABVbbCf/Fawk86avgMHl24CDysUDzmP9m4iIwD5wb2kXAA3fANwr
         p6WmuLmOBQQyPjPouVE2uvcIaOWqfOwz05kySuL0Gpyq9jLq9LtnQPDlNKAtEwA54Q
         k85lu0kDzFcrhOMafUKC8TGrPj1un1MvnS7o0PtZCgJpYbN9U2oLZfB5oReueOJZoI
         zYzRBUQh2f6241Irkt4Bdb5oT56a32y8y8R+tRrGkm5zcsnCJZYtNI0bWE+QlaCQE9
         HvcxczhkCo9Yg==
Date:   Mon, 11 Apr 2022 19:49:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     cgel.zte@gmail.com
Cc:     sean.wang@mediatek.com, matthias.bgg@gmail.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>
Subject: Re: [PATCH] dmaengine: mediatek: mtk-hsdma: Use platform_get_irq()
 to get the interrupt
Message-ID: <YlQ5D4XPksRHsXPB@matsya>
References: <20220309053436.2081066-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309053436.2081066-1-chi.minghao@zte.com.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 09-03-22, 05:34, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> It is not recommened to use platform_get_resource(pdev, IORESOURCE_IRQ)
> for requesting IRQ's resources any more, as they can be not ready yet in
> case of DT-booting.
> 
> platform_get_irq() instead is a recommended way for getting IRQ even if
> it was not retrieved earlier.
> 
> It also makes code simpler because we're getting "int" value right away
> and no conversion from resource to int is required.

Applied, thanks

-- 
~Vinod
