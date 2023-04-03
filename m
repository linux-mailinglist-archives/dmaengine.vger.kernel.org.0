Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF556D5402
	for <lists+dmaengine@lfdr.de>; Mon,  3 Apr 2023 23:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbjDCVwr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 3 Apr 2023 17:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbjDCVwr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 3 Apr 2023 17:52:47 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4E390;
        Mon,  3 Apr 2023 14:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680558766; x=1712094766;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1Q6bBL05Vw7AlHWmpx/OKhrtmQt1bapS87ipU3nNQfo=;
  b=PUqcUPifv9u2B4XKYKcrkUocQ7Y1EDdtI/GXpkInh8O3LCT1A1yPfIHx
   2QnBq/Imy2GASM0sLCXepfjD61aMKFkxgGCp6GY9OibnOJDlyalTiKCkc
   8tEtxl3uR1W2InW8Dz9tQWk6sVHpndTy2iVb8A+sjNjhaTncQoidWRgJH
   gzs29IPZXSk6aY11ez7mX6qEA4+uo6CBshspDK71BIkeeTJkky1QPfRKg
   FkrHPWcRtS/DPZDZHH767iLzKjaabsLz6xINx2tJG2Gv6Wxlrnm6Gq9NI
   9HgWG4WMeSslpmm47Fii4Nqjol3W93X81FJYyULW6cCj+jv31T+1CJCDo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="343718530"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="343718530"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 14:52:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="932202378"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="932202378"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 14:52:43 -0700
Date:   Mon, 3 Apr 2023 14:56:49 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     "Yu, Fenghua" <fenghua.yu@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v3 7/7] dmaengine/idxd: Re-enable kernel workqueue under
 DMA API
Message-ID: <20230403145649.2d3db18a@jacob-builder>
In-Reply-To: <IA1PR11MB609783D2D1159E4AA6F6099E9B8F9@IA1PR11MB6097.namprd11.prod.outlook.com>
References: <20230331231137.1947675-1-jacob.jun.pan@linux.intel.com>
        <20230331231137.1947675-8-jacob.jun.pan@linux.intel.com>
        <IA1PR11MB609783D2D1159E4AA6F6099E9B8F9@IA1PR11MB6097.namprd11.prod.outlook.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Fenghua,

On Fri, 31 Mar 2023 23:31:13 +0000, "Yu, Fenghua" <fenghua.yu@intel.com>
wrote:

> Hi, Jacob,
> 
> > Kernel workqueues were disabled due to flawed use of kernel VA and SVA
> > API. Now That we have the support for attaching PASID to the device's
> > default  
> 
> s/That/that/
will fix, for real this time :) you pointed it out before.

> > domain and the ability to reserve global PASIDs from SVA APIs, we can
> > re-enable the kernel work queues and use them under DMA API.
> > 
> > We also use non-privileged access for in-kernel DMA to be consistent
> > with the IOMMU settings. Consequently, interrupt for user privilege is
> > enabled for work completion IRQs.
> > 
> > Link:https://lore.kernel.org/linux-
> > iommu/20210511194726.GP1002214@nvidia.com/
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>  
> 
> Other than the typo,
> 
> Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
> 
> Thanks.
> 
> -Fenghua


Thanks,

Jacob
