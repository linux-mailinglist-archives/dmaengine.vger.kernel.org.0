Return-Path: <dmaengine+bounces-3689-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 305C69BEB48
	for <lists+dmaengine@lfdr.de>; Wed,  6 Nov 2024 13:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 627941C20ADD
	for <lists+dmaengine@lfdr.de>; Wed,  6 Nov 2024 12:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC30C1E3789;
	Wed,  6 Nov 2024 12:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="FQ6+ilLt"
X-Original-To: dmaengine@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23A01E25F8
	for <dmaengine@vger.kernel.org>; Wed,  6 Nov 2024 12:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730896966; cv=none; b=LptDkHLxNZf8EvqktpKfBco5waiul1o6Hs3O9nYhiV2RguBl70X3KMkSQbCToJ+CFA4smckqvvcbfPwIDoIpyQkvJn7P4t7a6kBr3d0cGRZGDifc2b2Zenaxqi5aW5Ry0g1NPHLQBMBs1lRzVN8jZbByHv8+cI+besGG6YhCo7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730896966; c=relaxed/simple;
	bh=hiHK/GFfCmgZqz1ERDxGVgCiG/u8jyvc7KoBwZy2a2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sp3XhyN2iD2apPzj14+F8vh52EMHHW2PMJ8P2a9rne/eWOyeqSHxi+NnL2fMOByzFZhLa5vEQ9obM3UJHEsOC8JBNBfIaNjFY5/g/q1qMauIVZ2HZ0sF0npZuC6KQoOF0sOaGDv+nUgYY0TUmyTZ+Z3hZpF+T39BuXFG6f9A3OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=FQ6+ilLt; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 72A89891D7;
	Wed,  6 Nov 2024 13:42:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1730896963;
	bh=e2tqqRezTLSNXYh52TzRniqTbgundmm4a3ka/D91TnY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FQ6+ilLtGE641Imvlt74dY90ghem8QojWi4seOo+Uj6bFGlbf8Nr0FaKopCQrCFkq
	 3ULPP6JohOFFuIIixTEXTdziKHBLVdCaopV35s897NNVU9QEprDDz30fsae+VI4biq
	 Hxy/sEM0UChZlgKwRkrc0CMgRAxH5Pp8bNeDBO/dfba+B1s7lao24r/F/3MHcL/gJp
	 JlRFJnDv8xMLwYwU2swJRElUc5NUjjtmaFe8XwNBntz2OwyA7eHABUKcTh5UlbwznW
	 Truok/WAO1HwDr1FIMFYRVwGgRJA9qMq8jtVpRftuo+7UG3ShukyVf0UuF0JYuA1IG
	 wJfTJ9gXDAZmQ==
Message-ID: <f168e5bd-cdab-4405-98ef-20f7ee534e0c@denx.de>
Date: Wed, 6 Nov 2024 12:41:34 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: xilinx_dma: Fix freeup active list based on
 descriptor completion bit
To: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 "Simek, Michal" <michal.simek@amd.com>, Peter Korsgaard
 <peter@korsgaard.com>, Vinod Koul <vkoul@kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "Katakam, Harini" <harini.katakam@amd.com>
References: <20241031165835.55065-1-marex@denx.de>
 <MN0PR12MB595370521C2E3D61145D15BCB7532@MN0PR12MB5953.namprd12.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <MN0PR12MB595370521C2E3D61145D15BCB7532@MN0PR12MB5953.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 11/6/24 10:48 AM, Pandey, Radhey Shyam wrote:
>> -----Original Message-----
>> From: Marek Vasut <marex@denx.de>
>> Sent: Thursday, October 31, 2024 10:28 PM
>> To: dmaengine@vger.kernel.org
>> Cc: Marek Vasut <marex@denx.de>; Uwe Kleine-König <u.kleine-
>> koenig@baylibre.com>; Simek, Michal <michal.simek@amd.com>; Peter Korsgaard
>> <peter@korsgaard.com>; Pandey, Radhey Shyam
>> <radhey.shyam.pandey@amd.com>; Vinod Koul <vkoul@kernel.org>; linux-arm-
>> kernel@lists.infradead.org
>> Subject: [PATCH] dmaengine: xilinx_dma: Fix freeup active list based on descriptor
>> completion bit
>>
>> The xilinx_dma is completely broken since the referenced commit,
>> because if the (seg->hw.status & XILINX_DMA_BD_COMP_MASK) is not
>> set for whatever reason, the current descriptor is never moved to
> 
> I want to understand more on this failure scenario.  How to replicate it?

The very basic test is to use AXI DMA for DMA transfer, which fails to 
complete because of this new chunk of code. By reading the commit 
history, I can only conclude this was something that got added due to 
the irq_delay, but was never tested on core without irq_delay support ?

> Why is completion bit not set ? Based on the documentation completed bit
> indicates to the software that the DMA Engine has completed the transfer
> as described by the associated descriptor. The DMA Engine sets this bit
> to 1 when the transfer is completed.
I don't know, the bit was not used before you added the bit and check of 
the bit in the problematic commit 7bcdaa658102 ("dmaengine: xilinx_dma: 
Freeup active list based on descriptor completion bit")

