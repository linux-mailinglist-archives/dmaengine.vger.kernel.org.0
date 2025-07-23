Return-Path: <dmaengine+bounces-5853-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82934B0F243
	for <lists+dmaengine@lfdr.de>; Wed, 23 Jul 2025 14:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EF551C216B7
	for <lists+dmaengine@lfdr.de>; Wed, 23 Jul 2025 12:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8D02E7179;
	Wed, 23 Jul 2025 12:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ukMeZZhO"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4478E2E6105;
	Wed, 23 Jul 2025 12:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753273777; cv=none; b=AP53GrplakODxX+3BO/OH2iHalJ3BNRZGHBvaMdo97yW+MBKdVf/w2Y2f/vFxs0Hg82P2uy6B8aQsyThDQlRnItaY3aVW/yNn64K0XNJs+V9sqGfpeeyiVTJhhNJmBHQmMnM3pfET81p812haTcFEhand82KklNHrVyyxUhTPWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753273777; c=relaxed/simple;
	bh=joXm74Ca7DzN8Wx5qJnsq91fuGSp6G2qAZ2RcFuh9h4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eGt8ecc/BmS9v4rlC7xeRJ0Xr7lvbQm7AX1HvwLXXcACXb4+9GzISIB5RyeYMv9eiiky3mENVcgj3WpCCzlGqr7c8XEcZPErxyiNV1HDwOP38zxqeAOCVESLvw0ZfcB4Msz21CtH+ufpijS+EbnhPHcXTGAJfPLAcqx7FcWWoSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ukMeZZhO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766E7C4CEE7;
	Wed, 23 Jul 2025 12:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753273774;
	bh=joXm74Ca7DzN8Wx5qJnsq91fuGSp6G2qAZ2RcFuh9h4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ukMeZZhOUTWSSt7ndjadJYKkjwC0weo++XHvseo6gC65n0QbAbLd1dzcEm3m7IHJi
	 E89EzYvV0PXcRIwtIIhGjCc0JMWy/2PsO+5UZT2JHptdqUVUc3k9s/gmQhFjx45qMz
	 xoifP63idp66SiehMRpl1R1tJAa1bCI+lZCLW/V1RC735Dt2Gpb3/KxtqFxC+ey7sp
	 GgmvcFk8FBEkTPKClnD2VYwnvZTXL6hJ1rKT/5ZT1H7k1VHApsgr67Zy9bq/ccyVlp
	 TAywBL5T9eGl/IPiVJFWFC2QbO686v+UDs69ZQLGdjxdjBhvianWP+GOYYtJYK6qNo
	 8y00NpWtnP1Ew==
From: Vinod Koul <vkoul@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250703155912.1713518-1-robh@kernel.org>
References: <20250703155912.1713518-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: dma: Convert marvell,orion-xor to DT
 schema
Message-Id: <175327377209.189941.8397130016323536629.b4-ty@kernel.org>
Date: Wed, 23 Jul 2025 17:59:32 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 03 Jul 2025 10:59:10 -0500, Rob Herring (Arm) wrote:
> Convert the Marvell Orion XOR engine binding to schema.
> 
> The "clocks" property is optional for some platforms (though not
> distinguished by compatble). The child node names used are 'channel' or
> 'xor'.
> 
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: dma: Convert marvell,orion-xor to DT schema
      commit: 245dd180ac861fea31abe69c722061a3c2c65a66

Best regards,
-- 
~Vinod



