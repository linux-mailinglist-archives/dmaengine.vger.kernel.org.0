Return-Path: <dmaengine+bounces-2545-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF3F91862C
	for <lists+dmaengine@lfdr.de>; Wed, 26 Jun 2024 17:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FC051F21353
	for <lists+dmaengine@lfdr.de>; Wed, 26 Jun 2024 15:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB9A73164;
	Wed, 26 Jun 2024 15:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="OcE9UTKQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9C0BE71;
	Wed, 26 Jun 2024 15:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719416759; cv=none; b=uZhyXDTUzPtWPZ88t/5xxr97TrDiIVBqKD2JB5CP3fIEPh2OXfA/azLGTsbMhCvpmeqMUBqW5r+pbxDSqqw5c7S/PNaDb2HBPE18oAP8JauqOIu1adwchewrh+5hs1h9RBxWXBhtj1vb5/7DydEdG8FTIkDFl3zOH7Q9rBLF37U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719416759; c=relaxed/simple;
	bh=WsxxdpCJ7n1faWx8RGOLhkTER8GXTEI/NlAf6ouiQoU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=A2IF9K0HkfYwR8WUqCeYVg+Y3jTMBql3s5mQqYQ4MCMEbpGHlwyWoRAyLgySiNARQe2WUSRBzxaXffEhcv/GD39d1g3yvBuGKuc+YyZBEY10oIrCSRIstxrnnE0lMDz6k1peqYqg1rDSovvt19TZ+ZZVyWkIBowYwR06Bs16mE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=OcE9UTKQ; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719416735; x=1720021535; i=markus.elfring@web.de;
	bh=WsxxdpCJ7n1faWx8RGOLhkTER8GXTEI/NlAf6ouiQoU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OcE9UTKQ350ha43cj0MdiaOcjHDJhiAhXV0Uf4ZQfYmcQCGhYBXtjyJkI1bqPiYO
	 q0inqogxaAlV4sWnBCBxg+9KVPv/QA42bn2J6RpOcMsCQzzb9B8JnXNuWKOnHUi53
	 pfh4rocEsOppjADy389cpGr5+zM9/MGcEWANpgK0YzEEfzjl9cMwZNoN2zzymuPyN
	 TuGiNm+AJq6JXsrzNOxEdX3K6UALXvlmGcvXu9RmJh3bVmqCQjlWYGpeiO/xXHnmN
	 0LhurSbm4tA3Mqe/bRA7+9mwRw34/6hOwzqAbNA7l2XJGGCXlx/ogAWhYjKrYEbyE
	 AJ3Uy4JuBsqRdRuprQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MjBRZ-1sqaFu0u2v-00qSjc; Wed, 26
 Jun 2024 17:45:35 +0200
Message-ID: <19107df8-db13-4876-b281-0cb21cd2e63a@web.de>
Date: Wed, 26 Jun 2024 17:45:25 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ma Ke <make24@iscas.ac.cn>, dmaengine@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Sia Jee Heng <jee.heng.sia@intel.com>, Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240626085416.2831017-1-make24@iscas.ac.cn>
Subject: Re: [PATCH] dmaengine: dw-axi-dmac: Add check for
 dma_set_max_seg_size in dw_probe()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240626085416.2831017-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ETHdg9yI00hLJVV4BIO87Jb2ea6kuBY1d9HknyVwb5uvyb4496c
 daiHbz5xFMBrt1rKuOc6dxQ2OW3+CM9TMhxbmm/A6XQe7NaZvarqSJqqRJ5uYGi5RsCkIxZ
 LydFZqMKXFsxt8RYivDd7b5/PzlY7mXx5dqcJaO9LH1ts6Wn7R6N0qsqGE2WrDl2n6hE/0A
 lAJc0cIVUABiaX2ryKrEg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:L785cS3qAz4=;uZ5nwsCrqlOV990zwAit3kh24fJ
 mGFHRqke3EXQQ3mipUsNXTKZkqDJ3x7grILf6RSICeYdG9TcVIKoSLrAIsDTfOg9WLoQs3Nbb
 We71aEsPxehG5XDPhlP2UpxRnAf8AT9++p2BssU2xuD02fwlEMTBwEy9oaRfq3h1b1ltrQ7Gb
 83b+xOh/Yru9Hn+GylrgbDcxETWk1McFs1b4qnVznzspAZRQNN+55zXWg5PUw4aer06zNvzCw
 9Jg1JEw2/Nbzwv5dYxNZTrOOExXoPvAlak8q6Ae2hGv7LiMCTabm7inTMS7aQUjbB0Kv0CT8+
 WqtqT3KWlAFeapsA0q8u2rWz5soDEu5cE7GEa2GzUzMx3UvbhOrzHMvYgdI5BU3l7HNOkS3qX
 +oTWSfaq9F070GgpRmWY7LCe/KprBhzKnJPhON+qN0z0Vpl3gsgC4ETaYvlL8LA3+hJGXC8zs
 nOcseRBSuR55/sJe7LqnDCH4ImH39Dw6pjG3t3DQ5DDQUeoc2OXTzvzlykubb6P0onYDV7x65
 ieEIt/8Ba8c9NVK6GsL2lCPJXXmkCiCYHShw6EJknRdsGtQ6Qm0J/OuT3zWWhg+gI8T4ZZxu4
 cKtmZY33066TxmwcmbZduaMceKu6ikOZbwqMEus9O+HxvaMeeMEgvZHPH0XEPyLfrQvsWzlOW
 iZNT+bSSoxdh99zDdNg7epQp1GrKEISxsRubqClo+eyRrF6rXCFKZMH3y+vI1UE8ci7EphObx
 PdHbAj377L7h90kqbbdKMi0myKYxG/X/FHbAyivBAVxqCLy6D9e5Xy7SpGtZf3w4dBV+dKjRr
 KjF4HZKecQ28b2lznogtBmzL9fq+L28hq73Ny522YDeE4=

> As the possible failure of the dma_set_max_seg_size(), we should better
> check the return value of the dma_set_max_seg_size().

Please avoid the repetition of a function name in such a change description.
Can it be improved with corresponding imperative wordings?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.10-rc5#n94

Regards,
Markus

