Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B0A6A8341
	for <lists+dmaengine@lfdr.de>; Thu,  2 Mar 2023 14:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjCBNH0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Mar 2023 08:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjCBNHY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 2 Mar 2023 08:07:24 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4834D3D0AC;
        Thu,  2 Mar 2023 05:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677762435; x=1709298435;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DRzuInPRniRNKBDiqDiQiPwsC6T8LD9EoJ4P/cy5hX0=;
  b=iv8V4hAiUI6RPw6E+zvADlIafiK7FcVbZ5hRHHP0M+uvfoXLPtSGXAkW
   br1bkOvphpdUG+3duqPBWg98ldLYnSRPMsqp5rfcdGXK3bHnshAvpMZpS
   +U3NrPlw8uhK+o2NHNsdsNnWOfO157yzSY1qawk5FMJuc4/i3bL7Jhvm0
   K8tv68olIR75j6qam47EUb+MdSG1fgjbzZAuMAGOYTBtVf/EmWypVr/iA
   ZQtU2faNVt2bzvhhBdUDmWtux6SDgTx9obz23pGsLXfDYbV2ceoHDpJst
   tEs2NOsLE7n76fXdr+cCtzlOf+UYT81Vdwxfi3oE9YOeYobklGFO03BRR
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="314376878"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="314376878"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 05:07:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="739071608"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="739071608"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.214.218]) ([10.254.214.218])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 05:07:08 -0800
Message-ID: <8b4c5311-016f-68e3-c796-5060042e062e@linux.intel.com>
Date:   Thu, 2 Mar 2023 21:07:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Cc:     baolu.lu@linux.intel.com, Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v4 5/6] iommu/ioasid: Rename INVALID_IOASID
Content-Language: en-US
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        X86 Kernel <x86@kernel.org>, bp@alien8.de,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, corbet@lwn.net,
        vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20230301235646.2692846-1-jacob.jun.pan@linux.intel.com>
 <20230301235646.2692846-6-jacob.jun.pan@linux.intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230301235646.2692846-6-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2023/3/2 7:56, Jacob Pan wrote:
> INVALID_IOASID and IOMMU_PASID_INVALID are duplicated. Rename
> INVALID_IOASID and consolidate since we are moving away from IOASID
> infrastructure.
> 
> Reviewed-by: Dave Jiang<dave.jiang@intel.com>
> Reviewed-by: Jason Gunthorpe<jgg@nvidia.com>
> Signed-off-by: Jacob Pan<jacob.jun.pan@linux.intel.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
