Return-Path: <dmaengine+bounces-7885-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 034D1CD91F7
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 12:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87F23303C28B
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 11:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31F9332EAD;
	Tue, 23 Dec 2025 11:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCBcBDjl"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DD93314A1;
	Tue, 23 Dec 2025 11:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766489318; cv=none; b=i4F5IbY1mOWbiCga8N22qEz8zY01zE6j3GtYcHTKvTpj8UHwZ8OyZBtOxvJSaqs8z3mhq/Hoch6dG1lhgYnSk52jFYOUR19IjKt9HBqpVXxBmcd75uXccUSLRAU+5jLKbxbLmOpbaKA8muKR7AUjGS2DzDV1o7DBUyWsBhjff2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766489318; c=relaxed/simple;
	bh=Tm8R2leKhxvnmeFGXEZGpqxajmXEOFr0rcTR1ZihUU8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZVdqgxCl36lNFIg0+sLIAzo16YjU7+Ss952J8TeNWYRnTRXKTJWGw+d+shXKm/B++29B65w9WdmXKiqeKyk2z0aeNJA6tAHtj2T5jdpCGexbH4bgH/uEnixb+GfBwQQY1Gz/OXEqPqwfEBJ34ceiTGN7WP9xSVRBI12C8wwVgyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCBcBDjl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26E1EC113D0;
	Tue, 23 Dec 2025 11:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766489318;
	bh=Tm8R2leKhxvnmeFGXEZGpqxajmXEOFr0rcTR1ZihUU8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JCBcBDjlQFTElL7ukWRUxSymq3CFEcVXnU2TlXqMIlrSVcq2refTFz7qEtg36PJln
	 jeJFkUO15tP/WrhZWKW74Lg8db2O7Edw5kMykz4+3XrZQkkdrmfF43SevQWDP7t0nQ
	 z9ZZJN9VebljRdwvPVdYKZWCfSneJj1yfYRMFEuVPXC4LWXCJGDgl4ih2fQrbpJ5b9
	 +/eKcBNwatf3sCIUl9y3bSqXbHFdZxd32yPYInibaZ4uaBLu4kVGbQYMlLa5YfvcVM
	 qtyWKlDeZdruKoOI+k09VtyDfAxjOOAe9r7XQd3biOoAYFr7t+fA0J0tiXfkzyzDIX
	 Aj9ErDx/zMBSQ==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20251106022015.84970-1-rosenp@gmail.com>
References: <20251106022015.84970-1-rosenp@gmail.com>
Subject: Re: [PATCH dmaengine 0/2] dmaengine: st_fdma: support COMPILE_TEST
Message-Id: <176648931679.697163.16396174417183020187.b4-ty@kernel.org>
Date: Tue, 23 Dec 2025 16:58:36 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 05 Nov 2025 18:20:13 -0800, Rosen Penev wrote:
> First commit fixes compilation under 64-bit and second actually enables
> it.
> 
> Rosen Penev (2):
>   dmaengine: st_fdma: change dreg_line to long
>   dmaengine: st_fdma: add COMPILE_TEST support
> 
> [...]

Applied, thanks!

[1/2] dmaengine: st_fdma: change dreg_line to long
      commit: 19fed6ca15c4c41c28059c25f9cc85c0058cc4fd
[2/2] dmaengine: st_fdma: add COMPILE_TEST support
      commit: c3af05623e079c2a9a9363386796fdea20defa18

Best regards,
-- 
~Vinod



