Return-Path: <dmaengine+bounces-5414-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB48AD6D51
	for <lists+dmaengine@lfdr.de>; Thu, 12 Jun 2025 12:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 888913AF41F
	for <lists+dmaengine@lfdr.de>; Thu, 12 Jun 2025 10:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9A61FBCB0;
	Thu, 12 Jun 2025 10:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vlgNQb4s"
X-Original-To: dmaengine@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8731A9B32;
	Thu, 12 Jun 2025 10:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749723374; cv=none; b=jjRB1g15dgzMtyi0MDtn2256yfYlUUrc64Ub3oqqFIem1YBC0QQ4O0ARDSiDyejgN8cCOfetcIYuD1lsLJRcqm4UE5dibsJGkWB2OvGAWzp9Q8zcgMGs+1hhnbRQ6wTWxgnm9CBrEplGD0TFjqAJtUP2cE7Y/f7564XLUO567nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749723374; c=relaxed/simple;
	bh=U8Ib+vhgknJZUGujsTIacxWsiwarvISy9tV/JoJj3mE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=In2mZ4Oy0db9/gKLpVZqHlMGPaumCHAyVA/DsHEcaabbPBX5YxNH/eg3Knnm8H8Ro8PtXK9U64od2nRuOZxcICFeYUSFSrMz+g5MlV3HW3NgFg9jWBht0EelHQQMgqxwGrZSIqQBRF44Uuy3tLTQxaGGV5rMuziE01Vxrku/knI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vlgNQb4s; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55CAFxWp2886298;
	Thu, 12 Jun 2025 05:15:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1749723359;
	bh=w1BvpyF39z5hMo5/VBX/0oCDLHJPdp2C+Dbe2C2TKsM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=vlgNQb4seNrwaouEv9+opWOU/k/iDzdQY6kL8THh/EMZ6I61r9DMp4NfWInqBpHFq
	 Dfzbx2R4JFIEIpktNhmtGodgG4x3x7ipw9MEAGtiXlaDx/ImOhNrsmhcG85R8eFx0N
	 0qTNfc8AqFb1qzhocK6DRFVnnFdCrpOMuPkPynkA=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55CAFxsK3562020
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 12 Jun 2025 05:15:59 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 12
 Jun 2025 05:15:58 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 12 Jun 2025 05:15:58 -0500
Received: from [172.24.227.40] (pratham-workstation-pc.dhcp.ti.com [172.24.227.40])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55CAFtXR1834025;
	Thu, 12 Jun 2025 05:15:55 -0500
Message-ID: <b27eab62-cfe0-4dfc-8429-ea464eef9e6f@ti.com>
Date: Thu, 12 Jun 2025 15:45:54 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] crypto: ti: Add driver for DTHE V2 AES Engine
 (ECB, CBC)
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: "David S. Miller" <davem@davemloft.net>,
        Kamlesh Gurudasani
	<kamlesh@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Praneeth Bajjuri
	<praneeth@ti.com>,
        Manorit Chawdhry <m-chawdhry@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, Vinod Koul
	<vkoul@kernel.org>,
        <dmaengine@vger.kernel.org>
References: <20250603124217.957116-1-t-pratham@ti.com>
 <20250603124217.957116-3-t-pratham@ti.com>
 <aElSKF88vBsIOJMV@gondor.apana.org.au>
Content-Language: en-US
From: T Pratham <t-pratham@ti.com>
In-Reply-To: <aElSKF88vBsIOJMV@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 11/06/25 15:23, Herbert Xu wrote:
> On Tue, Jun 03, 2025 at 06:07:29PM +0530, T Pratham wrote:
>>
>> +	// Need to do a timeout to ensure finalise gets called if DMA callback fails for any reason
>> +	ret = wait_for_completion_timeout(&rctx->aes_compl, msecs_to_jiffies(DTHE_DMA_TIMEOUT_MS));
> 
> This doesn't look safe.  What if the callback is invoked after a
> timeout? That would be a UAF.
> 
> Does the DMA engine provide any timeout mechanism? If not, then
> you could do it with a delayed work struct.  Just make sure that
> you cancel the work struct in the normal path callback.  Vice versa
> you need to terminate the DMA job in the timeout work struct.
> 
> Cheers,

Calling dma_terminate_sync() here should suffice I presume? I'll update the code accordingly.

Regards
T Pratham <t-pratham@ti.com>

