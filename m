Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30345284D8
	for <lists+dmaengine@lfdr.de>; Mon, 16 May 2022 14:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242718AbiEPM7p (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 May 2022 08:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242555AbiEPM7n (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 16 May 2022 08:59:43 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4E4396B5
        for <dmaengine@vger.kernel.org>; Mon, 16 May 2022 05:59:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 86046CE1621
        for <dmaengine@vger.kernel.org>; Mon, 16 May 2022 12:59:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65002C385B8;
        Mon, 16 May 2022 12:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652705979;
        bh=vMeibyjyKqCVFJKyAeJMJmlAFDCgxSpfoPBJK21rRrU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E2oiHRmOp3m2GUcUQSOSaKVBV93gTzXbU/6l5PI83oLGR43mWKoJ/mczr3yLzU622
         +7WYaCWGUgudSPkSdCzIOYAKmADGFMdsHOOCLlf/ldzcd1bAvazKQAzSCCiiMp+BkM
         J2R257xo5grxEj2mSO4WxYiPGSINYKsScjPsOZhlN/oMQ/gCkaP8gaRVOuuWQsmxu6
         xAzdNr4DbBRl3BZ33P9+p1eBWq5sp4yNOoE6lZRZrg3xudLQQRdUoGmY8UOvhS5oMb
         DapPOP80+v33Ex3keqCqyEL348+b8ougx5QhmU15V3L1c9TFLrS8KXvLKA0DU2DWfW
         O3SLKO0JAeKBA==
Date:   Mon, 16 May 2022 18:29:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: make
 idxd_register/unregister_dma_channel() static
Message-ID: <YoJKtxFsES4ilOdr@matsya>
References: <165187583222.3287435.12882651040433040246.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165187583222.3287435.12882651040433040246.stgit@djiang5-desk3.ch.intel.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06-05-22, 15:23, Dave Jiang wrote:
> Since idxd_register/unregister_dma_channel() are only called locally, make
> them static.

Applied, thanks

-- 
~Vinod
