Return-Path: <dmaengine+bounces-2350-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CBD9043A7
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jun 2024 20:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE0D71F251BA
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jun 2024 18:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BAC6156227;
	Tue, 11 Jun 2024 18:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="snSiSNmC"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D278680C03;
	Tue, 11 Jun 2024 18:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718130509; cv=none; b=fyGLF1gKtXjTiOCukhJqiOAKTWZ+hwc/TDi+EKBD2+nsES6ekqQ4X1F58BSSuK6ZKtxO0W3qNKOqZ1Wt8AJBCVSsMZb5hdD2jKvlQkqmjOu82jxbTS3uodWHNk6SDuQn0GgT+/txVCrZTNioJoSOVppiYNZJh5aOysJ4izTm0iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718130509; c=relaxed/simple;
	bh=bPeE4jluIw13QwOYSdkGvUGAxzeLN+qD7fwRi95zID8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RQH22Oh1mXJUVhDzMXJ5Me2G/pg8pegKlPbiJ79b/yqS6ga+mNsgh1tVfKAjhBB6QG++3pEHaSNSAfXGpZfp6fVDboGxBmc32oXld8t/yGOvInInc8U6w9NEJBWBF56DC2KEChMpyRw03pSaCeHT+rXp9JnXN4AalEl/kS6xY30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=snSiSNmC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D09C4AF1C;
	Tue, 11 Jun 2024 18:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718130509;
	bh=bPeE4jluIw13QwOYSdkGvUGAxzeLN+qD7fwRi95zID8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=snSiSNmCEpnyYvucGnRjxdxbHVr20LKA6o/B3v2Chbz01wahttuUUpuL+LL5XdSdr
	 uk0PzzjU+i+lQxBpMmUJiDauPoGF5lKf6HFvraFz+2meOp+YDCbzAY6afFt3kXPrMa
	 MDrRPs/G3/Eno1pfSAHHky1+k05KWCrrOf5Sd+XXwZW44AqC1aq8xm3Fyq3PjNZBrr
	 g4/CnF3SskjONUiaLhCF7PWstlA+ZLB3kM9RRXPg1Re2+nZl7eXk2362FIB1CF5Y1u
	 iRR+2cmV2Wdv5/gcFiKtU5gTpK29da8rBzNXfEqpu0m8CEGQ9Nd+ZxSYUbob3sPHTI
	 4zytIANS1bLHQ==
From: Vinod Koul <vkoul@kernel.org>
To: bryan.odonoghue@linaro.org, Frank.li@nxp.com, linux@treblig.org
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240517234024.231477-1-linux@treblig.org>
References: <20240517234024.231477-1-linux@treblig.org>
Subject: Re: [PATCH v3] dmaengine: qcom: gpi: remove unused struct
 'reg_info'
Message-Id: <171813050721.475662.13719019207799425584.b4-ty@kernel.org>
Date: Tue, 11 Jun 2024 23:58:27 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Sat, 18 May 2024 00:40:24 +0100, linux@treblig.org wrote:
> 'reg_info' was never used since it's initial
> commit 5d0c3533a19f ("dmaengine: qcom: Add GPI dma driver")
> Remove it.
> 
> 

Applied, thanks!

[1/1] dmaengine: qcom: gpi: remove unused struct 'reg_info'
      commit: 7dcf9e82e0a05cf7b7abccd0ce1b4ca598d70f08

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


