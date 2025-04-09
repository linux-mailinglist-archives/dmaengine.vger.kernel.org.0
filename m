Return-Path: <dmaengine+bounces-4862-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC509A81F9A
	for <lists+dmaengine@lfdr.de>; Wed,  9 Apr 2025 10:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 937224C1093
	for <lists+dmaengine@lfdr.de>; Wed,  9 Apr 2025 08:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9237425B667;
	Wed,  9 Apr 2025 08:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="Ky13OstA"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2671E5718;
	Wed,  9 Apr 2025 08:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744186767; cv=none; b=cyGDZJ1HJPu12dlRMO5aLaZgl4QHgXLdjGmY6G2YppzlUH5ecVOkYdVr+pOkVh3RaUDpjnf8qLZC9r8V9TZuceFbfMKOPhgUFP4RiFCPuy8XmiZoS2vhiUtkkWVCD655HKVL+dBz93t3FX48X+5rMertJjjaaZ6bkkxPBetmEG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744186767; c=relaxed/simple;
	bh=cARZ3MoSB/llLZWC/nfsNQVqtIuVgsB9ugipQScHhzg=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=fdJD7T2el8pDXKVq4renMcZvkZU/+RgUMXs6R/IBWMo4cYSOon9H/C9pg8DsBodumlL2pqZ5+2QCDxKYsF/RSB67ZuBkRRdNZVK5ie1tXCY6lEeQscXyDXhSJkDd3aPnm40ijp55xsEf7haoqw6EDTpSm8QoFaAT7w8WpQeoTrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=Ky13OstA; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1744186756; x=1744791556; i=wahrenst@gmx.net;
	bh=cARZ3MoSB/llLZWC/nfsNQVqtIuVgsB9ugipQScHhzg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Ky13OstA/q5D2hES1XeCKmo3E5yjeuRFIWY61QEPcf8dAh4q3ZNQ44sz7eHfwCrC
	 uzIEF+qiqmFuBPNlzwrsVlXVCpRooKs6vq6dBjYYK9hdOPNESjQO1Wtw1fA7lXONW
	 PznwuwnHBtzvBPwyKCcPs6X4lmR2hDjgzDAlVirEP+Afq6zI4XafHL0r8Ih2pnGjY
	 NSg+ot379GSTxa7Kg/moSz62AOhvPEsf2ut+67NscBajwHQw22AzKRV1Ij/Gsc6Jj
	 rZT1hfuAbu9YwxyVYcfPhjHfRYZdjW0MJ3jVJ4pGLPHUsSzETnrf/rj4RxY8h00t2
	 LMNMz+WKgQY1J5WxCw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.107] ([37.4.251.153]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYNJg-1tX8Qz3sZu-00OaZm; Wed, 09
 Apr 2025 10:19:16 +0200
Message-ID: <a9263ccf-2873-46e4-8aee-25e0de89a611@gmx.net>
Date: Wed, 9 Apr 2025 10:19:15 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Sherry Sun <sherry.sun@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Frank Li <Frank.li@nxp.com>
Cc: "imx@lists.linux.dev" <imx@lists.linux.dev>,
 linux-serial <linux-serial@vger.kernel.org>, dmaengine@vger.kernel.org,
 Fabio Estevam <festevam@gmail.com>, Christoph Stoidner <C.Stoidner@phytec.de>
From: Stefan Wahren <wahrenst@gmx.net>
Subject: fsl_lpuart: imx93: Rare dataloss during DMA receive
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OJM6wNRlhitf8b2UKdZrXaP32BiAer6DsVF/VBciG+2tf3jObDJ
 +NGBkRPUd6D31eBI32fahWPGzAQd2IoErWmrGBA6HOKjHck4MgFjr4riUO2kJvNxWqJD93a
 1lXLGwHfsln+YZIdLwsdiC+mFv7X6+TMlQ/eQkvDoPxO6i+dEi0v1iXMxl0RYDK1/fXN4Aw
 gNA3UcYsI3D4GnA9MQpLQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SiBV9w7+K/8=;UCcCE8vRt2bQlX9Qq3i4lY+Nu91
 Tsm1BvlZJA9rPZjsYunVslyZ+siHFGPTuXiOrO3uuHkUOkvYkYZbRplsWqi6dOLp08exFO2M1
 OR3WwjUB1tB8jrVgBdxejZCG4swz5fH9zfBGAkx48OExo73Ymut+U3Xx/3SgqbjdsiCYWgyhz
 fxBOtrZu4mX0PCwBOcC/VDsjGA8S3c8Sxs78pLQZ+yJoOsIdX13nG4L7Ry2OvL1FhH0GRn/n3
 pDI5L0SNFouFroKy4Hcf5QX4ib6cPi90/5dsv9Xj95KYoTwFvsDWq5qn7Qqt8WU6XQFMpHa5x
 e711I+QeIqnh3mcgkEAA3elbxWciHWWNR2Z3Sy4FylteQK77Nv4Ktk9CFhEvEA0NVx4VmF6t2
 6D8PLUy6i8K01hAlCMs/gY1ucPk8Q2jMcNz2hwHQzKkv2TFzbsqHM/xoCs+q7KUkuGYt/mhh8
 7P8i9e0yIpGVTS2MGlDden/cTyuu9L4wCGDGY9o8T39NQR+3CbSmKsFo8yJqhvjh+8bwzCwwH
 Omt846CZwuD1b6zmRYngK9NB4oPSrVX9gvKCAz3+5d9IEp8wS7JvUwvyqehMTyLsB8E9emS2A
 2mh8BfG7xuElwLKhmIHKsaeB7foyh7U4wqHXVQpQcm4/uUPxOjtYA2cxO0JrWjB5ansj2tGxu
 3E2yQFETgX/HEylv6SBr+6kItGloipXsJeBgFVuo9M+idLe22LAixNwrSGGiEhrMW13K7QSq0
 7yntHVMX1rgYF1hmqqohRAZvrcPkLYJ/gZZvFN5TUieQdQIYTEau3MCM/Pdd8ynZaOLjLJ8xm
 CQ85zfatbbNsfR3c9iVN5PM1MbkX8hiKAlW8YrDNYUaeOlL9MX/FF1jlGJrnv7Onw4c/d6P78
 0plRCKg1pIMHF+AP1c+vyTCM2Jnj4WIte2E9WvjlkNbdQTgDovN1KdRaH7uMUTrmiUPO3jYou
 4f+rft42ITN1SmLxRQRPLtBXVNSzzFnmIlCCYtNgt4i21LasiOokPqK4J6lRrHd0uqhbdrZmP
 /R8gdngBBGOaaBqzGK6dqVRRqOwzso/E5QhKDwUPPrHvnz2pkOpSg6y2zvT4xY+Fqw2w5po8F
 R7x6JnYKHQdueZnUBn4lEcOggq6m0Co9A63OzV2ScEi/TbFutGJzg3jmJvJw+tJZzg9oPWPXt
 K9jH35CfN9yLFvKv4Fpqym/ZqmIClk9gzPlCvHvp1L56kk393fFJroSDAt+g4tKbCnKwESoIO
 Qx4mKemdk4BgDZkJx2PQQGPQQT68Tg0GNfhZXNnJp/UaV44uqECKJ/E2X3hKI3v3gd5YGPik2
 rGwGhCgF05pC98ADi1XQ0Ou5pGvS/UXo2NkQ6AO6kWCa/LRtLnMZEG92eVllxpB92FfUEKycD
 hGPlnvPcKxOD5i4/RF4E65/jnRKjsdgXnFYCHjtpy8zslt9cQ39Cmd+Qzv1EHzYdWgW7YXfj2
 i1vFNspVzv+neYkuG43hTLC4fLVE=

Hi,

we have a custom i.MX93 board and on this board the i.MX93=C2=A0(A1 steppi=
ng)
is connected via LPUART3 to another MCU. Both processors communicate via
a small protocol (request/response are smaller than 16 bytes) at 115200
baud (no parity, no hardware flow control). The i.MX93 is the initiator
and the other MCU is the responder.

So we noticed via logic analyzer that the i.MX93 sometimes doesn't
receive the complete response (no framing issues). In our setup it
usually takes 1 or 2 minutes to reproduce this issue. Interestingly this
issue is not reproducible, if we disable DMA and operate via IRQ.

The issue is still reproducible, if we disable all other DMA channel
except the ones for LPUART3.

We tested with Linux Mainline 6.14 and Linux NXP 6.6.23, in both cases
the issue was also reproducible. We debugged the relevant drivers and
noticed that the UART detects (UARTSTAT has RX pin edge detected) the RX
signal, but there is not reaction within the DMA driver.

Is anyone at NXP aware of such an issue?
Do you have some suggestions to analyze this further?

Best regards


