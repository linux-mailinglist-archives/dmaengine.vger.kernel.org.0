Return-Path: <dmaengine+bounces-4214-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DBCA1D509
	for <lists+dmaengine@lfdr.de>; Mon, 27 Jan 2025 11:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2541C1882E66
	for <lists+dmaengine@lfdr.de>; Mon, 27 Jan 2025 11:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561B51FFC61;
	Mon, 27 Jan 2025 10:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EA/57VUh"
X-Original-To: dmaengine@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764F01FE449;
	Mon, 27 Jan 2025 10:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737975493; cv=none; b=JWc0Y2IjQTUiFx98Q7xOWK4If4r6NS+71kCB14+Qwc4K8CFKCBTz/SmfQGMStNmRg+1wdQ0N36g7vKk1eJbf45mlMWBQTO0Y2OsmWz9L7AQKjPpfscs78uQqxI6mUkOTXWWKBzZMahJlyW7Eyyhg6GCuw4pK6jxNKYyCIYU4Or8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737975493; c=relaxed/simple;
	bh=iUjUygDzUkxM5l1NSisQ2M1Ezk2B0PQupfGgxlKzOGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RmtP1rXt+P4Ntz+LB9lpaV2JhCN7GHjs3Vn4coBM/XYYBFk5TbUtAOkOi/1Fodn41YitxsQy/5wE2LBysGp+6+SFmk/CZs6ZBVxAPXgmBA0ltJc3iIO4Q/AkGqAqd3+9McGnzd4KIqOeV2lBjfYN7dJFwFN1XcCDu2TaJvuPKuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=EA/57VUh; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 50RAw066967783
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 27 Jan 2025 04:58:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1737975480;
	bh=v1ikTM5NgGTFGM3/hs958VEdvyjxwZdeGZKUGZ7RYL8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=EA/57VUhtCRDyBoypVgIjZUXT5o+jwOOtSWkmdsf6JaXZo0gVTyAJwjWW4ruN/ABF
	 77/oAUO9EGYeCO91ireuyoQFB2VemroChWvnFfII21MzrcYfihrMwVw/31ETj1S82A
	 Xg/VANY2matb0OomPFw0qLcogkDz1JmtE0q316OA=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50RAw0YF060319;
	Mon, 27 Jan 2025 04:58:00 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 27
 Jan 2025 04:58:00 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 27 Jan 2025 04:58:00 -0600
Received: from [172.24.17.105] (lt5cd2489kgj.dhcp.ti.com [172.24.17.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50RAvvnb079172;
	Mon, 27 Jan 2025 04:57:58 -0600
Message-ID: <7bea4592-01d6-4e19-90e4-e645dfe9631e@ti.com>
Date: Mon, 27 Jan 2025 16:27:57 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] dmaengine: ti: k3-udma: Use cap_mask directly from
 dma_device structure instead of a local copy
To: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>,
        <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>
CC: <vaishnav.a@ti.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250117121728.203452-1-y-abhilashchandra@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20250117121728.203452-1-y-abhilashchandra@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Abhilash,

On 1/17/2025 5:47 PM, Yemike Abhilash Chandra wrote:
> Currently, a local dma_cap_mask_t variable is used to store device
> cap_mask within udma_of_xlate(). However, the DMA_PRIVATE flag in
> the device cap_mask can get cleared when the last channel is released.
> This can happen right after storing the cap_mask locally in
> udma_of_xlate() and subsequent dma_request_channel() can fail due to
> mismatch in the cap_mask. Fix this by removing the local dma_cap_mask_t

This should carry fixes tag


> variable and directly using the one from the dma_device structure.
>
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> Signed-off-by: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
> ---
>   drivers/dma/ti/k3-udma.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index 7ed1956b4642..c775a2284e86 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -4246,7 +4246,6 @@ static struct dma_chan *udma_of_xlate(struct of_phandle_args *dma_spec,
>   				      struct of_dma *ofdma)
>   {
>   	struct udma_dev *ud = ofdma->of_dma_data;
> -	dma_cap_mask_t mask = ud->ddev.cap_mask;
>   	struct udma_filter_param filter_param;
>   	struct dma_chan *chan;
>   
> @@ -4278,7 +4277,7 @@ static struct dma_chan *udma_of_xlate(struct of_phandle_args *dma_spec,
>   		}
>   	}
>   
> -	chan = __dma_request_channel(&mask, udma_dma_filter_fn, &filter_param,
> +	chan = __dma_request_channel(&ud->ddev.cap_mask, udma_dma_filter_fn, &filter_param,
>   				     ofdma->of_node);

With addition of fixes tag in subject,

Reviewed-by: Udit Kumar <u-kumar1@ti.com>


>   	if (!chan) {
>   		dev_err(ud->dev, "get channel fail in %s.\n", __func__);

