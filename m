Return-Path: <dmaengine+bounces-1397-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF8787DD2D
	for <lists+dmaengine@lfdr.de>; Sun, 17 Mar 2024 13:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41CD61F21171
	for <lists+dmaengine@lfdr.de>; Sun, 17 Mar 2024 12:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261B917BDC;
	Sun, 17 Mar 2024 12:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="ay5j6jZ+"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA199101F2;
	Sun, 17 Mar 2024 12:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710679129; cv=none; b=S1APLIXKEliOZ1v/8ICPz9Lki3HdUXKmJI7s4+mWwqOl1IuMCvrxiYsk7xHDe7pTP6P1B+w1yBqVk3yhlNrmyjEggiQrsQVMIrneaL/XYGuBwdnvxrkfSZ2hAoGdQ/gyg4nfM/iD7tUsRqX5FIdJQI9OmtX9nacNoOrxOjIKyi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710679129; c=relaxed/simple;
	bh=iSBPOsdjtX7UbRvVNMVGHDzbS7W5NKYFCaEOK/NTW3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LtEBXj3sFjo7p4od8yZeaCWfi+i9odJPZjnsgtH5ZkoTxNq52yUzrxMei2dc9+hBAjxJ1zXAw9flC5zqnGryycqrSmsAYfvjwO5dwtj92eNCzULw/OuN9dIdnUkbpB9PgR0fnYE7hCbFmo0MGAOHJCTOzCU2Cbp07X4o/J2MXtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=ay5j6jZ+; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1710679106; x=1711283906; i=wahrenst@gmx.net;
	bh=zfe3aPmvxcJ7/kLQ88HcrCYxkLZiaMT4IF+coNia9Mk=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=ay5j6jZ+HPqaVK8ONwzbm/BT5XzKbP7cPO0zB8OU6HwnWypPNWOgihganLfHmcnh
	 BRxwwvn5DHwwMk9SEMXiUtiPL5Z4lfLyjncMyh9HktR0UVA16Gc2wCFZvVrSuEXFJ
	 H6mDNYzLFT943OaAh5sfTfUrxGFHX9PWQ5Hv3ncA/qbUW3pjbqYyW+CvG6PJbqn89
	 +nP+DY+G8gDE+mkjVnEGcdXId7v2dRIl4qyExmwDPkMnMXIlIYm/n8hQL9pKxPScC
	 Bz2Tc+4qaIQ1S5clTGtOcC4u4i/dIvIAZOOVdORqktVjGcb3CDYVfsM5A6zRT4ajW
	 ZUm1HrwZIOvzn8W4bw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MzQgC-1qqRuM2JAe-00vNaw; Sun, 17
 Mar 2024 13:38:26 +0100
Message-ID: <82eb2b49-639d-48ca-a035-c3d250c251c4@gmx.net>
Date: Sun, 17 Mar 2024 13:38:25 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/15] dmaengine: bcm2835: Add BCM2711 40-bit DMA
 support
Content-Language: en-US
To: Andrea della Porta <andrea.porta@suse.com>, Vinod Koul
 <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Saenz Julienne <nsaenz@kernel.org>,
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, dave.stevenson@raspberrypi.com
Cc: Phil Elwell <phil@raspberrypi.org>, Maxime Ripard <maxime@cerno.tech>,
 Dom Cobley <popcornmix@gmail.com>
References: <cover.1710226514.git.andrea.porta@suse.com>
 <8e4dceada017ea4804d7dac16c2a4974807a2c01.1710226514.git.andrea.porta@suse.com>
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <8e4dceada017ea4804d7dac16c2a4974807a2c01.1710226514.git.andrea.porta@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0mueHzFAPCkdqgs2qk2n8y4iViR+SDKNxy1sUQ8kq8+HlPXpAoQ
 QU3NjkcwjxzoG4h7kKj9/LW4v+9Qzkw+gxCK1G5LZpZCTAnGJl60QNJr3piZzK8qDBIiiOP
 T5FQkWyp1KeO2pwsY7NTahQQwkd3lbyeD5ULaC1dowFuQsG9uQ3HPonkrHIONCCcWIgaa9L
 lPoIOBw0CHKVaZ/h3baTw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZQ0qbhhdjmU=;I5bO9d7ISGYLSnxOrvhHBCLrWyH
 IehRiPd8+jXNtMtVAL0SoKublmvY8g3Qjs/+rnXxmECWAhgrvr8R2L0Z9ap/t87FTmB+KOz9R
 H9FufJOMmxTc1oYSIsTrcqhBM9MHbyl4m+W0aAmtIduH/1kJd0vWDtCO6y/PSd1A07AiU22OO
 9ecxlAxEZmlyGY9PXELL+QikGxrLouLbhANVzELC2RHoh99AA6E9NE6ZsVaYjfmxhqUK3ZUqv
 mlVwUQqrS0iBiNUuvV89LnPfo5n0opxEEoVUP9y5KTe7hsL+2HQ/H2hUJOlUMX+jWLQUGR4bh
 uQTXDN752ccdUQ/EMJ+W9xz2hNtKpi5Wvmz/We9hBvxSPp6H14x18yc6iLfWK8dHfiB3Fjdwy
 wZZRDIUL5HfDhk1Ufz7QGmSOs/CeyzRw5zT34pknbFkA8BxcVywad3PL5+vNwM2odJ1NR+/o3
 VbI+7pS3H+l68TQjJpmoPMOENcofkSutm/crCEtp3prElBtN+ffUCFdnXoTBUzH3wRBJKXho0
 6csneHQrEtzNuNCXRIZiluDc86dipdKkCNFbtmWKREyn0DOwKOMfePcVvIWYJhb1dNZ0VWV+O
 lhQMobE0b2FtT/n5doxAHnMLZ6L8hbrMDJlH/+j/ViydJ0sNOXrh/Dcdf6gQ1UOjh8YMA8zin
 xnuOQazvNFeqSDZPsLmq7Avmt1OUk9L1Py0uhz8+iSSe2Uv2tsJftPEReDmFGkjZqDkSU9Isp
 f4TbfWQdGu5SYVyJjDxnAF6uBy3ymPCEnEE/Ffcdr5ppMaHqGos/xPghXyLrSwjKUtl4Ej3Rz
 +yx8NWYqfiMB/lPTZkhlIatgXKj9acUbSDlWvXvi00/Uo=

Hi Andrea,

Am 13.03.24 um 15:08 schrieb Andrea della Porta:
> BCM2711 has 4 DMA channels with a 40-bit address range, allowing them
> to access the full 4GB of memory on a Pi 4. Assume every channel is capa=
ble
> of 40-bit address range.
>
> Originally-by: Phil Elwell <phil@raspberrypi.org>
> Originally-by: Maxime Ripard <maxime@cerno.tech>
> Originally-by: Stefan Wahren <stefan.wahren@i2se.com>
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>   drivers/dma/bcm2835-dma.c | 553 ++++++++++++++++++++++++++++++++------
>   1 file changed, 466 insertions(+), 87 deletions(-)

this patch contains a lot of changes (including style fixes). It would
be better to split this more for a better understanding.

