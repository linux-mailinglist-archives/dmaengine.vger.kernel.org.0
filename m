Return-Path: <dmaengine+bounces-3643-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEAF9B634D
	for <lists+dmaengine@lfdr.de>; Wed, 30 Oct 2024 13:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9452D281203
	for <lists+dmaengine@lfdr.de>; Wed, 30 Oct 2024 12:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9289D1E47AC;
	Wed, 30 Oct 2024 12:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=metux@gmx.de header.b="UxbVmpXW"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8B51E9066;
	Wed, 30 Oct 2024 12:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730292587; cv=none; b=tTBqZdEbrR6j1L0WV7aTvrbcOhp/wn9myBG0TKQ41+VmI7zMf/vLPnnQ3SObAXUxNib8+KZSeq2WwNNb5gaW0B3EWrIXWMvnIWgYe87vsFdynU1jQkUGlhHc8rhruVblYSNNLDzGL6HN/LiSTcBAu0DPFBBKeHW1gEjswYBiS5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730292587; c=relaxed/simple;
	bh=+YCnTpHf4kgqcsvGPEJmRwKHA8R5k5OeoiGplCCzf7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OwPtEP3D/a3ACyOXZS2HVEF7dK4/AyQzb7VLQfdEEomhe6oS+Wz9o41KmnN58L7qj/wMkMw8u5ZvVbt358Yhv9Zw6qkgwitjzfxDke2GpKYJhYWjgfsw/BeqqrEz3yQsIn5ofkeUQig1lHEeQsLzi6uuc1Xt8nVL0jQS790QoDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=metux@gmx.de header.b=UxbVmpXW; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730292502; x=1730897302; i=metux@gmx.de;
	bh=+YCnTpHf4kgqcsvGPEJmRwKHA8R5k5OeoiGplCCzf7Q=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UxbVmpXWvyWFMdu+GATuiw1ytz1oNpvm5GNdgPbapjupaP25dsmWNYV/SdmkFCpE
	 VX+3bwgCyi7J1vZWt8hxBFNjCqYXAs/90EF5MTi5XI4T3wPAud49gsLSmSGWAgCFH
	 L/MlMEdcnBrC3Z6I/Y0EX4qgIzoVFOZM2ueUS8NENLEQofE14R0wXa31OvlhCEm1F
	 9lgOEB79j/9vjsYX9KbXu2T/UCUxO61Yl+VZqyc98kF/0soDrfczquDVKjoNkb+Qg
	 C3a2MT2iG3Shr2kXGTjhv+n6z7zTnhYsIVyC7TaB+61rRJr4ZYE9Z0EHkdrRrpF0j
	 0MTyH7Gn6TRMn1XJ3Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.178] ([95.114.207.188]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUXpK-1tExqH3yV6-00WDT5; Wed, 30
 Oct 2024 13:48:22 +0100
Message-ID: <d769ffcf-95e6-4db9-8f80-fe8a7dae0441@gmx.de>
Date: Wed, 30 Oct 2024 13:48:45 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: lore.kernel.org getting senile ? [WAS: [PATCH 1/2] MAINTAINERS:
 Remove Huawei due to compilance requirements.
To: Vladimir Vladimirovich Putin <vladimir_putin_rus@kremlin.ru>,
 torvalds@linux-foundation.org
Cc: aospan@netup.ru, conor.dooley@microchip.com, ddrokosov@sberdevices.ru,
 dmaengine@vger.kernel.org, dushistov@mail.ru, fancer.lancer@gmail.com,
 geert@linux-m68k.org, gregkh@linuxfoundation.org,
 hoan@os.amperecomputing.com, ink@jurassic.park.msu.ru, jeffbai@aosc.io,
 kexybiscuit@aosc.io, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-fpga@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-media@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org,
 manivannan.sadhasivam@linaro.org, mattst88@gmail.com,
 netdev@vger.kernel.org, nikita@trvn.ru, ntb@lists.linux.dev,
 patches@lists.linux.dev, richard.henderson@linaro.org, s.shtylyov@omp.ru,
 serjk@netup.ru, shc_work@mail.ru, torvic9@mailbox.org,
 tsbogend@alpha.franken.de, v.georgiev@metrotek.ru, wangyuli@uniontech.com,
 wsa+renesas@sang-engineering.com, xeb@mail.ru,
 LKML <linux-kernel@vger.kernel.org>, phoronix@phoronix.com,
 redaktion@golem.de
References: <CAHk-=whNGNVnYHHSXUAsWds_MoZ-iEgRMQMxZZ0z-jY4uHT+Gg@mail.gmail.com>
 <20241024140353.384881-1-vladimir_putin_rus@kremlin.ru>
 <20241024140353.384881-2-vladimir_putin_rus@kremlin.ru>
Content-Language: tl
From: metux <metux@gmx.de>
In-Reply-To: <20241024140353.384881-2-vladimir_putin_rus@kremlin.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1/p4ha3marvAu2CXeYNmBSD+weQhVbztKCP0nISPKnffRdbsPI3
 zPctzMmHLcQZTqlh2zjZzgis1SjXx91Sovsuto7k7PtiaIGSg5OcFzLBWgRcu14kWBAZy2V
 6iBOO6GAd+WQX6yFBtItp11ISEXll6ojoO2a1WoqxVo2LnaaL9WPMNYPLxG752dUTxTITZF
 LcInJHKfb0M4bP+h7xstA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4vaZnIPP94U=;1c9up5UAbh4Ag/QzXUXNQvA2l0p
 44Ceg39Q9FQgjnuFRb4ctiEQZ6+ThY3ohI4R7ghaxJvwW9GLmQklj8ELuO6HJZM3haO1kBQuj
 lPf9DjnCWUfcGZ6Ecr8v4m+aEFlTj6r1/zlhPs8EVJwnS4Pe706PuXTBJpkg5WIn7GxOQO2JW
 XajGhvRcjBrJhZNk7taO4FNBbp5dLDGkB6UepQiBXV68RMT6oTpFOwswwn3/eBeat+lHalNB/
 gw+WciTtplBXIMbtRlqxaAJboJIHQLy0eXfzWRe/U26hY4FalvSL6RW63w2giJVSyCEe63Xf2
 pnU7T294h4NAY+Lk1Uh+0usTGhMn+kqSHhbyz6XuQ9SUym/02iNMzOAUQU4B9rMEU5q6ZVIUd
 0PZ3f2zoM/AhE/8kfql73M86UBv0ANHdx6CqwXixMw8ZaIdo+GaFI0OcAUT9fQKIyYZczFTBp
 AGABaZ971CQOkfqz9ZNcYAdXDG9laz6+7WLmruYJKXEeAyGdx7twTMJrs8FULcTe1ZOzQm3ZB
 DT9XeRboVEyBNz53wj4/qAD1UsQODVRq/XAMxGruSGXdp9S8U1GLjLvbeblVDHTp4i143RIfc
 UOHfXVzYXn7bC0uCHBJq1Wwe+j/PPMUEteRmxPqlOJxW/zJnk/+MhQ+nsjD3nQeqM4mO62C+8
 cGyUVjqqCH9JFck+CUdFeZs+muR6CcuaNof+jRlxFMXiRxLHv+44RU3hyg04PrdKE21G5zjmC
 EK9fu4IcYIpfrqOOb5TemzZQb0+1b1bsoLkyszrXyxOXZlQryGt702z9+snDKhQG4NhdmMGOd
 ZwypTOh+SvzsGp5g+0qej1rGVGE9aJPkSwI0X0drGzsuc=

On 24.10.24 16:03, Vladimir Vladimirovich Putin wrote:
> Huawei Corp was added to the US Entity List[1] on 08/20/2020.
>
> The Entity List is a trade restriction list published by the United
> States Department of Commerce's Bureau of Industry and Security (BIS),
> consisting of certain foreign persons, entities, or governments.
> It is published as Supplement 4 of Part 744 of the Code
> of Federal Regulations. [2]

Interesting to see that this message got removed from lore.kernel.org.

Google still has it in it's index, and marc.info still has the whole threa=
d.

The internet doesn't forget.


=2D-mtx

