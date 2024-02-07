Return-Path: <dmaengine+bounces-972-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E8E84C6A2
	for <lists+dmaengine@lfdr.de>; Wed,  7 Feb 2024 09:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 004891F293C3
	for <lists+dmaengine@lfdr.de>; Wed,  7 Feb 2024 08:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C347208B4;
	Wed,  7 Feb 2024 08:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p49uIPzl"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617F6241E2;
	Wed,  7 Feb 2024 08:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707295774; cv=none; b=JBxwlwvMQMkhhpVeYQ2Co4MV+IcdZxe82cr3e1jBKxLn3KSZacdvILaSlA/cNi7prCmaWXPKiPsmL+trvLfdga0hES4ylKzxhbF4MFI3Nyj34Jf8GDhjWvSILrfRmTIoJQ6QZS8cdZHiolrTVGHBEZHTbdXWAwuyYP06CF7rkPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707295774; c=relaxed/simple;
	bh=BYMa+c4SuvG+ZdZ4RzetzFCZxzoCsjh1usJq/fFXOBw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=E06/ly1s5syWPAdd4E7wel5fCXZlfenIYE1qyUYBbqSaC7MBC+Tm3gyAmwYicmE917VmRDa+ualHP0Rrd55dn6PJTWa0FVfvIo2x1filRkxGMPfZtPk/Jma2CG1x4aeqIC/wYXeurVqUiw7Ggsi79OYYAZ2Fncs0bl7qi2sg1PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p49uIPzl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA42C433F1;
	Wed,  7 Feb 2024 08:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707295773;
	bh=BYMa+c4SuvG+ZdZ4RzetzFCZxzoCsjh1usJq/fFXOBw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=p49uIPzl1ZUi8xvzqAlvca3RRqfXXMZ5KQgBE7OqyDNXJX0yrUblATDWdIriomE4y
	 /zuYyDxShttAUURpkg4bkZnBaXjWNtRxpaWfLspO0hTDnqFg1hDv1QatPTZa+x/o0+
	 L5i+/netr7Po77LVrizxM6UVv7BW2xhtG2/5k73RI101bl3CG9vh5zOJlRcyzg5vy9
	 qPoC9r82suDqKTPeXqSCkHBVEpDRiZhd+cgRck55EBrqI4WEJ5xL6TshFLobk5nt4N
	 BLfaIFEt6fTe3SCJIRU6RlS8S5jEsk9U1PuGeKRbJIItCYtBTMcO/cDxOcbJra9IbO
	 RWjbB7taUOJpA==
From: Vinod Koul <vkoul@kernel.org>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20240131-pxa-dma-yaml-v2-0-9611d0af0edc@skole.hr>
References: <20240131-pxa-dma-yaml-v2-0-9611d0af0edc@skole.hr>
Subject: Re: (subset) [PATCH v2 0/2] dt-bindings: mmp-dma: YAML conversion
Message-Id: <170729577170.88801.16549328232366263331.b4-ty@kernel.org>
Date: Wed, 07 Feb 2024 09:49:31 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3


On Wed, 31 Jan 2024 22:26:01 +0100, Duje Mihanović wrote:
> Convert the mmp-dma binding to YAML and drop a useless property in
> MMP2's ADMA node.
> 
> 

Applied, thanks!

[2/2] dt-bindings: mmp-dma: convert to YAML
      commit: d2363272ef9f96709ec1a146bb66378256c92e1d

Best regards,
-- 
~Vinod



