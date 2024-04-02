Return-Path: <dmaengine+bounces-1709-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A908957EE
	for <lists+dmaengine@lfdr.de>; Tue,  2 Apr 2024 17:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 109DFB23845
	for <lists+dmaengine@lfdr.de>; Tue,  2 Apr 2024 15:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095AF12CD86;
	Tue,  2 Apr 2024 15:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="V/1YlGNP"
X-Original-To: dmaengine@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E6812C526;
	Tue,  2 Apr 2024 15:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712070698; cv=none; b=nO49ZsR3haN6eRcmgEhJv+z4nqVVLoIoetTVjMn52YoJH+sSrINgAh/kd3kTShqQJC/J8ZSRS3qtmsfbeLCMl4pd1hj1NXElc9fb0ZPRsqBz5T3AHQ0N9vwLDf9DYS8UCF1BtAOuwUV5C3Y9tlaclO7eIfWaIHt6HspgMauUODc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712070698; c=relaxed/simple;
	bh=MlIvE42l0NzRMnJ2ZNOCzLjJI3UJGeE/J4+BUsMeGtY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tph5/3q/b44ry0kxHExQNZ6Vx9290j5GaCFIxNzf/lbRXIDUwtWFkG7CpBHt9KCFF2Wk6hh4IrFRnC5t2zO/XW9/B0JHkUIA2LDQNK2xN/SSB9xdor3pq8oltrK2D81miGSywUjgizCOmKWZqA773OHCXP5oXoeT7QgAogMlwHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=V/1YlGNP; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7FECB47C1D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1712070696; bh=MlIvE42l0NzRMnJ2ZNOCzLjJI3UJGeE/J4+BUsMeGtY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=V/1YlGNPjaSw7IbFjR8KyupsLg73cZ9GPKUjx4z2d3jVwcoS4zgcwLs+Od5jvI+jv
	 rHIFH0rTCEN4tpZyFx9kSN0yjgKbdgDmqs6Po2hJcZzzdmMaRig5U341jPWa0wywqu
	 HfO2z4TqYOGMipS903MQZcdBqqPjh8n4wfeXOoUszSRe1+bfkbRLoskDlbgukumePy
	 iP4bqhKPJ3fG9bh1dYL9Id4IckkuU60Hw/uPI2/9zd5PkshaOUduzA4odT9mViucmt
	 sup7uEhn26klrmHwt5S8AiJlrMu8vF+7hF0qv+ARrnuRqZPQQpyyAe+UvhJyqzIl6C
	 ZIbMkrxZDHL5A==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 7FECB47C1D;
	Tue,  2 Apr 2024 15:11:36 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Christoph Hellwig <hch@infradead.org>, Frank Li <Frank.Li@nxp.com>
Cc: rdunlap@infradead.org, hch@infradead.org, dmaengine@vger.kernel.org,
 imx@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 lizhijian@fujitsu.com, mst@redhat.com
Subject: Re: [PATCH v2 1/1] docs: dma: correct dma_set_mask() sample code
In-Reply-To: <ZgwfmERghiT-e_x-@infradead.org>
References: <20240401174159.642998-1-Frank.Li@nxp.com>
 <ZgwfmERghiT-e_x-@infradead.org>
Date: Tue, 02 Apr 2024 09:11:35 -0600
Message-ID: <877chfyf2w.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christoph Hellwig <hch@infradead.org> writes:

> This looks good to me:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>
> Jon, do you want to pick this up through the Documentation tree, or
> should I take it through the dma-mapping tree?

I'm going though my patch queue right now, as it happens, so I'll just
go ahead and apply it.

Thanks,

jon

