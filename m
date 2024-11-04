Return-Path: <dmaengine+bounces-3683-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A30719BAD5A
	for <lists+dmaengine@lfdr.de>; Mon,  4 Nov 2024 08:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2174B20956
	for <lists+dmaengine@lfdr.de>; Mon,  4 Nov 2024 07:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6566419993E;
	Mon,  4 Nov 2024 07:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="UjAozkVg"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8999B1917C4;
	Mon,  4 Nov 2024 07:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730706130; cv=none; b=lomGJM31zczkZYsbjIHg5588wMjh7WO4g3Wq5kZWvyvqJLnJpm9Etu9sfbaspmFTgnoTL3YtLla/nXaMMkLGY5i/N5MDpkMZbHxX/8w+OM1LB2LyfWvYJNCJDUxTTV4pxlV5n465dpFkC4CBKM3coRJbFXVIKzAz3XbgN2TX6Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730706130; c=relaxed/simple;
	bh=qMok5bTyC6I0n09Kq6tGo/rOCJ3udHa3x/VGuqvBrUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dfceEqqG2mWAAfkvaUL3LDwywFl11vYEfsaKXCQvf7FUo2RtlNin2xyv7dmSafkUpccx5hr2rEJjiUEtr2pBaF1xY5LBwYesIMyu/rcHWiEIcCwqZBe+HE0AaSTC+94YIaclIWwONt4W4DQvpvKIbM6ghuxRCj8rSIJeL8jZuUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=UjAozkVg; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 9F2F4A03A7;
	Mon,  4 Nov 2024 08:41:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=xv5bUFMxs4KAHpxzUJns
	OpeLi4TFFl07AzHMQZEr5RI=; b=UjAozkVggqW7Pn76P3FQKyuO1H3QhUzKCKYG
	MXPGw/eeO+RT3nzUhFoQww6cJYUhECAu0iFRc66fHZG2pPfoMgFHWfRR7mAkgnd6
	tqvzdWluQ2BCtaPBInFwCA3LQ9cXcMpBFo1hv92cARW8sIYOz3OZPfWKrOOGRbR1
	OLbxrn0RJhp7yVl5QJuBtUk/Ao7uu4hrRHFXsFONq93aMs2l2JPikLZG3/EKPQSa
	tiSG6Oaoctb86Fnea2mE8+8+broZ1SdCvqRUBf/+cRLC/M1/QKhT3H3WacZyCU48
	ViPwCTZKybSK/WEVoiBB2QZykK4UDM6pAIpanlaPl/5bjSDbfNrURQiYSg6xBJLG
	ui1lCNRghhAk8JDqkxhZT7vUu+WazarSDyZcpIIXuNhkTPOKG8EVLjY/p14yukJ4
	0zpZ5ILtEC0U4oneBRww62WoFibPhvK1Ky/hOERdtKazEBfFZ6O2FXJpwd8I8Nrs
	TYKb0iKDMIxX8CtcmdiFfoQQNISwAg06LyBJOOqsLvlukQ6zoY3bbaN0CoXhl95H
	dXhwlmsx14UbGUp7II0uUk9kwf6yr39SjAjR2b3dPgEWQbsnid1r+D3Y/rS3ILic
	qb8inFrxASzV4CRmz1hldWWRMBvXcBIR8LWvWQGaAa2OSvcbKYizEv45MOUO88g8
	uZiOEJ4=
Message-ID: <656fab96-b326-4721-9b55-2b5e3d652703@prolan.hu>
Date: Mon, 4 Nov 2024 08:41:56 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/5] dma-engine: sun4i: Add has_reset option to quirk
To: Andre Przywara <andre.przywara@arm.com>
CC: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>, Mesih Kilinc
	<mesihkilinc@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Vinod Koul
	<vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
	<jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, "Philipp
 Zabel" <p.zabel@pengutronix.de>
References: <20241102093140.2625230-1-csokas.bence@prolan.hu>
 <20241102093140.2625230-3-csokas.bence@prolan.hu>
 <20241102174516.02d124d6@minigeek.lan>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <20241102174516.02d124d6@minigeek.lan>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855667261

Hi!

On 2024. 11. 02. 18:45, Andre Przywara wrote:
> On Sat, 2 Nov 2024 10:31:41 +0100
> "Csókás, Bence" <csokas.bence@prolan.hu> wrote:
> 
> Hi,
> 
>> From: Mesih Kilinc <mesihkilinc@gmail.com>
>>
>>   static struct sun4i_dma_dev *to_sun4i_dma_dev(struct dma_device *dev)
>> @@ -1215,6 +1218,13 @@ static int sun4i_dma_probe(struct platform_device *pdev)
>>   		return PTR_ERR(priv->clk);
>>   	}
>>   
>> +	if (priv->cfg->has_reset) {
>> +		priv->rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
> 
> Can't we use devm_reset_control_get_optional_exclusive(), and then save
> this whole has_reset bit?

For suniv, reset is REQUIRED. For sun4i, reset DOES NOT EXIST.

has_reset does not mean that whether this instance has a reset control 
or not, that is handled by checking priv->rst for NULL. has_reset means 
whether reset is REQUIRED by this type of DMA, specified by the DT match 
data.

Bence


