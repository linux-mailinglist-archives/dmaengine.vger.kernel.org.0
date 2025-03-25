Return-Path: <dmaengine+bounces-4775-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2351DA6EC07
	for <lists+dmaengine@lfdr.de>; Tue, 25 Mar 2025 09:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A5C616E6B8
	for <lists+dmaengine@lfdr.de>; Tue, 25 Mar 2025 08:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166181D6DD4;
	Tue, 25 Mar 2025 08:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="SONecM2y"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2721DB154;
	Tue, 25 Mar 2025 08:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742893144; cv=none; b=j9ZgbqRGe5yCBZcQMkDbI8tLtIbXjEQgtVssnKeZ5NQdenhckH4j/41WPQ3nHX97B5v2Nxc4ylwm5xFGQvndqLenN4/ZOr5VAIsvYR70aoE8/sISVTPJfU0mdaWpe+fiywIf0reZ+XUAsK+foHTSMxBW7vtjSzRlvP4cxd3MbNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742893144; c=relaxed/simple;
	bh=ZJ1eyF3XOpFzFTm5C869DddrpISwJi4hxuvAp4+QDrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UGxuEys710GiDZV1I6UdV0M8Nh+9s7iV4ph3/HrcmhW93uuZOMf+g8iKP91Ri0qjsNSzAqsLd+072AXpb3xy90FyvWtD1EwpG+7s3RbQJoRUaHfTvzlJCQ2bDuNkc/h4Gb6EjBTDr0XMRq0SQkmtEOaAlR/4sIHAdLQ6pfXaTfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=SONecM2y; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id B3220A05E5;
	Tue, 25 Mar 2025 09:58:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=ZJ1eyF3XOpFzFTm5C869
	DddrpISwJi4hxuvAp4+QDrI=; b=SONecM2yOaUTb0yUPQpex5Z4ikQkat3Y/i6Y
	Goi3EqzjgVCDo7nyfXFETvU+r9S1xPjdR8a0IZOyCfNqWO8XkthhhK+KyGDiwllA
	DaHjbdm3gG36P/zw6IDSDBda89Sw4FC7USgOBX7g6CKqeXduEg1YB/IIvdR6smgd
	AyhwAYFLG4q3N1xZPzVxoD/h99IpRbNQooQlm61rRxA2S8X9l0HaNHTWNE4JbZVe
	wHj7axEQxrC2T/qV70U+ALLO6MN04aadb2s4ILx6ov56m1Yg64dr/JKuuUM13fwE
	z515uD2H1W9TgABJlVsHzytEyjFewVYE4LpOFkzbSeXZ5OdiBud/Ye+uuyziyZU3
	jnwfyhaEMhdp9OQqr2m9MZUsY5rO2PT5ZwWXOfmG5EeYZ00mrCrh5W9FY8q5TkJV
	+ujBkOOg9M7SwNJO946a3EcQi3Xuk/bSD6MqS51DpBrvwN/eHP7ZP7H03Rb5hdwZ
	KRXtV7DhfZOo3e98EnpJ+pXZC9eOgEnr27gAwHw0MXlKCyK1FPaHOqRRjbsvpVft
	FvA53F6zZMSlppCOw8zQrSo6DWPNI2uS4otXIbLwU2++93OKmUb+OwBDVeBYL4CB
	vMURGrjpS4CBe1fhHWWl4spHxVpKR8pfxbORJJifTUN0UBhLa18Br2wqEdUgAX2v
	0NpjEgk=
Message-ID: <7afcbbee-6261-4b2f-be14-a3076746d53c@prolan.hu>
Date: Tue, 25 Mar 2025 09:58:57 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v6] dma-engine: sun4i: Simplify error handling in probe()
To: Markus Elfring <Markus.Elfring@web.de>, <dmaengine@vger.kernel.org>,
	<linux-sunxi@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>
CC: LKML <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>, Christophe Jaillet
	<christophe.jaillet@wanadoo.fr>, Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, Vinod Koul <vkoul@kernel.org>
References: <20250324172026.370253-2-csokas.bence@prolan.hu>
 <92772f63-52c9-4979-9b60-37c8320ca009@web.de>
 <7064597b-caf7-42e2-b083-b3531e874200@prolan.hu>
 <7332ccd2-ebe6-4b9d-a2ae-8f33641e7bd4@web.de>
Content-Language: en-US, hu-HU
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <7332ccd2-ebe6-4b9d-a2ae-8f33641e7bd4@web.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D948526D7C6A

Hi,

On 2025. 03. 25. 9:47, Markus Elfring wrote:
> Implementation details are probably worth for another look.

What don't you like in the implementation? Let's discuss that then.

>> On 2025. 03. 24. 18:20, Bence Csókás wrote:
>>> Clean up error handling by using devm functions and dev_err_probe(). This
>>> should make it easier to add new code, as we can eliminate the "goto
>>> ladder" in sun4i_dma_probe().
> Please distinguish better between information from the “changelog”
> and items in a message subject.

What do you mean? The email body will be the commit message.

> Regards,
> Markus

Bence


