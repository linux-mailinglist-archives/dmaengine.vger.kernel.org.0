Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2123D6D3118
	for <lists+dmaengine@lfdr.de>; Sat,  1 Apr 2023 15:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjDANlW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 1 Apr 2023 09:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDANlV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 1 Apr 2023 09:41:21 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89EA1BF5D;
        Sat,  1 Apr 2023 06:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680356480; x=1711892480;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oo7ZKkfMW2SRqFUeLHxvdNWhSGFJwlIB/+Xmjgc78Gw=;
  b=gStNySngv6hBlCCLjn05CcNI4CPhDHKCOdP6jvNLSkCNVvD2CFbegrXm
   lQKqLxDlZTRRJjdq2RXRU4Qlc2CypWeqFh60TVq3WfXY0EIAyOxxyfKVE
   4V4tk14pIInSDs3vErDhphlizyDLgVlDsfGfzU+zyDwxaAkh5TVJKW1dt
   31HWg30M0b9mzavxdls7iVlGMKSl/SGyQqGwoumGq845eu9ELvs3nrXiS
   Cp5Ffu3cbzLjOos3noMoqmAtxj/9K2VocmIysWN3OBjWjCSuD4NQozP1h
   yU6OQwW9kiso+KlutjNqMaEaM/y3aAPSMKe9XuheRmQ+AlO4bjXCaPuB9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10667"; a="406690580"
X-IronPort-AV: E=Sophos;i="5.98,310,1673942400"; 
   d="scan'208";a="406690580"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2023 06:41:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10667"; a="931516604"
X-IronPort-AV: E=Sophos;i="5.98,310,1673942400"; 
   d="scan'208";a="931516604"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.211.241]) ([10.254.211.241])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2023 06:41:16 -0700
Message-ID: <2a5d6d53-f86a-43b4-b3cd-4c78951bc6ff@linux.intel.com>
Date:   Sat, 1 Apr 2023 21:41:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Cc:     baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>
Subject: Re: [PATCH v3 1/7] iommu/vt-d: Use non-privileged mode for all PASIDs
Content-Language: en-US
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>, dmaengine@vger.kernel.org,
        vkoul@kernel.org
References: <20230331231137.1947675-1-jacob.jun.pan@linux.intel.com>
 <20230331231137.1947675-2-jacob.jun.pan@linux.intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230331231137.1947675-2-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2023/4/1 7:11, Jacob Pan wrote:
> Supervisor Request Enable (SRE) bit in a PASID entry is for permission
> checking on DMA requests. When SRE = 0, DMA with supervisor privilege
> will be blocked. However, for in-kernel DMA this is not necessary in that
> we are targeting kernel memory anyway. There's no need to differentiate
> user and kernel for in-kernel DMA.
> 
> Let's use non-privileged (user) permission for all PASIDs used in kernel,
> it will be consistent with DMA without PASID (RID_PASID) as well.
> 
> Signed-off-by: Jacob Pan<jacob.jun.pan@linux.intel.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
