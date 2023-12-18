Return-Path: <dmaengine+bounces-565-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D26816D31
	for <lists+dmaengine@lfdr.de>; Mon, 18 Dec 2023 13:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47AED1F23646
	for <lists+dmaengine@lfdr.de>; Mon, 18 Dec 2023 12:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B02341C6C;
	Mon, 18 Dec 2023 11:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=alatek.krakow.pl header.i=@alatek.krakow.pl header.b="gwYdAwLw"
X-Original-To: dmaengine@vger.kernel.org
Received: from helios.alatek.com.pl (helios.alatek.com.pl [85.14.123.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E8641212;
	Mon, 18 Dec 2023 11:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alatek.krakow.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alatek.krakow.pl
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id D39B22D01875;
	Mon, 18 Dec 2023 12:52:30 +0100 (CET)
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10032)
 with ESMTP id ojvRBzrblCMI; Mon, 18 Dec 2023 12:52:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id D5ADD2D01877;
	Mon, 18 Dec 2023 12:52:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 helios.alatek.com.pl D5ADD2D01877
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alatek.krakow.pl;
	s=99EE5E86-D06A-11EC-BE24-DBCCD0A148D3; t=1702900346;
	bh=pgFYSPvqKsZ76d/HoygOZjY81UNiyQPNXJuryyJ5YgI=;
	h=Message-ID:Date:MIME-Version:To:From;
	b=gwYdAwLwPzOv7TzzKPBainbIFgrssAJfXlK0vlYm3XVUL7hKnWxXpUneM0S32+uaj
	 iXnhrRD9r0ZmGqf2GNuQXfyFcjSlH4rkYnvS1CjOk/b62ZGu9E+kUkuMnAb08Pyc7u
	 TItVfQcam071NDZy8riZzR6+2LafNYX6BJxijU3oOQOZn6hHTOdz+n2k5bwOTfy+uT
	 BZAs7E0hVyTB6WdBXnpZvrcVyEohVVZEQi6KjIq67/CkGo/TVPlE1hPdKxjLMWLMvf
	 EUkH2TZj4HLZV6ixuz7rNrqiu/+/hLnuc0v+6eVqUEs5+2IJskJalBzYZtQrqxS1dU
	 c3Vz7rNTW6U1w==
X-Virus-Scanned: amavis at alatek.com.pl
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10026)
 with ESMTP id TCCewzLwpviW; Mon, 18 Dec 2023 12:52:26 +0100 (CET)
Received: from [192.168.1.103] (unknown [10.0.2.2])
	by helios.alatek.com.pl (Postfix) with ESMTPSA id A6A912D01875;
	Mon, 18 Dec 2023 12:52:26 +0100 (CET)
Message-ID: <49d892ae-5986-43c2-bdad-2ad09be298f2@alatek.krakow.pl>
Date: Mon, 18 Dec 2023 12:52:26 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/8] dmaengine: xilinx: xdma: Rework
 xdma_terminate_all()
To: Vinod Koul <vkoul@kernel.org>
Cc: lizhi.hou@amd.com, brian.xu@amd.com, raj.kumar.rampelli@amd.com,
 michal.simek@amd.com, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, miquel.raynal@bootlin.com
References: <20231208134838.49500-1-jankul@alatek.krakow.pl>
 <20231208134929.49523-5-jankul@alatek.krakow.pl> <ZXbqSQ9W/VrAA0ZE@matsya>
Content-Language: en-US
From: Jan Kuliga <jankul@alatek.krakow.pl>
In-Reply-To: <ZXbqSQ9W/VrAA0ZE@matsya>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Vinod,

Thanks for reviewing my patchset.

On 11.12.2023 11:54, Vinod Koul wrote:
> On 08-12-23, 14:49, Jan Kuliga wrote:
>> Simplify xdma_xfer_stop(). Stop the dma engine and clear its status
>> register unconditionally - just do what its name states. This change
>> also allows to call it without grabbing a lock, which minimizes
>> the total time spent with a spinlock held.
>>
>> Delete the currently processed vd.node from the vc.desc_issued list
>> prior to passing it to vchan_terminate_vdesc(). In case there's more
>> than one descriptor pending on vc.desc_issued list, calling
>> vchan_terminate_desc() results in losing the link between
>> vc.desc_issued list head and the second descriptor on the list. Doing so
>> results in resources leakege, as vchan_dma_desc_free_list() won't be
>> able to properly free memory resources attached to descriptors,
>> resulting in dma_pool_destroy() failure.
>>
>> Don't call vchan_dma_desc_free_list() from within xdma_terminate_all().
>> Move all terminated descriptors to the vc.desc_terminated list instead.
>> This allows to postpone freeing memory resources associated with
>> descriptors until the call to vchan_synchronize(), which is called from
>> xdma_synchronize() callback. This is the right way to do it -
>> xdma_terminate_all() should return as soon as possible, while freeing
>> resources (that may be time consuming in case of large number of
>> descriptors) can be done safely later.
>>
>> Fixes: 290bb5d2d1e2
>> ("dmaengine: xilinx: xdma: Add terminate_all/synchronize callbacks")
>>
>> Signed-off-by: Jan Kuliga <jankul@alatek.krakow.pl>
>> ---
>>  drivers/dma/xilinx/xdma.c | 32 ++++++++++++++++----------------
>>  1 file changed, 16 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
>> index 1bce48e5d86c..521ba2a653b6 100644
>> --- a/drivers/dma/xilinx/xdma.c
>> +++ b/drivers/dma/xilinx/xdma.c
>> @@ -379,20 +379,20 @@ static int xdma_xfer_start(struct xdma_chan *xchan)
>>   */
>>  static int xdma_xfer_stop(struct xdma_chan *xchan)
>>  {
>> -	struct virt_dma_desc *vd = vchan_next_desc(&xchan->vchan);
>> -	struct xdma_device *xdev = xchan->xdev_hdl;
>>  	int ret;
>> -
>> -	if (!vd || !xchan->busy)
>> -		return -EINVAL;
>> +	u32 val;
>> +	struct xdma_device *xdev = xchan->xdev_hdl;
>>
>>  	/* clear run stop bit to prevent any further auto-triggering */
>>  	ret = regmap_write(xdev->rmap, xchan->base + XDMA_CHAN_CONTROL_W1C,
>> -			   CHAN_CTRL_RUN_STOP);
>> +							CHAN_CTRL_RUN_STOP);
> 
> Why this change, checkpatch would tell you this is not expected
> alignment (run with strict)
Actually, it does not. I've run it like this:
$LINUX_DIR/scripts/checkpatch.pl --strict -g <commit-id>

and it produced no output related to this line. Anyway, I've already prepared v5 patchset, that conforms to your hint:
Message-Id: 20231218113904.9071-1-jankul@alatek.krakow.pl

> 
>>  	i.f (ret)
>>  		return ret;
>>
>> -	xchan->busy = false;
>> +	/* Clear the channel status register */
>> +	ret = regmap_read(xdev->rmap, xchan->base + XDMA_CHAN_STATUS_RC, &val);
>> +	if (ret)
>> +		return ret;
>>
>>  	return 0;
>>  }
>> @@ -505,25 +505,25 @@ static void xdma_issue_pending(struct dma_chan *chan)
>>  static int xdma_terminate_all(struct dma_chan *chan)
>>  {
>>  	struct xdma_chan *xdma_chan = to_xdma_chan(chan);
>> -	struct xdma_desc *desc = NULL;
>>  	struct virt_dma_desc *vd;
>>  	unsigned long flags;
>>  	LIST_HEAD(head);
>>
>> -	spin_lock_irqsave(&xdma_chan->vchan.lock, flags);
>>  	xdma_xfer_stop(xdma_chan);
>>
>> +	spin_lock_irqsave(&xdma_chan->vchan.lock, flags);
>> +
>> +	xdma_chan->busy = false;
>>  	vd = vchan_next_desc(&xdma_chan->vchan);
>> -	if (vd)
>> -		desc = to_xdma_desc(vd);
>> -	if (desc) {
>> -		dma_cookie_complete(&desc->vdesc.tx);
>> -		vchan_terminate_vdesc(&desc->vdesc);
>> +	if (vd) {
>> +		list_del(&vd->node);
>> +		dma_cookie_complete(&vd->tx);
>> +		vchan_terminate_vdesc(vd);
>>  	}
>> -
>>  	vchan_get_all_descriptors(&xdma_chan->vchan, &head);
>> +	list_splice_tail(&head, &xdma_chan->vchan.desc_terminated);
>> +
>>  	spin_unlock_irqrestore(&xdma_chan->vchan.lock, flags);
>> -	vchan_dma_desc_free_list(&xdma_chan->vchan, &head);
>>
>>  	return 0;
>>  }
>> --
>> 2.34.1
> 

Thanks,
Jan

