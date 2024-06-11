Return-Path: <dmaengine+bounces-2337-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB139042C4
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jun 2024 19:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 429C3B214E2
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jun 2024 17:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4164F5F9;
	Tue, 11 Jun 2024 17:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQzWn/Sz"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF6C2570;
	Tue, 11 Jun 2024 17:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718128254; cv=none; b=WRA/K//Ajnxqf9NRZ0fPFVleolnU5t150dwibZpbzALaLlXSyFW7O9yPgXHSGOiWJ1PEVDmfvi/bnRWY4kze03P0OG6HP9avRaLnb0YIIt3bTpjew4lLgNmehsVZ/EmH9Zx7mG28kLlZ0m2G9wwm4hB1DZH86yLnEG9RvepzigM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718128254; c=relaxed/simple;
	bh=qKv99FKq5QNiYusY4oaFndG2yZprCcFJ9vJUSneVSVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBST5OVuHt1XvMUe3JU96rmI7pOYZN+Sz8WUZMDa6UWlAZtbsUQ/igtrzauA1PTgxoLKtRhKK4ZA99GX/YgkdgFeYtefoplzZxv6ss8nYrYTR6vzTEqCxnRDlnSG6C9AL67dWHftUcln/VV/uLB6nt3xSzw3i+ptvqZ0zrFaPQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQzWn/Sz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1231C2BD10;
	Tue, 11 Jun 2024 17:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718128254;
	bh=qKv99FKq5QNiYusY4oaFndG2yZprCcFJ9vJUSneVSVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iQzWn/Szpxmn6IF3SVEGpR/idtK+mB1QyIjeo5PocwfeNLjhOcfzIxLqvEf7dJXEE
	 PPmVfbALE3Mv6mbE60zRJPK9pNuOngcII5X7EeqYT2mIEdZMbHXwXdbvEGBLRMEHD9
	 yEw3g6c2/WwoMrPnUqHUMZ/Zlkkpyxabgo1C/KMhpGD3s883jbAGPeCM6tyAoY03om
	 VMf7OrxrBIFigNEJNSY/k33Or2dNaJpgbsTDZ1qCnvXgN319rXuQ7Jzo+OUmvHMmgn
	 JfowyGDbznZEfZiPWpG00/z4tNRZrEazAy2ROET7Icl1DfXr8PkTR7yvSYVDZESKgm
	 3lnr9p9kawGJg==
Date: Tue, 11 Jun 2024 23:20:50 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Jia Jie Ho <jiajie.ho@starfivetech.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: Re: [PATCH v5 1/3] dmaengine: dw-axi-dmac: Support hardware quirks
Message-ID: <ZmiOemWQrG-3EdIB@matsya>
References: <20240530031112.4952-1-jiajie.ho@starfivetech.com>
 <20240530031112.4952-2-jiajie.ho@starfivetech.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530031112.4952-2-jiajie.ho@starfivetech.com>

On 30-05-24, 11:11, Jia Jie Ho wrote:

> +
> +struct dw_axi_peripheral_config {
> +#define DWAXIDMAC_STARFIVE_SM_ALGO	BIT(0)

what does this quirk mean?

> +	u32 quirks;

Can you explain why you need this to be exposed. I would prefer we use
existing interfaces and not define a new one...

-- 
~Vinod

