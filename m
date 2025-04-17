Return-Path: <dmaengine+bounces-4918-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1552A92141
	for <lists+dmaengine@lfdr.de>; Thu, 17 Apr 2025 17:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 702858A1109
	for <lists+dmaengine@lfdr.de>; Thu, 17 Apr 2025 15:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489B925485C;
	Thu, 17 Apr 2025 15:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CsmvlMPf"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B9C254858;
	Thu, 17 Apr 2025 15:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744903138; cv=none; b=XNUWdY6PaWUozSpyhwWk0vAP3lTzeQKAIif2CWn+1IdIT71BbcEeNENXweVP3ZEx0KEES0x8RlmuG1oBLwlBKZ8pPdZce3oAU+Di7tvfgUf/FdwJW77z4LzKx47j1PPfHS3fLQ5G0+kNUd3X7X491z4GqkIWFDtQZt414SmL1FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744903138; c=relaxed/simple;
	bh=EHyKrvw9U4B5SWdJLt0Is0EeLwfWjVJZGYvKDtb/oog=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZR9YFAhZ90sP0izzGKvhEKTol1k3SSXHnHGjfF7UuriSa4uFiCduYzmFWc5ZKBhFz7AdM1v5wNc1Dxqt0Pzg5geebvQwYXQm9vmvBK2Fc/WZO9Y9YP1i/4Ys73I35EtFZVZqy2vNpDjo9Aq667Fpwd2u459b5albFgrrbolnTPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CsmvlMPf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5402C4CEE4;
	Thu, 17 Apr 2025 15:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744903138;
	bh=EHyKrvw9U4B5SWdJLt0Is0EeLwfWjVJZGYvKDtb/oog=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=CsmvlMPfL4lc9L3iDqVYx7P/NnvyOFnkgghBJ26XFmrCBvnEaUt6KYDUW0YY5DU1E
	 6Fmo9NA5mu3d8J9QOyprKAxBGL9oGYzjr1ZBoJ+tggH7CmY1vxXpnektQWhEih9tBa
	 evNd88HsMdYQACQerJQcfjf9EsH9hM5VzG6m/VJk3uPfobOfxPixOs7J5Km8vQK/FJ
	 qMLQnT6vzJOs/rKVPq6WVVLg+1hChdY7tgolgpfvmnr4aeGvYQ7RTKuS5wNbewjpMz
	 AfAhWVQ/C/JDzAkrFJA58L+MmdKFLgvMJU3IbYiOsfy48y0dOr8jLypyNi0Iz4mtvN
	 SVoSlyGS4Yo8Q==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org, 
 Thomas Gessler <thomas.gessler@brueckmann-gmbh.de>
Cc: Michal Simek <michal.simek@amd.com>, Marek Vasut <marex@denx.de>, 
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250314134717.703287-1-thomas.gessler@brueckmann-gmbh.de>
References: <20250314134717.703287-1-thomas.gessler@brueckmann-gmbh.de>
Subject: Re: [PATCH] dmaengine: xilinx_dma: Set max segment size
Message-Id: <174490313549.238725.11612673810296671348.b4-ty@kernel.org>
Date: Thu, 17 Apr 2025 20:48:55 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 14 Mar 2025 14:47:15 +0100, Thomas Gessler wrote:
> Set the maximumg DMA segment size from the actual core configuration
> value. Without this setting, the default value of 64 KiB is reported,
> and larger sizes cannot be used for IIO DMAEngine buffers.
> 
> 

Applied, thanks!

[1/1] dmaengine: xilinx_dma: Set max segment size
      commit: ebf744fdc080763a243ea6b1a719b1857474a977

Best regards,
-- 
~Vinod



