Return-Path: <dmaengine+bounces-1771-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD8189B307
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 18:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D10DF1C22025
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 16:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BC539FDA;
	Sun,  7 Apr 2024 16:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNdusd4/"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2A12B9B8;
	Sun,  7 Apr 2024 16:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712507935; cv=none; b=anrtiW6efeKUHCMFVZvIgmwWhMA18P1Z9++tQgXnaRLj4I6fl8KZWT2mOr6JnPanrHb81sNdXDKbMOLKIZLuoZOV79U9UvjgsIZkjhE3FumIR1gjfiED2BJeVdHSAJdwLc5dqaq0JwJnuo02EeQoZtUMWBijJR7DlNUL+uCX088=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712507935; c=relaxed/simple;
	bh=ZkTJaXYHph85xgfvYceTPe6xlezpzTbKACyrcoDckM4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dmNi1PEr2VVbZK1uGDKcPuJ0gXUXv5q8t0CS2WOggWI8hBU6yKtNDQtKT6tGGhVAKZeKhdG6YMAeMN+FjApNyhh0+nxl7njn4+W3Q3zafWKNsghOaMz+5xqq4LskStawF+B1/l1zaFESpp0GJSs0z7y2pkIz4mBRVMLfuwFIQHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNdusd4/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A7CC433C7;
	Sun,  7 Apr 2024 16:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712507935;
	bh=ZkTJaXYHph85xgfvYceTPe6xlezpzTbKACyrcoDckM4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=aNdusd4/Wpkt0XsdUXYQCnkkb8ES0oVeRTee8L3DGRmXwkvL2KNuIFbeYkWNgetDY
	 lIc7591rwEvxMFqD9vmOzS9ljnS1lAxx2nyUYyDzkC7hAZaQRZhhZc4pt+toL7vOZJ
	 Oe/rP6B/o9UXYEPhT4N3kzaXSBpZEgGPCAM0pjsv+E79jFSLtlg7LZB87OU9b7OJsn
	 sbrl6rckAPHgwSAz0lWOXFvZlLAv/JCXnAPayGD3KPSViBslpQyJltNyIaipYURBH2
	 nwfg5mje8fiEla2UkNsZFWJRHpZUERzSN6xnhqgrj+pT7Gaxn4nQKi5+IzkBMDqgrF
	 GhjiJAxwaYXSA==
From: Vinod Koul <vkoul@kernel.org>
To: Fenghua Yu <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
 Jerry Snitselaar <jsnitsel@redhat.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240405213941.3629709-1-jsnitsel@redhat.com>
References: <20240405213941.3629709-1-jsnitsel@redhat.com>
Subject: Re: [PATCH v2] dmaengine: idxd: Check for driver name match before
 sva user feature
Message-Id: <171250793335.435322.3691428203593315560.b4-ty@kernel.org>
Date: Sun, 07 Apr 2024 22:08:53 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Fri, 05 Apr 2024 14:39:41 -0700, Jerry Snitselaar wrote:
> Currently if the user driver is probed on a workqueue configured for
> another driver with SVA not enabled on the system, it will print
> out a number of probe failing messages like the following:
> 
>     [   264.831140] user: probe of wq13.0 failed with error -95
> 
> On some systems, such as GNR, the number of messages can
> reach over 100.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: idxd: Check for driver name match before sva user feature
      commit: c863062cf8250d8330859fc1d730b2aed3313bcd

Best regards,
-- 
~Vinod



