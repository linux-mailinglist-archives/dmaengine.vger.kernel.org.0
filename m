Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBCB6ACADE
	for <lists+dmaengine@lfdr.de>; Mon,  6 Mar 2023 18:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjCFRmB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Mar 2023 12:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjCFRl5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Mar 2023 12:41:57 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223A94741C;
        Mon,  6 Mar 2023 09:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678124490; x=1709660490;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jYQf0+QQ92IJa7rmg3xs0GynrfCE+yIEFalz9+F5Bow=;
  b=ONk4LW0Wy6ZzIgng6KRJCOe8xvw87Q4XkdId1hjJFPxIs36Dqc6giZJb
   KmM2PBvE1VD3gDVbG4MKOjKkrv4sPI2Lh+HdxZIN2x8JOTC2vW5RS/cVr
   Seoy4axexPSfKhJK0wYWXJ/NazP2La1dXl9hBeRLJqqKKSfylgkYH+UB+
   N/0qfiAqPsxRkIOpVOCUqjjN3o0zgKCIs9l3Ad4F+tRpBcHptgt+9uB/R
   fGf5ll+GGYKcDsofJtaJ9b8wFD41c9uukhkWJARRqrlZWc+p/0qyizbgw
   5/wjRvbxH0auB+vXBEZChTpXaXlAqk4Cz0uba1VnOzL1gmNIzfWbgv2K3
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="363242787"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="363242787"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 09:40:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="745156852"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="745156852"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 09:40:17 -0800
Date:   Mon, 6 Mar 2023 09:44:08 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Lu Baolu <baolu.lu@linux.intel.com>,
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
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 3/4] iommu/sva: Support reservation of global PASIDs
Message-ID: <20230306094408.2d675d5b@jacob-builder>
In-Reply-To: <ZAXkLN39VUSl+t65@nvidia.com>
References: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
        <20230302005959.2695267-4-jacob.jun.pan@linux.intel.com>
        <BN9PR11MB52765C5E0DC0759880C08E258CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
        <20230303134753.660d0755@jacob-builder>
        <ZAXkLN39VUSl+t65@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Jason,

On Mon, 6 Mar 2023 09:01:32 -0400, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Fri, Mar 03, 2023 at 01:47:53PM -0800, Jacob Pan wrote:
> > Hi Kevin,
> > 
> > On Thu, 2 Mar 2023 09:43:03 +0000, "Tian, Kevin" <kevin.tian@intel.com>
> > wrote:
> >   
> > > > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > > Sent: Thursday, March 2, 2023 9:00 AM
> > > > 
> > > > Global PASID allocation is under IOMMU SVA code since it is the
> > > > primary use case.  However, some architecture such as VT-d, global
> > > > PASIDs are necessary for its internal use of DMA API with PASID.    
> > > 
> > > No, global PASID is not a VT-d restriction. It's from ENQCMD/S hence a
> > > device requirement.  
> > I meant VT-d based platforms, it is kind of intertwined in that ENQCMDS
> > does not restrict RIDPASID!=DMA PASID, vt-d does. Without this
> > restriction, there wouldn't be a need for this patch. Let me reword.  
> 
> No, Kevin is right, there is nothing about VT-d that needs global
> PASID values.
> 
> The driver should be managing RID2PASID itself to avoid conflicting
> with any in-use PASID, either by changing RID2PASID on demand or by
> setting it to a value that is not part of the PASID number space, eg
> we can make 0 entirely invalid, or the driver can reduce max_pasid of
> the devices it controls and use PASID_MAX.
> 
I see, thank you both. how about
"This patch provide an API for device drivers to request global PASIDs as
needed. The device drivers will then gain the flexibility of choosing
PASIDs not conflicting with anyone in-use."


Thanks,

Jacob
