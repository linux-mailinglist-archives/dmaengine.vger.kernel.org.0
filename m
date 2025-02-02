Return-Path: <dmaengine+bounces-4246-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB50BA24C63
	for <lists+dmaengine@lfdr.de>; Sun,  2 Feb 2025 02:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 829201884F0D
	for <lists+dmaengine@lfdr.de>; Sun,  2 Feb 2025 01:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9679B8C07;
	Sun,  2 Feb 2025 01:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KirhkOVr"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA8E4C91;
	Sun,  2 Feb 2025 01:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738458883; cv=none; b=kkE1ZGFTO43FHet8TzPMlXOSG92Q6RY3XAkVfp5+yHRhwrJnX13C1fGkQJFMYIl+D/1W2sK4OYcXElhwMRlMzVzcCmoX7/xT8bIuVnM8mjedmT41qcbkBOZpAYc4ss8oP9TE1GK7LzGVjegmhBei3b21TVqWAlnpTte1QNa5lpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738458883; c=relaxed/simple;
	bh=npX90+DiMFvMCTdtgmlUJPmHOKmJN19J0iy4bpHnpVY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GlTvc9ojD8mEfjPgBbfTfux86QdnOQGHODHA6sbeN+fsFlMhPNSdqRWhqMqnQiWh5/rFLqHg1gdh+hgzMiQBx0YFzZPI/Q1GQDHlktftY4fqy55lx9mC6kTzAv7MZ1rXyBicZrg6FxF2Es6wn6VR1w5CwygkKsWeWPcY5YpsDbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KirhkOVr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 697B2C4CED3;
	Sun,  2 Feb 2025 01:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738458882;
	bh=npX90+DiMFvMCTdtgmlUJPmHOKmJN19J0iy4bpHnpVY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KirhkOVrNzpSq3yTbOlpSaCm9/puC/RQmJarziVj5EEgiPGqh999juWMIpBFgyUFu
	 A4rbopY7RYybK0vP4lyHjgOtUpyR0zOTAnbR6eoP4PecG0u0uiKmVgUkmvn7ax2AOc
	 I1RjiXDTbhgiRFXlsGEmQVMpxoIX6zEJCIYf0sIVgtIlXRniAytLf+MWdctMGTPf1w
	 4udhRIqbdPFmneP3Mf3xh4rEN/YhA2Ktpr5azr/6CLZlntEuoN2kLzxmVo0vUk4Y2D
	 AW6h6ByCJet9+gPhMDTezksZ6NGAzInQ7RY5Sy08+EsGzj/s4/Tuj4zqHhlhJdZNA+
	 5A7IDtzPvMwUg==
Date: Sat, 1 Feb 2025 17:14:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: <vkoul@kernel.org>
Cc: Mohan Kumar D <mkumard@nvidia.com>, <thierry.reding@gmail.com>,
 <jonathanh@nvidia.com>, <dmaengine@vger.kernel.org>,
 <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH v3 0/2] Tegra ADMA fixes
Message-ID: <20250201171441.407b91cb@kernel.org>
In-Reply-To: <20250116162033.3922252-1-mkumard@nvidia.com>
References: <20250116162033.3922252-1-mkumard@nvidia.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Jan 2025 21:50:31 +0530 Mohan Kumar D wrote:
> - Fix build error due to 64-by-32 division
> - Additional check for adma max page

Hi!

What's happening with this series? The buggy commit reached Linus's
tree and broke 32b builds for everybody. The patches look 2 weeks old.

