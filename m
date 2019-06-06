Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72E7E373BF
	for <lists+dmaengine@lfdr.de>; Thu,  6 Jun 2019 14:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbfFFMEf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 6 Jun 2019 08:04:35 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:51964 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728561AbfFFMEf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 6 Jun 2019 08:04:35 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x56C4Q8r021326;
        Thu, 6 Jun 2019 07:04:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559822666;
        bh=AvzxyZQyViAqtwQYq7pnaktuRRb4B8pnvEPR+rdnJvU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Q8uBqHnU3UExbGChb9DO4sjnnhugmJsFrBP9iCTlHMLDf+xbcSW6AE99IIiCiqDJF
         Q9S3YKLmZfzTaVwlDUpPnzpF3UlZaqnM1sXs8nwWQdT/D+pe7ihHLHIDcbkfIGSrt2
         gdlF0IQQDu+iHtutHyDFYkRAKPN6moljaKzPs/Lo=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x56C4QpG010887
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 6 Jun 2019 07:04:26 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 6 Jun
 2019 07:04:26 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 6 Jun 2019 07:04:26 -0500
Received: from [192.168.2.10] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x56C4N15062131;
        Thu, 6 Jun 2019 07:04:23 -0500
Subject: Re: [PATCH 01/16] firmware: ti_sci: Add resource management APIs for
 ringacc, psi-l and udma
To:     Lokesh Vutla <lokeshvutla@ti.com>, <vkoul@kernel.org>,
        <robh+dt@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <t-kristo@ti.com>, <tony@atomide.com>
References: <20190506123456.6777-1-peter.ujfalusi@ti.com>
 <20190506123456.6777-2-peter.ujfalusi@ti.com>
 <f2056b18-3f65-b7ae-90ba-5ebf9ac425bc@ti.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <78a2d824-d730-4174-e80b-4153a2744427@ti.com>
Date:   Thu, 6 Jun 2019 15:04:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <f2056b18-3f65-b7ae-90ba-5ebf9ac425bc@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Lokesh,

On 06/06/2019 9.00, Lokesh Vutla wrote:
> Hi Peter,
> 
> On 06/05/19 6:04 PM, Peter Ujfalusi wrote:
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> 
> Patch has the following checkpatch warnings and checks which can be fixed:
> 
> WARNING: Missing commit description - Add an appropriate one

How did I missed it?

> CHECK: Lines should not end with a '('
> #262: FILE: drivers/firmware/ti_sci.c:2286:
> +static int ti_sci_cmd_rm_udmap_tx_ch_cfg(
> 
> CHECK: Lines should not end with a '('
> #323: FILE: drivers/firmware/ti_sci.c:2347:
> +static int ti_sci_cmd_rm_udmap_rx_ch_cfg(
> 
> CHECK: Lines should not end with a '('
> #383: FILE: drivers/firmware/ti_sci.c:2407:
> +static int ti_sci_cmd_rm_udmap_rx_flow_cfg1(
> 
> CHECK: Lines should not end with a '('
> #1414: FILE: include/linux/soc/ti/ti_sci_protocol.h:455:
> +	int (*rx_flow_cfg)(
> 
> total: 0 errors, 2 warnings, 4 checks, 1399 lines checked

There must be a reason why these left, but I will take another look.

>> ---
>>  drivers/firmware/ti_sci.c              | 439 +++++++++++++++
>>  drivers/firmware/ti_sci.h              | 704 +++++++++++++++++++++++++
>>  include/linux/soc/ti/ti_sci_protocol.h | 216 ++++++++
>>  3 files changed, 1359 insertions(+)
>>
>> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
>> index 64d895b80bc3..af3ebcdeab18 100644
>> --- a/drivers/firmware/ti_sci.c
>> +++ b/drivers/firmware/ti_sci.c
> 
> [..snip.]
> 
>> +}
>> +
>> +static int ti_sci_cmd_rm_psil_pair(const struct ti_sci_handle *handle,
>> +				   u32 nav_id, u32 src_thread, u32 dst_thread)
>> +{
> 
> All the psil ops doesn't have the  kernel-doc function comments. Just be
> consistent with other functions :)

OK.

>> +	struct ti_sci_msg_hdr *resp;
>> +	struct ti_sci_msg_psil_pair *req;
>> +	struct ti_sci_xfer *xfer;
>> +	struct ti_sci_info *info;
>> +	struct device *dev;
>> +	int ret = 0;
>> +
>> +	if (IS_ERR(handle))
>> +		return PTR_ERR(handle);
>> +	if (!handle)
>> +		return -EINVAL;
>> +
>> +	info = handle_to_ti_sci_info(handle);
>> +	dev = info->dev;
>> +
>> +	xfer = ti_sci_get_one_xfer(info, TI_SCI_MSG_RM_PSIL_PAIR,
>> +				   TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
>> +				   sizeof(*req), sizeof(*resp));
>> +	if (IS_ERR(xfer)) {
>> +		ret = PTR_ERR(xfer);
>> +		dev_err(dev, "RM_PSIL:Message reconfig failed(%d)\n", ret);
>> +		return ret;
>> +	}
>> +	req = (struct ti_sci_msg_psil_pair *)xfer->xfer_buf;
>> +	req->nav_id = nav_id;
>> +	req->src_thread = src_thread;
>> +	req->dst_thread = dst_thread;
>> +
>> +	ret = ti_sci_do_xfer(info, xfer);
>> +	if (ret) {
>> +		dev_err(dev, "RM_PSIL:Mbox send fail %d\n", ret);
>> +		goto fail;
>> +	}
>> +
>> +	resp = (struct ti_sci_msg_hdr *)xfer->xfer_buf;
>> +	ret = ti_sci_is_response_ack(resp) ? 0 : -EINVAL;
>> +
>> +fail:
>> +	ti_sci_put_one_xfer(&info->minfo, xfer);
>> +
>> +	return ret;
>> +}
>> +
> 
> [..snip..]
> 
>> + */
>> +struct ti_sci_msg_rm_ring_cfg_req {
>> +	struct ti_sci_msg_hdr hdr;
>> +	u32 valid_params;
>> +	u16 nav_id;
>> +	u16 index;
>> +	u32 addr_lo;
>> +	u32 addr_hi;
>> +	u32 count;
>> +	u8 mode;
>> +	u8 size;
>> +	u8 order_id;
>> +} __packed;
>> +
>> +/**
>> + * struct ti_sci_msg_rm_ring_cfg_resp - Response to configuring a ring.
>> + *
>> + * @hdr:	Generic Header
>> + */
>> +struct ti_sci_msg_rm_ring_cfg_resp {
>> +	struct ti_sci_msg_hdr hdr;
>> +} __packed;
> 
> If it is a generic ACK, NACK response, just use the header directly.

Sure, I'll fix it and other places if any.

> 
> [..snip..]
> 
>> + */
>> +struct ti_sci_msg_rm_udmap_rx_ch_cfg_req {
>> +	struct ti_sci_msg_hdr hdr;
>> +	u32 valid_params;
>> +	u16 nav_id;
>> +	u16 index;
>> +	u16 rx_fetch_size;
>> +	u16 rxcq_qnum;
>> +	u8 rx_priority;
>> +	u8 rx_qos;
>> +	u8 rx_orderid;
>> +	u8 rx_sched_priority;
>> +	u16 flowid_start;
>> +	u16 flowid_cnt;
>> +	u8 rx_pause_on_err;
>> +	u8 rx_atype;
>> +	u8 rx_chan_type;
>> +	u8 rx_ignore_short;
>> +	u8 rx_ignore_long;
>> +	u8 rx_burst_size;
>> +
> 
> extra line?

Will remove it.
> 
>> +} __packed;
>> +
>> +/**
> 
> 
> Thanks and regards,
> Lokesh
> 

Thanks,
- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
