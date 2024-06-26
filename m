Return-Path: <dmaengine+bounces-2543-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CD6917F5C
	for <lists+dmaengine@lfdr.de>; Wed, 26 Jun 2024 13:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D01B81F24AE6
	for <lists+dmaengine@lfdr.de>; Wed, 26 Jun 2024 11:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD6117F50F;
	Wed, 26 Jun 2024 11:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="EGHj0NS8"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7621916631D;
	Wed, 26 Jun 2024 11:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719400530; cv=none; b=OCOZ7R/1F1gP7CXTVO+mp9ti1i+HfrEkDteyG48lIgId/1SDzsPzZzwOKXwaiSvEK6l4UsbbYMtKlVcTEDhy8hgzThxRwNIJyYBFgaJvUe+b0exJT/VnxHY5CViQzmSTk6A8b7+SnYN8E5s94KJGJZ0FiRFNO5haNF7fnTSz+g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719400530; c=relaxed/simple;
	bh=j+5ZIrKLNe8qHa4cOVrSOgiKjZFxNrDxASMdT1AH+lc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=NuV4VmoaTEX/lann8BJlVumkDxu/SDCvdXuBIp8Ptd0qI+MYcV2NpQz3Hi6tWpdjMWaLHGbwCd01/G+igWgUvyZIu9VWxM0cy2F1q3GWkV6DU8Wah1KZQL+vKpNfnjQSrFIFbUMKBHUc3nC5G2PSXQdFhdUaW0S9b9SGnEYS1wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=EGHj0NS8; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719400504; x=1720005304; i=markus.elfring@web.de;
	bh=j+5ZIrKLNe8qHa4cOVrSOgiKjZFxNrDxASMdT1AH+lc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=EGHj0NS8U+mhr1bM4iJZtbR7Wdv3bVcH5DDWAHrfJIPjP4TJzRYGOCVYxQtf6yaP
	 TklwHbN40eCGDWKZL6xAhntC7RF490MFl1ybmG8e5UdAJ5IxnnEDmxRQ6iLu1Astz
	 dkQZoAhQIGwlRi/z9Ldm9Y5BF63tsH7TDbTkkVaGxIsuZSTaRK3vQPQTdV4oi8OP8
	 wgHXJPRpvbAw0wPYrlLnCusPOCZv3S4N6z9iP08ssrwjBqfmp489uxO/H+zmjemg6
	 NAF+9Vq7FzymBeUIbxNdvG9R8OQGMm7f1Rbq2JbyZ6s3w/Y9JtjJxSNOXoN159w3H
	 yLJOpy2jMeOy/9LPgg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N7gXQ-1sQ1UI0Lhq-00tec2; Wed, 26
 Jun 2024 13:15:04 +0200
Message-ID: <ff6292c5-037e-4e40-af33-1339812965eb@web.de>
Date: Wed, 26 Jun 2024 13:15:02 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ma Ke <make24@iscas.ac.cn>, dmaengine@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
 kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240626084515.2829595-1-make24@iscas.ac.cn>
Subject: Re: [PATCH] dmaengine: mxs-dma: Add check for dma_set_max_seg_size in
 mxs_dma_probe()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240626084515.2829595-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:57lov0N4ETsqjC1VKjWMt8zCR17LEC/3JrVni7vl/bKEOrRJfED
 MFZpABEGV73IkJ1ywtkH0HBBSgfsr/SMdjjeRHrsi1PWVuOQyTo3XY4L8hNh3vutkq/2GlR
 vhxZgkTxcoqTRXa3uG1z0IUp4B+esv9I0Oz2rpH71oOM7r6tCzjFX9oV5e37GVDc6pS+AE4
 JP7J1pNNFZZuqSP85dPKg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6AURAV23DnI=;qyr2s9y3EjpMoEg38a4+dzx0BQt
 guWDWsNXragRlZvjvQlSAUBY0rOxfTgVU9u5mdspYW1OXswMHJAupZYMIsr8Nw9bBXIyv+JMi
 ARLm7keXUnXAssbu+AXucTqGgJ+rIFmK07oP/523bfjANWirA/Bm7yDPq5G4+tUkUVcFWSdiE
 2zpP6+S6Zes0SApia4XOFNNnW09JyHNR+K/wEoLBw0DdziBzlJ9BHHMCaAxwCGahCOZ2h7y4u
 12+fzzl+8OYgpAezAJcRmUn7K2zf8eYeGd2LLIZ2asV1SxCS6BUPNPrmESC2vYRBpHZ62Dn0A
 fGE7dvhBAPIMX1olPGUQf8P7b16rKG2WUNkevGxlP61jadbx9RbcmWFov2xV4UkoYZw3uQ+ut
 Kxpgks3hChqyUXidQGKV/X0UEHg6k3tAOkBHLfWltObYrxs9cZNPjK/NEDpY8Nv75I6tTQYG9
 XfiWWPB/ZVBMCpwWbB+Z7WK6zwTe+HHcgDlVeA75X7x/l1MGqiXa4lVfXZD7AqVX/IcMzWGya
 Anil5+MXdifTjQZmVlB/OEagv571df5B1wVMZZfS0O6lG360YPrbK1OTXlFl7X5WRJV84+VGs
 wrEy5jNc2swS0j/3x+pOGfDGYBkSxNgLI9Y+zVYKMrAuc4A5SjvBu3dU+BL4BKsS+hHcMmP+T
 hBYO5pjf54ycvLCeSG2Rxmm+PMv65FqAstPSiZrN49qNl0lhm42NVwp+FlWXU5vVQQsn2qqIC
 iAj470JWJWEEL8R8MY41e0VLZxn4mHXVyoMKlPRgQQT6p/hZCevoFbRDS0xv+9nhCdM1K7Nqm
 +suwfs14lLAA/sMkZq4CqqzokOb8HkdsDqxMfKppbof58=

> As the possible failure of the dma_set_max_seg_size(), we should better
> check the return value of the dma_set_max_seg_size().

Please avoid the repetition of a function name in such a change description.
Can it be improved with a corresponding imperative wording?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.10-rc5#n94

Regards,
Markus

