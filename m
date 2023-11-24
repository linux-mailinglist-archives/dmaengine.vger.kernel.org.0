Return-Path: <dmaengine+bounces-217-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3B47F7396
	for <lists+dmaengine@lfdr.de>; Fri, 24 Nov 2023 13:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16F891C209DC
	for <lists+dmaengine@lfdr.de>; Fri, 24 Nov 2023 12:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EEF28F8;
	Fri, 24 Nov 2023 12:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8eTrReb"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F49D1FC5
	for <dmaengine@vger.kernel.org>; Fri, 24 Nov 2023 12:15:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BAE8C433C7;
	Fri, 24 Nov 2023 12:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700828154;
	bh=xWJDM89s7PEji+2SZq/p+Vm/gSZqz0iXR9i8e95E0SE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k8eTrReb+GVfr8lTv7ZL31nlMfW3VZ77M7/wAcKveA5oin3ne8kb4VF7oCW+sxGU2
	 KF0LPPf3s5dG5n4lCaLVcxuaecJEPIUERJKOZb+1OSTA2xGYWEubHkbtwPThKVcy9q
	 cjcKRI5sVDxPlcKuCySoFWl4e8rf3IqLoa7Sm1xmqQ99ZD0VPRyWwBwbc6H+ilAXWH
	 vaDlqG9PFmt4gJRMw22EVT7pj2pYahuxR03B3LQOFN/4kz4IxHX51aewxUbGLMOjmM
	 qPgcJ4NRHmq9B1yr5IQFnQpCtosEzdmOXXykZ9Zg81cb3hRjx0kvKrxsVt/rrxIqLt
	 zr+XkZDwIroiw==
Date: Fri, 24 Nov 2023 17:45:50 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Matthew Wilcox <willy@infradead.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
	Alexey Klimov <klimov.linux@gmail.com>
Subject: Re: [PATCH 09/34] dmaengine: idxd: optimize perfmon_assign_event()
Message-ID: <ZWCT9sHhtTsx3u+t@matsya>
References: <20231118155105.25678-1-yury.norov@gmail.com>
 <20231118155105.25678-10-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231118155105.25678-10-yury.norov@gmail.com>

On 18-11-23, 07:50, Yury Norov wrote:
> The function searches used_mask for a set bit in a for-loop bit by bit.
> We can do it faster by using atomic find_and_set_bit().

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod

