Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341BD6D3D02
	for <lists+dmaengine@lfdr.de>; Mon,  3 Apr 2023 07:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjDCFtP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 3 Apr 2023 01:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjDCFtO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 3 Apr 2023 01:49:14 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD48165B9;
        Sun,  2 Apr 2023 22:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680500953; x=1712036953;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vor67KSJsSE/cFZlx1ZQmjpR2d2MNGp4HgZXneBuAcQ=;
  b=mJpN9no3haX9m1xjHBKb2jJhpj65oBm1suGladkLjZMaitdUEQoPH83P
   CGeFfaSXtlJWA6i9ITTBrZNFoiFKwvVEzvSCMZHzJo9GbCM4rYbB7cWSb
   8rybJz6OXvyJjdoX0urjwxBbeNSZNaPPWTMEcvGUsHFpcP23LBG+Fzcoq
   sJAJEeFgukmex/0YRLViMyozdnMeNrbIDTssXXWQVSPq6aRyNuRfQWas5
   mAvSF+5OtXbTuQtkXR4vWgxulYtDPsJqHugB+MB9iqHDgraPv+bSMZmi2
   oiJcyDMrVkQtJ/YvkqW5Rjnnw2YbPNKitVUR35hq40BpqbErTuidXmQo/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="428103273"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="428103273"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2023 22:49:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="718413118"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="718413118"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga001.jf.intel.com with ESMTP; 02 Apr 2023 22:49:08 -0700
Message-ID: <f6445aed-bf35-7245-3d52-336ebe11a866@linux.intel.com>
Date:   Mon, 3 Apr 2023 13:49:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] dmaengine: idxd: Add enable/disable device IOPF
 feature
Content-Language: en-US
To:     iommu@lists.linux.dev, dmaengine@vger.kernel.org
References: <20230324120234.313643-1-baolu.lu@linux.intel.com>
 <20230324120234.313643-2-baolu.lu@linux.intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230324120234.313643-2-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 3/24/23 8:02 PM, Lu Baolu wrote:
> The iommu subsystem requires IOMMU_DEV_FEAT_IOPF must be enabled before
> and disabled after IOMMU_DEV_FEAT_SVA, if device's I/O page faults rely
> on the IOMMU. Add explicit IOMMU_DEV_FEAT_IOPF enabling/disabling in this
> driver.
> 
> At present, missing IOPF enabling/disabling doesn't cause any real issue,
> because the IOMMU driver places the IOPF enabling/disabling in the path
> of SVA feature handling. But this may change.
> 
> Reviewed-by: Dave Jiang<dave.jiang@intel.com>
> Reviewed-by: Fenghua Yu<fenghua.yu@intel.com>
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>

Hi Dave and Fenghua,

The following iommu patches depends on this one. Can I route it to
Linus through the iommu tree?

Best regards,
baolu
