Return-Path: <dmaengine+bounces-613-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4505C81BBBA
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 17:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C306CB250E7
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 16:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559CF58208;
	Thu, 21 Dec 2023 16:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqjShHXx"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A7758206;
	Thu, 21 Dec 2023 16:17:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA7EC433C7;
	Thu, 21 Dec 2023 16:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703175430;
	bh=UgET2iUhHThR0JhLXtju4F+IngMEjotyGecLuns3OpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IqjShHXxEN9IRVoDuIusxlLsuC544jLvglJkMhCI52U1x8IyuP3QgR+JrP9/08+lY
	 ZOs0ZXprfEZpo/0VY1z624+EOZ+p69ldB1xlMpkBrBSybBgY8eMsnMN2WygyIHUv8e
	 Naup8ekji+y7v21895ktxEO5w3cTrXRfPlz3jQ0HLiquFTac9ggF1E5iG/bjhZ05pm
	 ER+JglF92mXVoC+NyBVGeplqCwU5uE9xVaC/i30Xfa7mNhKrKh3XJcbv0f7x3rTRy/
	 bvQ+XWCrtXYu3ZN8piEFTYeyqmZtuIl2b66fg8QqlWTbc/JdtOuqmx8Qpsn/03WuTf
	 OVOUFu7oqugiQ==
Date: Thu, 21 Dec 2023 21:47:06 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Kelvin.Cao@microchip.com
Cc: dmaengine@vger.kernel.org, George.Ge@microchip.com, logang@deltatee.com,
	christophe.jaillet@wanadoo.fr, hch@infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Message-ID: <ZYRlArNma_Rl3Y_t@matsya>
References: <fd597a2a71f1c5146c804bb9fce3495864212d69.camel@microchip.com>
 <b0dc3da623dee479386e7cb75841b8b7913c9890.camel@microchip.com>
 <ZR/htuZSKGJP1wgU@matsya>
 <f72b924b8c51a7768b0748848555e395ecbb32eb.camel@microchip.com>
 <ZSORx0SwTerzlasY@matsya>
 <1c677fbf37ac2783f864b523482d4e06d9188861.camel@microchip.com>
 <ZSaLoaenhsEG4/IP@matsya>
 <f6beb06cc707329923cc460545afd6cfe9fa065d.camel@microchip.com>
 <b5158f652d71790209626811eb0df2108384020b.camel@microchip.com>
 <b4a1a955cf4bbab695d364b6d4da4d16167c3959.camel@microchip.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4a1a955cf4bbab695d364b6d4da4d16167c3959.camel@microchip.com>

On 12-12-23, 17:53, Kelvin.Cao@microchip.com wrote:

> Hi Vinod,
> 
> Could you please take a look at v7 of the patchset which removed the
> wimm implementation per your comment? The patchset had got approval
> from other reviewers. Let me know if you have any other concern. 

Somehow I dont seem to have it, can you please rebase and repost after
the holidays, I will review and do the needful, sorry for missing

-- 
~Vinod

