Return-Path: <dmaengine+bounces-4763-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 069ACA6CBDF
	for <lists+dmaengine@lfdr.de>; Sat, 22 Mar 2025 19:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A15F2188D73F
	for <lists+dmaengine@lfdr.de>; Sat, 22 Mar 2025 18:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487AB1993B9;
	Sat, 22 Mar 2025 18:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="a+T+Fgr0"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B46270813;
	Sat, 22 Mar 2025 18:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742669180; cv=none; b=MeYjHvZNqaKat9qcEHPlv3Mz8VdeHSmY3wqO/yJn1X8r4bQbD3F4+Jbt+bH7iWwO0KURaF0JVUjAv4Hzln8SXzDrnPWj6DeLaPrnPUCzyR3UgRO9TWE2OgZKEJ89MQGmfB+2ciiIwyXrQvztdxSudZgzRulmmFQRI61I06O/sC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742669180; c=relaxed/simple;
	bh=tuPyuRK3ICzn5oyn0e3Hg7DiUvjxaBnVh58VbxYBAJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BsqWLZpOkFT1Lk/iQ3uyn1GY1KZrsZzWX75jgvnBleQaZN+EuvrGLwJAQRRP0HRDUSUiIeJn/kaWiztNOnTHJyaWK1gnJUGQzLJLcaL/2GWYBjTYkKr0Ikkio3ImwrFJXqMndrj8HiEC8kduZSBevsClCYxazi/EN7kPJUdPiQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=a+T+Fgr0; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id EDFABA0B56;
	Sat, 22 Mar 2025 19:46:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=AJwyQZqQD7T0LNy/jNqt
	jEdi05XKrLYNz0P7sIGRcMk=; b=a+T+Fgr09LxUJ1fxDW1n68PwmVU3ys2hBi0y
	1nDhgl0ZOIi9Oip+CEGUgxV2tO1tAAFGpnLCptDS5wm/iABRf/4ig6Occ3VfRElN
	gCW8X2hrGqLE6KKEJL1Y9ZyLpZvu7sZ6MsJGwGEfKoDKqrJyWMSL1uNoTko3mAuD
	hpgDKE7XHVqLytxg0mjyW2/Hpqm5JgINDbeJuijIP9F+DaM3ZP0dAbHskkeMZpNy
	wntY5yJ8aOvKzBitlZMi7yfJgYm481G//ohbbJsAx90VxTaB2YWKntUTzyDiFXMc
	75Xx2LhpCV8w3/57eqqgVUDa0GvWc3/ucLwZYmk8zYECyd8odunmAgYTB/WnquON
	X0XXdS8YHXvnU/h5CdM45gvlV649/G4Jfkyt8OYgoxEqHN1JhZWtiVZc0I4/WA7Q
	EUZYLEuD6SOAkeEgllcVGSLLWJdv0LqYP8MCKVZGcZI7o/XV6bZySK0Jqa/RXdhj
	K3z/x1sdwTxYldAGaie64gmfIt+5TgVLBeTB05aGAV6ruEpufGL20hIVal+baf2w
	EgeqWn2O1MLX2om02x6AORQcd/KJu+hB0jYi138yWSEBYw0IjNkw4+WyV9AfG31L
	Pcdsryu+qP2Gs10+5GvXntguEo9+M4HKCdsB0fe5L6rU0fddknQrQqKe+9EtjrEv
	O05C9GQ=
Message-ID: <f0a82f7a-806e-4dde-a870-f5d76df61984@prolan.hu>
Date: Sat, 22 Mar 2025 19:46:07 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] dma-engine: sun4i: Use devm functions in probe()
To: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
	Chen-Yu Tsai <wens@csie.org>, Vinod Koul <vkoul@kernel.org>, Samuel Holland
	<samuel@sholland.org>, Markus Elfring <Markus.Elfring@web.de>
References: <20250311180254.149484-1-csokas.bence@prolan.hu>
Content-Language: en-US, hu-HU
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <20250311180254.149484-1-csokas.bence@prolan.hu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D948526D7266

Hi all,

On 2025. 03. 11. 19:02, Bence Csókás wrote:
> Clean up error handling by using devm functions
> and dev_err_probe(). This should make it easier
> to add new code, as we can eliminate the "goto
> ladder" in probe().
> 
> Suggested-by: Chen-Yu Tsai <wens@kernel.org>
> Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>

So, will this be merged for the MW of 6.15? I just looked at the history 
of this patch, and there haven't been any major changes since v1, which 
was sent on 8 Dec last year. Despite this, it didn't make it into 6.14, 
probably because it was forgot amid the MW rush, so now I'm anxious as 
to whether it will happen again.

Bence


