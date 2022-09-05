Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353EF5ACB00
	for <lists+dmaengine@lfdr.de>; Mon,  5 Sep 2022 08:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236694AbiIEGdG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 5 Sep 2022 02:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236867AbiIEGcs (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 5 Sep 2022 02:32:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1639F3AB30;
        Sun,  4 Sep 2022 23:32:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87AC360FCA;
        Mon,  5 Sep 2022 06:32:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A5A0C433D6;
        Mon,  5 Sep 2022 06:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662359525;
        bh=PwLE9P3gco9X2NnkcHcGB6gMy5KpIvw9RWiLMdttoSE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KPfhS55vGp+lLE0QrpqjVcMdoknzxyChYrZhAb2hhASGmTBeDWxlVK3OufJ39mJDI
         0O9aqnWY4zCnJTxcSCM6UanBjpXUd3Uw45PAUgJzKfHKb8+ATFvFleESm7BpRIv+RV
         yxJE2tInLfCvgUal+IUverFl4piWYEVlaAZjx3qS/1/P1/nxPiZaGM2xXGRNB2IfbN
         DMpqsjtdThIScejXacWRrkC+58qh0vrdPlhJzRspNB0bIQ7os9K4Atcq+kdLGG+iHs
         uat6zCvmMPGm1JKybTlBQ15q1PtvZwr2vXhWrKdkoT57VBzsLpukzhpcDv5y+j9iZN
         kxoUDPB9XTIVA==
Date:   Mon, 5 Sep 2022 12:02:00 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Harini Katakam <harini.katakam@amd.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        harinikatakamlinux@gmail.com, michal.simek@amd.com,
        radhey.shyam.pandey@amd.com
Subject: Re: [PATCH] dmaengine: pl330: Remove unused flags
Message-ID: <YxWX4G1+io6khVmj@matsya>
References: <20220802102232.17653-1-harini.katakam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802102232.17653-1-harini.katakam@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 02-08-22, 15:52, Harini Katakam wrote:
> txd.flags is unused and need not be updated.

Applied, thanks

-- 
~Vinod
