Return-Path: <dmaengine+bounces-3631-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F529B365B
	for <lists+dmaengine@lfdr.de>; Mon, 28 Oct 2024 17:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37F97281102
	for <lists+dmaengine@lfdr.de>; Mon, 28 Oct 2024 16:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E921DB53A;
	Mon, 28 Oct 2024 16:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="qV07+cWi"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223FE55E73;
	Mon, 28 Oct 2024 16:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730132568; cv=none; b=lUOnZCL6P1FLIbh4Kh+lRlXe/SbKaUO7Uh/12CjGnFq01bLTugoFD9m8sPN7Tz5tAToMFQdvs1ZA2OlcpzaZ8NSjsheP0IcHdhTQKbG400ts2kipJQiHbTEXHP/sch9MT6+MG9b6JPKCf7ldtxmq893/Oeq6EfiNyvdagIlmAOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730132568; c=relaxed/simple;
	bh=8spqyiPxW26W8pqcSzXcG7D1nU2plf+R4cRX9GgXzL0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=nUxBw7aNlJQSsKAXv/bcFWFaB0WmqPWUDttCvbxlEOip0EY15II1fs1Dcd1DqBWB/qWS6R03M0hq44AvplBKPUMyZIjAPeT6HoPAwJ4Z0xzvbM+0t9LHjhSdZOlnDoPdygI6GxCoCDO0hlE4Jyi4t8l/c6Bv+gkCk6aO0beig3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=qV07+cWi; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id DFA71A0767;
	Mon, 28 Oct 2024 17:22:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=iGj/2RrjtCME9sfaOGl7
	6QJ8dsNtSXG+PLWljGpACOE=; b=qV07+cWiw94LKr8EnW7ekg/8PU6Cq5iklcxY
	RkY/yh+JCrnbycKAiPVOWk6dJZTEFEfpGUMQ8fqT5Cco1RhcQhrr/w27xcWnll64
	qazulhAYyIo8xMSHNZ6a/12xpmMXZpf1+oltT57Aw7Qo4099cPFljKoSZyP/xBz4
	f0HAo3ZxSHA+AZ2/0mbLIBNQmmIbV4ug50NCVdOois5tDffuX2HUzsPSuiAv/l6S
	Azrz5N6PpAPhInyTNsPfBY6VPAg95OL9gzpEEyDCW0TriyaLyaJl/FFf5F7Ba1/X
	b+c8qJmxV+G4QDsdkVlVffisHd0TLoQtkHakMkkrlfCDMye1OvAUGnV8BxmGQR1h
	RVh1c8CJFLGI2/mCggqlZ1NWTIoMIIgnJWXkinK9ktVrSyLq76EcYJsa2I7LNPBO
	n7UfGwRT0ZChxUWzaAU72AVW6gmqtjPyLfJFY8w0yHVNCeagpvWF0AXtkK1PnyWa
	UJ2GUlYwdrNTseFIv+F5n3IqUdOhXeJ/DYMAItyJy/yPM6aC6BQqDErWgEbdEU0C
	e8obxrAbuAV9Qk6ZrsECY3haoJN/xAl0Bs62S+cryJyHhrKSNkuSykscaUExcT9g
	3wwPmH7b1him2CvnKSbKkBU9T9gdK7iyRwBMjsOBTJE2CcbirmXrFXodZ6I98fjK
	D6BQ1fY=
Message-ID: <bdf6a38d-e113-41c5-abc9-c18571ed13d8@prolan.hu>
Date: Mon, 28 Oct 2024 17:22:41 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/10] dma-engine: sun4i: Add has_reset option to quirk
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
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
 <1811aa2a-3d19-4ce4-83c5-863aa0f4daab@prolan.hu>
Content-Language: en-US
In-Reply-To: <1811aa2a-3d19-4ce4-83c5-863aa0f4daab@prolan.hu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855667563

On 2024. 10. 28. 14:12, Csókás Bence wrote:
> 
> 
> On 2024. 10. 28. 8:44, Chen-Yu Tsai wrote:
>> I suggest adding a patch to switch the clk API calls to 
>> devm_clk_get_enabled()
>> which handles all the cleanup. Similarly you can switch to
>>
>>      devm_reset_control_get_exclusive_deasserted()
>>
>> for this patch.
>>
>>
>> ChenYu
> 
> Huh, that's a new API! Thanks, I'll switch to that then.

Actually, it doesn't seem to be merged to Linus' tree yet. I'll probably 
just switch it after it is merged.

Bence


