Return-Path: <dmaengine+bounces-230-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8407F7540
	for <lists+dmaengine@lfdr.de>; Fri, 24 Nov 2023 14:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DB23B2124C
	for <lists+dmaengine@lfdr.de>; Fri, 24 Nov 2023 13:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A69E28E13;
	Fri, 24 Nov 2023 13:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GTzGzVWZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E5E16432;
	Fri, 24 Nov 2023 13:33:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6203C43397;
	Fri, 24 Nov 2023 13:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700832803;
	bh=uoPeOd9O4SgQkdeE6NWSU3YB1DPElD4w0UIMSK4oJHU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=GTzGzVWZV+39lerM0qSCYf+1y8RdZ8n7t8PU66/S7rCtUkPt1dA/Dj18tWlK6GmeV
	 opYFxwcixBvCQj7UQCpzeuCNacBDXgDwKXfC9cGVLp5V91JO4I52XkpWpM/Mg0TOJW
	 iRvAXbNg65mBuGbSptYLdWpg0pJpStgi8GN7/omibD1sMN7nK9yPAcilAaleHgLOW+
	 uBL9XiWuZiwiRQXisv8hPK8F2r8uz1V5XRKy4xBcpjNO2SRGIzEgvpWkeCiIrDxHOc
	 fhEtaHFzd3UMW4c1NXtglt3U4YaRGurdMhlH2mOdjLKZGGMt+bQ9/AgR2Fa4FqV93H
	 twZPW16ItI1iw==
From: Vinod Koul <vkoul@kernel.org>
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
 =?utf-8?q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20231029170704.82238-1-povik+lin@cutebit.org>
References: <20231029170704.82238-1-povik+lin@cutebit.org>
Subject: Re: [PATCH v2] dmaengine: apple-admac: Keep upper bits of
 REG_BUS_WIDTH
Message-Id: <170083280044.771517.11806054531627846759.b4-ty@kernel.org>
Date: Fri, 24 Nov 2023 19:03:20 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3


On Sun, 29 Oct 2023 18:07:04 +0100, Martin Povišer wrote:
> For RX channels, REG_BUS_WIDTH seems to default to a value of 0xf00, and
> macOS preserves the upper bits when setting the configuration in the
> lower ones. If we reset the upper bits to 0, this causes framing errors
> on suspend/resume (the data stream "tears" and channels get swapped
> around). Keeping the upper bits untouched, like the macOS driver does,
> fixes this issue.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: apple-admac: Keep upper bits of REG_BUS_WIDTH
      commit: 306f5df81fcc89b462fbeb9dbe26d9a8ad7c7582

Best regards,
-- 
~Vinod



