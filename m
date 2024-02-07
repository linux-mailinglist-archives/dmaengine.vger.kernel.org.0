Return-Path: <dmaengine+bounces-970-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A9B84C69D
	for <lists+dmaengine@lfdr.de>; Wed,  7 Feb 2024 09:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96447285608
	for <lists+dmaengine@lfdr.de>; Wed,  7 Feb 2024 08:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A0720DF5;
	Wed,  7 Feb 2024 08:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zq0Hachs"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2AB20DCC;
	Wed,  7 Feb 2024 08:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707295761; cv=none; b=oj1jgvdO0+yFUEaOnTRRTKX/7HAftGwkatE6k44+MQufv8TS9lMu3Fe7/cGDa7HULosGFgi6vNF3LBp9ZMCCZqY35zm4hhhQMFEjCsn1IJoXdC0B4jN0Mr+Rh+9DLYkmTpiY+BuLELTZaGuNCnwqT9s9Kn8bZJiJ9/U8E41JNCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707295761; c=relaxed/simple;
	bh=zc54aVyU4jtqep4B6y91kkFrsOUQP1ry2uOVPeJMicM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GlrSGsk9u2RGoWdpEzhzXojxv0uvtoLUMMMhElSRZ+4bxffwnFat12TgiiR6x9jTbx5yNDRtsFeN/f5ovqEzqla/YDkbwEi9i/C8MqxTkl/U1i1zYUINkUUW6S58LgKzA+SXrqzDBeL/SmQ6NQNeMaufK+ia5IGVCmbusyBXMXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zq0Hachs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C68A9C43330;
	Wed,  7 Feb 2024 08:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707295761;
	bh=zc54aVyU4jtqep4B6y91kkFrsOUQP1ry2uOVPeJMicM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Zq0HachsFpk10h+JYAE2WWx5AR3gVR2fi7Vn44WttmSDiQr8xNsDBn1sonvm4grcg
	 4838eH880TP89kipXHPn8RpsLjLGSEA1Wol+fccEsTXcCS5AweYdejaV+fqQnTJJLo
	 UlUkw7lSqEsJeSGaEkH4qrauXKFkfWCGowJ6XxVFrmyn7TBfNEm/GzRI9Xq6kofX/w
	 3+vTH9tDtnlgY9eDROjs8RLR2jdzR7w0hmAGR59/biuAfQTrDdfBC2nH9AF7zQDJG7
	 8SnvMf4YIT9ZtVZSbg/5TJ9NxEyvA96Lyq/jsMlWd9eTvgDko67nRpXtTYo0t337Kg
	 Gy6UYd2cPJGfw==
From: Vinod Koul <vkoul@kernel.org>
To: Peng Ma <peng.ma@nxp.com>, Jiaheng Fan <jiaheng.fan@nxp.com>, 
 Wen He <wen.he_1@nxp.com>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
Cc: imx@lists.linux.dev
In-Reply-To: <20240201220406.440145-1-Frank.Li@nxp.com>
References: <20240201220406.440145-1-Frank.Li@nxp.com>
Subject: Re: [PATCH 1/1] dmaengine: fsl-qdma: init irq after reg
 initialization
Message-Id: <170729575955.88665.8594869298127799288.b4-ty@kernel.org>
Date: Wed, 07 Feb 2024 09:49:19 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Thu, 01 Feb 2024 17:04:06 -0500, Frank Li wrote:
> Initialize the qDMA irqs after the registers are configured so that
> interrupts that may have been pending from a primary kernel don't get
> processed by the irq handler before it is ready to and cause panic with
> the following trace:
> 
>   Call trace:
>    fsl_qdma_queue_handler+0xf8/0x3e8
>    __handle_irq_event_percpu+0x78/0x2b0
>    handle_irq_event_percpu+0x1c/0x68
>    handle_irq_event+0x44/0x78
>    handle_fasteoi_irq+0xc8/0x178
>    generic_handle_irq+0x24/0x38
>    __handle_domain_irq+0x90/0x100
>    gic_handle_irq+0x5c/0xb8
>    el1_irq+0xb8/0x180
>    _raw_spin_unlock_irqrestore+0x14/0x40
>    __setup_irq+0x4bc/0x798
>    request_threaded_irq+0xd8/0x190
>    devm_request_threaded_irq+0x74/0xe8
>    fsl_qdma_probe+0x4d4/0xca8
>    platform_drv_probe+0x50/0xa0
>    really_probe+0xe0/0x3f8
>    driver_probe_device+0x64/0x130
>    device_driver_attach+0x6c/0x78
>    __driver_attach+0xbc/0x158
>    bus_for_each_dev+0x5c/0x98
>    driver_attach+0x20/0x28
>    bus_add_driver+0x158/0x220
>    driver_register+0x60/0x110
>    __platform_driver_register+0x44/0x50
>    fsl_qdma_driver_init+0x18/0x20
>    do_one_initcall+0x48/0x258
>    kernel_init_freeable+0x1a4/0x23c
>    kernel_init+0x10/0xf8
>    ret_from_fork+0x10/0x18
> 
> [...]

Applied, thanks!

[1/1] dmaengine: fsl-qdma: init irq after reg initialization
      commit: 87a39071e0b639f45e05d296cc0538eef44ec0bd

Best regards,
-- 
~Vinod



