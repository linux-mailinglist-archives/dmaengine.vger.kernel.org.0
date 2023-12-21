Return-Path: <dmaengine+bounces-620-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E3881BC11
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 17:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 691B11F27649
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 16:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6EB63507;
	Thu, 21 Dec 2023 16:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dM6cAzMZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CA563506;
	Thu, 21 Dec 2023 16:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F6EC433CB;
	Thu, 21 Dec 2023 16:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703176218;
	bh=Pns1mHOAhwxWI4RzMSfubSLru2gmHFGq4Rn6nPIb3V4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dM6cAzMZPMHlvS+j2jZsXiavWraZs8dFQacQPYtpZlZKPWVH9X7YxGOaJHgXIleUC
	 FyA9rqYB3yhPgZNFjOoGzy+IA8yLHG1hbLD/ga3EL6eCBn8analiFUu9Z1lVhO4Yg/
	 fNKinFvONaynRDqQvTb3lIzE2HqDPBYHjYYDJxGDGBH871SM0cMENqRaFHizN2qT6B
	 R2KKVbSD5/WEYvjHciFkGFJEO2M8ndhGsBVTtbH/HEx0PdBU5O4lBjEtREzrKR3Lee
	 V8GJzxHPIQ1QBu8zGx4xQJEGwrf5tyo4Ns/GMnhrsfI7qoAhwAKqyHKd6/9x9Vm3Sz
	 bbXrqhJqvGuCg==
From: Vinod Koul <vkoul@kernel.org>
To: peter.ujfalusi@gmail.com, dmaengine@vger.kernel.org, 
 Vaishnav Achath <vaishnav.a@ti.com>
Cc: linux-kernel@vger.kernel.org, bb@ti.com, vigneshr@ti.com, 
 j-choudhary@ti.com, j-luthra@ti.com, u-kumar1@ti.com
In-Reply-To: <20231213081318.26203-1-vaishnav.a@ti.com>
References: <20231213081318.26203-1-vaishnav.a@ti.com>
Subject: Re: [PATCH v2] dmaengine: ti: k3-udma: Add PSIL threads for AM62P
 and J722S
Message-Id: <170317621504.683420.17633628596902638762.b4-ty@kernel.org>
Date: Thu, 21 Dec 2023 22:00:15 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Wed, 13 Dec 2023 13:43:18 +0530, Vaishnav Achath wrote:
> Add PSIL thread information and enable UDMA support for AM62P
> and J722S SoC. J722S SoC family is a superset of AM62P, thus
> common PSIL thread ID map is reused for both devices.
> 
> For those interested, more details about the SoC can be found
> in the Technical Reference Manual here:
> 	AM62P - https://www.ti.com/lit/pdf/spruj83
> 	J722S -	https://www.ti.com/lit/zip/sprujb3
> 
> [...]

Applied, thanks!

[1/1] dmaengine: ti: k3-udma: Add PSIL threads for AM62P and J722S
      commit: 3b08b3775593442be52cbb99efbccbd7fe4fa3fe

Best regards,
-- 
~Vinod



