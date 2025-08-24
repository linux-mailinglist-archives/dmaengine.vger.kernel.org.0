Return-Path: <dmaengine+bounces-6180-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5DFB32D2E
	for <lists+dmaengine@lfdr.de>; Sun, 24 Aug 2025 05:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C75FA1B60BDB
	for <lists+dmaengine@lfdr.de>; Sun, 24 Aug 2025 02:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDCC238D57;
	Sun, 24 Aug 2025 02:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUvW4LPh"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5051EA7CB;
	Sun, 24 Aug 2025 02:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756004173; cv=none; b=o/fv5q+BQejnWYtX7f4JmynSrtg19TZYdnkl7eQ/OI/1zX6X+zwvPAi7N6y3xSPbzuPrCaMqZ1MDuaXAN/EpXzHyuSX3cpD1RP2aXbZXzyHjAfObcp5fG0mEXkmaA7W2Q35tBurkB8jubfIrUvInM6PSmT1VoMgTTuwkkzincMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756004173; c=relaxed/simple;
	bh=SExc3QNx7ShEzeMxNxgu+3EWA1347cfpeNzUUZvT8RE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C/Ea4i72Oliwlm7YZk4Y5731sP2aXEZE7/8yV8uS6Nlk44tRlwUXaT7k6hKIzxdWrDfZ9dFciOf++EfzGT6tklI8Vaf7NxUwGbr82w8Q9shDBnAcy2ZDDYdp3G/bNCgIPl38NsieIbDVdGHzCLLAYggx1v84Kr5dfM0dZ6OkSGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUvW4LPh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43DC3C4CEE7;
	Sun, 24 Aug 2025 02:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756004173;
	bh=SExc3QNx7ShEzeMxNxgu+3EWA1347cfpeNzUUZvT8RE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZUvW4LPhYHLL+pvtFL6+LSzFyj0XlE94RZ0+oJC5i16y63fFkvNtI1+eT4BFAfly9
	 GToJwVMcJGLkDo0P4dzwjH6Q7aeaFJCvy2vB3rFTU1vQuOHBe+eTg+kYIRnSkGTdxs
	 KM5x3YnCePpRlDbgiFoh3nycl87BSC6L9ocSyJ5HKDJBwsw6xspMYRxROGGvl4kni8
	 1AxLMXltw5y8dWLYgNLA9fdu3tBDBv3CvMA5+Rprc54dkQm5oPgR2WFeBI9ZIL2EU5
	 OkzTuUFbop6qfc10Rtiu+U4e69MylaHNamvZ1KAbehpZuB8AoLAwQCGNshQ3Cv3WeN
	 z/PGr0CwJ1+qw==
From: Bjorn Andersson <andersson@kernel.org>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@foundries.io>,
	Pengyu Luo <mitltlatltl@gmail.com>
Cc: linux-arm-msm@vger.kernel.org,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v2 0/3] arm64: dts: qcom: Enable GPI DMA for sc8280xp
Date: Sat, 23 Aug 2025 21:55:46 -0500
Message-ID: <175600415270.952266.1079016155668636872.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250612075724.707457-1-mitltlatltl@gmail.com>
References: <20250612075724.707457-1-mitltlatltl@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 12 Jun 2025 15:57:21 +0800, Pengyu Luo wrote:
> This series adds GPI DMA support for sc8280xp platform and related devices.
> 
> base-commit: 0bb71d301869446810a0b13d3da290bd455d7c78
> 
> 

Applied, thanks!

[2/3] arm64: dts: qcom: sc8280xp: Describe GPI DMA controller nodes
      commit: 71b12166a2be511482226b21105f1952cd8b7fa5
[3/3] arm64: dts: qcom: sc8280xp: Enable GPI DMA
      commit: 013d01811a1ea4ce0f676e4110f94c80271586b9

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

