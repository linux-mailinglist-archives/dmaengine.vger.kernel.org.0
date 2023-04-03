Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682546D52B6
	for <lists+dmaengine@lfdr.de>; Mon,  3 Apr 2023 22:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbjDCUkx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 3 Apr 2023 16:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbjDCUkw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 3 Apr 2023 16:40:52 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063F1E4B;
        Mon,  3 Apr 2023 13:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680554451; x=1712090451;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5V7tfHtJX0OGp/o2K2RrvADYKgIPEcvGJ9Py6xIMOM8=;
  b=ldEo0HFD9k0WOz0DP+cFZJIru0/mx074nRZfNQYzPg4izsJ5tPqVULxx
   Q10W9Rr206lG8tFXhlQVGMkBIbbUylBLsGEAnqm4z6WvAQ1rTG8sf8dSs
   M/RbWrHvPFQyTcgEm6xkhq82aVwRRf6wY34iPKxZ38zOX7l3G6Y20Iwtx
   +tRnisK8m3HzXbg2jxMFzX49U54pQm9mc22hxVkcsILcHg93Wy7k25DTr
   Cm9+qEU1TchOzB9keunu+E0FB955ApmhkOmncvmlxoHFuRewbWwxtUkfC
   NPZ7oxc0eevjx5pszOO1ZEcKMXUZvwdu0mMjTF6uZ51qH/+hgmLGF+T+o
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="428298974"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="428298974"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 13:40:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="716422725"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="716422725"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 13:40:51 -0700
Date:   Mon, 3 Apr 2023 13:44:57 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>, dmaengine@vger.kernel.org,
        vkoul@kernel.org, Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v3 3/7] iommu/sva: Support allocation of global PASIDs
 outside SVA
Message-ID: <20230403134457.25f56d11@jacob-builder>
In-Reply-To: <d20a04fc-e0a8-32ee-0d4a-083338d4179b@linux.intel.com>
References: <20230331231137.1947675-1-jacob.jun.pan@linux.intel.com>
        <20230331231137.1947675-4-jacob.jun.pan@linux.intel.com>
        <d20a04fc-e0a8-32ee-0d4a-083338d4179b@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Baolu,

On Sat, 1 Apr 2023 21:16:39 +0800, Baolu Lu <baolu.lu@linux.intel.com>
wrote:

> > +/**
> > + * @brief
> > + *	Reserve a PASID from the SVA global number space.
> > + *
> > + * @param min starting range, inclusive
> > + * @param max ending range, inclusive
> > + * @return The reserved PASID on success or IOMMU_PASID_INVALID on
> > failure.
> > + */  
> 
> Nit: the comments here also need to be changed accordingly.
good catch! will fix.

Thanks,

Jacob
