Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3AA19C759
	for <lists+dmaengine@lfdr.de>; Thu,  2 Apr 2020 18:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389346AbgDBQtW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Apr 2020 12:49:22 -0400
Received: from mga01.intel.com ([192.55.52.88]:28778 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727412AbgDBQtW (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 2 Apr 2020 12:49:22 -0400
IronPort-SDR: eIVr02pNlmMzNSQ6in7g0BMWEXHV61UMjus8zwZxzAYnrnuj+YadakHeMqzpnWxv3+V0onMW0l
 fv/ZVAeNNYRg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2020 09:49:21 -0700
IronPort-SDR: PObNNV+joiE4Hjh+BJV7W7tWW6WiyLxup8D33nqlwf8vo1IUHkxPMzfc9Kv21jRJQBh+ptXRWa
 s6GXdk098uOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,336,1580803200"; 
   d="scan'208";a="284841870"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.134.85.228]) ([10.134.85.228])
  by fmsmga002.fm.intel.com with ESMTP; 02 Apr 2020 09:49:19 -0700
Subject: Re: [PATCH v2 1/2] dmaengine: ioat: fixing chunk sizing macros
 dependency
To:     "Ravich, Leonid" <Leonid.Ravich@dell.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Cc:     "lravich@gmail.com" <lravich@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Zavras, Alexios" <alexios.zavras@intel.com>,
        "Barabash, Alexander" <Alexander.Barabash@dell.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Jilayne Lovejoy <opensource@jilayne.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200402092725.15121-2-leonid.ravich@dell.com>
 <20200402163356.9029-1-leonid.ravich@dell.com>
 <accfd50c-cf70-1145-6776-e4030e7c37fc@intel.com>
 <DM6PR19MB26827AA2885E8240370A4B1098C60@DM6PR19MB2682.namprd19.prod.outlook.com>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <dd2ab4e9-2451-06fc-39c2-acd2daf52d1a@intel.com>
Date:   Thu, 2 Apr 2020 09:49:19 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <DM6PR19MB26827AA2885E8240370A4B1098C60@DM6PR19MB2682.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 4/2/2020 9:46 AM, Ravich, Leonid wrote:
> Sorry Dave ,
> sure was tested on Intel Sky Lake-E CBDMA

Thanks Leonid. Acked.

> 
> -----Original Message-----
> From: Dave Jiang <dave.jiang@intel.com>
> Sent: Thursday, April 2, 2020 7:43 PM
> To: Ravich, Leonid; dmaengine@vger.kernel.org
> Cc: lravich@gmail.com; Vinod Koul; Williams, Dan J; Greg Kroah-Hartman; Zavras, Alexios; Barabash, Alexander; Thomas Gleixner; Kate Stewart; Jilayne Lovejoy; Logan Gunthorpe; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2 1/2] dmaengine: ioat: fixing chunk sizing macros dependency
> 
> 
> [EXTERNAL EMAIL]
> 
> 
> 
> On 4/2/2020 9:33 AM, leonid.ravich@dell.com wrote:
>> From: Leonid Ravich <Leonid.Ravich@emc.com>
>>
>> prepare for changing alloc size.
>>
>> Acked-by: Dave Jiang <dave.jiang@intel.com>
>> Signed-off-by: Leonid Ravich <Leonid.Ravich@emc.com>
> 
> Hi Leonid, I haven't actually acked this patch yet, pending your answer on if this has been tested on hardware. Thanks.
> 
>> ---
>>    drivers/dma/ioat/dma.c  | 14 ++++++++------
>>    drivers/dma/ioat/dma.h  | 10 ++++++----
>>    drivers/dma/ioat/init.c |  2 +-
>>    3 files changed, 15 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/dma/ioat/dma.c b/drivers/dma/ioat/dma.c index
>> 18c011e..1e0e6c1 100644
>> --- a/drivers/dma/ioat/dma.c
>> +++ b/drivers/dma/ioat/dma.c
>> @@ -332,8 +332,8 @@ static dma_cookie_t ioat_tx_submit_unlock(struct dma_async_tx_descriptor *tx)
>>    	u8 *pos;
>>    	off_t offs;
>>    
>> -	chunk = idx / IOAT_DESCS_PER_2M;
>> -	idx &= (IOAT_DESCS_PER_2M - 1);
>> +	chunk = idx / IOAT_DESCS_PER_CHUNK;
>> +	idx &= (IOAT_DESCS_PER_CHUNK - 1);
>>    	offs = idx * IOAT_DESC_SZ;
>>    	pos = (u8 *)ioat_chan->descs[chunk].virt + offs;
>>    	phys = ioat_chan->descs[chunk].hw + offs; @@ -370,7 +370,8 @@
>> struct ioat_ring_ent **
>>    	if (!ring)
>>    		return NULL;
>>    
>> -	ioat_chan->desc_chunks = chunks = (total_descs * IOAT_DESC_SZ) / SZ_2M;
>> +	chunks = (total_descs * IOAT_DESC_SZ) / IOAT_CHUNK_SIZE;
>> +	ioat_chan->desc_chunks = chunks;
>>    
>>    	for (i = 0; i < chunks; i++) {
>>    		struct ioat_descs *descs = &ioat_chan->descs[i]; @@ -382,8 +383,9
>> @@ struct ioat_ring_ent **
>>    
>>    			for (idx = 0; idx < i; idx++) {
>>    				descs = &ioat_chan->descs[idx];
>> -				dma_free_coherent(to_dev(ioat_chan), SZ_2M,
>> -						  descs->virt, descs->hw);
>> +				dma_free_coherent(to_dev(ioat_chan),
>> +						IOAT_CHUNK_SIZE,
>> +						descs->virt, descs->hw);
>>    				descs->virt = NULL;
>>    				descs->hw = 0;
>>    			}
>> @@ -404,7 +406,7 @@ struct ioat_ring_ent **
>>    
>>    			for (idx = 0; idx < ioat_chan->desc_chunks; idx++) {
>>    				dma_free_coherent(to_dev(ioat_chan),
>> -						  SZ_2M,
>> +						  IOAT_CHUNK_SIZE,
>>    						  ioat_chan->descs[idx].virt,
>>    						  ioat_chan->descs[idx].hw);
>>    				ioat_chan->descs[idx].virt = NULL; diff --git
>> a/drivers/dma/ioat/dma.h b/drivers/dma/ioat/dma.h index
>> b8e8e0b..5216c6b 100644
>> --- a/drivers/dma/ioat/dma.h
>> +++ b/drivers/dma/ioat/dma.h
>> @@ -81,6 +81,11 @@ struct ioatdma_device {
>>    	u32 msixpba;
>>    };
>>    
>> +#define IOAT_MAX_ORDER 16
>> +#define IOAT_MAX_DESCS (1 << IOAT_MAX_ORDER) #define IOAT_CHUNK_SIZE
>> +(SZ_2M) #define IOAT_DESCS_PER_CHUNK (IOAT_CHUNK_SIZE / IOAT_DESC_SZ)
>> +
>>    struct ioat_descs {
>>    	void *virt;
>>    	dma_addr_t hw;
>> @@ -128,7 +133,7 @@ struct ioatdma_chan {
>>    	u16 produce;
>>    	struct ioat_ring_ent **ring;
>>    	spinlock_t prep_lock;
>> -	struct ioat_descs descs[2];
>> +	struct ioat_descs descs[IOAT_MAX_DESCS / IOAT_DESCS_PER_CHUNK];
>>    	int desc_chunks;
>>    	int intr_coalesce;
>>    	int prev_intr_coalesce;
>> @@ -301,9 +306,6 @@ static inline bool is_ioat_bug(unsigned long err)
>>    	return !!err;
>>    }
>>    
>> -#define IOAT_MAX_ORDER 16
>> -#define IOAT_MAX_DESCS 65536
>> -#define IOAT_DESCS_PER_2M 32768
>>    
>>    static inline u32 ioat_ring_size(struct ioatdma_chan *ioat_chan)
>>    {
>> diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c index
>> 60e9afb..58d1356 100644
>> --- a/drivers/dma/ioat/init.c
>> +++ b/drivers/dma/ioat/init.c
>> @@ -651,7 +651,7 @@ static void ioat_free_chan_resources(struct dma_chan *c)
>>    	}
>>    
>>    	for (i = 0; i < ioat_chan->desc_chunks; i++) {
>> -		dma_free_coherent(to_dev(ioat_chan), SZ_2M,
>> +		dma_free_coherent(to_dev(ioat_chan), IOAT_CHUNK_SIZE,
>>    				  ioat_chan->descs[i].virt,
>>    				  ioat_chan->descs[i].hw);
>>    		ioat_chan->descs[i].virt = NULL;
>>
