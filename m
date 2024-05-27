Return-Path: <dmaengine+bounces-2184-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 946F38D09E6
	for <lists+dmaengine@lfdr.de>; Mon, 27 May 2024 20:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BA6F1F23868
	for <lists+dmaengine@lfdr.de>; Mon, 27 May 2024 18:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD1A61FCB;
	Mon, 27 May 2024 18:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="eoN8+72R"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFEE2F2B;
	Mon, 27 May 2024 18:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716834757; cv=none; b=tK71SoHNM58NPWKAYXxMStfPXV+uG55eAL5k4IMnCE2NazZt2uPRr/AonXcTQfUn04a1a23/vjwR6WgyKHES7ALoHxazA8Hje5WIEMKyu6DH4PSGMq7zX88JPcPezH3+tRJRKMH7GrcSHuHcXWdV0Im1Ngw6WgCpIyXPHp7FFPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716834757; c=relaxed/simple;
	bh=f1NG8EyCsxK46GkES5qlcTPT4YQSJfe52SwViOa+/9E=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=N+tns75IdXkynGoAk/6FmAvJ6wbhEyAWdkGv8c4DtRYsw3AsLI6OqnNVHxVK6CM6CS0pK0v5YpdHCDst5eYY+Z0Pqt1VxqqujSEam2dj6K/fXjRHz7AsN+6fXeh9GsFu4y6ef7dIYUfn/jZqGdIOCvWkWApyhNCtJnUgvEUm1dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=eoN8+72R; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716834739; x=1717439539; i=markus.elfring@web.de;
	bh=pZFFKlLsRfCpipPUqY1WhEOAnXhn7hIE/lIk8jtjW1U=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=eoN8+72Rfmo0i38Y51JESCjEpr3DKQgzJZgnGtM+uOkYKkqO2tt/swKHnPwjULjt
	 aLfgoQ5jW5uRdiq63WzIhQgPXLy3v10tpYSy6ItJ2nQYdQC3KqsM8+IqEusOR0fCj
	 w+IN3Dq1WnPqiE8ZIQNqNIR8DquolG+cNgGe4vd46oYm8rxBxgKzu1R6H5XFF3G7D
	 A0FNHtzogPn+3hcboa4Svj2PhmsdR+cZYM1Uu2zo2dQmfGpsD//bdZx03SO5ooLZo
	 zrXH1P9/BOrvzTaf6+y4oY/iEeutNTfFasa+fcEmYPWfOAiGcBKBz8aLJLR2lWxQn
	 KtvcrPLggC52veG7Zw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MFaui-1sHkCr1mEY-002nit; Mon, 27
 May 2024 20:32:19 +0200
Message-ID: <f0eaf77b-eed9-4f8e-8009-983250fa56a8@web.de>
Date: Mon, 27 May 2024 20:32:05 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Louis Chauvet <louis.chauvet@bootlin.com>, dmaengine@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Brian Xu <brian.xu@amd.com>,
 Lizhi Hou <lizhi.hou@amd.com>, Michal Simek <michal.simek@amd.com>,
 Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
 Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240527-xdma-fixes-v1-1-f31434b56842@bootlin.com>
Subject: Re: [PATCH] dmaengine: xilinx: xdma: Fixes possible threading issue
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240527-xdma-fixes-v1-1-f31434b56842@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZTH3khqj+zdWbkdstetybfKashnzaduBDY9DmF4Dfh2FSlaeoCh
 MqFZmo/a+anuy+cecYrJWF3ZXW2PtqWvn1rv3cjOxSsVl6q49kM2u4gjTJ9zz8QsUVO1LoN
 V42dazRcLi8j569W/P2Fy06RiT/yNELE60Erlj45gocDUQ153UcBtrSH/AcBxtdpbgQ4Ypp
 W4ikxhPOEwx7AGvJJFA5Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yL2uW7/UscI=;ORtGIrvLLbEjuIzIN2Yi8uSwuQk
 Wqb97UF36Cp4v0tPijyu+TVOY7/3oXbz9C630xFvKIXH13QDXQVNrQ2HzJ3ctTjHxy9yr/Dmp
 /pEBJWfxvMLKp3g+NgEr1OEe1dHKP9P5gLlBNxjFBogQ3L6njj2VdZyM2bi8DHcFTOACveItQ
 Eyfx6D/D9DiybjoXCVFxPefY03N3Mf9bHsxfGzSEZuIa+pa14+Hv68Ofjco8Ja3r//BmWkSJi
 LQQFv2gKkaic7vUOIgiPMF5K3j2E2k4/punIxZvrsKJdU5Ao+TK3c5NRepXenIx/UN7AU80Gn
 ufj12lhe48MLS65j8VXTLjf6rdhdN+2AWS+83eK7x2SihbhnZRVpOAb4nEEVCghaCt7xzIdLB
 iQRl6qMZI8isngruTbtWiSLHqNY7Ygf9lP2+HOIndCW+89a8IhQU6CeYVMb+2pGZ4jVWDQvpM
 AmwHvSzGv7LI26dD7nvgJot6bbLWW2rZbGXDk2EoyECkRtHpgiU+4DtAVyl2p3t5KHK4mOPTe
 Lc5Y/yLTg9hXf8Ld5qETwinDT9HxHQRaTZC1GRYx6hKsIAcChJIHkDCiG1MuvzuWNsXjuXoNW
 fCoDSxsMaFBxspunyp6OwbheoNEf8h1MSCNNJorjU6NItcg62YIcNJZP9oHzkuv9/7Htas4t7
 MXURTybaw1sHhbtP5mv05h0FZ2r8eLfYq2uQ31/zWaa6mRZMyLjy4IRLwChMGz4yLyu1amA9Q
 QQETlBJ0nuhQfnjIehi9Cp1FFIFxpmXVWXki6W4NiI4V3NJhn2qqSlGXALKXo1ASzv2+ox9dU
 IIQsJZZV1FYmJHUeqJ21hEH2Y4avhcpBE4j39Tpq/D03U=

> The current interrupt handler in xdma.c was using xdma->stop_request
> before locking the vchan lock.

1. Will an additional imperative wording become helpful here?
   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/submitting-patches.rst?h=3Dv6.10-rc1#n94

2. How do you think about to use the summary phrase =E2=80=9CFix data sync=
hronisation in xdma_channel_isr()=E2=80=9D?

3. Will development interests grow for the usage of a statement like =E2=
=80=9Cguard(spin)(&xchan->vchan.lock);=E2=80=9D?
   https://elixir.bootlin.com/linux/v6.10-rc1/source/include/linux/cleanup=
.h#L124


Regards,
Markus

