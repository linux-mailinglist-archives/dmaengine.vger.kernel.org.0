Return-Path: <dmaengine+bounces-3860-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BD39E0B5F
	for <lists+dmaengine@lfdr.de>; Mon,  2 Dec 2024 19:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC8C6B8555E
	for <lists+dmaengine@lfdr.de>; Mon,  2 Dec 2024 17:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C451DB34E;
	Mon,  2 Dec 2024 17:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CwX9Hvm3"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E8718784A;
	Mon,  2 Dec 2024 17:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733160675; cv=none; b=V3vK2YhRsLP1iv2FPOzp8p7r6iK3jC6p8mU9UaQ+9YNzZNj8XHHVeYyAiPfqb5XCorlFMf5w3elzWqxoSzrQX83SGkXHiMqCPq1nyKUlgpgwFKb/Pn/6855eNmES2wVTR/3xV/ovAKPRShuUKl52rwkU83it++fGj6W2wHQlN3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733160675; c=relaxed/simple;
	bh=CAbiLMi4YxUdG9Ik2Xv87eZs8pKV4/K+/quwKpT/55k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dRwxbwYrG1EbofsOqBjwkzg2fcBJp6Smjz6qwxNS6uNFBmF+nJqHZopqIxItZLqtEMCs/7/CJgHk30UC9DafKvtawgLaODN3VMjr6A9xDhQfCEdQWx5R53LgwduASTb/XhDqonolp3+ngc+tbr73GeX8EwVOMejCpcECxY7ij10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CwX9Hvm3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C25C4CED2;
	Mon,  2 Dec 2024 17:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733160675;
	bh=CAbiLMi4YxUdG9Ik2Xv87eZs8pKV4/K+/quwKpT/55k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=CwX9Hvm3S2n3U+1E+nCQNyp4qHnxQTYCuAN0goDhNzGwLtKvwEbKSIrYqJS7jVbBD
	 RYGf9SrS8eFHvcZdYQ77AK7lkSYmokjBQ7lsXV0KeMkJvBW7LtepsIz4rQOxU7ckAl
	 MnX0CHDmoVF3eu1/JP/d8iHx1qD1PNYDO8Sh9azqglnE9FiXPQnPTmFIAgdGfLRe3b
	 MbQ85hof+67z5iForJg25Cz6HzWJrx8mqUdx/efVGy38arqW2TQ1U9nLGkdMc/77UC
	 m+A3zXi49tis7m8Y3YHGUZ8TWm2Ae9J8f5TwFocxqB0L+IfutgU/2z1msVr9P61plT
	 5EwhaNMr6SAhw==
From: Vinod Koul <vkoul@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Viken Dadhaniya <quic_vdadhani@quicinc.com>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241108-topic-sa8775_dma2-v1-0-1d3b0d08d153@oss.qualcomm.com>
References: <20241108-topic-sa8775_dma2-v1-0-1d3b0d08d153@oss.qualcomm.com>
Subject: Re: (subset) [PATCH 0/2] Add SA8775P GPI DMA compatible
Message-Id: <173316067073.538095.13350944715952515644.b4-ty@kernel.org>
Date: Mon, 02 Dec 2024 23:01:10 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 08 Nov 2024 22:41:16 +0100, Konrad Dybcio wrote:
> Fill in the missing parts of the initial submission
> 
> 

Applied, thanks!

[1/2] dt-bindings: dma: qcom,gpi: Add SA8775P compatible
      commit: bf9b0834552e615b1dbd3015c2f0ed2a3bdf62a4

Best regards,
-- 
~Vinod



