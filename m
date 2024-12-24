Return-Path: <dmaengine+bounces-4069-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A699FBCAA
	for <lists+dmaengine@lfdr.de>; Tue, 24 Dec 2024 11:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 750E97A2D58
	for <lists+dmaengine@lfdr.de>; Tue, 24 Dec 2024 10:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CA41D5ADD;
	Tue, 24 Dec 2024 10:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8yk6Q6w"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70DC1B4F3E;
	Tue, 24 Dec 2024 10:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735036942; cv=none; b=EqFPqogHo7lHus3mmHrjQzF3us9OA7gdvzuUpcYt4R5UfsFashZ3TceaSZzBmOHtfGviuOpHYCfRgF0D9Ht3pIdDyCuzAIEJnai4tHDGOBl8hyrgTnu8dhdYVctCU2zrlF2L8cDg3J+Uly15wk5WH1XN4zCWtIXbfE0K7qzFm7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735036942; c=relaxed/simple;
	bh=KbRfy1szNw/DI9kDip/Q/poL9Tig1koGv+0V+N3EvyU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Bsoam6avbXCfEjZMp/QCQAKOl0IjPILSfrrL89moy5bGOF+Cc0/7YOsnmNqPwML2kEhobxSs2uOb7fqrn7FoEOLmYhJDbCkvyWKK8Kw5BuB5xG5pmabklTszw3ZYgeav0lKWntqFzsqT+zEb9Cqc2swVB/8TwQj2K24FG1WKnCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8yk6Q6w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A1CC4CED0;
	Tue, 24 Dec 2024 10:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735036942;
	bh=KbRfy1szNw/DI9kDip/Q/poL9Tig1koGv+0V+N3EvyU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=o8yk6Q6wUiW+Fa/zJQ+UwIqKxWq+zft/mDhYTwYZOH+6fa7Sf81/iPWn4uw7w4X9a
	 yDn39iocnSNNh27IdOOkZ61x1c1SM9eaSEKGGdRweht1p4XUpi1YsQXuT1VhR9a2rs
	 K2Asiy43evTD57N7E1Xqem7WtRHyN5qOOrqO1jtkPfwOrK6DbNsj5PzyY6mR5Lv0Nw
	 Ykr9YoWGv93s+1039zv2hEFwQCE5RFkt9PB8HzXSlnGEZC5PoBqcU3Mb2CipdMTUnM
	 S47dmmslcvoKnTVt8oJAqn72DIUzfnxOFDVzdgJVdTQamzviNPPGViWs8PKRGJjbYH
	 BFt5/TfM3oVmw==
From: Vinod Koul <vkoul@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241216-axi-dma-dt-yaml-v3-0-7b994710c43f@baylibre.com>
References: <20241216-axi-dma-dt-yaml-v3-0-7b994710c43f@baylibre.com>
Subject: Re: [PATCH RESEND v3 0/2] dt-bindings: dma: adi,axi-dmac: convert
 to yaml and update
Message-Id: <173503693988.903491.18338368118586554434.b4-ty@kernel.org>
Date: Tue, 24 Dec 2024 16:12:19 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 16 Dec 2024 14:51:00 -0600, David Lechner wrote:
> Convert the ADI AXI DMAC bindings to YAML and then update the bindings
> to reflect the current actual use of the bindings.
> 

Applied, thanks!

[1/2] dt-bindings: dma: adi,axi-dmac: convert to yaml schema
      commit: 788726fcea1fd79ca238403c56c012ca9c159798
[2/2] dt-bindings: dma: adi,axi-dmac: deprecate adi,channels node
      commit: 06d5363296dbcffb9e52ca4c9cec097105eb81e9

Best regards,
-- 
~Vinod



