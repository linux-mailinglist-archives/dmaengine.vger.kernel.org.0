Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51916C20E2
	for <lists+dmaengine@lfdr.de>; Mon, 20 Mar 2023 20:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjCTTIK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 Mar 2023 15:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjCTTHr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 20 Mar 2023 15:07:47 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0EA2B613;
        Mon, 20 Mar 2023 12:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679338805; x=1710874805;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RVUBV13vg50kKjzvJu8eWgLIZUCC4rAeEXycCUsrUFE=;
  b=Cb1Rv6PhQG0o1qfeF7Hq2yt3uTkzi8CTMrWas0m5Bpu7EIfGv9P65yk3
   NORI50/RE2o4eflb8ems3kQBqL36MuO/hC4I5jqbRjE9x/KbTElHS1bqF
   238u7JSR/hE3vEAsnJsAWg48YBu8VFCKnbU81+wvfBG4gT/FReIO0AyT+
   ghKaIQAJu1AN8OddwzgtwxZSJ+OoYqZ6zxTZlkHizZ7XfQexeRd5zhI8S
   tO8/ejPd2m5XZ22uMudOyb1Znlqr9WsymJUAOZpRUC6HUqRRvJqSgx6K4
   wI/sbHzvVn1T/OiK9043KuRXCiNCBRBprxeWYv/f9D7pslmpWAUuDJ/HK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="338777323"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="338777323"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 11:58:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="855346805"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="855346805"
Received: from vrchili-mobl2.amr.corp.intel.com (HELO [10.209.117.85]) ([10.209.117.85])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 11:58:15 -0700
Message-ID: <b1a380ad-50b4-4a00-2480-ac4d1542c71f@intel.com>
Date:   Mon, 20 Mar 2023 11:58:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v7 6/7] iommu/ioasid: Rename INVALID_IOASID
Content-Language: en-US
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        X86 Kernel <x86@kernel.org>, bp@alien8.de,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, corbet@lwn.net,
        vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
References: <20230320185910.2643260-1-jacob.jun.pan@linux.intel.com>
 <20230320185910.2643260-7-jacob.jun.pan@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230320185910.2643260-7-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 3/20/23 11:59, Jacob Pan wrote:
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -40,7 +40,10 @@
>  #include <linux/io.h>
>  #include <linux/hardirq.h>
>  #include <linux/atomic.h>
> -#include <linux/ioasid.h>
> +
> +#ifdef CONFIG_IOMMU_SVA
> +#include <linux/iommu.h>
> +#endif

What's the deal with the #ifdef'd #include?

What's the harm of just making it unconditional?

