Return-Path: <dmaengine+bounces-2316-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C644900B8C
	for <lists+dmaengine@lfdr.de>; Fri,  7 Jun 2024 19:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 172E01C213F6
	for <lists+dmaengine@lfdr.de>; Fri,  7 Jun 2024 17:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948DA19B588;
	Fri,  7 Jun 2024 17:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWOxQ85u"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6979B19B3D4;
	Fri,  7 Jun 2024 17:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717782456; cv=none; b=At30Egosbz7X0nU+c5g8KPn4dwVA3/9jpvO2k9W5LJrjmFQ17vDljYBarw9bdlLcyazHy0oXdzX25zMgiT1I+ni7xkn8vRY4Hs9Vbh8FONS5GwmluCYSARHJ/nTrCQ5ekidDzlnOzB4yAct0cew/1H6TBdq5rKI/1tBT40RBMhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717782456; c=relaxed/simple;
	bh=seOlG0sZnNix/+17yEINqu32U0cA2oaSzUoLkGxawwg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=B1+F/MtYuaK5v5Oay4FzPOqL+uXQmfDQNWqJfvYvVa5k40t9IBL9GZUbrbeJMR9A44NOnr+F1YFVMEvfcOxoj9Ap9BZHk03wcnBfb/Pi1TKYhfZBsQYZdNNgTahqxC4jOJjF1+VpIFW4ICWaGAZIKHRG9jAWYH+wHik/nnEbjP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWOxQ85u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE15C3277B;
	Fri,  7 Jun 2024 17:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717782456;
	bh=seOlG0sZnNix/+17yEINqu32U0cA2oaSzUoLkGxawwg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=cWOxQ85uP7l0c/zhs41YJyBmANaZG4KHk0zmJkShgkvKi0ucUeUVf2+34lppUj1PF
	 SPgEEjthwn+gvwv59Q+YloZL2AcpX48lFiRky6vNzEDiLJSRGNB66GX7excuTaI1Gl
	 UHn1Ffho5VXJMvNEn2dt+P8dc/RWxLSX7LOVHyncQtv3c4j+J41e9hrmrVsn0VHtRr
	 57uC1rPEWbHGRGUrwZzbagB5exh35DzNp4LGJ0QfDDwOlxPS7Udf3fEEy1dJWIibkA
	 5iwMAzLCdYbFKsIWSCYueO4jGrhFE//zwqYKHt3LIAemB3O+xvz8M3qC+g30iN2sI7
	 0tauFq1bDyd+Q==
From: Vinod Koul <vkoul@kernel.org>
To: Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>, 
 Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, markus.elfring@web.de, stable@vger.kernel.org
In-Reply-To: <20240607-xdma-fixes-v2-1-0282319ce345@bootlin.com>
References: <20240607-xdma-fixes-v2-1-0282319ce345@bootlin.com>
Subject: Re: [PATCH v2] dmaengine: xilinx: xdma: Fix data synchronisation
 in xdma_channel_isr()
Message-Id: <171778245302.276345.15700458425601683655.b4-ty@kernel.org>
Date: Fri, 07 Jun 2024 23:17:33 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Fri, 07 Jun 2024 10:34:38 +0200, Louis Chauvet wrote:
> Requests the vchan lock before using xdma->stop_request.
> 
> 

Applied, thanks!

[1/1] dmaengine: xilinx: xdma: Fix data synchronisation in xdma_channel_isr()
      commit: 462237d2d93fc9e9221d1cf9f773954d27da83c0

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


