Return-Path: <dmaengine+bounces-2808-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB26894807C
	for <lists+dmaengine@lfdr.de>; Mon,  5 Aug 2024 19:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 625361F236B2
	for <lists+dmaengine@lfdr.de>; Mon,  5 Aug 2024 17:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A44161309;
	Mon,  5 Aug 2024 17:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2gR03XP"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CA616B3B6;
	Mon,  5 Aug 2024 17:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722879498; cv=none; b=pd3nf8ChqOXdAdoYmnyHMlcDFb9MIzuma0qP4yO3Hi3chqaJS17ZVNZDKKI/p50l4Ihz031iWORceFzEl1iHqIrWyFegfVnfY5Yzl2LhPPxEUa292qUtnlJ4ZnPABZEyRgmxht1NPKsv712zP3kYmQ8jwJNX7gVwwOWuUw3J8HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722879498; c=relaxed/simple;
	bh=x/YeYAVnYRfAyP8/DG0zyXmePLno/A7JSqDkhV1UZu0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JAS6Glg7lYW0ZozOqky+Qyrl+deO/XUbsx2AN1d83ZGweNJnr+SgdJqOTQt/N5lUX+YrHvuvSnL4YlpbgiFYGmO2ELOhyskwN+wzHhRU9+uYETlC1SsIWv+rKqcuhDfyBS95czYXXCjhR1ljj4bBCu7QVddcWB4rMX5ez7kkPMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2gR03XP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF37C4AF0E;
	Mon,  5 Aug 2024 17:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722879498;
	bh=x/YeYAVnYRfAyP8/DG0zyXmePLno/A7JSqDkhV1UZu0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=W2gR03XPhaqpq4oJufG6lqEdZVHut+vw+gAXidVMEZmQOGc19OqmO7Ysg549dQXT2
	 8WGyX2SOXyuIvqTzFUXqRYncxMYhEW/7lTJQTjMSPT7yq8YVdfR08N/7NTU0zPJIN0
	 dgZzER0ecmWghCYQ0m+yYocDh7tcfoWm+dpLfgxWuXJtPIlH3Es0RmDPhUR4SMaasL
	 oQjsRyYjsboIxDoM6haxwD3enZ7M+yBGzj08Ura5wMHQkNN7fpwezHBNJZDt8ZznYR
	 +2GE+mrODf+Ngayqr/B0a9vt7UyS6brQmprypw42unJh0pXlQM/WWCdnVh1uVpPLgp
	 yT+qdfysJLFGw==
From: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, 
 dmaengine@vger.kernel.org, imx@lists.linux.dev, krzk+dt@kernel.org, 
 linux-kernel@vger.kernel.org, robh@kernel.org
In-Reply-To: <20240710145400.2257718-1-Frank.Li@nxp.com>
References: <20240710145400.2257718-1-Frank.Li@nxp.com>
Subject: Re: [PATCH v4 1/1] dt-bindings: fsl-qdma: allow compatible string
 fallback to fsl,ls1021a-qdma
Message-Id: <172287949608.489137.4550970931428629973.b4-ty@kernel.org>
Date: Mon, 05 Aug 2024 23:08:16 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 10 Jul 2024 10:54:00 -0400, Frank Li wrote:
> The IP of QDMA ls1028/ls1043/ls1046/ is same as ls1021. So allow compatible
> string fallback to fsl,ls1021a-qdma.
> 
> The difference is that ls1021a-qdma have 3 irqs, and other have 5 irqs.
> 
> Fix below CHECK_DTB warning.
> arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dtb: dma-controller@8380000: compatible: ['fsl,ls1046a-qdma', 'fsl,ls1021a-qdma'] is too long
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: fsl-qdma: allow compatible string fallback to fsl,ls1021a-qdma
      commit: 0204485c5a1e2de00acfd83c3931bd9dc6493c64

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


