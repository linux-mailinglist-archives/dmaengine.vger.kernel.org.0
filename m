Return-Path: <dmaengine+bounces-958-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5589884A235
	for <lists+dmaengine@lfdr.de>; Mon,  5 Feb 2024 19:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6E41B228F7
	for <lists+dmaengine@lfdr.de>; Mon,  5 Feb 2024 18:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EE250250;
	Mon,  5 Feb 2024 18:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="nfrop+Js"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A057150257;
	Mon,  5 Feb 2024 18:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707157548; cv=none; b=KOWFCBS/+YLvKaOni+93o9IUoWhXNt5UOdnc1/DtPDkGhUGQz+23wsMMl2MDVMIEJ7K2XEhchaEroSvPgxS7vyn+JrfVzgFBsNZzk8kCfmo/90+a/qPNNQEflE7Xgw4OtaynZAjZcchwR5V8cEmcfBqMs4uyadjXMmGUyodoLTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707157548; c=relaxed/simple;
	bh=hkCYTCNXIwhAw2kg7HWIouXs7pen4EsHfo5cydjDG+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bfch+qIVVXEQ6PobQQcEAIS9mLPZgP7qebs2bciclGIvujWiNgWc5YsV/XLl/e4M80mNIKU/PSGCxai+WriGmoKlW5gJsGhdvCkqrSyTdfyBVINQpm/jJJjHH5HgJcHAnnO+3XgzT+VX240T3gxCmu4ndqNARnS1wFXjTcvRsfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=nfrop+Js; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1707157527; x=1707762327; i=wahrenst@gmx.net;
	bh=hkCYTCNXIwhAw2kg7HWIouXs7pen4EsHfo5cydjDG+k=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=nfrop+Jsgref3ZXsWIlbA0deiqEDhcwxxMGOoIGQONVtqrG8yeglj5Iu3jkNtcBW
	 MghqSQbaPG9cYq3aLBTgwljw8I3+Hy1O3BnG0cFMokYZFpUCtdulPZXLlL1I7PG55
	 Qw5Dkx4BQekghLdT4yHEI1Mfc7ixkNmL4wk2G7saRhB6bbFd3/epmohE9VC+jwz6x
	 YgOUXXrROsCJL4z324WY/X7xVEDzzPf0NPC99gpvqzi9zsV3qhjPG2Woolzqp1OxG
	 da/jBkdHUgRKqjpDOXYOjiYHPhIYZMIo0y+flplQHhSOo/EYE27HsUFhV350TccOZ
	 rlp2df+Hh9e4OtMcBg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N5VD8-1qwOTt1iDi-016tL5; Mon, 05
 Feb 2024 19:25:27 +0100
Message-ID: <419984b7-1b19-4daa-ae88-f574267b6c00@gmx.net>
Date: Mon, 5 Feb 2024 19:25:25 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/12] bcm2835-dma: Advertise the full DMA range
To: Andrea della Porta <andrea.porta@suse.com>, Vinod Koul
 <vkoul@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, dmaengine@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Maxime Ripard <maxime@cerno.tech>, Dom Cobley <popcornmix@gmail.com>,
 Phil Elwell <phil@raspberrypi.com>
References: <cover.1706948717.git.andrea.porta@suse.com>
 <a56a6d24066a64598efe4343090e51e2223475b8.1706948717.git.andrea.porta@suse.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <a56a6d24066a64598efe4343090e51e2223475b8.1706948717.git.andrea.porta@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Ic++3lrVrej8VSQWyEmgSrdSg0YMk1t2DrexC603Jwoae5m4EVs
 r37bXMY692u36IE43xvh5xl6Q93uOzSddh3fd9dqg1/ya+trPKsm/wr3CBcZpOf2zHbyQ9C
 k0sOm+RiTdfX6u+WY/LYRgW7iUIRawonWMItzJJmu7ZuVcWxPK5glhvR2nlcVZLo2GxXU0X
 XkzJuPw62IIBPkn96HgGw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:k0gD7DEOCmA=;xcS3a29kyC5szvkvJGVspF/UjkQ
 pfu9NViwFtbgd68RH+tgXUf2vZ4bXgiBWfxAvfJXCfKfBkoojs7fH4CWtLr3l4lRy51mYUI/S
 EDypPb/89bhdtbq9h6wdTsoC+QUNDI/vJ9HyfrDzWNHyWug0rXEYt9uWaQFQViUozd8vpu3Lb
 8F96UCtAtKLzqhfN15uXArptIvsco46XOUNmW78Ut5jK6iqApLYGU7yhZckE7ZKLMoItkHbum
 8ZLDU+8MLGigzyGPPccMgIp3fWqYhdBsvpbaWKTx2fMDClIC2FyEa0K3mgJCdBAGD2y8iB/Gs
 iCrdoCp4qegWn14QjEemk423CDfBYe1KKNNiesKqYAxvYFhgXThXPqBbrSceG5BC5W6R71wK1
 CLZTcxqwOWsKNeG+FFPY9MXLyg9kBlEqVECCRijzezvgFf+DgKazqTiblMf5B+MTj0XWHsLxq
 JvOgKoCwB+hAmfeSvHMh6SZx2KBMNoKL4KU7JtWdSIfmf9BZIjfEgiWgPTuJHztUXan4V0UFn
 N0PHXQ6kxiolJcRvBmyuqxKnyLyG7OZsfOl8QS/0MXFBZU+0B4OhPMJIgf8kxD9Z7tZXPAJE1
 LJVZ+tMgdraoMRnOdrns7mypM4wBBPcQ0tozozdwKNMqjKTgIvPMsMOMIZ6aLE62+wu0hQqNZ
 qoBcKEf4w7h8j5xquM9bRlmXyLQv1QuctqirYufp/h75wCRBiHLDYKugx9+JxsWUCuubpzDfJ
 QJkzEZLttgh19MExMgthyja/exa5/yRZ/LHXSlQHFPDiA4lz3d1MHrn5auPDnjD7x0FViQbUe
 EIHorCouC3oBfZVwZ8o4a1zMvwvqn4NhxVBFr+t97ukEM=

Hi Andrea,

Am 04.02.24 um 07:59 schrieb Andrea della Porta:
> From: Phil Elwell <phil@raspberrypi.com>
>
> Unless the DMA mask is set wider than 32 bits, DMA mapping will use a
> bounce buffer.
>
> Signed-off-by: Phil Elwell <phil@raspberrypi.com>
this lacks your Signed-off-by

Regards

