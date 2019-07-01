Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0990E5B63C
	for <lists+dmaengine@lfdr.de>; Mon,  1 Jul 2019 10:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfGAICO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 1 Jul 2019 04:02:14 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:24024 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfGAICO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 1 Jul 2019 04:02:14 -0400
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Ludovic.Desroches@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Ludovic.Desroches@microchip.com";
  x-sender="Ludovic.Desroches@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Ludovic.Desroches@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Ludovic.Desroches@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.63,438,1557212400"; 
   d="scan'208";a="41012022"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Jul 2019 01:02:13 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex03.mchp-main.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 1 Jul 2019 01:02:10 -0700
Received: from localhost (10.10.85.251) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 1 Jul 2019 01:02:09 -0700
Date:   Mon, 1 Jul 2019 10:00:51 +0200
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     Raag Jadav <raagjadav@gmail.com>
CC:     <dmaengine@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dmaengine: at_xdmac: check for non-empty xfers_list
 before invoking callback
Message-ID: <20190701080050.np5krtatlifnvtq5@M43218.corp.atmel.com>
Mail-Followup-To: Raag Jadav <raagjadav@gmail.com>,
        dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1561796448-3321-1-git-send-email-raagjadav@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1561796448-3321-1-git-send-email-raagjadav@gmail.com>
User-Agent: NeoMutt/20180716
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sat, Jun 29, 2019 at 01:50:48PM +0530, Raag Jadav wrote:
> 
> tx descriptor retrieved from an empty xfers_list may not have valid
> pointers to the callback functions.
> Avoid calling dmaengine_desc_get_callback_invoke if xfers_list is empty.
> 
> Signed-off-by: Raag Jadav <raagjadav@gmail.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

Thanks

> ---
>  drivers/dma/at_xdmac.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
> index 627ef3e..b58ac72 100644
> --- a/drivers/dma/at_xdmac.c
> +++ b/drivers/dma/at_xdmac.c
> @@ -1568,11 +1568,14 @@ static void at_xdmac_handle_cyclic(struct at_xdmac_chan *atchan)
>  	struct at_xdmac_desc		*desc;
>  	struct dma_async_tx_descriptor	*txd;
>  
> -	desc = list_first_entry(&atchan->xfers_list, struct at_xdmac_desc, xfer_node);
> -	txd = &desc->tx_dma_desc;
> +	if (!list_empty(&atchan->xfers_list)) {
> +		desc = list_first_entry(&atchan->xfers_list,
> +					struct at_xdmac_desc, xfer_node);
> +		txd = &desc->tx_dma_desc;
>  
> -	if (txd->flags & DMA_PREP_INTERRUPT)
> -		dmaengine_desc_get_callback_invoke(txd, NULL);
> +		if (txd->flags & DMA_PREP_INTERRUPT)
> +			dmaengine_desc_get_callback_invoke(txd, NULL);
> +	}
>  }
>  
>  static void at_xdmac_handle_error(struct at_xdmac_chan *atchan)
> -- 
> 2.7.4
> 
> 
