Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293535BD0E4
	for <lists+dmaengine@lfdr.de>; Mon, 19 Sep 2022 17:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiISP22 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 19 Sep 2022 11:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiISP2H (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 19 Sep 2022 11:28:07 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E3DBF53;
        Mon, 19 Sep 2022 08:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663601286; x=1695137286;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=u4l9l32AEn0lwr5hQNu6et9ZUSUu5/s1P/GSY7BqxV8=;
  b=RBr9dMYEkscYPNxREFPPOpEd1OQIgaltUJ5sZqgQyN/3GtHOWun5Ut56
   uA2izqgn1r3iC20tNj73q2z2AqxibrgmMUMrG4QscgjAx39J8qf26ZNkx
   d5A8KmXst8eblGNMk6zrOgWtVI2cIo0ElGM+2XW5cHMZqX4VRIJDhfIfi
   XN2mal5tbthxVoTECC/Pczs8Cvgd17fvS7c0MMvGNkMYqvmeNSe8ft0VO
   C08zJ6Q8njb8UeymO94K4FkCYUJk6NI84Upbluzz08sIY+zViL4+weSR8
   pDT3IlqJC+5OwIezm+gv6TxNjhl11wpZQytApV/2WNv/X1gUz8z3EZS0o
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="361168317"
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="361168317"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 08:28:05 -0700
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="569693701"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.95.27]) ([10.212.95.27])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 08:28:05 -0700
Message-ID: <ca0bb678-1ffd-42e1-4056-30c3a5b74f10@intel.com>
Date:   Mon, 19 Sep 2022 08:28:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH] dmaengine: idxd: Set workqueue state to disabled before
 trying to re-enable
Content-Language: en-US
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Fengqian Gao <fengqian.gao@intel.com>,
        "Shen, Xiaochen" <xiaochen.shen@intel.com>
References: <20220824192913.2425634-1-jsnitsel@redhat.com>
 <1417f4ce-2573-5c88-6c92-fda5c57ebceb@intel.com>
 <20220824211625.mfcyefi5yvasdt4r@cantor>
 <d0dbdd27-a890-1eea-63b5-ab6aaa27583e@intel.com>
 <f59ea139533f37991e786cd8cf4a0d591133d92c.camel@redhat.com>
 <36ecf274-7be1-f50e-8ac0-9e99bc9ef556@intel.com>
 <20220917170524.23wxvkhieroyrofd@cantor>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20220917170524.23wxvkhieroyrofd@cantor>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 9/17/2022 10:05 AM, Jerry Snitselaar wrote:
> On Wed, Aug 24, 2022 at 03:19:51PM -0700, Dave Jiang wrote:
>> On 8/24/2022 3:07 PM, Jerry Snitselaar wrote:
>>> On Wed, 2022-08-24 at 14:59 -0700, Dave Jiang wrote:
>>>> On 8/24/2022 2:16 PM, Jerry Snitselaar wrote:
>>>>> On Wed, Aug 24, 2022 at 01:29:03PM -0700, Dave Jiang wrote:
>>>>>> On 8/24/2022 12:29 PM, Jerry Snitselaar wrote:
>>>>>>> For a software reset idxd_device_reinit() is called, which will
>>>>>>> walk
>>>>>>> the device workqueues to see which ones were enabled, and try
>>>>>>> to
>>>>>>> re-enable them. It keys off wq->state being iDXD_WQ_ENABLED,
>>>>>>> but the
>>>>>>> first thing idxd_enable_wq() will do is see that the state of
>>>>>>> the
>>>>>>> workqueue is enabled, and return 0 instead of attempting to
>>>>>>> issue
>>>>>>> a command to enable the workqueue.
>>>>>>>
>>>>>>> So once a workqueue is found that needs to be re-enabled,
>>>>>>> set the state to disabled prior to calling idxd_enable_wq().
>>>>>>> This would accurately reflect the state if the enable fails
>>>>>>> as well.
>>>>>>>
>>>>>>> Cc: Fenghua Yu <fenghua.yu@intel.com>
>>>>>>> Cc: Dave Jiang <dave.jiang@intel.com>
>>>>>>> Cc: Vinod Koul <vkoul@kernel.org>
>>>>>>> Cc: dmaengine@vger.kernel.org
>>>>>>> Fixes: bfe1d56091c1 ("dmaengine: idxd: Init and probe for Intel
>>>>>>> data accelerators")
>>>>>>> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
>>>>>>> ---
>>>>>>>      drivers/dma/idxd/irq.c | 1 +
>>>>>>>      1 file changed, 1 insertion(+)
>>>>>>>
>>>>>>> diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
>>>>>>> index 743ead5ebc57..723eeb5328d6 100644
>>>>>>> --- a/drivers/dma/idxd/irq.c
>>>>>>> +++ b/drivers/dma/idxd/irq.c
>>>>>>> @@ -52,6 +52,7 @@ static void idxd_device_reinit(struct
>>>>>>> work_struct *work)
>>>>>>>                   struct idxd_wq *wq = idxd->wqs[i];
>>>>>>>                   if (wq->state == IDXD_WQ_ENABLED) {
>>>>>>> +                       wq->state = IDXD_WQ_DISABLED;
>>>>>> Might be better off to insert this line in
>>>>>> idxd_wq_disable_cleanup(). I
>>>>>> think that should put it in sane state.
>>>>> I don't think that is called in the code path that I was lookng at.
>>>>> I've been
>>>>> looking at this bit of process_misc_interrupts():
>>>>>
>>>>> halt:
>>>>>           gensts.bits = ioread32(idxd->reg_base +
>>>>> IDXD_GENSTATS_OFFSET);
>>>>>           if (gensts.state == IDXD_DEVICE_STATE_HALT) {
>>>>>                   idxd->state = IDXD_DEV_HALTED;
>>>>>                   if (gensts.reset_type ==
>>>>> IDXD_DEVICE_RESET_SOFTWARE) {
>>>>>                           /*
>>>>>                            * If we need a software reset, we will
>>>>> throw the work
>>>>>                            * on a system workqueue in order to allow
>>>>> interrupts
>>>>>                            * for the device command completions.
>>>>>                            */
>>>>>                           INIT_WORK(&idxd->work, idxd_device_reinit);
>>>>>                           queue_work(idxd->wq, &idxd->work);
>>>>>                   } else {
>>>>>                           idxd->state = IDXD_DEV_HALTED;
>>>>>                           idxd_wqs_quiesce(idxd);
>>>>>                           idxd_wqs_unmap_portal(idxd);
>>>>>                           spin_lock(&idxd->dev_lock);
>>>>>                           idxd_device_clear_state(idxd);
>>>>>                           dev_err(&idxd->pdev->dev,
>>>>>                                   "idxd halted, need %s.\n",
>>>>>                                   gensts.reset_type ==
>>>>> IDXD_DEVICE_RESET_FLR ?
>>>>>                                   "FLR" : "system reset");
>>>>>                           spin_unlock(&idxd->dev_lock);
>>>>>                           return -ENXIO;
>>>>>                   }
>>>>>           }
>>>>>
>>>>>           return 0;
>>>>> }
>>>>>
>>>>> So it sees that the device is halted, and sticks
>>>>> idxd_device_reinint() on that
>>>>> workqueue. The idxd_device_reinit() has this loop to re-enable the
>>>>> idxd wqs:
>>>> idxd_device_reinit() should called idxd_device_reset() first. And
>>>> that
>>>> should at some point call idxd_wq_disable_cleanup() and clean up the
>>>> states.
>>>>
>>>> https://elixir.bootlin.com/linux/v6.0-rc2/source/drivers/dma/idxd/irq.c#L42
>>>>
>>>> https://elixir.bootlin.com/linux/v6.0-rc2/source/drivers/dma/idxd/device.c#L725
>>>>
>>>> https://elixir.bootlin.com/linux/v6.0-rc2/source/drivers/dma/idxd/device.c#L711
>>>>
>>>> https://elixir.bootlin.com/linux/v6.0-rc2/source/drivers/dma/idxd/device.c#L376
>>>>
>>>> So if we stick the wq state reset in there, it should show up as
>>>> "disabled" by the time we try to enable the WQs again. Does that look
>>>> reasonable?
>>>>
>>> Ah, yeah I see that now. So, if it does set the state to disabled in
>>> idxd_wq_disable_cleanup(), does it have another means to track which
>>> wqs need to be re-enabled for that loop that happens after the
>>> idxd_device_reset() call?
>> Oh I see what you mean... So we can either do what you did or create a mask
>> and mark the WQ that are "enabled" before reset. Maybe that's cleaner rather
>> than relying on the side effect of the WQ state isn't cleared? Thoughts?
>>
> Circling back to this. Since max_wqs could theoretically go up to 2^8, I guess
> this would need to be done with the bitmap_* functions?

Hi Jerry,

I wouldn't say never but I doubt any time soon for 2^8. DSA 1.0 has 8 
WQs, and 2.0 (spec just went public) has 16. But yes we can use bitmap 
to be future proof. Are you currently working on a fix for this? Just 
don't want to duplicate effort if you already have something going. 
Thank you!


>
> Regards,
> Jerry
>
>>>>>           for (i = 0; i < idxd->max_wqs; i++) {
>>>>>                   struct idxd_wq *wq = idxd->wqs[i];
>>>>>
>>>>>                   if (wq->state == IDXD_WQ_ENABLED) {
>>>>>                           wq->state = IDXD_WQ_DISABLED;
>>>>>                           rc = idxd_wq_enable(wq);
>>>>>                           if (rc < 0) {
>>>>>                                   dev_warn(dev, "Unable to re-enable
>>>>> wq %s\n",
>>>>>                                            dev_name(wq_confdev(wq)));
>>>>>                           }
>>>>>                   }
>>>>>           }
>>>>>
>>>>> Once you go into idxd_wq_enable() though you get this check at the
>>>>> beginning:
>>>>>
>>>>>           if (wq->state == IDXD_WQ_ENABLED) {
>>>>>                   dev_dbg(dev, "WQ %d already enabled\n", wq->id);
>>>>>                   return 0;
>>>>>           }
>>>>>
>>>>> So IIUC it sees the device is halted, goes to reset it, figures out
>>>>> a wq
>>>>> should be re-enabled, calls idxd_wq_enable() which hits the check,
>>>>> returns
>>>>> 0 and the wq is never really re-enabled, though it will still have
>>>>> wq state
>>>>> set to IDXD_WQ_ENABLED.
>>>>>
>>>>> Or am I missing something?
>>>>>
>>>>> Regards,
>>>>> Jerry
>>>>>
>>>>>>>                           rc = idxd_wq_enable(wq);
>>>>>>>                           if (rc < 0) {
>>>>>>>                                   dev_warn(dev, "Unable to re-
>>>>>>> enable wq %s\n",
