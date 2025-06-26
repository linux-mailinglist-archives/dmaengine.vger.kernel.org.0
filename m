Return-Path: <dmaengine+bounces-5643-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B42AEA9FF
	for <lists+dmaengine@lfdr.de>; Fri, 27 Jun 2025 00:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5650E3B09E1
	for <lists+dmaengine@lfdr.de>; Thu, 26 Jun 2025 22:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAEE22B8A4;
	Thu, 26 Jun 2025 22:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZrsg3vd"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658D022A4FC;
	Thu, 26 Jun 2025 22:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750978090; cv=none; b=EjWk1Yny530YqxIi637YBJ/0qsPPOw46CgPmW8wfAIPcLCRvyGjPnOluE0Twcl5yLlHVy6VLSSLqxtuNT1w2TLh8WEup0NhtWW2ThgG4OSIjHTvwi5ZCiJTgbV1Qu3T1wZiG/HqBpJV2qft7uxUbqm/HiXUzePR3NUA9QW0blXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750978090; c=relaxed/simple;
	bh=nUQQ+LnpVtcSiEKYNyLJQYQ3qpwW8j9at1ttj37bRoE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=p3WYPUqE3s8NL6yQcgFLb5aVEftS+8Zy0SOenb+Oa2jQb6pigsroHSe41nH2Z6CXDiEwpDkhBpULT3ozdYlOphC/UCro01ihWUpE+MADtaFMCVXO77FwcnmgAudlhe+e0FMujM7eFpAxBGjb/yGCGdpQExOMM5Ux/jzGmzurwRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZrsg3vd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B8ECC4CEF3;
	Thu, 26 Jun 2025 22:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750978090;
	bh=nUQQ+LnpVtcSiEKYNyLJQYQ3qpwW8j9at1ttj37bRoE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=AZrsg3vdrJ0h/iRGea67V1Kjd16l35Zwmo76Qa+vj2q6zwKi6v1Ah9wl5WBNB2lWA
	 462gKoTgs4izGfLnhp01Ost894ecgtMAompg3rOGHh9oemcMIwy0PMbxuwbusSQVKY
	 fw6S23NxOWG9YyYiQzNL+cZtIgSPGh1ng98fu7XWyg8Lv2s/5/8WvWaCQsFMyrs57q
	 u4h98kx8k8VqrMM4LWU1NznJl/nfN3t9HfmaPB7MUNbSpaSI78hvBQHfpx4j1oqp17
	 Q1mIL9Fqi48UYRj4WZN9oDtSMDX/U6NaI3pfNJqSRaB2pESV6QiMM6OYGOb3NP/7/E
	 oSYMevKyeDRGQ==
From: Vinod Koul <vkoul@kernel.org>
To: =?utf-8?q?Am=C3=A9lie_Delaunay?= <amelie.delaunay@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: dmaengine@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250618-restricted-pointers-dma-v2-1-bc39dafc201d@linutronix.de>
References: <20250618-restricted-pointers-dma-v2-1-bc39dafc201d@linutronix.de>
Subject: Re: [PATCH v2] dmaengine: stm32: Don't use %pK through printk
Message-Id: <175097809000.79884.3200943794194377896.b4-ty@kernel.org>
Date: Thu, 26 Jun 2025 15:48:10 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0


On Wed, 18 Jun 2025 09:43:34 +0200, Thomas Weißschuh wrote:
> In the past %pK was preferable to %p as it would not leak raw pointer
> values into the kernel log.
> Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
> the regular %p has been improved to avoid this issue.
> Furthermore, restricted pointers ("%pK") were never meant to be used
> through printk(). They can still unintentionally leak raw pointers or
> acquire sleeping locks in atomic contexts.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: stm32: Don't use %pK through printk
      commit: 6e6d3c6f0ef235a95c25385b2dad98e8ad6223eb

Best regards,
-- 
~Vinod



