Return-Path: <dmaengine+bounces-7208-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 096B8C64BEF
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 15:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1802335A94B
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 14:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BDB314D38;
	Mon, 17 Nov 2025 14:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Iv/QG6cH"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95199221FDA;
	Mon, 17 Nov 2025 14:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763391334; cv=none; b=D5C/vTq8FzRt9ibR2Gk1iGuoKfKRCf9LxX0kSq5cTmGMvK31BWG4AwARSxyCwO44TJSIzxbwRM5gnvfwazQkANsjQrPe/TUAYXuzu64eZ0Tb/FihaP983ILAXWFYFbogYpVBuSFsLjbMzoWwlNHqRaHdgR9RewhvksY/wtWCikA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763391334; c=relaxed/simple;
	bh=auZ5IpUmby+BNPOWFEnPl3ltv0OBTPlou86Uelx6Z4Y=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=jjSMUorWZ9zzuXVcVo5WuucP7bmtbqGwwodEntgY+xRFg7sedy+GoOAIohGVD1cdBEdoO2L3TEgOIevOHMVxoz93uw8cCvJwp8UpzUomugRhHknNIFq5RJVtw+jabqzfCWbKvZp9ejclqmmaYqOrq3M5PkU0aDdUIvJP44BUhi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Iv/QG6cH; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1763391313; x=1763996113; i=markus.elfring@web.de;
	bh=auZ5IpUmby+BNPOWFEnPl3ltv0OBTPlou86Uelx6Z4Y=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Iv/QG6cHkPJhHnwq+dCQYMJYnGX3jGqDWdRLVpzH0V1ka20NCMTcn6iUwbUdLUPs
	 dEERN6CGrldO6fiMn783/npipoCoVuRdFjHnx9VjSfGLHtgywmXWLn7aNs0auu7/w
	 RlEHUVe8TPdqR40W07lE8VgLIhFZ2fzBVwX0m87CFwFzB63rHK26YIXMcXrYhtdlj
	 tiNCuD8+wPAj+LEBQ1rJbfQF90SKEwB4hoijOy9NWB1o9a60oX9UVdn+Fnw7iSXY7
	 Cpe9O4hJpU72U4Err+qx4BvAlIjSO+NiJ5InaSKNPg90H3Z280G8L7mSDfInwEYlP
	 59IScOtPqKMFsrcCzA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.218]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mm9Zc-1w36tV0xRg-00hG4n; Mon, 17
 Nov 2025 15:55:13 +0100
Message-ID: <1352fa6d-dcd9-4df0-ad0b-11be9fee7493@web.de>
Date: Mon, 17 Nov 2025 15:55:11 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: make24@iscas.ac.cn, dmaengine@vger.kernel.org,
 =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>,
 Vinod Koul <vkoul@kernel.org>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20251117082532.918-1-make24@iscas.ac.cn>
Subject: Re: [PATCH] dmaengine: ti-dma-crossbar: Fix error handling in
 ti_am335x_xbar_route_allocate
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251117082532.918-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vjWcitRxeRGkSI5R+BgoBggalaJAnersi+mKhocfFdQKuhga51I
 F0iA8lArFHQ3YJgS3za22pnj20SwcFK79JnDmonoDIAPmrhX0M+oxrUyflg3rFk7pvM8QkY
 8Ykl2cFxYey1k2mLYYpjLTq2+S+4o50EciG8zr8yOazVi6CZy4McTAyBaarmZJF0OZ8uxoZ
 vkig88d+McFFt3vn8bgaw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ABaRC52M5a0=;0qwWkMip+kL95mbpMSQm3h+s4rJ
 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
 XkbtNNChkdWjWAxil6Z6c7znPh/99EFNrPj95B

> Add proper put_device() calls in all exit paths to fix the reference
> count imbalance.

How do you think about to apply the attribute =E2=80=9C__free(put_device)=
=E2=80=9D
in this function implementation?
https://elixir.bootlin.com/linux/v6.18-rc5/source/include/linux/device.h#L=
1183

Regards,
Markus

