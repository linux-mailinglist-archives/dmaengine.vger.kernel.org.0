Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1666CCB9D
	for <lists+dmaengine@lfdr.de>; Tue, 28 Mar 2023 22:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjC1UsA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Mar 2023 16:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjC1UsA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Mar 2023 16:48:00 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4310212B;
        Tue, 28 Mar 2023 13:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680036479; x=1711572479;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IrBf2jxsIsqUqVNuSjNZZnkzHVlM3YG0iaidUQD274k=;
  b=YfVLgnTmr1MFlL6TIcqN6amBWaLj2W0r6gX1r4+PWiW3aaB5/Ps9nJ/x
   LsH/hMYjs0l8lWB6Kws8St1He5UlIjWX6yiaJ+WP8Nvj7iISGKVO83Pye
   1AzV8nVmWB71vxVeSCiiGP+pozqcUF8eyupvjVoZN3ol2orwoeC5lISZw
   kr7m16XP2QoxnKuCyciTCFR2mytgVhti9Yp6F5J7zhYZLzFO9nV9ZjX8k
   UTnRYy0ZvQ4frvOkygIjvR/9bgjuU4zMErDYBmdzlonnwlFJJSj3KRxL9
   MOqkQJ7I9+6bRgCn2tw3zwsTUgBsL9C3qMYpr2YHcMy9CLLY7f5Mw7vBR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="329147438"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="329147438"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 13:47:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="1013712586"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="1013712586"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 13:47:57 -0700
Date:   Tue, 28 Mar 2023 13:52:00 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>, dmaengine@vger.kernel.org,
        vkoul@kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 4/8] iommu/vt-d: Reserve RID_PASID from global SVA
 PASID space
Message-ID: <20230328135200.139f280a@jacob-builder>
In-Reply-To: <20230328092919.372f0545@jacob-builder>
References: <20230327232138.1490712-1-jacob.jun.pan@linux.intel.com>
        <20230327232138.1490712-5-jacob.jun.pan@linux.intel.com>
        <41d31adf-577e-431c-c400-2708885400c1@linux.intel.com>
        <20230328092919.372f0545@jacob-builder>
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

Hi Baolu,

On Tue, 28 Mar 2023 09:29:19 -0700, Jacob Pan
<jacob.jun.pan@linux.intel.com> wrote:

> > > On VT-d platforms, RID_PASID is used for DMA request without PASID. We
> > > should not treat RID_PASID special instead let it be allocated from
> > > the global SVA PASID number space.    
> > 
> > It's same to AMD and ARM SMMUv3, right? They also need an explicit
> > reservation of PASID 0.
> >   
> yes, all IOMMU drivers need to do that. I will give it a try but might
> need help to place the call.
It might be simpler to just let SVA code allocate from 1 up instead of 0
(as is in the current code). Global PASID allocator would still allow the
full range from 0 to max. Then there is no change to architectures that
don't support non-zero RID_PASID. For VT-d, it would still work in the
future when we have nonzero RID_PASID. is that reasonable?

Thanks,

Jacob
