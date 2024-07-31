Return-Path: <dmaengine+bounces-2763-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 321C2942911
	for <lists+dmaengine@lfdr.de>; Wed, 31 Jul 2024 10:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBF091F2407E
	for <lists+dmaengine@lfdr.de>; Wed, 31 Jul 2024 08:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFC01A7F8C;
	Wed, 31 Jul 2024 08:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="aIWB1GtD"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49C41A7F85;
	Wed, 31 Jul 2024 08:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722414124; cv=none; b=CyYwjUBUNMnouninlJYi2x+baiN0GmJkZK9R73Q86ax+kthFv+/+nCcVepuYPdO2JPnbgpaDVXtwBrRNDJ4EjZjTAJHm8k0f+4zHVSLRSVRDv6CAu0nra67cKKkjMqL7qzNm4e4GsAZF22PlzY9OhXOz/OEdiwnkcJ/JSKo9Eh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722414124; c=relaxed/simple;
	bh=7IHJECVa2WSvDCuY4TKIZrawhtfEM/UnUttBhMFbPUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JW8yn7O+7vfMS54eYfCO/n8SImW+C83vhz1vDGTLRin7NWEUUaNuD2cB0I50ZsfEhiqa6JG+8TrTMgg+6Y00HYp8tz7A1TR22BADcPhRAppsjN6kMd3bDKxBnj2eaPRkdzimiwsrOw3SsifoBiP7/TA6vMtwWuWhV7mY+m2FfWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=aIWB1GtD; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722414069; x=1723018869; i=markus.elfring@web.de;
	bh=7IHJECVa2WSvDCuY4TKIZrawhtfEM/UnUttBhMFbPUc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=aIWB1GtDJXvIL8UnjVARHO30tm66q5fVCu6+EuiK6zphh5w/B1m0A/XoT8BO56z4
	 FVFITM2d3zJqqMi5OzFcegk4tyZFc7k47RznY4UBDxSZuwCSw3LL65QrGPHq30nCg
	 cC49WVWTbLGZZuwf5nAK9kVaZHaXJ1u7VaKadBAsczyDprnhY1QhkYMI9OlvEaEQT
	 zaCzO/4sBUKswQ1QfwQJ2lXIpGwXaMcDfXV4XlinqMgyJ4NSRMZI1NSYeCZ7NBPN3
	 9eQS1+OzENjzrsg5DjG+cwkN04MFwhAiEsMKs9QL+Jc31sFRNwh+MdMdY7cS7wWQc
	 +1gSrP/ATyCTJK2Clg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MYLii-1smhPD0iyw-00TqyM; Wed, 31
 Jul 2024 10:21:09 +0200
Message-ID: <b42db5e1-102c-4ab7-b439-75301c8c27de@web.de>
Date: Wed, 31 Jul 2024 10:20:58 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v8 3/3] dmaengine: add driver for Sophgo CV18XX/SG200X dmamux
To: Inochi Amaoto <inochiama@outlook.com>, dmaengine@vger.kernel.org,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 Albert Ou <aou@eecs.berkeley.edu>, Chen Wang <unicorn_wang@outlook.com>,
 Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Rob Herring <robh@kernel.org>,
 Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Jingbao Qiu <qiujingbao.dlmu@gmail.com>, Jisheng Zhang <jszhang@kernel.org>,
 Liu Gui <kenneth.liu@sophgo.com>, Yixun Lan <dlan@gentoo.org>
References: <IA1PR20MB4953438ED600110E71F9D092BB042@IA1PR20MB4953.namprd20.prod.outlook.com>
 <633f5f40-481f-4063-ab5d-f383e981b0fe@web.de>
 <IA1PR20MB4953FE2F603D5D23175D724BBBB12@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <IA1PR20MB4953FE2F603D5D23175D724BBBB12@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:O5gOmYj/plL6GKTb2Trz6dd8+mGBkcchYhTTkeEn05GQ+fpCoz4
 DiRnr8TSMY2NSp/I6pF45Yfp76oh5s2YdjKqMdTZjj85S+LbgGM21bEhnUOEKFoXLhIpQG0
 hr5l2aG781QmGrqDSvCvrVAHfSd5Z9RLS1nOP6Ss09mufLNIBDG+zTzuUis2EbemS9qGOA7
 YUO8npC67caK9ORX3lxbA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4lOiIrPRq14=;NfFfNnZc6pGLDP2lXsb9xWkvgsK
 Lb5/YepfTYup4hqYjdgjhOw42q/2PfX8Vns+F+FvtHa4haIQstcuicKTPsoBob1rOh1KKSA5x
 xE8PGlt+WUPWv5Kfsgf2AjPWDy3fZNsVgShr553dOGG7ZLfGfpw2/MhER7HusGDwMyp0VXbeI
 wIrvyh/UXrp2GMXnLwzaAU7osCjzX6DLWAVE+V2ZBTEfcDBbHbjekYzL9s5p2mZtmaSXKlzYU
 dJ68YupI29fEdL/sJO6eBQHEQwZFNU5VzWhW1U4Vl29VyUPfVm19kPZrPmvgcH1cH/7Xcfr6y
 MqwYP6+Yu8IoO79sp/5epSJya6c9EGcnntSwJfP6aINoA5CjFqrTiMyyf1NjrRsobyB5oplzY
 2u4aYBkRU+SymDLsUxqtZhzTplZc62VWYfjWiqZEYRKL8uS/GJ+LOOVtX7XK0A7C9XHsz6/mE
 ZCocwqGE4EAK6ZJ11XpmirLijGyACuRmGFAF3FzOTsoZoaCzxwMB0eIPOdRoP/5qsvskcsPs3
 +g2qmcEjAQ6PVFPpOmhC/5xoYpdrjDBy/8tX/BfDmlAfvOkJPjZFed1rKXWECMm17hYb8nUPh
 xLVJ2kalkvFw7veCd3PSysuGNb3r4quLWw8033Ntm0HmnCkld66VDMbKxr7Y61jVg1OjlB0p3
 POpEtt9qf50/WtvoOXIp0a0hzXu/B+FXjzEdL9VCmJ3RDPmYExpzQr79rz5YG74hgLZ7AkSRD
 38RqNmo3oyuLDJVbPn7Du7DyMBNLQNmRHmaEyWfRyFmaFu3TNpIGWH41iryWpjvMgv5RdHF+E
 IfRdXn9sz45jLpriW1XMByTQ==

=E2=80=A6
>> Under which circumstances would you become interested to apply a statem=
ent
>> like =E2=80=9Cguard(spinlock_irqsave)(&dmamux->lock);=E2=80=9D?
>> https://elixir.bootlin.com/linux/v6.10.2/source/include/linux/spinlock.=
h#L574
=E2=80=A6
> This is very useful and I am pretty intersted, but I am not sure it
> is suitable. Could you share some technical detail (or some documents)
> about this method?

Further applications of scope-based resource management can become more he=
lpful,
can't they?

Would you like to take another look at corresponding information sources?

Example:
Articles by Javier Carrasco Cruz
Linux Kernel Development - Automatic Cleanup
https://javiercarrascocruz.github.io/kernel-auto-cleanup-1
June 2024

Regards,
Markus

