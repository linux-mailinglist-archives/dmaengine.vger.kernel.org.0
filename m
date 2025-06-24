Return-Path: <dmaengine+bounces-5609-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FB3AE58C2
	for <lists+dmaengine@lfdr.de>; Tue, 24 Jun 2025 02:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA42A7B23DF
	for <lists+dmaengine@lfdr.de>; Tue, 24 Jun 2025 00:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC30A19F43A;
	Tue, 24 Jun 2025 00:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YEjEDERS"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AA86F53E;
	Tue, 24 Jun 2025 00:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750725664; cv=none; b=gu3PGV0O5HCdTiYT12zCWt0c03UvbWi2DyueCIiQ+iH12Od4qr9l/gV9clzEllvUwgyXhnBVfwfIpKuhubZFEdcF+txXHRn/mmerTUH1TtLc/S9FbMvMa5k7wRAuwWo5MJ1BcWoQarWpcEIriPDqtFcCA78OeTfDYLoJzGyR6nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750725664; c=relaxed/simple;
	bh=X+WEAFWSFmlXFVU8QqjI58s4tQN09QAH7zqKLoWNiXo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jNf5b1J1R97GOPruihU+hNi6dl0n05XyNTlE3Blgtan5s1NLv1d6QlYGrcK4NnIbz5GjhhSxMhIg0dOJLa7KwDDiGxoEW1SoIcsGmpJkXDpuomPoIhkSA0jNX1GgrRihk4KN1Ji7qUQUm7c5yzXOpg8h7RrpLwfe2C6HbSJArAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YEjEDERS; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750725663; x=1782261663;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=X+WEAFWSFmlXFVU8QqjI58s4tQN09QAH7zqKLoWNiXo=;
  b=YEjEDERS0Ln92RbpAB+xC2e1heUR8gORphaVRhX/+o/hpujXPe2bsqfY
   TgEqCn7YRHNUn+YCSj28bk/F6Y1EkREXUoUTKlpqYT66kwk92wBRv7acb
   zKM9jbcRLKK/XIGwVtMqy6wQTh6VCh4iQDAqU0xkW97U/xYbSqROjkc6H
   +Owi8hmZ9yw3fPWQGnHmYkx9kfjNAb0SoY6OJu9D7Kve3yjEM/Wd18rJP
   VK6S3UsyxAZIIQxjKdjKWggp6zt5phdgj1IlxpUaCrUO3MzLdcgI3t7uI
   bwmShMHxBOwCY4s31qCvL8DPcIeqZK/0g1KfNewOQdnwafB2u6KW8XWQB
   Q==;
X-CSE-ConnectionGUID: SNp94FYeT56Rr6P/nbyx4w==
X-CSE-MsgGUID: F39WIoF5RjeVTQKo5GAQJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="52069268"
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="52069268"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 17:41:03 -0700
X-CSE-ConnectionGUID: 51vnbPoNQPa7r0xuv27B4g==
X-CSE-MsgGUID: 4uISFow6Sm2JmKr4oEFvNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="157536560"
Received: from unknown (HELO vcostago-mobl3) ([10.241.226.49])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 17:41:02 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Yi Sun <yi.sun@intel.com>, dave.jiang@intel.com,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 fenghuay@nvidia.com, philip.lantz@intel.com
Cc: yi.sun@intel.com, gordon.jin@intel.com, anil.s.keshavamurthy@intel.com
Subject: Re: [PATCH v2 2/2] dmaengine: idxd: Add Max SGL Size Support for
 DSA3.0
In-Reply-To: <20250620130953.1943703-3-yi.sun@intel.com>
References: <20250620130953.1943703-1-yi.sun@intel.com>
 <20250620130953.1943703-3-yi.sun@intel.com>
Date: Mon, 23 Jun 2025 17:41:01 -0700
Message-ID: <87o6ue6kf6.fsf@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yi Sun <yi.sun@intel.com> writes:

> Certain DSA 3.0 opcodes, such as Gather copy and Gather reduce, require max
> SGL configured for workqueues prior to supporting these opcodes.
>
> Configure the maximum scatter-gather list (SGL) size for workqueues during
> setup on the supported HW. Application can then properly handle the SGL
> size without explicitly setting it.
>
> Signed-off-by: Yi Sun <yi.sun@intel.com>
> Co-developed-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
> Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>


Cheers,
-- 
Vinicius

