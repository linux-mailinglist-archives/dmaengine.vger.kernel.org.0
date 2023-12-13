Return-Path: <dmaengine+bounces-507-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 892AD8109CD
	for <lists+dmaengine@lfdr.de>; Wed, 13 Dec 2023 07:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31C231F21812
	for <lists+dmaengine@lfdr.de>; Wed, 13 Dec 2023 06:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E315D295;
	Wed, 13 Dec 2023 06:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NVR/z3Y5"
X-Original-To: dmaengine@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7305F91;
	Tue, 12 Dec 2023 22:02:34 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BD62Ulh099471;
	Wed, 13 Dec 2023 00:02:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1702447350;
	bh=JVaOET4SJOg/lLNlV+MYLanlmdf9jNBPsHy38R8wKQI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=NVR/z3Y5O5mbF2Lxm/VlDBcjaaOqJvdjiHYN+hluP5X/kCO+3x9sGfIVFKrKz6iIa
	 hUZgsB4ps5VM6wHPi6p0tH0f0AZ8XBhLfeStlypQK8hH1IoRk7GLDCc7HLWgSd4+I+
	 NvzlTgzi4JWSZdlIYSDYSBasY6siQUzIQpMUddPE=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BD62TDf004116
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 13 Dec 2023 00:02:29 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 13
 Dec 2023 00:02:29 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 13 Dec 2023 00:02:29 -0600
Received: from [10.249.138.31] ([10.249.138.31])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BD62Qn6130056;
	Wed, 13 Dec 2023 00:02:27 -0600
Message-ID: <1f4bed4e-12e0-4c82-a4fe-a8dee7053a1b@ti.com>
Date: Wed, 13 Dec 2023 11:32:25 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: ti: k3-udma: Add PSIL threads for AM62P
Content-Language: en-US
To: Bryan Brattlof <bb@ti.com>, Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
CC: Vaishnav Achath <vaishnav.a@ti.com>,
        Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>,
        DMA Engine <dmaengine@vger.kernel.org>
References: <20231212203655.3155565-2-bb@ti.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20231212203655.3155565-2-bb@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 13/12/23 2:06 am, Bryan Brattlof wrote:
> From: Vignesh Raghavendra <vigneshr@ti.com>
> 
> Add PSIL and PDMA data for AM62P.
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---
>  drivers/dma/ti/Makefile        |   3 +-
>  drivers/dma/ti/k3-psil-am62p.c | 196 +++++++++++++++++++++++++++++++++

Does this also include J722s data? I prefer if we could introduce both
SoC support together as one is superset of the other. Vaishav?

Regards
Vignesh

[...]

