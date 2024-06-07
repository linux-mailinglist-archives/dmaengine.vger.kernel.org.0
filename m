Return-Path: <dmaengine+bounces-2309-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E6490035C
	for <lists+dmaengine@lfdr.de>; Fri,  7 Jun 2024 14:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 555D428A236
	for <lists+dmaengine@lfdr.de>; Fri,  7 Jun 2024 12:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183A718F2E8;
	Fri,  7 Jun 2024 12:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ga6RQ8cN"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B45186E56;
	Fri,  7 Jun 2024 12:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717763025; cv=none; b=We/yBCmA758qJTJb86ZWX1+9dAaCvDFc7bQu4FnQ7q+GkoWROFlHvqT8zBfDGjj92ttonRMzZyggduAu6mRFKRShDkHxX+wwnrM/OR0B1RqyIrMlW6ggUkX5jp5dULAAC+cCimgJyPtYUKL9wPyy4peeAlbnv3AfkSwzKeAzsTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717763025; c=relaxed/simple;
	bh=KXaT31eEGTd1QHcbggRukrvi8jLZCohTrUf9ufQF3Io=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tbwUFFEmeelO7CVoyIvbZwBZrsNnIdZJzbhPye5O8u2VA3CCZEgZTknXLqxF7wLMvwBPm8bVow9+htmkys/tvGGrzDqT7t0seDRgJf71oM6cZdMgrRXfk7g+85sZkdeWb0OPLBVel2RlS9BvjBSGfx89jdXtj4VHRsJL78VBOUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ga6RQ8cN; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1717762993; x=1718367793; i=markus.elfring@web.de;
	bh=xnbflH3Wg1z5GvtBOo9DAO3UHstyphUXTt3DOwd9w58=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ga6RQ8cNFDFq+7yR7zmw2wthREsvMJqzpr6gjIuF89FPKOhjFnFh7QcmoGqG3oOu
	 DUgf5+V/BIppxa3tC82IY/bX4cOypmtzSuqlRFCI/T80NA2eQfzBgB+D04aqYOBnp
	 WEsa1C02wS5Xk6I9YhxrP3euU2VJZriBlS0XktTuUMxl5T8gERXU0f4cSniVSFKmx
	 sY5jFoCcC0FV0RoiLIR3ikXI/F7DQwG8HrvZzW/aeBQTo7hIW1st/HERWAtJbp7Gr
	 czAfWj7K69QIKKCuMlx2rTONYLLZeJ7hwRfNakmeJEjwcKqkknXh6OXuIZqaoFmcI
	 KKsxCUviv1cKxbocQQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MbTH3-1sr5AW1Zrl-00im4v; Fri, 07
 Jun 2024 14:23:13 +0200
Message-ID: <5bd85dce-13a8-4558-a574-726626ecbc5c@web.de>
Date: Fri, 7 Jun 2024 14:23:10 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dmaengine: xilinx: xdma: Fix data synchronisation in
 xdma_channel_isr()
To: Louis Chauvet <louis.chauvet@bootlin.com>, Lizhi Hou <lizhi.hou@amd.com>,
 Brian Xu <brian.xu@amd.com>, Raj Kumar Rampelli
 <raj.kumar.rampelli@amd.com>, Vinod Koul <vkoul@kernel.org>,
 Michal Simek <michal.simek@amd.com>, dmaengine@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240607-xdma-fixes-v2-1-0282319ce345@bootlin.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240607-xdma-fixes-v2-1-0282319ce345@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Rq71xYcv7AE6RT6snxQ/7L88lxsSpvjLIAAaV4rGhD5tibDU584
 1LWrBOqL29y9nPpWAn/JgJSLhNtW4eDFr0O1eQj218dpPrjTDHu9zGDTR8fez75LcXyUq4S
 u6fajeEzdtMNsaylUW4Jya1qLHXgNLoPOJpLUShnTucCcukiU7UIlkBhE1E1mK6yr3o1oBW
 COJ5G9AUsu+8e2I5vVSjw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2ZuDCsg8jSw=;FL/XvPK9CgStER9vsTkVwtyJ/nA
 sGzNB0h8wq0C3Z379vJ4IsFOQ6Z52BqnhKu/D8C4APJTwcW8jAIAr6DoCoBBu33yCDSm7jykm
 tqQsbfJTHBiO5vHUnIM56Kq2ZJfx4lx//v4autdr9SBK4pCmNTEi02bzcgGnC6epqLFvJIovZ
 rzx9k+PW1ZgMhpibsYmg7eU8j+QianriZu2Jcfz/T8TH+2VPQRCUnc5Uvv3LAB1H7j/27VGqM
 uar1o8rNEfDk338wpx1eO/0FfZfZWGADkALr+gl2FXePQw4rRkrsmtTVHnAXMoNLRhc845MMe
 maY9hLrkVUjsMfwU9ClsrSFjNo+ZV2703nyVp5tSWiqlmi0y34Bb1c/70D1oVm7W9JWWSCgD8
 IZuYg51yJjb5OS+KUrx8BoV7+eTwW2Vfm3d89w84CcNOMkEWBQkWXGuUNDmrrQ/j/pBpe5W2j
 zuTO3YL8T+LMV9TZwIFUve+TRcpgLIa4La+/jxYm0VgMBrKCuyOwuUU+gNwrW6/wt5N5W8TAH
 elCNMyDMXio49MDI3rooDULUgiwkWPHuYKpKwmXiMRUYZ1U3wRmby0xLfxMdsnH5oniAlZ33o
 HZuLxwh6jgNcjbuIiJRFvE1xO4SF0z1+3dvHquzwPt+sXpE5CSnOej3cIgZsOquNmxImYgFqT
 1cl08dS3M8VOmYzdIk6Mjwn7JQtWapFOFSrHu8oO3Ykhnc/dEaCsO6vlMYZtOj/EPy5mr8PqV
 cX7FUCNBgVMpNzCHbFOiiR2mKpcSaFD+YqlB7OQEm+cb9B9X/NACa4mhIuqRFEPk81/1COZWg
 FLmOoSJ0QXNA/wl/oMtosV82mSus3qSny6vQhA2HJ5AUA=

=E2=80=A6
> +++ b/drivers/dma/xilinx/xdma.c
> @@ -885,11 +885,11 @@ static irqreturn_t xdma_channel_isr(int irq, void =
*dev_id)
>  	u32 st;
>  	bool repeat_tx;
>
> +	spin_lock(&xchan->vchan.lock);
> +
>  	if (xchan->stop_requested)
>  		complete(&xchan->last_interrupt);
=E2=80=A6

Can any lock scope adjustments matter also for another variable definition=
?
https://elixir.bootlin.com/linux/v6.10-rc2/source/drivers/dma/xilinx/xdma.=
c#L873

	struct xdma_device *xdev =3D xchan->xdev_hdl;


Regards,
Markus

