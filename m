Return-Path: <dmaengine+bounces-3604-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 284C49B1F88
	for <lists+dmaengine@lfdr.de>; Sun, 27 Oct 2024 19:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C83521F21468
	for <lists+dmaengine@lfdr.de>; Sun, 27 Oct 2024 18:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93927156F45;
	Sun, 27 Oct 2024 18:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="T0imSiSU"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3850217BB28;
	Sun, 27 Oct 2024 18:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730052242; cv=none; b=ffTZZHDfZ2F/3b0Ze7fPW8gLUwhCQRYRrWTH/DVLfyh8+jENPABvmoUBN80emqyy2usFTOWZXp4M2MJlL3EJqsCSNsRYQTgrj/OrUdLSxnpXcj+U+iKQg/wTa8fyWMeVrVvq8O2UBjsjgqsNhUG8iyOSFyREO3nwbFxPdGTjZdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730052242; c=relaxed/simple;
	bh=ZnZmB8Py+/Z4N0BHxyg2cP7zkwgVmxt+IGO1cvKBO7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WuwRiPwlXwvF9zRug17BEepXuA6tzCdM4YFVeaBg4ziJd3o2oXBZSEMYs1UqtQFZyzILsP8M3dymNwG8cnm8CaSHowFEnWnQ50j7sp7q8+v+n2LJYnf+AM/ANKY+enpGd+8UIkSdXL21qWPHPUkuhPIp8QkRVo8AuH7NBiWP+vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=T0imSiSU; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id C96F4A0472;
	Sun, 27 Oct 2024 19:03:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=SRsfm+4ttOXL38doVebO
	wSAVzLny2y4gp7NYq/iRAnA=; b=T0imSiSUi8SfNPL3bjugdvFvHZv0geCXp1UH
	tLJC9zzHCUbFBmSTSzNuX3u9vjmk5iv+0bRVo2/ibFTsMlEWKjaVE2WudqxhfFv4
	f56qeQPcs/to3UffaXZAbTBl0h2VA1S9FyklHvPOonMnodO42Q9mpbAnTv9TgFto
	bALV1hqIrxhoAiF8KL7cnb0qDZERcOZQ+L1KEDLgXvt+Yg59eCUfF+L+syiUcXGc
	/9MTdHgZFJMTqZbkiCEXsL3E0CbTvLvE5E+H87eYgn7raQZvaoyjAEA3o4VgU/cl
	avmn6OfVx8xejypNAS2oDgoz6BBMDjSg4nvnpJ5Q8bkIurZYENjTvHrW7IUBfmGp
	9Z2XopKN6iPHA4gIsQtm5yOam03Z0sxRLvRpCfPQryhhUVGFuthXBy2zIKa9N7EF
	gJGukIFEMIwYNjcBd+chqW6OqJehE4guSM8cKIEDlFkcrMcSjk7QewH7TPJwyTMS
	rA4znpTmmfbgjRrQzJOjw2Docgon+u21NJbgvuLrdULZ3gwA21n5abAm+c8yvqBJ
	eo5vQcCJSiRpNms1TB7h8nmKtyZyVHUzaeZEBPU2OOAGvEfiIILv8mqxps1I3YkT
	d+leQUWXBMgiFaTsXCJlyOu8r7ATBcT9DH7aT2/wGDq41+e7e6ZkqqbgEPiusQp8
	Q1AvVeM=
Message-ID: <4b614d6c-6b46-438a-b5c3-de1e69f0feb8@prolan.hu>
Date: Sun, 27 Oct 2024 19:03:55 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/10] dma-engine: sun4i: Add has_reset option to quirk
To: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: Mesih Kilinc <mesihkilinc@gmail.com>, Vinod Koul <vkoul@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, Philipp Zabel <p.zabel@pengutronix.de>
References: <20241027091440.1913863-1-csokas.bence@prolan.hu>
 <20241027091440.1913863-2-csokas.bence@prolan.hu>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <20241027091440.1913863-2-csokas.bence@prolan.hu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855677C61



On 2024. 10. 27. 10:14, Csókás, Bence wrote:
> From: Mesih Kilinc <mesihkilinc@gmail.com>
> 
> Allwinner suniv F1C100s has a reset bit for DMA in CCU. Sun4i do not
> has this bit but in order to support suniv we need to add it. So add
> support for reset bit.
> 
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
> [ csokas.bence: Rebased and addressed comments ]
> Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
> ---
> 
> Notes:
>      Changes in v2:
>      * Call reset_control_deassert() unconditionally, as it supports optional resets
>      * Use dev_err_probe()

I missed one, namely:

> +		dev_err(&pdev->dev,
> +			"Failed to deassert the reset control\n");
> +		goto err_clk_disable;
> +	}

For now I'll resubmit just this patch, and then wait for more comments 
that may arise during the week, then resubmit the whole amended series.


