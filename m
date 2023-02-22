Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875A169F754
	for <lists+dmaengine@lfdr.de>; Wed, 22 Feb 2023 16:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbjBVPE0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Feb 2023 10:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbjBVPEZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Feb 2023 10:04:25 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6140F4695
        for <dmaengine@vger.kernel.org>; Wed, 22 Feb 2023 07:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677078264; x=1708614264;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RqydCxBbJmud4IDXB+UVMwPwoqB7FQyoajz+nE/4wlQ=;
  b=RBrRQMAXrOcU5R29l/7B2zSDjkeBkFTR3vX/iFwDGVJDGoN9nkiU+w8O
   U/2ENecYW6IgI/3erfs0otXPz7vEPToNkpWMRovyRLxuPXY60SlBdtmTk
   zYheFY8IjAeB0Sg92kuYJ7u1Ct5QfajzPvozIUoO24S/mHvu8+vjig+Yn
   5p67IUqZt6W+RQsHfpvveY/OZ3OSCdSP9vYmUL6CEcObhWE+lTF6D10Ey
   E1t+2IIJeuF3D426uenq6/fJIiLqd8BhSDKvhcLQ8IDnYGWOj5RsVnxMB
   d7/QWVeqkALNt+mtFpCigMtGiI79yP2H2CG/3myNelfPdJU3ALW5zRX+Q
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="335143049"
X-IronPort-AV: E=Sophos;i="5.97,319,1669104000"; 
   d="scan'208";a="335143049"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2023 07:03:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="649589850"
X-IronPort-AV: E=Sophos;i="5.97,319,1669104000"; 
   d="scan'208";a="649589850"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 22 Feb 2023 07:03:53 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pUqet-00ASlV-33;
        Wed, 22 Feb 2023 17:03:51 +0200
Date:   Wed, 22 Feb 2023 17:03:51 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     ARM <armkeil9@gmail.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: DMA Query
Message-ID: <Y/Yu13Sp8085ddtV@smile.fi.intel.com>
References: <CA+Td+pvxyC9GCTroD74uBaTsou5spzw-R642n2Unc1CAKy1ECA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+Td+pvxyC9GCTroD74uBaTsou5spzw-R642n2Unc1CAKy1ECA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Feb 22, 2023 at 02:50:14PM +0530, ARM wrote:
> Hello I am vijay,
> Iam using two separate axi dma channels connected to the 2 ddr's,so i want
> to start(trigger) the both dma channels at ta time in petalinux..

I believe in DMA engine mailing list (Cc'ed) you may ask for help.
You need to formulate your question better, though.

-- 
With Best Regards,
Andy Shevchenko


