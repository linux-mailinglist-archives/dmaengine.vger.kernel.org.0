Return-Path: <dmaengine+bounces-3405-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A12079A9895
	for <lists+dmaengine@lfdr.de>; Tue, 22 Oct 2024 07:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 618E9281F50
	for <lists+dmaengine@lfdr.de>; Tue, 22 Oct 2024 05:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137A0142E76;
	Tue, 22 Oct 2024 05:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLUM1Y+H"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D279E13B59E;
	Tue, 22 Oct 2024 05:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729575195; cv=none; b=N+HcRxKgRUG/Y2nSti94S56uO6Xr3UGoTm3xYN5wzWrz+TDqNiWVjZg+zu+kprjYxbhSf2LrdCkGUeT43nDo4X/PG0gLXChNqHNUe88lao+aJ0f9JWe7fkhw3f2dDVYQUQcBFzlKdzNasPCRUwV3ML/NUs7JZRx4wGwagnu6UPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729575195; c=relaxed/simple;
	bh=j4WAdEaL6eBPQZU9yUngRZzKGUSRNnxFRBmfn8V7nrY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fEV7lQlixqfVwyaFR//vORn/TALZyNAg4XfyRlljiaZfmVYat0GS2g/epVszNWBP78MDey3yV/cCYDg0nuPChOyx4CM7y4LQVkctod8ePwx6JXJche7C0zMqxZUz0YVmEcuU0qE0ofMutjxqWi8Av5de36fZVJOLynMhlD99J90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLUM1Y+H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5AE1C4CEC3;
	Tue, 22 Oct 2024 05:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729575194;
	bh=j4WAdEaL6eBPQZU9yUngRZzKGUSRNnxFRBmfn8V7nrY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=KLUM1Y+HGZ1ISWpH2GGmd+P0NwR24PKGhS38Z4ZIgXSBAxJBsV22oIRIVj3FN3Q4o
	 kmz0dC4PNwHQ6GtKtEy4ngzaawDfvdslegGBAcU2zlOYZxEwkMjzgYVBBqsoy8DHY1
	 UdYbt977nXTLbiiiNIJLZMIrNbWVQg8oZGgBQWwYuwDglSAXoZaX8LNlKmvxzVjD5j
	 rJhEkrIMriStUWE80qbSNemt40LgDs6yb9I5PP5vEL3eJRbY3VvTBuCAmLp9P5G3J4
	 0rT7XUfITlpKXOGUeRmdMxKUcPn064B6WQzwO37sUr2ucaZxlCdUpty/SHW7T5XIsi
	 xqIN74A03avIA==
From: Vinod Koul <vkoul@kernel.org>
To: Conor Dooley <conor@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Paul Elder <paul.elder@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Jim Quinlan <jim2101024@gmail.com>, 
 Nicolas Saenz Julienne <nsaenz@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Andy Gross <agross@kernel.org>, 
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
 Jim Quinlan <james.quinlan@broadcom.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org
In-Reply-To: <20240925232409.2208515-1-robh@kernel.org>
References: <20240925232409.2208515-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: Fix array property constraints
Message-Id: <172957518656.489113.4975806367588166309.b4-ty@kernel.org>
Date: Tue, 22 Oct 2024 11:03:06 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 25 Sep 2024 18:24:06 -0500, Rob Herring (Arm) wrote:
> Schemas for array properties should only have 1 level of array
> constraints (e.g. items, maxItems, minItems). Sometimes the old
> encoding of all properties into a matrix leaked into the schema, and
> didn't matter for validation. Now the inner constraints are just
> silently ignored as json-schema array keywords are ignored on scalar
> values.
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: Fix array property constraints
      commit: 72c65390c61fc96cebfb91c300ca774925565383

Best regards,
-- 
~Vinod



