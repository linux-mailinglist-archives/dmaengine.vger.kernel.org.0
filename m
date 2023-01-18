Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8196719B4
	for <lists+dmaengine@lfdr.de>; Wed, 18 Jan 2023 11:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjARKza (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 18 Jan 2023 05:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjARKxH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 18 Jan 2023 05:53:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9675888751
        for <dmaengine@vger.kernel.org>; Wed, 18 Jan 2023 02:02:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25AB661749
        for <dmaengine@vger.kernel.org>; Wed, 18 Jan 2023 10:02:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09ED1C433EF;
        Wed, 18 Jan 2023 10:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674036135;
        bh=/w+U1Nv7bIlZ/5ir9pk8sqhEBP5KoG+McaWLxjkXqeI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CkgHy0TySuURVxJptyZ0yzcC5dsB7A7q3cQZ7p86JyoXxPMHHLW7AFgU+9hq6CA7P
         RZahjMLS/tew2lg9JAFJz4P2VHdKMQNKqDO//qmJDDIWiKbtAfx4zWJmAD+XkNs70w
         PBQ2Od33E3c3G0w9+xOFTmLRh0us5uPZnU8mQu6/ooYFMnIwEdK01qoTGCQA97BmbS
         164i+a4EPSDcpUYxz3sbW+HkBvITDnUBpiARLsbU3fasEIBUUIJollbYZO5oPsMDoK
         Z5hA6xvxu+fb5x2P38kVUDxbgfyso+UkcZ3+owAb277a+MewZLdA2aBSUzQgoAmD0k
         wJd5H1M3kR0Ww==
Date:   Wed, 18 Jan 2023 15:32:11 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Harliman Liem <pliem@maxlinear.com>
Cc:     mallikarjunax.reddy@linux.intel.com, dmaengine@vger.kernel.org,
        linux-lgm-soc@maxlinear.com
Subject: Re: [PATCH] dmaengine: lgm: Move DT parsing after initialization
Message-ID: <Y8fDo3CTz+DSag1i@matsya>
References: <afef6fc1ed20098b684e0d53737d69faf63c125f.1672887183.git.pliem@maxlinear.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afef6fc1ed20098b684e0d53737d69faf63c125f.1672887183.git.pliem@maxlinear.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 05-01-23, 11:05, Peter Harliman Liem wrote:
> ldma_cfg_init() will parse DT to retrieve certain configs.
> However, that is called before ldma_dma_init_vXX(), which
> will make some initialization to channel configs. It will
> thus incorrectly overwrite certain configs that are declared
> in DT.
> 
> To fix that, we move DT parsing after initialization.
> Function name is renamed to better represent what it does.

Applied, thanks

-- 
~Vinod
