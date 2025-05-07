Return-Path: <dmaengine+bounces-5104-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31553AADD1E
	for <lists+dmaengine@lfdr.de>; Wed,  7 May 2025 13:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FD393B8125
	for <lists+dmaengine@lfdr.de>; Wed,  7 May 2025 11:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF838218EBA;
	Wed,  7 May 2025 11:18:02 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mxout37.expurgate.net (mxout37.expurgate.net [194.37.255.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508F71DF270;
	Wed,  7 May 2025 11:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746616682; cv=none; b=qrGHn+Q5s6aDQ8XIUVX/EsxLaNmp+NhKeKQ9vLR/SZhaIBcUgSUCMfTQ0OavfvEiLRyP0Fv2m69LzvLDslWE9pPhg55DWTsJaVfMv9xmW9kR163ePklhPmEgV6buj5UTRmb7qhVXY8F4jqyTLV8ZXkKEDqPiNGAz2mc2of7fO5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746616682; c=relaxed/simple;
	bh=jMIjivGs+YUJa/yQg29y5qzQoUNnZZfwhHMWuu2jaL4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=kpTSnvljDzpE/n4gkOCAwAscwd1p1m2qooHwynTiwd3J13huWGwtONfNkjRPZvWm54OJYPUqQbV2r/M7nxQAOyvIHazQuTerkZiuq1EV6bHq2M8STs4bNhGCLZQ78IoD0VzbSMI8GpFy5RlxZwsZo0RC4PLJiJlngLumfZ5LTEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=brueckmann-gmbh.de; spf=pass smtp.mailfrom=brueckmann-gmbh.de; arc=none smtp.client-ip=194.37.255.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=brueckmann-gmbh.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brueckmann-gmbh.de
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <thomas.gessler@brueckmann-gmbh.de>)
	id 1uCcUk-002ilu-Tb; Wed, 07 May 2025 12:59:22 +0200
Received: from [217.239.223.202] (helo=zimbra.brueckmann-gmbh.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <thomas.gessler@brueckmann-gmbh.de>)
	id 1uCcUj-00GcMA-QI; Wed, 07 May 2025 12:59:21 +0200
Received: from zimbra.brueckmann-gmbh.de (localhost [127.0.0.1])
	by zimbra.brueckmann-gmbh.de (Postfix) with ESMTPS id A9E3FCA068E;
	Wed,  7 May 2025 12:59:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.brueckmann-gmbh.de (Postfix) with ESMTP id 9B435CA0800;
	Wed,  7 May 2025 12:59:20 +0200 (CEST)
Received: from zimbra.brueckmann-gmbh.de ([127.0.0.1])
 by localhost (zimbra.brueckmann-gmbh.de [127.0.0.1]) (amavis, port 10026)
 with ESMTP id J9uvJOYXCRuy; Wed,  7 May 2025 12:59:20 +0200 (CEST)
Received: from zimbra.brueckmann-gmbh.de (zimbra.brueckmann-gmbh.de [10.0.0.21])
	by zimbra.brueckmann-gmbh.de (Postfix) with ESMTP id 8E630CA068E;
	Wed,  7 May 2025 12:59:20 +0200 (CEST)
Date: Wed, 7 May 2025 12:59:20 +0200 (CEST)
From: =?utf-8?B?R2XDn2xlciw=?= Thomas <thomas.gessler@brueckmann-gmbh.de>
To: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
Cc: dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, 
	"Simek, Michal" <michal.simek@amd.com>, Marek Vasut <marex@denx.de>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	"Katakam, Harini" <harini.katakam@amd.com>, 
	"Gupta, Suraj" <Suraj.Gupta2@amd.com>
Message-ID: <1814404629.486377.1746615560560.JavaMail.zimbra@brueckmann-gmbh.de>
In-Reply-To: <MN0PR12MB5953C8800220724906360D54B788A@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <20250314134849.703819-1-thomas.gessler@brueckmann-gmbh.de> <MN0PR12MB59531CAA16616476F2E09EFBB7DF2@MN0PR12MB5953.namprd12.prod.outlook.com> <MN0PR12MB5953C8800220724906360D54B788A@MN0PR12MB5953.namprd12.prod.outlook.com>
Subject: Re: [PATCH] dmaengine: xilinx_dma: Set dma_device directions
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 10.0.13_GA_4723 (ZimbraWebClient - FF128 (Win)/10.0.13_GA_4736)
Thread-Topic: dmaengine: xilinx_dma: Set dma_device directions
Thread-Index: AQHblOfyPgreEFaTb06QsgCB79kDoLN25v/wgFBhYuDwSRY+Zg==
X-purgate: clean
X-purgate-type: clean
X-purgate-ID: 151534::1746615562-29EE269F-4C6B8EFA/0/0

----- Am 7. Mai 2025 um 12:20 schrieb Pandey, Radhey Shyam radhey.shyam.pandey@amd.com:
> Suraj also worked on this patch internally and he did set direction in
> chan_probe().
> So, I think we can switch to below implementation ?

That's fine by me.

