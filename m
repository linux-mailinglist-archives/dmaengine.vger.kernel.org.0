Return-Path: <dmaengine+bounces-4905-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2FFA90EE2
	for <lists+dmaengine@lfdr.de>; Thu, 17 Apr 2025 00:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77760173603
	for <lists+dmaengine@lfdr.de>; Wed, 16 Apr 2025 22:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE998245025;
	Wed, 16 Apr 2025 22:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="iG9QV8HT"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894AA238C25;
	Wed, 16 Apr 2025 22:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744843778; cv=none; b=QVgHu99IH8HexIjtgkqf8jUpkHcWISz37ofXSSRCjNU7eSYo3LWzdc6/E1VmVjQvAVRoxsBoj8kPihTo7ujoiNbRaw46tJNXWcmhO3FQsYoH/w2Z2hspV0uoTfvC1dN+Vg5C6PsT1kbid8sbcQs+PqGUEBsLLVKtY7W90obe9Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744843778; c=relaxed/simple;
	bh=zhARHuIhbLTyXHkW6CXECsYiL9+R0A5TAIw+AjmN5vs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ox7bvdfDaPbft/e05Rob5B8yAtGQkUWckDGdnKeLNnZ9uo9oYYfyIDhF9t2Sppa3kYXOq2sRr525spK2fyqVWnf4Hz+TsHCuiDMa8AbNkl1llPdqqnA6qBDi3ofUn44GPpJKWrdzkim5bfplNFqyTdU0Ylnoz0zX1hQnusPioco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=iG9QV8HT; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1744843771; x=1745448571; i=wahrenst@gmx.net;
	bh=zhARHuIhbLTyXHkW6CXECsYiL9+R0A5TAIw+AjmN5vs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=iG9QV8HTd3rUGkA48XDBauUafE5EH4g0rcbxil7U9wnhzDzxH0TGNSBox+tp6En5
	 LQNCsudckMAssmXMdY+GbWkau3ClsQ6frrlo/sVn1OKpPdTKHKEmg1IXTej/ZzkuB
	 XcMHt+vAJ9hzpG4UjUTBFdpzo2BAsJQLj0BcDvpidVy4h6JhKbEdASqJY7B9KQ5cL
	 0CRcoEk99hQYxSSIL0aW3mlRULFxp30aFWiW8NjBiiZioKoLjrT67/Co11/rwuRsn
	 qwjw5VQIq/dSMGs1oW9XktOSI7uIMekawXPHhsHX3wkXz1IL607xVRUbJ7mTAqpmo
	 a5znv696IHb7emeb5A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.107] ([37.4.251.153]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mzyuc-1v2Dq13NdW-00xVLq; Thu, 17
 Apr 2025 00:49:31 +0200
Message-ID: <2d5c6d41-90ee-4f33-866f-a8454162e41a@gmx.net>
Date: Thu, 17 Apr 2025 00:49:30 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: fsl_lpuart: imx93: Rare dataloss during DMA receive
To: Sherry Sun <sherry.sun@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Frank Li <frank.li@nxp.com>, Joy Zou <joy.zou@nxp.com>
Cc: "imx@lists.linux.dev" <imx@lists.linux.dev>,
 linux-serial <linux-serial@vger.kernel.org>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 Fabio Estevam <festevam@gmail.com>, Christoph Stoidner <c.stoidner@phytec.de>
References: <a9263ccf-2873-46e4-8aee-25e0de89a611@gmx.net>
 <DB9PR04MB84299ACCDAFE6427B30699F592B42@DB9PR04MB8429.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
In-Reply-To: <DB9PR04MB84299ACCDAFE6427B30699F592B42@DB9PR04MB8429.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FjJumgb112Upp1kgY9X3tzPlFxJnmFPdBpwE9KWJw6Q4we6WhAy
 9EXcTm4YxTp1JjwHBF1sVT+y/rjNvjhShXKra5j2DJk8l8mgsJJnBsYlKq8BdZ9JBkCm0Z9
 lF6tCxQs3gN6GqVrJkv6o4AZkOXWrNVknMohaxL/t+qAKDIDy6VqRZWfLCih8Zc3OkWgG0x
 HcQX53RsHklDieQVkJKsA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:E7J2OZxbYp0=;1mu8zmy9oXp9FTppcd+c/+bUlxa
 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

Hi Sherry,

Am 09.04.25 um 11:51 schrieb Sherry Sun:
>
>> -----Original Message-----
>> From: Stefan Wahren <wahrenst@gmx.net>
>> Sent: Wednesday, April 9, 2025 4:19 PM
>> To: Sherry Sun <sherry.sun@nxp.com>; Peng Fan <peng.fan@nxp.com>;
>> Frank Li <frank.li@nxp.com>
>> Cc: imx@lists.linux.dev; linux-serial <linux-serial@vger.kernel.org>;
>> dmaengine@vger.kernel.org; Fabio Estevam <festevam@gmail.com>;
>> Christoph Stoidner <c.stoidner@phytec.de>
>> Subject: fsl_lpuart: imx93: Rare dataloss during DMA receive
>>
>> Hi,
>>
>> we have a custom i.MX93 board and on this board the i.MX93=C2=A0(A1 ste=
pping) is
>> connected via LPUART3 to another MCU. Both processors communicate via a
>> small protocol (request/response are smaller than 16 bytes) at 115200 b=
aud
>> (no parity, no hardware flow control). The i.MX93 is the initiator and =
the other
>> MCU is the responder.
>>
>> So we noticed via logic analyzer that the i.MX93 sometimes doesn't rece=
ive
>> the complete response (no framing issues). In our setup it usually take=
s 1 or 2
>> minutes to reproduce this issue. Interestingly this issue is not reprod=
ucible, if
>> we disable DMA and operate via IRQ.
>>
>> The issue is still reproducible, if we disable all other DMA channel ex=
cept the
>> ones for LPUART3.
>>
>> We tested with Linux Mainline 6.14 and Linux NXP 6.6.23, in both cases =
the
>> issue was also reproducible. We debugged the relevant drivers and notic=
ed
>> that the UART detects (UARTSTAT has RX pin edge detected) the RX signal=
, but
>> there is not reaction within the DMA driver.
>>
>> Is anyone at NXP aware of such an issue?
>> Do you have some suggestions to analyze this further?
> We have not observed this issue in our internal testing, some debug sugg=
estions from fsl-lpuart side. Perhaps Joy can give some suggestions from e=
DMA side.
> Please try with Linux Mainline 6.14.
> 1. Can you please run "cat /proc/tty/driver/fsl-lpuart" and "cat /proc/i=
nterrupt | grep serial" when issue observed? That may help to get more inf=
o.
> 2. Can you please check if the issue is still observed after enabling ha=
rdware flow control?
> 3. Can you please check if this is still observed if setting rx_watermar=
k=3D1?
> 4. Is there an easy way to reproduce this issue? Maybe we can give it a =
try.
thanks for your fast reply and the hints. Sorry for the noise, I figured=
=20
out that there was no dataloss. There was a bug in the test setup and a=20
misunderstanding how thinks work :-(

Regards
>
> Best Regards
> Sherry


