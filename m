Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96546AD369
	for <lists+dmaengine@lfdr.de>; Tue,  7 Mar 2023 01:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjCGAmC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Mar 2023 19:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjCGAmB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Mar 2023 19:42:01 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE4B3B3DE;
        Mon,  6 Mar 2023 16:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678149719; x=1709685719;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XhNE9wpAaF+JRcQwnZM8UruFGzy4KLhJd78fbJA7ezg=;
  b=A4TZJXy7l+qXAooIqYjLPEWhxn+nEdf2G2kQAdx0bt+S8vmkHi9ApP6l
   R1wEEBc+PCMH8J0nLtotazFdkP0Mrk/kk2tSi6LFrRtYAi3c77I5bdvGz
   JgnczoXn3WS7zyfzTgMb1YSt4ygUCRYtzR4BIjV/D+4webcYhAUFQ9y8t
   vaNf4C+J5zdgghltAGs7ujNGknKG8kcAVIuDIWsdwAM3rDQahRQQ8VXFu
   RDaUT5IHKoX3n82Y/DLV7jcxVJoXWe9mSqGnCPp+U/LlsvzV4lS+Uruxv
   scl946YBbNhl1jjIC7/3G0kKx2BWyYoTF343SYdmtRpi4Hi0zeRWjyiBe
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="335742844"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="335742844"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 16:41:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="922147808"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="922147808"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 16:41:58 -0800
Date:   Mon, 6 Mar 2023 16:45:49 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
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
Subject: Re: [PATCH 1/4] iommu/vt-d: Implement set device pasid op for
 default domain
Message-ID: <20230306164549.27ebf2ac@jacob-builder>
In-Reply-To: <20230306154504.04769726@jacob-builder>
References: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
        <20230302005959.2695267-2-jacob.jun.pan@linux.intel.com>
        <fad7f28f-b4e8-c1c3-4ca4-a48c5c6d7f4a@linux.intel.com>
        <BN9PR11MB52762957011E60E935E82CC88CB39@BN9PR11MB5276.namprd11.prod.outlook.com>
        <2c9115d0-f251-c284-63d6-73714edc96b4@linux.intel.com>
        <BN9PR11MB527634EA1ED5067D1FC0D7C68CB39@BN9PR11MB5276.namprd11.prod.outlook.com>
        <7f8983c8-b703-4960-67b5-97f4053329db@linux.intel.com>
        <BN9PR11MB5276E48AA1680C76A3ED66AD8CB39@BN9PR11MB5276.namprd11.prod.outlook.com>
        <20230306110443.4ca52204@jacob-builder>
        <ZAY4zd4OlgSz+puZ@nvidia.com>
        <20230306154504.04769726@jacob-builder>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Jacob,

On Mon, 6 Mar 2023 15:45:04 -0800, Jacob Pan
<jacob.jun.pan@linux.intel.com> wrote:

> Hi Jason,
> 
> On Mon, 6 Mar 2023 15:02:37 -0400, Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > On Mon, Mar 06, 2023 at 11:04:43AM -0800, Jacob Pan wrote:
> >   
> > > > and probably this is the right thing to do as in the end DMA type
> > > > will be removed with Jason's cleanup    
> > >
> > > so, let me recap. set_dev_pasid() should make no assumptions of
> > > ordering, i.e. it is equal to iommu_domain_ops.attach_dev().    
> > 
> > Absolutely yes.
> > 
> > You should factor out all the "prepare the domain to be used" code and
> > call it in both places.
> >   
> I think this has been done by Baolu
> https://lore.kernel.org/linux-iommu/20190325013036.18400-1-baolu.lu@linux.intel.com/T/#m8c980357a39dc75dc360ff0f71dc7ebe1e49f9a6
> iommu/vt-d: Move common code out of iommu_attch_device()
>     
>     This part of code could be used by both normal and aux
>     domain specific attach entries. Hence move them into a
>     common function to avoid duplication.
> 
> set_dev_pasid() will call prepare_domain_attach_device() as well.
Actually, there are more to be factored to common code if we take that
assumption away. attach_dev() can be viewed as a special case for
set_dev_pasid() except the PASID is RID_PASID.

Thanks,

Jacob
