Return-Path: <dmaengine+bounces-4591-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0C8A47D01
	for <lists+dmaengine@lfdr.de>; Thu, 27 Feb 2025 13:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB0763B1266
	for <lists+dmaengine@lfdr.de>; Thu, 27 Feb 2025 12:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740B622FDE8;
	Thu, 27 Feb 2025 12:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mg6Djrrt"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4260222FAFD;
	Thu, 27 Feb 2025 12:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740658088; cv=none; b=LOmH3FfEwSpeNQp3HOuB/Fzv4/AG3GASozybbUPrRE+bNOJVd8wIRgNDQ7GgAqSrIZsssRjaaq+gEI/l0OSRWRITBU3VIKUPo+6mX7z5lm1KL5oSPdp7u9o+2bkE+q9LQ0bI1qrp8zGy1Ma9VHfmrokg9hGBk/by/xeHN8AMBTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740658088; c=relaxed/simple;
	bh=+jWg+/qR88kiWEcyUp66ZD/Q8dyb0IZMnZC0rkWbtDY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JIaICgOZ7KQuABmgW8vlIXhZAYdVBhGA4y45/codXrWmTyjzALnJed8td7ZohajeFU6W34TjEDi2li0o2gO4jV8i5TFEk1oGVIyzPLSqGJQY0HcMmWmxbaigeWPKuiQzVcV/5rkcHEv95Sf8W0aESc1jel9pfomwp4BXpMkw4fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mg6Djrrt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12AD1C4CEE5;
	Thu, 27 Feb 2025 12:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740658087;
	bh=+jWg+/qR88kiWEcyUp66ZD/Q8dyb0IZMnZC0rkWbtDY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Mg6DjrrtFLXhj49WLq4KbzUh33dxLLNVMyIl/5nn6ci0HibY1c11rgtapJodsE26u
	 MvRoEcIuEK5edY26swAkZyDpTL32/LiA1xoIrddZc50u48UptiByFxwdhql7tx2nhF
	 +rgcXds2vFfdwXX+mD3ZipLBzsn9Ci5uZUNwte4l9+zxzgIAi0Md0uNB9r90ttOCI1
	 3LxNZd/JlM4fMClO62UDPgchBC54fmhyUXKXeXdF9e/wrOOS1z3v+a8AeClgThItdE
	 L+1z9zrIt8AQ8Gm4GHfX6F9qQPIqh48WjiQUjqGXE6hnh9GE/6Bg4gS5AC2HlJ3OAH
	 246E2Q/ZaQt5Q==
From: Vinod Koul <vkoul@kernel.org>
To: Yan Zhen <yanzhen@vivo.com>, Palmer Dabbelt <palmer@rivosinc.com>, 
 Thorsten Blum <thorsten.blum@linux.dev>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250219105419.2025-2-thorsten.blum@linux.dev>
References: <20250219105419.2025-2-thorsten.blum@linux.dev>
Subject: Re: [RESEND PATCH] dmaengine: Fix typo in comment
Message-Id: <174065808566.367410.6938061745713567822.b4-ty@kernel.org>
Date: Thu, 27 Feb 2025 17:38:05 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 19 Feb 2025 11:54:17 +0100, Thorsten Blum wrote:
> s/consumer/consume/
> 
> 

Applied, thanks!

[1/1] dmaengine: Fix typo in comment
      commit: 6f9669f3634b4e85374676dfdff9181bee14567d

Best regards,
-- 
~Vinod



