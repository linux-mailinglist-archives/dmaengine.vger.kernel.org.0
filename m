Return-Path: <dmaengine+bounces-2585-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 622B191BC34
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jun 2024 12:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1309928493C
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jun 2024 10:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200C7548E1;
	Fri, 28 Jun 2024 10:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJdMTghK"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C4E1103;
	Fri, 28 Jun 2024 10:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719569407; cv=none; b=Zd7cxHVyZnShhqEt8iOoyvnA3BoxO82coe7z286KLBl3wrLPUEKRFk8JmHMpf8NI7NZGlMtWYddcRLdRlKZ9uQCcJNmvtCqRol++YmDH+MYPRvOvG7cjkisH2Jv6wKxXThV+FksOL99F4kHcxsVVezXgi04CQXBXB3/oPT5lQvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719569407; c=relaxed/simple;
	bh=WsJpLzRwEfVVxdAfPlSCqbelXlIs+8r0y72XYMqBMMc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=a1dCZFS3wOP24DVfNeGV2f9udH9v2YQMC1Er3JElyTDYFkKL9cK9DcBLyuge2d6EOxFCo6DmmIlysCfa5pnGX4/fmEcRT2vdt0rEWYtJ1q/rnZQqE7wDTJUHzIwoUBCDf0XEmNyoZ/hBb+5dhFJlwBZhi6rb59nuVY2G+wnJ57Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJdMTghK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66918C116B1;
	Fri, 28 Jun 2024 10:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719569406;
	bh=WsJpLzRwEfVVxdAfPlSCqbelXlIs+8r0y72XYMqBMMc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=OJdMTghK4Iwi8/JRW1eNEtpMNfl8119UNTSEvXKA4emVlUO7Dp0OHJiNS+MstW4Sh
	 27gyIkV+ziNMirBF9D4P7zx1DTM8gZbPB0XGmgvgFvpV7OoZFuoxn/Ubitcj8MixVV
	 G19yMCtoE02rNwrEDRsKlJul5AZMdnfanuBPkPPaWciK3F545gqvpu6HP51rfLkVtP
	 qTx/oQqLQTNVJ6OPFYg4Jpq5ne/RflOVm+MKdS5pWMYdqD9rXL4VNk0IR9iDUKHgcr
	 3RJzNmRzWADw5u0Bxo0nb1xVgsw0ZD5TlfMNPI+F4Ot1dRKoNBt7SkDRtBIwEZs4XU
	 OqQTZH5BDijkA==
From: Vinod Koul <vkoul@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, 
 Pavel Machek <pavel@denx.de>, Hien Huynh <hien.huynh.px@renesas.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 dmaengine@vger.kernel.org, Biju Das <biju.das.au@gmail.com>, 
 linux-renesas-soc@vger.kernel.org
In-Reply-To: <20240625170119.173595-1-biju.das.jz@bp.renesas.com>
References: <20240625170119.173595-1-biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH] dmaengine: sh: rz-dmac: Fix lockdep assert warning
Message-Id: <171956940295.519169.14488710673571484304.b4-ty@kernel.org>
Date: Fri, 28 Jun 2024 15:40:02 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 25 Jun 2024 18:01:16 +0100, Biju Das wrote:
> Fix the below lockdep assert warning by holding vc.lock for
> vchan_get_all_descriptors().
> 
> WARNING: virt-dma.h:188 rz_dmac_terminate_all
> pc : rz_dmac_terminate_all
> 
> 
> [...]

Applied, thanks!

[1/1] dmaengine: sh: rz-dmac: Fix lockdep assert warning
      commit: 0e53aa3464e9a0a82bd3b926ba5999a11569c9ba

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


