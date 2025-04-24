Return-Path: <dmaengine+bounces-5015-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFF7A9A07F
	for <lists+dmaengine@lfdr.de>; Thu, 24 Apr 2025 07:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D713442EF7
	for <lists+dmaengine@lfdr.de>; Thu, 24 Apr 2025 05:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DD219D07E;
	Thu, 24 Apr 2025 05:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u3lxihf5"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6292A8F5C
	for <dmaengine@vger.kernel.org>; Thu, 24 Apr 2025 05:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745472989; cv=none; b=VgR5CXkPewHLQUhOANg4ATIqhdZZ2jyZmB6ExMDr9bsr6wyNalsW+UPnNQp9r4xcwzxvqGGNJ3LGY1qbWmeoTUnk7K+uG1TSEAtHz4/ki/uCFgnYBtF+ZkyTYDGRoCWpx1shAIGWn9VqDQWTLzLxQDdi4t3GaoPz6dnB2IQOzRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745472989; c=relaxed/simple;
	bh=m1IsAD02OtDHZVDUivIzTovaxJhp2VvothJrfIdgoec=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YzhudigEB0lMUHCyCPTM2wKvkf4WYym550xuic7MJuSWjIc92goWdk49lUPMQ73pLOtqdSCYPB0KgdXqw4nCJbf6Sf1E42B9wXBfx5lQ9Nv4fUt65uhKRmQbh60fIKIYxC06Ofwco4ZwjCttWRc5BPy2FdQ6eM+l1y9/6N0A8K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u3lxihf5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F41C4CEE3;
	Thu, 24 Apr 2025 05:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745472988;
	bh=m1IsAD02OtDHZVDUivIzTovaxJhp2VvothJrfIdgoec=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=u3lxihf5ucF1Kn2rGX/xsD0EIfItfZVtdTt9v70WMqVC/b6YGWcfoKX1PmbHbkG9J
	 zFlGYxgi0zNxeThqbObMoFUbS7pZBiauKsM1SD7H3Olib6ff7rUG5BOml9tGfovmqY
	 AJ+e2mBpaOCz+s/Umv5bn+Y2oqLqS99okzADQJcaySW8088ugBfBT6QmhGaaU9DQXS
	 y3lsHcWKEXAg4zjMy5cY7LOFakPr9DHqXOjmh3mmA4WU8wOMQ6+bNXnufpED2ATgct
	 uzvOsFNgv+DUTC5RtOt5yR/C9HgZjxOYcnJMgb5rMxVrmsuVn7SsRNPRto9sGq9+G1
	 wCxiORNTalnOQ==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>
Cc: vinicius.gomes@intel.com, arjan@linux.intel.com, nathan.lynch@amd.com
In-Reply-To: <20250421170337.3008875-1-dave.jiang@intel.com>
References: <20250421170337.3008875-1-dave.jiang@intel.com>
Subject: Re: [PATCH v2] dmaengine: idxd: Fix allowing write() from
 different address spaces
Message-Id: <174547298664.315671.10538699041361455695.b4-ty@kernel.org>
Date: Thu, 24 Apr 2025 11:06:26 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 21 Apr 2025 10:03:37 -0700, Dave Jiang wrote:
> Check if the process submitting the descriptor belongs to the same
> address space as the one that opened the file, reject otherwise.
> 
> 

Applied, thanks!

[1/1] dmaengine: idxd: Fix allowing write() from different address spaces
      commit: 8dfa57aabff625bf445548257f7711ef294cd30e

Best regards,
-- 
~Vinod



