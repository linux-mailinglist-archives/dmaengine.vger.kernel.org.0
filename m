Return-Path: <dmaengine+bounces-6087-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F103CB2E449
	for <lists+dmaengine@lfdr.de>; Wed, 20 Aug 2025 19:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF84FA22E92
	for <lists+dmaengine@lfdr.de>; Wed, 20 Aug 2025 17:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C859274661;
	Wed, 20 Aug 2025 17:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NcuGaUr0"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B8526B2D7;
	Wed, 20 Aug 2025 17:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755711752; cv=none; b=eC0gKNBmhH43iqwadAgwFOiF6/BJTLCYUokc2MKkJ8sai+OTdU1JGieMG/EuuB/+zXAPo5mxg59d4uW1UeiNYP94ndAbo0sPcuhn8mgpV20fA6wGPWPB6A+8u7zM1OB4rl+V3SxivoLgaiyENldS9JxOEFlj5rKDxnvi9NeU0c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755711752; c=relaxed/simple;
	bh=DfAe9MzYTgX7IoWjHoOZCVTOptGJeJnMUoX5me0ztE8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UsERUaEXB6CJRKl4AbX7JvxO/e+ZIeMEOL/tAN6IbK0sRglMbtxnMKLSU5PKaA1TK5NSnL8b5ETswsyCrD6F4PkDUtLGG9JBLQPY1DBFBKVZme52+YnXCoBRHMVa/yyN2I7HnGTmcIh/EDb7KnCrZsHKtObT5cxogNY9LeeNXWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NcuGaUr0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A803C4CEE7;
	Wed, 20 Aug 2025 17:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755711751;
	bh=DfAe9MzYTgX7IoWjHoOZCVTOptGJeJnMUoX5me0ztE8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=NcuGaUr0oNenwU9VWC4fgGEGUWtHUc1PGXXUdEMwuVlYSV8GWhMJOZBGot6XFrfN4
	 IWbVXLibJhT/9O60mniBuwjf1IwT/NatbMUIEON38uXEP/fgY62m7nY78czRIA74wc
	 Ir6DEq1y/K7Dv6Hzfbmr3TkS56LK3limjIZtgF1z8lfxiy7sZqGWrsC/fT24SAF4KI
	 /sNnDAiTHIkWdjY6ronSZb3V5sBJX86Kx9IxOpt6U4BS+qa3NPgjezPTV3OV80MezL
	 bIUM6i7+yKLAiE5ZM8Vq4uRIekqUd2J6DjpSQnVXcW5ot4wwXUIkLijTgJdJ6HygDW
	 j6ALFMeRXGMaQ==
From: Vinod Koul <vkoul@kernel.org>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
 Dave Jiang <dave.jiang@intel.com>, Thorsten Blum <thorsten.blum@linux.dev>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250810225858.2953-2-thorsten.blum@linux.dev>
References: <20250810225858.2953-2-thorsten.blum@linux.dev>
Subject: Re: [PATCH] dmaengine: idxd: Replace memset(0) + strscpy() with
 strscpy_pad()
Message-Id: <175571174965.87738.10265434992981489693.b4-ty@kernel.org>
Date: Wed, 20 Aug 2025 23:12:29 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 11 Aug 2025 00:58:59 +0200, Thorsten Blum wrote:
> Replace memset(0) followed by strscpy() with strscpy_pad() to improve
> idxd_load_iaa_device_defaults(). This avoids zeroing the memory before
> copying the strings and ensures the destination buffers are only written
> to once, simplifying the code and improving efficiency.
> 
> 

Applied, thanks!

[1/1] dmaengine: idxd: Replace memset(0) + strscpy() with strscpy_pad()
      commit: 847164d47098f55e99503819300b36cca20cb4f7

Best regards,
-- 
~Vinod



