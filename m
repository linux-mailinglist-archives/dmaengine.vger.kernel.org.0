Return-Path: <dmaengine+bounces-2586-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D0091BC36
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jun 2024 12:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEDFD284966
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jun 2024 10:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DBB15442F;
	Fri, 28 Jun 2024 10:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxwYHr7a"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F551103;
	Fri, 28 Jun 2024 10:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719569410; cv=none; b=KJipzshKGgGy6KtituJzoHK+Fl1q3RYsO33EgNHFa0uwDdm3PwW4KJCN9thm/g+0EZga86yY6+wvVf7kWzrocoro97tICokUSnlbZWgCtSTJPMTpkX8cOPtXGBuFaAtTW0Rf88Yi1MUNBWKS2gH0piArZHTqrL88H6jUBXKPe0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719569410; c=relaxed/simple;
	bh=t3fFLMO9wa79MnA4kRf3PafxT3Nw/pBZrccA9fGwYmY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Y97RyfpiqBEHla/KKc/D1VuYhAKviF9k1HOA1AkXgyefSpJoTliMWm769v/Vq5WcenbgqJ0I8nH7zKkbUtsB+NHsL42XbDlNfFInP3b4ZFIAGvH8CKbLqmRnIISli1k0fbpLGZ4KAY3bsvh2IHvrt9pFYfrLxZ5leW1UalBgSEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxwYHr7a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C6CBC32786;
	Fri, 28 Jun 2024 10:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719569410;
	bh=t3fFLMO9wa79MnA4kRf3PafxT3Nw/pBZrccA9fGwYmY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rxwYHr7a/zfRY1U+DMK062c4SaPbPi2HI+brmCmSR0XnbWSBVSw9euawA1O2d/Zv+
	 ZONbotwzECvkCuD6TwWSSJjNb8F9JNME0i7rDrT85jHsSGe1eV5wan5Q884MEyTugE
	 4Q3tEkkKlj1Fta1swG7K+s9v+pc8vRT8cGNvUsJiDi/g+Bp53gfIVrX+k4Ve50mLIx
	 nfzO3VaSUGVl15wEB3RjriA4wCfWrtdi+booVv4UznbGG7NoMOZ6Ad2koD3PO7LjiK
	 JcfWOL+PyIbR5hn8oXSBaAn3kalzz2EmYU9FHGQ/ghagaBECf+QjLytIWISRPFdfbn
	 d+3hHAFoCulfQ==
From: Vinod Koul <vkoul@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>, Jai Luthra <j-luthra@ti.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Devarsh Thakkar <devarsht@ti.com>, 
 Jayesh Choudhary <j-choudhary@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20240607-bcdma_chan_cnt-v2-1-bf1a55529d91@ti.com>
References: <20240607-bcdma_chan_cnt-v2-1-bf1a55529d91@ti.com>
Subject: Re: [PATCH v2] dmaengine: ti: k3-udma: Fix BCHAN count with UHC
 and HC channels
Message-Id: <171956940678.519169.5815985134895413368.b4-ty@kernel.org>
Date: Fri, 28 Jun 2024 15:40:06 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Fri, 07 Jun 2024 23:41:03 +0530, Jai Luthra wrote:
> Unlike other channel counts in CAPx registers, BCDMA BCHAN CNT doesn't
> include UHC and HC BC channels. So include them explicitly to arrive at
> total BC channel in the instance.
> 
> 

Applied, thanks!

[1/1] dmaengine: ti: k3-udma: Fix BCHAN count with UHC and HC channels
      commit: 372f8b3621294173f539b32976e41e6e12f5decf

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


