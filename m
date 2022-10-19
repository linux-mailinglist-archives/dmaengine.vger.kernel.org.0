Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0743A6048D7
	for <lists+dmaengine@lfdr.de>; Wed, 19 Oct 2022 16:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiJSOLh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Oct 2022 10:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232731AbiJSOLM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 19 Oct 2022 10:11:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289E59FDD
        for <dmaengine@vger.kernel.org>; Wed, 19 Oct 2022 06:53:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92F096174E
        for <dmaengine@vger.kernel.org>; Wed, 19 Oct 2022 13:51:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6181CC433D6;
        Wed, 19 Oct 2022 13:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666187463;
        bh=EKSYk5DbFePgg1Mf55LJyF4/0gOWAtL/1oX5olp40V0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TuEReP+cBvDRkheN9E1FilibJVPU/YQNDq2QYIdepW4q239I2yjO3F9D3NWDr74N5
         LMkjNsnDiAL4rmlaMHR6Je7+dIakBdPDu5QfaX7r+glxAX+nU/nqpfqUBRdK0yrp6e
         An1Ej9bk3vltao88hmWqrNP7YU1GutVsGnaJPg/pjNYcVqFPtUSbtyhBRhKE+QFPks
         KgmFGxzBG1a+s+ocKqru4PZs2fI0D8KASe1GgG3fB8PczY4ROp8d4gOHrI5hTXHQm8
         wSAJkF6DUpaxB2cIlardwQO8FTQshOzNgnNwtEI7RlDwpQj5VptIbuzOFps3ySvrZa
         d60dw8kITjFEA==
Date:   Wed, 19 Oct 2022 19:20:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Xiaochen Shen <xiaochen.shen@intel.com>
Cc:     fenghua.yu@intel.com, dave.jiang@intel.com,
        dmaengine@vger.kernel.org, ramesh.thomas@intel.com,
        tony.luck@intel.com, tony.zhu@intel.com, pei.p.jia@intel.com
Subject: Re: [PATCH v2 0/2] dmaengine: idxd: Fix max batch size issues for
 Intel IAA
Message-ID: <Y1AAw7ux+ECH4r00@matsya>
References: <20220930201528.18621-1-xiaochen.shen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220930201528.18621-1-xiaochen.shen@intel.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 01-10-22, 04:15, Xiaochen Shen wrote:
> Fix max batch size related issues for Intel IAA:
> 1. Fix max batch size default values.
> 2. Make max batch size attributes in sysfs invisible.

Applied, thanks

-- 
~Vinod
