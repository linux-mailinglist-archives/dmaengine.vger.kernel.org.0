Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA1F6AD486
	for <lists+dmaengine@lfdr.de>; Tue,  7 Mar 2023 03:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjCGCS4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Mar 2023 21:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjCGCSz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Mar 2023 21:18:55 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC25332CC2;
        Mon,  6 Mar 2023 18:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678155534; x=1709691534;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tQv4gmdXcympjD8IkqsMELkqyJD5tQxJZu6zFQZNSo8=;
  b=Y480MuwUkcipqggxksBGGgAnYMPW04ZzOEFSYkGQ9d0DqfK+dKCkFLAp
   m6ZUaRUSA0wxu13GR2CiL83xHYiOa/BadulbTlhO+s5hl7V7lHu7dILFm
   ebQprr1RvPBho85fB522A28FWPYzLyqUj57jMXkf72BcGqfgUzvDYPyq+
   wD65kusJFjG5QFj5j2RXT06Fwi5+sg0LvtEA5hBEGuc75170oaJQ5f3FA
   Z9GmWfFZxO+lpoyufU+ZOzOuQ/1Vk3qxPIGH0mETRVUPKFIr44BJZu2io
   ahvE2vPOcWbdQRPnhkExfEg2luhtX9iHkPVMRsUECxYxi9SipUA/eVrIx
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="333212755"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="333212755"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 18:16:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="765460393"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="765460393"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Mar 2023 18:16:20 -0800
Message-ID: <f7c71e0a-59a8-b871-5593-713c9ad38cce@linux.intel.com>
Date:   Tue, 7 Mar 2023 10:15:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     baolu.lu@linux.intel.com, LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
        dmaengine@vger.kernel.org, vkoul@kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>
Subject: Re: [PATCH 1/4] iommu/vt-d: Implement set device pasid op for default
 domain
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
 <20230302005959.2695267-2-jacob.jun.pan@linux.intel.com>
 <ZAXjVaucrkEvrfsw@nvidia.com> <20230306093626.31c1573e@jacob-builder>
 <ZAYlwzQEcDHZKoju@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZAYlwzQEcDHZKoju@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 3/7/23 1:41 AM, Jason Gunthorpe wrote:
> On Mon, Mar 06, 2023 at 09:36:26AM -0800, Jacob Pan wrote:
> 
>>> It seems like all this is doing is flushing the PRI queue.
>>> A domain should have a dedicated flag unrelated to the type if it is
>>> using PRI and all PRI using domains should have the PRI queue flushed
>>> here, using the same code as flushing the PRI for a RID attachment.
>> Yes, or if the teardown op is domain-specific, then it works too?
> That could only sense if we end up creating a PRI domain type too..
> 
> Right now PRI is messy because it doesn't really work with unmanaged
> domains and that is something that will have to get fixed sort of
> soonish
> 
> Once PRI is a proper thing then "SVA" is just a PRI domain that has a
> non-managed from-the-mm page table pointer.
> 
> Most of the driver code marked svm should entirely disappear.

Agreed.

There is also another code consolidation we discussed earlier, that is
moving mmu_notifier_register/unregister to drivers/iommu/iommu-sva.c.
It's common for all SVA-capable iommu drivers.

With PRI domain and mm_notifier addressed, we could safely remove the
switch here. SVA domain will be nothing special. :-)

Best regards,
baolu
