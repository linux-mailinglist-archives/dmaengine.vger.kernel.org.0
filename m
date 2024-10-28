Return-Path: <dmaengine+bounces-3621-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E69C79B28C6
	for <lists+dmaengine@lfdr.de>; Mon, 28 Oct 2024 08:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE4C2281D8F
	for <lists+dmaengine@lfdr.de>; Mon, 28 Oct 2024 07:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89C218DF84;
	Mon, 28 Oct 2024 07:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="e5AtdkqF"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B3018FC91;
	Mon, 28 Oct 2024 07:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100686; cv=none; b=Nnv8OGRIw3sz3DpjRcURGem+tgHyaAxe2vrHQfuMeYo+eud4Y5K1RfP36Te69pk3I4NBdxY0KqsrJjuNJh00lsx27zXdv2/e6Bg3px4CyPydBmKdAHLxzHlh00u1V7RJDQta0RyErZahbboejkD0hwYmZ+uodQlPzoWr3pu2inE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100686; c=relaxed/simple;
	bh=qrB0miUIgjXHZQLEDYFM79ucY2NOMbwpEtWBb4TOsuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OteuOoUPIS9JpgrX22g/rhIyrixzm6anA/rXfmUL2Q43RrhqkjtRYlI2wqDO2h+g5LURE32c32vHqMpBFoOb28rJsR9bz3Em8H92D0ncRMQm7414iN3rp/DXK5LIBi3qYRkBxbuhAqGqu6/E76WnemF37PTjhCJm6hYaMoqDQKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=e5AtdkqF; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 05A64A0767;
	Mon, 28 Oct 2024 08:31:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=Jzwxp88ilPxMqqVour7K
	BL4/+4MkX3IVm03TfWmTjFQ=; b=e5AtdkqFLnQ+WxX26HGP43hZIJUhu/t/Zcil
	JKaYUFaXL+MgHxNclZXtIzFUKHVmO+Fm9WBDHPHsh6CKBuuVucuMZn/xv5IRfxdo
	8YcQfQvuPqSKGVyzrHX9QaCzXTZtlDWfixiwS/+5ZWnM6rN7XXnOnCc4RX3DaejG
	bNN9LxzdByk2JwdVYv9qQb0B1xdln/Tm3pfTq+bKzk4caPn4HJ9dygubggkkr1iq
	BzJYZqsOZxYthfbdrUr3vwLbVp6H+3mndmgOOArJrKjY+agNSkGR0CQJwXiWi1uM
	y8ByvuexjiGYFHaggVe2EZZUr1iIjH6LdWyaN5j4LQJ8ej3zUHbLWBsK2pFS5+9y
	i6fiwAZSrGX6qLv/9dpbraVA7Sbrrb7RDUtvj0qIXIeIc/TTa2RqHJXzDDeXoWEG
	G1Edf/9SQr8HanjRy1WQifQ9CAHSCQrv1pyKtqAoYM6XvORaxe8ZKj4E8jcbTs0M
	/rQApTpqnuUv0PeBNulT2WRCpk0Xs2d1QOAsZx8YqkOw0wgKzbh44kdlWeg3T+VE
	0eeqlcoiWEuc9c/v06t4bZ0VB/Zg5iRQDtZtVOVAz6f5dOVMUl1P8fV7CkCtyF45
	k/RnyI+iZJGfym8UgEgPNaHkMJS6Z9cYTTwFNtvEoDvlxHiq8j2rcLq904vQmJYD
	NfQtGDo=
Message-ID: <5eedfe71-7a8d-4b91-ab49-e09352e7d6f3@prolan.hu>
Date: Mon, 28 Oct 2024 08:31:13 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/10] dma-engine: sun4i: Add has_reset option to quirk
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>, Mesih Kilinc
	<mesihkilinc@gmail.com>, Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai
	<wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
	<samuel@sholland.org>, Philipp Zabel <p.zabel@pengutronix.de>
References: <4b614d6c-6b46-438a-b5c3-de1e69f0feb8@prolan.hu>
 <20241027180903.2035820-2-csokas.bence@prolan.hu>
 <dsuadjqzybikpnuyr7q2fbq5jdzev33rqqhnehh3ns2lgfvdlb@bdmib46vlxt3>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <dsuadjqzybikpnuyr7q2fbq5jdzev33rqqhnehh3ns2lgfvdlb@bdmib46vlxt3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855677C65

Hi,

On 2024. 10. 27. 21:43, Krzysztof Kozlowski wrote:
> You did not build v2. Then you send v3... which you also did not build.
> 
> Please start at least compiling your own code. Then start testing it,
> but without building it cannot obviously be even tested.

I forgot to rebase an amend! before sending v2, which I corrected in v3. 
I *did* in fact build v3 (after the aforementioned correction) rebased 
on top of Linux 6.5, which is what I have available for my board. And I 
also *did* test with aplay and confirmed to have working audio. If you 
believe there are differences between 6.5 and master that break v3 of 
the patch, then please point those out as opposed to making accusations.

Bence


