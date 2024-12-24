Return-Path: <dmaengine+bounces-4061-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 749CF9FBC92
	for <lists+dmaengine@lfdr.de>; Tue, 24 Dec 2024 11:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF08F1882D2A
	for <lists+dmaengine@lfdr.de>; Tue, 24 Dec 2024 10:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FFD191F91;
	Tue, 24 Dec 2024 10:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ix8L7B0l"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBD11AFB36;
	Tue, 24 Dec 2024 10:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735036917; cv=none; b=YGi5gdmgSaZQGj7yUZebkhEE43K1rPGQ1h6uMwf0/H6tm3m1utWqXe8ByBheU/9D89b5dOLOrT375p4P2QSfxKPQ1lKrCN+RGpw53BSLWYZQtUg7qDSnZD85sslW1yXCODGEziCCNjcax7GCrcVjtPu6kA/ifAv58qE3pfKbhZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735036917; c=relaxed/simple;
	bh=HwLzoignyOm0Zjz0YiEbF60Bhr5J34V+2wRKgPRZ5s8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=beyhZ0F9IPD3wAd1lqFJSx/TrN23XDgA5pPYRspUYdrKSq8JPGJFhM+ntUBBzNbtxKc2/cvXk69i4LlSg8VahXriBSq96riN14t+sVmZ1BARyydDPmHfbQn7SSP1lakAe0FpVD5yAaUmSheFp6uU6AYzDKdVsGUAXs4u/XYVnNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ix8L7B0l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B49C4CED0;
	Tue, 24 Dec 2024 10:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735036916;
	bh=HwLzoignyOm0Zjz0YiEbF60Bhr5J34V+2wRKgPRZ5s8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Ix8L7B0l9A4DeiXKqib+q3QD9aL4usCTylr9fs0Qf9s96Ssiix15pEcYV5O7JfRDK
	 +ORw7Sc/LndKiJwV6GbSJEPYFoDwRlDnhhV1FKbkCGWTrHZdmTuCggp7uWSUecfc01
	 vlmgSEHdFsyDQc4IexZtnhDt96h7aI3nqo0KaIWfExotemwYoaZbs9L3mzrQ9KLz9/
	 jDLUcsJsE45g1JANU8YG4jG2E0Uv4rUFQTxFV7ilW40hScvt9ZJYUoYh3aK454FhqU
	 7caEhvNl2ZeuaJ6ZtOMadlpOL13C7AIKlV2QqyT4we/Th5k9s9tgb0TtfmzyG7a36b
	 Pze5ivK6lJd5w==
From: Vinod Koul <vkoul@kernel.org>
To: fenghua.yu@intel.com, dave.jiang@intel.com, linux@treblig.org
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241221141635.69412-1-linux@treblig.org>
References: <20241221141635.69412-1-linux@treblig.org>
Subject: Re: [PATCH] dmaengine: idxd: Remove unused
 idxd_(un)register_bus_type
Message-Id: <173503691502.903491.746751184798251507.b4-ty@kernel.org>
Date: Tue, 24 Dec 2024 16:11:55 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sat, 21 Dec 2024 14:16:35 +0000, linux@treblig.org wrote:
> idxd_register_bus_type() and idxd_unregister_bus_type() have been unused
> since 2021's
> commit d9e5481fca74 ("dmaengine: dsa: move dsa_bus_type out of idxd driver
> to standalone")
> 
> Remove them.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: idxd: Remove unused idxd_(un)register_bus_type
      commit: 308213731f8cc772245adb729ae2364fb1d20e98

Best regards,
-- 
~Vinod



