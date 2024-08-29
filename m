Return-Path: <dmaengine+bounces-3032-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 859E3964CD9
	for <lists+dmaengine@lfdr.de>; Thu, 29 Aug 2024 19:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4204D28579F
	for <lists+dmaengine@lfdr.de>; Thu, 29 Aug 2024 17:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2B61B8EAE;
	Thu, 29 Aug 2024 17:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pyFIdP50"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9591B8EA8;
	Thu, 29 Aug 2024 17:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724952650; cv=none; b=aSNDlpzS44uVvSTjbmVLjYK5fAZy3bxgnTe8s01R4fsoX6yn+8je+lJGtrwaAQ2ZlOkAoK4dXw1yknSNefCpJeCpCVQ4oU8DNqkFiy8khQ/mZja66P/yfvIczEejkbwwADvfQZedFMzxvMFG5kcWvkuLNxdN+MWCXsnHSv3lszk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724952650; c=relaxed/simple;
	bh=0mEvs03hAY2LDMxm7vaf8QmXwQ1HTusedKvM0ivRWvI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=a/l5N9yzPnZEW1tSSfBSoEtuheFKd+EKMVLORgWG1rfru3moCnTCYyFw0rFEk7uPB7p49fM2+F+p0MqxN3vkINHpfjHSG92Rq7yKWsgEDj3w1SXWkIrd/M95wXHj06VqoiVyLPrnIvr+/ScPkUS6gXwH3GgzE78f6u0o4cFECek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pyFIdP50; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6395C4CEC2;
	Thu, 29 Aug 2024 17:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724952650;
	bh=0mEvs03hAY2LDMxm7vaf8QmXwQ1HTusedKvM0ivRWvI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=pyFIdP50OIr7m01ieZarR3qBj/z9qiQlvCPPYI/tDKt5gtgx5RJQSBNuo8ZtXPyOu
	 jOBSKSw7AsJsc3Q3+cQ4iOIvNeUEGfphpdmIlac8kaUXoGYNydLIstXIcrYuDGN6yw
	 H4ZhHwnbnW8fhSozLbpVw/Gc0RZRaRMJpgQS73KYmVLAVBGXyn8hIBi/bFOfNZfICp
	 kW/2i1QIRVeFl9CVB5L8iA5dCGn++ozRQzHPSMArGKFdAUlTbZMcfONFsIRrJzZ5c2
	 Nwz0M3ThX1md/CF/VYOEW+sUVpO2RIKBkFj1PxU4oqal3/5CGsr+bIQ/EN90UmwJB1
	 ujVw7jZMXPM+w==
From: Vinod Koul <vkoul@kernel.org>
To: Viresh Kumar <vireshk@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Andy Shevchenko <andy@kernel.org>, Serge Semin <fancer.lancer@gmail.com>
Cc: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, dmaengine@vger.kernel.org, 
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240802075100.6475-1-fancer.lancer@gmail.com>
References: <20240802075100.6475-1-fancer.lancer@gmail.com>
Subject: Re: [PATCH RESEND v4 0/6] dmaengine: dw: Fix src/dst addr width
 misconfig
Message-Id: <172495264758.385951.2350573756781126919.b4-ty@kernel.org>
Date: Thu, 29 Aug 2024 23:00:47 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Fri, 02 Aug 2024 10:50:45 +0300, Serge Semin wrote:
> The main goal of this series is to fix the data disappearance in case of
> the DW UART handled by the DW AHB DMA engine. The problem happens on a
> portion of the data received when the pre-initialized DEV_TO_MEM
> DMA-transfer is paused and then disabled. The data just hangs up in the
> DMA-engine FIFO and isn't flushed out to the memory on the DMA-channel
> suspension (see the second commit log for details). On a way to find the
> denoted problem fix it was discovered that the driver doesn't verify the
> peripheral device address width specified by a client driver, which in its
> turn if unsupported or undefined value passed may cause DMA-transfer being
> misconfigured. It's fixed in the first patch of the series.
> 
> [...]

Applied, thanks!

[1/6] dmaengine: dw: Add peripheral bus width verification
      commit: e2c97d200ac3558e6c34258c96a01a0b9472292f
[2/6] dmaengine: dw: Add memory bus width verification
      commit: 5bb11aedb5309c232967ce490d7b826536f697c0
[3/6] dmaengine: dw: Simplify prepare CTL_LO methods
      commit: d34e8466c63389ef250c380cd615826afb2a049c
[4/6] dmaengine: dw: Define encode_maxburst() above prepare_ctllo() callbacks
      commit: 2f87a9671ed532fc088ef0b05e350637afdf001a
[5/6] dmaengine: dw: Simplify max-burst calculation procedure
      commit: 17d4353413a4d931e89b2c37106acae4a0972ad8
[6/6] dmaengine: dw: Unify ret-val local variables naming
      commit: 3f92ee7c4a4e2319d510eb2ddcfdd3105b235f0e

Best regards,
-- 
~Vinod



