Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE09524591
	for <lists+dmaengine@lfdr.de>; Thu, 12 May 2022 08:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347424AbiELGWK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 12 May 2022 02:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350162AbiELGWJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 12 May 2022 02:22:09 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3044B415;
        Wed, 11 May 2022 23:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652336529; x=1683872529;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=apWNSnw0jq7MMyjF5XJkJ1OhC5LHi+YzksZK3Q5fLSE=;
  b=m4Njk9QW5TOBduWyuEmWPvLe2i3U7koL5giBFOuDzoM5vFRI+dkLuXiT
   rkUmKXopYp+b0dgoWm+M7TN5570wD+tFjF62TvsgA0HLeb5c6/pKpt4zL
   gaOhbeuPBiP48z1U1GNyGqbJZxgN8Ee+yTup782QeVUOUyE+cVi6BHJY9
   nuf0oSrAIefq6Zmk0AvPeDsNDRXK4h4wwLhN9fR3bQmCqOGBH5Rsoo8ZY
   9Xw9I/0eJbz906NC/PDtE8V4PCZ3M48yFriUyPoEC1/Y1IycvM/yhXPw6
   2/42QuTfEOy3FS7ixxzlwQL+1yUplqoFMNxJMtPk/3wbNKKys/BEhZzwi
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="249801089"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="249801089"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 23:22:08 -0700
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="594516021"
Received: from hezhu1-mobl1.ccr.corp.intel.com (HELO [10.255.29.168]) ([10.255.29.168])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 23:22:04 -0700
Message-ID: <c75a03db-69c2-0833-d853-b766c4561be4@linux.intel.com>
Date:   Thu, 12 May 2022 14:22:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>, dmaengine@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        vkoul@kernel.org, robin.murphy@arm.com, will@kernel.org,
        Yi Liu <yi.l.liu@intel.com>, Dave Jiang <dave.jiang@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v3 1/4] iommu/vt-d: Implement domain ops for
 attach_dev_pasid
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20220510210704.3539577-1-jacob.jun.pan@linux.intel.com>
 <20220510210704.3539577-2-jacob.jun.pan@linux.intel.com>
 <20220510232121.GP49344@nvidia.com> <20220510172309.3c4e7512@jacob-builder>
 <20220511115427.GU49344@nvidia.com> <20220511082958.79d5d8ee@jacob-builder>
 <20220511161237.GB49344@nvidia.com> <20220511100216.7615e288@jacob-builder>
 <20220511170025.GF49344@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220511170025.GF49344@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Jason,

On 2022/5/12 01:00, Jason Gunthorpe wrote:
>> Consolidate pasid programming into dev_set_pasid() then called by both
>> intel_svm_attach_dev_pasid() and intel_iommu_attach_dev_pasid(), right?
> I was only suggesting that really dev_attach_pasid() op is misnamed,
> it should be called set_dev_pasid() and act like a set, not a paired
> attach/detach - same as the non-PASID ops.

So,

   "set_dev_pasid(domain, device, pasid)" equals to dev_attach_pasid()

and

   "set_dev_pasid(NULL, device, pasid)" equals to dev_detach_pasid()?

do I understand it right?

Best regards,
baolu
