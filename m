Return-Path: <dmaengine+bounces-3630-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 491289B3167
	for <lists+dmaengine@lfdr.de>; Mon, 28 Oct 2024 14:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C88C282D59
	for <lists+dmaengine@lfdr.de>; Mon, 28 Oct 2024 13:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7795B1DA309;
	Mon, 28 Oct 2024 13:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="UQseZHBF"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001301E48A;
	Mon, 28 Oct 2024 13:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730121154; cv=none; b=P8c1sWASSG8XigbIERnao9hyv5NhkcXpOOABHzfarl+DPGPpqnQF3ffhboI+xEHaoYvQKtDcvZy2V2Hsk993OS5nvQ5cZPXXkB1dtWNivKHcqm0LBqfuo/Lnf88mxYl3ACk/zZFlBK7f72irUizLcMmomXa8DOKv/dTin75wk9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730121154; c=relaxed/simple;
	bh=KgZ8HaWvNp4BAfTHvrXH0/8Skj751PewZrW2Mn65rI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lJMZBMBgDLA9OMqVvzhTcC/WAHCI810jGqqiqlCBEGnb7uxwG495UqcHNjF/yN/Qx5zQcO1tLhD6X/OHwgg2c8A7ExTaPI/KxD/LJmhXr2H6XyDizHQ/Q9fsrS2YI9aEamP8nV9xQYJBkPG90htX+a93nlWYLqrQwOfXPxoIJD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=UQseZHBF; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 998F7A09F1;
	Mon, 28 Oct 2024 14:12:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=a/Km0duaUxN9zrPZeOy2
	RJQXZwW6MUMmomrvB9hLoAo=; b=UQseZHBFhaIAsUXZ58dfmX3kXyOr9KsCgXPS
	SvuPoNSgAFOOUl0/qNd3141M6WDsLsFoSJC9JjZn4ivvS5+kBpqngIkhOaMwCNQA
	KF9fqHW8dSodcN9PKeBElOXmZ/Cc9XR6fMS5zYOp5eHGprkGKm4+JYL3TKRv1lrV
	IwDjMqW9TiEPX0ROUTWXUUgXhaBee6TuaOxGoh/QkJaHcxRuuWJvRPFEhCrghNU3
	Wmluxl01SWWNsb4JT/xp7OFcnmbzEhMchUJRKB4xfmoKwe86k6Zr4UvuR9fQE52x
	o9dUohQCkaQCuvxubzo5yxWjXUvMzYgs0h8fdtf2wbXcpj2KuaXiHt9chN4011Kg
	NyV1Rb9pbRzbTl3NPDdb3A422KwNadY7u65YL7tPNavAz6HP0cvMXeoi6OE9Tufs
	TJbMGsiTimrxoP2HPth+1UadXhZcoCG3nBiDXgBzuhnM0c8l+5azFD68+TMHYDUo
	vCKaiXeak4hGeMKvtkia51+se47Rj1vf6CmQSb/RSwyL/A4vVMK7IPCMDa/rXCfe
	z3uleYY5GPW2+FT9T3fw/Akugxsk0c6hfBFdpIxDBkoLy8ej+oP+cQVpJRvZaE30
	L72tb6TkN9X+9ZNPRyl9r+AilBTLusns99Yctynj3xNHUPEaSjZ5SMoNVVdF4C7P
	JdnmnSo=
Message-ID: <1811aa2a-3d19-4ce4-83c5-863aa0f4daab@prolan.hu>
Date: Mon, 28 Oct 2024 14:12:27 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/10] dma-engine: sun4i: Add has_reset option to quirk
To: <wens@kernel.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Mesih Kilinc <mesihkilinc@gmail.com>, "Vinod
 Koul" <vkoul@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, "Samuel
 Holland" <samuel@sholland.org>, Philipp Zabel <p.zabel@pengutronix.de>
References: <20241027091440.1913863-1-csokas.bence@prolan.hu>
 <20241027091440.1913863-2-csokas.bence@prolan.hu>
 <nlhsxigg3rbfvua76ekmub4p6df2asps2ihueouuk6zkbn56zl@xdj6jzzt4gfb>
 <b74dafed-197a-4644-a546-54c7a1639484@prolan.hu>
 <CAGb2v65ZXftjrG9+f1_88=EsU7rM8vnOPZCszWfWYFQ+Do9Xsg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <CAGb2v65ZXftjrG9+f1_88=EsU7rM8vnOPZCszWfWYFQ+Do9Xsg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855677C6B



On 2024. 10. 28. 8:44, Chen-Yu Tsai wrote:
> I suggest adding a patch to switch the clk API calls to devm_clk_get_enabled()
> which handles all the cleanup. Similarly you can switch to
> 
>      devm_reset_control_get_exclusive_deasserted()
> 
> for this patch.
> 
> 
> ChenYu

Huh, that's a new API! Thanks, I'll switch to that then.

Regarding the change to devm_clk_get_enabled(), I think that should be a 
separate patch from this series, where all the pre-existing dev_err()'s 
get changed as well. If someone wants to work on that, go ahead, but if 
no one does then after this series is merged I might get around to that too.

Bence


