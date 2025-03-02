Return-Path: <dmaengine+bounces-4629-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A87E4A4B405
	for <lists+dmaengine@lfdr.de>; Sun,  2 Mar 2025 19:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD12E7A82F7
	for <lists+dmaengine@lfdr.de>; Sun,  2 Mar 2025 18:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1BD1EB5D0;
	Sun,  2 Mar 2025 18:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNrN5Ptz"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E75A1D618E
	for <dmaengine@vger.kernel.org>; Sun,  2 Mar 2025 18:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740939535; cv=none; b=qGBa1v9lAfOIhdWf7emqJ+7pzDYApPK2bg0F4C91+oksoZDFEKfMMm00F8WdIYG6QC0TmbY9K0e7t/jekB2VfpelsRMZJt/hSfu8gpo93eUKqOsjUrRz4/KiPE/YEX0DoxxsgGoIZvyKcynnxCoa7ZcCtPtwUrss/QbkLXcu/eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740939535; c=relaxed/simple;
	bh=Iqd1EyVXc3E4TO9KOyEGebN3lggbQYAVfrVVVV98aWk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=CCCUcSSWCNUMpF74o3Z2W4kWN2soJFG5PZrDOwPmOvQWthEPFLbuunSGoAiRPOYzJSUDgvk2XBk9L7h2YrvVdKHJZUwcbnDm1vukyioWNAC5mDcte2tgeYe8X7Qm0HosrFQ4dH1RzulPmC9svwv1kztGItARfZzCCIIOrsnb6PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNrN5Ptz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A43A9C4CED6;
	Sun,  2 Mar 2025 18:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740939534;
	bh=Iqd1EyVXc3E4TO9KOyEGebN3lggbQYAVfrVVVV98aWk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GNrN5PtzrKkU1HvZbujth3QIU4Kfw68Mr+FaWEjcBiABG3Cz+qILdfS7m2TTtJpNo
	 Q08vC2TIih82DytepsCINopx4XYo28RX0OXiOB1tfRxqodcwlPYjqgtYiT033XXKIs
	 gxW12ELdelaS6WVi2Y3XLdiZva9M15MkxINo4SRdKTD7y4ThxyUssEHyoGXSbsCkzg
	 6/GdYK77L+ecKpmgHJRWyvr91QLbeg5A98LJ13vhr72rx3c9Wng6rGoGei7pjP7lEN
	 ERx5dmfiLedcNySRbj2xQm4pnK4We6VMTCT+zDcdMWQHdhHpEQKebEEZtbjf1swHt0
	 3EfT0bBH5B+Ag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71230380AACF;
	Sun,  2 Mar 2025 18:19:28 +0000 (UTC)
Subject: Re: [GIT PULL]: Dmaengine subsystem fixes for v6.14
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z8SVslyQKIe41xET@vaman>
References: <Z8SVslyQKIe41xET@vaman>
X-PR-Tracked-List-Id: <dmaengine.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z8SVslyQKIe41xET@vaman>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix-6.14
X-PR-Tracked-Commit-Id: e521f516716de7895acd1b5b7fac788214a390b9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b91872c56940950a6a0852e499d249c3091d4284
Message-Id: <174093956710.2675004.7591516541730378152.pr-tracker-bot@kernel.org>
Date: Sun, 02 Mar 2025 18:19:27 +0000
To: Vinod Koul <vkoul@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, dma <dmaengine@vger.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 2 Mar 2025 23:00:26 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix-6.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b91872c56940950a6a0852e499d249c3091d4284

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

