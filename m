Return-Path: <dmaengine+bounces-898-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD658429EC
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jan 2024 17:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ADEC283175
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jan 2024 16:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1467B86AD3;
	Tue, 30 Jan 2024 16:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHXFp/p9"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70B91E4A1;
	Tue, 30 Jan 2024 16:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706633446; cv=none; b=j8cgnCAsu95yOwQ3+1mEbDPrISXCxPXs+fnc0bMQDi2Gu9yU8vp7LrHj8VMqWhDTmXqhnFbe/1PtKiXVYo9afCR8GXgW7gxzZ/z/8ozu+P97H+Ie54HXpcDirte8DJXZzqYTmYMf9/MWFeVQxGtVZ3NnUwlDrkr0kv2VZF+94s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706633446; c=relaxed/simple;
	bh=KCkxiDMO++TE0CToP0JnZm8TViWY/57apCRph4GiQNw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=s+aryCF816q4alQk9J8lkk3ravBnH0yQXyRnGUBmCtITDScFls/TDM+LxH4lsN/kJ71toOWCc6Y3JerpCHyHLQ1K81u4WXwI6u2uFOjrfvFZsfKQmHUwk1BA0jNWz4MHEqmAQQrUx38v3k1YuzewjrNN2DHcYLj+wEy1eCoaHcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHXFp/p9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927C1C433C7;
	Tue, 30 Jan 2024 16:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706633445;
	bh=KCkxiDMO++TE0CToP0JnZm8TViWY/57apCRph4GiQNw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=XHXFp/p9TCZxrMhRNwZyiSMFBlKJAUMdJY/cWsRNtg2Td7rqMJbdM302/eKOMMQtd
	 hAqAOFJXS0AFPHXMGdPjh/UhG7Kzfw3LhxYAiiqrDeEcwlNTPnQ9VWTqF6MNQnsrNu
	 UI4eFQ7HO2YfMpV8DaH7j9B1Ru5/sMnX4ALtyCCaGDnbSWPAd8epd4JWMRK8M9S1nD
	 yFX5NUS0Pj//jJk38MD8clfWRObQIxzOLeiVi9GyUkTc8L0+ffYA5BWKJ8F7k7tx6b
	 /lPyrX3umWsrGDJQVihrY7rjFlF8Lmfqk5ytaI4vJ33uTSDWPs0f18DqsmQUNPWtSG
	 vZiSEYEs45wtQ==
From: Vinod Koul <vkoul@kernel.org>
To: Barry Song <Baohua.Song@csr.com>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
Cc: imx@lists.linux.dev
In-Reply-To: <20240123172842.3764529-1-Frank.Li@nxp.com>
References: <20240123172842.3764529-1-Frank.Li@nxp.com>
Subject: Re: [PATCH 1/1] dmaengine: fix is_slave_direction() return false
 when DMA_DEV_TO_DEV
Message-Id: <170663344320.657338.6849422221928151453.b4-ty@kernel.org>
Date: Tue, 30 Jan 2024 22:20:43 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Tue, 23 Jan 2024 12:28:41 -0500, Frank Li wrote:
> is_slave_direction() should return true when direction is DMA_DEV_TO_DEV.
> 
> 

Applied, thanks!

[1/1] dmaengine: fix is_slave_direction() return false when DMA_DEV_TO_DEV
      commit: a22fe1d6dec7e98535b97249fdc95c2be79120bb

Best regards,
-- 
~Vinod



