Return-Path: <dmaengine+bounces-964-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F4184BE31
	for <lists+dmaengine@lfdr.de>; Tue,  6 Feb 2024 20:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACAED1C23076
	for <lists+dmaengine@lfdr.de>; Tue,  6 Feb 2024 19:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DBA17555;
	Tue,  6 Feb 2024 19:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nt77VMdX"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CF217BAE;
	Tue,  6 Feb 2024 19:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707248375; cv=none; b=n/rV4t972MbVsTb6F6gYvcpS3rtt1nEcDzGgNyvDHgZKedJL9zJxnh1+grj50WzAnDKmgFYxK/u86Uq/Uz9lQ7VipTnzt971Mcjcah0lABdd32MR3ZnIES+ddXQWua8Z0zVC9QDO1EWJR2vg99n05/Et30vHAWdAlRY+HcYivRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707248375; c=relaxed/simple;
	bh=BqxQ7FEXnzOrBOd7zj6mYuOjgycKqkJG9Ox/LfYw7ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i4ZEEXHt2TYH5v1CPZcfRRE7j75Y75gX6LAl4hRIr9pJnrDq8PPXA/rwSsS/xTmfTryod+XbllTtcz2kQeb1oJrEJq3EDtuuxrNZf6HUJnHaRh8bkfXZwGwg7aOmZYnx/qgiznNtgCEvJ4SIc7JWAz5Rb1eStWxCxdUm1y8ADOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nt77VMdX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC340C433F1;
	Tue,  6 Feb 2024 19:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707248374;
	bh=BqxQ7FEXnzOrBOd7zj6mYuOjgycKqkJG9Ox/LfYw7ms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nt77VMdXUt5FjMlr8RCREY65FvC8+hBjPE8hs4xXz1s7YvoV7OToDZl1R19bOZDIZ
	 ZQad5Rw+Gk34NATfN8E5itpqs6s6KSoo+J9Xx+tjbhAMJ57w0XbMBdz+N09oXPbjPl
	 AdOMZUZ3EwFkcaVS85n60VP8YHCiF6SqO+aOL+oLQdgjUtpB5GKahUNc4Srdo2TuKR
	 DZBemHXcgkVo/pjtzisQkzavKbr6Lx3fNPoWjMk7AJ/d2ZfAULTIncMSJ6mjS6SAGM
	 b8k9t1/y4YWGYPthsbJKg0j4K936lUUc/xrS27z7b17HDCHRcrzl+q/nCOmEQMr3Jy
	 q6JTU7zynApsQ==
From: Conor Dooley <conor@kernel.org>
To: green.wan@sifive.com,
	vkoul@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	conor+dt@kernel.org,
	shravan chippa <shravan.chippa@microchip.com>
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	nagasuresh.relli@microchip.com,
	praveen.kumar@microchip.com
Subject: Re: (subset) [PATCH v5 0/4] dma: sf-pdma: various sf-pdma updates for the mpfs platform
Date: Tue,  6 Feb 2024 19:39:25 +0000
Message-ID: <20240206-luckily-udder-ffd828ccdc57@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231208103856.3732998-1-shravan.chippa@microchip.com>
References: <20231208103856.3732998-1-shravan.chippa@microchip.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=443; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=xmtgk10aREoc8W34f44KzSWunePLW5lmhs8pdAnijqk=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKmHut7wx7dWlExfcNHWa3tnQMT2pqO2387rZOe0dZstl 98k7fmjo5SFQYyDQVZMkSXxdl+L1Po/Ljuce97CzGFlAhnCwMUpABN538vIsJF7rtPM7173ukOX vrPqXhavN/VYiDjfpgseC85sqa9+nsnwk3HRzTmVmgsWbM5TeJudttX7Q8HFm/veCVy/58+8SWZ FEzMA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Fri, 08 Dec 2023 16:08:52 +0530, shravan chippa wrote:
> From: Shravan Chippa <shravan.chippa@microchip.com>
> 
> Changes from V4 -> V5:
> 
> Modified commit msg
> Replaced the sf_pdma_of_xlate() function with
> of_dma_xlate_by_chan_id()
> 
> [...]

Applied to riscv-dt-for-next, thanks!

[4/4] riscv: dts: microchip: add specific compatible for mpfs pdma
      https://git.kernel.org/conor/c/5669bb5a16a0

Thanks,
Conor.

