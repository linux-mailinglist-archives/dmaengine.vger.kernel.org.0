Return-Path: <dmaengine+bounces-3883-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED4D9E3B14
	for <lists+dmaengine@lfdr.de>; Wed,  4 Dec 2024 14:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 644D2282CD9
	for <lists+dmaengine@lfdr.de>; Wed,  4 Dec 2024 13:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315B41BE86E;
	Wed,  4 Dec 2024 13:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rB5k+ijE"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E301BD032;
	Wed,  4 Dec 2024 13:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733318323; cv=none; b=EPYfxPdr1EjjupoA2AdCPdSU4nTCbCDILJv+HZ3a+SevTwNUJgelyhuEwkUdmLuRoRp3mg9XSCH3PfdRZEVXwFxjuErfkCmEjCFF/o1MFsQWEactXKlWhek6zvxf8IJfzzd8QOnYYKiRM5Zvp+JEDf9qD/+cfa8G4gZ6bWBKtYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733318323; c=relaxed/simple;
	bh=faV2UgrFbUwgZHqI4NWc38uDrA+m4co89RJaBnWShTs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hi+dqtuzSvfh05eT06l3aZGcbDMc+PFid6c2/4bMBa5GGvVNomwXdsvyG0Zv6+ZXhVWTwOJ1W/V8vaui4nW6ffz4nS0FQuo587FIC5iJxrPUIQyBZkYa6jG8z5bOj5DO2w5+U64XRDlEYca43SCa7hpdd3Iq0M/EEdNkvC6GpHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rB5k+ijE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D442C4CED1;
	Wed,  4 Dec 2024 13:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733318322;
	bh=faV2UgrFbUwgZHqI4NWc38uDrA+m4co89RJaBnWShTs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rB5k+ijEcQq+GMI+O3ZZNor55nQ668cDtyWYBE7E4Va4VThnAJARQoUwM41lr6DQs
	 eg/c4KoQZPtSVwhiyjgGzdoeOUhN7CFtAkSsUUnmhhoYzfyY5G4S8fz2+uVW+2vXzL
	 L5gk/3MHecf9HaNMHav+bF/cx1jOE+WnaruBainUiMSjC/Gr05RXI7CvUjVFw8/V/4
	 GfSeAQRGPOM2WkwuusLY8NXSjh/yUmlwdk66JEkSYdQ84kx0lQmb4sWbvSMbzfV4CS
	 w4XQPY8Dlt9LOclYz8x+Jdg2z2cuZuAAwqmiFq/XkPkPluXzeMXhab0EwWCAKOlUzV
	 NEqqC2FH7f53w==
From: Vinod Koul <vkoul@kernel.org>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Dan Williams <dan.j.williams@intel.com>, 
 Dave Jiang <dave.jiang@intel.com>, Paul Cercueil <paul@crapouillou.net>, 
 Nuno Sa <nuno.sa@analog.com>, dmaengine@vger.kernel.org
In-Reply-To: <20241202172004.76020-1-rdunlap@infradead.org>
References: <20241202172004.76020-1-rdunlap@infradead.org>
Subject: Re: [PATCH v2] linux/dmaengine.h: fix a few kernel-doc warnings
Message-Id: <173331832011.673314.3759206188321207606.b4-ty@kernel.org>
Date: Wed, 04 Dec 2024 18:48:40 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 02 Dec 2024 09:20:04 -0800, Randy Dunlap wrote:
> The comment block for "Interleaved Transfer Request" should not begin
> with "/**" since it is not in kernel-doc format.
> 
> Fix doc name for enum sum_check_flags.
> 
> Fix all (4) missing struct member warnings.
> 
> [...]

Applied, thanks!

[1/1] linux/dmaengine.h: fix a few kernel-doc warnings
      commit: 790fb9956eead785b720ccc0851f09a5ca3a093e

Best regards,
-- 
~Vinod



