Return-Path: <dmaengine+bounces-5170-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB892AB6ED6
	for <lists+dmaengine@lfdr.de>; Wed, 14 May 2025 17:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A5E81BA39AB
	for <lists+dmaengine@lfdr.de>; Wed, 14 May 2025 15:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0360327C152;
	Wed, 14 May 2025 15:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+MrAElP"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E621C84AF;
	Wed, 14 May 2025 15:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747234991; cv=none; b=eLEIypuZvzFFYBpcKIEP7+KrWKM2uiHX7/M3hoYp7TLzXh/W4X47Zt6h9FVWtDmY7SC5hz+iXD+FWcSlJlTD4+xMbOqCKtOeTyhzIGd87YVUP4VMF2pgnYmt8MqMH7qnBS8v4sdL6MXF+lK/pAXdRD3NO2oC7SR3FhjY665VhEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747234991; c=relaxed/simple;
	bh=BDjd/dPRS2L4m/ca+Hsf4jobzeV6g+TgyBgYCGTC/cU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jm8X/eBAyFmk/XeKgi9FbMZy118SRDjfQzsTBiYB3XR7z4RT7yBKjrhWVDLCuMpkfQZsB1Ej+zjmBV6xKS+LXogE878LUvKD0/v4nuNAaNaaDMu0tskYgytvbQnLSZPgpOIY1fdD/AWvnM+CqHRsUtmlDGM3xo0s4I/5jfOhz4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u+MrAElP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4344BC4CEF4;
	Wed, 14 May 2025 15:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747234991;
	bh=BDjd/dPRS2L4m/ca+Hsf4jobzeV6g+TgyBgYCGTC/cU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=u+MrAElPeeBtMKRh+3RRSIwkqvm5A2ecQxbfl+xILiFFjkW3lXGCi+kJehMXlrrWM
	 1amp8aCS3lN/3aQJHKoJdMRzo4cwN1FfsfJKdwddS7X5rhmuXTgsUv8+vFHZrebRgi
	 1BTdETj0aYT2C9Wk3JdRc2jRjgjuyOK7feeNlIy5RkDen71DHIFkB2UA4uzs47ggnM
	 fyzlWvWby7ylyKosXMGVWd8nmhtWwR5KMc/8Fi8stlL4A4JntSQZareunNE4iSlgqx
	 XKUm+/5MJLTL4z8F1e1AWSoeJbHgiG5N8qFn9cCjaXxnX7q1VgnUUZWh3/G9r9p5g+
	 qO465+WLgh7Ag==
From: Vinod Koul <vkoul@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Anil Keshavamurthy <anil.s.keshavamurthy@intel.com>
In-Reply-To: <20250312221511.277954-1-vinicius.gomes@intel.com>
References: <20250312221511.277954-1-vinicius.gomes@intel.com>
Subject: Re: [PATCH v1] dmaengine: idxd: Narrow the restriction on BATCH to
 ver. 1 only
Message-Id: <174723498996.115803.6284345485157042502.b4-ty@kernel.org>
Date: Wed, 14 May 2025 16:03:09 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 12 Mar 2025 15:15:10 -0700, Vinicius Costa Gomes wrote:
> Allow BATCH operations to be submitted and the capability to be
> exposed for DSA version 2 (or later) devices.
> 
> DSA version 2 devices allow safe submission of BATCH operations.
> 
> 

Applied, thanks!

[1/1] dmaengine: idxd: Narrow the restriction on BATCH to ver. 1 only
      commit: 31f04b537152675adca2f97582660e3f178dcfff

Best regards,
-- 
~Vinod



