Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68E66A87BB
	for <lists+dmaengine@lfdr.de>; Thu,  2 Mar 2023 18:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjCBRTY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Mar 2023 12:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjCBRTX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 2 Mar 2023 12:19:23 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFB5CA26;
        Thu,  2 Mar 2023 09:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677777562; x=1709313562;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t6Bmp0fFrnUCAiBWt37tkMKRrr79WxRyKdKg/hHFkKg=;
  b=NaBkTcAU7tdLy2RfP3iodlo5NckgeVEwDH9wiAk0ihbkz9sEMyzQJ9+i
   gCkkH0KmOGewr5stGPufKx2i85dUFmXznsw/ZfmfjDZjLESj0w4ZTTLc8
   0Dbu3edExg93KYjleZ8ICNiITWiwRiV+bb8XSEaNLus+2NNPOxVAggsSb
   e229dW3JMQFC9BAd/0I+X9yZcDeiBL9F8lG3hd26FQFjskbPguX/+T6Ro
   1gdD4KgcDhzchQ0R3hHxblRdHQe3VOh4ydEcmkF4EhQ2hoSsPMtRIey9G
   D8b4p9aEvTbRpykGnhNcmJqYmKhhX0/wJhlBolD55lehJjmdVNOvIiOdq
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="333508780"
X-IronPort-AV: E=Sophos;i="5.98,228,1673942400"; 
   d="scan'208";a="333508780"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 09:19:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="849150513"
X-IronPort-AV: E=Sophos;i="5.98,228,1673942400"; 
   d="scan'208";a="849150513"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 09:19:21 -0800
Date:   Thu, 2 Mar 2023 09:23:10 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Tina Zhang <tina.zhang@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "X86 Kernel" <x86@kernel.org>, <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, <corbet@lwn.net>,
        <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        "David Woodhouse" <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v4 3/6] iommu/sva: Stop using ioasid_set for SVA
Message-ID: <20230302092310.77f97361@jacob-builder>
In-Reply-To: <43e9711f-042e-eaf9-e091-07db78cad943@intel.com>
References: <20230301235646.2692846-1-jacob.jun.pan@linux.intel.com>
        <20230301235646.2692846-4-jacob.jun.pan@linux.intel.com>
        <43e9711f-042e-eaf9-e091-07db78cad943@intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Tina,

On Thu, 2 Mar 2023 21:52:42 +0800, Tina Zhang <tina.zhang@intel.com> wrote:

> >   		if (mm->pasid < min || mm->pasid >= max)  
> Here seems not right, since the valid range is defined [min, max]. 
> Shouldn't the invalid range be:
> 		if (mm->pasid < min || mm->pasid > max)
yes it is better to be consistent even if we removed the inclusive
requirements in the previous comments.

Thanks,

Jacob
