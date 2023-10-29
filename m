Return-Path: <dmaengine+bounces-8-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A59207DAD73
	for <lists+dmaengine@lfdr.de>; Sun, 29 Oct 2023 18:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E2E71F21855
	for <lists+dmaengine@lfdr.de>; Sun, 29 Oct 2023 17:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801A0DDD4;
	Sun, 29 Oct 2023 17:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cutebit.org header.i=@cutebit.org header.b="gWSwdjK4"
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3184DDB4
	for <dmaengine@vger.kernel.org>; Sun, 29 Oct 2023 17:10:56 +0000 (UTC)
Received: from hutie.ust.cz (hutie.ust.cz [IPv6:2a03:3b40:fe:f0::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06D6AF;
	Sun, 29 Oct 2023 10:10:55 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
	t=1698599452; bh=qqFFfHBHXxc/vngEYN7PGSdvv72J5iWHr+qOTphN6Io=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=gWSwdjK4WQs8sn+bwfMnOmyLeSs2iQt1mq45yaHM3oreInK8s1UO7jN5IiKTeO+bC
	 fGaz5XZnbSq5149tfmhcXo6wryLDzl8PGWBS6Lt1xsLjVYH5hr6LzcVjfRDNWIA4ZW
	 in+71aaNRTNvrn+SEYjAjyiL+ZH1A27ER1tbzA08=
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH] dmaengine: apple-admac: Keep upper bits of REG_BUS_WIDTH
From: =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
In-Reply-To: <20231029170053.82146-1-povik+lin@cutebit.org>
Date: Sun, 29 Oct 2023 18:10:41 +0100
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 asahi@lists.linux.dev,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
 dmaengine@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <00401D09-6037-44AE-91CC-34379ED9589E@cutebit.org>
References: <20231029170053.82146-1-povik+lin@cutebit.org>
To: Hector Martin <marcan@marcan.st>,
 Sven Peter <sven@svenpeter.dev>,
 Vinod Koul <vkoul@kernel.org>


> On 29. 10. 2023, at 18:00, Martin Povi=C5=A1er <povik+lin@cutebit.org> =
wrote:
>=20
> From: Hector Martin <marcan@marcan.st>
>=20
> For RX channels, REG_BUS_WIDTH seems to default to a value of 0xf00, =
and
> macOS preserves the upper bits when setting the configuration in the
> lower ones. If we reset the upper bits to 0, this causes framing =
errors
> on suspend/resume (the data stream "tears" and channels get swapped
> around). Keeping the upper bits untouched, like the macOS driver does,
> fixes this issue.
>=20
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Reviewed-by: Martin Povi=C5=A1er <povik@cutebit.org>
> Signed-off-by: Martin Povi=C5=A1er <povik@cutebit.org>
> ---

Please take up v2 instead. I slipped in the wrong email address in here,
which I don=E2=80=99t want to subscribe for kernel spam with.

=
https://lore.kernel.org/dmaengine/20231029170704.82238-1-povik+lin@cutebit=
.org/T/#u

Thanks!

Kind regards,
Martin


