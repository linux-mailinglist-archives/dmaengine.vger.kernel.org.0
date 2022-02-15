Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61BC14B62E1
	for <lists+dmaengine@lfdr.de>; Tue, 15 Feb 2022 06:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbiBOFen (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Feb 2022 00:34:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbiBOFem (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 15 Feb 2022 00:34:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8C0EB3;
        Mon, 14 Feb 2022 21:34:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E16F06149D;
        Tue, 15 Feb 2022 05:34:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67AD8C340EC;
        Tue, 15 Feb 2022 05:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644903272;
        bh=e+VHZ+GfdRIHc2Igx3HcOskdf1INRdCeNoAWWaSkADs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RcX/8IS0fZrQTbUpmqTM8PlWmvGR1WZz62ctueQ98RF0kAblrxwzSILI+fvd4wpjy
         vYJ4Iq88Ow8zAEFMATOrz9PurFgzbXhp5CeV0uOl7hlSpFVRQTPidRLVaPiG7ENiQ9
         QEBY+qNb3Q7cgbE/tVoeqNBbd3MfdYZh8VW+Cpiw8gUqsGGtShh+PnEPOl0RAXNmQh
         Erd8XZq/h4sFuJXimaLIddTBcVZ6pd1w6+Eo/HHeD4moQ3+AYUfirfQQRCMTZk8Hll
         2N4lLZzPpWdY1es1wju4cgxA18yU8pQeATFRPR1fvnTq3b/j9NavgnKmDITbuMmdxO
         6wKB1+vmhj/0Q==
Date:   Tue, 15 Feb 2022 11:04:28 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: iot: Remove useless DMA-32 fallback
 configuration
Message-ID: <Ygs7ZEFzU8y/2NEu@matsya>
References: <1d0de79852a3551545fe896789a75b36e35db8e6.1642231987.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d0de79852a3551545fe896789a75b36e35db8e6.1642231987.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15-01-22, 08:33, Christophe JAILLET wrote:
> As stated in [1], dma_set_mask() with a 64-bit mask never fails if
> dev->dma_mask is non-NULL.
> So, if it fails, the 32 bits case will also fail for the same reason.
> 
> Simplify code and remove some dead code accordingly.

Applied, thanks

-- 
~Vinod
