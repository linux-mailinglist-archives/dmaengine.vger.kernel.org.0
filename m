Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A875EFBAE
	for <lists+dmaengine@lfdr.de>; Thu, 29 Sep 2022 19:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234737AbiI2RKM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Sep 2022 13:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234916AbiI2RKL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 29 Sep 2022 13:10:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E8A51A03;
        Thu, 29 Sep 2022 10:10:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66908B8254D;
        Thu, 29 Sep 2022 17:10:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95272C433D7;
        Thu, 29 Sep 2022 17:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664471408;
        bh=du6mld2YyzlxmKHpR7XMOgLceDqdAM1lNtnQWdVwP0s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E4M4PoQMzltN33UdT/eI3ouq4DIaF9N/tgOCbE+ImZmviN+JcLGAtGfPyoo2Zjvpf
         T4KhpJHbPI1YSBzaKnSEk0Et45QU5ADU6nHlrCTD/RdH6haD9PuCnKrGhT4CIca7Tf
         w8KHhDUgo09ZcIqAnSTL7wSfH49DCkhBUB5Kx4hxGa6u7jxZxpnmVn6GI0eGbS9S1B
         YubsT/aVTqqAUP/MtPHcJ7BhTwOQYO+cTE3KSDZMxwGdUdqly4qbW8L26Oo6Ndp9+r
         Tgdr1g3RLue5eUE7iX7WxV/WHGriIkIkEdbNfAiZ+S5vsyoRvR+kHhJ3H4hyglPwj6
         K9EY/W+b2SWRQ==
Date:   Thu, 29 Sep 2022 22:40:04 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Koba Ko <koba.ko@canonical.com>
Subject: Re: [PATCH 3/3] dmaengine: Fix client_count is countered one more
 incorrectly.
Message-ID: <YzXRbBvv+2MGE6Eq@matsya>
References: <20220830093207.951704-1-koba.ko@canonical.com>
 <20220929165710.biw4yry4xuxv7jbh@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929165710.biw4yry4xuxv7jbh@cantor>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 29-09-22, 09:57, Jerry Snitselaar wrote:
> On Tue, Aug 30, 2022 at 05:32:07PM +0800, Koba Ko wrote:

> 
> Hi Vinod,
> 
> Any thoughts on this patch? We recently came across this issue as well.

I have only patch 3, where is the rest of the series... ?

-- 
~Vinod
