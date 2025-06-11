Return-Path: <dmaengine+bounces-5382-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCDEAD5BD6
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 18:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 184B83A1670
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 16:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8ACA74059;
	Wed, 11 Jun 2025 16:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8ivT56d"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D52190497
	for <dmaengine@vger.kernel.org>; Wed, 11 Jun 2025 16:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749658613; cv=none; b=cYyUs8Onh6gUU8XMGLlBDKvxrRgGwkEzd2EgCIJ80um0eN5XI9N2Pyjnyc4NssHZF9Ky2CnrjoWMDWokMa69uXxD6oN/V09yeAqQSCBAvCp6CMLJ7Sk5FfQ6cT2B5AKL4xmhWDHd2rfa1k0uC+USOx2jBQyj5EnZzgwIzBacdrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749658613; c=relaxed/simple;
	bh=WFtUBJqlAhF8dGqTN2nXC1pQiRHrSopQJ1PTtE6d/n0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=B3fDHH6nSeZjQi8kek+7ZTFkUmoYzTnTmAx8CEu4o2PS7RapcrNZpQQFlElCa5PEA6uw9Z/KlBb2RIPvl79wmAtsnM24NIzXi/xM0N/QKLRjSiPTpBhtJmjajS9YY1ZFhSBSKMGPhJ1UlgvC1FCtxUDuhv7ovJgbRfz4duhbxNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8ivT56d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D840C4CEE3;
	Wed, 11 Jun 2025 16:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749658613;
	bh=WFtUBJqlAhF8dGqTN2nXC1pQiRHrSopQJ1PTtE6d/n0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=A8ivT56dUw/1mkYBmqAYXT8Jl30TxyVUkSC8armZBguZ9DfHaujbV0Qfsoliq0wJP
	 EUcVUnFqO8NG9SUSKL7rQehqax+9nl1Ihmuo5gJp/TdABLNgFaVlZJvllKE9bHyfW0
	 AC1R3qmUoDZMNJN+mLLoJT2x8zxuZbmhjJiszw0PX3pox/Utthj6vqFXH8Egye3eVF
	 7+HRg4JUkBEGcYY/wlFP/KXZ19iX+cA9GXY6S8TAp7HzmCzLfJSC2Esy/wgtCcJ8yl
	 U9qwAKOVo+/SqtWr6NDPHk2tSXOj/e7bFnK0lhllaS2bYiKcaNPpKNbmOSG3feJdQi
	 MLMhqKBaNlpBA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EC1C71136;
	Wed, 11 Jun 2025 16:16:53 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH RESEND 0/4] dma: dma-axi-dmac: fixes and improvements
Date: Wed, 11 Jun 2025 17:16:54 +0100
Message-Id: <20250611-dev-axi-dmac-fixes-v1-0-d30af52a2af5@analog.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: dmaengine@vger.kernel.org
Cc: Paul Cercueil <paul@crapouillou.net>, 
 Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749658620; l=827;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=WFtUBJqlAhF8dGqTN2nXC1pQiRHrSopQJ1PTtE6d/n0=;
 b=pQMoPDapELFwXwnQL4cpqIg2ISYyebkeiUbi996HX5NsnVzWddSBOg8RGcrzrEHPwna5+v2hO
 EWxCoU1aaYmCdY68fF6nWWi3hj8i2jud0RdhxuOJ2SJOJyIb88yz4sG
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

This series adds some fixes to the DMA core with respect with cyclic
transfer and HW scatter gather.

It also adds some improvements. Most notably for allowing bigger that
32bits DMA masks so we do not have to rely on bounce buffers from
swiotlb.

---
Nuno Sá (4):
      dma: dma-axi-dmac: fix SW cyclic transfers
      dma: dma-axi-dmac: fix HW scatter-gather not looking at the queue
      dma: dma-axi-dmac: support bigger than 32bits addresses
      dma: dma-axi-dmac: simplify axi_dmac_parse_dt()

 drivers/dma/dma-axi-dmac.c | 48 +++++++++++++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 15 deletions(-)
---
base-commit: 3c018bf5a0ee3abe8d579d6a0dda616c3858d7b2
change-id: 20250520-dev-axi-dmac-fixes-41502e41d982
--

Thanks!
- Nuno Sá
-- 
Nuno Sá <nuno.sa@analog.com>



