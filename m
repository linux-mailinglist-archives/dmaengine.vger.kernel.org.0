Return-Path: <dmaengine+bounces-7914-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FB2CDA4AF
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 19:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48A743010CD4
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 18:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE88347BC6;
	Tue, 23 Dec 2025 18:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="Dr0P5PAH"
X-Original-To: dmaengine@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0030A27B340
	for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 18:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766515369; cv=none; b=LZG1JOCJCGB4gQ1+wj/xGhWboBrYzbDa1UUNDCwamIi1fhwcqvh5Noy8A2oJLlkhymbbXuu8OS7e3jfByJq+4wY8xxn0vmf+niyNGqdBDLtC7TBbA9Kiv3IT6DBb2TBw6vu1dJihToDCfh1M7Lm6Mecpa0HxQZynHCa64Tpw94U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766515369; c=relaxed/simple;
	bh=Q2sTuKZ/+6CstqUbVXfSX4KcCgppjU730sp2PDJPkGU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=BI7J9dUPEdZ9MasFb+A6dnubW64X96exe7ZUrxX+82jpMx7q/wiKj/aJMuioGc7NdjnIj2DUg4rKmCdvPZ/QqWPY6lX+Uyos9zBa2fVCNzgbzUgoNv2KUXnUz0KtubnRLUmo9SbhuK6kfFupreH0BcN4cLb8Llrp51if81xBQrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=Dr0P5PAH; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=L89MaalH1pA3hN9cuu5fQ0kUzbIeK37MzWcPyMp9NbU=; b=Dr0P5PAHSaxLDOCP0IKDQQJJNZ
	Vgyvg57tRENX7EBOfxa7mL3+j6Sl8jJb8+YCPg75cq3uEW9SFv4FO3kCCuuZoFaGzk0puICiLdoiU
	Na+nk/ofImAYENYLOd532AZmBzM+z9skPfL9q5SRzM0GouBsaCjfHO0wUZXTF2uic9JAFiU1K4faZ
	LjzCpcxvgBas/8iYNbrHeksKX55dZO+U8lzm7gNGpVfmIAefBulF+UfxODRFv3dq/0Wf3KHUJD/Rn
	zCgCclZjtkYax6mZV4veoxB+bukwkBfeBp3n9UyUZ4DbdywrArR6OrZh46RetugK8DvodYznv33C9
	T3ONpIqA==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1vY7LJ-000000099rh-3q1X;
	Tue, 23 Dec 2025 11:42:46 -0700
Message-ID: <40576306-d9d8-4467-b449-1a8736515e13@deltatee.com>
Date: Tue, 23 Dec 2025 11:42:45 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Vinod Koul <vkoul@kernel.org>
Cc: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 Kelvin Cao <kelvin.cao@microchip.com>, George Ge <George.Ge@microchip.com>,
 Christoph Hellwig <hch@infradead.org>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 Christoph Hellwig <hch@lst.de>
References: <20251215181649.2605-1-logang@deltatee.com>
 <20251215181649.2605-3-logang@deltatee.com> <aUE7zahyYgsls-Ic@vaman>
 <eeda026b-bfe1-42ba-a062-ca90b5f03ee6@deltatee.com> <aUpuXwb1h6rtlfoB@vaman>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <aUpuXwb1h6rtlfoB@vaman>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: vkoul@kernel.org, dmaengine@vger.kernel.org, kelvin.cao@microchip.com, George.Ge@microchip.com, hch@infradead.org, christophe.jaillet@wanadoo.fr, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v11 2/3] dmaengine: switchtec-dma: Implement hardware
 initialization and cleanup
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2025-12-23 03:26, Vinod Koul wrote:
> On 19-12-25, 10:19, Logan Gunthorpe wrote:
>> On 2025-12-16 04:00, Vinod Koul wrote:
>>> This is bit interesting. Any reason why you choose double pointer here.
>>> If you take a look at other driver, they follow similar approach but
>>> dont use double pointer for this.
>>>
>>
>> The ring size has had to be quite large. It is currently set to 32K in
>> order to be able to get maximum performance in some work loads. While
>> each element is only 104 bytes, the total array is more than 3MB which
>> is too much for a single allocation. The PLX dma driver this is based on
>> does the same thing even though it's queue size is only 2048.
> 
> Ring size is fine, the question is about use of a double pointer instead
> of a single pointer

Ah, I guess we could make the array part of switchtec_dma_chan, I can
make that change. It is a large allocation (256KB) either way.

>> I'm not sure what you are looking for, I couldn't find any explicit
>> quiesce function that is commonly used on teardown in other drivers.
>> Clearing the pdev pointer above and synchronizing the RCU should ensure
>> there are no other jobs in progress or tasklets running.
>>
>> Note: I have tested teardown while running dmatest and have not found
>> any issues.
> 
> The tasklet can be schedule and then you free irq which creates a racy
> situation, so I always recommend to kill the tasklet after freeing the
> irq!
> 

Ok, yes, I think it should be possible to move the tasklet_kill down
below the free_irq. I'll give it a try.

Logan

