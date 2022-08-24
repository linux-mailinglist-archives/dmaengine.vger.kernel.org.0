Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5AC95A03DB
	for <lists+dmaengine@lfdr.de>; Thu, 25 Aug 2022 00:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiHXWT4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Aug 2022 18:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiHXWTz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 24 Aug 2022 18:19:55 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1192C659;
        Wed, 24 Aug 2022 15:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661379594; x=1692915594;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CEeCT5EogFCflOx9haEXMqcu4QZ0Np90fex1l12akU0=;
  b=LoFks9NY76xi724/IFaqqoDQQJ6N7QcA5hNwh/j8K7Nd+QPEPJVYYQYI
   XQnTVdYh649MUpuKVTXTVtHZE2AtWhC9vl/4Wz8EPNBUBvZy2UD8dLcq3
   GIbumtPB0sVKEe0j0CMCHhjU2ZoXyigqytohudBwbMEKPmdOqKVmyKIpc
   nje8XeKjlZWQcnYfJt5v+Q7SsXyYQZcbXQviahIg1PHPEQ2abLwa6+RAJ
   JdVLB52FK+hcuI4ZkCItX65ameH+SoXbYOZiSeDiZc22BlGsf5zz49E/W
   kDVDpHVs13ILDkj8NR4xQMgOSnkYlRXWL6iIKVhGO1MGVlL6VQ5ivRdBT
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="281061219"
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="281061219"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 15:19:53 -0700
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="678217251"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.213.178.56]) ([10.213.178.56])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 15:19:52 -0700
Message-ID: <36ecf274-7be1-f50e-8ac0-9e99bc9ef556@intel.com>
Date:   Wed, 24 Aug 2022 15:19:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: [PATCH] dmaengine: idxd: Set workqueue state to disabled before
 trying to re-enable
Content-Language: en-US
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
References: <20220824192913.2425634-1-jsnitsel@redhat.com>
 <1417f4ce-2573-5c88-6c92-fda5c57ebceb@intel.com>
 <20220824211625.mfcyefi5yvasdt4r@cantor>
 <d0dbdd27-a890-1eea-63b5-ab6aaa27583e@intel.com>
 <f59ea139533f37991e786cd8cf4a0d591133d92c.camel@redhat.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <f59ea139533f37991e786cd8cf4a0d591133d92c.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 8/24/2022 3:07 PM, Jerry Snitselaar wrote:
> On Wed, 2022-08-24 at 14:59 -0700, Dave Jiang wrote:
>> On 8/24/2022 2:16 PM, Jerry Snitselaar wrote:
>>> On Wed, Aug 24, 2022 at 01:29:03PM -0700, Dave Jiang wrote:
>>>> On 8/24/2022 12:29 PM, Jerry Snitselaar wrote:
>>>>> For a software reset idxd_device_reinit() is called, which will
>>>>> walk
>>>>> the device workqueues to see which ones were enabled, and try
>>>>> to
>>>>> re-enable them. It keys off wq->state being iDXD_WQ_ENABLED,
>>>>> but the
>>>>> first thing idxd_enable_wq() will do is see that the state of
>>>>> the
>>>>> workqueue is enabled, and return 0 instead of attempting to
>>>>> issue
>>>>> a command to enable the workqueue.
>>>>>
>>>>> So once a workqueue is found that needs to be re-enabled,
>>>>> set the state to disabled prior to calling idxd_enable_wq().
>>>>> This would accurately reflect the state if the enable fails
>>>>> as well.
>>>>>
>>>>> Cc: Fenghua Yu <fenghua.yu@intel.com>
>>>>> Cc: Dave Jiang <dave.jiang@intel.com>
>>>>> Cc: Vinod Koul <vkoul@kernel.org>
>>>>> Cc: dmaengine@vger.kernel.org
>>>>> Fixes: bfe1d56091c1 ("dmaengine: idxd: Init and probe for Intel
>>>>> data accelerators")
>>>>> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
>>>>> ---
>>>>>     drivers/dma/idxd/irq.c | 1 +
>>>>>     1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
>>>>> index 743ead5ebc57..723eeb5328d6 100644
>>>>> --- a/drivers/dma/idxd/irq.c
>>>>> +++ b/drivers/dma/idxd/irq.c
>>>>> @@ -52,6 +52,7 @@ static void idxd_device_reinit(struct
>>>>> work_struct *work)
>>>>>                  struct idxd_wq *wq = idxd->wqs[i];
>>>>>                  if (wq->state == IDXD_WQ_ENABLED) {
>>>>> +                       wq->state = IDXD_WQ_DISABLED;
>>>> Might be better off to insert this line in
>>>> idxd_wq_disable_cleanup(). I
>>>> think that should put it in sane state.
>>> I don't think that is called in the code path that I was lookng at.
>>> I've been
>>> looking at this bit of process_misc_interrupts():
>>>
>>> halt:
>>>          gensts.bits = ioread32(idxd->reg_base +
>>> IDXD_GENSTATS_OFFSET);
>>>          if (gensts.state == IDXD_DEVICE_STATE_HALT) {
>>>                  idxd->state = IDXD_DEV_HALTED;
>>>                  if (gensts.reset_type ==
>>> IDXD_DEVICE_RESET_SOFTWARE) {
>>>                          /*
>>>                           * If we need a software reset, we will
>>> throw the work
>>>                           * on a system workqueue in order to allow
>>> interrupts
>>>                           * for the device command completions.
>>>                           */
>>>                          INIT_WORK(&idxd->work, idxd_device_reinit);
>>>                          queue_work(idxd->wq, &idxd->work);
>>>                  } else {
>>>                          idxd->state = IDXD_DEV_HALTED;
>>>                          idxd_wqs_quiesce(idxd);
>>>                          idxd_wqs_unmap_portal(idxd);
>>>                          spin_lock(&idxd->dev_lock);
>>>                          idxd_device_clear_state(idxd);
>>>                          dev_err(&idxd->pdev->dev,
>>>                                  "idxd halted, need %s.\n",
>>>                                  gensts.reset_type ==
>>> IDXD_DEVICE_RESET_FLR ?
>>>                                  "FLR" : "system reset");
>>>                          spin_unlock(&idxd->dev_lock);
>>>                          return -ENXIO;
>>>                  }
>>>          }
>>>
>>>          return 0;
>>> }
>>>
>>> So it sees that the device is halted, and sticks
>>> idxd_device_reinint() on that
>>> workqueue. The idxd_device_reinit() has this loop to re-enable the
>>> idxd wqs:
>> idxd_device_reinit() should called idxd_device_reset() first. And
>> that
>> should at some point call idxd_wq_disable_cleanup() and clean up the
>> states.
>>
>> https://elixir.bootlin.com/linux/v6.0-rc2/source/drivers/dma/idxd/irq.c#L42
>>
>> https://elixir.bootlin.com/linux/v6.0-rc2/source/drivers/dma/idxd/device.c#L725
>>
>> https://elixir.bootlin.com/linux/v6.0-rc2/source/drivers/dma/idxd/device.c#L711
>>
>> https://elixir.bootlin.com/linux/v6.0-rc2/source/drivers/dma/idxd/device.c#L376
>>
>> So if we stick the wq state reset in there, it should show up as
>> "disabled" by the time we try to enable the WQs again. Does that look
>> reasonable?
>>
> Ah, yeah I see that now. So, if it does set the state to disabled in
> idxd_wq_disable_cleanup(), does it have another means to track which
> wqs need to be re-enabled for that loop that happens after the
> idxd_device_reset() call?

Oh I see what you mean... So we can either do what you did or create a 
mask and mark the WQ that are "enabled" before reset. Maybe that's 
cleaner rather than relying on the side effect of the WQ state isn't 
cleared? Thoughts?


>
>>>          for (i = 0; i < idxd->max_wqs; i++) {
>>>                  struct idxd_wq *wq = idxd->wqs[i];
>>>
>>>                  if (wq->state == IDXD_WQ_ENABLED) {
>>>                          wq->state = IDXD_WQ_DISABLED;
>>>                          rc = idxd_wq_enable(wq);
>>>                          if (rc < 0) {
>>>                                  dev_warn(dev, "Unable to re-enable
>>> wq %s\n",
>>>                                           dev_name(wq_confdev(wq)));
>>>                          }
>>>                  }
>>>          }
>>>
>>> Once you go into idxd_wq_enable() though you get this check at the
>>> beginning:
>>>
>>>          if (wq->state == IDXD_WQ_ENABLED) {
>>>                  dev_dbg(dev, "WQ %d already enabled\n", wq->id);
>>>                  return 0;
>>>          }
>>>
>>> So IIUC it sees the device is halted, goes to reset it, figures out
>>> a wq
>>> should be re-enabled, calls idxd_wq_enable() which hits the check,
>>> returns
>>> 0 and the wq is never really re-enabled, though it will still have
>>> wq state
>>> set to IDXD_WQ_ENABLED.
>>>
>>> Or am I missing something?
>>>
>>> Regards,
>>> Jerry
>>>
>>>>>                          rc = idxd_wq_enable(wq);
>>>>>                          if (rc < 0) {
>>>>>                                  dev_warn(dev, "Unable to re-
>>>>> enable wq %s\n",
