Return-Path: <dmaengine+bounces-754-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A808329B3
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jan 2024 13:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1C691F23484
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jan 2024 12:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842F851C35;
	Fri, 19 Jan 2024 12:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5GoU0LO"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A04A5103F;
	Fri, 19 Jan 2024 12:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705668633; cv=none; b=ir/tLphlz5JbpVsSnpXgov8Ijw5gWtGUin7BfGLM19hmZJe3O+Qd6OcBp5Q3kMmUsidPKy89qxLfgErSAu9KBlJwCv7IiuDlynFtH9Ny2MU3E0rek/1hiqm2OMR72l9OuwL1jmImhtfYv0I2uoI1knUPJX5IkG1Fg/pS9jQ2mRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705668633; c=relaxed/simple;
	bh=Fh5XnWDJw0FyVN6LcftAowCYyQkotzmF9wo5S7vmoRY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=q1hptg8AIHUvGroA1m89W7rwFc3VRjPiti7SQTlK+vZRBlIK3trFrxNAciXMBMrKnQilNj+trmthpdfydhmJDcwK4B+cPET+CqyV1pupr8/9bluN011kJlvpgzMhF8USBBrGcof90yHA9p7bchYQpwbXJR1zj6YPl9Y1bouPnf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5GoU0LO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31E13C433C7;
	Fri, 19 Jan 2024 12:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705668633;
	bh=Fh5XnWDJw0FyVN6LcftAowCYyQkotzmF9wo5S7vmoRY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=C5GoU0LOJzewcUBU2M6BKme5xRN6AXKUFONNOJRKk9o62PvCo1wlWkAsmtknzUpFi
	 SVzJdlDatgUMbFmjipzceTmgBriPDjzBaEq1E/d3YvZKJ9vUyL4CYLruaAZ3q+w4ij
	 FNShVMkYrvMwtwmoR7+vBO/bJ0AqpkpByeCMGp5QzTvo6FBrhBlyeAbDfgLnXIiDDs
	 aWIjyahnAh7tfzZx7Yt6babQDcLntUzL2c483rNzC4hVCHiUK2NCQ9ojJS4OBrgb12
	 705V9MRaea896DiwZNqYEIH1f7wS2Tg+wCZwPe2A6gEXKIavsv0uwx/IWEBkHJoR5N
	 aaY4ER8HKU5BQ==
From: Vinod Koul <vkoul@kernel.org>
To: lizhi.hou@amd.com, brian.xu@amd.com, raj.kumar.rampelli@amd.com, 
 jankul@alatek.krakow.pl, Nathan Chancellor <nathan@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 llvm@lists.linux.dev, patches@lists.linux.dev
In-Reply-To: <20231222-dma-xilinx-xdma-clang-fixes-v1-0-84a18ff184d2@kernel.org>
References: <20231222-dma-xilinx-xdma-clang-fixes-v1-0-84a18ff184d2@kernel.org>
Subject: Re: [PATCH 0/2] dmaengine: xilinx: xdma: Fix two clang warnings
Message-Id: <170566862981.152659.10334947019095225561.b4-ty@kernel.org>
Date: Fri, 19 Jan 2024 18:20:29 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Fri, 22 Dec 2023 11:06:43 -0700, Nathan Chancellor wrote:
> This series fixes two clang warnings that I see after
> commit 2f8f90cd2f8d ("dmaengine: xilinx: xdma: Implement interleaved DMA
> transfers"). They have just been build tested but I think the logic is
> sound, please double check though.
> 

Applied, thanks!

[1/2] dmaengine: xilinx: xdma: Fix operator precedence in xdma_prep_interleaved_dma()
      commit: fe0d495e759cee0dbfff4348b5791f21b6f56655
[2/2] dmaengine: xilinx: xdma: Fix initialization location of desc in xdma_channel_isr()
      commit: 620a7e4c1f03a84e10c8c3fa0ae1aab03ef84294

Best regards,
-- 
~Vinod



