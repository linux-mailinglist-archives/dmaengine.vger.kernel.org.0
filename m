Return-Path: <dmaengine+bounces-5162-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C34FAB6EBA
	for <lists+dmaengine@lfdr.de>; Wed, 14 May 2025 17:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 686484C3D3A
	for <lists+dmaengine@lfdr.de>; Wed, 14 May 2025 15:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241D61CEAB2;
	Wed, 14 May 2025 15:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAqmd5d9"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6FA1CCB40;
	Wed, 14 May 2025 15:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747234964; cv=none; b=d4gEYtk0i4SQt4utXseqSWYJujUZa+50oSOJsqgsLpjGYP5y+HWcubtylZcddtXI9p81Y82YnWuxCyM79vosTS8q8uvQ7cv8/QT+g3anSi9B0pWAEt3rxsh2acYT0xsaFP6ltRTJXQvjByEPN/u62BePZe3RvNBmOSIT80MTIEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747234964; c=relaxed/simple;
	bh=5VGSJ7ucwRKC6ig6fod1DNEI/NamUi+YyuaqfxQA9b0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gG4FY+yeKvRlB79YSjJzjpD77+P3kgbDJfVmcaAF52Re3uSQCYXexR6kkhJR3XznnJg20aIyE3ia/BWkZvZoj2/4fR9GE5oF7h+z+YsQlSyr39QSzBHx+Sm2FYsFqf1z9AIxsk4kT2ruNqQ3ry32ddAeIMsfVqm7G8Em+ItM/Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAqmd5d9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2709EC4CEE9;
	Wed, 14 May 2025 15:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747234962;
	bh=5VGSJ7ucwRKC6ig6fod1DNEI/NamUi+YyuaqfxQA9b0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bAqmd5d9I3Oa8Xej6pTZ4LohxpRS9jd975k8zC3+nk+yYncY4V0NH+anaEQWiEb4F
	 ggMClI4/kHUyvHhZe3i6D5SfvWtk/UUcWsSUoC4L/hqhRqlqNX0eXgNBFLnpbBm59K
	 KTVRHKeW3GHB+hpyj534CT1o+iFLUPJZUiPTAvXDXeW7CHZ8Nir1Nftei7MyiVXP6T
	 P1YOjUsE8gTbheXtG1L8TGZlRFbTOjg6rqPfGUN88RFWaUmkMroDXTeN7O5zXf6R26
	 WCWNCHVxZ0nBT7S0kt7+VMJhw/C+hwzxPbqC7iaOiO2HcL2U1HFFudDyBBWHHf7Hhz
	 1ORZI3AHOgakQ==
From: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.Li@nxp.com>, Joy Zou <joy.zou@nxp.com>, 
 Stefan Wahren <wahrenst@gmx.net>
Cc: imx@lists.linux.dev, dmaengine@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20250424114829.9055-1-wahrenst@gmx.net>
References: <20250424114829.9055-1-wahrenst@gmx.net>
Subject: Re: [PATCH RFC] dmaengine: fsl-edma: Fix return code for unhandled
 interrupts
Message-Id: <174723496086.115648.13109604693240649188.b4-ty@kernel.org>
Date: Wed, 14 May 2025 16:02:40 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 24 Apr 2025 13:48:29 +0200, Stefan Wahren wrote:
> For fsl,imx93-edma4 two DMA channels share the same interrupt.
> So in case fsl_edma3_tx_handler is called for the "wrong"
> channel, the return code must be IRQ_NONE. This signalize that
> the interrupt wasn't handled.
> 
> 

Applied, thanks!

[1/1] dmaengine: fsl-edma: Fix return code for unhandled interrupts
      commit: 5e27af0514e2249a9ccc9a762abd3b74e03a1f90

Best regards,
-- 
~Vinod



