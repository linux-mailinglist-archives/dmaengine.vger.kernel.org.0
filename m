Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B409F4B62E7
	for <lists+dmaengine@lfdr.de>; Tue, 15 Feb 2022 06:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbiBOFfm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Feb 2022 00:35:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbiBOFfm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 15 Feb 2022 00:35:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2C1B7D;
        Mon, 14 Feb 2022 21:35:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C55661338;
        Tue, 15 Feb 2022 05:35:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0BE0C340EC;
        Tue, 15 Feb 2022 05:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644903331;
        bh=R9thlo1WvN2/WhvdvZoFRszkO4H/txvCZdYcwEipM+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UhqnI0X5EVWRtkgsBUlFjAqF00M6mYTcZ4qn7QgLXc+qxAs6ViONZJ0iIfOyRuBgi
         moWmUxjZklkXG/LJNFHTxlJdmhHOE+3Pekj+LZGJ7mIMjXGOEldLddJfyP11esKT9D
         pOH20HYRIRmHXEPTt/APHULaSl6JW1IGnvTmxhFD71X1J8R5q3i0LU+XMsZjduR6I7
         bdM5nPCQqhD5+LXJN/bhZe6W9oRjDtgciAPOwBZCl/erHE09C4MWear3QcN1VMhnwx
         Pw7VZ9F/+5mB3+iu+f22OtpC3aGVUDXa+DGytpoldSijVszlT7DI3lZVzuG/YaepUq
         SaV2EhPRj15Uw==
Date:   Tue, 15 Feb 2022 11:05:27 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Yongzhi Liu <lyz_cs@pku.edu.cn>
Cc:     broonie@kernel.org, laurent.pinchart@ideasonboard.com,
        arnd@arndb.de, christophe.jaillet@wanadoo.fr,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: shdma: Fix runtime PM imbalance on error
Message-ID: <Ygs7nwawFmaApt9+@matsya>
References: <1642311296-87020-1-git-send-email-lyz_cs@pku.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1642311296-87020-1-git-send-email-lyz_cs@pku.edu.cn>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15-01-22, 21:34, Yongzhi Liu wrote:
> pm_runtime_get_() increments the runtime PM usage counter even
> when it returns an error code, thus a matching decrement is needed on
> the error handling path to keep the counter balanced.

Applied, thanks

-- 
~Vinod
