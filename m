Return-Path: <dmaengine+bounces-3024-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FED964CC5
	for <lists+dmaengine@lfdr.de>; Thu, 29 Aug 2024 19:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F6F228439B
	for <lists+dmaengine@lfdr.de>; Thu, 29 Aug 2024 17:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429381B78FD;
	Thu, 29 Aug 2024 17:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBoyDkVp"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191A51B78F4;
	Thu, 29 Aug 2024 17:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724952629; cv=none; b=nPkNPmDhslNz92StoKcXR11A+6QPmalXmuGr4VIN2hAWPV+/7ZWOZ6HMA7AwMiZfRonVK6Cx1JaQrJom40DwKH+jG5SMTPua+VYQYWEp3KI3dR9jPvpTckjKgBQqldsso4ed2uRgP1wXU1ic6M+APWpdjvEpxQv239xaFsceb4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724952629; c=relaxed/simple;
	bh=AqT2kmXddqAikPJ94Wcnoy+RKKWAgjusgq49hjoYPkA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DHuaPfxOPs4vsT4xOkqdIGfYVGLoTrBI74pERw8jYh3w9UeBVilwaddcaQ4Dmi1q6t6gMfl0XsTIkgBanBEXoKHS6i6iSvWmcODTRyPoLYsR5RboY8YBLt7Q03IjTevJ9AzaZwJDPHuY1PgPWOKRDN4/zKqSv82rFBWiBybzJmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBoyDkVp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA723C4CEC7;
	Thu, 29 Aug 2024 17:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724952628;
	bh=AqT2kmXddqAikPJ94Wcnoy+RKKWAgjusgq49hjoYPkA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=oBoyDkVpp/Lqn58nQKBdHegtbaRvWhR67jdFKOabDq+vZMhBi583trgdtHMVX8Z8J
	 azc+NHDawx7aPowkVt4vkeu37eKyM004Z98UunS3nOJI97U2/xMCzhkK1820XiPigH
	 b8dhe3Mum0VhJghO7vyAuJQxnIsm6ibf09BJb5rrivBlEG1Krb8eTlgi82F3fB+jrc
	 s+8v/R0qm+vifSmsXwf738Ve12BOzWKNv6lwcHWnyGeh26lWJJI1wLpH7hgwcwUGYH
	 OPKCZLrUPgM2pWXO85VP7S2PDR0p2WdVQPWM3mh53NPf1pt5kzxMeVEAQcIHToOKGQ
	 l18dAlHMs53ew==
From: Vinod Koul <vkoul@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20240828233401.186007-1-fenghua.yu@intel.com>
References: <20240828233401.186007-1-fenghua.yu@intel.com>
Subject: Re: [PATCH v2 0/2] Add a few new DSA/IAA device IDs
Message-Id: <172495262740.385951.12976673891304151813.b4-ty@kernel.org>
Date: Thu, 29 Aug 2024 23:00:27 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 28 Aug 2024 16:33:59 -0700, Fenghua Yu wrote:
> Due to a potential security issue, it's not safe to assign legacy
> DSA/IAA devices to virtual machines. This issue has been addressed
> by adding the legacy DSA/IAA device IDs to the VFIO denylist[1].
> 
> With the security issue fixed in newer DSA/IAA devices, which have
> new device IDs, these devices can be safely assigned to virtual
> machines without needing to add their IDs to the VFIOI denylist.
> Additionally, the new device IDs may be useful to identify any other
> potential issues with specific device as well in the future.
> 
> [...]

Applied, thanks!

[1/2] dmaengine: idxd: Add a new DSA device ID for Granite Rapids-D platform
      commit: f91f2a9879cc77db1f45f690f38f42698580416e
[2/2] dmaengine: idxd: Add new DSA and IAA device IDs for Diamond Rapids platform
      commit: 4fecf944c051ea852e98c062636bf5b4c7f5f8a7

Best regards,
-- 
~Vinod



