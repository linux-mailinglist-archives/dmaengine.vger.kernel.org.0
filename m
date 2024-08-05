Return-Path: <dmaengine+bounces-2805-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E4B948075
	for <lists+dmaengine@lfdr.de>; Mon,  5 Aug 2024 19:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 830A01C21E06
	for <lists+dmaengine@lfdr.de>; Mon,  5 Aug 2024 17:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE67165EE3;
	Mon,  5 Aug 2024 17:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GnSchWyQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AAD166F0B;
	Mon,  5 Aug 2024 17:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722879492; cv=none; b=WKKipWnCQyUiJ/5Qna+MTIVDm1BMOwDX/3KtTnqylrCL589ysWM8j1xI+dW24RfVkQN8TYLC23wNz7WpVXWQHE+3w5zrDy8Yt0PfDVQPu1a4fblI+Jwv1xhqDQYxIuGNJxh8qOFmEvPBtx6U6ZQaT+YHJjQpnxT/NDsR+F4XJoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722879492; c=relaxed/simple;
	bh=nxR4LjhPkMaERMjLhviiy3Je47CLqyKxQkx8/VHzLyU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nymCzstBfWw1PHGyBWBnRXoqNvesTDH+W6JhvtS18CVORMBuDRZq15na/8evrFbIKA+NhpFPqgjWP2grwXF4LWeO/KdxvJJjZa9D3csnOOa1UdSN/bsRPwRZ4r2gZd6VQGYxEPTbnTFDCeqTqSgkSnmDsG0gV8PHx8hK9pWO1Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GnSchWyQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8DFEC4AF0E;
	Mon,  5 Aug 2024 17:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722879492;
	bh=nxR4LjhPkMaERMjLhviiy3Je47CLqyKxQkx8/VHzLyU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=GnSchWyQmei4C5DSxKlakBV8+riOWo1hl8oNSySR4TDv708LwiVkqpXP+gJn6mvdy
	 DG73mdxGuHB7n6+ht2PdPH9DLritHTMcfQPLT4uGQkCjbdLHVOCoyHLfNufnwN3rTo
	 bO+SSLQmGILxHzORvZlPtfKUnOq1dB9yqKZSNACImgDfomrhBi5Q+emE6WYm4UAWGE
	 yDC4kUYQQ8fkmU1c0hnMCx9EVQ0ER2+j0wC4jApHgtHb/acnZrIAm0zssifRwLLDWn
	 kctPDj5l9Hryj5WVcN3mTTeESKvqjN0lk37KbQ2zMewa+hfjwc5ioNyQPIXEeGfgDG
	 tWytBLoyHJ6hA==
From: Vinod Koul <vkoul@kernel.org>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 andrew@lunn.ch, Shresth Prasad <shresthprasad7@gmail.com>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
 javier.carrasco.cruz@gmail.com
In-Reply-To: <20240723095518.9364-2-shresthprasad7@gmail.com>
References: <20240723095518.9364-2-shresthprasad7@gmail.com>
Subject: Re: [PATCH v3] dt-bindings: dma: mv-xor-v2: Convert to dtschema
Message-Id: <172287948932.489137.16494399270709607927.b4-ty@kernel.org>
Date: Mon, 05 Aug 2024 23:08:09 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 23 Jul 2024 15:25:19 +0530, Shresth Prasad wrote:
> Convert txt bindings of Marvell XOR v2 engines to dtschema to allow
> for validation.
> 
> Also add missing property `dma-coherent` as `drivers/dma/mv_xor_v2.c`
> calls various dma-coherent memory functions.
> 
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: dma: mv-xor-v2: Convert to dtschema
      commit: 31c70e0b7b54016ecf2033f8166a385d2abaad15

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


