Return-Path: <dmaengine+bounces-510-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A4B81123A
	for <lists+dmaengine@lfdr.de>; Wed, 13 Dec 2023 14:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C65EB1C2074F
	for <lists+dmaengine@lfdr.de>; Wed, 13 Dec 2023 13:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0907A29420;
	Wed, 13 Dec 2023 13:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hraHSnTb"
X-Original-To: dmaengine@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFE810A;
	Wed, 13 Dec 2023 05:00:24 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BDD0LhY071761;
	Wed, 13 Dec 2023 07:00:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1702472421;
	bh=zHaG9EOvhGw+Eye9IXKEwTb6wGAx5Oy0OLqMaoyNSkw=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=hraHSnTbJk5zNmG03Cr3rgSGkrwOvYZXWdhPndDps0ur9oeMVBHHPSVCxdj2M+01x
	 I2RPZeMFww6uBVYxWGo0vUkzSZr6A/SHoo6ur7vKo82ZL/Zm8Q7RKueI1ilAYdGQJ9
	 ZFZ1n+SacrPkQZ3KnIytMAqtTa5l0Lpm54bEDO+c=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BDD0LRu008914
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 13 Dec 2023 07:00:21 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 13
 Dec 2023 07:00:20 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 13 Dec 2023 07:00:20 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BDD0Kxl104648;
	Wed, 13 Dec 2023 07:00:20 -0600
Date: Wed, 13 Dec 2023 07:00:20 -0600
From: Bryan Brattlof <bb@ti.com>
To: Vaishnav Achath <vaishnav.a@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        Peter Ujfalusi
	<peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>,
        DMA Engine
	<dmaengine@vger.kernel.org>
Subject: Re: [PATCH] dmaengine: ti: k3-udma: Add PSIL threads for AM62P
Message-ID: <20231213130020.d3tpi3q5tnxz37c3@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20231212203655.3155565-2-bb@ti.com>
 <1f4bed4e-12e0-4c82-a4fe-a8dee7053a1b@ti.com>
 <6ed9778c-d792-5481-144c-905a0cf12d61@ti.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <6ed9778c-d792-5481-144c-905a0cf12d61@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On December 13, 2023 thus sayeth Vaishnav Achath:
> Hi Vignesh,
> 
> On 13/12/23 11:32, Vignesh Raghavendra wrote:
> > 
> > 
> > On 13/12/23 2:06 am, Bryan Brattlof wrote:
> >> From: Vignesh Raghavendra <vigneshr@ti.com>
> >>
> >> Add PSIL and PDMA data for AM62P.
> >>
> >> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> >> Signed-off-by: Bryan Brattlof <bb@ti.com>
> >> ---
> >>  drivers/dma/ti/Makefile        |   3 +-
> >>  drivers/dma/ti/k3-psil-am62p.c | 196 +++++++++++++++++++++++++++++++++
> > 
> > Does this also include J722s data? I prefer if we could introduce both
> > SoC support together as one is superset of the other. Vaishav?
> > 
> 
> This did not include J722S data and also CSI2RX data for both devices, I have
> added those and sent a V2 for this patch:
> https://lore.kernel.org/all/20231213081318.26203-1-vaishnav.a@ti.com/
> 

Ah yeah! I like doing this all in one shot. 

Thanks Vaishnav and Vignesh.

~Bryan

