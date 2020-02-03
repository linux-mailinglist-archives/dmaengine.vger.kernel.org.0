Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D466150275
	for <lists+dmaengine@lfdr.de>; Mon,  3 Feb 2020 09:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbgBCIY6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 3 Feb 2020 03:24:58 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:62548 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgBCIY6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 3 Feb 2020 03:24:58 -0500
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Ludovic.Desroches@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Ludovic.Desroches@microchip.com";
  x-sender="Ludovic.Desroches@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Ludovic.Desroches@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Ludovic.Desroches@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: LYzB8tjFzwME2IoR4inF3aAMR7E8mFznysBZRpxY0qLtLp+o30w47celA5tYohtq/EQ+OPcUPP
 VOwpY9HfKlqC6+tVpHI/0SfinRC93oEXfSydvmuHNe1VOWKjHXeBWewDHhMugGaj0KAVL8QVZC
 efDneFt+/tM/CAlk2ufRy0ph/PFrbDy3SBhRQ66vTGKKjID6cPvp8N2dyl/IR+x/Sugp0GYHLi
 c4ZbyGl077x69yTYNOvkVLpov63QtXs9Ys2s2bHUKvCeOxL6pbTNG9+S4qIYotYLhAQkb3zr4j
 oIo=
X-IronPort-AV: E=Sophos;i="5.70,397,1574146800"; 
   d="scan'208";a="1018402"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Feb 2020 01:24:57 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 3 Feb 2020 01:24:57 -0700
Received: from localhost (10.10.85.251) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 3 Feb 2020 01:24:56 -0700
Date:   Mon, 3 Feb 2020 09:24:27 +0100
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     Tudor Ambarus - M18064 <Tudor.Ambarus@microchip.com>
CC:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/10] dmaengine: at_hdmac: Substitute kzalloc with
 kmalloc
Message-ID: <20200203082427.bog6ykmxvixeisg5@M43218.corp.atmel.com>
Mail-Followup-To: Tudor Ambarus - M18064 <Tudor.Ambarus@microchip.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200123140237.125799-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200123140237.125799-1-tudor.ambarus@microchip.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Jan 23, 2020 at 02:03:02PM +0000, Tudor Ambarus - M18064 wrote:
> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> All members of the structure are initialized below in the function,
> there is no need to use kzalloc.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Hi Tudor,

It sounds good for me. Thanks for the cleanup and deadlock fixes.

For the whole set of patches:
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

Ludovic

> ---
>  drivers/dma/at_hdmac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
> index 672c73b4a2d4..cad6dcd9cfb5 100644
> --- a/drivers/dma/at_hdmac.c
> +++ b/drivers/dma/at_hdmac.c
> @@ -1671,7 +1671,7 @@ static struct dma_chan *at_dma_xlate(struct of_phandle_args *dma_spec,
>  	dma_cap_zero(mask);
>  	dma_cap_set(DMA_SLAVE, mask);
>  
> -	atslave = kzalloc(sizeof(*atslave), GFP_KERNEL);
> +	atslave = kmalloc(sizeof(*atslave), GFP_KERNEL);
>  	if (!atslave)
>  		return NULL;
>  
> -- 
> 2.23.0
