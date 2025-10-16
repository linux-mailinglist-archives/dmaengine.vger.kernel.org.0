Return-Path: <dmaengine+bounces-6869-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 065B2BE4182
	for <lists+dmaengine@lfdr.de>; Thu, 16 Oct 2025 17:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EB215E20A9
	for <lists+dmaengine@lfdr.de>; Thu, 16 Oct 2025 15:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578953451C6;
	Thu, 16 Oct 2025 15:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sSi+0lPp"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3021E3451BF;
	Thu, 16 Oct 2025 15:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760626937; cv=none; b=U5l2/ntpCeqSOxhatk5nsh8tQKUYXQzpTuQ5MPIb0ym5moJUYlIPiFqq9Mf4o8Sys3TnP9wzIsHhoklRa0gSFJGQTbGfMAiuW18JjaFGojV0Gjj49NlBM97OEW7f4OrKpkNp7eY1QQm0RkwsUvG31G3FdgyPuSNZs6kr6j7J1yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760626937; c=relaxed/simple;
	bh=u43BAiGgobFarWaWcO9Ov0kcc7bdAUReXwSLUODL7eE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Oeyr5HMlyYBRmXUTWLTkhWqAAJy89pYTgO5v2t5cnsaIF14Rn4SxOv38bBqroOlVwMHNUYIEY67bqKakmnc3qikNwLFw+I7+bm9JY9w8XBrivLaiPAsnhUX5e0BxKKVjTHDdXNpzUfcweMPuSenJtke97Ja0fJfb66JBEOgYGJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sSi+0lPp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98C0EC4CEF1;
	Thu, 16 Oct 2025 15:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760626936;
	bh=u43BAiGgobFarWaWcO9Ov0kcc7bdAUReXwSLUODL7eE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=sSi+0lPpzskT3QKU7km1Pd32O18j+ZJ1mtgtX6kSlGBl2VEcYbQd/h4K5wvZX8z5w
	 2WDzvHArUjqkRffMLoFj6PShUawqZCniFZu0G9GS6cA6cJ6GWVdNIm6gEgARfex5dZ
	 3wwAtWGpcjvRMGWf8Zk1DArjC5jgV38v6MN1IUcP28uxG1Obxppkzoq0fksLmWYpf9
	 vPgV3/Et1XK2qQE4MCqlcRjkcK4y6zzmc0wFZ78szDOROXqHzXVMFEMBZXzPFYJUYO
	 wA6KDOqYbzdH2aQ/fAcHjEC4VAW7KZ+HEkpE1p36si+A1uV00lm5BdPoKSwwVZ1hWz
	 lMr6RbWiuikXQ==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: dave.jiang@intel.com, linux-kernel@vger.kernel.org
In-Reply-To: <20251001012226.1664994-1-vinicius.gomes@intel.com>
References: <20251001012226.1664994-1-vinicius.gomes@intel.com>
Subject: Re: [PATCH v1] dmaengine: idxd: drain ATS translations when
 disabling WQ
Message-Id: <176062693527.525215.1212282983221053178.b4-ty@kernel.org>
Date: Thu, 16 Oct 2025 20:32:15 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 30 Sep 2025 18:22:26 -0700, Vinicius Costa Gomes wrote:
> There's an errata[1], for the Disable WQ command that it
> does not guaranteee that address translations are drained. If WQ
> configuration is updated, pending address translations can use an
> updated WQ configuration, resulting an invalid translation response
> that is cached in the device translation cache.
> 
> Replace the Disable WQ command with a Drain WQ command followed by a
> Reset WQ command, this guarantees that all ATS translations are
> drained from the device before changing WQ configuration.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: idxd: drain ATS translations when disabling WQ
      commit: f80ea8566917c4bb680911db839a170873e5d17c

Best regards,
-- 
~Vinod



