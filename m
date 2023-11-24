Return-Path: <dmaengine+bounces-222-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCC37F752A
	for <lists+dmaengine@lfdr.de>; Fri, 24 Nov 2023 14:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19BD2281845
	for <lists+dmaengine@lfdr.de>; Fri, 24 Nov 2023 13:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79C428DDB;
	Fri, 24 Nov 2023 13:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k83ufH4E"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B905028DDA
	for <dmaengine@vger.kernel.org>; Fri, 24 Nov 2023 13:32:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB5D7C433C7;
	Fri, 24 Nov 2023 13:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700832766;
	bh=o1nAJawZujV8ky8aBl2/Qzgffw+hVov2napCORg7MCE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=k83ufH4ExiieTHPouLNWbD5c/SIUNv0xaujtcNKGT0wyNCYDyoEI1P9x+F1Wzzlyg
	 QvC07Mu8cgBz9mQd7mm+4C+rqQTtrn9W5jSCJdJg9TzL2Lndq/PPxqi56jNqmw8McJ
	 h7I3Ghm/VXxaHu8p6n7+4goIHIeDbpKY3vq1Get4rcojihaafE/Fp89OwHxDFlCzKk
	 mSh9jpgFRPGVThkWl9rcxOWOwuo7sRc6kNX6EJwYt158BAuQqhBieKLSXCaUHQmeWk
	 EzxP95f4O/3dSkoGaUj0doRr4RPxvIZnDUMh6y2wSAlE+99CWOjtA+vM8GV8BIUnz+
	 F0cBHyJjV1cpQ==
From: Vinod Koul <vkoul@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Jai Luthra <j-luthra@ti.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ronald Wahl <rwahl@gmx.de>
In-Reply-To: <20231123-psil_fix-v1-1-6604d80819be@ti.com>
References: <20231123-psil_fix-v1-1-6604d80819be@ti.com>
Subject: Re: [PATCH] dmaengine: ti: k3-psil-am62a: Fix SPI PDMA data
Message-Id: <170083276437.771401.9856922958033463487.b4-ty@kernel.org>
Date: Fri, 24 Nov 2023 19:02:44 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Thu, 23 Nov 2023 14:57:31 +0530, Jai Luthra wrote:
> AM62Ax has 3 SPI channels where each channel has 4x TX and 4x RX
> threads. Also fix the thread numbers to match what the firmware expects
> according to the PSI-L device description.
> 
> 

Applied, thanks!

[1/1] dmaengine: ti: k3-psil-am62a: Fix SPI PDMA data
      commit: be37542afbfcd27b3bb99a135abf9b4736b96f75

Best regards,
-- 
~Vinod



