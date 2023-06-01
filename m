Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5522C71A34F
	for <lists+dmaengine@lfdr.de>; Thu,  1 Jun 2023 17:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbjFAPyC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 1 Jun 2023 11:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233827AbjFAPxy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 1 Jun 2023 11:53:54 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0068CB3;
        Thu,  1 Jun 2023 08:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685634833; x=1717170833;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qxiOOdrYX4boDBzh8iGft9ewMpmmOEyU+ptNYZaGWPM=;
  b=UVo6tKu++allYV8fBveJARqsj7rfe93ItwYcopuFqieQ6teJIP0s80sq
   Fzy7D4PnDufUBvnyaDdgesFeXUR0bQE0+tbmX6BgvZKJaGIr+vH0rnpcV
   hgsAyCR9lfxU+UsPAALKVUHHJiYgwbyqLGm1mfX+zLnvvI+n+/2LAd7bn
   MeQNpcQE1jZaeSDV4iTEAo6GHAzKfDw3wxqOgJvO+QnPjJipQ6hthKkJ9
   hr8XkFiq3ti0pYsrU5DiPSoYJKFYe9FOeDmeRZ+VvCeB5YhSwUp0iIfUb
   kXZZafMXMdQOtHVODi9Nz6ao7mKL7roicAzOV+odeDAuBcOsI1hAN67Nz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="335217770"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="335217770"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 08:53:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="881670636"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="881670636"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 08:53:53 -0700
Date:   Thu, 1 Jun 2023 08:58:29 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        dmaengine@vger.kernel.org, vkoul@kernel.org,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        narayan.ranganathan@intel.com, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v7 0/4] Re-enable IDXD kernel workqueue under DMA API
Message-ID: <20230601085829.026a8c17@jacob-builder>
In-Reply-To: <ZHipgzmZ9q3Ihvk5@nvidia.com>
References: <20230523173451.2932113-1-jacob.jun.pan@linux.intel.com>
        <20230531213342.1a3f1508@jacob-builder>
        <ZHipgzmZ9q3Ihvk5@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Jason,

On Thu, 1 Jun 2023 11:21:55 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, May 31, 2023 at 09:33:42PM -0700, Jacob Pan wrote:
> > Hi Jason,
> > 
> > Do you have any comments on this set? this is a follow-up of the IOASID
> > removal series.  
> 
> It looks OK in general, I see it still needs another spin before the
> driver part is OK?
Yes, I will get that from Baolu and test.

Thanks,

Jacob
