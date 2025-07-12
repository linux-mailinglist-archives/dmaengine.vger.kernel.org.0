Return-Path: <dmaengine+bounces-5769-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A75EB02C0F
	for <lists+dmaengine@lfdr.de>; Sat, 12 Jul 2025 19:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 008F33A2531
	for <lists+dmaengine@lfdr.de>; Sat, 12 Jul 2025 17:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368E21F76A5;
	Sat, 12 Jul 2025 17:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="gAQco3wz"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B882BAF4;
	Sat, 12 Jul 2025 17:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752339690; cv=none; b=KzgO2iTs0+523/+NJw9NLtkBOJ3/luKpUemOQ43SWSsqzWaMqV/WmyAuuzZquMkNU0PyyvP1xlnqKtW3SLMkhBhsOP0PAgHT0UxlaLCw/N+h3aTUgIYPECc59L0CfT/BsfUNZShMwqBvzryaxmDZ4xSxSey9RCr2AtyxZPrKsw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752339690; c=relaxed/simple;
	bh=U3pm2J+mn/APVgKQP4vS0GxNg3pFfaVK3pN7cIUGWJQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=bNOE9tLE5RJSKlL/ojTWPOzs0ienOa9Ja0JjYwBWSazV7M0rC5tjI6H0Nbt+86COuvUKMbnvDCKwkAg33PowJCm2iWgm9SexVZ2TGg/mWXvzqThv2TEWuRJkpNEkMFzceUIN9Mkif+mUYvVaotQA6nlMYMP+RuE/KVs5RJfS4RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=gAQco3wz; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1752339679; x=1752944479; i=markus.elfring@web.de;
	bh=U3pm2J+mn/APVgKQP4vS0GxNg3pFfaVK3pN7cIUGWJQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gAQco3wzzjfeLPT7k94dWQ73DOlrBtE3+0Z6O4W3osvzO6pAfmR5q702wP8om/+6
	 agykTPRqdVCXiMFwXJeNC1ToWihbtkbh+JmoocCk1i5azgZ9MdrP8PgL/WATl1izC
	 GfpTDipwks2dosCacI5mhmfLnXnxljNmgWIwDxc6L36XsI455sjd8m4uAhleld4FU
	 AwqY5z/VHRF5z+3XReuyGsRbxWKtT6HKkY2dCFh05+bnRixlvZMTKJD1if2Tc9r7S
	 YRAB8XmL/kr1ErkR6+uxElQfeq5C6ZF7t9UIgQgoMnJKpCrfKZtGfdR0OlqSlZi/H
	 M3JObkr/Lmwpg5hHoQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.234]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MQ8Wa-1uEgoZ2QGO-00UnNX; Sat, 12
 Jul 2025 18:55:35 +0200
Message-ID: <fe2f98f8-deda-429e-baa2-8ad4560e36e5@web.de>
Date: Sat, 12 Jul 2025 18:55:26 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhang Shurong <zhang_shurong@foxmail.com>, dmaengine@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Magnus Damm <magnus.damm@gmail.com>, Robin Murphy <robin.murphy@arm.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Vinod Koul <vkoul@kernel.org>
References: <tencent_71CC9630D88A8792C2396A8844DCCD5C6D06@qq.com>
Subject: Re: [PATCH] dmaengine: rcar-dmac: Fix PM usage counter imbalance
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <tencent_71CC9630D88A8792C2396A8844DCCD5C6D06@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/CQaH3vp5T/+lZkulwgKweZQ+2Hs7w6K1l/FdnjC7N6G+gq/Bgz
 ZB6OjZ4+BKX/KdMNTip2WujQBiqSr+wIll6ycLHXBkMWYgdXv6E7I2FnoOBZ8aylYk30n8S
 Z1gAHGmqB5GT8qArwMDGCt0YOrxxrV2Iv7wIRRwf17PWuhei4cGl5xrbQAkAArMK2bWx2Ma
 XAegQ2LcAGRcPdVqgqc/g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zQjsz6q3kOc=;fkj6zkaD7h9n3paUNF61IFdV4r0
 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
 qPksmFH7J7Tz3Lv0H3U0Hlc=

=E2=80=A6
> result in reference leak here. We fix it by replacing
> it with pm_runtime_resume_and_get to keep usage counter
> balanced.

You may occasionally put more than 55 characters into text lines
of such a change description.

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.16-rc5#n94

Regards,
Markus

