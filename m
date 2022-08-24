Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46F05A00A2
	for <lists+dmaengine@lfdr.de>; Wed, 24 Aug 2022 19:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238819AbiHXRpd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Aug 2022 13:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240245AbiHXRpX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 24 Aug 2022 13:45:23 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655B380EA8;
        Wed, 24 Aug 2022 10:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661363122; x=1692899122;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=j9Y4RfhJhiqAcJQ1n06sQz7TM6Rj//b03WX4pHgBo98=;
  b=j9ue4aL8JWrCWfSzhJ2ZmSrfAzm5/vQ0I3qkAAhrGtcGpBYWd+5dFkr3
   +j3LwZJcXrx5E7nmW9u5oMPw/EVw3hUAClXE/4DsKoz+eit4sJHt9lF9x
   9itO5XjzsxtaP7nGcOIr2FWROkmhdrJkEg1qDJncwBv/Pwbp7hT52XWwc
   TMps9Y12YOhjSTqWWLsIhLeDykIXLr5+6zOIJ4YIe/m0yjV7M/RAZ/DV4
   fdoufI/FcpqoOkpnd1EzqkZnP6NKHgzSAIfHxTkKb4T2WayCc5SMyRzUq
   NVHo79Ymi2sdgxUbiuN3GZXiJeHpGHzCnW1bC10BwX55sB5vHbdghrbSr
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="274422898"
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="274422898"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 10:45:22 -0700
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="678135941"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.213.178.56]) ([10.213.178.56])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 10:45:21 -0700
Message-ID: <223e5a43-95a5-da54-0ff7-c2e088a072e3@intel.com>
Date:   Wed, 24 Aug 2022 10:45:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: [PATCH v2] dmaengine: idxd: avoid deadlock in
 process_misc_interrupts()
Content-Language: en-US
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
References: <20220823162435.2099389-1-jsnitsel@redhat.com>
 <20220823163709.2102468-1-jsnitsel@redhat.com>
 <905d3feb-f75b-e91c-f3de-b69718aa5c69@intel.com>
 <20220824005435.jyexxvjxj3z7tc2f@cantor>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20220824005435.jyexxvjxj3z7tc2f@cantor>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 8/23/2022 5:54 PM, Jerry Snitselaar wrote:
> On Tue, Aug 23, 2022 at 09:46:19AM -0700, Dave Jiang wrote:
>> On 8/23/2022 9:37 AM, Jerry Snitselaar wrote:
>>> idxd_device_clear_state() now grabs the idxd->dev_lock
>>> itself, so don't grab the lock prior to calling it.
>>>
>>> This was seen in testing after dmar fault occurred on system,
>>> resulting in lockup stack traces.
>>>
>>> Cc: Fenghua Yu <fenghua.yu@intel.com>
>>> Cc: Dave Jiang <dave.jiang@intel.com>
>>> Cc: Vinod Koul <vkoul@kernel.org>
>>> Cc: dmaengine@vger.kernel.org
>>> Fixes: cf4ac3fef338 ("dmaengine: idxd: fix lockdep warning on device driver removal")
>>> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
>> Thanks Jerry!
>>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>
> I noticed another problem while looking at this. When the device ends
> up in the halted state, and needs an flr or system reset, it calls
> idxd_wqs_unmap_portal(). Then if you do a modprobe -r idxd, you hit
> the WARN_ON in devm_iounmap(), because the remove code path calls
> idxd_wq_portal_unmap(), and wq->portal is null. I'm not sure if it
> just needs a simple sanity check in drv_disable_wq() to avoid the call
> in the case that it has already been unmapped, or if more cleanup
> needs to be done, and possibly a state to differentiate between
> halted + soft reset possible, versus halted + flr or system reset
> needed.  You get multiple "Device is HALTED" messages during the
> removal as well.

Thanks!

Fenghua, can you please take a look at this when you have a chance? 
Thank you!


>
> Regards,
> Jerry
>
