Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3214C11A8CF
	for <lists+dmaengine@lfdr.de>; Wed, 11 Dec 2019 11:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbfLKKY4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 Dec 2019 05:24:56 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35542 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727469AbfLKKY4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 11 Dec 2019 05:24:56 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBBAOj8Q115655;
        Wed, 11 Dec 2019 04:24:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576059885;
        bh=W+RMFciMhRgB2xiAH7N3KcyPOaKYa0Y2g73Ycx9qJBU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=AlEFjwGweVEw8qSb+hWRM560R4gcZ7LdQZ7uT5KGIJsgTrfW8NMyt7CLxYaIfAK7/
         9i+s5zTdbewcepjqroGmDL/g963+nLlM7PN4rIUCzTtx7AnaFGJ6YvBuMudA2LnFlu
         E9LCQFxJqBv/nvaI1HudJqEX0eIujtBgobWH2jN8=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBBAOjKf030751;
        Wed, 11 Dec 2019 04:24:45 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 11
 Dec 2019 04:24:43 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 11 Dec 2019 04:24:43 -0600
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBBAOeLj096803;
        Wed, 11 Dec 2019 04:24:40 -0600
Subject: Re: [PATCH v7 11/12] firmware: ti_sci: rm: Add support for tx_tdtype
 parameter for tx channel
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, <vkoul@kernel.org>,
        <robh+dt@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <tony@atomide.com>, <j-keerthy@ti.com>, <vigneshr@ti.com>
References: <20191209094332.4047-1-peter.ujfalusi@ti.com>
 <20191209094332.4047-12-peter.ujfalusi@ti.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <3d3a4f1d-e449-88d6-ec5a-5ce516faf436@ti.com>
Date:   Wed, 11 Dec 2019 12:24:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191209094332.4047-12-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 09/12/2019 11:43, Peter Ujfalusi wrote:
> The system controller's resource manager have support for configuring the
> TDTYPE of TCHAN_CFG register on j721e.
> With this parameter the teardown completion can be controlled:
> TDTYPE == 0: Return without waiting for peer to complete the teardown
> TDTYPE == 1: Wait for peer to complete the teardown
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Hi Peter,

You somehow dropped my reviewed by tag from this patch, this appears 
identical to the v6 one. So,

Reviewed-by: Tero Kristo <t-kristo@ti.com>

> ---
>   drivers/firmware/ti_sci.c              | 1 +
>   drivers/firmware/ti_sci.h              | 7 +++++++
>   include/linux/soc/ti/ti_sci_protocol.h | 2 ++
>   3 files changed, 10 insertions(+)
> 
> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> index 4126be9e3216..f13e4a96f3b7 100644
> --- a/drivers/firmware/ti_sci.c
> +++ b/drivers/firmware/ti_sci.c
> @@ -2412,6 +2412,7 @@ static int ti_sci_cmd_rm_udmap_tx_ch_cfg(const struct ti_sci_handle *handle,
>   	req->fdepth = params->fdepth;
>   	req->tx_sched_priority = params->tx_sched_priority;
>   	req->tx_burst_size = params->tx_burst_size;
> +	req->tx_tdtype = params->tx_tdtype;
>   
>   	ret = ti_sci_do_xfer(info, xfer);
>   	if (ret) {
> diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
> index f0d068c03944..255327171dae 100644
> --- a/drivers/firmware/ti_sci.h
> +++ b/drivers/firmware/ti_sci.h
> @@ -910,6 +910,7 @@ struct rm_ti_sci_msg_udmap_rx_flow_opt_cfg {
>    *   12 - Valid bit for @ref ti_sci_msg_rm_udmap_tx_ch_cfg::tx_credit_count
>    *   13 - Valid bit for @ref ti_sci_msg_rm_udmap_tx_ch_cfg::fdepth
>    *   14 - Valid bit for @ref ti_sci_msg_rm_udmap_tx_ch_cfg::tx_burst_size
> + *   15 - Valid bit for @ref ti_sci_msg_rm_udmap_tx_ch_cfg::tx_tdtype
>    *
>    * @nav_id: SoC device ID of Navigator Subsystem where tx channel is located
>    *
> @@ -973,6 +974,11 @@ struct rm_ti_sci_msg_udmap_rx_flow_opt_cfg {
>    *
>    * @tx_burst_size: UDMAP transmit channel burst size configuration to be
>    * programmed into the tx_burst_size field of the TCHAN_TCFG register.
> + *
> + * @tx_tdtype: UDMAP transmit channel teardown type configuration to be
> + * programmed into the tdtype field of the TCHAN_TCFG register:
> + * 0 - Return immediately
> + * 1 - Wait for completion message from remote peer
>    */
>   struct ti_sci_msg_rm_udmap_tx_ch_cfg_req {
>   	struct ti_sci_msg_hdr hdr;
> @@ -994,6 +1000,7 @@ struct ti_sci_msg_rm_udmap_tx_ch_cfg_req {
>   	u16 fdepth;
>   	u8 tx_sched_priority;
>   	u8 tx_burst_size;
> +	u8 tx_tdtype;
>   } __packed;
>   
>   /**
> diff --git a/include/linux/soc/ti/ti_sci_protocol.h b/include/linux/soc/ti/ti_sci_protocol.h
> index 9531ec823298..f3aed0b91564 100644
> --- a/include/linux/soc/ti/ti_sci_protocol.h
> +++ b/include/linux/soc/ti/ti_sci_protocol.h
> @@ -342,6 +342,7 @@ struct ti_sci_msg_rm_udmap_tx_ch_cfg {
>   #define TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_SUPR_TDPKT_VALID        BIT(11)
>   #define TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_CREDIT_COUNT_VALID      BIT(12)
>   #define TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_FDEPTH_VALID            BIT(13)
> +#define TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_TDTYPE_VALID            BIT(15)
>   	u16 nav_id;
>   	u16 index;
>   	u8 tx_pause_on_err;
> @@ -359,6 +360,7 @@ struct ti_sci_msg_rm_udmap_tx_ch_cfg {
>   	u16 fdepth;
>   	u8 tx_sched_priority;
>   	u8 tx_burst_size;
> +	u8 tx_tdtype;
>   };
>   
>   /**
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
