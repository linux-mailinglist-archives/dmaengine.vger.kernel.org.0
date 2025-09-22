Return-Path: <dmaengine+bounces-6685-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F1DB93389
	for <lists+dmaengine@lfdr.de>; Mon, 22 Sep 2025 22:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6737445F3A
	for <lists+dmaengine@lfdr.de>; Mon, 22 Sep 2025 20:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FC030DEA6;
	Mon, 22 Sep 2025 20:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fhy16nPq"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77D3302748;
	Mon, 22 Sep 2025 20:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758572790; cv=none; b=pTgDYhov1mDlB2ghUuvYy6T12HlQxVkW+ZmbI/2ehfsNJ/M1SWPOxhHfe3dszkHqwde6D7E4grGR0wyVy7MO4ojTEro+zsG5Jy3ubSZENbIrGk/EGjU4/QHrOT+cOOjwznDZPD+kE9Mm10KYUhdSYBmM81H+IQ8jmJHDE8nL5WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758572790; c=relaxed/simple;
	bh=8/Sodj1mjXkjB4zFqzkZm1U4zLysyWPNUhHTxhwMLzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DF2/TjM2iq7wKdzDIOMN0IMutGOiNLtAhqLOWfXJBLK5KsYw0oQ+4qZQxexO/yn1nnbhnd0WIGMH/XqB0wPJ9bUqfRx2v+trq1wcw2HIifSKuzPRgLFOTEnvhXAIi20GM7t2vNfEf4WIYkoWxpybSupsSNXU+8OKXOYAO4kBtUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fhy16nPq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D38EC4CEF0;
	Mon, 22 Sep 2025 20:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758572788;
	bh=8/Sodj1mjXkjB4zFqzkZm1U4zLysyWPNUhHTxhwMLzI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fhy16nPquN6DthdhSi3nskGzHCgePSJ005XwjNU/5c9UW7WEJxuvogdQjWq67kSDY
	 iurWMdHX2W0VPJfZE6e3MuU0iuK1Fki+TRt50StIh4VSR2FMZJzVXZMzl+ahXopGXF
	 FAbrRGpt3cNhO7W6pLgvs4AJyXz0HHPq6yDhjTJowOOUFsODpLRYRXadnrKtFHZJQK
	 zvnzcUzNlJUVITNEKhdq5eNZG/sRtPdxZYJrnl9jtP96fTGqV/NtcepKYJARUGzlxj
	 Qdu715H/8m8X+6cXGKykCweVGQvGOqu1D6RoSRJTpWM+z09tWEDPYho+Sx7Zn6imFb
	 F6AbAtjC4Chhw==
Date: Mon, 22 Sep 2025 15:26:27 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: vkoul@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dma: qcom,gpi: Document the glymur GPI DMA
 engine
Message-ID: <175857278671.1274472.1445857118961212430.robh@kernel.org>
References: <20250920133305.412974-1-pankaj.patil@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250920133305.412974-1-pankaj.patil@oss.qualcomm.com>


On Sat, 20 Sep 2025 19:03:05 +0530, Pankaj Patil wrote:
> From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
> 
> Document the GPI DMA engine on the Glymur.
> 
> Signed-off-by: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


