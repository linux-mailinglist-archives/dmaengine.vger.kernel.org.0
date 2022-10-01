Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979765F1873
	for <lists+dmaengine@lfdr.de>; Sat,  1 Oct 2022 03:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbiJABb6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 30 Sep 2022 21:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiJABb5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 30 Sep 2022 21:31:57 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F15E1176F3
        for <dmaengine@vger.kernel.org>; Fri, 30 Sep 2022 18:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664587911; x=1696123911;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NUBmqwofEQhIsYj9X7axkscXZT6vudLnJZ0kcsjiL+g=;
  b=dtcB9vzasOunrs1VB3/O1m1LuW3CSOdaXugXSfXgcHb0MMcP7q4Pcg4J
   kAoe3nvCcoqbF5NNnIcFiwq77GsZ+lKFJ2xcv5T31E8Lgu6abFKBE60Mv
   WYR1CiUOlghYF8dPW5NGWU9OGbZnL/1aUKbPQrmCbaJe/IebOizSU+/XK
   TsF3TVoZuz5WStXODAqqy0hymF62C9Hk7RFInMN3+ROyt6L/mLuPK6ykf
   ElgWH1ebRU9JnWFw+zmZtxZlezJQgpV1iNAzQrA+UVU0H3z1iHU+hKhgV
   W6Su4ryxpaWzVIgkj07bzZ2xALplmcG1F/NEJJ5WYG5/0uIyF03gbeFYJ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="282036705"
X-IronPort-AV: E=Sophos;i="5.93,359,1654585200"; 
   d="scan'208";a="282036705"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 18:31:50 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="798151986"
X-IronPort-AV: E=Sophos;i="5.93,359,1654585200"; 
   d="scan'208";a="798151986"
Received: from xshen14-mobl.ccr.corp.intel.com (HELO [10.254.214.38]) ([10.254.214.38])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 18:31:47 -0700
Message-ID: <5a8b2a3d-2870-2cfb-03bd-a8a3f0eb19db@intel.com>
Date:   Sat, 1 Oct 2022 09:31:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.13.1
Subject: Re: [PATCH 0/2] dmaengine: idxd: Fix max batch size issues for Intel
 IAA
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>
Cc:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "Thomas, Ramesh" <ramesh.thomas@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Zhu, Tony" <tony.zhu@intel.com>,
        "Jia, Pei P" <pei.p.jia@intel.com>,
        Xiaochen Shen <xiaochen.shen@intel.com>
References: <20220808031922.29751-1-xiaochen.shen@intel.com>
 <IA1PR11MB6097EC13718EEEED2A15A0F09B499@IA1PR11MB6097.namprd11.prod.outlook.com>
 <YzXL/HkYS2Q8QEbK@matsya> <c898dd4c-1f1d-789e-e485-afd33c6dce87@intel.com>
 <YzcW27iY+fcDCxtw@matsya>
From:   Xiaochen Shen <xiaochen.shen@intel.com>
In-Reply-To: <YzcW27iY+fcDCxtw@matsya>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

On 10/1/2022 0:18, Vinod Koul wrote:
> yes pls rebase on -next branch, thanks

Please find v2 patchset which is rebased on -next branch:
https://lore.kernel.org/all/20220930201528.18621-1-xiaochen.shen@intel.com/

Thank you very much!


Best regards,
Xiaochen
