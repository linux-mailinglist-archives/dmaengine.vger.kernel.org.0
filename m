Return-Path: <dmaengine+bounces-1985-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 554A68BBB8E
	for <lists+dmaengine@lfdr.de>; Sat,  4 May 2024 14:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BE5EB2169F
	for <lists+dmaengine@lfdr.de>; Sat,  4 May 2024 12:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0142EAF9;
	Sat,  4 May 2024 12:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0JoMizD"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D922D2E647;
	Sat,  4 May 2024 12:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714826843; cv=none; b=qpyKyt/3YFAc3XTDan2bdA8566KZ0MHsW5r+RaCJ+Z8Oxyd5Dts3FuqpzsZmmsMQq7XGcJkrPTXs31mtLSgDlk6TDey1M/LdfGCAidIG/U9W4aCPjEKbVnYtvPD7IZ4rgdad8RaSzDfzjBt1ogcQ8tmtgJMZB5qLmdWbD+znvmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714826843; c=relaxed/simple;
	bh=dV+mB8XXwYFitJq2TJSeCHPsg62KdLbPQuw6gl9vjLQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ACkX2diIwwyY/jje9C6B3N0UmIUYvmu8lAcA2nsxpa1RjKEIvsL2hWGeqSfTw1vpJT3btyv5IXEmbmZp6BNcRu1y+LoYOoMQ8brPzeHeXsKWD90FqkVemiLgt5fU7ViZMQCchZykXEKGBMVpx4gvEr2qNIKs01zTqnx1h3L95Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0JoMizD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7659C32789;
	Sat,  4 May 2024 12:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714826843;
	bh=dV+mB8XXwYFitJq2TJSeCHPsg62KdLbPQuw6gl9vjLQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=W0JoMizD+7J2P+BKZOqeUgZfb3p+p+YLiRzVqF1r7LuDuJgNJk4R7mrGmaggQK0FZ
	 wKC74iFq+Hr+Y/Ip12esnWsvqsV3CoBHUAfCBRMXJ4R+2MN34vn95nU2Owr4YRM92T
	 MEnGYzETKNEEsIC99ChmZR0EEWMtVf7uCgrp/sx99B0UAmoKrWRXT/xpDeonW5GR4l
	 pdHO67cbRx2bhLId9ouZj7SHY1eHq1l+Wl2i7f+y2ji5LZsAkLbf9GfiF8juYiJXrT
	 3Kfqxfb35aZHKOQL+aQi+Yu0KFkWvPV9jH5QEURfS38hyMXis2d8tZQDpm9tc1DMxh
	 rDGWgK29zqnJQ==
From: Vinod Koul <vkoul@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20240415182055.3465170-1-fenghua.yu@intel.com>
References: <20240415182055.3465170-1-fenghua.yu@intel.com>
Subject: Re: [PATCH] MAINTAINERS: Update role for IDXD driver
Message-Id: <171482684152.61200.4544931704069463466.b4-ty@kernel.org>
Date: Sat, 04 May 2024 18:17:21 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 15 Apr 2024 11:20:55 -0700, Fenghua Yu wrote:
> Move Dave Jiang to reviewer role since he has not been working on the
> driver.
> 
> 

Applied, thanks!

[1/1] MAINTAINERS: Update role for IDXD driver
      commit: 28059ddbee0eb92730931a652e16a994499a7858

Best regards,
-- 
~Vinod



