Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1595F6B19BF
	for <lists+dmaengine@lfdr.de>; Thu,  9 Mar 2023 04:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjCIDDD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 Mar 2023 22:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjCIDDC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 8 Mar 2023 22:03:02 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3074C1BDE;
        Wed,  8 Mar 2023 19:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678330981; x=1709866981;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=e/LMiKmqsbycPATloBpt++Crxaa+zf+Pc5WNhT0JUkE=;
  b=KObTwbXuz3rVkRisgKQvSesnyAd1ZiFb9qjRyJxOTcfzUidEyL+zEOOU
   RXL6HuLDdfCYmXzD+a55Vw8HN/6GWJEXM0NNK69SSe/Xok27ANGSDOWzj
   Pm5AbjBjZiNpYepkmYTAVyPx73bHqA0E1731vUevTJq3UiB/hZqXfTlRQ
   yMAhgqoJPaGA34dYsEzXJHGLgKqBWBS8Lcb7NptJ9n06Wi+aPcA+cZB/I
   88h7T4oYCo9a7asV+YKWNx7TfuB/5XD4oVdLR1c1YPDdydslgdPfGmG34
   JsAf0W249ODECOKvuUb0yxRwqYP9aVy0n56M0rUaA3N2jIqDOA7OQJBDa
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="363975247"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="363975247"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 19:02:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="766259491"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="766259491"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Mar 2023 19:02:51 -0800
Message-ID: <3e3809e7-6603-3fd9-69b6-8ab114fff24b@linux.intel.com>
Date:   Thu, 9 Mar 2023 11:01:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Refactor code for non-PRI IOPF
Content-Language: en-US
To:     iommu@lists.linux.dev, dmaengine@vger.kernel.org
References: <20230309025639.26109-1-baolu.lu@linux.intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230309025639.26109-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 3/9/23 10:56 AM, Lu Baolu wrote:
> The existing SVA and IOPF implementation assumes that devices report I/O
> page faults via PCI PRI. This is not always true as some emerging
> devices are designed to handle the I/O page faults by themselves without
> ever sending PCI page requests nor advertising PRI capability.
> 
> Refactor the SVA and IOPF code to allow SVA support with IOPF handled
> either by IOMMU (PCI PRI) or device driver (device-specific IOPF).
> 
> This series is based on v6.3-rc1 and also available at github:
> https://github.com/LuBaolu/intel-iommu/commits/intel-iommu-refactor-iopf-v2

This is iommu/vt-d specific. I should make it explicit in the
cover-letter title.

	iommu/vt-d: Refactor code for non-PRI IOPF

Sorry about it.

Best regards,
baolu
