Return-Path: <dmaengine+bounces-2345-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D79490439A
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jun 2024 20:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10D8E1C23DB2
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jun 2024 18:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A475E155300;
	Tue, 11 Jun 2024 18:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRrCui99"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5D61552F5;
	Tue, 11 Jun 2024 18:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718130495; cv=none; b=tC0fcHOFuFUhe134Ar7jo+MMV83gYHGUUOzLqKZa4bRNlo63Y+jbEUDbpBDmJFCEe+r5WamxH9SZ8zZ8TzAtkvnvjA0j7top+YR+EpyJpoHVJnKrFWiGmZmhQsskOU96P44V6xP/4WNn40axiazWOUNN1Buz/KpAKPdDV3wHm90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718130495; c=relaxed/simple;
	bh=8D3OQHswbC2P361Pk4nAjaQ8dTehgzedq3gMFTInLtc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cE+igpbn5jp43T7bFVz0bOcLXSRLMuM62kI9zUUM04zkuXJWOK/kjUSX7rOlMtTEOQsUR9JrWJ6CPp/eNRq0INWQ9fHJXwPLIVJw874azOLzCQdIctZq/wLKCmvUYLr4swvMJHGvYeFJpvUJ3+uj7OUDqvvQxpFwbrI2u13SxXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRrCui99; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7EE4C4AF1C;
	Tue, 11 Jun 2024 18:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718130495;
	bh=8D3OQHswbC2P361Pk4nAjaQ8dTehgzedq3gMFTInLtc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=QRrCui992V9IfdotZKly/zbhK6eD25lwtUDek98rtgLGr6C7q2VaeEx6JygXMohDS
	 7S622XaPYVzjgwUQuVnxHbsb5BPIZKKiP+ympjpTo6Ju+BjrZ6MEhOP0seWSa/ldWx
	 7A5r5dRBSCmxBa0ftYEHWhayd0RSU+V/KI0ByjeVL9Rs67i+rXWM9+ECU/GywtX7Ts
	 /6GpLQNa4ck+zjpvj1vULY55QFhVEOLs9Y0LYTxDHDGUSDjRTCuC7RiMK4lHQ3h5NU
	 w0hqXaSJccrn88AxxjfJ/IXW9rCzhgjUBWZNfOOSReI5SWomtzwFpoT3MrMrgSzOrd
	 3vgffo+LR/6Fw==
From: Vinod Koul <vkoul@kernel.org>
To: Stefan Roese <sr@denx.de>, 
 Olivier Dautricourt <olivierdautricourt@gmail.com>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
 Eric Schwarz <eas@sw-optimization.com>
In-Reply-To: <20240608213216.25087-1-olivierdautricourt@gmail.com>
References: <20240608213216.25087-1-olivierdautricourt@gmail.com>
Subject: Re: [PATCH v2 1/3] dmaengine: altera-msgdma: use irq variant of
 spin_lock/unlock while invoking callbacks
Message-Id: <171813049334.475662.18180872896770044456.b4-ty@kernel.org>
Date: Tue, 11 Jun 2024 23:58:13 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Sat, 08 Jun 2024 23:31:46 +0200, Olivier Dautricourt wrote:
> As we first take the lock with spin_lock_irqsave in msgdma_tasklet, Lockdep
> might complain about this. Inspired by commit 9558cf4ad07e
> ("dmaengine: zynqmp_dma: fix lockdep warning in tasklet")
> 
> 

Applied, thanks!

[1/3] dmaengine: altera-msgdma: use irq variant of spin_lock/unlock while invoking callbacks
      commit: 261d3a85d959841821ca0d69f9d7b0d4087661c4
[2/3] dmaengine: altera-msgdma: cleanup after completing all descriptors
      commit: d3ddfab0969b19a7dee3753010bb3ea94a0cccd1
[3/3] dmaengine: altera-msgdma: properly free descriptor in msgdma_free_descriptor
      commit: 54e4ada1a4206f878e345ae01cf37347d803d1b1

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


