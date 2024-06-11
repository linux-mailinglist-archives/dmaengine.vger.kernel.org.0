Return-Path: <dmaengine+bounces-2347-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FE690439F
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jun 2024 20:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9923DB27525
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jun 2024 18:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C8E1553BF;
	Tue, 11 Jun 2024 18:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qaDttzYO"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A70D1553B4;
	Tue, 11 Jun 2024 18:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718130501; cv=none; b=oMXl9OKIOT0SOtnv4V9e7eWHXmgV7ZBx1qhUHokyE4H7lUj+elmluM08XSXA8pem2wZeuiJved/B9YvO+Qfl21lNEoqSKAjgytk5EDZzEBGcNdzUrW7MJpeAm+uQjGJbce2nL//Waxnb30qYnJda7Pvz10XWELIqAnT2tPPkqxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718130501; c=relaxed/simple;
	bh=wfA1da30CmPTkWYaNNBASZzD3aUSgxiND7E14LbAT5M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bzmxJ9NI3I97e+V0L85dPH4FtQcif4o0W5w9nYG9hZfDlae++ERW5J0WpnAATX/02Z4cpoHHXMBt/DiZlBFYfKA63pb7TPVnliqla2f6bBZFwBU20IEv6h8NW7dJpvZmZkMKqtAjNRFtsXOEyiZpLUpm+xqg3uk43YzaS98XLG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qaDttzYO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B6C5C4AF48;
	Tue, 11 Jun 2024 18:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718130501;
	bh=wfA1da30CmPTkWYaNNBASZzD3aUSgxiND7E14LbAT5M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qaDttzYO8KhPqwi3yEvixBOU6k0bvmQG/aBYzGkDPxF7MQWh5QPvsSaZUTYVXQF8U
	 EwUkINyZGtzrRuGtI6lsioR3lcFfws2smpC/06YTmk6Fh7Qk7LMe57xl0qVdcLHOwG
	 0H802/Ffht7vphtDI8gIJMznYMiwSgWpbKIGLTZ3qywmHDjJWnMpaZ1MzkJUhK+M3/
	 Zk30zjVkwqLxp3/VW3HvWXsyIs4vzX8gcUwTCh8XUfHmIjvoWmPJc3yLz2Ev4LjMFW
	 cLvUJMxy7WhTuy1nvcS1GKJ4fgek/Gs8DAwYqtSOIKLP0DcsuhPFzvGlO6upy6q0VE
	 jsQUtyM53CCdg==
From: Vinod Koul <vkoul@kernel.org>
To: imx@lists.linux.dev, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
Cc: imx@lists.linux.dev
In-Reply-To: <20240603152317.69917-1-Frank.Li@nxp.com>
References: <20240603152317.69917-1-Frank.Li@nxp.com>
Subject: Re: [PATCH v2 1/2] dmaengine: fsl-edma: request per-channel IRQ
 only when channel is allocated
Message-Id: <171813049980.475662.10470435420085877416.b4-ty@kernel.org>
Date: Tue, 11 Jun 2024 23:58:19 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 03 Jun 2024 11:23:15 -0400, Frank Li wrote:
> The edma feature individual IRQs for each DMA channel at some devices.
> Given the presence of numerous eDMA instances, each with multiple channels,
> IRQ request during probe results in an extensive list at /proc/interrupts.
> However, a significant portion of these channels remains unused by the
> system.
> 
> Request irq only when a DMA client driver requests a DMA channel.
> 
> [...]

Applied, thanks!

[1/2] dmaengine: fsl-edma: request per-channel IRQ only when channel is allocated
      commit: 44eb827264de4f14d8317692441e13f5e2aadbf2
[2/2] dmaengine: fsl-edma: remove redundant "idle" field from fsl_chan
      commit: bb160502a45440d2b52c189d5a81365c01b8d494

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


