Return-Path: <dmaengine+bounces-7878-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54889CD91AC
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 12:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 867053001630
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 11:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9120C3314A1;
	Tue, 23 Dec 2025 11:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNp7bR4g"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E982D3A80;
	Tue, 23 Dec 2025 11:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766489298; cv=none; b=QfZ2ydUYKqq45WQXzsMVmIW3p95Vhkk1u7IquiTBhhXIefaZigjy68m7fLUC1PGAC9AIyw2vTTwJVtvR7FGBZLnXMpa8Z4Zu5R7rHLW8XzvVH5DzvzNI4s4sgCpO5lkXSGuKUmeAyY6jgg6XBuwrNaIlLadq5AxgdpnAEvezBw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766489298; c=relaxed/simple;
	bh=CXTikuhV3EiY2FsqamIAGYKReZj4jV2kfB6eDMhHLMk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JxMY4mP7YB447TAir5rRwKKV6rZijvyGLbge5S+RjKRxlPupvbArH5wmscH33gtKD5M05mBfgavAKaJ8WHa7+izgKPVcYGQqh6PQqmymRVPv9gJ5A8dgm8CEcsR4jenBs7HBn9/0B/7eqZJY4eZP5I6ndhlljbDv/fKJsq9CxY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNp7bR4g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CFF4C116C6;
	Tue, 23 Dec 2025 11:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766489298;
	bh=CXTikuhV3EiY2FsqamIAGYKReZj4jV2kfB6eDMhHLMk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=aNp7bR4gYyKYps54two3btL413p044OdUWAmTgk89BAST4/0E3VU4kB0PmkQOV0Kk
	 4R1qx2jf3MfYRkfTUr5XJE+5FGg2H8z8zUA2XjVUF5v76ZNRILzTGwL3+k/UFVF/Jr
	 hylATzl9LbnBPKZ7sABP6COi1zuwMrdwIiqFoiHQ+xncwnTMU4UKEtoD67URq3CL0m
	 6Jf2M/Sbgx1rS+SbWE0N1p/aW08rm219hhcQ/yVDKq4vSaUYYg6mHqF8yXwhYhdIiu
	 uq47aVE/kLZOCEZgnJQ2Omu+hc6lBSknW8u6VR9++X0juttE2Q1lS3eHnEgEVHdjj9
	 OOdtEUaPAiZWw==
From: Vinod Koul <vkoul@kernel.org>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <20251222-uapi-idxd-v1-1-baa183adb20d@linutronix.de>
References: <20251222-uapi-idxd-v1-1-baa183adb20d@linutronix.de>
Subject: Re: [PATCH] dmaengine: idxd: uapi: use UAPI types
Message-Id: <176648929594.697163.13256165598692141453.b4-ty@kernel.org>
Date: Tue, 23 Dec 2025 16:58:15 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0


On Mon, 22 Dec 2025 09:04:13 +0100, Thomas Weißschuh wrote:
> Using libc types and headers from the UAPI headers is problematic as it
> introduces a dependency on a full C toolchain.
> 
> Use the fixed-width integer types provided by the UAPI headers instead.
> 
> 

Applied, thanks!

[1/1] dmaengine: idxd: uapi: use UAPI types
      commit: 98b9f207afa53aff2edb0e52910c4348b456b37d

Best regards,
-- 
~Vinod



