Return-Path: <dmaengine+bounces-4071-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3BA9FBCAD
	for <lists+dmaengine@lfdr.de>; Tue, 24 Dec 2024 11:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60DFF1680E2
	for <lists+dmaengine@lfdr.de>; Tue, 24 Dec 2024 10:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965C61D86FB;
	Tue, 24 Dec 2024 10:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgLaYMf8"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BC81D86CB;
	Tue, 24 Dec 2024 10:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735036949; cv=none; b=Q64NTAyMXT8fyPM6/r3yz4Fmv523jlzEeHZP6yUMn/mZA7I4FkhLtJNN5xt00sM0mqfdaQh95/UDM/yae37884ib2QJE8BhJ736BoECIQR4HGETK9YsALUxDbrkW7wCFkxc8Qy59IjOVk6lT7jSyPlsTpswn7uEZOIU0PzqbqOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735036949; c=relaxed/simple;
	bh=5Cxrf1mpeQlP/xWn7RoT5esd+s9F+bviYF/k+MUUJzo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eDCC5GSxm8nAQLVrBrvLCoLGACWE7k7L81rMkhK3GsPlbxw7drnNThBqtwfdE23QlMDmG8xxOztVz+R0SX60KnFBjomu0vtRPh+3Rz1+lsA6bty/V3OnyCIo8+nTttvUTwWm5ck7vIONpYRDxBna0ArMY/vVw8dtge2BAOs43HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgLaYMf8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD7BAC4CEDE;
	Tue, 24 Dec 2024 10:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735036949;
	bh=5Cxrf1mpeQlP/xWn7RoT5esd+s9F+bviYF/k+MUUJzo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kgLaYMf8AHYU+htlhj548Ui1vPAqKVTqHUmL/iWSdJsPElGkHLofpbGEMAqqTqIij
	 TknIT0wk/gTNBeI5ci7LA7GE1npXcf8ewzwmIi/YoEE42oC+pxQKegdkl4hZY1Zmw7
	 /47S0GmI6XDSBuRkH4Y8EigI9HadUvFi6aO27vBGZsXsQMemepZ26mNXYnrnXhQTxw
	 BjjDcp8jWR2Sd2mIKSRGbYy7TwiPwshMPoyvIdCqZu04/Vz/JME4JZIVW37Z/ZzaHM
	 fkWuIzimh9AncZiw5uLZDH8UG6lJD0cb9A3A27v2qj53j7BjRg7H7a+YfUpLi2PZ+A
	 L5rb98Mp3cjDg==
From: Vinod Koul <vkoul@kernel.org>
To: Ken Sloat <ksloat@cornersoftsolutions.com>
Cc: =?utf-8?q?Am=C3=A9lie_Delaunay?= <amelie.delaunay@foss.st.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, dmaengine@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241206115018.1155149-1-ksloat@cornersoftsolutions.com>
References: <20241206115018.1155149-1-ksloat@cornersoftsolutions.com>
Subject: Re: [PATCH v2] dt-bindings: dma: st-stm32-dmamux: Add description
 for dma-cell values
Message-Id: <173503694532.903491.10482380884670352908.b4-ty@kernel.org>
Date: Tue, 24 Dec 2024 16:12:25 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 06 Dec 2024 06:50:18 -0500, Ken Sloat wrote:
> The dma-cell values for the stm32-dmamux are used to craft the DMA spec
> for the actual controller. These values are currently undocumented
> leaving the user to reverse engineer the driver in order to determine
> their meaning. Add a basic description, while avoiding duplicating
> information by pointing the user to the associated DMA docs that
> describe the fields in depth.
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: dma: st-stm32-dmamux: Add description for dma-cell values
      commit: 54e09c8e2d3b0b7d603a64368fa49fe2a8031dd1

Best regards,
-- 
~Vinod



