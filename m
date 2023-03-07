Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89DF56AE570
	for <lists+dmaengine@lfdr.de>; Tue,  7 Mar 2023 16:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjCGPyS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Mar 2023 10:54:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjCGPyQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Mar 2023 10:54:16 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309586BDCC;
        Tue,  7 Mar 2023 07:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678204452; x=1709740452;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nVrmjUNJ4dp+HMX33cZyqZT/vBmmZVro42lOw0Gxzn4=;
  b=AfKGxlaBfnCAwW177/tGq9RhBxiwEZI601JYVGSTlzb8REnCC4QyFPJh
   cg+iLwJhIw1Ey2DftAJBKo3zdcIqzx8+qAolUaYm2/wafdpcc/CsSZ4eP
   wXkXwNcWv/FqjtfRcO6untuNJEGc0ISfVAMCY45+JLaj1UY7SoECyTxvc
   0bOMBJOORsVZgc/WhJU6CgY2z1Px2qW1UIXZWbRCOuTK+6aheIO9j+Kr+
   FihuoJmtgnZWMBVScw6wpk7L0qrYYGvgu4V/22+qHP1ciSerfKwp9JjBx
   0KZpF+VURv8hPFBtfnWaHKzeO7qSxYNs/jnG7OqG/yRZ8BJefLGF25N3L
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="333356205"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="333356205"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 07:54:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="765676186"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="765676186"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.116.173]) ([10.212.116.173])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 07:54:03 -0800
Message-ID: <3a39812e-62da-377c-f430-dd6c1eb473e2@intel.com>
Date:   Tue, 7 Mar 2023 08:54:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH 00/16] crypto: Add Intel Analytics Accelerator (IAA)
 crypto compression driver
Content-Language: en-US
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Cc:     davem@davemloft.net, fenghua.yu@intel.com, vkoul@kernel.org,
        tony.luck@intel.com, wajdi.k.feghali@intel.com,
        james.guilford@intel.com, kanchana.p.sridhar@intel.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        dmaengine@vger.kernel.org
References: <20230306185226.26483-1-tom.zanussi@linux.intel.com>
 <ZAa7lS/eS1wWuXYp@gondor.apana.org.au>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <ZAa7lS/eS1wWuXYp@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 3/6/23 9:20 PM, Herbert Xu wrote:
> On Mon, Mar 06, 2023 at 12:52:10PM -0600, Tom Zanussi wrote:
>> This series adds Linux crypto algorithm support for Intel® In-memory
>> Analytics Accelerator (Intel IAA) [1] hardware compression and
>> decompression, which is available on Sapphire Rapids systems.
> 
> I haven't reviewed the patches yet, but could you please create
> a drivers/crypto/intel directory and put this driver in it?

Hi Herbert, does this mean drivers/crypto/qat should now move to 
drivers/crypto/intel/qat?

> 
> Thanks,
