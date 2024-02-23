Return-Path: <dmaengine+bounces-1093-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B90AD86111D
	for <lists+dmaengine@lfdr.de>; Fri, 23 Feb 2024 13:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB0291C21ECC
	for <lists+dmaengine@lfdr.de>; Fri, 23 Feb 2024 12:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5D37EF08;
	Fri, 23 Feb 2024 12:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="md57iLce"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B3F7EF04;
	Fri, 23 Feb 2024 12:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708690128; cv=none; b=pBzYD7Z0M0iFprNAxixpR51uc0IdGCcwmgIMTpyMOBRPMegMCM355ZYJR+2U2uXX6JhdyRDPxI/A5ktrMqnVFKP03UYlBNSUD4GRRi/jWWYMpcK1kEkicDbwE1z9xiCArJcTGfAgWn5r0h5sWhwZ6HdoxU5JuBPBY/flwjU7I8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708690128; c=relaxed/simple;
	bh=brMBFJdqaXTqNevt1dZjoF9uhkb2qfz03xtNUIodsws=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DwTsqqPwlWg3xQWi/qozmiJYv+7Vt5PGAuH6fvmFBF0ipfU9tNDN7GP6dpsv8arlMgWqnq3ItWjSPApp0hX0IauP3DSND1+tQBw/uF7SONMiqmw+qlkYrcB7MqC8hfXz1tsZodS6n6pNIiuWkyT7aBpoBPUb2aukLwaEynMGuWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=md57iLce; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F259EC433F1;
	Fri, 23 Feb 2024 12:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708690128;
	bh=brMBFJdqaXTqNevt1dZjoF9uhkb2qfz03xtNUIodsws=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=md57iLceuuThS5NkQLrd5LDcHelo+pzyQh1mSnQK07XSeQJn7kPdwT9P5uLW5vPmu
	 YzxNu8cktM47jO7nhki26evnbwF5o9MZpM/yJkKtnAGvzDws880I/kVOI/Mae+5Dzz
	 UavjkdLnNhCLFRwzIhFzrVoKP2RyU2YYBE+mk71zRx1t4TN+ST85FDEdfE0lmd0x4V
	 MNwSk8fFCkxL9nR4qxQP+sRgwt/bvTjkEX59oYwv1EjKVcEe2TO0l1WQ/4OpTrsjS/
	 m3OCztVLjM7F5Geyf1UinS9ifYlloC6lWRQ/Rthj2tP5jgbff2GV2jys8pMIXOfRRb
	 Fi/Re6VlipJ7g==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240208202742.631307-1-krzysztof.kozlowski@linaro.org>
References: <20240208202742.631307-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/2] dmaengine: pl08x: constify pointer to char in
 filter function
Message-Id: <170869012662.529520.5189500367473761398.b4-ty@kernel.org>
Date: Fri, 23 Feb 2024 17:38:46 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Thu, 08 Feb 2024 21:27:41 +0100, Krzysztof Kozlowski wrote:
> The opaque argument chan_id passed to filter function is actually
> pointer to const memory, so make that obvious in the filter for code
> readability and safety.
> 
> 

Applied, thanks!

[1/2] dmaengine: pl08x: constify pointer to char in filter function
      commit: 16374aba824971d73916f005e79207370c9c31dd
[2/2] dmaengine: of: constify of_phandle_args in of_dma_find_controller()
      commit: 716141d366f45d62ffe4dd53a045867b26e29d19

Best regards,
-- 
~Vinod



