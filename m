Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21DD65F0FBC
	for <lists+dmaengine@lfdr.de>; Fri, 30 Sep 2022 18:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbiI3QSn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 30 Sep 2022 12:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbiI3QSl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 30 Sep 2022 12:18:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F63115A6B
        for <dmaengine@vger.kernel.org>; Fri, 30 Sep 2022 09:18:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BE24622AA
        for <dmaengine@vger.kernel.org>; Fri, 30 Sep 2022 16:18:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C30C433C1;
        Fri, 30 Sep 2022 16:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664554719;
        bh=a8Vi4bACXOV9IrI3oMzcwrV2LD6ulm7T+tOpgQKlrGk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CHqbeAhrKSYjeMtRbMD5bNLrvP7WYnJRWcaqJSgJS4F9XcaKDywA0uezeOwLT9OO5
         nwQo08SA61V1StSD95YhiDCAy5Khr3pZ8qVwk/vmPe5rlp2lyP0LRsn3nDuAvpvJze
         x6ovMPhP/u3x1mqCVGyYGjdstKpcvP6ota1fbb//mnm6+uui1XLYxXp6wz5dN/4D50
         6zR9rHyusNhbTm9hUcIlppyxqdWrviGC0a5UveJ6GBMZk9eyrzsVV1lyWVvYR3H+jj
         jKJ7YBVS4J48u6eoWbKHKEe2/7cjlXF6VTtF3ckPAxTZ2MxqlWCzpXCg2ehsi+VqE1
         8zHkXYR0w2S1g==
Date:   Fri, 30 Sep 2022 21:48:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Xiaochen Shen <xiaochen.shen@intel.com>
Cc:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "Thomas, Ramesh" <ramesh.thomas@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Zhu, Tony" <tony.zhu@intel.com>,
        "Jia, Pei P" <pei.p.jia@intel.com>
Subject: Re: [PATCH 0/2] dmaengine: idxd: Fix max batch size issues for Intel
 IAA
Message-ID: <YzcW27iY+fcDCxtw@matsya>
References: <20220808031922.29751-1-xiaochen.shen@intel.com>
 <IA1PR11MB6097EC13718EEEED2A15A0F09B499@IA1PR11MB6097.namprd11.prod.outlook.com>
 <YzXL/HkYS2Q8QEbK@matsya>
 <c898dd4c-1f1d-789e-e485-afd33c6dce87@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c898dd4c-1f1d-789e-e485-afd33c6dce87@intel.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 30-09-22, 11:18, Xiaochen Shen wrote:
> Hi Vinod,
> 
> Thank you very much for code review!
> 
> On 9/30/2022 0:46, Vinod Koul wrote:
> > On 15-09-22, 16:21, Yu, Fenghua wrote:
> > > Hi, Vinod,
> > > 
> > > > Fix max batch size related issues for Intel IAA:
> > > > 1. Fix max batch size default values.
> > > > 2. Make max batch size attributes in sysfs invisible.
> > > 
> > > Any comment on this patch set? Would you apply it?
> > 
> > This does not apply for me (i guess due to other idxd patches I have
> > applied today), pls rebase on next and resend
> > 
> 
> Could you help check if these idxd patches are merged into 'next' branch of
> https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git ?
> 
> I will rebase on top of 'next' branch and resend the patch soon.
> Thank you very much!

yes pls rebase on -next branch, thanks

-- 
~Vinod
