Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1785E581337
	for <lists+dmaengine@lfdr.de>; Tue, 26 Jul 2022 14:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbiGZMji (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 Jul 2022 08:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbiGZMjh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 26 Jul 2022 08:39:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852202CDEB;
        Tue, 26 Jul 2022 05:39:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20BA261521;
        Tue, 26 Jul 2022 12:39:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E5AC341C0;
        Tue, 26 Jul 2022 12:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658839175;
        bh=v0tGAr/InIblqhn9psBtjGEpeZa61eZxTNk0ZPTmYxQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cd843CWbBKxjNSR8l+GsXYw6coHA1AUqESqQOfh4BZO+UkMD2zd3O8UwU6uCFUl1b
         7kpcNIEmVeuQFIRpxaqLaycB0I+ClVY7IPAUmAve3dgy0oqZhdC0xt9E2+WOhWYHwS
         pESGEgzx5Qpnk4FjTZSqs4HQg/NHJZDbki78tTEDAPfxfPe78W/g0ZqPcJyOBG0T1M
         ZY2wmGdjSoBkaagTIy2psCSPmEgakd6mWtMKtFG4P0gVy8N40e/QZkhVIXPFojSQvq
         Kwh7VtCalYGqBTst/58vXsKjp0rw+b9DwlBcd/Faz2g4z6qw4C3OrciZ9TAoRuq82J
         uWn9DyejpkDrA==
Date:   Tue, 26 Jul 2022 18:09:31 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jie Hai <haijie1@huawei.com>
Cc:     wangzhou1@hisilicon.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/7] dmaengine: hisilicon: Add dfx feature for hisi
 dma driver
Message-ID: <Yt/gg+MpHQD+k5qY@matsya>
References: <20220625074422.3479591-1-haijie1@huawei.com>
 <20220629035549.44181-1-haijie1@huawei.com>
 <20220629035549.44181-7-haijie1@huawei.com>
 <YtlTuAHTcZnTFo6B@matsya>
 <2a2a9624-d8ce-4bae-e666-3035ebb1b9e6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a2a9624-d8ce-4bae-e666-3035ebb1b9e6@huawei.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 26-07-22, 09:43, Jie Hai wrote:
> On 2022/7/21 21:25, Vinod Koul wrote:
> > On 29-06-22, 11:55, Jie Hai wrote:
> > 
> > What does dfx mean in title?
> > 
> Thanks for the question.
> 
> DFX＝"Design for X", I quote its definition as follows:
> The product definition puts forward a list of specific aspects about a
> design that designers need to optimize, for example, product usage,
> functions and features, cost range, and aesthetics. Modern designers even
> need to consider more design objectives because the new design
> characteristics may finally determine the success or failure of a product.
> Design methodologies that consider these new characteristics are called
> design for X (DFX). Specific design methodologies include design for
> reliability (DFR), design for serviceability (DFS), design for supply chain
> (DFSC), design for scalability (DFSc), design for energy efficiency and
> environment (DFEE), design for testability (DFT),and so on.

This would be better to explain in changelog, not many people would be
familiar with these terms...

> 
> For clarity, I've replaced it in v3 with something easier to understand.
> > > This patch adds dump of registers with debugfs for HIP08
> > > and HIP09 DMA driver.
> > > 
> > > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > ?
> > 
> The kernel test robot raised an issue and asked me to modify it and add
> "Reported-by: kernel test robot <lkp@intel.com>" to the commit message, so I
> did, and it was removed in v3.

ok

-- 
~Vinod
