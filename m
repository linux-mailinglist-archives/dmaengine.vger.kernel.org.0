Return-Path: <dmaengine+bounces-2807-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E6394807A
	for <lists+dmaengine@lfdr.de>; Mon,  5 Aug 2024 19:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D395D1F23424
	for <lists+dmaengine@lfdr.de>; Mon,  5 Aug 2024 17:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C62169AC5;
	Mon,  5 Aug 2024 17:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4KSvJv4"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0181684A8;
	Mon,  5 Aug 2024 17:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722879496; cv=none; b=DQt9MvS97nYid14DyX9ai5pB0z2HkqoPdMan5JNqdeP7RrW20vWyvjNKs5A67xgyaJAq1TT5SLaewZuyq2P3WT2aNhA1NsMsNsLP4a5xWGsuKRBglzClGHYtl/lj+dWtFPXGAEI8uYHfA1UZ6Z4KAxLakHgOS4E2Um4lW4Pz/N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722879496; c=relaxed/simple;
	bh=VQjQBpaLoV3yiBsxZPPXaBypAB78+0TZoewXlRcWDFo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CmV0TnL2X83+FEZ96+dIemBJYtANIiJjkpfKWmfeqglwFLGX3x6UaZdqSc4y0/FBF1htwlTwnUVPslV5z0blsWYgmm5S7Q/zc3bN0kMHg2QAfdiMWMnTQcKBPajVbrCyRcB+HFCnkUAMqS/8JkJvbNVAaYoC9kBkH6bhJl+b/sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4KSvJv4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4D2CC32782;
	Mon,  5 Aug 2024 17:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722879495;
	bh=VQjQBpaLoV3yiBsxZPPXaBypAB78+0TZoewXlRcWDFo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=R4KSvJv4BlaXD1qJ6cI6afZXx4hqWaCosIhdoK5oy0Ln0EoCYpkNUAmjFNvgvuohy
	 seJPtOzqqMqG158j35GRM3xFu/QoJbFSu294+KJR1e/AzX8vQ6j7m5s6gNqyI7Ib4x
	 p5OxB1WUWnf7xLj6Fh8KS2p0pLT44J1QCJAGaASMjHrqPqEX7ynAcHLI+6tiMJaqHl
	 rIvgBqp6T6/spRrHlItwO2m9rU9s7tli2vU2RdFIok6H3lOEG4rKX1PUiMnKSk6E3b
	 eZ1mfv1BFf+Sv7hZKivZIZihLLe+zip0Ov3mOVx4VlQuLQwStyHAoYqmwXwV73fuHd
	 wQ7y2MaA6m3SQ==
From: Vinod Koul <vkoul@kernel.org>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240711132001.92157-1-thorsten.blum@toblux.com>
References: <20240711132001.92157-1-thorsten.blum@toblux.com>
Subject: Re: [PATCH] dmaengine: dmatest: Explicitly cast divisor to u32
Message-Id: <172287949457.489137.6420336100082404989.b4-ty@kernel.org>
Date: Mon, 05 Aug 2024 23:08:14 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 11 Jul 2024 15:20:01 +0200, Thorsten Blum wrote:
> As the comment explains, the while loop ensures that runtime fits into
> 32 bits. Since do_div() casts the divisor to u32 anyway, explicitly cast
> runtime to u32 to remove the following Coccinelle/coccicheck warning
> reported by do_div.cocci:
> 
>   WARNING: do_div() does a 64-by-32 division, please consider using div64_s64 instead
> 
> [...]

Applied, thanks!

[1/1] dmaengine: dmatest: Explicitly cast divisor to u32
      commit: da080d987e20a8b20b368c75826226834c9660a3

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


