Return-Path: <dmaengine+bounces-5273-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C126AC66F6
	for <lists+dmaengine@lfdr.de>; Wed, 28 May 2025 12:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E0D517E159
	for <lists+dmaengine@lfdr.de>; Wed, 28 May 2025 10:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFE2279323;
	Wed, 28 May 2025 10:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xLWfTKqK"
X-Original-To: dmaengine@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0747278E44;
	Wed, 28 May 2025 10:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748428174; cv=none; b=PC4aFjGckMJ/HCcIQ84yWrE2uK503rNEf+VeHmwnz0zeaNDulJ/plNVRB7h9qbyzJPjn2D2hysVbV0cu+0yujmKIzkJW6BRmbSSFEAzeZKUHk4h8UvBZ90ALlGRtNNV+9OkdCpDjdCGfsxjB6evDBFSCzb5lnx8wG+EZLLu6ssU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748428174; c=relaxed/simple;
	bh=h+29phBmhlh1+LUraWLSuUdwRFKJoxTWtUu/2ITtjhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Gw8F83p0q62lTWINyKr6it3pFLYhTwB5lXHvBLeyxwWuL+C/7wsVvL9MSDDgYbC1IuAj7Yra+q/XrnWlD/MvMvWt4YO5PKg5NSx4oRc5ByKGXcwTFOKH19k8hohbLINj5c3jIdCIhRPkh8wLgLXbVWEg0BHTEnInx8I6stLec/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=xLWfTKqK; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 54SATMNi3236486;
	Wed, 28 May 2025 05:29:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1748428162;
	bh=m8AmUS6TNrYkLRwZxzaG8NF3Ct7s6HtxqfyDKxPFrLc=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=xLWfTKqKreLX83E7Sv7bJ60G/xqoWyLC028ZcbJwEzPTY9A76Glyl+04Mo3u9HbH1
	 fhFr4Ics7qmR+WKvc3GD3NzfP8/b04tuoFeKvVIaqXCTx6TYm1Wc656bquRb5CSVwS
	 29Mvkih+z9J4SHMT9dejzfRlcG3y6UKghjkSb89g=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 54SATM8Q3369282
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 28 May 2025 05:29:22 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 May 2025 05:29:22 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 May 2025 05:29:22 -0500
Received: from [172.24.30.41] (lt2k2yfk3.dhcp.ti.com [172.24.30.41])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 54SATGi7013764;
	Wed, 28 May 2025 05:29:17 -0500
Message-ID: <110b1fb3-da88-4b38-babf-eb0e375100a6@ti.com>
Date: Wed, 28 May 2025 15:59:16 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] drivers: dma: ti: Refactor TI K3 UDMA driver
To: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>,
        <vkoul@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <praneeth@ti.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
        <a-chavda@ti.com>
References: <20250428072032.946008-1-s-adivi@ti.com>
 <20250428072032.946008-4-s-adivi@ti.com>
 <e823a43e-20a8-4142-875f-a3575cbb0d0b@gmail.com>
Content-Language: en-US
From: "Adivi, Sai Sree Kartheek" <s-adivi@ti.com>
In-Reply-To: <e823a43e-20a8-4142-875f-a3575cbb0d0b@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 5/9/2025 7:55 PM, Péter Ujfalusi wrote:
> Hi,
> 
> On 28/04/2025 10:20, Sai Sree Kartheek Adivi wrote:
>> Refactors and split the driver into common and device
>> specific parts. There are no functional changes.
>>
>> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
>> ---
>>   drivers/dma/ti/Makefile         |    2 +-
>>   drivers/dma/ti/k3-udma-common.c | 2909 ++++++++++++++++++++++++
>>   drivers/dma/ti/k3-udma.c        | 3751 ++-----------------------------
> 
> I'm affraid you do need to break this one up a bit. It might be doing it
> correctly, but it is impossible to check with the churn, like ....
noted. I'm working on splitting this. Will post a v2.

> 
>>   drivers/dma/ti/k3-udma.h        |  548 ++++-
>>   4 files changed, 3700 insertions(+), 3510 deletions(-)
>>   create mode 100644 drivers/dma/ti/k3-udma-common.c
> 
> ...
> 
>> -static bool udma_is_chan_running(struct udma_chan *uc)
>> -{
>> -	u32 trt_ctl = 0;
>> -	u32 rrt_ctl = 0;
>> -
>> -	if (uc->tchan)
>> -		trt_ctl = udma_tchanrt_read(uc, UDMA_CHAN_RT_CTL_REG);
>> -	if (uc->rchan)
>> -		rrt_ctl = udma_rchanrt_read(uc, UDMA_CHAN_RT_CTL_REG);
>> -
>> -	if (trt_ctl & UDMA_CHAN_RT_CTL_EN || rrt_ctl & UDMA_CHAN_RT_CTL_EN)
>> -		return true;
>> -
>> -	return false;
>> -}
>> -
>>   static bool udma_is_chan_paused(struct udma_chan *uc)
>>   {
>>   	u32 val, pause_mask;
>> @@ -643,189 +88,73 @@ static bool udma_is_chan_paused(struct udma_chan *uc)
>>   	return false;
>>   }
>>   
>> -static inline dma_addr_t udma_get_rx_flush_hwdesc_paddr(struct udma_chan *uc)
>> +static void udma_decrement_byte_counters(struct udma_chan *uc, u32 val)
> 
> 
> These sort of diffs.
> 
>>   {
>> -	return uc->ud->rx_flush.hwdescs[uc->config.pkt_mode].cppi5_desc_paddr;
>> +	if (uc->desc->dir == DMA_DEV_TO_MEM) {
>> +		udma_rchanrt_write(uc, UDMA_CHAN_RT_BCNT_REG, val);
>> +		udma_rchanrt_write(uc, UDMA_CHAN_RT_SBCNT_REG, val);
>> +		if (uc->config.ep_type != PSIL_EP_NATIVE)
>> +			udma_rchanrt_write(uc, UDMA_CHAN_RT_PEER_BCNT_REG, val);
>> +	} else {
>> +		udma_tchanrt_write(uc, UDMA_CHAN_RT_BCNT_REG, val);
>> +		udma_tchanrt_write(uc, UDMA_CHAN_RT_SBCNT_REG, val);
>> +		if (!uc->bchan && uc->config.ep_type != PSIL_EP_NATIVE)
>> +			udma_tchanrt_write(uc, UDMA_CHAN_RT_PEER_BCNT_REG, val);
>> +	}
>>   }
>>   
>> -static int udma_push_to_ring(struct udma_chan *uc, int idx)
>> +static void udma_reset_counters(struct udma_chan *uc)
>>   {
> 
> ...
> 
>> +struct udma_dev {
>> +	struct dma_device ddev;
>> +	struct device *dev;
>> +	void __iomem *mmrs[MMR_LAST];
>> +	const struct udma_match_data *match_data;
>> +	const struct udma_soc_data *soc_data;
>> +
>> +	struct udma_tpl bchan_tpl;
>> +	struct udma_tpl tchan_tpl;
>> +	struct udma_tpl rchan_tpl;
>> +
>> +	size_t desc_align; /* alignment to use for descriptors */
>> +
>> +	struct udma_tisci_rm tisci_rm;
>> +
>> +	struct k3_ringacc *ringacc;
>> +
>> +	struct work_struct purge_work;
>> +	struct list_head desc_to_purge;
>> +	spinlock_t lock;
>> +
>> +	struct udma_rx_flush rx_flush;
>> +
>> +	int bchan_cnt;
>> +	int tchan_cnt;
>> +	int echan_cnt;
>> +	int rchan_cnt;
>> +	int rflow_cnt;
>> +	int tflow_cnt;
>> +	unsigned long *bchan_map;
>> +	unsigned long *tchan_map;
>> +	unsigned long *rchan_map;
>> +	unsigned long *rflow_gp_map;
>> +	unsigned long *rflow_gp_map_allocated;
>> +	unsigned long *rflow_in_use;
>> +	unsigned long *tflow_map;
>> +
>> +	struct udma_bchan *bchans;
>> +	struct udma_tchan *tchans;
>> +	struct udma_rchan *rchans;
>> +	struct udma_rflow *rflows;
>> +
>> +	struct udma_chan *channels;
>> +	u32 psil_base;
>> +	u32 atype;
>> +	u32 asel;
>> +
>> +	int (*udma_start)(struct udma_chan *uc);
>> +	int (*udma_stop)(struct udma_chan *uc);
>> +	int (*udma_reset_chan)(struct udma_chan *uc, bool hard);
>> +	bool (*udma_is_desc_really_done)(struct udma_chan *uc, struct udma_desc *d);
>> +	void (*udma_decrement_byte_counters)(struct udma_chan *uc, u32 val);
> 
> You can drop the udma_ prefix, it is clear that they are for udma..
> 
>> +};


