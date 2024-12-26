Return-Path: <dmaengine+bounces-4078-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BF99FCB7B
	for <lists+dmaengine@lfdr.de>; Thu, 26 Dec 2024 15:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A64241882AB6
	for <lists+dmaengine@lfdr.de>; Thu, 26 Dec 2024 14:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9923F9FE;
	Thu, 26 Dec 2024 14:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="Ry5SHn+x"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CE9288B1;
	Thu, 26 Dec 2024 14:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735224397; cv=none; b=mlKGm8231AxrxWlvQqw+W1/TgL2vNJFoqt2yXLz7TlgWqnI3bb28zHcwktdgtKgUuNcgQrv2hBPtzwLELPHL67wKDBxhdskHFV5r2PjmXkAkAkU9yXHoFEe7JKZaIVEhRiFlYDyA4h8pSEvo4FCEDUFyiVdRQQtkfeKyPU8fPvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735224397; c=relaxed/simple;
	bh=svVbWZOnN0qJ5PwBgDCyU1p1vsx3i4Mqfgq/d6z8c5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PtiM55JM6MMWDfSPLJr7g+68Jadm43HlWcV7+C8u/1pgDNWywPQuN2pwaDQzfpWTlhPxfeK/4OGGmX6RcRNP9fRxvU+49YeJRJkhaUpxk5k+TdQsSGiTYLBtyiJjUJvR11BQ8Iei2Ze8dc0Bmbjp0sxtiOo1ScIo8pkgeMxFjjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=Ry5SHn+x; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id B7C24A0361;
	Thu, 26 Dec 2024 15:46:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=LWTQ1VcoQJ3qfI9BjBoR
	RiH7ufM7GFFexBsBL9E2Mac=; b=Ry5SHn+xtgGrCiA90i0CaZwKFZDqgJzrfDkC
	f+k0lSwRg3hxPx1OWi/ybstYoIRucvbmh/8EfRzwbQ0W292uVPz9JZS4YBtqCL01
	i1kJ34ZZ672Io0RoezPoYayER7ZgGiTH4n1/eKM5g6M/GAAPbn+zRdqBk8oYh9lU
	QMTbGOEDGahsTz32IYIbvUjm6Ym+lrnetBc1SlL5EXi6KaJxAgP0Syfk0ojRIS7f
	IL2BYbjYjHXagF8qTTzBVB0qPEdnHfPC6a1fM+xT/pWqkjx36cV/j5Y72hXjHE5E
	q9Kt/xwsbelNWhxcZlbCb69PEZXBTwedx37+3SpQYm5ftu5u0vnPhkcgjg5ObuiA
	WIQ28/r3F5uexL4ptjT9qiCSAjyspDl2vqVZZPpK+/TvFncQPY/iGK9F1XJEGlGN
	s8QCdJj87BzefhWpi3aO98VHmry9kaCIKMJPcBYgi3cGQDaiKZebNbJxpfanAxO2
	0gCkwT2jMbAG1OgMmPC/mdUABhLW3f6lY7MiFne2bRdNLUYjo80diwCZi1wWUtCt
	D4SQ6Obx8b27Npp/hSsvoyHd9DXIXMoC06Ed1KBNExqmJZYI17YrHCN8xcfOiRrL
	6hzvEQbx2U7iYJkeIegK8YEGVnyhep2jFJOrVAAIls/p7/mp5kAozh7vc4Rax8hR
	HeIrU6g=
Message-ID: <0d77f2cc-53e2-4aad-97f5-5dd449691944@prolan.hu>
Date: Thu, 26 Dec 2024 15:46:28 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dma: Add devm_dma_request_chan()
To: Vinod Koul <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241222141427.819222-1-csokas.bence@prolan.hu>
 <Z2p86Z8B/qVSFwn8@vaman>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <Z2p86Z8B/qVSFwn8@vaman>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D948556C7665

Hi,

On 2024. 12. 24. 10:20, Vinod Koul wrote:
> On 22-12-24, 15:14, Bence Csókás wrote:
>> Expand the arsenal of devm functions for DMA
>> devices, this time for requesting channels.
> 
> Looks good, users for this?

I plan to use it in drivers/spi/atmel-quadspi.c. I already have that 
patch ready, I'll submit it once it has been tested, and after my 
outstanding patches have been merged (linux-spi ML has been quiet during 
the holidays, understandably), but for now I wanted to get it into 
dmaengine, so it will be ready for the SPI guys to use.

>> Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>

Bence


