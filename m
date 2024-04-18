Return-Path: <dmaengine+bounces-1885-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B1B8A924D
	for <lists+dmaengine@lfdr.de>; Thu, 18 Apr 2024 07:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB5F51F217F5
	for <lists+dmaengine@lfdr.de>; Thu, 18 Apr 2024 05:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A872154BCC;
	Thu, 18 Apr 2024 05:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sMb7TUzJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7994F651B1;
	Thu, 18 Apr 2024 05:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713417207; cv=none; b=StrG/AX7QOodxSwth+Y+m3F4QeGc0pdM2iFZuclmMH+7hfxJibPYFNEavBSpx+ENjoRRxg2jBFgHvR9bwXrP+me2JDU52NGb7vkBRHbB++wjGEEPkOx2trqwlxz7OY87ZUE10TWKeJ2l/CTeFsdmES0VA+cqGbmXQkuIzbARqfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713417207; c=relaxed/simple;
	bh=gW1mGJDzIE0PdWXkGTdRMnEL0jMbvEIBiO9qTSGudOI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QfaKClcIFuLTxihWKAgWb+H1/uxzjIfvLmAcK8M3RIOMa3FwLVz8THbYgE5t6hi2T0r2Idjt3aSSlLFaZn2VMBaYgyIKPgjqCVRUmaUnHyHizG39PKZROHpmBnTod4iqZcraUI5PP0U09ggyE8F9H1WwkQ59tZRmrW5qYccTO7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sMb7TUzJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A5AC32782;
	Thu, 18 Apr 2024 05:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713417207;
	bh=gW1mGJDzIE0PdWXkGTdRMnEL0jMbvEIBiO9qTSGudOI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=sMb7TUzJQdA2Je+ck2wHeLIF6agHcjGlZHqELfQ0STL4V0G1sir0kpor2z2zE9oSl
	 qgV64QJfHFqPUZ5IQPNNaYxm/T9xZoZAR/954drGewmn3aWnBFXhU1Vtfgydh+0brQ
	 QvON4NuHtpE7/97s2dThhVFVr5mGDUnG9v9LFsZZz69GgIcYYKZJnkysdQIdErhLDi
	 bCjKhSPN0E0bVo225dj1665RVuLYou/JW1cX+ryzwmmlkV+nA0zKBtOy3oD/mwXDyO
	 bY4JiHKKAl/bwixOSoVr0gk3Y9uo9V+TjURuAkCNElIQCa/svm2sS9UzXrVNk4SzaI
	 ADJ+YgXgRT0AA==
From: Vinod Koul <vkoul@kernel.org>
To: Kees Cook <keescook@chromium.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Erick Archer <erick.archer@outlook.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org
In-Reply-To: <AS8PR02MB72373D9261B3B166048A8E218B392@AS8PR02MB7237.eurprd02.prod.outlook.com>
References: <AS8PR02MB72373D9261B3B166048A8E218B392@AS8PR02MB7237.eurprd02.prod.outlook.com>
Subject: Re: [PATCH v2] dmaengine: pl08x: Use kcalloc() instead of
 kzalloc()
Message-Id: <171341720530.758041.12615273224606101090.b4-ty@kernel.org>
Date: Thu, 18 Apr 2024 10:43:25 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Sat, 30 Mar 2024 16:23:23 +0100, Erick Archer wrote:
> This is an effort to get rid of all multiplications from allocation
> functions in order to prevent integer overflows [1].
> 
> Here the multiplication is obviously safe because the "channels"
> member can only be 8 or 2. This value is set when the "vendor_data"
> structs are initialized.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: pl08x: Use kcalloc() instead of kzalloc()
      commit: 98f2233a5c20ca567b2db1147278fd110681b9ed

Best regards,
-- 
~Vinod



