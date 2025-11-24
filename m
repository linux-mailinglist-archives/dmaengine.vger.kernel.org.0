Return-Path: <dmaengine+bounces-7337-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E07C81DF1
	for <lists+dmaengine@lfdr.de>; Mon, 24 Nov 2025 18:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1BFC3A2CF6
	for <lists+dmaengine@lfdr.de>; Mon, 24 Nov 2025 17:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820CB20E00B;
	Mon, 24 Nov 2025 17:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="jx+G/8v1"
X-Original-To: dmaengine@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB13621D3D2
	for <dmaengine@vger.kernel.org>; Mon, 24 Nov 2025 17:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764004852; cv=none; b=jlCVQAwvAq1uLlmSh/EZas4NjXxVF2zOobqHdtz6U+A5xQyZM07ZUCS2IrFuRTRXfhFu6XwqSMFkajrktXqT2YJZu0MdUbOM2n3StTzNFhkYgp7WzwzsrABx4bFAa1Nvibc8uEx+Kqdwl5SDPi2a4OSQOREHXCTGMwuff7e6KFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764004852; c=relaxed/simple;
	bh=hbFqYMG1ITgqDKiYfAUsHTP3Pa/d9N4KhvuiYBk2foo=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=f35P1fgMTCXPz3QPETMaAq355mmr9RmZEsob40aSextZydc1aZx6nGI5Wsw0JjUIDvveoBuN3MwKhD73gqiS4W3PZ7psO/B1ulaqGIbqLuByPD0rTHtIWuLi9WGQdREfaRAEbVDGmSVDwxJgO19q3SPNmVBF8OfamOBhken7GYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=jx+G/8v1; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=u44i0M5ycKNAG0ed/hufjyky8qwh264/fcYsKwiQHk8=; b=jx+G/8v12xPGemklWsHf+FzNjD
	xMn0UV6ogaD1JFNm3svTYD9L3cMyjOIvpbaAc5w4qrT/bb89jRkFziyRurGt3nWtOd9HyaThsxXyX
	COD+D0xPsEix3/sdaJiEy0dfqtdNz4Dfzqgllg0XclbFoT83Og4Za08+FzQsoDo+oYouzHYIRKPdE
	ZJcI+lK93f3S7kvJuzdJ/qwxzCqpK1FxMBVlNfOy0+HdAETDYT5a5q14Gp7f3HVOU0scW/4UkNCxU
	ZzTnJn1v3Q8ONqsK5hUvP3CwWBPImd1NEP6Cle3XOsUJ1LB0+zwvbPNvJPLSLhJ0Ou5O9y8etf/C9
	EFGOFHSw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1vNZtx-000000059SH-05gV;
	Mon, 24 Nov 2025 09:58:57 -0700
Message-ID: <55479dfb-2c91-416d-9f9d-2040282c77e2@deltatee.com>
Date: Mon, 24 Nov 2025 09:58:35 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org, Kelvin Cao <kelvin.cao@microchip.com>,
 George Ge <George.Ge@microchip.com>, Christoph Hellwig <hch@infradead.org>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 Christoph Hellwig <hch@lst.de>
References: <20251014192239.4770-1-logang@deltatee.com>
 <20251014192239.4770-3-logang@deltatee.com> <aSF5_Go4bddAbx38@vaman>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <aSF5_Go4bddAbx38@vaman>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: vkoul@kernel.org, dmaengine@vger.kernel.org, kelvin.cao@microchip.com, George.Ge@microchip.com, hch@infradead.org, christophe.jaillet@wanadoo.fr, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH 2/3] dmaengine: switchtec-dma: Implement hardware
 initialization and cleanup
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2025-11-22 01:53, Vinod Koul wrote:
> On 14-10-25, 13:22, Logan Gunthorpe wrote:
>> From: Kelvin Cao <kelvin.cao@microchip.com>
>>
>> Initialize the hardware and create the dma channel queues.
> 
> This looks mostly okay. Any reason why virt-dma is not used in this
> driver?

virt-dma creates a queue in software that is useful for simpler
hardware. The switchtec driver, like the plx_dma and ioat drivers before
it, relies on a queue in hardware and adding a software queue would just
add unnecessary overhead with no extra benefit.

Thanks,

Logan



