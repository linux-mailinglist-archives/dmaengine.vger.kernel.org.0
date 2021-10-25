Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDDE2439DD0
	for <lists+dmaengine@lfdr.de>; Mon, 25 Oct 2021 19:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234368AbhJYRpo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Oct 2021 13:45:44 -0400
Received: from mga12.intel.com ([192.55.52.136]:63185 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234141AbhJYRpV (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 25 Oct 2021 13:45:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10148"; a="209807106"
X-IronPort-AV: E=Sophos;i="5.87,181,1631602800"; 
   d="scan'208";a="209807106"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 10:20:00 -0700
X-IronPort-AV: E=Sophos;i="5.87,181,1631602800"; 
   d="scan'208";a="446325683"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.251.129.126]) ([10.251.129.126])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 10:19:59 -0700
Message-ID: <c8a22e39-dcb1-31bb-32a4-04dc8f035b29@intel.com>
Date:   Mon, 25 Oct 2021 10:19:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 4/7] dmaengine: idxd: add helper for per interrupt handle
 drain
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kevin Tian <kevin.tian@intel.com>, dmaengine@vger.kernel.org
References: <163474864017.2608004.10983485368237365990.stgit@djiang5-desk3.ch.intel.com>
 <163474883845.2608004.9330596081850512248.stgit@djiang5-desk3.ch.intel.com>
 <YXY7Zy/g/jrSDuFD@matsya>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <YXY7Zy/g/jrSDuFD@matsya>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 10/24/2021 10:06 PM, Vinod Koul wrote:
> On 20-10-21, 09:53, Dave Jiang wrote:
>> The helper is called at the completion of the interrupt handle refresh
>> event. It issues drain descriptors to each of the wq with associated
>> interrupt handle. The drain descriptor will have interrupt request set but
>> without completion record. This will ensure all descriptors with incorrect
>> interrupt completion handle get drained and a completion interrupt is
>> triggered for the guest driver to process them.
>>
>> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   drivers/dma/idxd/irq.c |   41 +++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 41 insertions(+)
>>
>> diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
>> index 573a2f6d0f7f..8bca0ed2d23c 100644
>> --- a/drivers/dma/idxd/irq.c
>> +++ b/drivers/dma/idxd/irq.c
>> @@ -55,6 +55,47 @@ static void idxd_device_reinit(struct work_struct *work)
>>   	idxd_device_clear_state(idxd);
>>   }
>>   
>> +/*
>> + * The function sends a drain descriptor for the interrupt handle. The drain ensures
>> + * all descriptors with this interrupt handle is flushed and the interrupt
>> + * will allow the cleanup of the outstanding descriptors.
>> + */
>> +static void idxd_int_handle_revoke_drain(struct idxd_irq_entry *ie)
>> +{
>> +	struct idxd_wq *wq = ie->wq;
>> +	struct idxd_device *idxd = ie->idxd;
>> +	struct device *dev = &idxd->pdev->dev;
>> +	struct dsa_hw_desc desc;
>> +	void __iomem *portal;
>> +	int rc;
>> +
>> +	memset(&desc, 0, sizeof(desc));
> declare and init it and avoid the memset:
>          struct dsa_hw_desc desc = {};

Thanks. Will fix.


>
>> +
>> +	/* Issue a simple drain operation with interrupt but no completion record */
>> +	desc.flags = IDXD_OP_FLAG_RCI;
>> +	desc.opcode = DSA_OPCODE_DRAIN;
>> +	desc.priv = 1;
>> +
>> +	if (ie->pasid != INVALID_IOASID)
>> +		desc.pasid = ie->pasid;
>> +	desc.int_handle = ie->int_handle;
>> +	portal = idxd_wq_portal_addr(wq);
>> +
>> +	/*
>> +	 * The wmb() makes sure that the descriptor is all there before we
>> +	 * issue.
>> +	 */
>> +	wmb();
>> +	if (wq_dedicated(wq)) {
>> +		iosubmit_cmds512(portal, &desc, 1);
>> +	} else {
>> +		rc = enqcmds(portal, &desc);
>> +		/* This should not fail unless hardware failed. */
>> +		if (rc < 0)
>> +			dev_warn(dev, "Failed to submit drain desc on wq %d\n", wq->id);
>> +	}
>> +}
>> +
>>   static int process_misc_interrupts(struct idxd_device *idxd, u32 cause)
>>   {
>>   	struct device *dev = &idxd->pdev->dev;
>>
