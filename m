Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3508A5EFB3A
	for <lists+dmaengine@lfdr.de>; Thu, 29 Sep 2022 18:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbiI2Qq6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Sep 2022 12:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235386AbiI2Qq5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 29 Sep 2022 12:46:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBEE1176D8
        for <dmaengine@vger.kernel.org>; Thu, 29 Sep 2022 09:46:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD44E61E94
        for <dmaengine@vger.kernel.org>; Thu, 29 Sep 2022 16:46:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C0BC433D6;
        Thu, 29 Sep 2022 16:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664470016;
        bh=2TGM4QiO91HIgiok5w6xD41afWkMkzHJeTF9h7pc0F8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lLB0rE157RXgLUqGX0yxBL4IpsMVAfvfjvkEqaWUaiq5kzN1iCD9bbDhL8SHEkTaN
         oQUpBEprq6UpALbOa5yipn75UvLEcZHJ8oNiiJlEsxLEOQiI17NnseaAXe8TK0MIWB
         A8lpaYd45xJws8kfaeTRHZiEebVbNqbHfLbC6ztkD8J/nN3QaeDQKr6QLFHA51zpEM
         A3y30mOR0FKRz89HiFoX2c9hi5EOng3sIPWbt+Sr+o7Svjhcs6JvFke9tsUpsP+xFh
         Bnc1DRnYfsT1MFWQmYKysdVncfJBEXC2TMNZGgL2WRo4L6k+sAKFqnFI55oAwVZfLB
         RMqDmeOYpcixQ==
Date:   Thu, 29 Sep 2022 22:16:52 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Yu, Fenghua" <fenghua.yu@intel.com>
Cc:     "Shen, Xiaochen" <xiaochen.shen@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "Thomas, Ramesh" <ramesh.thomas@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Zhu, Tony" <tony.zhu@intel.com>,
        "Jia, Pei P" <pei.p.jia@intel.com>
Subject: Re: [PATCH 0/2] dmaengine: idxd: Fix max batch size issues for Intel
 IAA
Message-ID: <YzXL/HkYS2Q8QEbK@matsya>
References: <20220808031922.29751-1-xiaochen.shen@intel.com>
 <IA1PR11MB6097EC13718EEEED2A15A0F09B499@IA1PR11MB6097.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR11MB6097EC13718EEEED2A15A0F09B499@IA1PR11MB6097.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15-09-22, 16:21, Yu, Fenghua wrote:
> Hi, Vinod,
> 
> > Fix max batch size related issues for Intel IAA:
> > 1. Fix max batch size default values.
> > 2. Make max batch size attributes in sysfs invisible.
> 
> Any comment on this patch set? Would you apply it?

This does not apply for me (i guess due to other idxd patches I have
applied today), pls rebase on next and resend

-- 
~Vinod
