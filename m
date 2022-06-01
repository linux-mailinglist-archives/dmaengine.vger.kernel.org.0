Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835C653A0C7
	for <lists+dmaengine@lfdr.de>; Wed,  1 Jun 2022 11:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiFAJiB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 1 Jun 2022 05:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349866AbiFAJhc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 1 Jun 2022 05:37:32 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EA213DDD;
        Wed,  1 Jun 2022 02:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654076251; x=1685612251;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=D7NtTD/QI9HCTZzgqGKCgSrSSUq0k5fYUd5oM5bo5JY=;
  b=G3zvwCRiDRNivkdtM/m01wXHda3/2bap0PGQPIgurgD/m0orMk3wn3ON
   msppomuEDWSL5T4jTotk2g9U3A7GLZF6GvkqxcgbvbF49b7+nY3iz7HWn
   NMEQnKmQz2L95oA9UhcIJb2mEp+6K+9L/2DSd9lL9U2/0H5VjRGs4NMLq
   A90q0phGiZHaViF11kN1Zsu9DJAGfrhu1jTBRfp/wm0EQLBckTHK14bSH
   jwAb55wxaoAuLzeAx5KMs7nZmpQ/ArJJZCX92mThpegtX1kUS8HaIYMZs
   IundusFBY9A/Fy86SXHOaJg0DFOtMv7Y3EMX7x3DwiNrm6EZuHTrIRznZ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="361904366"
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="361904366"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 02:37:31 -0700
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="706981292"
Received: from hej1-mobl.ccr.corp.intel.com (HELO [10.255.28.123]) ([10.255.28.123])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 02:37:27 -0700
Message-ID: <868984fa-c8bc-635c-1788-99bc8e6fd587@linux.intel.com>
Date:   Wed, 1 Jun 2022 17:37:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Christoph Hellwig <hch@infradead.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v4 1/6] iommu: Add a per domain PASID for DMA API
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
 <20220518182120.1136715-2-jacob.jun.pan@linux.intel.com>
 <20220524135034.GU1343366@nvidia.com> <20220524081727.19c2dd6d@jacob-builder>
 <20220530122247.GY1343366@nvidia.com>
 <BN9PR11MB52768105FC4FB959298F8A188CDC9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <628aa885-dd12-8bcd-bfc6-446345bf69ed@linux.intel.com>
 <20220531102955.6618b540@jacob-builder>
 <BN9PR11MB5276A2B5E849C2153939934C8CDF9@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276A2B5E849C2153939934C8CDF9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2022/6/1 09:43, Tian, Kevin wrote:
>> From: Jacob Pan<jacob.jun.pan@linux.intel.com>
>> Sent: Wednesday, June 1, 2022 1:30 AM
>>>> In both cases the pasid is stored in the attach data instead of the
>>>> domain.
>>>>
>> So during IOTLB flush for the domain, do we loop through the attach data?
> Yes and it's required.

What does the attach data mean here? Do you mean group->pasid_array?

Why not tracking the {device, pasid} info in the iommu driver when
setting domain to {device, pasid}? We have tracked device in a list when
setting a domain to device.

Best regards,
baolu
