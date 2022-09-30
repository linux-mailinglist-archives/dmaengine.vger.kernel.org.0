Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0335F0324
	for <lists+dmaengine@lfdr.de>; Fri, 30 Sep 2022 05:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiI3DS2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Sep 2022 23:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiI3DS1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 29 Sep 2022 23:18:27 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75A515313B
        for <dmaengine@vger.kernel.org>; Thu, 29 Sep 2022 20:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664507906; x=1696043906;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=J9NPAol3RM1kE1vsPEcBYPYAfGzMSq2AbJHyDM6/IBw=;
  b=QHfKnmND0TRc41ESoNpXQ9XhivE/Iwf1HJZdB8L+8VzFFjUfPPKLORDy
   IqVnDGfY3skn6WSb56pZTe9c6iAAlKCGOoKRhfSW6y8iEUK7PPwaMi3Q7
   ZIyhg2LULBAin3bSdfw8l+B0sQEhu8bcnx/aMPXHBXGVS2ysi50bKwHoI
   cXkEAq8jGarc4RUDUXD+xKOzaagq4aNhVIAB02DNkWJtHFyzgUFvpn5zx
   deBt+kg5d8mfO7ig39srviGwzzcgL55DYFsW/dMG3beVhlStXUAglfovQ
   6TkHVWHHeH3HwJ5s1jJimdW37k7XrPbjBl6cSYP+CJo6pArtTAD63DHXJ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="285228119"
X-IronPort-AV: E=Sophos;i="5.93,357,1654585200"; 
   d="scan'208";a="285228119"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 20:18:26 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="624828587"
X-IronPort-AV: E=Sophos;i="5.93,357,1654585200"; 
   d="scan'208";a="624828587"
Received: from conghuic-mobl1.ccr.corp.intel.com (HELO [10.254.215.189]) ([10.254.215.189])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 20:18:23 -0700
Message-ID: <c898dd4c-1f1d-789e-e485-afd33c6dce87@intel.com>
Date:   Fri, 30 Sep 2022 11:18:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.13.1
Subject: Re: [PATCH 0/2] dmaengine: idxd: Fix max batch size issues for Intel
 IAA
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>, "Yu, Fenghua" <fenghua.yu@intel.com>
Cc:     "Jiang, Dave" <dave.jiang@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "Thomas, Ramesh" <ramesh.thomas@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Zhu, Tony" <tony.zhu@intel.com>,
        "Jia, Pei P" <pei.p.jia@intel.com>,
        Xiaochen Shen <xiaochen.shen@intel.com>
References: <20220808031922.29751-1-xiaochen.shen@intel.com>
 <IA1PR11MB6097EC13718EEEED2A15A0F09B499@IA1PR11MB6097.namprd11.prod.outlook.com>
 <YzXL/HkYS2Q8QEbK@matsya>
From:   Xiaochen Shen <xiaochen.shen@intel.com>
In-Reply-To: <YzXL/HkYS2Q8QEbK@matsya>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

Thank you very much for code review!

On 9/30/2022 0:46, Vinod Koul wrote:
> On 15-09-22, 16:21, Yu, Fenghua wrote:
>> Hi, Vinod,
>>
>>> Fix max batch size related issues for Intel IAA:
>>> 1. Fix max batch size default values.
>>> 2. Make max batch size attributes in sysfs invisible.
>>
>> Any comment on this patch set? Would you apply it?
> 
> This does not apply for me (i guess due to other idxd patches I have
> applied today), pls rebase on next and resend
> 

Could you help check if these idxd patches are merged into 'next' branch of
https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git ?

I will rebase on top of 'next' branch and resend the patch soon.
Thank you very much!


Best regards,
Xiaochen
