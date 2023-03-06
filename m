Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3BE6ACB85
	for <lists+dmaengine@lfdr.de>; Mon,  6 Mar 2023 18:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjCFRz0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Mar 2023 12:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbjCFRzM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Mar 2023 12:55:12 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242623B208;
        Mon,  6 Mar 2023 09:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678125290; x=1709661290;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4KwXkwpAmYREsl3iLbahqeIPXWyReRCUT+dJZ9VovR0=;
  b=oC/SJRKn0O7+lbg24MBF28obNrZBO/RiC6IWzMsUVBbTdT2EMDKn2m+G
   eH51cslG0fY6Ckk+31AzeB1CNBNtN3Rj0sAMfieQ+pxfLb0Vpxda+BHby
   jDivyIc6OraLyN9YuHk6UkdHrYlpbEt8NPn9x09hYHRuk4EWUEFC7F9Pf
   FRDul82U6CitzVvAbe55AW7enGOTKhG21KPrAxJX6pdvy5ezr+0hwBD9+
   kbpNvva5GlyeZ3zWKAzbPprAhedGqgiZZgiJ0SnjFI9hTdc5eTig+clFq
   BjG7wU5TO4E6WaEYK+bUnWlxZY7JlAZRdPqscN+7EgJbYDdJ1qqb2L+dr
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="319456153"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="319456153"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 09:54:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="819384765"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="819384765"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 09:54:07 -0800
Date:   Mon, 6 Mar 2023 09:57:59 -0800
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
Message-ID: <20230306095759.1dd65cca@jacob-builder>
In-Reply-To: <ZAYmS4Sx6bm+ziDY@nvidia.com>
References: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
        <20230302005959.2695267-4-jacob.jun.pan@linux.intel.com>
        <BN9PR11MB52765C5E0DC0759880C08E258CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
        <20230303134753.660d0755@jacob-builder>
        <ZAXkLN39VUSl+t65@nvidia.com>
        <20230306094408.2d675d5b@jacob-builder>
        <ZAYmS4Sx6bm+ziDY@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Jason,

On Mon, 6 Mar 2023 13:43:39 -0400, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, Mar 06, 2023 at 09:44:08AM -0800, Jacob Pan wrote:
> > Hi Jason,
> > 
> > On Mon, 6 Mar 2023 09:01:32 -0400, Jason Gunthorpe <jgg@nvidia.com>
> > wrote: 
> > > On Fri, Mar 03, 2023 at 01:47:53PM -0800, Jacob Pan wrote:  
> > > > Hi Kevin,
> > > > 
> > > > On Thu, 2 Mar 2023 09:43:03 +0000, "Tian, Kevin"
> > > > <kevin.tian@intel.com> wrote:
> > > >     
> > > > > > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > > > > Sent: Thursday, March 2, 2023 9:00 AM
> > > > > > 
> > > > > > Global PASID allocation is under IOMMU SVA code since it is the
> > > > > > primary use case.  However, some architecture such as VT-d,
> > > > > > global PASIDs are necessary for its internal use of DMA API
> > > > > > with PASID.      
> > > > > 
> > > > > No, global PASID is not a VT-d restriction. It's from ENQCMD/S
> > > > > hence a device requirement.    
> > > > I meant VT-d based platforms, it is kind of intertwined in that
> > > > ENQCMDS does not restrict RIDPASID!=DMA PASID, vt-d does. Without
> > > > this restriction, there wouldn't be a need for this patch. Let me
> > > > reword.    
> > > 
> > > No, Kevin is right, there is nothing about VT-d that needs global
> > > PASID values.
> > > 
> > > The driver should be managing RID2PASID itself to avoid conflicting
> > > with any in-use PASID, either by changing RID2PASID on demand or by
> > > setting it to a value that is not part of the PASID number space, eg
> > > we can make 0 entirely invalid, or the driver can reduce max_pasid of
> > > the devices it controls and use PASID_MAX.
> > >   
> > I see, thank you both. how about
> > "This patch provide an API for device drivers to request global PASIDs
> > as needed. The device drivers will then gain the flexibility of choosing
> > PASIDs not conflicting with anyone in-use."  
> 
> Stil no, this functionality should be clearly and unambiguously tied
> to ENQCMD:
> 
> Devices that rely on Intel ENQCMD have a single CPU register to store
> the current thread's PASID in. This necessarily makes the PASID a
> system-global value shared by all ENQCMD using devices.
> 
> This matches the current allocator being used for the SVA PASID so for
> now allow ENQCMD drivers to access this PASID allocator for other
> uses.
> 
ENQCMDS does not have the restriction of using a single CPU MSR to store
PASIDs, PASID is supplied to the instruction operand. Here we are adding
API for ENQCMDS. Should we explain this as well? i.e. due the unforgiving
nature of ENQCMD that requires global PASIDs, ENQCMDS has no choice but to
allocate from the same numberspace to avoid conflict.


Thanks,

Jacob
