Return-Path: <dmaengine+bounces-6331-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 713B1B4043B
	for <lists+dmaengine@lfdr.de>; Tue,  2 Sep 2025 15:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4050F7BBF24
	for <lists+dmaengine@lfdr.de>; Tue,  2 Sep 2025 13:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C362430649E;
	Tue,  2 Sep 2025 13:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="sI87RtFx"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C2A311592;
	Tue,  2 Sep 2025 13:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756819870; cv=none; b=EDDCYVoclD3gS/OapUwelHRR3M9G6ZbKsWJUmDPI0QToQEUsMQfbqFSXB9ad/kO96924jaglLJPCcd7jSii7WpBLI+Skv0NvQ88dbSJ5S3hSYlhMDW2q69u3SMrkuqluTw3gj+na1ti+C3HqK2k4loDMz6z4Qwru8jYh345Z7Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756819870; c=relaxed/simple;
	bh=wHopyso6SK9NeVUA6eEW3TVJb7lAiyEBz8kTpAsiGEA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=KiSEwAzsxf31fQDgQgtUJFf1LCqckeoEA5RDp0yNs552b+76zw1TtghIeSSDx+YIYlc6xSQ8L3MNTLp1ZHT3cQG8vGUgbypKnNix2+1BlcUTdTChVlwf0+prLxsEQqtOfDEuLfIcZpn9CKe6zWmfDJza0jaf1CCAQvj99501R/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=sI87RtFx; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1756819861; x=1757424661; i=markus.elfring@web.de;
	bh=wHopyso6SK9NeVUA6eEW3TVJb7lAiyEBz8kTpAsiGEA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=sI87RtFx+h76BDzaJaOqY+n+xwoyv77bFUkWS8rBbQZHcREaqY2DW5O0LtFeVluu
	 pE9vzntpYd6J3eWFSFbG/OYyD5WUn+NNrbboQL8xZK4AN+D+yZbAkOBXWKqNcYAaG
	 Lm4a8sZcen0cirKKdXUnjLB9Inoyvih3pjnJ9zHOq/do163zvi8xkthYn+oIBX3u9
	 jyjG1nkPvXGQ8yLZ7yo5IuEXkSveV8ECkBQGTEoezn9IQ/Po7G8DGP3fqrAScqXTM
	 Cq9STUUc12Q4SGpR4WY/ha173dcQPco+uMtCNiEKo3PU1aAvk3oqOkopZenUz+wdS
	 XeUth850Bl2IZhltgw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.184]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N7gXO-1uNpf531CU-00vRdD; Tue, 02
 Sep 2025 15:31:01 +0200
Message-ID: <197860cc-6658-4a5f-8325-0340470c1602@web.de>
Date: Tue, 2 Sep 2025 15:30:59 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?B?5p6X5aaZ5YCp?= <linmq006@gmail.com>, dmaengine@vger.kernel.org
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Vinod Koul <vkoul@kernel.org>,
 Viresh Kumar <vireshk@kernel.org>
References: <CAH-r-ZHx+vcL3QY0rKP3Lo_qofYLSuxCxqyb=URPSbnStxA5cQ@mail.gmail.com>
Subject: Re: dmaengine: dw: dmamux: Fix device reference leak in
 rzn1_dmamux_route_allocate
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAH-r-ZHx+vcL3QY0rKP3Lo_qofYLSuxCxqyb=URPSbnStxA5cQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:sFM8PYhGtZ1LxyYw8asdTZEPRIWuYUZfts07TqaSXrs9A4Xvrlu
 MDtw8rU89wHK2H9rMhl/gYK5Ob/EpkC8ih34jjNWKNdghs6RXyI5aU0Z2Yf5AgLDDF/EvcO
 CRMYSAyWbX/ZC2APMPhDHQwOx/Efymgu2sUo9YVL7jPCRyDJ0mx63fZHUFxl3dPl4fUhV2r
 mSMKW4l/2srSYGhZg1QPg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HlFptODJQeg=;BR1x0A7B02lHVlF8I5WlKzhGXsE
 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

> This was found through static code analysis.

May you point the software tool name out?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/researcher-guidelines.rst?h=v6.17-rc4#n5

Regards,
Markus

