Return-Path: <dmaengine+bounces-3671-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 082179B9E05
	for <lists+dmaengine@lfdr.de>; Sat,  2 Nov 2024 09:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E68A1C20BE4
	for <lists+dmaengine@lfdr.de>; Sat,  2 Nov 2024 08:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB44158D87;
	Sat,  2 Nov 2024 08:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="Gecmhibf"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D75136351;
	Sat,  2 Nov 2024 08:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730537874; cv=none; b=W8NpTq2yqfOjb8xMOjBesGUqTLlKCqhAANxUBCmjIvpiMe1x1hMJoM95JUpqP0PMU/orEGVNQgiaTAYBhR6uwZjuxd7vh9L9shiE9wjwuLfd3/Qm43KJPCOPGbFiXMgB3kyEysk9bfi4W4Vzaq6D45ZMiMX4lWev6+EIi1xmcxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730537874; c=relaxed/simple;
	bh=ktTzf+Lq/jTkyU7b4tfI8pRlbwVRvpmf7PEUMuveifk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=K+I8vMgW2Y2bu8upLlsQMBCemZdd8EsFEoyLKcEtLTQKbnTLjjoX+zwhNm5fOdm2g+gqCgjjb/skGCS4glj/hlLZwS6hx41oTjWuLuhM1pGiw3dfB4MVFdO8hLbkMefIEX2IapMhn6BmnVTEGECKwZ0EmjH20iUQ5Cw1Mq3eDVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=Gecmhibf; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 4A9CEA09BA;
	Sat,  2 Nov 2024 09:57:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=oHkSNNNrwMqpzUY5rzOn
	LOxgjwpzlT3G1/0AWJvzSww=; b=GecmhibfrMQ6yCpYosL1WkhOmP+xHjG0iK9T
	6HiDGbqFxSQJxakL1sdfOlYdSRyBZqJdv+Pe93HUUvlqmowepDO1C4XwWCsf9kOM
	2XJHP1ullatnEIWCLoxQbCPE55CYtzBV1FTQw8RqeW2tK7KiPdXREFqxtd8ecp0l
	kJKkBStlW1p86Y4irCxPCrursQBsfkZN7aclHCskVrzNDY68aIvvDESexkn0N9Zz
	Zb6NlxIo2iaQCqx0KcOIBJs3vD4LxEO7DMLZE1Z5IzyrTl1iRQlzEkQ+OlXZpTPi
	X9+hxobi0YYd7oht8C5/F4+H6yyLWrbxk1SE2S2HyV3jVzXEMCnhZydBUrOQrjCg
	zU6hnORa97kwcYB0P+gN9Ug2v3Bnd5xtiXW3PhpzIkb89GVaOmLLJ9zLlcCNUq0p
	CMZfuLCWgqabPYBkSGgY9ARpeg2JaUoMUVPI5B9xJ6PGbpymlNl/cQ7v7ay8DWGN
	3Bs/AWCUFwwo4nnvdbu4njLRzzJjaLMqVq8Xf8AA74rhZQ6GqoxRtlozDJ4uZDQc
	/imM9iHRGNQE/swcmEa7UrzZ57Xni7PqqnfXb3NWwwzMVFOZ3fGz0hQbga/UqN8W
	q4gcnmp2gFX0Szwejb5/JEejhgHtt3M2hmpdzNWY0W0wBQPApb+AQXwVdjFlUqqG
	vBokBzo=
Message-ID: <ce76f036-d8ac-4f3b-a229-ee1550c2422a@prolan.hu>
Date: Sat, 2 Nov 2024 09:57:40 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/10] dt-bindings: dmaengine: Add Allwinner suniv
 F1C100s DMA
To: Rob Herring <robh@kernel.org>
CC: Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>,
	<dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Conor Dooley <conor.dooley@microchip.com>,
	Vinod Koul <vkoul@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Jernej Skrabec
	<jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>
References: <20241031123538.2582675-1-csokas.bence@prolan.hu>
 <20241031123538.2582675-3-csokas.bence@prolan.hu>
 <20241031181749.GA1260045-robh@kernel.org>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <20241031181749.GA1260045-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855667067


On 2024. 10. 31. 19:17, Rob Herring wrote:
> On Thu, Oct 31, 2024 at 01:35:29PM +0100, Csókás, Bence wrote:
>> Add compatible string for Allwinner suniv F1C100s DMA.
>>
>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>> Link: https://lore.kernel.org/linux-kernel/20241024-recycler-borrowing-5d4296fd4a56@spud/
> 
> You don't need a link to Conor's ack.

I don't? I thought whenever I collect a tag I should provide the link as 
well...


