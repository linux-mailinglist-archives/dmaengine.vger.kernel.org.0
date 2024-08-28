Return-Path: <dmaengine+bounces-2989-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBBA962F9A
	for <lists+dmaengine@lfdr.de>; Wed, 28 Aug 2024 20:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A957B20EDE
	for <lists+dmaengine@lfdr.de>; Wed, 28 Aug 2024 18:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757661547DD;
	Wed, 28 Aug 2024 18:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="baUZeKh0"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2B714AD24;
	Wed, 28 Aug 2024 18:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724869012; cv=none; b=coocVRlUIY418CW6rjhjsAvfBNPh57PUM4izvVG37L9+89Iz7zmBYBfqW0HycYq3fGBwrHDolHABmavB2pdPJQ3Q+WungZINp2Dl3m3UitzrbvBIhGiMOyj9ECncWXpP1E51PydcoHtZJzriZ+WWiMAGRTt5OvoqRDROg0O6o+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724869012; c=relaxed/simple;
	bh=Ei26e5yU+S/V7nXPDZSm18EDo4MePpuDMOpeUvRaWWk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RCZuIJT/8NDdQf6qjcsaYEd8tufG4cNd5R6mzrp7voReKB+0K84WRkvbt8XyJY5aKfAZqcF4CxuFCp4EkOZygOPOHbMsIL7yYl4izJHsy7aY2+19AYiW1OnZicE0H0AX5CWc6W7/LWrqLlw45TvZ6cn1Tt7O5QgP4iu0tTS1PYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=baUZeKh0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF7D0C4CEC0;
	Wed, 28 Aug 2024 18:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724869011;
	bh=Ei26e5yU+S/V7nXPDZSm18EDo4MePpuDMOpeUvRaWWk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=baUZeKh0CjQCh3MO61e5/D6g5uQzviJ7KGflQDz8uYzAL1OUqedJyfgyopon7BFwN
	 fJB0/JeutRk4/q2KDrffS3/i3bhClWQiNeQl6OdOcme7lttrOj8/2F5aGDIXXNLut7
	 YzW4HE9sQyJdJfb1Mx43zlozRQ4a87GCrZHThQvWYLtxflffjv1B0+9DsmeO8QDLvN
	 zslwAdA9NJ4Vp7yBMfFy01XZf3uEormWTz+MAG0BAhfW6eAZyCpuoxJwSQVbykOiTm
	 fjFkWm/G/MKMNO6ZbFGhTq4W5AUuu6/E4v+/GVUAYZIHUNvUT/xnQyC34U4jyQiA5y
	 w1ZpIP6+aPkNg==
From: Vinod Koul <vkoul@kernel.org>
To: miquel.raynal@bootlin.com, Frank Li <Frank.Li@nxp.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, 
 dmaengine@vger.kernel.org, festevam@gmail.com, han.xu@nxp.com, 
 imx@lists.linux.dev, kernel@pengutronix.de, krzk+dt@kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mtd@lists.infradead.org, marex@denx.de, richard@nod.at, 
 robh@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org, 
 vigneshr@ti.com
In-Reply-To: <20240801214601.2620843-1-Frank.Li@nxp.com>
References: <20240801214601.2620843-1-Frank.Li@nxp.com>
Subject: Re: [PATCH v3 1/1] dt-bindings: dma: fsl-mxs-dma: Add compatible
 string "fsl,imx8qxp-dma-apbh"
Message-Id: <172486900640.320468.11399033651070208268.b4-ty@kernel.org>
Date: Wed, 28 Aug 2024 23:46:46 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 01 Aug 2024 17:46:01 -0400, Frank Li wrote:
> Add compatible string "fsl,imx8qxp-dma-apbh". It requires power-domains
> compared with "fsl,imx28-dma-apbh".
> 
> Allow 'power-domains' property because i.MX8DXL i.MX8QM and i.MX8QXP need
> it.
> 
> Keep the same restriction about 'power-domains' for other compatible
> strings.
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: dma: fsl-mxs-dma: Add compatible string "fsl,imx8qxp-dma-apbh"
      commit: 63556df6acdd737b75d9a7a8b906cd1c1bc8e2aa

Best regards,
-- 
~Vinod



