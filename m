Return-Path: <dmaengine+bounces-7877-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B42CD91A6
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 12:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 62A9F300CAD7
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 11:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425A8315D3E;
	Tue, 23 Dec 2025 11:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCT+Vcl+"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F2F254849;
	Tue, 23 Dec 2025 11:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766489281; cv=none; b=PZZB+O2II2b5Bvv8E3rjpOkR/aSMCT/ZNXAbkrKE2fV02iqQfwbRzxOoG+YR9zWsJw3r9jGRXALRnq7UkyaH9a+xA0sq4ejonBYIEv48Z0RxrPGUOR3YSb7zLS6+vgQN8Naw+xNN59mNHhSk89awrmV6kXQiBOjZ3DoNqZmMjpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766489281; c=relaxed/simple;
	bh=EOcod4KivACkoR+fcYl5ZpqxIiNa5O5Q94ykTEfISbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YaiVD7WQoUSf3scNEEc201g7NXi+uLsD1rR3vPDkFlYOfFk+cf54XUpr3jRQcMiy0OwC4HAFXyF6Ryl9614DCTa8dt28YehUs42kBi8KX3UqIFNrsRCNZFX4BgDlDRXXpyQk7n8grVk5SkNoWTSyOvobHOi36REPdqbb+c6reqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCT+Vcl+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5939C113D0;
	Tue, 23 Dec 2025 11:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766489280;
	bh=EOcod4KivACkoR+fcYl5ZpqxIiNa5O5Q94ykTEfISbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GCT+Vcl+xzW6I8bfiohUrdNSuZT9Sw/ESeATQ+w7fu4UnWGVD5tb9/8aeua+PunS+
	 Ifs4HC6UVTBi+u8gVJv5ZJ45nmGnYrGf6k6lt69xD5HqZ0uFTvkkpfxZCzLO7B+zpq
	 9jrFPiu+atOs2oIO3wu1GlpiwGCEWahArsNny3whYmMLx2en2SmvIGrNeQzehmi2Zd
	 Pl20+Psg9ZKxhN+9Yw0L4FneCIzSKyVeJ6Tsy0krJO6eFza95KgLPURYPJcz41e2Un
	 L3CcQRZXQSHcPlmt1Nj8jg7zMKjIygVDyBleJtRPc/KJgeFp42QqILPgHa6+yCSqgs
	 aMhvLX17qarVQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vY0YY-000000000mj-0Gl5;
	Tue, 23 Dec 2025 12:27:58 +0100
Date: Tue, 23 Dec 2025 12:27:58 +0100
From: Johan Hovold <johan@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] dmaengine: at_hdmac: enable compile testing
Message-ID: <aUp8vhZLIAUJ98Oz@hovoldconsulting.com>
References: <20251117161657.11083-1-johan@kernel.org>
 <aUp2MkMmDFw1kgdK@vaman>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUp2MkMmDFw1kgdK@vaman>

On Tue, Dec 23, 2025 at 04:30:02PM +0530, Vinod Koul wrote:
> On 17-11-25, 17:16, Johan Hovold wrote:
> > There seems to be nothing preventing the driver from being compile
> > tested so enable that for wider build coverage.
> 
> Sorry this fails for me, can you please rebase

Apparently someone sent a corresponding series a couple of weeks before
me which is now in 6.19-rc1. So please disregard this one.

Johan

