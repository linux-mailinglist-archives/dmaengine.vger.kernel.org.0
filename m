Return-Path: <dmaengine+bounces-4682-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF67DA5A59A
	for <lists+dmaengine@lfdr.de>; Mon, 10 Mar 2025 22:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BF3D7A7129
	for <lists+dmaengine@lfdr.de>; Mon, 10 Mar 2025 21:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A131DF73B;
	Mon, 10 Mar 2025 21:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="guBF3SdL"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20BF1D5CDB;
	Mon, 10 Mar 2025 21:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741640797; cv=none; b=OrbnSpvFHaDL2JoPkgP0ZKZBShUXnku6oSeJlpJ7X5KLZ4NWUEKoM0EkoaEVejhZzVlND5fJxPxMrhmI26d3nvACb6D8xV2+PP5OJFy1qp2fTW2sqJqUlEJfNbXoAKoOZ24IXL9Zwc5EjgUxvopL94StR7UfoT36AmIaaIVxfvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741640797; c=relaxed/simple;
	bh=bUcsyhE7tuvhIYvy3w+bcLNnK9zcOWwVrHqC/kyU+0I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Se9YWgQzf0Yt8Yx0k6u/x/g3FDGmbA5IDSaufGQTjnvv6QUihuSuJdwcM6BeXxOQUzXm/7OD1TdDOrDrmxFvcesGbd0y3qSWptfoODHU4NjKcSTdGnv7Uo1Ws3TOnPKoHkEUY3WxBXEyWhQGOWuV0wcw7nNcGcIpUcfUcpp4CLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=guBF3SdL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B576AC4CEE5;
	Mon, 10 Mar 2025 21:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741640797;
	bh=bUcsyhE7tuvhIYvy3w+bcLNnK9zcOWwVrHqC/kyU+0I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=guBF3SdL5g8fUUUD+VdEGB5/Gu+QziZWmvqGJEMFZAFxWr+fvivvifywfRMx82JmI
	 uy6D9xivPLth0EvxXPF4RqtT1FYHsvUiYS2G4IfTGMZsY15ov4tX6KhpQofrrz/iQw
	 jCD9ya0uZOye9gTTP1iJrmn4mwGiZeeSj7k4CF7vfghNZ9mtO7jsY7xZKrD1kBL19f
	 myGrl4gcDIuGsi007C7Nxc7l9YjqAifQNUMU/31tWFnAQLIngSWwzKqx8bpwJgBwj8
	 s6xaTUhSmFim9iQrIe7WbBWLzIM7xcNnqlNjwCgLF61m/9WziZI+QLuH0SiOFT+ZsR
	 q4hu2e0wQXfYg==
From: Vinod Koul <vkoul@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>, 
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
Cc: imx@lists.linux.dev
In-Reply-To: <20250307215100.3257649-1-Frank.Li@nxp.com>
References: <20250307215100.3257649-1-Frank.Li@nxp.com>
Subject: Re: [PATCH] dt-bindings: dma: fsl-mxs-dma: Add compatible string
 for i.MX8 chips
Message-Id: <174164079235.489187.5863262843040562459.b4-ty@kernel.org>
Date: Tue, 11 Mar 2025 02:36:32 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 07 Mar 2025 16:50:59 -0500, Frank Li wrote:
> Add compatible string for all i.MX8 chips, which is backward compatible
> with i.MX28. Set it to fall back to "fsl,imx28-dma-apbh".
> 
> 

Applied, thanks!

[1/1] dt-bindings: dma: fsl-mxs-dma: Add compatible string for i.MX8 chips
      commit: 964c032d1d5d1d896746b361416b84cef078dba5

Best regards,
-- 
~Vinod



