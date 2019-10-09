Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16927D08B0
	for <lists+dmaengine@lfdr.de>; Wed,  9 Oct 2019 09:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729618AbfJIHqi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 9 Oct 2019 03:46:38 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:22667 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfJIHqi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 9 Oct 2019 03:46:38 -0400
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Ludovic.Desroches@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Ludovic.Desroches@microchip.com";
  x-sender="Ludovic.Desroches@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Ludovic.Desroches@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Ludovic.Desroches@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: 8v0tdMs3LlvQuSHU7rzAWhRtWIVlotOUQ8ditN56wCSdkOVwSWrpH6xpRpB5o4IFGvwz2oQWnn
 IIj3G65C0gTbgnRV+douGVZvsSs5albruElzTe2OAUWUZNsguLdlc6PBeICA8q2ZCy5PBDKLNx
 3yOjtw6tAsg6bPGLyfJ2eavi13JhfaL84i8Mm82sgjZXzkv5jwHGouLGCzuHKtkV4ax2cf8mWS
 RojiYrUy9JaS7J+XD+q6QhVZetGADXwhPxHErHQ8eotSGUrP2WfzIOigipksHTLSF+468tjMif
 Xxk=
X-IronPort-AV: E=Sophos;i="5.67,273,1566889200"; 
   d="scan'208";a="52257068"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Oct 2019 00:46:36 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 9 Oct 2019 00:46:33 -0700
Received: from localhost (10.10.85.251) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 9 Oct 2019 00:46:33 -0700
Date:   Wed, 9 Oct 2019 09:46:42 +0200
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     Markus Elfring <Markus.Elfring@web.de>
CC:     <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        "Nicolas Ferre" <nicolas.ferre@atmel.com>
Subject: Re: [PATCH] dmaengine: at_xdmac: Use
 devm_platform_ioremap_resource() in at_xdmac_probe()
Message-ID: <20191009074641.taocxbrs2vodvsgm@M43218.corp.atmel.com>
Mail-Followup-To: Markus Elfring <Markus.Elfring@web.de>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@atmel.com>
References: <377247f3-b53a-a9d9-66c7-4b8515de3809@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <377247f3-b53a-a9d9-66c7-4b8515de3809@web.de>
User-Agent: NeoMutt/20180716
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sun, Sep 22, 2019 at 10:48:20AM +0200, Markus Elfring wrote:
> 
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 22 Sep 2019 10:37:31 +0200
> 
> Simplify this function implementation by using a known wrapper function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com> 

Thanks

> ---
>  drivers/dma/at_xdmac.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
> index b58ac720d9a1..f71c9f77d405 100644
> --- a/drivers/dma/at_xdmac.c
> +++ b/drivers/dma/at_xdmac.c
> @@ -1957,21 +1957,16 @@ static int atmel_xdmac_resume(struct device *dev)
> 
>  static int at_xdmac_probe(struct platform_device *pdev)
>  {
> -	struct resource	*res;
>  	struct at_xdmac	*atxdmac;
>  	int		irq, size, nr_channels, i, ret;
>  	void __iomem	*base;
>  	u32		reg;
> 
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!res)
> -		return -EINVAL;
> -
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0)
>  		return irq;
> 
> -	base = devm_ioremap_resource(&pdev->dev, res);
> +	base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
> 
> --
> 2.23.0
> 
