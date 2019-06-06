Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E14636BF5
	for <lists+dmaengine@lfdr.de>; Thu,  6 Jun 2019 08:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbfFFGBA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 6 Jun 2019 02:01:00 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:60148 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfFFGA7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 6 Jun 2019 02:00:59 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5660oXb078820;
        Thu, 6 Jun 2019 01:00:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559800850;
        bh=FSREGiRABJFq74W4rr6M51W3Yk2CPzgfEKsFWNPJA9I=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=B7C/+eYQR/5L3PIF9wwHURouG6GdJIeqKkPllBB4+j4CrEAShfaS6oxx2iecVfiR8
         3xNMh39kzPDq256uL/Vt07rZ27zV7Cf/p94LYqQWInBOi1DR8svnJizB/KNYv/AGqV
         7910peb5NTsaW9IxuikgQ5cAWSX/gF2LRyTfnd64=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5660ont032539
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 6 Jun 2019 01:00:50 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 6 Jun
 2019 01:00:50 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 6 Jun 2019 01:00:50 -0500
Received: from [172.24.190.117] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5660gQS102302;
        Thu, 6 Jun 2019 01:00:44 -0500
Subject: Re: [PATCH 01/16] firmware: ti_sci: Add resource management APIs for
 ringacc, psi-l and udma
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, <vkoul@kernel.org>,
        <robh+dt@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <t-kristo@ti.com>, <tony@atomide.com>
References: <20190506123456.6777-1-peter.ujfalusi@ti.com>
 <20190506123456.6777-2-peter.ujfalusi@ti.com>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <f2056b18-3f65-b7ae-90ba-5ebf9ac425bc@ti.com>
Date:   Thu, 6 Jun 2019 11:30:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190506123456.6777-2-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Peter,

On 06/05/19 6:04 PM, Peter Ujfalusi wrote:
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Patch has the following checkpatch warnings and checks which can be fixed:

WARNING: Missing commit description - Add an appropriate one

CHECK: Lines should not end with a '('
#262: FILE: drivers/firmware/ti_sci.c:2286:
+static int ti_sci_cmd_rm_udmap_tx_ch_cfg(

CHECK: Lines should not end with a '('
#323: FILE: drivers/firmware/ti_sci.c:2347:
+static int ti_sci_cmd_rm_udmap_rx_ch_cfg(

CHECK: Lines should not end with a '('
#383: FILE: drivers/firmware/ti_sci.c:2407:
+static int ti_sci_cmd_rm_udmap_rx_flow_cfg1(

CHECK: Lines should not end with a '('
#1414: FILE: include/linux/soc/ti/ti_sci_protocol.h:455:
+	int (*rx_flow_cfg)(

total: 0 errors, 2 warnings, 4 checks, 1399 lines checked



> ---
>  drivers/firmware/ti_sci.c              | 439 +++++++++++++++
>  drivers/firmware/ti_sci.h              | 704 +++++++++++++++++++++++++
>  include/linux/soc/ti/ti_sci_protocol.h | 216 ++++++++
>  3 files changed, 1359 insertions(+)
> 
> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> index 64d895b80bc3..af3ebcdeab18 100644
> --- a/drivers/firmware/ti_sci.c
> +++ b/drivers/firmware/ti_sci.c

[..snip.]

> +}
> +
> +static int ti_sci_cmd_rm_psil_pair(const struct ti_sci_handle *handle,
> +				   u32 nav_id, u32 src_thread, u32 dst_thread)
> +{

All the psil ops doesn't have the  kernel-doc function comments. Just be
consistent with other functions :)


> +	struct ti_sci_msg_hdr *resp;
> +	struct ti_sci_msg_psil_pair *req;
> +	struct ti_sci_xfer *xfer;
> +	struct ti_sci_info *info;
> +	struct device *dev;
> +	int ret = 0;
> +
> +	if (IS_ERR(handle))
> +		return PTR_ERR(handle);
> +	if (!handle)
> +		return -EINVAL;
> +
> +	info = handle_to_ti_sci_info(handle);
> +	dev = info->dev;
> +
> +	xfer = ti_sci_get_one_xfer(info, TI_SCI_MSG_RM_PSIL_PAIR,
> +				   TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
> +				   sizeof(*req), sizeof(*resp));
> +	if (IS_ERR(xfer)) {
> +		ret = PTR_ERR(xfer);
> +		dev_err(dev, "RM_PSIL:Message reconfig failed(%d)\n", ret);
> +		return ret;
> +	}
> +	req = (struct ti_sci_msg_psil_pair *)xfer->xfer_buf;
> +	req->nav_id = nav_id;
> +	req->src_thread = src_thread;
> +	req->dst_thread = dst_thread;
> +
> +	ret = ti_sci_do_xfer(info, xfer);
> +	if (ret) {
> +		dev_err(dev, "RM_PSIL:Mbox send fail %d\n", ret);
> +		goto fail;
> +	}
> +
> +	resp = (struct ti_sci_msg_hdr *)xfer->xfer_buf;
> +	ret = ti_sci_is_response_ack(resp) ? 0 : -EINVAL;
> +
> +fail:
> +	ti_sci_put_one_xfer(&info->minfo, xfer);
> +
> +	return ret;
> +}
> +

[..snip..]

> + */
> +struct ti_sci_msg_rm_ring_cfg_req {
> +	struct ti_sci_msg_hdr hdr;
> +	u32 valid_params;
> +	u16 nav_id;
> +	u16 index;
> +	u32 addr_lo;
> +	u32 addr_hi;
> +	u32 count;
> +	u8 mode;
> +	u8 size;
> +	u8 order_id;
> +} __packed;
> +
> +/**
> + * struct ti_sci_msg_rm_ring_cfg_resp - Response to configuring a ring.
> + *
> + * @hdr:	Generic Header
> + */
> +struct ti_sci_msg_rm_ring_cfg_resp {
> +	struct ti_sci_msg_hdr hdr;
> +} __packed;

If it is a generic ACK, NACK response, just use the header directly.

[..snip..]

> + */
> +struct ti_sci_msg_rm_udmap_rx_ch_cfg_req {
> +	struct ti_sci_msg_hdr hdr;
> +	u32 valid_params;
> +	u16 nav_id;
> +	u16 index;
> +	u16 rx_fetch_size;
> +	u16 rxcq_qnum;
> +	u8 rx_priority;
> +	u8 rx_qos;
> +	u8 rx_orderid;
> +	u8 rx_sched_priority;
> +	u16 flowid_start;
> +	u16 flowid_cnt;
> +	u8 rx_pause_on_err;
> +	u8 rx_atype;
> +	u8 rx_chan_type;
> +	u8 rx_ignore_short;
> +	u8 rx_ignore_long;
> +	u8 rx_burst_size;
> +

extra line?

> +} __packed;
> +
> +/**


Thanks and regards,
Lokesh
