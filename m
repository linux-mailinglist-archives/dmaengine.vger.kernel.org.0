Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549705085FB
	for <lists+dmaengine@lfdr.de>; Wed, 20 Apr 2022 12:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238517AbiDTKhR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Apr 2022 06:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236192AbiDTKhQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Apr 2022 06:37:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B4E3FBD5
        for <dmaengine@vger.kernel.org>; Wed, 20 Apr 2022 03:34:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 179D4B81E89
        for <dmaengine@vger.kernel.org>; Wed, 20 Apr 2022 10:34:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31572C385A1;
        Wed, 20 Apr 2022 10:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650450868;
        bh=pquKFaaTgugTuTmGmgO7f1Ux+Cfe9WSpCStmCv7xcWg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JelM5WPOklYPu9g/TRqJj9QuI6voxnzW64dDITxtJYACdwBAU1wvUfhNnFwkhwjM1
         BgUuykvfrNC/gO06A80be6oxw5Lc2V1yDiHPMwZrEZSfPsgVyGjhUQpB05Zz6Xzjkt
         Bm6WvUxQ548T/acIV9ItuTY8BSVryFnZFhZJnLTZVtJ294+jKEa6JJM7tIDuAcwpbw
         Bds6hN0DoIBL708KB/mtH8VQjzlYn1DoUCrgZq+nD89wz0mG864bBn6swKYRCwWFUN
         RxgqxVH8yN+pKFpC3qYEXCjK1I15mftwX7XH5qRPsViDi08w2iQABst74tpivyhFNk
         ftvV8d0Z6DiFg==
Date:   Wed, 20 Apr 2022 16:04:24 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: fix retry value to be constant for
 duration of function call
Message-ID: <Yl/hsHJWYguaAx/L@matsya>
References: <165031760154.3658664.1983547716619266558.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165031760154.3658664.1983547716619266558.stgit@djiang5-desk3.ch.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18-04-22, 14:33, Dave Jiang wrote:
> When retries is compared to wq->enqcmds_retries each loop of idxd_enqcmds(),
> wq->enqcmds_retries can potentially changed by user. Assign the value
> of retries to wq->enqcmds_retries during initialization so it is the
> original value set when entering the function.

Applied, thanks

-- 
~Vinod
