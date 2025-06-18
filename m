Return-Path: <dmaengine+bounces-5531-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1CEADE51D
	for <lists+dmaengine@lfdr.de>; Wed, 18 Jun 2025 10:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D39B23BC86A
	for <lists+dmaengine@lfdr.de>; Wed, 18 Jun 2025 08:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F67A27F005;
	Wed, 18 Jun 2025 08:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gjrxtSt7"
X-Original-To: dmaengine@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3404A78F36;
	Wed, 18 Jun 2025 08:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750233910; cv=none; b=u9au9BKJ8PTV2ddcrGrxbct9g2ahqQzWX8FdF6O96aVwNkPwarDqFCgx5Yk/cRo/NQ+2h29msjTEa6Fm9VmwkJaSInaZO+CCea18UoV8ER49WS19RrJ5ZbMETNX9R0lP8n4rTN+vKlNQZqILv5wWrC1MYKlM+BhqmLWsLRY+3Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750233910; c=relaxed/simple;
	bh=6/3qHFdiaMsBTrQbhD+mcQD74rIaA69OMemwtiFZ/+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Y9Oi8XVdGtEXhZS1bzk5I/qbB+9j5Cm2CMVIZaGy5jJVQvRFpZQb1uvx9yWOi9mxG6yTkZnfbUteGLytIeJ1heUSX46bJ2JbiozUcy3ha6Om/IEC6yAQkXnaB1282smpTHBCPQUFkFZ/VqpfUA5MJ6KbDeIhenR4tpiimm3BHYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gjrxtSt7; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55I8509d258388;
	Wed, 18 Jun 2025 03:05:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1750233900;
	bh=iAAvYxuuuYgZ6Udi3MqCZJcu5QStsstjQ/LkjzAIDBw=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=gjrxtSt7FvQkXkHpVC5Uo2xcKnofCv6Ehf8qWIJw5uEl06UjNterpP3Dm/Yu2K32D
	 sQRwzyqu30rrMEdd8EJIyydxx+jNTtLYeLssmXvSUsbNRm/pYCtyaJi1mYuWRtguTz
	 4AqqXhaC5mTbS9xBzQgTBHAMSnAurR3N6bv8RCqA=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55I850so2735878
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 18 Jun 2025 03:05:00 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 18
 Jun 2025 03:04:59 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 18 Jun 2025 03:04:59 -0500
Received: from [172.24.20.171] (lt2k2yfk3.dhcp.ti.com [172.24.20.171])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55I84sLG3131069;
	Wed, 18 Jun 2025 03:04:55 -0500
Message-ID: <fabe8565-cd27-4117-ba64-23022f1942ae@ti.com>
Date: Wed, 18 Jun 2025 13:34:53 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/17] dmaengine: ti: k3-udma: move static inline
 helper functions to header file
To: Siddharth Vadapalli <s-vadapalli@ti.com>
CC: Peter Ujfalusi <peter.ujfalusi@gmail.com>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Santosh
 Shilimkar <ssantosh@kernel.org>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <praneeth@ti.com>,
        <vigneshr@ti.com>, <u-kumar1@ti.com>, <a-chavda@ti.com>,
        <p-mantena@ti.com>
References: <20250612071521.3116831-1-s-adivi@ti.com>
 <20250612071521.3116831-4-s-adivi@ti.com>
 <acc1217d-50ce-4851-829d-38294b0a4d81@ti.com>
Content-Language: en-US
From: "Adivi, Sai Sree Kartheek" <s-adivi@ti.com>
In-Reply-To: <acc1217d-50ce-4851-829d-38294b0a4d81@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Siddharth,

On 6/12/2025 4:35 PM, Siddharth Vadapalli wrote:
> On Thu, Jun 12, 2025 at 12:45:07PM +0530, Sai Sree Kartheek Adivi wrote:
>> Move static inline helper functions in k3-udma.c to k3-udma.h header
>> file for better separation and re-use.
>>
>> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
>> ---
>>   drivers/dma/ti/k3-udma.c | 108 --------------------------------------
>>   drivers/dma/ti/k3-udma.h | 109 +++++++++++++++++++++++++++++++++++++++
> 
> Since this patch and the previous two patches seem to have the same
> objective of moving contents from "k3-udma.c" to "k3-udma.h" for the
> purpose of re-use, could they be squashed?

I split them up to make the changes easier to review, bisect or revert 
if needed. They're logically distinct changes even if the overall goal 
is similar.

If there's a strong preference to squash them, I can do that but I'd 
prefer keeping them separate.

> 
> Regards,
> Siddharth.


