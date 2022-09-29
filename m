Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3895EEF75
	for <lists+dmaengine@lfdr.de>; Thu, 29 Sep 2022 09:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235477AbiI2HnT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Sep 2022 03:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235357AbiI2Hmo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 29 Sep 2022 03:42:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7379AFAA
        for <dmaengine@vger.kernel.org>; Thu, 29 Sep 2022 00:42:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14642B8220A
        for <dmaengine@vger.kernel.org>; Thu, 29 Sep 2022 07:42:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24BEFC433C1;
        Thu, 29 Sep 2022 07:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664437349;
        bh=co081rKhMPRCaSwto1picKA39re+uKqhG6F+V4UNp84=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WTuGXmljYuykaakudwp4UCx1gBckDK/WsEmE5tamRsMAGj0UMKlqYfOZgl5TyWs0M
         G/2Ef/Pf2gVyR3NlXwj52oXYUg0w/ip6jCle7H1YYRZpUIA/Lh8GLqXivRxTwSFHha
         7tURLizpZ5onn7M4HuG5Cy6DXLN1i9waACfFBzGHNt/mHhaTwVIB3vDRQlH7z6NG8U
         1KAtCOOcUi6Ah/SiwteNuzG18SeKLZkRgtGLjWGKxL7XGfswpiE2seFVZcgD+ygYLz
         wR2n3fQ4URkxsezgv9xJv2Mck35t1YfUQV91N9vQ8OTHCw8IIMqCC3q94BGiBHZaHk
         FOGyrRa2ev9pg==
Date:   Thu, 29 Sep 2022 13:12:26 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Yuan Can <yuancan@huawei.com>
Cc:     fenghua.yu@intel.com, dave.jiang@intel.com,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH RESEND] dmaengine: idxd: Remove unused struct idxd_fault
Message-ID: <YzVMYrXuFXwIJwEv@matsya>
References: <20220928014747.106808-1-yuancan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928014747.106808-1-yuancan@huawei.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 28-09-22, 01:47, Yuan Can wrote:
> Since fault processing code has been removed, struct idxd_fault is not used any
> more and can be removed as well.

This should have been tagged v2... this is update over v1

> Fixes: commit 0e96454ca26c ("dmaengine: idxd: remove fault processing code")

This is not a valid fix, it is an improvement so dropped

I have applied this
-- 
~Vinod
