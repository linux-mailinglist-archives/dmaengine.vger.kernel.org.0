Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D07B546670
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jun 2022 14:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235619AbiFJMTo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Jun 2022 08:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239840AbiFJMTn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Jun 2022 08:19:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642EB2CFE8B
        for <dmaengine@vger.kernel.org>; Fri, 10 Jun 2022 05:19:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6BCE621A3
        for <dmaengine@vger.kernel.org>; Fri, 10 Jun 2022 12:19:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0DEDC3411E;
        Fri, 10 Jun 2022 12:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654863581;
        bh=YYkRqp8ldunjkkKi6ZDvraJv++/2kyZaowvrlGqRPDA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ohkw+XyeaaWP67wBzp561Bjv7RWGXSScVLMbd8MyjRmZrl6vbj0gBmW6rcqeNTYmG
         mfMu18/+ssn035SAPrEssHWJiU/C6flHdSaV6YXzLz35eajw44/YUoZQDEVDylFs/H
         58uLqKVFatCxYwgOH3CWSJ1PlMj4+TDedbJ7lnigi/EWHv5gwC2qjJlpm3w4wKDaA7
         npYh0vYUAMiCLFm7GUtg+aBd+KQQ9mcgeNn6MB3ihV1LUFZDz1Rm4Y/4GgNAfENgr/
         MDdwUwaJvf0vxBRIpBawC9t0MIWSPaTKfXYNCt21mWGLWkbFnmF2ZmOxSjKmNkgLK9
         ozUq3MaJEqsVQ==
Date:   Fri, 10 Jun 2022 17:49:36 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Herve Codina <herve.codina@bootlin.com>,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: dw-edma: remove a macro conditional with
 similar branches
Message-ID: <YqM22A+pzVOZxzn2@matsya>
References: <20220610100700.2295522-1-vladimir.zapolskiy@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610100700.2295522-1-vladimir.zapolskiy@linaro.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 10-06-22, 13:07, Vladimir Zapolskiy wrote:
> After adding commit 8fc5133d6d4d ("dmaengine: dw-edma: Fix unaligned
> 64bit access") two branches under macro conditional become identical,
> thus the code can be simplified without any functional change.

Applied, thanks

-- 
~Vinod
