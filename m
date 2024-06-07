Return-Path: <dmaengine+bounces-2305-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBE5900165
	for <lists+dmaengine@lfdr.de>; Fri,  7 Jun 2024 13:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19712B2334D
	for <lists+dmaengine@lfdr.de>; Fri,  7 Jun 2024 11:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5897315DBA5;
	Fri,  7 Jun 2024 11:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="voYI5waC"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8214152530;
	Fri,  7 Jun 2024 11:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717758061; cv=none; b=nOE8tp52pUm0A/BbEqEfknUxU/gJ+cGfyfJET27NuNe+kLVvLc+ETP/Kyck83rxquMrbX+meEhpFLaY160KXZHbsxlVlU36Fb83bidSZsxgo4u0M/yWlBOPVgpaIAm0OsnTe1fvYTAXTmxJm7e78ELcdQUCbnNUfT+ecaN+xmzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717758061; c=relaxed/simple;
	bh=PYBDXW1bgAq8z8hyPZRjTK33dIFpn/74BViS5VSNeIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ey9yvf1tV6WRQdFEm1tVTEvE1GyYpylHgPIy+brqoiQNxioMiiXiepSwS/+krH7B/wqNnsrUCENQWR14B7e1yt10f4sDIQNue2iLNWrNigcrHfKqadGhJuFoPqBWnMP78ms3KFT/gLqm4+IOSn+3f9yxo1Wg+apMeUUU/spGaZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=voYI5waC; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1717758021; x=1718362821; i=markus.elfring@web.de;
	bh=IhW5vpsMEF6oM47c6btwxu3Ln8LJNCv3Ogz2x3bYGGY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=voYI5waCAWK90Hkf6VsiDMqz3Q79jVJp46bqwaP7vzBhthOmcVdsR1tJv/fpxZqp
	 7nCIIm4xYZTUmhoQ+1cNoEL1dTOIvDcHhTAAXUVAi9bDxfQm29k1oEqHRWg8jY+Vl
	 zzUkgba45soV3mH9iSTr1CMR54gT0ZbmkyqkwCNVuhNFNC8arHi/XHZvMBsIPTM8I
	 dow8SWx86aFHp5dfH3jUZKrxaGAzNvi1DqW3ibumgmDAq7kJrKXnTtqFyP2dKxwnx
	 fkqb5lduq9kjV198HN2/7OJoDlwFXULysMr+ANiTy+dDXc/S8Dm2l9n0mC7DEk7dd
	 NPt0NbWiT28uLZdJnQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mft7t-1svTvY2naj-00n9hn; Fri, 07
 Jun 2024 13:00:21 +0200
Message-ID: <dd01cc26-5af5-45f6-a5b0-b5d29da3f01e@web.de>
Date: Fri, 7 Jun 2024 13:00:20 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dmaengine: xilinx: xdma: Fix data synchronisation in
 xdma_channel_isr()
To: Louis Chauvet <louis.chauvet@bootlin.com>, Lizhi Hou <lizhi.hou@amd.com>,
 Brian Xu <brian.xu@amd.com>, Raj Kumar Rampelli
 <raj.kumar.rampelli@amd.com>, Vinod Koul <vkoul@kernel.org>,
 Michal Simek <michal.simek@amd.com>, dmaengine@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240607-xdma-fixes-v2-1-0282319ce345@bootlin.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240607-xdma-fixes-v2-1-0282319ce345@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qMKv+pscBjHW9lTpGPCxoG4AtlhN/1w5uQrP4IcHwLCdyT9LaAF
 pxnwHOZ3kovQB+gMDFK1SPxvxAZOQV5KR3R3dZYB4U4+kYRQKcrR9y8xfBWl27pDf0Lv+Jh
 +lj2y835hfBopQGcVC81yHAErCkizTODlGzkGolloRlE3Lew1V72XG9ucswdxcIyBVV93Rj
 mvxIk/GKwUJNK5XuKDhJQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZGEkmf+aAVU=;Z3Ng3uPnW/ZXnqCjf23PD3CLyqQ
 Nw+YuHt0WkNK5QE+6h41+qD1gzH5KKWUxhmRNGOLPC5WzgUC8XXObf0Hllu4gsI8M1lUsCiyJ
 nveY7fGVDJXU3rENekbrIYjVBf+YS2QaOvK9ZwnMCYw9TvLBRnGPVK0ZZxs7SSvinTm7unOba
 qSe/y/U2Vilx20HNKFEa9iah90/xG3WWIPk1jdEnsfOvJ4J0oScibrxmOnpZ5BfaNpNMf7iVQ
 1pMYrBpKjemvK4/5zyv37lZOMnCcxRedXkWtY7DCOxkrucLWyIRDwwXOHueAx92NpUG6eWC4w
 6raqQpB9h0WUO2PL5Uqv7/aJkyob3aulBNXDLwjQrpBJb8FC076YIXA04w1LyZ8imZVcqyJqc
 je0cJ/1n4K6y5Hcx76KcMF7YRONDQYm37TRjejiLwVcRZ8ZlSd6j9JP7sVQr0yXFLtw7ZIP8h
 AsO0pgdM8qMYrHKNyHkgolIP++6daz/C3G9VT6LhFF1e/8U2IorS/IJykshYZgiRSidjucf8A
 2f1jq9JtYCTynNPbWvlhpSmli0eBpES9ec13jcRHVcQWQMAhBBdIiTLpaPRAoNkNqYHRFjcps
 CnzPxfoo8lN/qCIdPQ6CRS02AdolWAznZhcDBUS+F/PBSrm6GDLnSbnd7GyZ7y3TSX7VW4uNR
 Ti1mzu9Ivsefr6XDg8s3yu0LoR9APmGSMhRpM1I5TfAo4xzFsK9/4ppeM54GqCrfrH1vm+6bj
 k9O0ApTQGjC+eaJ7E5dpHQp0w71OSG9DQrBL3w89U4jV3tK4sKUlmRHGy5YBKvrW6oPCsYIeX
 U4dMQikVc7aKkIXzuMgbO0yOpWJpKl4+hSEjmy7ZunTIc=

> Requests the vchan lock before using xdma->stop_request.

Better wording alternative?:
  A data synchronisation construct was missing in this function implementa=
tion.
  Thus apply the vchan lock before checking the data structure
  member =E2=80=9Cxchan->stop_requested=E2=80=9D.


> ---
>  drivers/dma/xilinx/xdma.c | 4 ++--

How do think about to avoid a duplicate marker line?


=E2=80=A6
> +++ b/drivers/dma/xilinx/xdma.c
> @@ -885,11 +885,11 @@ static irqreturn_t xdma_channel_isr(int irq, void =
*dev_id)
>  	u32 st;
>  	bool repeat_tx;
>
> +	spin_lock(&xchan->vchan.lock);
> +
>  	if (xchan->stop_requested)
>  		complete(&xchan->last_interrupt);
>
> -	spin_lock(&xchan->vchan.lock);
> -
>  	/* get submitted request */
=E2=80=A6

Under which circumstances will development interests grow for the usage of
a statement like =E2=80=9Cguard(raw_spinlock)(&xchan->vchan.lock);=E2=80=
=9D?
https://elixir.bootlin.com/linux/v6.10-rc2/source/include/linux/cleanup.h#=
L124

Regards,
Markus

