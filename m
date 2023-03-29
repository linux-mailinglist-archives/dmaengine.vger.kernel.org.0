Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168AB6CD207
	for <lists+dmaengine@lfdr.de>; Wed, 29 Mar 2023 08:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjC2GWj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Mar 2023 02:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC2GWi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Mar 2023 02:22:38 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5D41FE0;
        Tue, 28 Mar 2023 23:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680070957; x=1711606957;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RENjv1pFPkUUvA/QrzQeFxG/sxZXAb6K1H65xfm0QFc=;
  b=X8VT2yqcyKjasbQhhIF1q/Ebmh7fywoXirTFUTr/to3bXDh1OFF3Cmr4
   SJOp9pBQoxwrnWGIKxlNiQ8QcYhQFKJ4ee9vCJo+jLrV0AUhK4WXp2zvW
   BKK2Hd3kMInEXHwgZc3kV5ZmakFDb5P2pcbZTiF145ZnVsxx3dMTKDhyB
   ARHr+8VY9PevN2QElvUbTfoYP+Jo5SqLM4OUwyegvEDX6xTpCxeKT5bvA
   jvnNDraYk0UbNCgJgkyoRt5Ecf5ahIwAjvnrWX+pfU0doxvvwKJRJAChe
   qcIJYvca0xAsbmxp3ezk1mekyjlFD9U9gQ6uD4Ko/M2uyRMRU2kQJpr5g
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="403414243"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="403414243"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 23:22:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="930180199"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="930180199"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by fmsmga006.fm.intel.com with ESMTP; 28 Mar 2023 23:22:32 -0700
Message-ID: <797fec71-67d5-6420-3b2b-7056095d4bb7@linux.intel.com>
Date:   Wed, 29 Mar 2023 14:22:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     baolu.lu@linux.intel.com, LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>
Subject: Re: [PATCH v2 6/8] iommu/vt-d: Implement set_dev_pasid domain op
Content-Language: en-US
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
References: <20230327232138.1490712-1-jacob.jun.pan@linux.intel.com>
 <20230327232138.1490712-7-jacob.jun.pan@linux.intel.com>
 <BN9PR11MB5276B3FF6D21608BB17E32A18C889@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20230328084015.5c8c08ca@jacob-builder>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230328084015.5c8c08ca@jacob-builder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 3/28/23 11:40 PM, Jacob Pan wrote:
> Hi Kevin,
> 
> On Tue, 28 Mar 2023 07:47:45 +0000, "Tian, Kevin" <kevin.tian@intel.com>
> wrote:
> 
>>> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
>>> Sent: Tuesday, March 28, 2023 7:22 AM
>>>
>>> Devices that use ENQCMDS to submit work on buffers mapped by DMA API
>>> must attach a PASID to the default domain of the device. In preparation
>>> for this use case, this patch implements set_dev_pasid() for the
>>> default_domain_ops. Besides PASID attachment, device will also be
>>> attached to the domain as the result of this call if the device has not
>>> been attached before.
>>>    
>>
>> I didn't get the last point. PASID attach should only have the scope
>> for the pasid. RID of the device might be attached to another domain
>> which shouldn't be changed by this call.
> I meant if the RID context has not been set up before attaching this PASID,
> this call will also set up the context, PASID dir etc. In the end, we
> eliminated ordering requirement of attaching device, RID_PASID first, then
> other PASIDs.

This occurs in default domain deferred attaching case.

> How about:
> "If the device context has not been set up prior to this call, this will
> set up the device context in addition to PASID attachment."

Best regards,
baolu
