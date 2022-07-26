Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A17581780
	for <lists+dmaengine@lfdr.de>; Tue, 26 Jul 2022 18:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239010AbiGZQgT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 Jul 2022 12:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiGZQgS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 26 Jul 2022 12:36:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4938312D28;
        Tue, 26 Jul 2022 09:36:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8FB460D42;
        Tue, 26 Jul 2022 16:36:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C281AC433C1;
        Tue, 26 Jul 2022 16:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658853377;
        bh=ble3zRDYs/yITk8HA/1pQokt6KnZTLpU07UlEohD6WI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=agTB7w/4rgu9pBobWKtUapMo9JBItfgWY/4f0gZVgL4KUFH7SQ/8mDIWSGd+qojE6
         EejuKRagYWctkrt0cddg9nPrE+QPp+YWPGMQXwtF2ZIva4jCjgErOLBPmRnJJNtoEA
         gmxDDuq1a2JWWHeuPxXrD35Jsclog4rG7q5bAK5/x9ww6eWbK0BwJPNUVciznbwZS1
         l6JI250Vb+ZqMU9Uct6FeRmGiHwWCslvvIwdGIYMYeYC8lPHESeS2jwDvnaH+dJRuN
         IZZiyDLQyrpy1sMGUiltK9Zv8nmqPbvWjlu6wcGzf/ySiBFktjJutwusNV8GOZLUbf
         rVmjIBUUM+Lnw==
Date:   Tue, 26 Jul 2022 22:06:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     sean.wang@mediatek.com, matthias.bgg@gmail.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: mediatek: mtk-hsdma: Fix typo 'the the' in
 comment
Message-ID: <YuAX/eR78JdSRCzS@matsya>
References: <20220721055647.46085-1-slark_xiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721055647.46085-1-slark_xiao@163.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 21-07-22, 13:56, Slark Xiao wrote:
> Replace 'the the' with 'the' in the comment.

Applied, thanks

-- 
~Vinod
