Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6446C508785
	for <lists+dmaengine@lfdr.de>; Wed, 20 Apr 2022 13:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235652AbiDTL7C (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Apr 2022 07:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378384AbiDTL7A (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Apr 2022 07:59:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A3B1C90B
        for <dmaengine@vger.kernel.org>; Wed, 20 Apr 2022 04:55:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8D956195B
        for <dmaengine@vger.kernel.org>; Wed, 20 Apr 2022 11:55:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B287CC385A0;
        Wed, 20 Apr 2022 11:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650455753;
        bh=k7n/5Sb1CcLhdoAmZcILa2LNwTh5YXyRRLyrvckye1E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=len1Wj2lYjNktrInHexJAXGa/IxEAFoOOnHJ6E+yxqsAf0gR/hslLT/NvksriiGsc
         mCVt3Q7R6k4KJ09U60eqGI8Umro4mD7dJtTpifqk5T0gm7f+UkkvfGQlHnnlvCZlNC
         boaXNHqeb8LEMePt6/xG9YVxnOcbhOOQEzA9do6ZytF2GMG1I5FGw1oqbwQ8b/GUEd
         LH+U+Oj8vl9P1e35unC1iDk1DzXpPn/+oMpH26w2mnZ/cDqxBDZ4/8e6F7eS1vkBDk
         y5twUpNL1rJc5GNXDgSYL8JY+Iq2c7y96x4S1GK4Tx8edSxR82nloss6qeb+39mLHe
         wVkzG6PuDmC2Q==
Date:   Wed, 20 Apr 2022 17:25:49 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: move wq irq enabling to after device
 enable
Message-ID: <Yl/0xU9oGFGNbtld@matsya>
References: <164642777730.179702.1880317757087484299.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164642777730.179702.1880317757087484299.stgit@djiang5-desk3.ch.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 04-03-22, 14:02, Dave Jiang wrote:
> Move the calling of request_irq() and other related irq setup code until
> after the WQ is successfully enabled. This reduces the amount of
> setup/teardown if the wq is not configured correctly and cannot be enabled.

Applied, thanks

-- 
~Vinod
