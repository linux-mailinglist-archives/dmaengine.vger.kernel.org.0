Return-Path: <dmaengine+bounces-5103-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD71AADD02
	for <lists+dmaengine@lfdr.de>; Wed,  7 May 2025 13:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A05E21894D6C
	for <lists+dmaengine@lfdr.de>; Wed,  7 May 2025 11:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC792153D2;
	Wed,  7 May 2025 11:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b="SmQ0f5v8"
X-Original-To: dmaengine@vger.kernel.org
Received: from www522.your-server.de (www522.your-server.de [195.201.215.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36AE72628;
	Wed,  7 May 2025 11:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.215.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746616259; cv=none; b=QPEFiShUc8qRA9MxSO5wF3i90Lyvl5P4Ub7ZJLMHjQ5rhUEiFCqk3HYIAjLV/mzgCyUq4LCvtM4rp1K2pIZ6vJo8xIENr6xZwusQhJiKo78g3kSGOIUvUHmYmrVf5HBeKZj8dVewUMwJdTy9KiecV5CDzuJWRNiHCTo9p5oOejE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746616259; c=relaxed/simple;
	bh=vmSGuFzk/EifdADajz7/SqsZwIclBftrNbOHkm1ysk4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=pbfxEZwee2LlaEwzjhdaJlpxbZgFSFGEJxHkqViJpHd1CeCvtvWR0pEeDbkJjXh0ivMp7cb1coZbN2j3sWExvYFdaFcGVzjlueumEbr1VMAg999WFLvd0e8R8RPkjh14T8fFDHWuTNoiUhPvMof9peysd4feWrap7M2VHIPe9Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de; spf=pass smtp.mailfrom=folker-schwesinger.de; dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b=SmQ0f5v8; arc=none smtp.client-ip=195.201.215.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=folker-schwesinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=folker-schwesinger.de; s=default2212; h=In-Reply-To:References:To:From:Cc:
	Subject:Message-Id:Date:Content-Type:Content-Transfer-Encoding:Mime-Version:
	Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Tx722LLBcDX85Nl+UVjthb6rDb0/f2vKG6KsAYhSJ3Q=; b=SmQ0f5v84BGP/Ko44iFlRqfT+2
	HqFax0psOtD+BSW8Or6pV5mrEHnzrN/aETO49l4ydOpKEuC97pzM3z6R5Chs1tK8ex4fEp7SO/m1H
	JU0e+0gAz8Xa8+6nY3P1HS/OfYv0ofAJJigMMNM12t8Js9K6CtEaH8HM7R4IjYqSvTW3nd0trtvi5
	Hic5UdV/LPIm4niQh7Jx0bikG4aOmRzBlo7Z/wIzkULy795yqV7YcSPZ6CAcNUDlWOgq4QWkEivJO
	teZxajMdYy4jGeRn9MuD2AKFzEEt0nUY0IvRdybcSOIfY4Oe9sQHvgzFqHtFKP3iCWWUZxN3ca7J4
	G3yBSvsw==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www522.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1uCcIv-000Al9-0y;
	Wed, 07 May 2025 12:47:09 +0200
Received: from [141.24.82.26] (helo=localhost)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1uCcIu-000Dr9-37;
	Wed, 07 May 2025 12:47:08 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 07 May 2025 10:47:08 +0000
Message-Id: <D9PVA78TMQNH.H3AZTEVZ8SV@folker-schwesinger.de>
Subject: Re: [PATCH] dmaengine: xilinx_dma: Set dma_device directions
Cc: "Vinod Koul" <vkoul@kernel.org>, "Simek, Michal" <michal.simek@amd.com>,
 "Marek Vasut" <marex@denx.de>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "Katakam, Harini" <harini.katakam@amd.com>,
 "Gupta, Suraj" <Suraj.Gupta2@amd.com>
From: "Folker Schwesinger" <dev@folker-schwesinger.de>
To: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>, "Thomas Gessler"
 <thomas.gessler@brueckmann-gmbh.de>, "dmaengine@vger.kernel.org"
 <dmaengine@vger.kernel.org>
X-Mailer: aerc 0.20.1-71-gcaf717fc3044
References: <20250314134849.703819-1-thomas.gessler@brueckmann-gmbh.de>
 <MN0PR12MB59531CAA16616476F2E09EFBB7DF2@MN0PR12MB5953.namprd12.prod.outlook.com> <MN0PR12MB5953C8800220724906360D54B788A@MN0PR12MB5953.namprd12.prod.outlook.com>
In-Reply-To: <MN0PR12MB5953C8800220724906360D54B788A@MN0PR12MB5953.namprd12.prod.outlook.com>
X-Authenticated-Sender: dev@folker-schwesinger.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27630/Tue May  6 11:43:15 2025)

On Wed May 7, 2025 at 12:20 PM CEST, Radhey Shyam Pandey wrote:
> [snip]
>> > Subject: [PATCH] dmaengine: xilinx_dma: Set dma_device directions
>> >
>> > Coalesce the direction bits from the enabled TX and/or RX channels
>> > into the directions bit mask of dma_device. Without this mask set,
>> > dma_get_slave_caps() in the DMAEngine fails, which prevents the driver
>> > from being used with an IIO DMAEngine buffer.
>> >
>> > Signed-off-by: Thomas Gessler <thomas.gessler@brueckmann-gmbh.de>
>>
>> Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
>> Thanks!
>>
>> > ---
>> >  drivers/dma/xilinx/xilinx_dma.c | 4 ++++
>> >  1 file changed, 4 insertions(+)
>> >
>> > diff --git a/drivers/dma/xilinx/xilinx_dma.c
>> > b/drivers/dma/xilinx/xilinx_dma.c index 108a7287f4cd..641aaf0c0f1c
>> > 100644
>> > --- a/drivers/dma/xilinx/xilinx_dma.c
>> > +++ b/drivers/dma/xilinx/xilinx_dma.c
>> > @@ -3205,6 +3205,10 @@ static int xilinx_dma_probe(struct
>> > platform_device
>> > *pdev)
>> >             }
>> >     }
>> >
>> > +   for (i =3D 0; i < xdev->dma_config->max_channels; i++)
>> > +           if (xdev->chan[i])
>> > +                   xdev->common.directions |=3D xdev->chan[i]->direct=
ion;
>> > +
>
> Suraj also worked on this patch internally and he did set direction in ch=
an_probe().
> So, I think we can switch to below implementation ?
>
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -2909,6 +2909,7 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_=
device *xdev,
>                 return -EINVAL;
>         }
>
> +       xdev->common.directions |=3D chan->direction;

Looks good to me.


