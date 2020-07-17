Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C73223518
	for <lists+dmaengine@lfdr.de>; Fri, 17 Jul 2020 09:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbgGQHCr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Jul 2020 03:02:47 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:36580 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbgGQHCq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Jul 2020 03:02:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1594969366; x=1626505366;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zvYhhfPJJoUkehWHcDgol6pHbU2fH1ez1ZK7n6yYhdk=;
  b=PkbBVR2MtBsa86oVopLvzXuOw7dCDHkH8JyXZJ7B69Eh76SyIsmtiuQ/
   Ws1DjDJGQ7w6a/pjoDyUxRZWP5cPJxh7aqq1UpDRL4cAC5JRbZLKjR3Ij
   QcYCgEB4zTPZID9wsZrKp/J2RIS9JRY0kvnYaxH7cLt2T8bW+ZjitkbFC
   d8G5XJziJJEF2vo05rdFCkmt4v6vfkMPf++9Xo4UHqvAxqi8G3+Y1F6vG
   YYqUtLthQ4fb6aeSAufIKLn7zsdtRtaRlWmUpmdPyqNvcXrm319L8wSBA
   HFRQhIe7ukGISrUx43ixhiWda72qMfiX+YUuQpxa3KhMUrSJHAGGtly6e
   g==;
IronPort-SDR: pRgM2gd9E2UVUoR8a8tSk2StvyyBfuTf/uyv0FlKY+gJmggkudSajGRgSLVRoNi2kzdzHpyaKH
 FDKgi3OF1sacDQg3IDKn+ZrSGr7Q5jWJQ1fOi8+K9zFWo8A7Bn1ffYkqS4IxeQGOdDJ82W/xT/
 v6v4l9LwVnRDESqEqmFja7HU5B0rEUm9pxt8thnxv/TyLGxrYNKt+RE+A6Hks/XDxBEyCJa6Kd
 uZ82E1BOVx5T53aArVAK4lZ4aXNlrvAnuPEm3dEm8KasLmJD+eIONrRVWkR83TCW9EsZavUieY
 N2Q=
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="80275861"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Jul 2020 00:02:45 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 17 Jul 2020 00:02:10 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 17 Jul 2020 00:02:12 -0700
Date:   Fri, 17 Jul 2020 09:02:44 +0200
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     <tudor.ambarus@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v2] MAINTAINERS: dma: Microchip: add Tudor Ambarus as
 co-maintainer
Message-ID: <20200717070244.ipxabcvr2pxcz7r2@ROU-LT-M43218B.mchp-main.com>
References: <20200716071524.25642-1-ludovic.desroches@microchip.com>
 <20200717061753.GF82923@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200717061753.GF82923@vkoul-mobl>
User-Agent: NeoMutt/20180716
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Jul 17, 2020 at 11:47:53AM +0530, Vinod Koul wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On 16-07-20, 09:15, Ludovic Desroches wrote:
> > Add Tudor Ambarus as co-maintainer for both Microchip DMA drivers and
> > take the opportunity to merge both entries.
> 
> Applied after changing dma->dmaengine, thanks
> I have conflict while applying, please check

Sounds good.

Thanks

Ludovic

> 
> --
> ~Vinod
