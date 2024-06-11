Return-Path: <dmaengine+bounces-2348-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E37049043A1
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jun 2024 20:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C1291F24D1E
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jun 2024 18:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75F5155A43;
	Tue, 11 Jun 2024 18:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+hBWzQr"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B277F7E3;
	Tue, 11 Jun 2024 18:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718130505; cv=none; b=V5pfr9GIO3A/T5pGyIsGD+2pkgrI5+hFqdyNNw194KCd48GRCwZjHT9AT6D/RVV/9UjWrETbYA+9TUHYthq2Sz71Yr1UMkNf/MPkr6Ux2K+yaGzMpR2CArEKajOzSb01bGLWrVT2bzMS18IIhZqG5erkTT787O6i4TWs9YJP398=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718130505; c=relaxed/simple;
	bh=ASTVQ3g9Rf3VqgMx9wDJe2koGCVSLXH24rsi7ZnRAT8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dpqzgZHSE+LWQGHvm/wWiZNwMGlTwsu2z8lClfw+mFwR7leyk/yidZQus1Fc6UanZm6CmSaQ9RMgdwfUYNMKmFe4XYJcB7/5aqv4ff/vPiFlPnpztMVBYTaX+r0VZmQmDiwu9jrftlv3tuVwUurHRH2TZJyd9NIOa48B0dWuUIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+hBWzQr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B0F7C4AF54;
	Tue, 11 Jun 2024 18:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718130505;
	bh=ASTVQ3g9Rf3VqgMx9wDJe2koGCVSLXH24rsi7ZnRAT8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=S+hBWzQr1Sudx/3LF9FtyOg4syZNNYbEbchXihrKVy9i2edfgjA5vaMamJJp3/KoO
	 seuDlC9bLA+cmQFCQLnRQKL6Sk0/HKu38cYe9DwlFnyUB0Pj1XZ4eJ7Yy0BX0fMEn5
	 ThxSyOYtP2ataPsCR76IEonBA5aeaA3XqPE6DgfckpVNNPZbCb/rQkLjW1HHMREZHk
	 HzAeCCnF5VqeBlfGAsJyoIBIu9u6LDFduIWChE2qZ8+rt7KBHlZraOGrUlSrn2sQHK
	 7LeT6Aiq9ucQ5qEB99mc7N19jHu7UDGzsFx5XmvJLQVuWD7gLGZC0ofeol8rwuBxQC
	 RBdI9pDBNPI5g==
From: Vinod Koul <vkoul@kernel.org>
To: krzk@kernel.org, Frank Li <Frank.Li@nxp.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, 
 dmaengine@vger.kernel.org, imx@lists.linux.dev, krzk+dt@kernel.org, 
 linux-kernel@vger.kernel.org, robh@kernel.org
In-Reply-To: <20240528163734.2471268-1-Frank.Li@nxp.com>
References: <20240528163734.2471268-1-Frank.Li@nxp.com>
Subject: Re: [PATCH v2 1/1] dt-bindings: fsl-qdma: Convert to yaml format
Message-Id: <171813050173.475662.8322119332604104990.b4-ty@kernel.org>
Date: Tue, 11 Jun 2024 23:58:21 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 28 May 2024 12:37:34 -0400, Frank Li wrote:
> Convert binding doc from txt to yaml.
> 
> Re-order interrupt-names to align example.
> Add #dma-cell in example.
> Change 'reg' in example to 32bit address.
> 
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: fsl-qdma: Convert to yaml format
      commit: 671bc17fc4d14fed69ee86e1f7c2c972010c49ac

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


