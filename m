Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C8E5FACDB
	for <lists+dmaengine@lfdr.de>; Tue, 11 Oct 2022 08:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiJKGdo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Oct 2022 02:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiJKGdn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 11 Oct 2022 02:33:43 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08E489828
        for <dmaengine@vger.kernel.org>; Mon, 10 Oct 2022 23:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665470023; x=1697006023;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZxpifM4bYYb/GgivSvyzVmpUsR2oybWXqawpEJ+YldM=;
  b=FK9kb11pREnfUr427mIq45C6aOoeXbe+4r1g50qhBCohiD78+wSBiFui
   RHMkNtHupkKGaiWRGJT2TvUZ6IE3QTa5/kU/BtgcaaKT0rQN7tGn9Ggh9
   f/UIzS7uhn1FRP/Ia6V/eekCULGmLrFq7R0AnEjS9Sf6EUAG5DTELoAtn
   3Q3jiYLG+SE6H/lWrmnNfdbXe6dOr/gasXKX2iOH197jPh/o5lz+fyWBT
   5vpDWT5yHmp0UkGVt/wrkvy9NKFZ0H8bSLYGsgwbPNdU4TqLvS4HnCnxZ
   GoZO4oImA4vzvbhGH1R70sdWxw9Rg1daTB7Oxi2xytfTMlwKhZw+2qdbU
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="390729470"
X-IronPort-AV: E=Sophos;i="5.95,175,1661842800"; 
   d="scan'208";a="390729470"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 23:33:42 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="628572537"
X-IronPort-AV: E=Sophos;i="5.95,175,1661842800"; 
   d="scan'208";a="628572537"
Received: from xshen14-mobl.ccr.corp.intel.com (HELO [10.254.212.155]) ([10.254.212.155])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 23:33:32 -0700
Message-ID: <457ddb4d-acfe-f4e1-a917-8dd64dbad8c2@intel.com>
Date:   Tue, 11 Oct 2022 14:33:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.3.2
Subject: Re: [PATCH v2 0/2] dmaengine: idxd: Fix max batch size issues for
 Intel IAA
To:     vkoul@kernel.org, fenghua.yu@intel.com, dave.jiang@intel.com,
        dmaengine@vger.kernel.org
Cc:     ramesh.thomas@intel.com, tony.luck@intel.com, tony.zhu@intel.com,
        pei.p.jia@intel.com, Xiaochen Shen <xiaochen.shen@intel.com>
References: <20220930201528.18621-1-xiaochen.shen@intel.com>
Content-Language: en-US
From:   Xiaochen Shen <xiaochen.shen@intel.com>
In-Reply-To: <20220930201528.18621-1-xiaochen.shen@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

On 10/1/2022 4:15, Xiaochen Shen wrote:
> Fix max batch size related issues for Intel IAA:
> 1. Fix max batch size default values.
> 2. Make max batch size attributes in sysfs invisible.
> 
> Changelog:
> v2:
> - Rebase on -next branch (Vinod).
> - Use wrapper function idxd_{device|wq}_attr_max_batch_size_invisible()
>    to make the code more readable.
> 
> Xiaochen Shen (2):
>    dmaengine: idxd: Fix max batch size for Intel IAA
>    dmaengine: idxd: Make max batch size attributes in sysfs invisible for
>      Intel IAA


Do you have any comment on this rebased patch set?

After rebase, this patch set could be applied against both dmaengine -next
branch and mainline -master branch now.

Thank you very much for code review!


Best regards,
Xiaochen
