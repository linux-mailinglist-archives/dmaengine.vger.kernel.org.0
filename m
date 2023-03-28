Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715AA6CC7E8
	for <lists+dmaengine@lfdr.de>; Tue, 28 Mar 2023 18:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjC1Q2Y (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Mar 2023 12:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjC1Q2X (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Mar 2023 12:28:23 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BCDD533;
        Tue, 28 Mar 2023 09:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680020897; x=1711556897;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PutlLLRQ0cjX+4MJOODPdoxCIDXtRmBjpz7PWw8bXP8=;
  b=Y40m75raQFF95oDCjb1C75egA+ADECHc1QxMp+L8MBa26fmuS7CGpErX
   ARd+yusiV7jtz5nFJkeIMrrdbX0mM9e6DKcFy8G/ZT9fW6oraacM7KhrW
   V6ws1hVPaOF54C2MvfazvBU9dzRTDhJgR/CHTUGNlcqcnUSAIcA3GluR1
   mDZZWRWYMSpsGhq2ybQOdSjRCox4LA6mIrL5i1mL5qfKhbAmnBOXN0vAr
   14YwzG0bAlS2IeYp0qfkEQPG+by5x3+fDe1RSc1wj3Syxu4uqv8A+G1UI
   XHeYWk+3oYJ1IFz0JXwoQZbnu0zwedKApIXp4WdA4ZXYB7CcsphEOjpry
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="405558062"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="405558062"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 09:28:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="683957590"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="683957590"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 09:28:13 -0700
Date:   Tue, 28 Mar 2023 09:32:16 -0700
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
Subject: Re: [PATCH v2 3/8] iommu/sva: Support reservation of global SVA
 PASIDs
Message-ID: <20230328093216.1c7afc1f@jacob-builder>
In-Reply-To: <ZCMN/LhCgDfwz+Z/@nvidia.com>
References: <20230327232138.1490712-1-jacob.jun.pan@linux.intel.com>
        <20230327232138.1490712-4-jacob.jun.pan@linux.intel.com>
        <BN9PR11MB527652D88D15437F52FCE8268C889@BN9PR11MB5276.namprd11.prod.outlook.com>
        <20230328083110.294a327c@jacob-builder>
        <ZCMN/LhCgDfwz+Z/@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Jason,

On Tue, 28 Mar 2023 12:55:40 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Mar 28, 2023 at 08:31:10AM -0700, Jacob Pan wrote:
> 
> > > this would be future proof when the same driver starts to allocate
> > > more pasids for other usages e..g siov.  
> > I don't have strong preference here. Jason and others?  
> 
> Oh I'm all for getting the word SVA out of the PASID infrastructure.
> 
> SVA has nothing to do with PASID other than it requires it to work.
> 
I will move pasid allocation code to iommu.c then.

Thanks,

Jacob
